xmlport 50085 "Import Payment Entry List"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;
    FieldSeparator = ',';
    // FieldDelimiter = '"';

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                textelement(EnrollmentNo)
                { }
                textelement(Term)
                { }
                textelement(Academicyear)
                { }
                trigger OnBeforeInsertRecord()
                var
                    CustomerLedEnt: Record "Cust. Ledger Entry";
                    ReturnPaymentEntry: Record "SLcM Reversal Entry";
                    ErrorMsg: Label 'Enrollment No or Term or Academic year must have value';
                begin
                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end Else begin
                        if (EnrollmentNo = '') or (Term = '') or (Academicyear = '') then
                            Error(ErrorMsg);
                        CustomerLedEnt.Reset();
                        CustomerLedEnt.SetRange("Enrollment No.", EnrollmentNo);
                        CustomerLedEnt.SetRange(Reversed, false);
                        CustomerLedEnt.SetRange(Open, true);
                        if term = 'Fall' then
                            CustomerLedEnt.SetRange(Term, CustomerLedEnt.Term::FALL);
                        if term = 'Spring' then
                            CustomerLedEnt.SetRange(Term, CustomerLedEnt.Term::SPRING);
                        if term = 'Summer' then
                            CustomerLedEnt.SetRange(Term, CustomerLedEnt.Term::SUMMER);
                        CustomerLedEnt.SetRange("Academic Year", Academicyear);
                        if CustomerLedEnt.FindSet() then begin
                            repeat
                                CheckPaymentDocNo();
                                InsertIntoReturnPaymentEntryList(ReturnPaymentEntry, CustomerLedEnt);
                            until CustomerLedEnt.Next() = 0;
                        end;
                    end;
                    currXMLport.Skip();
                end;
            }
        }
    }
    trigger OnPreXmlPort()
    begin
        SkipFirstLine := True;
    end;

    trigger OnPostXmlPort()
    begin
        Message(SuccessMsg);
    end;

    var
        SkipFirstLine: boolean;
        SuccessMsg: Label 'Imported Successfully.';

    procedure CheckPaymentDocNo()
    var
        ReturnPaymentEntry: Record "SLcM Reversal Entry";
        ReturnPaymentEntry2: Record "SLcM Reversal Entry";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
    begin
        if ReturnPaymentEntry."Payment Document No." <> ReturnPaymentEntry2."Payment Document No." then begin
            ReturnPaymentEntry."Original Amount" := 0;
            ReturnPaymentEntry."Remaning Amount" := 0;
            ReturnPaymentEntry."Reverse Applicable" := false;
            CustomerLedgerEntry.reset();
            CustomerLedgerEntry.Setrange("Customer No.", ReturnPaymentEntry."Student No.");
            CustomerLedgerEntry.Setrange("Document No.", ReturnPaymentEntry."Payment Document No.");
            if CustomerLedgerEntry.FindFirst() then begin
                CustomerLedgerEntry.CalcFields("Original Amount", "Remaining Amount");
                ReturnPaymentEntry."Original Amount" := CustomerLedgerEntry."Original Amount";
                ReturnPaymentEntry."Remaning Amount" := CustomerLedgerEntry."Remaining Amount";
                if ReturnPaymentEntry."Original Amount" = ReturnPaymentEntry."Remaning Amount" then
                    if ReturnPaymentEntry."Original Amount" <> 0 then
                        ReturnPaymentEntry."Reverse Applicable" := true;
            end;
        end;
        // InsertIntoReturnPaymentEntryList(ReturnPaymentEntry, CustomerLedgerEntry);
    end;

    procedure InsertIntoReturnPaymentEntryList(var ReturnPaymentEntry: record "SLcM Reversal Entry"; CustomerLedEnt: Record "Cust. Ledger Entry")
    begin
        ReturnPaymentEntry.Reset();
        if ReturnPaymentEntry.FindLast() then
            ReturnPaymentEntry."Entry No." += 1
        else
            ReturnPaymentEntry."Entry No." := 1;
        CustomerLedEnt.CalcFields("Original Amount", "Remaining Amount");
        ReturnPaymentEntry.Init();
        ReturnPaymentEntry.Validate("Student No.", CustomerLedEnt."Customer No.");
        ReturnPaymentEntry.Validate("Enrollment No.", CustomerLedEnt."Enrollment No.");
        ReturnPaymentEntry.Validate("Payment Document No.", CustomerLedEnt."Document No.");
        ReturnPaymentEntry.Validate("Original Amount", CustomerLedEnt."Original Amount");
        ReturnPaymentEntry.Validate("Remaning Amount", CustomerLedEnt."Remaining Amount");
        ReturnPaymentEntry.validate("Payment Document Select", True);
        ReturnPaymentEntry.Insert();
    end;
}
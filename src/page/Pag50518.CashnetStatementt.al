page 50518 "Examination Setup List"
{
    PageType = List;
    Caption = 'CashnetStatement';
    // EntityName = 'Customer';
    // EntitySetName = 'Customer';
    SourceTable = Customer;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Studentid; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Studentname; Rec.Name)
                {
                    ApplicationArea = All;
                }

                Field(Addr1; Rec.Address)
                {
                    ApplicationArea = All;
                }
                Field(Addr2; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                Field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Stmtdate; Today)
                {
                    ApplicationArea = All;
                }
                Field(Currbal; Round(CustomerBal))
                {
                    ApplicationArea = All;
                }
                Field(Previousbalance; Round(PrevBalance))
                {
                    ApplicationArea = All;
                }
                field(Duedate; DueDate)
                {
                    ApplicationArea = All;
                }
                field(Totaldue; Round(CustomerBal + PrevBalance))
                {
                    ApplicationArea = All;
                }
            }

        }

    }
    trigger OnAfterGetRecord()
    var
        CustomerLedEnt: Record "Cust. Ledger Entry";
    begin
        Clear(CustomerBal);
        CustomerLedEnt.Reset();
        CustomerLedEnt.SetRange("Customer No.", Rec."No.");
        CustomerLedEnt.SetRange("Global Dimension 2 Code", '');
        CustomerLedEnt.SetRange("Posting Date", 20211001D, 20221231D);
        IF CustomerLedEnt.FindFirst() then
            repeat
                CustomerLedEnt.CalcFields(Amount);
                CustomerBal += CustomerLedEnt.Amount;
            until CustomerLedEnt.Next() = 0;

        Clear(PrevBalance);
        StudentLegacyLedger.reset();
        StudentLegacyLedger.SetRange("Date", 20010101D, 20210930D);
        StudentLegacyLedger.SetRange("Student Number", Rec."No.");
        StudentLegacyLedger.setfilter("Global Dimension 2 Code", '');
        if StudentLegacyLedger.Findfirst() then BEGIN
            StudentLegacyLedger.CalcSums(Amount);
            PrevBalance := StudentLegacyLedger.Amount;
        end;

        CustomerLedEnt.Reset();
        CustomerLedEnt.SetCurrentKey("Posting Date", "Customer No.", "Global Dimension 2 Code", Reversed, "Document No.");
        CustomerLedEnt.setrange("posting Date", 20010101D, 20210930D);
        CustomerLedEnt.SetRange("customer No.", Rec."No.");
        CustomerLedEnt.setfilter("Global Dimension 2 Code", '');
        CustomerLedEnt.SetRange(Reversed, false);
        CustomerLedEnt.SetFilter("Document No.", '<>%1', 'OPNG*');
        IF CustomerLedEnt.FindFirst() then
            repeat
                CustomerLedEnt.CalcFields(Amount);
                PrevBalance += CustomerLedEnt.Amount;
            until CustomerLedEnt.Next() = 0;
        DueDate := 0D;
        CustomerLedEnt.Reset();
        CustomerLedEnt.SetCurrentKey("Entry No.");
        CustomerLedEnt.SetRange("Customer No.", Rec."No.");
        CustomerLedEnt.SetRange("Global Dimension 2 Code", '');
        IF CustomerLedEnt.FindLast() then
            DueDate := CustomerLedEnt."Due Date";
    end;

    var
        CustomerBal: Decimal;
        PrevBalance: Decimal;
        DueDate: Date;
        StudentLegacyLedger: Record "Student Legacy Ledger";
}
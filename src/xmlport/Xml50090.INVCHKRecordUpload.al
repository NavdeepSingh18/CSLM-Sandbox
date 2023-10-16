xmlport 50090 "INV CHK Record Upload"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("RLE INV CHK Update XL"; "RLE INV CHK Update XL")
            {
                XmlName = 'InvoiceCheckUploadXL';

                textelement(RotationID) { }

                textelement(StudentID) { }

                textelement(InvoiceNo) { }
                textelement(InvoiceDate) { }
                textelement(WeeksToInvoice) { }
                textelement(CostperWeekOverride) { }
                textelement(CheckNo) { }
                textelement(CheckDate) { }
                textelement(WeeksToPay) { }

                trigger OnBeforeInsertRecord()
                var
                    RLEXL: Record "RLE INV CHK Update XL";
                begin
                    if Heading = true then
                        Heading := false
                    else
                        if (RotationID <> '') and (StudentID <> '') then begin
                            RLEXL.Reset();
                            if RLEXL.FindLast() then
                                EntryNo := RLEXL."Entry No."
                            else
                                EntryNo := 1;

                            EntryNo := EntryNo + 1;
                            RLEXL.Init();
                            RLEXL."Entry No." := EntryNo;
                            RLEXL."Rotation ID" := RotationID;

                            if WeeksToInvoice <> '' then
                                Evaluate(RLEXL."Weeks to Invoice", WeeksToInvoice);
                            if WeeksToPay <> '' then
                                Evaluate(RLEXL."Weeks to Pay", WeeksToPay);

                            RLEXL.Validate("Student ID", StudentID);
                            RLEXL."Invoice No." := InvoiceNo;

                            if InvoiceDate <> '' then
                                Evaluate(RLEXL."Invoice Date", InvoiceDate);

                            if CostperWeekOverride <> '' then
                                Evaluate(RLEXL."Cost per Week Override", CostperWeekOverride);
                            RLEXL."Check No." := CheckNo;

                            if CheckDate <> '' then
                                Evaluate(RLEXL."Check Date", CheckDate);

                            RLEXL."Uploaded By" := UserId;
                            RLEXL."Uploaded On" := Today;
                            RLEXL.Insert();
                        end;

                    currXMLport.Skip();
                end;
            }
        }
    }


    trigger OnPreXmlPort()
    var
        RLEXL: Record "RLE INV CHK Update XL";
    begin
        RLEXL.Reset();
        if RLEXL.FindLast() then
            EntryNo := RLEXL."Entry No."
        else
            EntryNo := 1;

        Heading := true;
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Details Uploaded Successfully!');
    end;

    var
        EntryNo: Integer;
        Heading: Boolean;
}


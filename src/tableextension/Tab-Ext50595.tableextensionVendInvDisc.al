tableextension 50595 "tableextensionVendInvDisc" extends "Vendor Invoice Disc."
{
    // version NAVW17.00,FIN1.0-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    30-04-2019    OnModify                      Code added for Assign Value in Fields.
    // 2         CSPL-00136    30-04-2019    InsertVendorInvDiscArchive    Code added for insert data in table.
    // 
    fields
    {
        modify("Discount %")
        {
            trigger OnAfterValidate()
            begin
                InsertVendorInvDiscArchive(Rec);
            end;
        }
        field(50000; "Last Modified Date"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
        }
        field(50001; "Archive No."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Mother Tongue-CS" WHERE(Code = FIELD(Code)));
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Archive No.';
        }
        field(50002; "Last Modified Time"; Time)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Last Modified Time';
            DataClassification = CustomerContent;
        }
    }

    trigger OnModify()
    begin
        //Code added for Assign Value in Fields::CSPL-00136::30-04-2019: Star
        "Last Modified Time" := TIME();
        "Last Modified Date" := WORKDATE();
        //Code added for Assign Value in Fields::CSPL-00136::30-04-2019: Star
    end;

    procedure InsertVendorInvDiscArchive(Rec: Record "Vendor Invoice Disc.")
    var
        VendInvoiceDiscArchCS: Record "Vend Invoice Disc Arch-CS";
        LineNo: Integer;
    begin
        //Code added for insert data in table::CSPL-00136::30-04-2019: Star
        VendInvoiceDiscArchCS.Reset();
        VendInvoiceDiscArchCS.SETRANGE(Code, Code);
        IF VendInvoiceDiscArchCS.FINDLAST() THEN
            LineNo := VendInvoiceDiscArchCS."Line No.";

        VendInvoiceDiscArchCS.INIT();
        VendInvoiceDiscArchCS.Code := Code;
        VendInvoiceDiscArchCS."Line No." := LineNo + 10000;
        VendInvoiceDiscArchCS."Currency Code" := "Currency Code";
        VendInvoiceDiscArchCS."Minimum Amount" := "Minimum Amount";
        VendInvoiceDiscArchCS."Discount %" := "Discount %";
        VendInvoiceDiscArchCS."Service Charge" := "Service Charge";
        VendInvoiceDiscArchCS."Modified Date" := "Last Modified Date";
        VendInvoiceDiscArchCS."Modified Time" := "Last Modified Time";
        VendInvoiceDiscArchCS.INSERT();
        //Code added for insert data in table::CSPL-00136::30-04-2019: End
    end;
}
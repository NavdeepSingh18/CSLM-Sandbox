table 50422 "Vendor Contract"
{
    DataClassification = CustomerContent;
    Caption = 'Vendor Contract';
    DataCaptionFields = "Vendor No.", "Contract No.";

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor No.';
            Editable = false;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                "Vendor Name" := '';
                if Vendor.Get("Vendor No.") then
                    "Vendor Name" := Vendor."Name";
            End;
        }
        field(2; "Contract No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract No.';
        }
        field(3; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            trigger OnValidate()
            var
                VendorContract: Record "Vendor Contract";
            begin
                TestField("Contract No.");

                VendorContract.Reset();
                VendorContract.SetCurrentKey("Contract End Date");
                VendorContract.SetRange("Vendor No.", "Vendor No.");
                VendorContract.SetFilter("Contract End Date", '<>%1', "Contract End Date");
                If VendorContract.FindLast() then
                    IF "Contract Start Date" <= VendorContract."Contract End Date" then
                        Error('Contract Start Date (%1) must be greater than Contract End Date (%2) of Contract No. %3.', "Contract Start Date", VendorContract."Contract End Date", VendorContract."Contract No.");

                "Contract End Date" := 0D;
            end;
        }
        field(4; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            trigger OnValidate()
            var
                VendorContract: Record "Vendor Contract";
            begin
                TestField("Contract No.");
                Testfield("Contract Start Date");
                IF "Contract Start Date" > "Contract End Date" then
                    Error('Contract End Date must be greater than the Contract Start Date.');

                VendorContract.Reset();
                VendorContract.SetCurrentKey("Contract Start Date");
                VendorContract.SetRange("Vendor No.", "Vendor No.");
                VendorContract.SetFilter("Contract Start Date", '>%1', "Contract Start Date");
                If VendorContract.FindSet() then
                    Repeat
                        IF "Contract End Date" >= VendorContract."Contract Start Date" then
                            Error('End Date (%1) must be Less than Start Date (%2) of Contract No. %3.', "Contract End Date", VendorContract."Contract Start Date", VendorContract."Contract No.");
                    Until VendorContract.NEXT() = 0;
            end;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(8; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;
        }
        Field(9; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;
        }
        Field(10; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;
        }
        Field(13; "Vendor Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Name';
            Editable = false;

        }

    }

    keys
    {
        key(key1; "Vendor No.", "Contract No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := Today;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified On" := Today;
    end;
}
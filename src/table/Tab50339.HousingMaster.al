table 50339 "Housing Master"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Master';
    LookupPageId = "Housing Master List";
    DrillDownPageId = "Housing Master List";
    DataCaptionFields = "Housing ID", "Housing Name";

    fields
    {
        field(1; "Housing ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';

        }
        field(2; "Housing Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Name';

        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(4; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(5; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        Field(6; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;

        }
        Field(7; "Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
            Editable = False;

        }
        Field(8; "Housing Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Group';
            TableRelation = "Housing Group"."Group Code";

        }
        Field(9; "Owned By University"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Owned By University';

        }
        Field(10; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor No.';
            TableRelation = Vendor."No." where("Vendor Sub Type" = filter('Property Owner'));

            trigger OnValidate()
            begin
                IF VendorRec.Get("Vendor No.") THEN
                    "Owner Name" := VendorRec.Name
                ELSE
                    "Owner Name" := '';

            end;
        }
        Field(11; "Owner Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Owner Name';
        }
        Field(12; "Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        Field(13; "Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        Field(14; "City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
            // TableRelation = if (country = const()) "Post Code".City
            // else
            // if (Country = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = field(Country));
        }
        Field(15; "Country"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        Field(16; "Contact Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Number';
        }
        Field(17; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(20; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            // TableRelation = if (country = const()) "Post Code"
            // else
            // if (Country = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field(Country));
            // trigger OnValidate()
            // begin
            //     PostCodeRec.Reset();
            //     PostCodeRec.SetRange(PostCodeRec.Code, "Post Code");
            //     IF PostCodeRec.FindFirst() THEN BEGIN
            //         Country := PostCodeRec."Country/Region Code";
            //         city := PostCodeRec.City;
            //     END ELSE BEGIN
            //         Country := '';
            //         city := '';
            //     END;
            // end;
        }
        Field(21; "Off Campus"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Off Campus';

        }
        Field(24; "Contact Person Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Person Name';

        }
        Field(25; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = False;

        }
        Field(26; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
            Editable = False;

        }
        field(27; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(28; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(29; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(30; Block; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; Comment; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(32; Gender; Option)
        {
            Caption = 'Open Type';
            OptionCaption = ' ,E,C';
            OptionMembers = " ",Everyone,Couple;
            DataClassification = CustomerContent;
        }
        field(33; MaxCapacity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(34; NormalCapacity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(35; State; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Country = const()) "State SLcM CS"
            else
            if (Country = FILTER(<> '')) "State SLcM CS" WHERE("Country/Region Code" = field(Country));
        }

    }

    keys
    {
        key(PK; "Housing ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Housing ID", "Housing Name")
        { }
    }
    var
        VendorRec: Record Vendor;
        PostCodeRec: Record "Post Code";
        HostelLedger: Record "Housing Ledger";

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        Updated := true;
        // HostelLedger.Reset();
        // HostelLedger.SetRange(HostelLedger."Housing ID", "Housing ID");
        // IF HostelLedger.FindFirst() then
        //     Error('You can not Modify the record, Ledger Entry already exist');
    end;

    trigger OnDelete()
    begin
        HostelLedger.Reset();
        HostelLedger.SetRange(HostelLedger."Housing ID", "Housing ID");
        IF HostelLedger.FindFirst() then
            Error('You can not delete the record, Ledger Entry already exist');
    end;

    procedure ContractDetail(HostelID: Code[20]; var StartDate: Date; var EndDate: Date; var ContractNo: Code[20])
    var
        HostelContractDetail: Record "Housing Contract";

    begin
        HostelContractDetail.Reset();
        HostelContractDetail.SetRange("Housing ID", HostelID);
        HostelContractDetail.SetFilter("Start Date", '<=%1', WorkDate());
        HostelContractDetail.SetFilter("End Date", '>=%1', WorkDate());
        if HostelContractDetail.FindSet() then begin
            StartDate := HostelContractDetail."Start Date";
            EndDate := HostelContractDetail."End Date";
            ContractNo := HostelContractDetail."Contract No.";
        end;
    end;

}
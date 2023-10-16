table 50331 "Room Category Fee Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Apartment Category Fee Setup';
    LookupPageId = "Room Category Fee Setup";
    DrillDownPageId = "Room Category Fee Setup";
    DataCaptionFields = "Room Category Code", "Room Category Name";


    fields
    {
        field(1; "Room Category Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Code';
            TableRelation = "Room Category Master";
            trigger OnValidate()
            Var
                RecRoomCatMaster: Record "Room Category Master";
            begin

                IF RecRoomCatMaster.Get("Room Category Code") then begin
                    "Room Category Name" := RecRoomCatMAster."Room Category Name";
                    "With Spouse" := RecRoomCatMAster."With Spouse";
                end else begin
                    "Room Category Name" := '';
                    "With Spouse" := false;
                end;

            end;

        }
        field(2; "Effective From"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective From';

        }
        field(3; "Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cost';

        }
        field(4; "G/L Account No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account"."No.";
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
        field(7; "With Spouse Cost"; Decimal)
        {
            Caption = 'With Spouse Cost';
            DataClassification = CustomerContent;
        }
        field(8; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(9; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;

        }
        field(10; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        field(11; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = false;

        }
        field(12; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert';
            Editable = false;

        }
        field(13; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;

        }
        field(14; "Housing ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';
            TableRelation = "Housing Master"."Housing ID";
            trigger OnValidate()
            Var
                RecHousingMaster: Record "Housing Master";
            begin

                IF RecHousingMaster.Get("Housing ID") then begin
                    "Housing Name" := RecHousingMaster."Housing Name";
                    validate("Housing Group", RecHousingMaster."Housing Group");
                    "Off Campus" := RecHousingMaster."Off Campus";
                end;

            end;
        }
        field(15; "Room Category Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Name';
            Editable = False;
        }
        field(16; "Housing Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Name';
            Editable = False;
        }
        Field(17; "Housing Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Group';
            TableRelation = "Housing Group"."Group Code";
            trigger OnValidate()
            var
                HousingGrp: Record "Housing Group";
            begin
                "Housing Group Name" := '';
                if HousingGrp.Get("Housing Group") then
                    "Housing Group Name" := HousingGrp."Group Name"
            end;

        }
        Field(18; "Off Campus"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Off Campus';
            Editable = false;

        }
        Field(19; "With Spouse"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'With Spouse';
            Editable = false;

        }
        field(20; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(22; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(23; "Room Category Availbility"; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'Apartment Category Availbility';

            CalcFormula = Exist("Room Wise Bed" WHERE("Housing ID" = FIELD("Housing ID"),
                                                        "Room Category Code" = field("Room Category Code"),
                                                        Blocked = filter(false),
                                                        Available = filter(true)));
        }
        field(24; "Housing Group Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Group Name';
            Editable = False;
        }
        field(25; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Blocked (On Campus Housing)"; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Room Category Code", "Housing ID", "Effective From")
        {
            Clustered = true;
        }
    }

    var


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
    end;


}
table 50330 "Room Category Master"
{
    DataClassification = CustomerContent;
    Caption = 'Apartment Category Master';
    LookupPageId = "Room Category List";
    DrillDownPageId = "Room Category List";
    DataCaptionFields = "Room Category Code", "Room Category Name";

    fields
    {
        field(1; "Room Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Code';

        }
        field(2; "Room Category Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Name';

        }
        field(3; "Maximum No. of Bed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum No. of Room';
            MinValue = 0;
            trigger OnValidate()
            var
                RoomMaster_lRec: Record "Room Master";
            begin
                RoomMaster_lRec.Reset();
                RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
                IF RoomMaster_lRec.FindFirst() then begin
                    RoomMaster_lRec.CalcFields("Available Beds");
                    IF "Maximum No. of Bed" <> RoomMaster_lRec."Available Beds" then
                        error('Apartment Occupied you can not change "Maximum No. of Room"');
                end;
                IF "With Spouse" then
                    IF "Maximum No. of Bed" <= 1 then
                        Error('"Maximum No. of Room" must be greater than 1');
            end;

        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(6; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert';
            Editable = false;

        }
        field(7; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;

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
        field(12; "With Spouse"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'With Spouse';
            trigger OnValidate()
            begin
                IF "With Spouse" then
                    IF "Maximum No. of Bed" <= 1 then
                        Error('"Maximum No. of Room" must be gerater than 1');
            end;
        }
        field(50013; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50014; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50015; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50016; Block; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Block';
        }
        field(50017; Comment; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment';
        }
        field(50018; "Normal Capacity"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Normal Capacity';
        }
    }

    keys
    {
        key(PK; "Room Category Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Room Category Code", "Room Category Name", "Maximum No. of Bed", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
        }
    }



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
table 50332 "Room Master"
{
    DataClassification = CustomerContent;
    Caption = 'Apartment Master';
    LookupPageId = "Room Master List";
    DrillDownPageId = "Room Master List";
    DataCaptionFields = "Housing ID", "Room No.";
    fields
    {
        field(1; "Housing ID"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';
            Editable = false;
            TableRelation = "Housing Master";

            trigger OnValidate()
            begin
                If HousingMasterRec.Get("Housing ID") then begin
                    "Global Dimension 1 Code" := HousingMasterRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := HousingMasterRec."Global Dimension 2 Code";
                end else begin
                    "Global Dimension 2 Code" := '';
                    "Global Dimension 2 Code" := '';
                end;

            end;

        }
        field(2; "Room No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment No.';
            trigger OnValidate()
            begin
                If HousingMasterRec.Get("Housing ID") then
                    if HousingMasterRec.Blocked = true then
                        Error('You can not create Apartment, Housing is blocked');
            end;

        }
        field(3; "Floor No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Floor No.';
            MinValue = -3;
            MaxValue = 12;

        }
        field(4; "Room Category Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Code';
            TableRelation = "Room Category Master"."Room Category Code";

            trigger OnValidate()
            begin
                IF RoomCateMaterRec.Get("Room Category Code") THEN
                    "Maximum No. of Bed" := RoomCateMaterRec."Maximum No. of Bed"
                ELSE
                    "Maximum No. of Bed" := 0;

            end;

        }
        field(5; "Maximum No. of Bed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum No. of Room';
            Editable = false;

        }
        field(6; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(7; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;

        }
        field(8; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        field(9; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = false;

        }
        field(10; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
            Editable = false;

        }
        field(11; "Available Beds"; Integer)
        {
            Caption = 'Apartment Wise Available Rooms';
            FieldClass = FlowField;
            // CalcFormula = sum ("Hostel Ledger"."Room Assignment" where("Hostel ID" = field("Hostel ID"), "Room No." = Field("Room No.")));
            // CalcFormula = count ("Room Wise Bed" where("Housing ID" = field("Housing ID"), "Room No." = field("Room No."),
            // Consumption = const(0)));
            CalcFormula = count("Room Wise Bed" where("Housing ID" = field("Housing ID"), "Room No." = field("Room No."),
            Blocked = filter(false), Available = filter(true)));
        }

        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
            Editable = false;

        }
        field(15; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;

        }
        field(16; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(17; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(19; "Room Fee"; Decimal)
        {
            Caption = 'Apartment Fee';
            DataClassification = CustomerContent;

        }
        field(20; "Bill Code"; code[20])
        {
            Caption = 'Bill Code';
            DataClassification = CustomerContent;

        }
        field(21; "Gender Allowed"; Option)
        {
            Caption = 'Open Type';
            OptionCaption = ' ,E,C';
            OptionMembers = " ",Everyone,Couple;
            DataClassification = CustomerContent;

        }

    }

    keys
    {
        key(Key1; "Housing ID", "Room No.")
        {
            Clustered = true;
        }
    }

    var
        RoomCateMaterRec: Record "Room Category Master";
        HousingMasterRec: Record "Housing Master";
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
        //24Dec2021 ---Mishma Mail(Housing Corrections Required- PROD update)
        // HostelLedger.Reset();
        // HostelLedger.SetRange("Housing ID", "Housing ID");
        // HostelLedger.SetRange("Room No.", "Room No.");
        // IF HostelLedger.FindFirst() then
        //     Error('You can not Modify the record, Ledger Entry already exist');
    end;

    trigger OnDelete()
    begin
        HostelLedger.Reset();
        HostelLedger.SetRange("Housing ID", "Housing ID");
        HostelLedger.SetRange(HostelLedger."Room No.", "Room No.");
        IF HostelLedger.FindFirst() then
            Error('You can not delete the record, Ledger Entry already exist');
    end;

    trigger OnRename()
    begin

    end;

}
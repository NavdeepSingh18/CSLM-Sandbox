table 50333 "Room Wise Bed"
{
    DataClassification = CustomerContent;
    Caption = 'Apartment Wise Room';
    LookupPageId = "Room Wise Bed List";
    DrillDownPageId = "Room Wise Bed List";
    DataCaptionFields = "Housing ID", "Room No.", "Bed No.";


    fields
    {
        field(1; "Housing ID"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';
            Editable = false;
            trigger OnValidate()
            begin
                If HousingMasterRec.Get("Housing ID") then BEGIN
                    "Global Dimension 1 Code" := HousingMasterRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := HousingMasterRec."Global Dimension 2 Code"
                END ELSE BEGIN
                    "Global Dimension 2 Code" := '';
                    "Global Dimension 2 Code" := '';
                END;
            end;



        }
        field(2; "Room No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment No.';
            Editable = false;


        }
        field(3; "Bed No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Room No.';
            trigger OnValidate()
            begin

                If "Bed No." <> '' then begin
                    RoomWiseBedRec.Reset();
                    RoomWiseBedRec.SETRANGE("Housing ID", "Housing ID");
                    RoomWiseBedRec.SETRANGE("Room No.", "Room No.");
                    if xrec."Bed No." <> '' then
                        RoomWiseBedRec.SetRange("Bed No.", xrec."Bed No.");
                    IF RoomWiseBedRec.FINDSET() THEN BEGIN
                        RoomCount := RoomWiseBedRec.COUNT() + 1;
                        RoomMasterRec.Reset();
                        RoomMasterRec.SETRANGE("Housing ID", "Housing ID");
                        RoomMasterRec.SetRange("Room No.", "Room No.");
                        IF RoomMasterRec.FINDFIRST() THEN begin
                            //"Maximum No. of Bed" := RoomMasterRec."Maximum No. of Bed";
                            RoomMasterRec.TestField(RoomMasterRec.Blocked, false);
                            IF RoomCount > RoomMasterRec."Maximum No. of Bed" THEN
                                ERROR('You are trying to exceed the number of Rooms which are assigned to the Apartment.');
                        end;
                    END;
                    RoomMasterRec.Reset();
                    RoomMasterRec.SETRANGE("Housing ID", "Housing ID");
                    RoomMasterRec.SetRange("Room No.", "Room No.");
                    IF RoomMasterRec.FINDFIRST() THEN begin
                        "Maximum No. of Bed" := RoomMasterRec."Maximum No. of Bed";
                        "Room Category Code" := RoomMasterRec."Room Category Code";
                    end;
                    Available := true;
                end
                else
                    Available := false;

            end;
        }
        field(4; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(5; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;

        }
        field(6; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        field(7; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = false;

        }
        field(8; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
            Editable = false;

        }
        field(9; Available; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Available';
            Editable = false;

        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
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
        field(21; Consumption; Integer)
        {
            Caption = 'Consumption';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Housing Ledger"."Room Assignment" where("Housing ID" = field("Housing ID"), "Room No." = Field("Room No.")
            , "Bed No." = field("Bed No.")));
        }
        field(22; "Maximum No. of Bed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum No. of Room';
            Editable = false;

        }
        field(23; "Room Category Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Code';
            TableRelation = "Room Category Master"."Room Category Code";
            Editable = false;
        }
        field(24; "Bed Size"; text[50])
        {
            DataClassification = CustomerContent;

        }

    }

    keys
    {
        key(Key1; "Bed No.", "Housing ID", "Room No.")
        {
            Clustered = true;
        }
    }

    var
        HousingMasterRec: Record "Housing Master";
        RoomMasterRec: Record "Room Master";
        HostelLedger: Record "Housing Ledger";
        RoomWiseBedRec: Record "Room Wise Bed";
        RoomCount: Integer;


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
        // HostelLedger.SetRange("Housing ID", "Housing ID");
        // HostelLedger.SetRange("Room No.", "Room No.");
        // HostelLedger.SetRange(HostelLedger."Bed No.", "Bed No.");
        // IF HostelLedger.FindFirst() then
        //     Error('You can not Modify the record, Ledger Entry already exist');

    end;

    trigger OnDelete()
    begin
        HostelLedger.Reset();
        HostelLedger.SetRange("Housing ID", "Housing ID");
        HostelLedger.SetRange("Room No.", "Room No.");
        HostelLedger.SetRange(HostelLedger."Bed No.", "Bed No.");
        IF HostelLedger.FindFirst() then
            Error('You can not delete the record, Ledger Entry already exist');

    end;

}
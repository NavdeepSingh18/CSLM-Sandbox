table 50295 "Room Alloted Head-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   09/04/2019       OnInsert()                                 Code added for No series & Created Details
    // 02    CSPL-00114   09/04/2019       OnModify()                                 Code added for Validation & Modified Details
    // 03    CSPL-00114   09/04/2019       No. - OnValidate()                         Code added for No Series Generation
    // 04    CSPL-00114   09/04/2019       AssistEdit() -Function                     Code added for No Series Generation

    Caption = 'Room Alloted Head-CS';
    // DrillDownPageID = "Mal Practice1-CS";
    // LookupPageID = "Mal Practice1-CS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for No Series Generation::CSPL-00114::09042019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    SetupExaminationCS.GET();
                    NoSeriesMgt.TestManual(SetupExaminationCS."Room Allocation Nos.");
                    "No. Series" := '';
                END;
                //Code added for No Series Generation::CSPL-00114::09042019: End
            end;
        }
        field(2; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(3; "Room Capacity"; Integer)
        {
            Caption = 'Room Capacity';
            DataClassification = CustomerContent;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(11; "Student Capacity Line"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Student Capacity Line';

            CalcFormula = Sum("Room Alloted Line-CS"."Student Capacity" WHERE("Document No." = FIELD("No.")));
            Editable = false;

        }
        field(50; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;

            Editable = false;
        }
        field(51; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(53; "Last Modified On"; Date)
        {
            Caption = 'Last Modified On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(54; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(55; "Room  no."; Code[20])
        {
            Caption = 'Room  no.';
            DataClassification = CustomerContent;
            TableRelation = "Rooms-CS"."Room No." WHERE("Allot For Examination" = CONST(False));
        }
        field(56; "Building No."; Integer)
        {
            Caption = 'Building No.';
            DataClassification = CustomerContent;
        }
        field(57; "Building Name"; Text[80])
        {
            Caption = 'Building Name';
            DataClassification = CustomerContent;
        }
        field(58; "Floor No."; Integer)
        {
            Caption = 'Floor No.';
            DataClassification = CustomerContent;
        }
        field(59; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for No series & Created Details::CSPL-00114::09042019: Start
        IF NOT SkipInitialization() THEN BEGIN
            SetupExaminationCS.GET();
            NoSeriesMgt.InitSeries(SetupExaminationCS."Room Allocation Nos.", xRec."No. Series", TODAY(), "No.", "No. Series");
        END;
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        //Code added for No series & Created Details::CSPL-00114::09042019: End
    end;

    trigger OnModify()
    begin
        //Code added for Validation & Modified Details::CSPL-00114::09042019: Start
        "Last Modified By" := FORMAT(UserId());
        "Last Modified On" := TODAY();

        RoomAllotedLineCS.Reset();
        RoomAllotedLineCS.SETRANGE("Document No.", Rec."No.");
        IF RoomAllotedLineCS.FINDFIRST() THEN
            ERROR(Text_10004Lbl);

        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Validation & Modified Details::CSPL-00114::09042019: End
    end;

    var
        SetupExaminationCS: Record "Setup Examination -CS";
        RoomAllotedLineCS: Record "Room Alloted Line-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text_10004Lbl: Label 'Room allocation line already exists.';

    local procedure SkipInitialization(): Boolean
    begin
        IF "No." = '' THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    procedure AssistEdit(RoomAllocationHeader: Record "Room Alloted Head-CS"): Boolean
    begin
        //Code added for No Series Generation::CSPL-00114::09042019: Start
        SetupExaminationCS.GET();
        IF NoSeriesMgt.SelectSeries(SetupExaminationCS."Room Allocation Nos.", RoomAllocationHeader."No. Series", "No. Series") THEN BEGIN
            SetupExaminationCS.GET();
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
        //Code added for No Series Generation::CSPL-00114::09042019: End
    end;
}


table 50265 "Examination Time Slot-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                              Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   07/01/2019       OnInsert()                           Get "No Series","Academic Year",Date & "User Id" Values.
    // 02    CSPL-00114   07/01/2019       Code - OnValidate()                  Code added for No Series.
    // 03    CSPL-00114   07/01/2019       Assistedit -Function                 Get "No Series" Code added

    Caption = 'Examination Time Slot-CS';
    DrillDownPageID = "Slot(Exam) Card-CS";
    LookupPageID = "Slot(Exam) Card-CS";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                //Code added for No Series::CSPL-00114::07012019: Start
                IF Code <> xRec.Code THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Exam Slot No.");
                    "No. Series" := '';
                END;
                //Code added for No Series::CSPL-00114::07012019: End
            end;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "From Time"; Time)
        {
            Caption = 'From Time';
            DataClassification = CustomerContent;
        }
        field(4; "To Time"; Time)
        {
            Caption = 'To Time';
            DataClassification = CustomerContent;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Examination Center"; Code[10])
        {
            Caption = 'Examination Center';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Examination Center")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Get "No Series","Academic Year",Date & "User Id" Values::CSPL-00114::07012019: Start
        AcademicsSetupCS.GET();
        IF Code = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Exam Slot No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Exam Slot No.", xRec."No. Series", 0D, Code, "No. Series");
        END;

        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for Get "No Series","Academic Year",Date & "User Id" Values::CSPL-00114::07012019: End
    end;

    var


        AcademicsSetupCS: Record "Academics Setup-CS";
        ExaminationTimeSlotCS: Record "Examination Time Slot-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

    procedure AssistEdit(OldExamSlot: Record "Examination Time Slot-CS"): Boolean
    begin
        //Get "No Series" Code added::CSPL-00114::07012019: Start
        WITH ExaminationTimeSlotCS DO BEGIN
            ExaminationTimeSlotCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Exam Slot No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Exam Slot No.", OldExamSlot."No. Series", "No. Series") THEN BEGIN
                NoSeriesManagement.SetSeries(Code);
                Rec := ExaminationTimeSlotCS;
                EXIT(TRUE);
            END;
        END;
        //Get "No Series" Code added::CSPL-00114::07012019: End
    end;
}


table 50307 "Re-Appear Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   27/04/2019       OnInsert()                                 Generate "No Series" Code Added
    // 01    CSPL-00114   27/04/2019       OnDelete()                                 Code added for Line Delete
    // 02    CSPL-00114   27/04/2019       No. - OnValidate()                         Code added for No.Series generation
    // 05    CSPL-00114   27/04/2019       Semester - OnValidate()                    Code Added For the Validation.
    // 07    CSPL-00114   27/04/2019       Subject Type - OnValidate()                Get Description & Status Related Code added
    // 03    CSPL-00114   27/04/2019       Subject Code - OnValidate()                Code added for Subject Related values
    // 06    CSPL-00114   27/04/2019       External Maximum - OnValidate()            Code added for External Generate Validation
    // 06    CSPL-00114   27/04/2019       Staff Code - OnValidate()                  Code added for External & Internal Generate Validation
    // 06    CSPL-00114   27/04/2019       Section - OnValidate()                     Code added for Validation
    // 06    CSPL-00114   27/04/2019       Total Maximum - OnValidate()               Code added for Validation
    // 08    CSPL-00114   27/04/2019       AssistEdit - Function                      Code added for No.Series generation

    Caption = 'Re-Appear Header-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Line Delete::CSPL-00114::27042019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Re-appear No.");
                    "No.Series" := '';
                END;
                //Code added for Line Delete::CSPL-00114::27042019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";

            trigger OnValidate()
            begin
                //Code added for Line Delete::CSPL-00114::27042019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    Semester := '';
                    ERROR(Text003Lbl, AcademicsSetupCS."CBCS Subject Type");
                END;
                //Code added for Line Delete::CSPL-00114::27042019: End
            end;
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::27042019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    AcademicsSetupCS.TESTFIELD("CBCS Batch");
                    "CBCS Batch" := AcademicsSetupCS."CBCS Batch";
                END;
                //Code added for Validation::CSPL-00114::27042019: End
            end;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code WHERE("Academic Year" = FIELD("Academic Year"),
                                                            Course = FIELD("Course Code"));

            trigger OnValidate()
            begin
                //Code added for Subject Related values::CSPL-00114::27042019: Start
                SubjectMasterCS.RESET();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "Subject Code");
                SubjectMasterCS.SETRANGE(SubjectMasterCS."Academic Year", "Academic Year");
                IF SubjectMasterCS.FindFirst() THEN BEGIN
                    "Total Maximum" := SubjectMasterCS."Total Maximum";
                    "Interanl Maximum" := SubjectMasterCS."Internal Maximum";
                    "External Maximum" := SubjectMasterCS."External Maximum";
                    "Exam Fee" := SubjectMasterCS."Exam Fee";
                END ELSE BEGIN
                    "Total Maximum" := 0;
                    "Interanl Maximum" := 0;
                    "External Maximum" := 0;
                    "Exam Fee" := 0;
                END;
                //Code added for Subject Related values::CSPL-00114::27042019: End
            END;
        }
        field(6; "External Maximum"; Decimal)
        {
            Caption = 'External Maximum';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for External Generate Validation::CSPL-00114::27042019: Start
                ReAppearHeaderCS.GET("No.");
                IF ReAppearHeaderCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for External Generate Validation::CSPL-00114::27042019: End
            end;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for External & Internal Generate Validation::CSPL-00114::27042019: Start
                ReAppearHeaderCS.GET("No.");
                IF ReAppearHeaderCS."Internal Generated" OR ReAppearHeaderCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for External & Internal Generate Validation::CSPL-00114::27042019: End
            end;
        }
        field(9; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::27042019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    Section := '';
                    ERROR(Text005Lbl, AcademicsSetupCS."CBCS Subject Type");
                END;
                TESTFIELD(Semester);
                //Code added for Validation::CSPL-00114::27042019: End
            end;
        }
        field(11; "Total Maximum"; Decimal)
        {
            Caption = 'Total Maximum';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::27042019: Start
                ReAppearHeaderCS.GET("No.");
                IF ReAppearHeaderCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for Validation::CSPL-00114::27042019: End
            end;
        }
        field(12; "Internal Generated"; Boolean)
        {
            Caption = 'Internal Generated';
            DataClassification = CustomerContent;
        }
        field(13; "External Generated"; Boolean)
        {
            Caption = 'External Generated';
            DataClassification = CustomerContent;
        }
        field(14; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(15; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
        }
        field(16; "Interanl Maximum"; Decimal)
        {
            Caption = 'Interanl Maximum';
            DataClassification = CustomerContent;
        }
        field(17; "Exam Fee"; Decimal)
        {
            Caption = 'Exam Fee';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Open,Released';
            OptionMembers = " ",Open,Released;
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27042019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27042019';
        }
        field(33048922; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27042019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; "Course Code", Semester, "Subject Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Line Delete::CSPL-00114::27042019: Start
        ReAppearHeaderCS.GET("No.");
        ReAppearLineCS.RESET();
        ReAppearLineCS.SETRANGE("Document No.", "No.");
        ReAppearLineCS.DELETEALL();
        //Code added for Line Delete::CSPL-00114::27042019: End
    end;

    trigger OnInsert()
    begin
        //Code added for No.Series generation and Get Values Academic Year,Id,Status::CSPL-00114::27042019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("External Marks No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Re-appear No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;

        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        Status := Status::Open;
        //Code added for No.Series generation and Get Values Academic Year,Id,Status::CSPL-00114::27042019: End
    end;

    var
        ReAppearHeaderCS: Record "Re-Appear Header-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        ReAppearLineCS: Record "Re-Appear Line-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";


        Text002Lbl: Label 'You cant modify completed gereration.';
        Text003Lbl: Label 'You  cant enter a semester for subject type %1';

        Text005Lbl: Label 'You Cannot enter a Section For Subject Type %1.';

    procedure Assistedit(OldReAppearHeaderCS: Record "Re-Appear Header-CS"): Boolean
    begin
        //Code added Code added for No.Series generation::CSPL-00114::27042019: Start
        WITH ReAppearHeaderCS DO BEGIN
            ReAppearHeaderCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Re-appear No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Re-appear No.", OldReAppearHeaderCS."No.Series", "No.Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := ReAppearHeaderCS;
                EXIT(TRUE);
            END;
        END;
        //Code added Code added for No.Series generation::CSPL-00114::27042019: End
    end;
}


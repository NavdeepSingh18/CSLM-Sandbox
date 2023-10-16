table 50317 "Revaluation Head-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   15/03/2019       OnInsert()                                 Get "No Series","Academic Year" & "User Id" Values
    // 03    CSPL-00114   15/03/2019       No. - OnValidate()                         Code added for Get "No Series" Values
    // 04    CSPL-00114   15/03/2019       Subject Code - OnLookup()                  Code added for Subject Related Value & Course wise Subject Page lookup
    // 05    CSPL-00114   15/03/2019       Assistedit - Function                      Generate No Series

    Caption = 'Revaluation Head-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Get "No Series" Values::CSPL-00114::15032019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Revaluation Mark");
                    "No.Series" := '';
                END;
                //Code added for Get "No Series" Values::CSPL-00114::15032019: Start
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
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";

            trigger OnLookup()
            begin
                //Code added for Subject Related Value & Course wise Subject Page lookup::CSPL-00114::15032019: Start
                TESTFIELD("Subject Type");
                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD("Common Subject Type");
                RevaluationHeadCS.GET("No.");
                IF "Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", "Subject Type", "Subject Code");
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        RevaluationHeadCS.Reset();
                        RevaluationHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                        RevaluationHeadCS.SETRANGE("Course Code", "Course Code");
                        RevaluationHeadCS.SETRANGE(Semester, Semester);
                        RevaluationHeadCS.SETRANGE(Section, Section);
                        RevaluationHeadCS.SETRANGE("Academic Year", "Academic Year");
                        RevaluationHeadCS.SETRANGE("Subject Type", CourseWiseSubjectLineCS."Subject Type");
                        RevaluationHeadCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        IF RevaluationHeadCS.ISEMPTY() then BEGIN
                            SubjectMasterCS.Reset();
                            IF SubjectMasterCS.GET("Subject Code") THEN BEGIN
                                "Subject Code" := SubjectMasterCS.Code;
                                "External Maximum" := SubjectMasterCS."External Maximum";
                                "Total Maximum" := SubjectMasterCS."Total Maximum";
                            END;
                        END ELSE BEGIN
                            "Subject Code" := '';
                            "External Maximum" := 0;
                            "Total Maximum" := 0;
                            ERROR(Text000Lbl);
                        END;
                    END;
                END ELSE BEGIN
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETRANGE("Subject Type", "Subject Type");
                    IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN BEGIN
                        RevaluationHeadCS.Reset();
                        RevaluationHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                        RevaluationHeadCS.SETRANGE("Course Code", "Course Code");
                        RevaluationHeadCS.SETRANGE(Semester, Semester);
                        RevaluationHeadCS.SETRANGE(Section, Section);
                        RevaluationHeadCS.SETRANGE("Academic Year", "Academic Year");
                        RevaluationHeadCS.SETRANGE("Subject Type", SubjectMasterCS."Subject Type");
                        RevaluationHeadCS.SETRANGE("Subject Code", SubjectMasterCS.Code);
                        IF RevaluationHeadCS.ISEMPTY() then BEGIN
                            "Subject Code" := SubjectMasterCS.Code;
                            "External Maximum" := SubjectMasterCS."External Maximum";
                            "Total Maximum" := SubjectMasterCS."Total Maximum";
                        END ELSE BEGIN
                            "Subject Code" := '';
                            "External Maximum" := 0;
                            "Total Maximum" := 0;
                            ERROR(Text000Lbl);
                        END;
                    END;
                END;
                //Code added for Subject Related Value & Course wise Subject Page lookup::CSPL-00114::15032019: End
            end;
        }
        field(6; "External Maximum"; Decimal)
        {
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
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
        }
        field(11; "Total Maximum"; Decimal)
        {
            Caption = 'Total Maximum';
            DataClassification = CustomerContent;
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
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15032019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15032019';
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
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Get "No Series","Academic Year" & "User Id" Values::CSPL-00114::15032019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Revaluation Mark");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Revaluation Mark", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for Get "No Series","Academic Year" & "User Id" Values::CSPL-00114::15032019: Start
    end;

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        RevaluationHeadCS: Record "Revaluation Head-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

        NoSeriesMgt: Codeunit "NoSeriesManagement";

        Text000Lbl: Label '''External marks for this subjets has created already';

    procedure Assistedit(OldRevaluationHeadCS: Record "Revaluation Head-CS"): Boolean
    begin
        //Code added for No Series Generation::CSPL-00114::15032019: Start
        WITH RevaluationHeadCS DO BEGIN
            RevaluationHeadCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Revaluation Mark");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Revaluation Mark", OldRevaluationHeadCS."No.Series", "No.Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := RevaluationHeadCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for No Series Generation::CSPL-00114::15032019: End
    end;
}


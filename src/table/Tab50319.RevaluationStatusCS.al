table 50319 "Revaluation Status-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   28/03/2019       OnInsert()                                 Get "No Series","Academic Year",Revaluation Status Values
    // 02    CSPL-00114   28/03/2019       No. - OnValidate()                         Code added for No Series Gereration
    // 03    CSPL-00114   28/03/2019       Subject Code - OnLookup()                  Code added for No Series Course wise Subject Page lookup & Subject related Value
    // 04    CSPL-00114   28/03/2019       Student No. - OnValidate()                 Code added for Student related Value
    // 05    CSPL-00114   28/03/2019       Assistedit - Function                      Code added for No Series Gereration

    Caption = 'Revaluation Status-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No Series Generation::CSPL-00114::28032019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Revaluation No.");
                    "No.Series" := '';
                END;
                //Code added for No Series Generation::CSPL-00114::28032019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Editable = false;
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
                //Code added for No Series Course wise Subject Page lookup & Subject related Value::CSPL-00114::28032019: Start
                TESTFIELD("Subject Type");
                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD("Common Subject Type");
                RevaluationStatusCS.GET("No.");
                IF "Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", "Subject Type", "Subject Code");
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        RevaluationStatusCS.Reset();
                        RevaluationStatusCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                        RevaluationStatusCS.SETRANGE("Course Code", "Course Code");
                        RevaluationStatusCS.SETRANGE(Semester, Semester);
                        RevaluationStatusCS.SETRANGE(Section, Section);
                        RevaluationStatusCS.SETRANGE("Academic Year", "Academic Year");
                        RevaluationStatusCS.SETRANGE("Subject Type", CourseWiseSubjectLineCS."Subject Type");
                        RevaluationStatusCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        IF RevaluationStatusCS.ISEMPTY() then BEGIN
                            SubjectMasterCS.Reset();
                            IF SubjectMasterCS.GET(CourseWiseSubjectLineCS."Subject Code") THEN
                                "Subject Code" := SubjectMasterCS.Code
                            ELSE
                                "Subject Code" := '';
                        END;
                    END;
                END ELSE BEGIN
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETRANGE("Subject Type", "Subject Type");
                    IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN
                        RevaluationStatusCS.Reset();
                    RevaluationStatusCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                    RevaluationStatusCS.SETRANGE("Course Code", "Course Code");
                    RevaluationStatusCS.SETRANGE(Semester, Semester);
                    RevaluationStatusCS.SETRANGE(Section, Section);
                    RevaluationStatusCS.SETRANGE("Academic Year", "Academic Year");
                    RevaluationStatusCS.SETRANGE("Subject Type", SubjectMasterCS."Subject Type");
                    RevaluationStatusCS.SETRANGE("Subject Code", SubjectMasterCS.Code);
                    IF NOT RevaluationStatusCS.FINDFIRST() THEN
                        "Subject Code" := SubjectMasterCS.Code
                    ELSE BEGIN
                        "Subject Code" := '';
                        ERROR(Text000Lbl);
                    END;

                END;
                "Fee Amount" := AcademicsSetupCS."Revaluation Fees";
                //Code added for No Series Course wise Subject Page lookup & Subject related Value::CSPL-00114::28032019: End
            end;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
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
        field(11; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student related Value::CSPL-00114::28032019: Start
                StudentMasterCS.GET("Student No.");
                Name := StudentMasterCS."Student Name";
                "Course Code" := StudentMasterCS."Course Code";
                Semester := StudentMasterCS.Semester;
                "Academic Year" := StudentMasterCS."Academic Year";
                Section := StudentMasterCS.Section;
                //Code added for Student related Value::CSPL-00114::28032019: End
            end;
        }
        field(12; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(13; "Revaluation Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Requested,Approved,Closed';
            OptionMembers = " ",Requested,Approved,Closed;
        }
        field(14; "Fee Amount"; Decimal)
        {
            Caption = 'Fee Amount';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Student No.", "Course Code", Semester, "Academic Year", "Subject Code", "Revaluation Status")
        {
        }
        key(Key3; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series","Academic Year",Revaluation Status Values::CSPL-00114::28032019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Revaluation No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Revaluation No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;

        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "Revaluation Status" := "Revaluation Status"::Requested;
        //Get "No Series","Academic Year",Revaluation Status Values::CSPL-00114::28032019: End
    end;

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";

        RevaluationStatusCS: Record "Revaluation Status-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

        Text000Lbl: Label 'External marks for this subjets has created already.';

    procedure Assistedit(OldRevaluationStatusCS: Record "Revaluation Status-CS"): Boolean
    begin
        //Code added for No Series Generation::CSPL-00114::28032019: Start
        WITH RevaluationStatusCS DO BEGIN
            RevaluationStatusCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Revaluation No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Revaluation No.", OldRevaluationStatusCS."No.Series", "No.Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := RevaluationStatusCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for No Series Generation::CSPL-00114::28032019: End
    end;
}


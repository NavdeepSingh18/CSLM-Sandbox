table 50099 "Attend Percentage Head-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                         Remarks
    // 1         CSPL-00092    22-05-2019    OnInsert                        No Series and User Id Assign in User Id Field.
    // 2         CSPL-00092    22-05-2019    OnDelete                      Delete data form table
    // 3         CSPL-00092    22-05-2019    No. - OnValidate              No Series
    // 4         CSPL-00092    22-05-2019    Course Code - OnValidate      Validate Data
    // 5         CSPL-00092    22-05-2019    Semester - OnValidate       Validate Data
    // 6         CSPL-00092    22-05-2019    Subject Type - OnValidate       Validate Data And Assign value in CBSE Batch field
    // 7         CSPL-00092    22-05-2019    Subject Code - OnLookup       Validate Data And Assign value in fields
    // 8         CSPL-00092    22-05-2019    Section - OnValidate        Validate Data
    // 9         CSPL-00092    22-05-2019    Assistedit                Function Assistedit Button

    Caption = 'Attendance Percentage Header-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for No Series::CSPL-00092::22-05-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Attendance Percent No.");
                    "No.Series" := '';
                END;
                //Code added for No Series::CSPL-00092::22-05-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TESTFIELD("Subject Type");
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TESTFIELD("Course Code");
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    Semester := '';
                    ERROR(Text002Lbl, AcademicsSetupCS."CBCS Subject Type");
                END;
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(5; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            TableRelation = "Subject Type-CS";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validate Data And Assign value in CBSE Batch field::CSPL-00092::22-05-2019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    AcademicsSetupCS.TESTFIELD("CBCS Batch");
                    "CBCS Batch" := AcademicsSetupCS."CBCS Batch";
                END;
                //Code added for Validate Data And Assign value in CBSE Batch field::CSPL-00092::22-05-2019: End
            end;
        }
        field(6; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(7; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = "Subject Master-CS";
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Validate Data And Assign value in fields::CSPL-00092::22-05-2019: Start
                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD("Common Subject Type");
                TESTFIELD("Academic Year");
                IF "Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", "Subject Type", "Subject Code");
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        AttendPercentageHeadCS.Reset();
                        AttendPercentageHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                        AttendPercentageHeadCS.SETRANGE("Course Code", "Course Code");
                        AttendPercentageHeadCS.SETRANGE(Semester, Semester);
                        AttendPercentageHeadCS.SETRANGE(Section, Section);
                        AttendPercentageHeadCS.SETRANGE("Academic Year", "Academic Year");
                        AttendPercentageHeadCS.SETRANGE("Subject Type", CourseWiseSubjectLineCS."Subject Type");
                        AttendPercentageHeadCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        AttendPercentageHeadCS.SETRANGE("Result Generated", FALSE);
                        IF AttendPercentageHeadCS.ISEMPTY() then
                            "Subject Code" := CourseWiseSubjectLineCS."Subject Code"
                        ELSE
                            ERROR(Text003Lbl);
                    END;
                END ELSE BEGIN
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETRANGE("Subject Type", "Subject Type");
                    SubjectMasterCS.SETFILTER(Course, '%1|%2', "Course Code", '');
                    IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN BEGIN
                        AttendPercentageHeadCS.Reset();
                        AttendPercentageHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                        AttendPercentageHeadCS.SETRANGE("Course Code", "Course Code");
                        AttendPercentageHeadCS.SETRANGE(Semester, Semester);
                        AttendPercentageHeadCS.SETRANGE(Section, Section);
                        AttendPercentageHeadCS.SETRANGE("Academic Year", "Academic Year");
                        AttendPercentageHeadCS.SETRANGE("Subject Type", SubjectMasterCS."Subject Type");
                        AttendPercentageHeadCS.SETRANGE("Subject Code", SubjectMasterCS.Code);
                        AttendPercentageHeadCS.SETRANGE("Result Generated", FALSE);
                        IF AttendPercentageHeadCS.ISEMPTY() then
                            "Subject Code" := SubjectMasterCS.Code
                        ELSE
                            IF (AttendPercentageHeadCS.COUNT() <> 1) AND (NOT AttendPercentageHeadCS."Attendance % Generated") THEN
                                ERROR(Text003Lbl)
                            ELSE
                                "Subject Code" := SubjectMasterCS.Code;
                    END;
                END;
                //Code added for Validate Data And Assign value in fields::CSPL-00092::22-05-2019: End
            end;
        }
        field(8; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    Section := '';
                    ERROR(Text004Lbl, AcademicsSetupCS."CBCS Subject Type");
                END;
                TESTFIELD(Semester);
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(12; "Attendance % Generated"; Boolean)
        {
            Caption = 'Attendance % Generated';
            DataClassification = CustomerContent;
        }
        field(13; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(14; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 24-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 24-05-2019';
            Caption = 'Final Year Course';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 24-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 24-05-2019';
            DataClassification = CustomerContent;
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
        key(Key3; "Academic Year", "Subject Type", "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Delete date form table::CSPL-00092::22-05-2019: Start
        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETRANGE("Document No.", "No.");
        AttendPercentageLineCS.DELETEALL();
        //Code added for Delete date form table::CSPL-00092::22-05-2019: End
    end;

    trigger OnInsert()
    begin
        //Code added for No Series and User Id Assign in User Id Field::CSPL-00092::22-05-2019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Attendance Percent No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Attendance Percent No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for No Series and User Id Assign in User Id Field::CSPL-00092::22-05-2019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";

        AttendPercentageHeadCS: Record "Attend Percentage Head-CS";

        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";

        AttendPercentageLineCS: Record "Attend Percentage Line-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

        Text002Lbl: Label 'You cant enter a semester for subject type %1.';
        Text003Lbl: Label 'Attendance percentage already created.';
        Text004Lbl: Label 'You cant enter a section for subject type %1.';

    procedure Assistedit(OldStudentAttPercenHeader: Record "Attend Percentage Head-CS"): Boolean
    begin
        //Code added for Assistedit Button::CSPL-00092::22-05-2019: Start
        WITH AttendPercentageHeadCS DO BEGIN
            AttendPercentageHeadCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Attendance Percent No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Attendance Percent No.", OldStudentAttPercenHeader."No.Series", "No.Series")
            THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := AttendPercentageHeadCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Assistedit Button::CSPL-00092::22-05-2019: End
    end;
}
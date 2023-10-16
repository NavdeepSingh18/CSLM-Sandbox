table 50101 "Sessional Exam Group Head-CS"
{
    // version V.001-CS

    // Sr.No.      Emp. ID       Date          Trigger                                   Remarks
    // 1           CSPL-00092    20-04-2019    OnInsert                                  No series And Assign Value in Fields
    // 2           CSPL-00092    20-04-2019    OnModify                                Assign Value in Fields
    // 3           CSPL-00092    20-04-2019    OnDelete                                Delete Data from Table
    // 4           CSPL-00092    20-04-2019    No. - OnValidate                          For No. Series
    // 5           CSPL-00092    20-04-2019    Course Code - OnValidate                Assign Value in Fields
    // 6           CSPL-00092    20-04-2019    Semester - OnValidate                 Validate data
    // 7           CSPL-00092    20-04-2019    Subject Code - OnValidate               Assign Value in Internal Maximum Field
    // 8           CSPL-00092    20-04-2019    Subject Code - OnLookup                 Assign Value in Fields
    // 9           CSPL-00092    20-04-2019    Section - OnValidate                  Validate Data
    // 10          CSPL-00092    20-04-2019    Internal Evaluation Method - OnValidate Validate Data

    Caption = 'Sessional Exam Group Header-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for No Series::CSPL-00092::20-04-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Internal Exam Group No.");
                    "No.Series" := '';
                END;
                //Code added for No Series::CSPL-00092::20-04-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::20-04-2019: Start
                CourseMasterCS.Reset();
                IF CourseMasterCS.GET("Course Code") THEN BEGIN
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Program" := CourseMasterCS.Graduation;
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::20-04-2019: End
            end;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD("Course Code"));

            trigger OnValidate()
            begin
                //Code added for Validate data::CSPL-00092::20-04-2019: Start
                TESTFIELD("Course Code");
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    Semester := '';
                    ERROR(Text002Lbl, AcademicsSetupCS."CBCS Subject Type");
                END;
                //Code added for Validate data::CSPL-00092::20-04-2019: End
            end;
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
            TableRelation = "Course Wise Subject Line-CS"."Subject Code" WHERE("Course Code" = FIELD("Course Code"),
                                                                                Semester = FIELD(Semester));

            trigger OnLookup()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::20-04-2019: Start
                IF "Type Of Course" = "Type Of Course"::Semester THEN BEGIN
                    TESTFIELD("Subject Type");
                    TESTFIELD("Academic Year");
                    AcademicsSetupCS.GET();
                    AcademicsSetupCS.TESTFIELD("Common Subject Type");
                    IF "Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                        CourseWiseSubjectLineCS.Reset();
                        IF "Course Code" <> '' THEN
                            CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                        CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                        CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                        CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                        IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                            "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                            "Exam Group" := CourseWiseSubjectLineCS."Group Code";
                            "Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                        END ELSE BEGIN
                            "Subject Code" := '';
                            "Exam Group" := '';
                            "Internal Maximum" := 0;
                        END;
                    END ELSE BEGIN
                        SubjectMasterCS.Reset();
                        SubjectMasterCS.SETRANGE("Subject Type", "Subject Type");
                        SubjectMasterCS.SETFILTER(Course, '%1|%2', "Course Code", '');
                        IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN BEGIN
                            "Subject Code" := SubjectMasterCS.Code;
                            "Exam Group" := SubjectMasterCS."Group Code";
                        END ELSE BEGIN
                            "Subject Code" := '';
                            "Exam Group" := '';
                        END;
                    END
                END;

                IF "Type Of Course" = "Type Of Course"::Year THEN BEGIN
                    TESTFIELD("Subject Type");
                    TESTFIELD("Academic Year");
                    AcademicsSetupCS.GET();
                    AcademicsSetupCS.TESTFIELD("Common Subject Type");
                    IF "Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                        CourseWiseSubjectLineCS.Reset();
                        CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                        CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                        CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                        IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                            "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                            "Exam Group" := CourseWiseSubjectLineCS."Group Code";
                            "Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                        END ELSE BEGIN
                            "Subject Code" := '';
                            "Exam Group" := '';
                            "Internal Maximum" := 0;
                        END;
                    END ELSE BEGIN
                        SubjectMasterCS.Reset();
                        SubjectMasterCS.SETRANGE("Subject Type", "Subject Type");
                        SubjectMasterCS.SETFILTER(Course, '%1|%2', "Course Code", '');
                        IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN BEGIN
                            "Subject Code" := SubjectMasterCS.Code;
                            "Exam Group" := SubjectMasterCS."Group Code";
                        END ELSE BEGIN
                            "Subject Code" := '';
                            "Exam Group" := '';
                        END;
                    END
                END;
                //Code added for Assign Value in Fields::CSPL-00092::20-04-2019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Internal Maximum Field::CSPL-00092::20-04-2019: Start
                CourseWiseSubjectLineCS.Reset();
                IF CourseWiseSubjectLineCS."Course Code" <> '' THEN
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                CourseWiseSubjectLineCS.SETRANGE("Subject Code", "Subject Code");
                IF CourseWiseSubjectLineCS.FINDFIRST() THEN
                    "Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum"
                ELSE
                    "Internal Maximum" := 0;
                //Code added for Assign Value in Internal Maximum Field::CSPL-00092::20-04-2019: End
            end;
        }
        field(6; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    Section := '';
                    ERROR(Text003Lbl, AcademicsSetupCS."CBCS Subject Type");
                END;
                TESTFIELD(Semester);
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(9; "Exam Group"; Code[20])
        {
            Caption = 'Exam Group';
            DataClassification = CustomerContent;
            TableRelation = "Sessional Exam Group-CS".Group;
        }
        field(10; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 25-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Year Course';
            DataClassification = CustomerContent;

            Description = 'CS Field Added 25-04-2019';
        }
        field(50015; Year; Code[20])
        {
            caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            TableRelation = "Year Master-CS";
        }
        field(50016; "Internal Evaluation Method"; Option)
        {
            Caption = 'Internal Evaluation Method';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            OptionCaption = ' ,Best of Two,Average of Two,Best of Three,Average of Three,Average of Best Two';
            OptionMembers = " ","Best of Two","Average of Two","Best of Three","Average of Three","Average of Best Two";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                SessionalExamGroupLineCS.Reset();
                SessionalExamGroupLineCS.SETRANGE("Document No.", "No.");
                IF SessionalExamGroupLineCS.COUNT() > 1 THEN
                    ERROR(Text005Lbl);
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(50017; "Internal Maximum"; Decimal)
        {
            Caption = 'Internal Maximum';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50018; "Weightage Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Sessional Exam Group Line-CS".Weightage WHERE("Document No." = FIELD("No.")));
            Description = 'CS Field Added 25-04-2019';
            Editable = false;

        }
        field(50019; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            TableRelation = "Subject Classification-CS".Code;
        }
        field(50020; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50021; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50022; "Modified By"; Code[30])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50023; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50024; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            Editable = false;
            OptionCaption = 'Open,Released,Published';
            OptionMembers = Open,Released,Published;
        }
        field(50025; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50026; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50027; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code", "Exam Group")
        {
        }
        key(Key3; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Delete Data from Table::CSPL-00092::20-04-2019: Start
        SessionalExamGroupLineCS1.Reset();
        SessionalExamGroupLineCS1.SETRANGE("Document No.", "No.");
        SessionalExamGroupLineCS1.DELETEALL();
        //Code added for Delete Data from Table::CSPL-00092::20-04-2019: End
    end;

    trigger OnInsert()
    begin
        //Code added for No series And Assign Value in Fields::CSPL-00092::20-04-2019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Internal Exam Group No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        Inserted := true;
        //Code added for No series And Assign Value in Fields::CSPL-00092::20-04-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::20-04-2019: Start
        SessionalExamGroupLineCS.Reset();
        SessionalExamGroupLineCS.SETRANGE("Document No.", "No.");
        IF SessionalExamGroupLineCS.FINDFIRST() THEN
            //  ERROR(Text000Lbl);

            "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();

        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Fields::CSPL-00092::20-04-2019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";

        SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        CourseMasterCS: Record "Course Master-CS";
        SessionalExamGroupLineCS1: Record "Sessional Exam Group Line-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

        Text002Lbl: Label 'You cant enter the semester for subject type %1.';
        Text003Lbl: Label 'You cant enter a section for subject type %1.';

        Text005Lbl: Label 'Course Subj Ex Group Line already exists.';


    procedure Assistedit(OldCourseSubjExGroupHead: Record "Sessional Exam Group Head-CS"): Boolean
    begin
        WITH SessionalExamGroupHeadCS DO BEGIN
            SessionalExamGroupHeadCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Internal Exam Group No.", OldCourseSubjExGroupHead."No.Series",
            "No.Series")
            THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := SessionalExamGroupHeadCS;
                EXIT(TRUE);
            END;
        END;
    end;
}


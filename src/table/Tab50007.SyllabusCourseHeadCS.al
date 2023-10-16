table 50007 "Syllabus Course Head-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    28-04-2019    OnInsert                    No. Series and  Assign Value in Fields
    // 2         CSPL-00092    28-04-2019    No. - OnValidate        No. Series
    // 3         CSPL-00092    28-04-2019    Course Code - OnValidate    Assign Value in Fields
    // 4         CSPL-00092    28-04-2019    Subject Code - OnLookup     Assign Value in Fields

    Caption = 'Syllabus Course Head-CS';
    DrillDownPageID = 50220;
    LookupPageID = 50220;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No. Series ::CSPL-00092::28-04-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Course Syllabus Header No.");
                    "No.Series" := '';
                END;
                //Code added for No. Series ::CSPL-00092::28-04-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields ::CSPL-00092::28-04-2019: Start
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "Course Code");
                IF CourseMasterCS.FindFirst() THEN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                "Type Of Course" := CourseMasterCS."Type Of Course";
                "Academic Year" := CourseMasterCS."Academic Year";
                //Code added for Assign Value in Fields ::CSPL-00092::28-04-2019: End
            end;
        }
        field(3; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";

            trigger OnLookup()
            begin
                //Code added for Assign Value in Fields ::CSPL-00092::28-04-2019: Start
                IF "Type Of Course" = "Type Of Course"::Semester THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, "Semester Code");
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN
                        "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                END;

                IF "Type Of Course" = "Type Of Course"::Year THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Year, Year);
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN
                        "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                END;
                //Code added for Assign Value in Fields ::CSPL-00092::28-04-2019: End
            end;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Typr of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048922; Department; Code[20])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            Enabled = false;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
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
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::28-04-2019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Course Syllabus Header No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Course Syllabus Header No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::28-04-2019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";


        SyllabusCourseHeadCS: Record "Syllabus Course Head-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CourseMasterCS: Record "Course Master-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

    procedure Assistedit(OldCourseSyllabusHeader: Record "Syllabus Course Head-CS"): Boolean
    begin
        WITH SyllabusCourseHeadCS DO BEGIN
            SyllabusCourseHeadCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Course Syllabus Header No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Course Syllabus Header No.", OldCourseSyllabusHeader."No.Series",
           "No.Series")
           THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := SyllabusCourseHeadCS;
                EXIT(TRUE);
            END;
        END;
    end;
}


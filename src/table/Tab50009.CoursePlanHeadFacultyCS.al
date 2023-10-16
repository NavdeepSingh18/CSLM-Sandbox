table 50009 "Course Plan Head Faculty-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                         Remarks
    // 1         CSPL-00092    30-04-2019    OnInsert                        No. Series and  Assign Value in Fields
    // 2         CSPL-00092    30-04-2019    No. - OnValidate                No. Series
    // 3         CSPL-00092    30-04-2019    Course Code - OnValidate      Assign Value in Fields
    // 4         CSPL-00092    30-04-2019    Subject Code - OnValidate     Assign Value in Fields

    Caption = 'Course Plan Head Faculty';
    DrillDownPageID = 50221;
    LookupPageID = 50221;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;


            trigger OnValidate()
            begin
                //Code added for No. Series::CSPL-00092::30-04-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Faculty Scheme Planning No.");
                    "No.Series" := '';
                END;
                //Code added for No. Series::CSPL-00092::30-04-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::30-04-2019: Start
                "CourseMasterCS".Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "Course Code");
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Academic Year" := CourseMasterCS."Academic Year";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::30-04-2019: End
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

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::30-04-2019: Start
                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Subject Code", "Subject Code");
                IF CourseWiseSubjectLineCS.FindFirst() THEN
                    "Course Code" := CourseWiseSubjectLineCS."Course Code";
                "Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                "Semester Code" := CourseWiseSubjectLineCS.Semester;
                Year := CourseWiseSubjectLineCS.Year;
                VALIDATE("Course Code");
                //Code added for Assign Value in Fields::CSPL-00092::30-04-2019: End
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
        field(7; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(8; "Plan Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Applied,Approved,Rejected';
            OptionMembers = " ",Applied,Approved,Rejected;
        }
        field(9; Comments; Text[50])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(10; "Total Week Hours"; Integer)
        {
            Caption = 'Total Week Hours';
            DataClassification = CustomerContent;
        }
        field(11; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(12; "Perc Completed"; Decimal)
        {
            Caption = 'Perc Completed';
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
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Semester,Year';
            DataClassification = CustomerContent;
            OptionMembers = " ",Semester,Year;
        }
        field(50014; Year; Code[20])
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
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(33048923; Group; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Group Student-CS"."Group Code" WHERE("Course" = FIELD("Course Code"));
        }
        field(33048924; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Batch of Student-CS"."Batch Code" WHERE(Course = FIELD("Course Code"));
        }
        field(33048925; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", "Semester Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::30-04-2019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Faculty Scheme Planning No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Faculty Scheme Planning No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;

        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::30-04-2019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        CoursePlanHeadFacultyCS: Record "Course Plan Head Faculty-CS";

        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CourseMasterCS: Record "Course Master-CS";

        NoSeriesManagement: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

    procedure Assistedit(OldFacultySchemePlanHeader: Record "Course Plan Head Faculty-CS"): Boolean
    begin
        WITH CoursePlanHeadFacultyCS DO BEGIN
            CoursePlanHeadFacultyCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Course Syllabus Header No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Course Syllabus Header No.", OldFacultySchemePlanHeader."No.Series",
            "No.Series")
            THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := CoursePlanHeadFacultyCS;
                EXIT(TRUE);
            END;
        END;
    end;
}


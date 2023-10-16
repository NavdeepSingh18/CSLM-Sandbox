table 50008 "Syllabus Course Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    28-04-2019    OnInsert                    Assign Value in Fields
    // 2         CSPL-00092    28-04-2019    Unit Code - OnValidate      Assign Value in Unit Name Field
    // 3         CSPL-00092    28-04-2019    Chapter Code - OnValidate   Validate and Assign Value in Chapter Name Field
    // 4         CSPL-00092    28-04-2019    Unit Name - OnValidate      Assign Value in Unit Name Field

    Caption = 'Course Syllabus Line - COL';
    DrillDownPageID = 50215;
    LookupPageID = 50215;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(4; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(6; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            DataClassification = CustomerContent;
            TableRelation = "Unit Master-CS" WHERE("Course Code" = FIELD("Course Code"),
                                                    Subject = FIELD("Subject Code"));

            trigger OnValidate()
            begin
                //Code added for Assign Value in Unit Name Field::CSPL-00092::28-04-2019: Start
                "Unit Name" := '';
                UnitMasterCS.Reset();
                UnitMasterCS.SETRANGE(UnitMasterCS.Code, "Unit Code");
                IF UnitMasterCS.FindFirst() THEN
                    "Unit Name" := UnitMasterCS.Description;
                //Code added for Assign Value in Unit Name Field::CSPL-00092::28-04-2019: End
            end;
        }
        field(7; "Chapter Code"; Code[20])
        {
            Caption = 'Chapter Code';
            DataClassification = CustomerContent;
            TableRelation = "Lesson Master-CS" WHERE("Unit Code" = FIELD("Unit Code"));

            trigger OnValidate()
            begin
                //Code added for Validate and Assign Value in Chapter Name Field::CSPL-00092::28-04-2019: Start
                SyllabusCourseLineCS.Reset();
                SyllabusCourseLineCS.SETRANGE("Document No.", "Document No.");
                SyllabusCourseLineCS.SETFILTER("Line No.", '<>%1', "Line No.");
                SyllabusCourseLineCS.SETRANGE("Unit Code", "Unit Code");
                SyllabusCourseLineCS.SETRANGE("Chapter Code", "Chapter Code");
                IF SyllabusCourseLineCS.FINDFIRST() THEN
                    ERROR('%1 already exists', "Chapter Code");

                "Chapter Name" := '';
                LessonMasterCS.Reset();
                LessonMasterCS.SETRANGE(LessonMasterCS.Code, "Chapter Code");
                IF LessonMasterCS.FindFirst() THEN
                    "Chapter Name" := LessonMasterCS.Description;
                //Code added for Validate and Assign Value in Chapter Name Field::CSPL-00092::28-04-2019: End
            end;
        }
        field(8; "Chapter Name"; Text[250])
        {
            Caption = 'Chapter Name';
            DataClassification = CustomerContent;
        }
        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(10; "No of Hours"; Integer)
        {
            Caption = 'No of Hours';
            DataClassification = CustomerContent;
        }
        field(11; "Unit Name"; Text[100])
        {
            Caption = 'Unit Name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Unit Name Field::CSPL-00092::28-04-2019: Start
                SyllabusCourseLineCS.Reset();
                SyllabusCourseLineCS.SETRANGE("Document No.", "Document No.");
                SyllabusCourseLineCS.SETFILTER("Line No.", '<>%1', "Line No.");
                SyllabusCourseLineCS.SETRANGE("Unit Code", "Unit Code");
                SyllabusCourseLineCS.SETFILTER("Unit Name", '<>%1', '');
                IF SyllabusCourseLineCS.FINDFIRST() THEN
                    "Unit Name" := SyllabusCourseLineCS."Unit Name"
                //ELSE
                //   "Unit Name" := '';
                //Code added for Assign Value in Unit Name Field::CSPL-00092::28-04-2019: End
            end;
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
            Caption = 'Type Of Course';
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
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", "Course Code", "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::28-04-2019: Start
        IF SyllabusCourseHeadCS.GET("Document No.") THEN BEGIN
            "Course Code" := SyllabusCourseHeadCS."Course Code";
            "Global Dimension 1 Code" := SyllabusCourseHeadCS."Global Dimension 1 Code";
            "Semester Code" := SyllabusCourseHeadCS."Semester Code";
            "Subject Code" := SyllabusCourseHeadCS."Subject Code";
            "Academic Year" := VerticalEducationCS.CreateSessionYear();
            "User ID" := FORMAT(UserId());
        END;
        //Code added for Assign Value in Fields::CSPL-00092::28-04-2019: End
    end;

    var
        SyllabusCourseHeadCS: Record "Syllabus Course Head-CS";

        SyllabusCourseLineCS: Record "Syllabus Course Line-CS";
        UnitMasterCS: Record "Unit Master-CS";
        LessonMasterCS: Record "Lesson Master-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


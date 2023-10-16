table 50018 "Course Plan Line Faculty-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    30-04-2019    OnInsert                    Assign Value in Fields
    // 2         CSPL-00092    30-04-2019    Unit Code - OnValidate      Assign Value in Unit Name Fields
    // 3         CSPL-00092    30-04-2019    Chapter Code - OnValidate   Assign Value in Chapter Name Fields
    // 4         CSPL-00092    30-04-2019    Work Status - OnValidate    Faculty Cource Plan

    Caption = 'Course Plan Line Faculty';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
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
            TableRelation = "Unit Master-CS" WHERE(Subject = FIELD("Subject Code"));

            trigger OnValidate()
            begin
                //Code added for Assign Value in Unit Name Fields::CSPL-00092::30-04-2019: Start
                UnitMasterCS.RESET();
                UnitMasterCS.SETRANGE(Subject, "Subject Code");
                UnitMasterCS.SETRANGE(Code, "Unit Code");
                IF UnitMasterCS.FindFirst() THEN
                    "Unit Name" := UnitMasterCS.Description;
                //Code added for Assign Value in Unit Name Fields::CSPL-00092::30-04-2019: End
            end;
        }
        field(7; "Chapter Code"; Code[20])
        {
            Caption = 'Chapter Code';
            TableRelation = "Lesson Master-CS" WHERE("Unit Code" = FIELD("Unit Code"),
                                                      Subject = FIELD("Subject Code"));

            trigger OnValidate()
            begin
                //Code added for Assign Value in Chapter Name Fields::CSPL-00092::30-04-2019: Start
                LessonMasterCS.RESET();
                LessonMasterCS.SETRANGE("Unit Code", "Unit Code");
                LessonMasterCS.SETRANGE(Subject, "Subject Code");
                LessonMasterCS.SETRANGE(Code, "Chapter Code");
                IF LessonMasterCS.FindFirst() THEN
                    "Chapter Name" := LessonMasterCS.Description;
                //Code added for Assign Value in Chapter Name Fields::CSPL-00092::30-04-2019: End
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
        field(10; Week; Integer)
        {
            Caption = 'Week';
            DataClassification = CustomerContent;
        }
        field(11; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(12; "Unit Name"; Text[100])
        {
            Caption = 'Unit Name';
            DataClassification = CustomerContent;
        }
        field(13; Period; Integer)
        {
            Caption = 'Period';
            DataClassification = CustomerContent;
        }
        field(14; "No of Minuites"; Integer)
        {
            Caption = 'No of Minuites';
            DataClassification = CustomerContent;
        }
        field(15; "Learning OutCome"; Text[50])
        {
            Caption = 'Learning OutCome';
            DataClassification = CustomerContent;
        }
        field(16; Assesment; Text[30])
        {
            Caption = 'Assesment';
            DataClassification = CustomerContent;
        }
        field(17; "Work Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Not Completed,Completed';
            OptionMembers = " ","Not Completed",Completed;

            trigger OnValidate()
            begin
                //Code added for faculty Cource Plan::CSPL-00092::30-04-2019: Start
                TotalCount := 0;
                TotalCompleted := 0;
                CoursePlanLineFacultyCS.RESET();
                CoursePlanLineFacultyCS.SETRANGE("Document No.", "Document No.");
                IF CoursePlanLineFacultyCS.FINDSET() THEN
                    REPEAT
                        TotalCount += CoursePlanLineFacultyCS."No of Minuites";
                    UNTIL CoursePlanLineFacultyCS.NEXT() = 0;

                CoursePlanLineFacultyCS.RESET();
                CoursePlanLineFacultyCS.SETRANGE("Document No.", "Document No.");
                CoursePlanLineFacultyCS.SETRANGE("Work Status", CoursePlanLineFacultyCS."Work Status"::Completed);
                IF CoursePlanLineFacultyCS.FINDSET() THEN
                    REPEAT
                        TotalCompleted += CoursePlanLineFacultyCS."No of Minuites";
                    UNTIL CoursePlanLineFacultyCS.NEXT() = 0;

                IF "Work Status" = "Work Status"::Completed THEN
                    TotalCompleted := TotalCompleted + "No of Minuites"
                ELSE
                    TotalCompleted := TotalCompleted - "No of Minuites";

                CoursePlanHeadFacultyCS.GET("Document No.");

                IF (TotalCount <> 0) AND (TotalCompleted <> 0) THEN
                    CoursePlanHeadFacultyCS."Perc Completed" := (TotalCompleted / TotalCount) * 100
                ELSE
                    CoursePlanHeadFacultyCS."Perc Completed" := 0;

                CoursePlanHeadFacultyCS.Modify();
                //Code added for faculty Cource Plan::CSPL-00092::30-04-2019: End
            end;
        }
        field(18; "Scheduled Date"; Date)
        {
            Caption = 'Scheduled Date';
            DataClassification = CustomerContent;
        }
        field(19; "Actual Date"; Date)
        {
            Caption = 'Actual Date';
            DataClassification = CustomerContent;
        }
        field(20; "Section Code"; Code[20])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(21; "Faculty Department"; Code[20])
        {
            Caption = 'Faculty Department';
            Editable = false;
            Enabled = false;

        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50015; Topics; Text[250])
        {
            Caption = 'Topics';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
        }
        field(50016; Status; Integer)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048922; Group; Code[20])
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
            TableRelation = "Group Student-CS"."Group Code" WHERE(Course = FIELD("Course Code"));
        }
        field(33048923; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
            TableRelation = "Batch of Student-CS"."Batch Code";
        }
        field(33048924; Approve; Boolean)
        {
            Caption = 'Approve';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Subject Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::30-04-2019: Start
        IF CoursePlanHeadFacultyCS.GET("Document No.") THEN BEGIN
            "Course Code" := CoursePlanHeadFacultyCS."Course Code";
            "Semester Code" := CoursePlanHeadFacultyCS."Semester Code";
            "Subject Code" := CoursePlanHeadFacultyCS."Subject Code";
            "Academic Year" := VerticalEducationCS.CreateSessionYear();
            "Section Code" := CoursePlanHeadFacultyCS.Section;
            "Faculty Code" := CoursePlanHeadFacultyCS."Faculty Code";
            "Global Dimension 1 Code" := CoursePlanHeadFacultyCS."Global Dimension 1 Code";
            "User ID" := FORMAT(UserId());
        END;
        //Code added for Assign Value in Fields::CSPL-00092::30-04-2019: End
    end;

    var
        CoursePlanHeadFacultyCS: Record "Course Plan Head Faculty-CS";

        CoursePlanLineFacultyCS: Record "Course Plan Line Faculty-CS";
        UnitMasterCS: Record "Unit Master-CS";
        LessonMasterCS: Record "Lesson Master-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        TotalCount: Integer;
        TotalCompleted: Integer;

}


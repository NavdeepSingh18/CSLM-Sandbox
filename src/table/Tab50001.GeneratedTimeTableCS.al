table 50001 "Generated Time Table-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    28-04-2019    OnInsert                    User Id Assign in User Id Field.
    // 2         CSPL-00092    28-04-2019    Course Code - OnValidate    Assign Value in Fields
    // 3         CSPL-00092    28-04-2019    Subject Code - OnValidate   Assign Value in Subject Description Field
    // 4         CSPL-00092    28-04-2019    Subject Code - OnLookup     Assign value in Fields
    // 5         CSPL-00092    28-04-2019    Faculty Code - OnValidate   Assign Value in Faculty Name Field

    Caption = 'Generated Time Table-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::28-04-2019: Start
                CourseMasterCS.RESET();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "Course Code");
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Academic Year" := CourseMasterCS."Academic Year";
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::28-04-2019: End
            end;
        }
        field(3; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(4; "Day No"; Integer)
        {
            Caption = 'Day No';
            DataClassification = CustomerContent;
        }
        field(5; "Hour No"; Integer)
        {
            Caption = 'Hour No';
            DataClassification = CustomerContent;
        }
        field(6; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = "Subject Master-CS";
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::28-04-2019: Start
                CourseWiseSubjectLineCS.RESET();
                CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS.Semester, "Semester Code");
                IF CourseWiseSubjectLineCS.FINDFIRST() THEN
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                        "Subject Description" := CopyStr(CourseWiseSubjectLineCS.Description, 1, MaxStrLen("Subject Description"));
                        "Subject Classification" := CourseWiseSubjectLineCS."Subject Classification";
                    END;
                //Code added for Assign Value in Fields::CSPL-00092::28-04-2019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Subject Description Field::CSPL-00092::28-04-2019: Start
                SubjectMasterCS.RESET();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "Subject Code");
                IF SubjectMasterCS.FindFirst() THEN
                    "Subject Description" := CopyStr(SubjectMasterCS.Description, 1, MaxStrLen("Subject Description"));
                //Code added for Assign Value in Subject Description Field::CSPL-00092::28-04-2019: End
            end;
        }
        field(7; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            TableRelation = "Employee";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Faculty Name Field::CSPL-00092::28-04-2019: Start
                IF Employee.GET("Faculty Code") THEN
                    "Faculty Name" := CopyStr(Employee."First Name" + Employee."Middle Name" + Employee."Last Name", 1, MaxStrLen("Faculty Name"))
                ELSE
                    "Faculty Name" := '';
                //Code added for Assign Value in Faculty Name Field::CSPL-00092::28-04-2019: End
            end;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
        }
        field(9; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;
        }
        field(10; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            TableRelation = "Subject Type-CS";
            DataClassification = CustomerContent;
        }
        field(11; "Faculty Name"; Text[30])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
        }
        field(12; "Subject Description"; Text[80])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 30-05-2019';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 30-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            Description = 'CS Field Added 30-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            DataClassification = CustomerContent;
        }
        field(50014; Year; Code[20])
        {
            Description = 'CS Field Added 30-05-2019';
            TableRelation = "Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(50015; "Time Duration"; Code[20])
        {
            Description = 'CS Field Added 30-05-2019';
            Caption = 'Time Duration';
        }
        field(50016; "Room Allocation"; Code[20])
        {
            Description = 'CS Field Added 30-05-2019';
            Caption = 'Room Allocation';
            TableRelation = "Exam Room Allocation-CS"."Room No." WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"),
                                                                        Course = FIELD("Course Code"),
                                                                        Semester = FIELD("Semester Code"),
                                                                        Year = FIELD(Year));
        }
        field(50017; "Subject Classification"; Code[20])
        {
            Caption = 'Subject Classification';
            Description = 'CS Field Added 30-05-2019';
            TableRelation = "Subject Classification-CS";
            DataClassification = CustomerContent;
        }
        field(50018; "Attendance Date"; Date)
        {
            Description = 'CS Field Added 30-05-2019';
            Caption = 'Attendance Date';
            DataClassification = CustomerContent;
        }
        field(50019; "Substitute Faculty Code"; Code[20])
        {
            Description = 'CS Field Added 30-05-2019';
            TableRelation = "Employee";
            Caption = 'Substitute Faculty Code';
            DataClassification = CustomerContent;
        }
        field(50020; "Substitute Faculty Name"; Text[30])
        {
            Description = 'CS Field Added 30-05-2019';
            Caption = 'Substitute Faculty Name';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 30-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 30-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048922; Group; Code[20])
        {
            Description = 'CS Field Added 30-05-2019';
            Caption = 'Group';
            TableRelation = "Group Student-CS"."Group Code" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(33048923; Batch; Code[20])
        {
            Description = 'CS Field Added 30-05-2019';
            Caption = 'Batch';
            DataClassification = CustomerContent;
            TableRelation = "Batch of Student-CS"."Batch Code" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Day No", "Hour No", "Subject Code")
        {
        }
        key(Key2; "Course Code", "Semester Code")
        {
        }
        key(Key3; "Course Code", "Semester Code", "Day No", "Hour No", "Subject Code")
        {
        }
        key(Key4; "Day No", "Hour No", "Faculty Code")
        {
        }
        key(Key5; "Course Code", "Semester Code", "Subject Code", "Faculty Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Dropdown; "Day No")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::28-04-2019: Start
        "User ID" := CopyStr(USERID(), 1, MaxStrLen("User ID"));
        //Code added for User Id Assign in User Id Field::CSPL-00092::28-04-2019: End
    end;

    var

        Employee: Record "Employee";
        SubjectMasterCS: Record "Subject Master-CS";
        CourseMasterCS: Record "Course Master-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
}


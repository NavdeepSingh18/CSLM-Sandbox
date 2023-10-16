table 50314 "Re-Appear Exam Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   29/08/2019       OnInsert()                                 Auto "User Id" Assign
    // 02    CSPL-00114   29/08/2019       OnDelete()                                 Code added for Student name

    Caption = 'Re-Appear Exam Line-CS';


    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student name::CSPL-00114::29082019: Start
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name"
                ELSE
                    "Student Name" := '';
                //Code added for Student name::CSPL-00114::29082019: Start
            end;
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(7; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(8; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(13; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Present,Absent,On Duty,Leave';
            OptionMembers = " ",Present,Absent,"On Duty",Leave;
        }
        field(21; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(23; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
        }
        field(24; "Attendance Percentage"; Decimal)
        {
            Caption = 'Attendance Percentage';
            DataClassification = CustomerContent;
        }
        field(25; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Attendance % as on Date"; Date)
        {
            Caption = 'Attendance % as on Date';
            DataClassification = CustomerContent;
        }
        field(31; "Attendance Detail"; Text[80])
        {
            Caption = 'Attendance Detail';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
        {
            SumIndexFields = Points;
        }
        key(Key2; Course, Semester, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; Course, Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key4; "Student No.", Semester, Section)
        {
        }
        key(Key5; Course, Semester, Section, "Academic Year")
        {
        }
        key(Key6; "Student No.", Course, Semester, Section, "Subject Type", "Subject Code")
        {
        }
        key(Key7; Course, "Academic Year", Semester, "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Auto "User Id" Assign::CSPL-00114::29082019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto "User Id" Assign::CSPL-00114::29082019: End
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
}


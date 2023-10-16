table 50117 "Branch Information Stud-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                   Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   25/07/2019       Student No. - OnValidate()                Code added for Get Student Enrollment No
    // 02    CSPL-00114   25/07/2019       New Course Code - OnValidate()            Code added for Get Course Description

    Caption = 'Branch Information Stud-CS';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Get Student Enrollment No::CSPL-00114::25072019: Start
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", "Student No.");
                IF StudentMasterCS.FindFirst() THEN
                    "Enrollment No." := StudentMasterCS."Enrollment No."
                ELSE
                    "Enrollment No." := '';

                //Code added for Get Student Enrollment No::CSPL-00114::25072019: End
            end;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(3; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(5; "New Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Get Course Description::CSPL-00114::25072019: Start
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "New Course Code");
                IF CourseMasterCS.FindFirst() THEN
                    "New Course Description" := CourseMasterCS.Description
                ELSE
                    "New Course Description" := '';

                //Code added for Get Course Description::CSPL-00114::25072019: End
            end;
        }
        field(6; "New Course Description"; Text[100])
        {
            Caption = 'New Course Description';
            DataClassification = CustomerContent;
        }
        field(7; Category; Code[10])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";
        }
        field(8; "Portal User ID"; Code[20])
        {
            Caption = 'Portal User ID';
            DataClassification = CustomerContent;
        }
        field(9; "Branch Transfer Compleated"; Boolean)
        {
            Caption = 'Branch Transfer Completed';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CourseMasterCS: Record "Course Master-CS";
        StudentMasterCS: Record "Student Master-CS";
}


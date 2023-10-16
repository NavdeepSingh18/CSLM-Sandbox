table 50306 "Re-Appear Exam-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date                  Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   27/04/2019       Student No - OnValidate()                        Get Student Name from Student Master

    Caption = 'Re-Appear Exam-CS';

    fields
    {
        field(1; "Student No"; Code[20])
        {
            Caption = 'Student No';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Student Master-CS"."No.";

            trigger OnValidate()
            begin
                //Code added for Student Name from Student Master::CSPL-00114::27042019: Start
                StudentMasterCS.Reset();
                IF StudentMasterCS.GET("Student No") THEN
                    "Student Name" := StudentMasterCS."Student Name";
                //Code added for Student Name from Student Master::CSPL-00114::27042019: End
            end;
        }
        field(2; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Academic Year Master-CS";
        }
        field(4; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Course Master-CS";
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Semester Master-CS";
        }
        field(6; "Re-Appear Exam Form"; Boolean)
        {
            Caption = 'Re-Appear Exam Form';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        StudentMasterCS: Record "Student Master-CS";
}


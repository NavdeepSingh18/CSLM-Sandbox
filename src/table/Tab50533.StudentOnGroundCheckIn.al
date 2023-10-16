table 50533 StudentOnGroundCheckIn
{
    DataClassification = CustomerContent;
    Caption = 'Student On Ground Check In';

    fields
    {
        field(1; StudentNo; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            Caption = 'Student No.';
        }
        field(5; StudentName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."Student Name" where("No." = field(StudentNo)));
            Caption = 'Student Name';
            Editable = false;
        }
        field(6; Status; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".Status where("No." = field(StudentNo)));
            Caption = 'Status';
            Editable = false;
        }
        field(7; OLRCompleted; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."OLR Completed" where("No." = field(StudentNo)));
            Caption = 'OLR Completed';
            Editable = false;
        }
        field(8; OLRCompletedDate; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."OLR Completed Date" where("No." = field(StudentNo)));
            Caption = 'OLR Completed Date';
            Editable = false;
        }
        field(9; StudentOnGroundGroup; Option)
        {
            OptionMembers = " ","On-Ground Check-In","On-Ground Check-In Completed";
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."Student Group" where("No." = field(StudentNo)));
            Caption = 'Student On Ground Group';
            Editable = false;
        }

        field(10; "On Ground Check-In On"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."On Ground Check-In On" where("No." = field(StudentNo)));
            Caption = 'On Ground Check-In On';
            Editable = false;
        }
        field(11; "On Ground ChkIn Completed On"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."On Ground Check-In Complete On" where("No." = field(StudentNo)));
            Caption = 'On Ground Check-In Completed On';
            Editable = false;
        }

        field(15; "OLR Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "OLR Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "OLR Term"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(18; Confirmed; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

    }

    keys
    {
        key(Key1; StudentNo, "OLR Academic Year", "OLR Term")
        {
            Clustered = true;
        }
    }
}
table 50304 "Award Line-CS"
{
    // version V.001-CS

    Caption = 'Award Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(5; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Fee Generated"; Boolean)
        {
            Caption = 'Fee Generated';
            DataClassification = CustomerContent;
        }
        field(8; "Generate Admit Card"; Boolean)
        {
            Caption = 'Generate Admit Card';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No")
        {
        }
        key(Key2; "Course Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}


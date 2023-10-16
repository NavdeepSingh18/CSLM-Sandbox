table 50384 "Student Course Subject Buffer"
{
    Caption = 'Student Course Subject Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
        field(4; Term; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(5; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }

        field(8; "Semester"; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(9; "SLcM Subject Code"; Code[20])
        {
            Caption = 'SLcM Subject Code';
            DataClassification = CustomerContent;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(Key1; "Student No.", "Course Code", Semester, "Academic Year", "Subject Code", Section, "SLcM Subject Code")
        {
            Clustered = true;
        }
    }

}

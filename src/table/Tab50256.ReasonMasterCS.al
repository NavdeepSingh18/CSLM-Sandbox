table 50256 "Reason Master-CS"
{
    // version V.001-CS

    Caption = 'Reason Master-CS';

    fields
    {
        field(1; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
        }
        field(2; "Reason Description"; Text[100])
        {
            Caption = 'Reason Description';
            DataClassification = CustomerContent;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(5; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(6; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(7; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(8; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(9; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
        field(10; "Reason Type"; Option)
        {
            Caption = 'Reason Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Class Attendance","Sessional Exam","End Semester Exam";
        }
    }

    keys
    {
        key(Key1; "Reason Code")
        {
        }
    }

    fieldgroups
    {
    }
}


table 50216 "Promotion Criteria-CS"
{
    // version V.001-CS

    Caption = 'Promotion Criteria-CS';
    //DrillDownPageID = 33049493;
    //LookupPageID = 33049493;

    fields
    {
        field(1; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(3; Year; Code[10])
        {
            caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; Graduation; Code[10])
        {
            caption = 'Graduation';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS";
        }
        field(6; "Minimum Credit"; Decimal)
        {
            caption = 'Minimum Credit';
            DataClassification = CustomerContent;
        }
        field(7; "Type Of Course"; Option)
        {
            caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(8; "Lateral Credit"; Decimal)
        {
            caption = 'Lateral Credit';
            DataClassification = CustomerContent;
        }
        field(9; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(10; "Minimum Passing %"; Decimal)
        {
            caption = 'Minimum Passing %';
            DataClassification = CustomerContent;
        }
        field(11; "Maximum Passing %"; Decimal)
        {
            caption = 'Maximum Passing %';
            DataClassification = CustomerContent;
        }
        field(12; "Passing Input Point %"; Decimal)
        {
            caption = 'Passing Input Point %';
            DataClassification = CustomerContent;
        }
        field(13; "Adjusted Input Point %"; Decimal)
        {
            caption = 'Adjusted Passing %';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22062019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22062019';
        }
    }

    keys
    {
        key(Key1; Course, Semester, Year, "Academic Year", Graduation)
        {
        }
    }

    fieldgroups
    {
    }
}


table 50096 "Grade Course-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    20-05-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Grade Course-CS';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Max Percentage"; Decimal)
        {
            Caption = 'Max Percentage';
            DataClassification = CustomerContent;
        }
        field(4; "Min Percentage"; Decimal)
        {
            Caption = 'Min Percentage';
            DataClassification = CustomerContent;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; Points; Decimal)
        {
            Caption = 'Points';
        }
        field(7; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 21-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 21-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 21-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 21-05-2019';
        }
    }

    keys
    {
        key(Key1; Course, "Code", "Academic Year")
        {
        }
        key(Key2; Points)
        {
        }
        key(Key3; Course, Points)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::20-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::20-05-2019: End
    end;

    var
}


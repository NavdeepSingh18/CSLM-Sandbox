table 50091 "Attend Percentage Setup-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    20-04-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Attend Percentage Setup-CS';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Minimum Attendance %"; Decimal)
        {
            Caption = 'Minimum Attendance %';
            DataClassification = CustomerContent;
        }
        field(3; "Maximum Attendance %"; Decimal)
        {
            Caption = 'Maximum Attendance %';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; "Repeat Exam"; Boolean)
        {
            Caption = 'Repeat';
            DataClassification = CustomerContent;
        }
        field(6; Eligible; Boolean)
        {
            Caption = 'Eligible';
            DataClassification = CustomerContent;
        }
        field(7; Mark; Decimal)
        {
            Caption = 'Mark';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-04-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-04-2019';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Mark)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::20-04-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::20-04-2019: End
    end;
}


table 50224 "Percentage Quota-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    11-05-2019    OnInsert                            Assign Value in User ID Field.

    Caption = 'Percentage Quota-CS';

    fields
    {
        field(1; "Qutoa Code"; Code[20])
        {
            Caption = 'Qutoa Code';
            DataClassification = CustomerContent;
            TableRelation = "External Attendance Header-CS";
        }
        field(2; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;
        }
        field(3; Numofseat; Integer)
        {
            Caption = 'Numofseat';
            DataClassification = CustomerContent;
        }
        field(4; "Round of Compensation"; Boolean)
        {
            Caption = 'Round of Compensation';
            DataClassification = CustomerContent;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Order"; Integer)
        {
            Caption = 'Order';
            DataClassification = CustomerContent;
        }
        field(8; "Open Competition"; Boolean)
        {
            Caption = 'Open Competition';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
    }

    keys
    {
        key(Key1; "Qutoa Code")
        {
        }
        key(Key2; "Order")
        {
        }
        key(Key3; "Round of Compensation")
        {
        }
        key(Key4; "Open Competition")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in User ID Field::CSPL-00092::11-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Assign Value in User ID Field::CSPL-00092::11-05-2019: End
    end;

    var

}


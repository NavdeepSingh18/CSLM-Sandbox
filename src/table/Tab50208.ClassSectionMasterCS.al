table 50208 "Class Section Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    06-05-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Class Section Master-CS';
    //DrillDownPageID = 33049265; chandrabhan   
    //LookupPageID = 33049265; chandrabhan

    fields
    {
        field(1; Class; Code[20])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            SQLDataType = Integer;
        }
        field(2; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Class Time Table Header-CS";
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
        }
        field(5; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            DataClassification = CustomerContent;
        }
        field(22; Capacity; Decimal)
        {
            Caption = 'Capacity';
            DecimalPlaces = 0 : 0;
        }
        field(23; "Present Strength"; Integer)
        {
            Caption = 'Present Strength';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Marks System"; Option)
        {
            Caption = 'Marks System';
            OptionCaption = 'Marks,Grade';
            OptionMembers = Marks,Grade;
        }
        field(25; "Promotion Percentage"; Decimal)
        {
            Caption = 'Promotion Percentage';
            DataClassification = CustomerContent;
        }
        field(26; Promoted; Boolean)
        {
            Caption = 'Promoted';
            DataClassification = CustomerContent;
        }
        field(29; "Consolidated Grades"; Option)
        {
            Caption = 'Consolidated Grades';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Points,Marks';
            OptionMembers = " ",Points,Marks;
        }
        field(30; "Class Teacher"; Code[20])
        {
            Caption = 'Class Teacher';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(31; "Home Work Duration"; Decimal)
        {
            Caption = 'Home Work Duration';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
        }
    }

    keys
    {
        key(Key1; "Class Code")
        {
        }
        key(Key2; Class, Curriculum, "Academic Year")
        {
            SumIndexFields = Capacity;
        }
        key(Key3; Class)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::06-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::06-05-2019: End
    end;

    var

}


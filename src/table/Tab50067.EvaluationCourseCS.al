table 50067 "Evaluation Course-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    21-01-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Evaluation Course-CS';
    DrillDownPageID = 50258;
    LookupPageID = 50258;

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            TableRelation = "Student Extension New-CS";
            DataClassification = CustomerContent;
        }
        field(3; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            DataClassification = CustomerContent;
        }
        field(4; "Pass Mark"; Decimal)
        {
            Caption = 'Pass Mark';
            DataClassification = CustomerContent;
        }
        field(5; Compulsory; Boolean)
        {
            Caption = 'Compulsory';
            DataClassification = CustomerContent;
        }
        field(6; "Int Evaluation Date"; Date)
        {
            Caption = 'Int Evaluation Date';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 28-01-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 28-01-2019';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Course Code", "Evaluation Method Code")
        {
        }
        key(Key2; "Course Code", Compulsory)
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::21-01-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::21-01-2019: End
    end;
}


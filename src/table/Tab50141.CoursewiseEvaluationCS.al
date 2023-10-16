table 50141 "Course wise Evaluation-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   29/05/2019       OnInsert()                             Auto assign User ID

    Caption = 'Course wise Evaluation-CS';
    DrillDownPageID = 50258;
    LookupPageID = 50258;

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Student Extension New-CS";
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
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29052019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29052019';
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

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Auto assign User ID::CSPL-00114::29052019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto assign User ID::CSPL-00114::29052019: End
    end;
}


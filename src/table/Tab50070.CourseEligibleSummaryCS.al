table 50070 "Course Eligible Summary-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date            Trigger                 Remarks
    // 1         CSPL-00092    26-01-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Course Eligible Summary-CS';
    DrillDownPageID = 50267;
    LookupPageID = 50267;

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "List No."; Integer)
        {
            Caption = 'List No.';
            DataClassification = CustomerContent;
        }
        field(4; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = IF (Type = FILTER(Evaluation)) "Student Extension New-CS"
            ELSE
            IF (Type = FILTER(Category)) "Category Master-CS"
            ELSE
            IF (Type = FILTER("Prequalification Subjects")) "Due Clearance-CS";
            DataClassification = CustomerContent;
        }
        field(5; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;
        }
        field(6; "Order Number"; Integer)
        {
            Caption = 'Order Number';
            DataClassification = CustomerContent;
        }
        field(9; "Course Line No."; Integer)
        {
            Caption = 'Course Line No.';
            DataClassification = CustomerContent;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Evaluation,Category,Prequalification Subjects';
            OptionMembers = " ",Evaluation,Category,"Prequalification Subjects";
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
        field(50003; Prequalification; Option)
        {
            Description = 'CS Field Added 28-01-2019';
            OptionCaption = ' ,10th,12th,Diploma,Graduation,Post Graduation,Others';
            OptionMembers = " ","10th","12th",Diploma,Graduation,"Post Graduation",Others;
            DataClassification = CustomerContent;
        }
        field(50004; "Check Eligibility"; Boolean)
        {
            Description = 'CS Field Added 28-01-2019';
            DataClassification = CustomerContent;
        }
        field(50005; "Optional Subject"; Text[5])
        {
            Description = 'CS Field Added 28-01-2019';
            DataClassification = CustomerContent;
        }
        field(50006; Stream; Code[20])
        {
            Description = 'CS Field Added 28-01-2019';
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
        key(Key1; "Course Code", "Course Line No.", "Line No.", "List No.", "Code")
        {
        }
        key(Key2; "Course Code", "Course Line No.", "List No.", "Order Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::26-01-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::26-01-2019: End
    end;
}
table 50080 "Course Ranking Summary-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    29-01-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Course Ranking Summary-CS';

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
            TableRelation = IF (Type = FILTER(Evaluation)) "Discipline Level-CS"
            ELSE
            IF (Type = FILTER(Category)) "Room Alloted Line-CS"
            ELSE
            IF (Type = FILTER("Prequalification Subjects")) "Class Assignment Header-CS";
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
            Description = 'CS Field Added 29-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 29-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 29-01-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 29-01-2019';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Course Code", "Course Line No.", "List No.", "Line No.")
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
        //Code added for User Id Assign in User Id Field::CSPL-00092::29-01-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::29-01-2019: End
    end;
}
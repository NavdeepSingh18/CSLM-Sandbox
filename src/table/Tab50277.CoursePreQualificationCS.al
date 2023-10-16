table 50277 "Course Pre-Qualification-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   29/05/2019       OnInsert()                             Auto assign User ID

    Caption = 'Course Prequalification-COL';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

        }
        field(2; "Prequalification Code"; Code[20])
        {
            Caption = 'Prequalification Code';
            DataClassification = CustomerContent;
            TableRelation = "Not Sync Document-CS";
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Ad29d 17052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Ad29d 17052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Ad29d 17052019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Ad29d 17052019';
        }
    }

    keys
    {
        key(Key1; "Course Code", "Prequalification Code")
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


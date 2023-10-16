table 50273 "Stage Selection Detail2-CS"
{
    // version V.001-CS

    // 
    // Sr.No   Emp.ID      Date            Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   29/05/2019       OnInsert()                             Auto assign User ID

    Caption = 'Stage Selection Detail2-CS';


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            TableRelation = "Application-CS";
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(4; "Application Selection"; Boolean)
        {
            Caption = 'Application Selection';
            DataClassification = CustomerContent;
        }
        field(5; "Eligibility Percertage"; Decimal)
        {
            Caption = 'Eligibility Percertage';
            DataClassification = CustomerContent;
        }
        field(6; "Eligibility Rank"; Integer)
        {
            Caption = 'Eligibility Rank';
            DataClassification = CustomerContent;
        }
        field(7; "Rank Selection"; Boolean)
        {
            Caption = 'Rank Selection';
            DataClassification = CustomerContent;
        }
        field(8; "Selection Percentage"; Decimal)
        {
            Caption = 'Selection Percentage';
            DataClassification = CustomerContent;
        }
        field(9; "Selection Rank"; Integer)
        {
            Caption = 'Selection Rank';
            DataClassification = CustomerContent;
        }
        field(10; "Selected Quota Rank"; Integer)
        {
            Caption = 'Selected Quota Rank';
            DataClassification = CustomerContent;
        }
        field(11; "Selected Quota"; Code[20])
        {
            Caption = 'Selected Quota';
            DataClassification = CustomerContent;
            TableRelation = "Quota-CS";
        }
        field(12; Alloted; Boolean)
        {
            Caption = 'Alloted';
            DataClassification = CustomerContent;
        }
        field(13; "Selection List No."; Integer)
        {
            Caption = 'Selection List No.';
            DataClassification = CustomerContent;
        }
        field(14; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            DataClassification = CustomerContent;
        }
        field(15; "Applicant Name"; Text[30])
        {
            Caption = 'Applicant Name';
            DataClassification = CustomerContent;
        }
        field(16; Quota; Code[20])
        {
            Caption = 'Quota';
            DataClassification = CustomerContent;
            TableRelation = "Quota-CS";
        }
        field(17; "Is Promoted"; Boolean)
        {
            Caption = 'Is Promoted';
            DataClassification = CustomerContent;
        }
        field(18; "Is Demoted"; Boolean)
        {
            Caption = 'Is Demoted';
            DataClassification = CustomerContent;
        }
        field(19; "Reason For Promotion"; Text[30])
        {
            Caption = 'Reason For Promotion';
            DataClassification = CustomerContent;
        }
        field(20; "Reason For Demotion"; Text[30])
        {
            Caption = 'Reason For Demotion';
            DataClassification = CustomerContent;
        }
        field(21; "Eligibility Quota"; Code[20])
        {
            Caption = 'Eligibility Quota';
            DataClassification = CustomerContent;
        }
        field(22; "Eligibility Quota Rank"; Integer)
        {
            Caption = 'Eligibility Quota Rank';
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
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Course Code", "Selection List No.")
        {
        }
        key(Key3; "Course Code", "Selection List No.", "Application Selection", "Rank Selection", Alloted)
        {
        }
        key(Key4; "Course Code", "Selection List No.", "Application No.")
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


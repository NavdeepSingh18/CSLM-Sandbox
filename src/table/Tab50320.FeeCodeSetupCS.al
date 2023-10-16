table 50320 "Fee Code Setup-CS"
{
    // version V.001-CS

    // 
    // Sr.No   Emp.ID      Date            Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   07/01/2019       OnInsert()                    Auto Assign "User Id" Values

    Caption = 'Fee Code Setup-CS';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Class Fee No."; Code[10])
        {
            Caption = 'Class Fee No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(3; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(4; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(5; "Fee Number"; Code[20])
        {
            Caption = 'Fee Number';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Auto Assign "User Id" Values::CSPL-00114::07012019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto Assign "User Id" Values::CSPL-00114::07012019: End
    end;
}


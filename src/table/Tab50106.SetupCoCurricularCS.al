table 50106 "Setup Co-Curricular -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   16/06/2019       OnModify()                               Auto Assign user Id

    Caption = 'Setup Co-Curricular -CS';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(3; "Participant Entry No."; Code[20])
        {
            Caption = 'Participant Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(4; "Result Individual Entry No."; Code[20])
        {
            Caption = 'Result Individual Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(5; "Result Team Entry No."; Code[20])
        {
            Caption = 'Result Team Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
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

    trigger OnModify()
    begin
        //Code added for Auto Assign user Id::CSPL-00114::16062019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto Assign user Id::CSPL-00114::16062019: End
    end;
}


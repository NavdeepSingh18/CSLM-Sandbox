table 50261 "Vehicle - CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                  Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   06/01/2019       OnInsert()            Code to assign User ID.

    Caption = 'Media Vehicle';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06012019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06012019';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Code to assign User ID::Emp. Id::06012019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Code to assign User ID::Emp. Id::06012019: End
    end;
}


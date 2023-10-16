table 50325 "Class Master - CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   07/01/2019       OnInsert()                    Auto Assign "User Id" Values

    Caption = 'Class';


    fields
    {
        field(1; "Code"; Code[10])
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
        field(3; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = CustomerContent;
        }
        field(50174; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07012019';
        }
        field(50175; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07012019';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Sequence)
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


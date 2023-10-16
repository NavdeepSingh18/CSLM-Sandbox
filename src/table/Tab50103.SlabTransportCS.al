table 50103 "Slab Transport-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   16/06/2019       OnInsert()                               Auto Assign user Id

    Caption = 'Slab Transport-CS';

    fields
    {
        field(1; "Slab Code"; Code[10])
        {
            Caption = 'Slab Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Slab Name"; Text[30])
        {
            Caption = 'Slab Name';
            DataClassification = CustomerContent;
        }
        field(3; "Slab Start Distance in KM"; Decimal)
        {
            Caption = 'Slab Start Distance in KM';
            DataClassification = CustomerContent;
        }
        field(4; "Slab End Distance in KM"; Decimal)
        {
            Caption = 'Slab End Distance in KM';
            DataClassification = CustomerContent;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }

        //CSPL-00307
        field(6; StudentLastNameMini; Code[10])
        {
            Caption = 'Student Last Name Minimum Range';
            DataClassification = CustomerContent;
        }
        field(7; StudentLastNameMax; Code[10])
        {
            Caption = 'Student Last Name Max Range';
            DataClassification = CustomerContent;
        }
        field(8; Email; text[250])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
        }
        Field(9; Type; Option)
        {
            OptionCaption = ' ,Transcript/Degree,Graduation Contact';
            OptionMembers = " ","Transcript/Degree","Graduation Contact";
        }
        //CSPL-00307
        field(50174; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
        }
        field(50175; "Portal ID"; Code[50])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
        }
    }

    keys
    {
        key(Key1; "Slab Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Auto Assign user Id::CSPL-00114::16062019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto Assign user Id::CSPL-00114::16062019: End
    end;
}


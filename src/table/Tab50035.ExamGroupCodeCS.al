table 50035 "Exam Group Code-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Exam Group Code-CS';
    DrillDownPageID = "Code(Exam) List-CS";
    LookupPageID = "Code(Exam) List-CS";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Exam Order"; Integer)
        {
            BlankZero = true;
            Caption = 'Exam Order';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 06-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 06-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Exam Type"; Option)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External,Assignment,Internal Lab,External Lab,Project,Industrial Training';
            OptionMembers = " ",Internal,External,Assignment,"Internal Lab","External Lab",Project,"Industrial Training";
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
        }
        field(33048922; Block; Boolean)
        {
            Caption = 'Block';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2021';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Exam Order")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::02-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::02-05-2019: End
    end;
}


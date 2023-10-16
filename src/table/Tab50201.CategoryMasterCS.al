table 50201 "Category Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    04-05-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Category';
    DataClassification = CustomerContent;
    DrillDownPageID = 50183;
    LookupPageID = 50183;
    DataCaptionFields = "Code", Description;

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
        field(3; "Fee Classification"; Code[20])
        {
            Caption = 'Fee Classification';
            DataClassification = CustomerContent;
            TableRelation = "Fee Classification Master-CS";
        }
        field(4; "Discount Code"; Code[20])
        {
            Caption = 'Discount Code';
            DataClassification = CustomerContent;
            TableRelation = "Fee Discount Head-CS"."No." WHERE("Fee Clasification Code" = FIELD("Fee Classification"));
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "SIS Code"; Code[10])
        {
            Caption = 'SIS Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50004; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50005; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';

        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
    }

    keys
    {
        key(Key1; "Code", "Fee Classification")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::04-05-2019: Start
        "User ID" := FORMAT(UserId());

        Inserted := True;
        //Code added for User Id Assign in User Id Field::CSPL-00092::04-05-2019: End
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;
}


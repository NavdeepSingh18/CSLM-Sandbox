table 50267 "Year Master-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger              Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   08/02/2019       OnInsert()           automatically filled "User Id" name.

    Caption = 'Year Master-CS';
    DrillDownPageID = "Year List College -CS";
    LookupPageID = "Year List College -CS";
    DataCaptionFields = "Code", Description;

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
        field(4; "Order"; Integer)
        {
            Caption = 'Order';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08022019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08022019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08022019';
            NotBlank = true;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08022019';
        }
        field(33048921; "Portal ID"; Code[30])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08022019';
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
        fieldgroup(DropDown; "Code")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for automatically filled "User Id" name::CSPL-00114::08022019: Start
        "User ID" := FORMAT(UserId());
        //Code added for automatically filled "User Id" name::CSPL-00114::08022019: End
    end;
}


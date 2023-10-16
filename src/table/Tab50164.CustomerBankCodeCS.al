table 50164 "Customer Bank Code-CS"
{
    // version V.001-CS

    Caption = 'Customer Bank Code-CS';
    fields
    {
        field(1; BankCode; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = CustomerContent;
        }
        field(2; BankDesc; Text[30])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(3; UserID; Text[30])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(4; DateTime; DateTime)
        {
            Caption = 'Date Time';
            DataClassification = CustomerContent;
        }
        field(5; "Create Date"; DateTime)
        {
            Caption = 'Create Date';
            DataClassification = CustomerContent;
        }
        field(6; EffStat; Code[10])
        {
            Caption = 'Eff State';
            DataClassification = CustomerContent;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(9; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(10; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(Key1; BankCode)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; BankCode, BankDesc)
        {
        }
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    Trigger OnModify()
    begin
        IF xRec.Updated = Updated then
            Updated := true;
    end;
}


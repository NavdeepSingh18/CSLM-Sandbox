table 50165 "Cust Bank Branch-CS"
{
    // version V.001-CS

    Caption = 'Cust Bank Branch-CS';

    fields
    {
        field(1; BranchCode; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
        }
        field(2; BranchName; Text[30])
        {
            Caption = 'Branch Name';
            DataClassification = CustomerContent;
        }
        field(3; UserID; Text[30])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
        field(4; DateTime; DateTime)
        {
            Caption = 'Date Time';
            DataClassification = CustomerContent;
        }
        field(5; "Create Date"; DateTime)
        {
            Caption = 'Creted Date';
            DataClassification = CustomerContent;
        }
        field(6; EffStat; Code[10])
        {
            Caption = 'Eff Stat';
            DataClassification = CustomerContent;
        }
        field(7; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(8; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(Key1; BranchCode)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; BranchCode, BranchName)
        {
        }
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        IF xRec.Updated = Updated then
            Updated := true;
    end;
}


table 50411 "Special Accommodation Category"
{
    DataClassification = CustomerContent;
    Caption = 'Special Accommodation Category';
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; "Reason Description"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason Description';
        }
        field(3; Category; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Category';
            OptionMembers = " ","Non-Health","Health";
        }
        field(4; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = Allowed,Blocked;
        }
        field(5; "Blocked By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked By';
        }
        field(6; "Blocked On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked On';
        }
        field(7; "Allowed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Allowed By';
        }
        field(8; "Allowed On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Allowed On';
        }
        field(20; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;
        }
        field(21; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;
        }

        field(22; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(23; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';

        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, "Reason Description", Category)
        {
        }
    }
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := Today;

        Inserted := True;
    end;

    Trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;
}
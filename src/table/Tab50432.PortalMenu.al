table 50432 "Portal Menu"
{
    DataClassification = CustomerContent;
    Caption = 'Portal Menu';

    fields
    {
        field(1; "Menu Code"; Code[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Menu Code';
        }
        field(2; "Menu Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Menu Name';
        }
        field(3; PRIORITY; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PRIORITY';
        }
        field(4; Link; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Link';
        }
        field(5; "Parent ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Parent ID';
        }
        field(6; ID; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
        }
        field(7; Active; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Active';
        }
        field(8; "Availability"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Availability';
        }
        field(9; "Event Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Event Code';
        }

        field(10; Inserted; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Inserted';
        }
        field(11; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }
    keys
    {

        key(Key1; "Menu Code")
        {
        }
    }

    trigger OnInsert()
    Begin
        Inserted := true;
    End;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

}
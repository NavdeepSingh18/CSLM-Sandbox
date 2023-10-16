table 50420 "Salesforce Sync Error Log"
{
    Caption = 'Salesforce Sync Error Log';
    DataClassification = ToBeClassified;
    // LookupPageId = "Salesforce Sync Error Log List";
    // DrillDownPageId = "Salesforce Sync Error Log List";

    fields
    {

        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; "Log Date"; DateTime)
        {
            Caption = 'Log Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Data Table Name"; Text[100])
        {
            Caption = 'Data Table Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Web Service Name"; Text[2048])
        {
            Caption = 'Web Service Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Insert Event"; Boolean)
        {
            Caption = 'Insert Event';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(6; "Update Event"; Boolean)
        {
            Caption = 'Update Event';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(7; "Error Description"; Text[2048])
        {
            Caption = 'Error Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Data"; Text[2048])
        {
            Caption = 'Data';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; URL; Text[2048])
        {
            Caption = 'URL';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(11; "Body 1"; Text[2048])
        {
            Caption = 'Body 1';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Body 2"; Text[2048])
        {
            Caption = 'Body 2';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; Method; Text[10])
        {
            Caption = 'Method';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Event Trigger"; Text[50])
        {
            Caption = 'Event Trigger';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Retry"; Boolean)
        {
            Caption = 'Retry';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; Counter; Integer)
        {
            Caption = 'Counter';
            DataClassification = CustomerContent;
            Editable = false;
        }


    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure Setstyle(): Text[100]
    begin
        If Rec.Counter = 99 then
            EXIT('Unfavorable');
        If Rec.Retry then
            exit('Favorable');
        If Rec.Counter <= 5 then
            exit('');
    end;

}

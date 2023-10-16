table 50431 "Portal APIs Error Log"
{
    DataClassification = CustomerContent;
    Caption = 'Portal APIs Error Log';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;

        }
        field(2; "Table Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Table Name';

        }
        field(3; "API Responses"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'API Responses';


        }
        field(4; "Remarks"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';


        }
        field(5; "Modified On"; DateTime)
        {
            DataClassification = CustomerContent;

        }
        field(6; "Modified By"; Text[2048])
        {
            DataClassification = CustomerContent;

        }


    }
    keys
    {

        key(Key1; "Entry No")
        {
        }
    }

}
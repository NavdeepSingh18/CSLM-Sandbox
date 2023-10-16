table 50393 "SAP Fee Code"
{

    Caption = 'SAP Fee Code';

    fields
    {
        field(1; "SAP Code"; Code[20])
        {
            Caption = 'SAP Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "SAP G/L Account"; Code[20])
        {
            Caption = 'SAP G/L Account';
            DataClassification = CustomerContent;
        }
        field(3; "SAP Assignment Code"; Code[20])
        {
            Caption = 'SAP Assignment Code';
            DataClassification = CustomerContent;
        }
        field(4; "SAP Description"; Text[30])
        {
            Caption = 'SAP Description';
            DataClassification = CustomerContent;
        }

        field(5; "SAP Cost Centre"; Code[20])
        {
            Caption = 'SAP Cost Centre';
            DataClassification = CustomerContent;
        }
        field(6; "SAP Profit Centre"; Code[20])
        {
            Caption = 'SAP Profit Centre';
            DataClassification = CustomerContent;
        }
        field(7; "SAP Company Code"; Code[20])
        {
            Caption = 'SAP Company Code';
            DataClassification = CustomerContent;
        }
        field(8; "SAP Bus. Area"; Code[20])
        {
            Caption = 'SAP Bus. Area';
            DataClassification = CustomerContent;
        }
        field(9; "Fee Group"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Group';
            OptionCaption = ' ,Non-Institutional,Institutional';
            OptionMembers = " ","Non-Institutional",Institutional;
        }
    }

    keys
    {
        key(Key1; "SAP Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "SAP Code", "SAP G/L Account", "SAP Assignment Code", "SAP Description", "SAP Cost Centre", "SAP Profit Centre", "SAP Company Code", "SAP Bus. Area", "Fee Group")
        {

        }
    }

}
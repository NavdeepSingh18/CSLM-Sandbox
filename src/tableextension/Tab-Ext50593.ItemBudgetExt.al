tableextension 50593 "Item Budget Name Ext" extends "Item Budget Name"
{
    fields
    {
        field(50000; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50001; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), "Dimension Value Type" = filter(Standard));
        }
        field(50002; "SAP Company Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "SAP Bus. Area"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "SAP Cost Centre"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "SAP Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "G/L Account"; Code[20])
        {//CSPL-00307
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50008; "Budget Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }

    }
}
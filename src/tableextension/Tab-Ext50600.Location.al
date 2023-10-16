tableextension 50600 LocationExt extends Location
{
    fields
    {
        field(50000; "Global Dimension 1 Code"; Code[20])   //CSPL-00307
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

            end;
        }
        field(50001; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }
    }

    var
    // myInt: Integer;
}
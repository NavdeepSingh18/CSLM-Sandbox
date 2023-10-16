tableextension 50568 "tableextensionItem" extends Item
{
    fields
    {
        field(50000; "Product Sub group Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Product Sub group Code';
            DataClassification = CustomerContent;
        }
        field(50001; Image; BLOB)
        {
            Description = 'CS Field Added 02-05-2019';
            SubType = Bitmap;
            Caption = 'Image';
            DataClassification = CustomerContent;
        }
    }
}
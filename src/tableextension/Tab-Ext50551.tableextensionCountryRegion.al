tableextension 50551 "tableextension50551" extends "Country/Region"
{
    fields
    {
        field(50000; "SIS Code"; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50001; EWS; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50002; Nationality; text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Nationality';
        }
        field(50003; Citizenship; text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Citizenship';
        }
        field(50004; "Immigration Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Immigration Applicable';
        }
        field(50005; "Block"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Block';
        }
        field(50006; "Phone Mask"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone Mask';
        }
        field(50007; "SSN Mask"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'SSN Mask';
        }

        field(50008; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50009; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(50010; "Visa Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50011; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    trigger OnInsert()
    Begin
        Inserted := true;
    End;

    Trigger OnModify()
    Begin

        IF xRec.Updated = Updated then
            Updated := true;
    End;
}


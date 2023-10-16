table 50185 "Application Option Master-CS"
{
    // version V.001-CS

    Caption = 'Cashnet File Data';

    fields
    {
        field(1; "Code"; Code[20])
        {
            caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(4; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        Field(5; Type; Option)
        {
            OptionCaption = ' ,Customer,Note,Balance,Statement';
            OptionMembers = " ",Customer,Note,Balance,Statement;
        }
        Field(6; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(7; "Customer Status"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Customer Last Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Customer First Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Customer Group"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Customer PIN"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(12; "Address Line 1"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(13; "Address Line 2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(14; "Address Line 3"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(15; City; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(16; State; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(17; "Zip Code"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(18; Country; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Area Code"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Telephone No."; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(21; "Email Address"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(22; "Customer Attribute 1"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(23; "Customer Attribute 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(24; "Customer Attribute 3"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(25; "Customer Attribute 4"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(26; "Alternate ID 1"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(27; "Alternate ID 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(28; "Alternate ID 3"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(29; "Alternate ID 4"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(30; "Row No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(31;Amount;Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(32;"Academic Year";Code[10])
        {
            DataClassification = CustomerContent;
        }
        Field(33;"Statement Date";Date)
        {
            DataClassification = CustomerContent;
        }
        field(34;"Current Balance";Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(35;"Previous Balance";Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(36;"Total Due";Decimal)
        {
            DataClassification = CustomerContent;
        }
        Field(37;"Summary Statement";Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(38;"Detailed Statement";Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(39;"Student Name";Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(40;"Activity Description";Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(41;"Activity Charges";DEcimal)
        {
            DataClassification = CustomerContent;
        }
        field(42;"Activity Date";Date)
        {
            DataClassification = CustomerContent;
        }
        Field(43;"Due Date";Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        if xRec.Updated = Updated then
            Updated := true;
    end;
}

table 50217 "Vend Invoice Disc Arch-CS"
{
    // version V.001-CS

    Caption = 'Vend Invoice Disc Arch-CS';
    // DrillDownPageID = 50123;
    // LookupPageID = 50123;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Minimum Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Minimum Amount';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(3; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(4; "Service Charge"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Service Charge';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(5; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(6; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Modified Time"; Time)
        {
            Caption = 'Modified Time';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}


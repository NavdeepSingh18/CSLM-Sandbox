table 50234 "Grading Rule Setup-CS"
{
    // version V.001-CS

    Caption = 'Grading Rule Setup-CS';

    fields
    {
        field(1; Graduation; Code[20])
        {
            caption = 'Graduation';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS";
        }
        field(2; "Grading Rule"; Option)
        {
            caption = 'Grading Rule';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Statistical, Absolute, Fixed';
            OptionMembers = " ",Statistical," Absolute"," Fixed";
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
        }
        field(5; "Maximum Grace Marks"; Decimal)
        {
            caption = 'Maximum Grace Marks';
            DataClassification = CustomerContent;
        }
        field(6; "Highest Grade Highest Cut Off"; Decimal)
        {
            caption = 'Highest Grade Highest Cut Off';
            DataClassification = CustomerContent;
        }
        field(7; "Highest Grade Lowest Cut Off"; Decimal)
        {
            caption = 'Highest Grade Lowest Cut Off';
            DataClassification = CustomerContent;
        }
        field(8; "Lowest Grade Highest Cut Off"; Decimal)
        {
            caption = 'Lowest Grade Highest Cut Off';
            DataClassification = CustomerContent;
        }
        field(9; "Lowest Grade Lowest Cut Off"; Decimal)
        {
            caption = 'Lowest Grade Lowest Cut Off';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Graduation, "Grading Rule", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
        }
    }

    fieldgroups
    {
    }
}


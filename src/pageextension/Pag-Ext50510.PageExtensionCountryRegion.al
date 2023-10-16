pageextension 50510 "PageExtensionCountryRegion" extends "Countries/Regions"
{
    layout
    {
        addafter(Name)
        {
            field(Nationality; Rec.Nationality)
            {
                ApplicationArea = All;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = all;
            }
            field("Immigration Applicable"; Rec."Immigration Applicable")
            {
                ApplicationArea = All;
            }
            field("Visa Applicable"; Rec."Visa Applicable")
            {
                ApplicationArea = all;
            }
            field(Block; Rec.Block)
            {
                ApplicationArea = All;
            }
            field("Phone Mask"; Rec."Phone Mask")
            {
                ApplicationArea = All;
            }

            field("SSN Mask"; Rec."SSN Mask")
            {
                ApplicationArea = All;
            }
        }

    }
}


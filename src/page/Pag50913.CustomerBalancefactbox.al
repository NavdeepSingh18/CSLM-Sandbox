page 50913 "CustomerBalanceFactBox"
{
    Caption = 'Customer Balance Details';
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field("Tuition Balance"; Rec."Tuition Balance")
            {
                ApplicationArea = All;
                Caption = 'Tuition Balance';
            }
            field("Grenville Balance"; Rec."Grenville Balance")
            {
                ApplicationArea = All;
                Caption = 'Grenville Balance';
            }
            field("AUA Housing Balance"; Rec."AUA Housing Balance")
            {
                ApplicationArea = All;
                Caption = 'AUA Housing Balance';
            }
        }
    }



}


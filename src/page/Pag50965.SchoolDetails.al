page 50965 "School Details"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = School;
    Caption = 'School Details';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("School ID"; Rec."School ID")
                {
                    ApplicationArea = All;
                    Editable = False;

                }
                field("18 Digit ID"; Rec."18 Digit ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Account Person Type"; Rec."Account Person Type")
                {
                    ApplicationArea = all;
                }
                field("Alternate Email Address"; Rec."Alternate Email Address")
                {
                    ApplicationArea = All;
                }
                field("Billing Address"; Rec."Billing Address")
                {
                    ApplicationArea = All;
                }
                Field("City "; Rec."City ")
                {
                    ApplicationArea = All;
                }
                field("Current GPA Scale"; Rec."Current GPA Scale")
                {
                    ApplicationArea = All;
                }
                field("Shipping Address"; Rec."Shipping Address")
                {
                    ApplicationArea = All;
                }
                field("Zip Code"; Rec."Zip Code")
                {
                    ApplicationArea = All;

                }
                field(Advisor; Rec.Advisor)
                {
                    ApplicationArea = all;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                Field(Website; Rec.Website)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
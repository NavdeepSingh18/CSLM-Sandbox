page 50584 "School List"
{

    PageType = List;
    SourceTable = School;
    Caption = 'School List';
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = False;
    // CardpageID = "School Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("School ID"; Rec."School ID")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field("Alternate Email Address"; Rec."Alternate Email Address")
                {
                    ApplicationArea = All;
                }
                field("Billing Address"; Rec."Billing Address")
                {
                    ApplicationArea = All;
                }
                field("City "; Rec."City ")
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
                    ApplicationArea = All;
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
                field(Website; Rec.Website)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}

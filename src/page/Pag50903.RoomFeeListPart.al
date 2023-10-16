page 50903 "Room Category Fee Listpart"
{
    PageType = listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Room Category Fee Setup";
    Caption = 'Apartment Category Fee Setup';

    layout
    {
        area(Content)
        {
            repeater(group)
            {

                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;

                }
                field("Room Category Name"; Rec."Room Category Name")
                {
                    ApplicationArea = All;

                }
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;

                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;

                }
                field("Housing Group"; Rec."Housing Group")
                {
                    ApplicationArea = All;

                }
                field("Housing Group Name"; Rec."Housing Group Name")
                {
                    ApplicationArea = all;
                }

                field("Effective From"; Rec."Effective From")
                {
                    ApplicationArea = All;

                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;

                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;

                }
                field("With Spouse Cost"; Rec."With Spouse Cost")
                {
                    ApplicationArea = All;
                }
                field("Off Campus"; Rec."Off Campus")
                {
                    ApplicationArea = All;
                }
                field("Room Category Availbility"; Rec."Room Category Availbility")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                Field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
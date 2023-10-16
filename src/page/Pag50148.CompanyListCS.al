page 50148 "Company List-CS"
{
    // version V.001-CS

    CardPageID = "Company Card-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Stud Placement Company-CS";
    Caption='Company List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Company Address"; Rec."Company Address")
                {
                    ApplicationArea = All;
                }
                field("Company Address1"; Rec."Company Address1")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Company Phone"; Rec."Company Phone")
                {
                    ApplicationArea = All;
                }
                field("Company Website"; Rec."Company Website")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Contact person Designation"; Rec."Contact person Designation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Company")
            {
                Caption = '&Company';
                action("Company C&ard")
                {
                    Caption = 'Company C&ard';
                    RunObject = Page 50147;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
            }
        }
    }
}
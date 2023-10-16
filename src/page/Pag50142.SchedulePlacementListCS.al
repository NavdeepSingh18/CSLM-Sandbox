page 50142 "Schedule (Placement) List-CS"
{
    // version V.001-CS

    CardPageID = "Sch. (Placement) Card-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Stud Placement Schedule-CS";
    Caption = 'Schedule (Placement) List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Schedule No."; Rec."Schedule No.")
                {
                    ApplicationArea = All;
                }
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("No of openings"; Rec."No of openings")
                {
                    ApplicationArea = All;
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = All;
                }
                field("To Time"; Rec."To Time")
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
            group("&Placement Schedule")
            {
                Caption = '&Placement Schedule';
                action("&Schedule Card")
                {
                    Caption = '&Schedule Card';
                    RunObject = Page 50141;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = All;
                }
            }
        }
    }
}
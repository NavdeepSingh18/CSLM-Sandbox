page 50495 "FM1_IM1 Date Preset LST+"
{
    Caption = 'FM1/IM1 Date Presets';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FM1/IM1 Date Preset Entry";
    SourceTableView = where(Status = const(Confirmed));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Preset No."; Rec."Preset No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Document Due Date"; Rec."Document Due Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("FM1/IM1 Preset Information"; "FM1IM1 Preset Factbox")
            {
                ApplicationArea = All;
                Caption = 'FM1/IM1 Preset Information';
                SubPageLink = "Preset No." = field("Preset No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Open")
            {
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromTimesheet;
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                end;
            }
            action("Hospital Inventory")
            {
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromTimesheet;
                ApplicationArea = All;
                trigger OnAction()
                var
                    HospitalInventory: Record "Hospital Inventory";
                    FM1_IM1HospitalInventory: Page "FM1_IM1 Hospital Inventory";
                begin
                    HospitalInventory.Reset();
                    HospitalInventory.SetRange("Course Code", Rec."Course Code");
                    HospitalInventory.SetRange("Start Date", Rec."Start Date");
                    HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::"FM1/IM1");
                    FM1_IM1HospitalInventory.SetTableView(HospitalInventory);
                    FM1_IM1HospitalInventory.Editable := false;
                    FM1_IM1HospitalInventory.RunModal();
                end;
            }
            action("Applied Students")
            {
                ShortcutKey = 'Ctrl+D';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromTimesheet;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                begin
                    ClerkshipSiteAndDateSelection.Reset();
                    ClerkshipSiteAndDateSelection.FilterGroup(2);
                    ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
                    ClerkshipSiteAndDateSelection.FilterGroup(0);
                    Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection);
                end;
            }
        }
    }
}
page 50606 "Rotation Offer List+"
{
    PageType = List;
    Caption = 'Confirmed Elective Rotation Offers';
    CardPageId = "Rotation Offer Card+";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rotation Offers";
    SourceTableView = where(Status = filter(<> " "));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Hospital Name"; Rec."Hospital Name")
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
                field("Total No. of Seats"; Rec."Total No. of Seats")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("No. of Students Applied"; Rec."No. of Students Applied")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
        area(FactBoxes)
        {
            part("Applied Students"; "Offer Application Factbox")
            {
                ApplicationArea = All;
                Caption = 'Rotation Offer Information';
                SubPageLink = "Offer No." = field("Offer No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Rotation Applications")
            {
                ApplicationArea = All;
                Caption = 'Rotation Applications';
                ShortcutKey = 'Ctrl+L';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = List;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.FilterGroup(2);
                    RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                    RotationOfferApplication.FilterGroup(0);
                    Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                end;
            }
        }
    }
}
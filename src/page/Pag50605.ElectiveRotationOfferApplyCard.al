page 50605 "Rotation Offer Apply Card"
{
    Caption = 'Elective Rotation Offer Apply Card';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Rotation Offers";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    ShowMandatory = true;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    MultiLine = true;
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
                    MultiLine = true;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = true;
                    ShowMandatory = true;
                    LookupPageId = "Hospital Inventory Lookup";
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    MultiLine = true;
                    Editable = false;
                }
                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Strong;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Strong;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Unfavorable;
                }

                field("No. of Students Applied"; Rec."No. of Students Applied")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            part("Applied Students"; "Offer Application Factbox")
            {
                ApplicationArea = All;
                Caption = 'Applied Students';
                SubPageLink = "Offer No." = field("Offer No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Apply for Rotation")
            {
                ApplicationArea = All;
                Caption = 'Apply for Rotation';
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = ApplicationWorksheet;
                trigger OnAction()
                begin
                    Rec.ApplyForRotation();
                end;
            }
        }
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

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        if not UserSetup.Get(UserId) then
            Error('User Setup for User ID %1 not found.', UserId);

        Rec."Global Dimension 1 Code" := '9000';
    end;
}
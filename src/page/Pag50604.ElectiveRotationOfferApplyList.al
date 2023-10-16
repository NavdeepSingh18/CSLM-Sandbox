page 50604 "Rotation Offer Apply List"
{
    PageType = List;
    Caption = 'Elective Rotation Offer Apply List';
    CardPageId = "Rotation Offer Apply Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rotation Offers";
    SourceTableView = sorting("Start Date") order(descending) where(Status = filter(Confirmed));
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
                    ShowMandatory = true;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                }
                field("Course Description"; Rec."Course Description")
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
                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = All;
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
                }
            }
        }

        area(FactBoxes)
        {
            part("Applied Students"; "Offer Application Factbox")
            {
                ApplicationArea = All;
                Caption = 'Elective Rotation Offer';
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

    trigger OnOpenPage()
    var
        RotationOffers: Record "Rotation Offers";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Offer No.      ############1################\';
    begin
        WindowDialog.Open('Checking Elective Offers..\' + Text001Lbl);
        RotationOffers.Reset();
        RotationOffers.SetRange(Status, RotationOffers.Status::Confirmed);
        RotationOffers.SetFilter("Start Date", '<>%1', 0D);
        if RotationOffers.FindSet() then
            repeat
                WindowDialog.Update(1, RotationOffers."Offer No.");
                if RotationOffers."Start Date" < WorkDate() then begin
                    RotationOffers.Status := RotationOffers.Status::Closed;
                    RotationOffers."Status By" := 'Closed';
                    RotationOffers."Status On" := Today;
                    RotationOffers.Modify();
                end;
            until RotationOffers.Next() = 0;
        WindowDialog.Close();
    end;
}
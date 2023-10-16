page 50607 "Rotation Offer Card+"
{
    Caption = 'Confirmed Rotation Offer';
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
                field("Maximum Waitlist Students"; Rec."Maximum Waitlist Students")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Visible = false;
                    Enabled = false;
                }
                field("Total No. of Seats"; Rec."Total No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    Caption = 'Total No. of Seats';
                    DecimalPlaces = 0;
                    Visible = false;
                    Enabled = false;
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
                field("Visible on Portal"; Rec."Visible on Portal")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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
                Caption = 'Elective Rotation Offer';
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
            action("Close Offer")
            {
                ApplicationArea = All;
                Caption = 'Close Offer';
                ShortcutKey = 'Ctrl+Shift+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Closed;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    UserSetup.Reset();
                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Clinical Administrator" = false then
                            Error('You do not have permission to Close the Offer.');
                    end
                    else
                        Error('User Setup not found for the User ID %1.', UserId);

                    if not Confirm('Do you want to Close the Offer No. %1?', true, Rec."Offer No.") then
                        exit;

                    Rec.Validate(Status, Rec.Status::Closed);
                    CALE.InsertLogEntry(6, 10, Rec."Offer No.", Rec."Elective Course Code", Rec."Offer No.", '', '', Rec."Elective Course Code", Rec."Rotation Description");
                    Rec.Modify();
                    Message('Offer No. %1 has Closed.', Rec."Offer No.");
                end;
            }
            action("Reopen Offer")
            {
                ApplicationArea = All;
                Caption = 'Reopen Offer';
                ShortcutKey = 'Ctrl+Shift+O';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Closed;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    UserSetup.Reset();
                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Clinical Administrator" = false then
                            Error('You do not have permission to Reopen the Offer.');
                    end
                    else
                        Error('User Setup not found for the User ID %1.', UserId);

                    if not Confirm('Do you want to Reopen the Offer No. %1?', true, Rec."Offer No.") then
                        exit;

                    Rec.Validate(Status, Rec.Status::Confirmed);
                    CALE.InsertLogEntry(6, 15, Rec."Offer No.", Rec."Elective Course Code", Rec."Offer No.", '', '', Rec."Elective Course Code", Rec."Rotation Description");
                    Rec.Modify();
                    Message('Offer No. %1 has Reopened.', Rec."Offer No.");
                end;
            }
            action("Remove Offer from Portal")
            {
                ApplicationArea = All;
                Caption = 'Remove Offer from Portal';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = ViewCheck;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    UserSetup.Reset();
                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Clinical Administrator" = false then
                            Error('You do not have permission for this action.');
                    end
                    else
                        Error('User Setup not found for the User ID %1.', UserId);

                    if not Confirm('Do you want to remove Offer No. %1 from portal?', true, Rec."Offer No.") then
                        exit;

                    Rec."Visible on Portal" := false;
                    CALE.InsertLogEntry(6, 23, Rec."Offer No.", Rec."Elective Course Code", Rec."Offer No.", '', 'Remove from Portal', Rec."Elective Course Code", Rec."Rotation Description");
                    Rec.Modify();
                    Message('Offer No. %1 is removed from portal.', Rec."Offer No.");
                end;
            }
            action("Offer Visible on Portal")
            {
                ApplicationArea = All;
                Caption = 'Offer Visible on Portal';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = ViewPostedOrder;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    UserSetup.Reset();
                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Clinical Administrator" = false then
                            Error('You do not have permission for this action.');
                    end
                    else
                        Error('User Setup not found for the User ID %1.', UserId);

                    if not Confirm('Do you want to make Offer No. %1 visible to portal?', true, Rec."Offer No.") then
                        exit;

                    Rec."Visible on Portal" := true;
                    CALE.InsertLogEntry(6, 23, Rec."Offer No.", Rec."Elective Course Code", Rec."Offer No.", '', 'Visible on Portal', Rec."Elective Course Code", Rec."Rotation Description");
                    Rec.Modify();
                    Message('Offer No. %1 is now visible on portal.', Rec."Offer No.");
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
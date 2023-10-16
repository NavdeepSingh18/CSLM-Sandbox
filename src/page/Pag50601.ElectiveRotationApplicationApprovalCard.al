page 50601 "Rotation Offer Appl Card"
{
    PageType = Card;
    Caption = 'Elective Rotation Application Approval';
    UsageCategory = None;
    SourceTable = "Rotation Offer Application";
    InsertAllowed = false;
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
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Same Rotation Applied"; Rec."Same Rotation Applied")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(Semester; Rec.Semester)
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
    }
    actions
    {
        area(Processing)
        {
            action("Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction()
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");

                    if not Confirm('Do you want to approve Elective Rotation Offer Application for the Student %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
                        exit;
                    Rec.Validate("Approval Status", Rec."Approval Status"::Approved);
                    Rec.Modify();
                    Message('Elective Rotation Offer Application %1 for the Student %2 (%3) has been approved successfully.', Rec."Application No.", Rec."Student No.", Rec."Student Name");
                end;
            }

            action("Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.FilterGroup(2);
                    RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                    RotationOfferApplication.SetRange("Line No.", Rec."Line No.");
                    RotationOfferApplication.SetRange("Application No.", Rec."Application No.");
                    RotationOfferApplication.FilterGroup(0);
                    // Page.RunModal(Page::"Offer Appl Reject Card", RotationOfferApplication);
                end;
            }
            action("Future Rotation List")
            {
                ApplicationArea = All;
                Caption = 'Future Rotation List';
                ShortcutKey = 'Ctrl+R';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromJob;

                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                begin
                    RSL.Reset();
                    RSL.SetRange("Student No.", Rec."Student No.");
                    RSL.SetFilter("Start Date", '>%1', Rec."End Date");
                    Page.RunModal(Page::"Roster Scheduling Lines", RSL);
                end;
            }
        }
    }
}
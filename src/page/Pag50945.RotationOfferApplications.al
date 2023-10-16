page 50945 "Rotation Offer Applications"
{
    PageType = List;
    Caption = 'Elective Rotation Offer Applications';
    UsageCategory = None;
    SourceTable = "Rotation Offer Application";
    CardPageId = "Elective Rotation Appl Card";
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
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Unfavorable;
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
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }

                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
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
                field("Alternate Start Date"; Rec."Alternate Start Date")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                }
                field("Alternate End Date"; Rec."Alternate End Date")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Rotation Status"; Rec."Rotation Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Rotation Application Rejected")
            {
                ApplicationArea = All;
                Caption = 'Rotation Application Rejected';
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Reject;
                Visible = false;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.FilterGroup(2);
                    RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                    RotationOfferApplication.SetRange("Student No.", Rec."Student No.");
                    RotationOfferApplication.FilterGroup(0);
                    page.RunModal(Page::"Rotation Application Rejection", RotationOfferApplication);
                end;
            }
        }
    }
}
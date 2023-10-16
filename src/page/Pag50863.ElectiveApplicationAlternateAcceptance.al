page 50863 "Elec Appl Alternate Acceptance"
{
    PageType = List;
    Caption = 'Elective Applications Alternate Date Acceptance';
    UsageCategory = None;
    SourceTable = "Rotation Offer Application";
    SourceTableView = sorting("Offer No.", "Application No.") order(descending) where("Alternate Start Date" = filter(<> ''));
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
                    Style = Strong;
                }
                field("Alternate End Date"; Rec."Alternate End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
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
            action("Accept Alternate Date")
            {
                ApplicationArea = All;
                Caption = 'Accept Alternate Date';
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = ContactFilter;
                trigger OnAction()
                var
                    RotationOffers: Record "Rotation Offers";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");

                    if not Confirm('Do you want to accept the given Allternate Date.', true) then
                        exit;

                    if Rec."Alternate Start Date" = 0D then
                        Error('You must specify the Alternate Start Date.');

                    RotationOffers.Reset();
                    if RotationOffers.Get(Rec."Offer No.") then begin
                        RotationOffers.CalcFields("No. of Students Applied");
                        if RotationOffers."No. of Students Applied" = RotationOffers."Total No. of Seats" then begin
                            RotationOffers.Validate(Status, RotationOffers.Status::Completed);
                            RotationOffers.Modify();
                        end;
                    end;

                    Rec.Validate("Start Date", Rec."Alternate Start Date");
                    Rec."Alternate Start Date" := 0D;
                    Rec."Alternate End Date" := 0D;
                    Rec.Validate(Status, Rec.Status::Confirmed);
                    Rec.Validate("Approval Status", "Approval Status"::Approved);
                    Rec.Modify();
                    CALE.InsertLogEntry(7, 6, Rec."Student No.", Rec."Student Name", Rec."Application No.", Rec."Reject Reason", Rec."Reject Reason Description", Rec."Elective Course Code", Rec."Rotation Description");
                    Message('Application for the Elective Rotation with Alternate Date Applied Successfully.');
                    CurrPage.Close();
                end;
            }
            action("Reject Alternate Date")
            {
                ApplicationArea = All;
                Caption = 'Reject Alternate Date';
                ShortcutKey = 'Ctrl+D';
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
                    RotationOfferApplication.SetRange("Application No.", Rec."Application No.");
                    RotationOfferApplication.FilterGroup(0);
                    Page.RunModal(Page::"Elective Rotation Appl Card", RotationOfferApplication);
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
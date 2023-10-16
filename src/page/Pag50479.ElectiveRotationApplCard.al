page 50479 "Elective Rotation Appl Card"
{
    PageType = Card;
    Caption = 'Elective Rotation Application Card';
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
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
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
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Unfavorable;
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

                group("Alternate Options")
                {
                    field("Alternate Start Date"; Rec."Alternate Start Date")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Alternate End Date"; Rec."Alternate End Date")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Reject Reason"; Rec."Reject Reason")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                    field("Reject Reason Description"; Rec."Reject Reason Description")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        MultiLine = true;
                    }
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
                Visible = AlternateDateFilled;
                trigger OnAction()
                var
                    RotationOffers: Record "Rotation Offers";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    REc.TestField("Rotation Status", REc."Rotation Status"::" ");
                    if REc."Reject Reason" <> '' then
                        Error('Reject Reason must be Blank.');
                    if REc."Reject Reason Description" <> '' then
                        Error('Reject Reason Description must be Blank.');

                    if not Confirm('Do you want to assign an Alternate Start Date for the Elective Rotation Application?') then
                        exit;

                    if REc."Alternate Start Date" = 0D then
                        Error('You must specify the Alternate Start Date.');

                    RotationOffers.Reset();
                    if RotationOffers.Get(REc."Offer No.") then begin
                        RotationOffers.CalcFields("No. of Students Applied");
                        if RotationOffers."No. of Students Applied" = RotationOffers."Total No. of Seats" then begin
                            RotationOffers.Validate(Status, RotationOffers.Status::Completed);
                            RotationOffers.Modify();
                        end;
                    end;

                    REc.Validate("Start Date", REc."Alternate Start Date");
                    REc."Alternate Start Date" := 0D;
                    REc."Alternate End Date" := 0D;
                    REc.Validate(Status, REc.Status::Confirmed);
                    REc.Validate("Approval Status", REc."Approval Status"::"Not Applicable");
                    REc.Modify();
                    CALE.InsertLogEntry(7, 6, REc."Student No.", REc."Student Name", REc."Application No.", REc."Reject Reason", REc."Reject Reason Description", REc."Elective Course Code", REc."Rotation Description");
                    Message('Alternate Date has been assigned for the Elective Rotation');
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
                Visible = AlternateDateFilled;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    REc.TestField("Rotation Status", REc."Rotation Status"::" ");
                    REc.TestField("Reject Reason");
                    REc.TestField("Reject Reason Description");

                    if not Confirm('Do you want to Reject the given Allternate Date.', true) then
                        exit;

                    REc."Alternate Start Date" := 0D;
                    REc."Alternate End Date" := 0D;

                    REc.Validate(Status, REc.Status::Rejected);
                    REc.Validate("Approval Status", REc."Approval Status"::" ");
                    REc.Modify();
                    CALE.InsertLogEntry(7, 5, REc."Student No.", REc."Student Name", REc."Application No.", REc."Reject Reason", REc."Reject Reason Description", REc."Elective Course Code", REc."Rotation Description");
                    Message('Alternate Date Option Rejected.');
                    CurrPage.Close();
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
                    RSL.SetRange("Student No.", REc."Student No.");
                    RSL.SetFilter("Start Date", '>%1', REc."End Date");
                    Page.RunModal(Page::"Roster Scheduling Lines", RSL);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    Begin
        AlternateDateFilled := true;
        if REc."Alternate Start Date" = 0D then
            AlternateDateFilled := false;
    End;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if REc.Status <> REc.Status::Rejected then begin
            if REc."Reject Reason" <> '' then
                Error('You must remove Reject Reason');
            if REc."Reject Reason Description" <> '' then
                Error('You must remove Reject Reason Description');
        end;
    end;

    var
        AlternateDateFilled: Boolean;
}
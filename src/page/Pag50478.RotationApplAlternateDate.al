page 50478 "Rotation Appl Alternate Date"
{
    PageType = Card;
    Caption = 'Elective Rotation Application Alternate Date';
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

                group("Alternate Options")
                {
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
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Confirm)
            {
                ApplicationArea = All;
                Caption = 'Confirm';
                ShortcutKey = 'F6';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Confirm;
                trigger OnAction()
                var
                    RotationOffers: Record "Rotation Offers";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    REc.TestField("Rotation Status", REc."Rotation Status"::" ");

                    if not Confirm('Do you want to assign an Alternate Start Date for the Elective Rotation Application?') then
                        exit;

                    if REc."Alternate Start Date" = 0D then
                        Error('You must specify the Alternate Start Date.');

                    RotationOffers.Reset();
                    if RotationOffers.Get(REc."Offer No.") then
                        if RotationOffers.Status = RotationOffers.Status::Completed then begin
                            RotationOffers.Status := RotationOffers.Status::Confirmed;
                            RotationOffers.Modify();
                        end;

                    REc.Validate(Status, REc.Status::Open);
                    REc.Validate("Approval Status", REc."Approval Status"::" ");
                    CALE.InsertLogEntry(7, 11, 'NA', 'NA', REc."Application No.", 'ALTDATE', 'Alternate Date Assignment', REc."Elective Course Code", REc."Rotation Description");
                    REc.Modify();
                    Message('Alternate Date has been assigned for the Elective Rotation');
                    CurrPage.Close();
                end;
            }
        }
    }
}
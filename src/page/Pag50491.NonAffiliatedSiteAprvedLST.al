page 50491 "Non-Affiliated Site Aprved LST"
{
    Caption = 'List of Approved Non-Affiliated Sites';
    PageType = List;
    SourceTable = "Non-Affiliated Hospital";
    SourceTableView = sorting(Status) where(Confirmed = filter(true), Status = filter(Approved | Rejected));
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Non-Affiliated Site Aprvd CRD";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {

        area(content)
        {
            repeater(Group)
            {

                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the No..';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Date of Application.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Specifies the Status of Application.';
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the ID of the Student.';
                    Style = Strong;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Enrollment No. of the Student.';
                    Style = Strong;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Name of the Student.';
                    Style = Strong;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Academic Year of the Student.';
                    Style = Strong;
                    Editable = false;
                }
                field("System Ref. No."; Rec."System Ref. No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Affilated Hospital No. if Exist.';
                    Caption = 'Hospital No.';
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Name.';
                }
                field("Address"; Rec."Address")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Address 2.';
                }
                field("City"; Rec."City")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the City.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Post Code.';
                }
                field("Contact"; Rec."Contact")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Contact.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Phone No..';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Country/Region Code.';
                }
                field("Sponsoring Institution"; Rec."Sponsoring Institution")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Sponsoring Institution.';
                }

                field("Sponsored Programs"; Rec."Sponsored Programs")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Sponsored Programs.';
                }
                field("Confirmed"; Rec."Confirmed")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Confirmed.';
                }

                field("Confirmed On"; Rec."Confirmed On")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Confirmed On.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Hospital Card")
            {
                ShortcutKey = 'Ctrl+D';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Card;
                ApplicationArea = All;

                // trigger OnAction()
                // var
                //     Vendor: Record Vendor;
                //     HospitalCard: page "Hospital Card";
                // begin
                //     if Rec."System Ref. No." = '' then
                //         Error('Affiliated Hospital not found for the No. %1 (%2).', Rec."Application No.", Rec.Name);

                //     Vendor.Reset();
                //     Vendor.FilterGroup(2);
                //     Vendor.SetRange("No.", Rec."System Ref. No.");
                //     Vendor.FilterGroup(0);
                //     HospitalCard.SetTableView(Vendor);
                //     HospitalCard.Editable(false);
                //     HospitalCard.RunModal();
                // end;
            }
        }
    }
}
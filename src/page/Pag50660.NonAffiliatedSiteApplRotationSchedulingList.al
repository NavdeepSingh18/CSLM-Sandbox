page 50660 "Non-Afltd Rotation Scheduling"
{
    Caption = 'Non-Affiliated Application Rotation Scheduling';
    PageType = List;
    SourceTable = "Non-Affiliated Hospital";
    SourceTableView = sorting(Status) where(Confirmed = filter(true), Status = filter(Approved), "Rotation ID" = filter(''));
    // CardPageId = "Non-Afltd Rotation Schedule";
    UsageCategory = Lists;
    ApplicationArea = All;
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
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Name of the Student.';
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Academic Year of the Student.';
                    Editable = false;
                }

                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Name.';
                    Style = Strong;
                }
                field("System Ref. No."; Rec."System Ref. No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Non-Affilated Hospital No.';
                    Caption = 'Hospital No.';
                    Style = Strong;
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
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Course for the Rotation.';
                    Style = Unfavorable;
                    ShowMandatory = true;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Course for the Rotation.';
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Prefix of Subject for the Rotation.';
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Course of Elective Rotation.';
                    Style = Unfavorable;
                    ShowMandatory = true;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Course of Elective Rotation.';
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Start Date of Rotation.';
                    Style = Unfavorable;
                    ShowMandatory = true;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the No. of Week(s) of Rotation.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the End Date of Rotation.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Confirmed"; Rec."Confirmed")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Confirmed.';
                    Style = Strong;
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
            action("Schedule Rotation")
            {
                Caption = 'Schedule Rotation';
                ShortcutKey = 'Ctrl+S';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SuggestWorkMachCost;
                ApplicationArea = All;
                trigger OnAction()
                var
                    NonAffiliatedHospital: Record "Non-Affiliated Hospital";
                    Text001Lbl: Label 'Total Application      ############1################\';
                    Text002Lbl: Label 'Application In Progress      ############2################\';
                    T: Integer;
                    C: Integer;
                    W: Dialog;
                begin
                    NonAffiliatedHospital.Reset();
                    CurrPage.SetSelectionFilter(NonAffiliatedHospital);
                    T := NonAffiliatedHospital.Count;

                    if not Confirm('You have Selected %1 Applications.\\\Do you want to Schedule Rotation(s) for the Selected Records?', true, T) then
                        exit;

                    W.Open('Scheduling Rotations..\' + Text001Lbl + Text002Lbl);

                    NonAffiliatedHospital.Reset();
                    CurrPage.SetSelectionFilter(NonAffiliatedHospital);
                    if NonAffiliatedHospital.FindSet() then begin
                        T := NonAffiliatedHospital.Count;
                        C := 0;
                        repeat
                            C += 1;
                            W.Update(1, T);
                            W.Update(2, C);
                            Rec.CreateRotation(NonAffiliatedHospital);
                        until NonAffiliatedHospital.Next() = 0;
                    end;

                    W.Close();
                    Message('%1 Rotations(s) Scheduled Successfully.', C);
                end;
            }
        }
    }
}
page 50246 "Application Receipt-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       Post Journal - OnAction()                  Code add for post appliction
    // 02    CSPL-00059   07/01/2019       OnAction()                                 Code add for run report
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Application Receipt';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Application-CS";
    SourceTableView = SORTING("No.")
                      WHERE("Application Status" = FILTER(>= Sold));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Date of Receive"; Rec."Date of Receive")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost"; Rec."Registration Cost")
                {
                    ApplicationArea = All;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cheque / DD No."; Rec."Cheque / DD No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cheque / DD Date"; Rec."Cheque / DD Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prospectus No."; Rec."Prospectus No.")
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Receive)
            {
                Caption = '&Receive';
                action("Post Journal")
                {
                    Caption = '&Receive';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        AdmissionStage1CS: Codeunit "Admission Stage1-CS";
                    //   Process: Option Sales,Registration;
                    begin
                        //Code added for posting application::CSPL-00059::07012019: Start
                        IF Rec."Application Status" = Rec."Application Status"::Received THEN
                            ERROR('Applicant Already Paid the Amount');
                        IF AdmissionStage1CS.RegistrationDateCheckCS(Rec."Course Code") THEN
                            IF CONFIRM(Text000Lbl, TRUE) THEN
                                AdmissionStage1CS.ReceiptUpdateCS(Rec."No.");
                        //Code added for posting application::CSPL-00059::07012019: End
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for run report::CSPL-00059::07012019: Start
                        ApplicationCS.Reset();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FINDFIRST() THEN
                            REPORT.RUNMODAL(50074, TRUE, FALSE, ApplicationCS);
                        //Code added for run report::CSPL-00059::07012019: End
                    end;
                }
            }
        }
    }

    var
        ApplicationCS: Record "Application-CS";
        Text000Lbl: Label 'Do you want to Receive this Application ?';
}
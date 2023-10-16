page 50210 "Stud Appl Eligible Select-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      <Action1102155017> - OnAction()               Code added for Send offer.
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Appl Eligible Selection';
    Editable = false;
    PageType = List;
    SourceTable = "Stage Selection Details1-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
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
                field(Quota; Rec.Quota)
                {
                    ApplicationArea = All;
                }
                field("Eligibility Quota"; Rec."Eligibility Quota")
                {
                    ApplicationArea = All;
                }
                field("Eligibility Percertage"; Rec."Eligibility Percertage")
                {
                    ApplicationArea = All;
                }
                field("Eligibility Quota Rank"; Rec."Eligibility Quota Rank")
                {
                    ApplicationArea = All;
                }
                field("Eligibility Rank"; Rec."Eligibility Rank")
                {
                    ApplicationArea = All;
                }
                field("Application Selection"; Rec."Application Selection")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Send Call Letter")
            {
                Caption = '&Send Call Letter';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ActionSaleStage1CS: Codeunit "Action Sale Stage1-CS";
                begin
                    //Code added for Send Offer::CSPL-00059::07022019: Start
                    ActionSaleStage1CS.SendCallLetterValid(Rec."Course Code", Rec."Selection List No.");
                    //Code added for Send Offer::CSPL-00059::07022019: End
                end;
            }
        }
    }
}
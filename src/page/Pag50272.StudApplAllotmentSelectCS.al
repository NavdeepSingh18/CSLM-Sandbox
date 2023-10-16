page 50272 "Stud Appl Allotment Select-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   14/02/2019      <Action1102155023> - OnAction()           Code added for get waiting detail and report run.
    // 02    CSPL-00059   14/02/2019      <Action1102155015> - OnAction()           Code added for student dmission and run report.
    // 03    CSPL-00059   14/02/2019      LOCAL AllotedOnAfterValidate()            Code added for data validation.
    // 04    CSPL-00059   14/02/2019      Alloted - OnValidate()                    Code added for call function.

    Caption = 'Stud Appl Allotment Select-CS';
    PageType = List;
    SourceTable = "Stage Selection Details2-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quota; Rec.Quota)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Selected Quota"; Rec."Selected Quota")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Selection Percentage"; Rec."Selection Percentage")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Selection Rank"; Rec."Selection Rank")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Selected Quota Rank"; Rec."Selected Quota Rank")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Alloted; Rec.Alloted)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for call function::CSPL-00059::14022019: Start
                        AllotedOnAfterValidate();
                        //Code added for call function::CSPL-00059::14022019: End
                    end;
                }
                field("Reason For Demotion"; Rec."Reason For Demotion")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&List")
            {
                Caption = '&List';
                action("&Waiting List")
                {
                    Caption = '&Waiting List';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for get waiting detail and report run::CSPL-00059::14022019: Start
                        ActionSaleStage2CS.WaitingListShowCS(Rec."Course Code", Rec."Selection List No.");
                        //Code added for get waiting detail and report run::CSPL-00059::14022019: End
                    end;
                }
            }
        }
        area(processing)
        {
            action("Se&nd Admission Letter")
            {
                Caption = 'Se&nd Admission Letter';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for student dmission and run report::CSPL-00059::14022019: Start
                    ActionSaleStage2CS.AdmissionLetterSendCS(Rec."Course Code", Rec."Selection List No.");
                    //Code added for student dmission and run report::CSPL-00059::14022019: End
                end;
            }
        }
    }

    var

        ActionSaleStage2CS: Codeunit "Action Sale Stage2-CS";
        Text007Lbl: Label 'Do you want to Demote the Candidate from Admission List ?';

    local procedure AllotedOnAfterValidate()
    begin
        //Code added for data validation::CSPL-00059::14022019: Start
        IF NOT CONFIRM(Text007Lbl) THEN
            Rec.Alloted := xRec.Alloted
        ELSE BEGIN
            ActionSaleStage2CS.DemotionApplicantCS(Rec."Application No.", Rec."Course Code", Rec."Selection List No.");
            Rec."Is Demoted" := TRUE;
            Rec."Is Promoted" := FALSE;
            CurrPage.Update();
        END;
        //Code added for data validation::CSPL-00059::14022019: End
    end;
}
page 50273 "Stud Appl Allotment Wt-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   14/02/2019      LOCAL AllotedOnAfterValidate()            Code added for data validation.
    // 02    CSPL-00059   14/02/2019      Alloted - OnValidate()                    Code added for call function.

    Caption = 'Stud Appl Allotment Wt-CS';
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
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quota; Rec.Quota)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Selected Quota"; Rec."Selected Quota")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Selection Percentage"; Rec."Selection Percentage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Selection Rank"; Rec."Selection Rank")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Selected Quota Rank"; Rec."Selected Quota Rank")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Reason For Promotion"; Rec."Reason For Promotion")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var

        SelProcessStage2: Codeunit "Action Sale Stage2-CS";
        Text006Lbl: Label 'Do you want to Promote the Candidate for Admission List ?';

    local procedure AllotedOnAfterValidate()
    begin
        //Code added for data validation::CSPL-00059::14022019: Start
        IF NOT CONFIRM(Text006Lbl) THEN
            Rec.Alloted := xRec.Alloted
        ELSE BEGIN
            SelProcessStage2.PromotionApplicantCS(Rec."Application No.", Rec."Course Code", Rec."Selection List No.");
            Rec."Is Promoted" := TRUE;
            Rec."Is Demoted" := FALSE;
            CurrPage.Update();
        END;
        //Code added for data validation::CSPL-00059::14022019: End
    end;
}


page 50209 "Formula Course Stage1-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      Generate - OnAction()                Code added for Generate Formula1.
    ApplicationArea = All;
    UsageCategory = Administration;
    AutoSplitKey = false;
    Caption = 'Course Stage1 Formula';
    DataCaptionFields = "Course Code", "Line No.", "List No.";
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Course Eligible Summary-CS";

    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Prequalification; Rec.Prequalification)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Order Number"; Rec."Order Number")
                {
                    ApplicationArea = All;
                }
                field("Check Eligibility"; Rec."Check Eligibility")
                {
                    ApplicationArea = All;
                }
                field("Optional Subject"; Rec."Optional Subject")
                {
                    ApplicationArea = All;
                }
                field(Stream; Rec.Stream)
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
            // action("Generate Formula1")
            // {
            //     Caption = '&Generate';
            //     Promoted = true;
            //     PromotedOnly = true;
            //     PromotedCategory = Process;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         SaleFormulaActionCS: Codeunit "Sale Formula Action-CS";
            //     begin
            //         //Code added for Generate Formula1::CSPL-00059::07022019: Start
            //         SaleFormulaActionCS.CreateProgStage1Formula("Course Code", "Course Line No.", "List No.", '=');
            //         CurrPage.Close();
            //         //Code added for Generate Formula1::CSPL-00059::07022019: Start
            //     end;
            // }
        }
    }
}
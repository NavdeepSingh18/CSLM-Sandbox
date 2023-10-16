page 50207 "Formula Course Stage2-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      Generate - OnAction()                Code added for Generate Formula.

    Caption = 'Course Stage2 Formula';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Course Ranking Summary-CS";

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
            }
        }
    }

    actions
    {
        area(processing)
        {
            // action(Generate)
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
            //         //Code added for Generate Formula::CSPL-00059::07022019: Start
            //         SaleFormulaActionCS.CreateProgStage2Formula(Code, "Course Line No.", "List No.", '*');
            //         CurrPage.Close();
            //         //Code added for Generate Formula::CSPL-00059::07022019: End
            //     end;
            // }
        }
    }
}
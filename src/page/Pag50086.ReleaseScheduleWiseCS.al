page 50086 "Release Schedule Wise -CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                   Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  16-05-19   Execute - OnAction()     Exam Schedule Generation.
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Exam Schedule No"; ExamScheduleNo)
            {
                ApplicationArea = All;
                Caption = 'Exam Schedule No';
                TableRelation = "Exam Time Table Head-CS"."No.";
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Execute)
            {
                Image = ExecuteBatch;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Exam Schedule Generation::CSPL-00174::160519: Start
                    IF NOT CONFIRM('Do You Want To Release All The Document ?', FALSE) THEN
                        EXIT
                    ELSE BEGIN
                        ExamScheduleGeneration.ReleaseAllCS(ExamScheduleNo);
                        MESSAGE('All Documents Have Been Released !!');
                    END;
                    //Code added for Exam Schedule Generation::CSPL-00174::160519: End
                end;
            }
        }
    }

    var
        ExamScheduleGeneration: Codeunit "Schedule Exam Gen-CS";
        ExamScheduleNo: Code[20];

}
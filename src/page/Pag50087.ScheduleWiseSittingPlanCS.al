page 50087 "Schedule Wise Sitting Plan-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                  Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  08-07-19   Execute - OnAction()     Code added for Create New Sitting Plan.

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
            field("Institute Code"; InstituteCode)
            {
                Caption = 'Institute Code';
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('INSTITUTE'));
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Execute)
            {
                ToolTip = 'Execute';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                VAR
                    InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
                begin
                    //Code added for Create New Sitting Plan::CSPL-00174::080719: Start
                    IF NOT CONFIRM(Text_10001Lbl, FALSE) THEN
                        EXIT
                    ELSE
                        InformationOfStudentCS.GenerateSittingPlanNewCS(InstituteCode, ExamScheduleNo);
                    CurrPage.UPDATE();
                    //Code added for Create New Sitting Plan::CSPL-00174::080719: End
                end;
            }
        }
    }

    var
        ExamScheduleNo: Code[20];
        InstituteCode: Code[20];
        Text_10001Lbl: Label 'Do You Want To Generate Sitting Plan ?';
}
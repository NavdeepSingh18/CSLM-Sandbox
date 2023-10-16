page 50062 "Group(Enquiry) SubPage-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  11-05-19   Maximum Marks - OnValidate()                Code added for current page update.
    // 02.   CSPL-00174  11-05-19   Weightage - OnValidate()                    Code added for function call.
    // 03.   CSPL-00174  11-05-19   Function-LOCAL WeightageOnAfterValidate()   Code added for current page update.

    AutoSplitKey = true;
    Caption = 'Group(Enquiry) SubPage-CS';
    Editable = true;
    PageType = ListPart;
    UsageCategory = Administration;
    ApplicationArea = All;
    RefreshOnActivate = true;
    SourceTable = "Sessional Exam Group Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Exam Method"; Rec."Exam Method")
                {
                    ApplicationArea = All;
                }
                field("Method Description"; Rec."Method Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maximum Marks"; Rec."Maximum Marks")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Maximum Marks';

                    trigger OnValidate()
                    begin
                        //Code added for update current page::CSPL-00174::110519: Start
                        CurrPage.Update();
                        //Code added for update current page::CSPL-00174::110519: End
                    end;
                }
                field(Order; Rec.Order)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;
                }
                field(Weightage; Rec.Weightage)
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        //Code added for function call::CSPL-00174::110519: Start
                        WeightageOnAfterValidate();
                        //Code added for function call::CSPL-00174::110519: End
                    end;
                }
            }
        }
    }

    local procedure WeightageOnAfterValidate()
    begin
        //Code added for current page update::CSPL-00174::110519: Start
        CurrPage.UPDATE(TRUE);

        //Code added for current page update::CSPL-00174::110519: End
    end;
}


page 50043 "Edu Calendar-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id       Date        Trigger                            Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.    CSPL-00174  07-05-19    CalendarGeneration - OnAction()    Code added to generate education calender .
    // 02.    CSPL-00174  07-05-19    UpdateDayOrder - OnAction()        Code added to assign day order in education calender.

    Caption = 'Education Calendar Card';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Education Calendar-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Edu Calendar SubPage-CS")
            {
                SubPageLink = Code = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("F&unction")
            {
                Caption = 'F&unction';
                action(CalendarGeneration)
                {
                    Caption = 'Calendar Generation';
                    ApplicationArea = All;
                    Image = Calendar;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        //Code aded to generate education calender ::CSPL-00174::070519: Start
                        EducationTimeTableCS.GenerateCale(Rec.Code, Rec."Academic Year", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code");
                        //Code added to generate the education calender ::CSPL-00174::070519: END
                    end;
                }
                // action("Off Days")
                // {
                //     Caption = 'Off Days';
                //     ApplicationArea = All;
                //     Image = Holiday;
                //     Promoted = true;
                //     PromotedOnly = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Off Day Edu Calendar Setup-CS";
                //     RunPageLink = Code = FIELD(Code);
                // }
                action(UpdateDayOrder)
                {
                    Caption = 'Update DayOrder';
                    ApplicationArea = All;
                    Image = Order;
                    Visible = false;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin

                        //Code added to assign  day order in education calender::CSPL-00174::070519: Start
                        EducationTimeTableCS.AssignDayShorting();
                        //Code added to assign day order in education calender::CSPL-00174::070519: END
                    end;
                }
                action(Holidays)
                {
                    Caption = 'Holidays';
                    ApplicationArea = All;
                    Image = Holiday;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    RunObject = Page "Holiday Edu Calendar Setup-CS";
                    RunPageLink = Code = FIELD(Code);

                }
            }
        }
    }

    var
        EducationTimeTableCS: Codeunit "Education Time Table-CS";
}
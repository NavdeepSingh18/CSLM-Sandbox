page 50033 "List Academic Year-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger                  Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.    CSPL-00174  06-05-19   YearClose- OnAction()    Code added for Year Close.
    // 02.    CSPL-00174  06-05-19   AssignYear - OnAction()  Code added for Assign Year.
    // 03.    CSPL-00174  06-05-19   ResetYear - OnAction()   Code added for Reset Year.

    Caption = 'List Academic Year-CS';
    Editable = true;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Academic Year Master-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(ll; Rec.Closed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unction")
            {
                Caption = 'F&unction';

                action(CloseYear)
                {
                    Caption = '&Close Year';
                    Image = CloseYear;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Year Close  ::CSPL-00174::060519: Start
                        VerticalEducationCS.CloseSession_Year(Rec.Code);
                        //Code added for Year Close::CSPL-00174::060519: End
                    end;
                }
                action(AssignYear)
                {
                    Caption = '&Assign Year';
                    Image = Apply;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Assign Year::CSPL-00174::060519: Start
                        VerticalEducationCS.OpenSession_Year(Rec.Code);
                        //Code added for Assign Year::CSPL-00174::060519: End
                    end;
                }
                action(ResetYear)
                {
                    Caption = '&Reset Year';
                    Image = ResetStatus;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Reset Year::CSPL-00174::060519: Start
                        VerticalEducationCS.ResetAcademicYr(Rec.Code);
                        //Code added for Reset Year::CSPL-00174::060519: End
                    end;
                }
            }
        }
    }

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


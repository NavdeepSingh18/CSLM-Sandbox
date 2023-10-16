page 50332 "Calendar Generation-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       <Action1102155004> - OnAction()              Code added to Generate Time Table

    Caption = 'Calendar Generation';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            field("Academic Year Master CS"; AcademicYearMasterCS)
            {

                Caption = 'AcademicYearMasterCS';
                TableRelation = "Academic Year Master-CS";
                ApplicationArea = all;
            }
            /*  field(OptSem; OptSem)
              {
                  optionCaption = 'Semester Type';
                  ApplicationArea = all;
              }*/
        }
    }

    actions
    {
        area(processing)
        {
            action("&Generate")
            {
                Caption = '&Generate';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CalendarGenerationCS: Codeunit "Calendar Generation-CS";
                begin
                    //Code added for Generate Time Table::CSPL-00059::07022019: Start
                    CalendarGenerationCS.CreateTimeTable(AcademicYearMasterCS, OptSem);
                    //Code added for Generate Time Table::CSPL-00059::07022019: End
                end;
            }
        }
    }

    var
        AcademicYearMasterCS: Code[20];
        OptSem: Option " ",Odd,Even;

}


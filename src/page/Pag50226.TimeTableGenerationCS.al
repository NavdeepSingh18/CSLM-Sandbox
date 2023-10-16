page 50226 "Time Table Generation-CS"
{
    // version V.001-CS

    // Sr.No.   Emp.ID        Date       Triggers                     Remarks
    // .............................................................................................
    // 01.     CSPL-00174    05-01-19   College Code - OnLookup      Code added for get value of college code & run page
    // 02.     CSPL-00174    05-01-19   Generate - OnAction()        Code added for generate Time table

    Caption = 'Time Table Generation-CS';
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            field("College Code"; CollegeCode)
            {
                Caption = 'College Code';
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    //Code added for get college code & run page::CSPL::050119: Start
                    DimensionValue.Reset();
                    DimensionValue.SETRANGE("Dimension Code", 'INSTITUTE');
                    IF PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK THEN
                        CollegeCode := DimensionValue.Code;

                    //Code added for get college code & run page::CSPL::050119: End
                end;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Generate)
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Code added for generate Time table ::SPL-00174::050119: Start
                    IF CONFIRM(Text_10001Lbl, FALSE) THEN
                        // EventsOfExaminationCS.CSCreateAutomateTimeTable(CollegeCode)
                    CurrPage.Close();
                    //Code added for generate Time table::SPL-00174::050119: End
                end;
            }
        }
    }

    var
        DimensionValue: Record "Dimension Value";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        CollegeCode: Code[20];

        Text_10001Lbl: Label 'Do You Want To Generate Time Table ?';

}


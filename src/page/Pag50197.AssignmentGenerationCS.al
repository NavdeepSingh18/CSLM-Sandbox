page 50197 "Assignment Generation-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    19-05-2019    Institute Code - OnLookup           Select and Assign value in Field
    // 2         CSPL-00092    19-05-2019    Generate - OnAction                 Generate Internal Assignment Detail

    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            field("Institute Code"; InstituteCode)
            {
                Caption = 'Institute Code';
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    //Code added for Select and Assign value in Field::CSPL-00092::19-05-2019: Start
                    DimensionValue.Reset();
                    DimensionValue.SETRANGE("Dimension Code", 'INSTITUTE');
                    IF PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK THEN
                        InstituteCode := DimensionValue.Code;

                    //Code added for Select and Assign value in Field::CSPL-00092::19-05-2019: End
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
                    //Code added for Generate Internal Assignment Detail::CSPL-00092::19-05-2019: Start
                    IF CONFIRM(Text_10001Lbl, FALSE) THEN
                        // EventsOfExaminationCS.CSCreateAutomateInternalAssignmentDetails(InstituteCode);

                    CurrPage.Close();
                    //Code added for Generate Internal Assignment Detail::CSPL-00092::19-05-2019: End
                end;
            }
        }
    }

    var


        DimensionValue: Record "Dimension Value";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        InstituteCode: Code[20];
        Text_10001Lbl: Label 'Do You Want To Generate Assingment Details ?';
}
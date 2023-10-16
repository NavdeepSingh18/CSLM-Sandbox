page 50193 "Exam Grp Creation-Internal-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger               Remarks
    // 1         CSPL-00092    18-05-2019    OnInsert              Institute Code - OnLookup Select and Assign Value in Field
    // 2         CSPL-00092    18-05-2019    Generate - OnAction   Generate Internal Exam Group Subject

    Caption = 'Internal Exam Group Creation';
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
                    //Code added for Select and Assign Value in Field::CSPL-00092::18-05-2019: Start
                    DimensionValue.Reset();
                    DimensionValue.SETRANGE("Dimension Code", 'INSTITUTE');
                    IF PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK THEN
                        InstituteCode := DimensionValue.Code;
                    //Code added for Select and Assign Value in Field::CSPL-00092::18-05-2019: End
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
                    //Code added for Select and Assign Value in Field::CSPL-00092::18-05-2019: Start
                    IF CONFIRM(Text_10001Lbl, FALSE) THEN
                        // ExaminationEvents.CSCreateAutomateInternalExamGroupSubjClassWise(InstituteCode);
                    CurrPage.Close();
                    //Code added for Select and Assign Value in Field::CSPL-00092::18-05-2019: End
                end;
            }
        }
    }

    var
        DimensionValue: Record "Dimension Value";
        // ExaminationEvents: Codeunit "Events Of Examination-CS";
        InstituteCode: Code[20];

        Text_10001Lbl: Label 'Do You Want To Generate Internal Exam Group ?';
}


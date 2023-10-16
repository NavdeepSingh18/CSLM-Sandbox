page 50060 "Classification of fee-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  12-05-19   E&dit - OnAction()     Code added to make the form editable.
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Classification of fee-CS';
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "Fee Classification Master-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Tooltip = 'Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Tooltip = 'Description';
                    ApplicationArea = All;
                }
                field("Credit Card Bank Account No."; Rec."Credit Card Bank Account No.")
                {
                    Tooltip = 'Credit Card Bank Account No.';
                    ApplicationArea = All;
                }
                field("EFT Bank Account No."; Rec."EFT Bank Account No.")
                {
                    ApplicationArea = all;
                }
                field("Wire Trans. Bank Account No."; Rec."Wire Trans. Bank Account No.")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(" E&dit")
            {
                ToolTip = 'Edit';
                Image = Edit;
                Caption = 'Edit';
                Promoted = true;
                PromotedOnly = true;

                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added to make the form editable::CSPL-00174::120519: Start
                    CurrPage.EDITABLE := TRUE;
                    //Code added to make the form editable::CSPL-00174::120519: End
                end;
            }
        }
    }
}
page 50183 "Category List-CS"
{
    // version V.001-CS

    // Sr.No Emp.ID        Date       Trigger                Remarks
    // ------------------------------------------------------------------------------------------------------------
    // 01.   CSPL-00174    03-02-19   E&dit - OnAction()    Code added to make form Editable.

    Caption = 'Category List-CS';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Category Master-CS";

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
                field("Fee Classification"; Rec."Fee Classification")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
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
                Caption = ' E&dit';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added to make form Editable::CSPL-00174::030219: Start
                    CurrPage.EDITABLE := TRUE;
                    //Code added to make form Editable::CSPL-00174::030219: End
                end;
            }
        }
    }
}


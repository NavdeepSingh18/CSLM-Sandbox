page 50351 "Stage List-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       OnOpenPage()                Code added for open page college wise.

    Caption = 'Stage List';
    Editable = true;
    PageType = List;
    SourceTable = "Lesson Master-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Gurop)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
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
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // Start 01. VANDHANA
                    CurrPage.EDITABLE := TRUE;
                    // Stop 01. VANDHANA
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for open page college wise::CSPL-00059::07022019: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for open page college wise::CSPL-00059::07022019: End
    end;

    var
        recUserSetup: Record "User Setup";
}


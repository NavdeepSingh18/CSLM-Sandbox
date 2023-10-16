page 50399 "Issues Header Stage1-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       Select All - OnAction()                     Code added for line selection.

    Caption = 'Issues Header Stage1-CS';
    PageType = Card;
    SourceTable = "Indent H-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field("Issue For"; Rec."Issue For")
                {
                    ToolTip = 'Issue For';
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Issue Date';
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'User Id';
                    ApplicationArea = All;
                }
            }
            part("Issue Line"; 50400)
            {
                ApplicationArea = All;
                SubPageLink = "Document No" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Select All")
            {
                Image = SelectField;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Code added for line selection::CSPL-00059::07022019: Start
                    IF CONFIRM(TXT0002Lbl, TRUE) THEN BEGIN
                        GVar_IndentLCS.RESET();
                        IF GVar_IndentLCS.FindSet() THEN
                            REPEAT
                                GVar_IndentLCS.Select := TRUE;
                                GVar_IndentLCS.MODIFY(TRUE);
                            UNTIL GVar_IndentLCS.NEXT() = 0;
                    END;
                    //Code added for line selection::CSPL-00059::07022019: End
                end;
            }
        }
    }

    var
        GVar_IndentLCS: Record "Indent L-CS";
        TXT0002Lbl: Label 'Do you want to select all indent?';




}
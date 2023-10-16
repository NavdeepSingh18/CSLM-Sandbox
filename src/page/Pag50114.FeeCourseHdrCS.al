page 50114 "Fee Course Hdr-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                  Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  13-05-19   OnOpenPage()               Code added for boolian field true.
    // 02.   CSPL-00174  13-05-19   No. - OnAssistEdit()       Code added for  generate No.Series .
    // 03.   CSPL-00174  13-05-19   Course Code - OnValidate() Code added for Editable or Non-Editable.
    // 04.   CSPL-00174  13-05-19   Other Fees - OnValidate()  Code added to fields blank and Editable or Non-Editable.
    // 05.   CSPL-00174  13-05-19   CopyFee - OnAction()       Code added for  Report run.

    Caption = 'Fee Course Header';
    DeleteAllowed = true;
    UsageCategory = None;

    PageType = Card;
    SourceTable = "Fee Course Head-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //Code added for generate No.Series ::CSPL-00174::130519:Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        //Code added for generate No.Series ::CSPL-00174::130519: End
                    end;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = Bool;

                    trigger OnValidate()
                    begin
                        //Code added for Editable or Non-Editable:CSPL-00174::130519: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN BEGIN
                            Edit_Var_Sem := TRUE;
                            Edit_Var_Yr := FALSE;
                        END;
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            Edit_Var_Sem := FALSE;
                            Edit_Var_Yr := TRUE;
                        END;
                        //Code added for Editable or Non-Editable::CSPL-00174::130519: End
                    end;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Other Fees"; Rec."Other Fees")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for Field blank and Editable or Non-Editable::CSPL-00174::130519: Start
                        IF Rec."Other Fees" = TRUE THEN BEGIN
                            Bool := FALSE;
                            Rec."Course Code" := '';
                            Rec."Course Name" := '';
                            Rec."Program" := '';
                        END ELSE
                            Bool := TRUE;
                        //Code added for Field blank and Editable or Non-Editable::CSPL-00174::130519: End
                    end;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = Bool;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = Bool;
                }

                field("Admitted Year"; Rec."Admitted Year")
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
            }
            part("Course Fees Line"; 50115)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = ALL;
            }
            group(Installment)
            {
                Caption = 'Installment';
                Visible = false;
                field("No Of Installment"; Rec."No Of Installment")
                {
                    ApplicationArea = aLL;
                }
                field("Installment Charges"; Rec."Installment Charges")
                {
                    ApplicationArea = aLL;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Fees Copy")
            {
                Caption = 'Fees Copy';
                action("Fee Copy")
                {
                    Caption = 'Copy Fees';
                    //RunObject = Page "Copy Fee Document";
                    PromotedCategory = Process;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    // trigger OnAction()
                    // var
                    //     CopyFeePage: Page "Copy Fee Document";
                    // begin
                    //     CopyFeePage.VariablePassing("No.");
                    //     CopyFeePage.RunModal();
                    // end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for boolian field true::CSPL-00174::130519: Start
        Bool := TRUE;
        //Code added for boolian field true::CSPL-00174::130519: End
    end;

    var
        Bool: Boolean;
        Edit_Var_Sem: Boolean;
        Edit_Var_Yr: Boolean;


}
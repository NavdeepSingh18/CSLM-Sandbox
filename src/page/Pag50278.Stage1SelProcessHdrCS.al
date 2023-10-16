page 50278 "Stage1 Sel Process Hdr-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       OnAction()                              Code add for showing selection process
    // 02    CSPL-00059   07/01/2019       OnAction()                              Code add for showing waiting list
    // 03    CSPL-00059   07/01/2019       OnAction()                              Code add for selection process

    Caption = 'Stage1 Sel Process Hdr-CS';
    PageType = Card;
    SourceTable = "Sel Process Stage H1-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
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
                        // Start 01.VIGNESH
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        // Stop 01.VIGNESH
                    end;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Stage1 Selection List No."; Rec."Stage1 Selection List No.")
                {
                    ApplicationArea = All;
                }
                field("Number of Students"; Rec."Number of Students")
                {
                    ApplicationArea = All;
                }
                field("Application Receive Till Date"; Rec."Application Receive Till Date")
                {
                    ApplicationArea = All;
                }
                field("Excempt Rules - Reserve Quota"; Rec."Excempt Rules - Reserve Quota")
                {
                    ApplicationArea = All;
                }
                field("Excempt Rules - Staff Child"; Rec."Excempt Rules - Staff Child")
                {
                    ApplicationArea = All;
                }
                field("Consider Break Students"; Rec."Consider Break Students")
                {
                    ApplicationArea = All;
                }
            }
            part("Lines"; 50279)
            {
                Editable = false;
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Selection")
            {
                Caption = '&Selection';
                action("Stage1 &Selection List")
                {
                    Caption = 'Stage1 &Selection List';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for showing selection process::CSPL-00059::07012019: Start
                        ActionSaleStage1CS.ShowSelectionListVlid(Rec."Course Code", Rec."Stage1 Selection List No.");
                        //Code added for showing selection process::CSPL-00059::07012019: End
                    end;
                }
                action("Stage1 &Waiting List")
                {
                    Caption = 'Stage1 &Waiting List';
                    ApplicationArea = All;
                    trigger OnAction()
                    var

                    begin
                        //Code added for showing waiting list::CSPL-00059::07012019: Start
                        ActionSaleStage1CS.ShowWaitingListValid(Rec."Course Code", Rec."Stage1 Selection List No.");
                        //Code added for showing waiting list::CSPL-00059::07012019: End
                    end;
                }
            }
            group("F&unction")
            {
                Caption = 'F&unction';
                action("&Stage1Generation")
                {
                    Caption = '&Stage1Generation';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for selection process::CSPL-00059::07012019: Start
                        ActionSaleStage1CS.Stage1SelectionProcessValid(Rec."No.");
                        //Code added for selection process::CSPL-00059::07012019: Start
                    end;
                }
            }
        }
    }

    var
        ActionSaleStage1CS: Codeunit "Action Sale Stage1-CS";
}
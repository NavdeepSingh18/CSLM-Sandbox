page 50276 "Stage2 Sel Process Hdr-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       OnAction()                              Code add for showing stage 2 selection process
    // 02    CSPL-00059   07/01/2019       OnAction()                              Code add for selection stage 2 process

    Caption = 'Sel Process Stage2 Header';
    PageType = Card;
    SourceTable = "Sel Process Stage H2-CS";
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
                field("Stage2 Selection List No."; Rec."Stage2 Selection List No.")
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
            part("Lines"; 50277)
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
                action("Stage&2 List")
                {
                    Caption = 'Stage&2 List';
                    ApplicationArea = All;
                    // trigger OnAction()
                    // var
                    //     ActionSaleStage2CS: Codeunit "Action Sale Stage2-CS";
                    // begin
                    //     //Code added for showing stage 2 selection process::CSPL-00059::07012019: Start
                    //     ActionSaleStage2CS.SelectionListShowCS(Rec."Course Code", Rec."Stage2 Selection List No.");
                    //     //Code added for showing stage 2 selection process::CSPL-00059::07012019: End
                    // end;
                }
            }
            group("F&unction")
            {
                Caption = 'F&unction';
                action("&Stage2Generation")
                {
                    Caption = '&Stage2Generation';
                    ApplicationArea = All;
                    // trigger OnAction()
                    // begin
                    //     //Code added for selection stage 2 process::CSPL-00059::07012019: Start
                    //     ActionSaleStage2CS.SelectionProcessStage2CS(Rec."No.", Rec."Academic Year");
                    //     //Code added for selection stage 2 process::CSPL-00059::07012019: End
                    // end;
                }
            }
        }
    }

    var
    // ActionSaleStage2CS: Codeunit "Action Sale Stage2-CS";
}
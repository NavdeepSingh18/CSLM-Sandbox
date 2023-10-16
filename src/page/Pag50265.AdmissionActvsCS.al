page 50265 "Admission Actvs-CS"
{
    // version V.001-CS

    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Finance Cue";

    layout
    {
        area(content)
        {
            cuegroup(Payments)
            {
                Caption = 'Payments';

                field("Overdue Student  Payment"; Rec."Overdue Sales Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Overdue Sales Documents';
                    DrillDownPageID = "Customer Ledger Entries";
                }
                field("Purchase Invoices Due Today"; Rec."Purchase Documents Due Today")
                {
                    ApplicationArea = All;
                    ToolTip = 'Purchase Documents Due Today';
                    DrillDownPageID = "Vendor Ledger Entries";
                }
                //Code Comment The Web client does not support displaying both Actions and Fields in the Cue Group 'Payments'. Only Fields will be displayed.
                /*   actions
                   {
                       action("Edit Cash Receipt Journal")
                       {
                           Caption = 'Edit Cash Receipt Journal';
                           ToolTip = 'Edit Cash Receipt Journal';
                           RunObject = Page 255;
                           ApplicationArea = All;

                       }
                       action("New Sales Credit Memo")
                       {
                           Caption = 'New Sales Credit Memo';
                           ToolTip = 'New Sales Credit Memo';
                           RunObject = Page 44;
                           RunPageMode = Create;
                           ApplicationArea = All;
                       }
                       action("Edit Payment Journal")
                       {
                           ToolTip = 'Edit Payment Journal';
                           Caption = 'Edit Payment Journal';
                           RunObject = Page 256;
                           ApplicationArea = All;
                       }
                       action("New Purchase Credit Memo")
                       {
                           ToolTip = 'New Purchase Credit Memo';
                           Caption = 'New Purchase Credit Memo';
                           RunObject = Page 52;
                           RunPageMode = Create;
                           ApplicationArea = All;
                       }
                   }*/
            }
            cuegroup("Document Approvals")
            {
                Caption = 'Document Approvals';
                field("POs Pending Approval"; Rec."POs Pending Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'POs Pending Approval';
                    DrillDownPageID = "Purchase Order List";
                }
                field("SOs Pending Approval"; Rec."SOs Pending Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'SOs Pending Approval';
                    DrillDownPageID = "Sales Order List";
                }
                //Code Comment The Web client does not support displaying both Actions and Fields in the Cue Group 'Payments'. Only Fields will be displayed.
                /*    actions
                    {
                        action("Create Reminders...")
                        {
                            ApplicationArea = all;
                            ToolTip = 'Create Reminders...';
                            Caption = 'Create Reminders...';
                            Image = TileBrickCalendar;
                            RunObject = Report 188;
                        }
                        action("Create Finance Charge Memos...")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Create Finance Charge Memos...';
                            Caption = 'Create Finance Charge Memos...';
                            Image = TileCamera;
                            RunObject = Report 191;
                        }
                    }*/
            }
            cuegroup("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                field("New Incoming Documents"; Rec."New Incoming Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'New Incoming Documents';
                    DrillDownPageID = "Incoming Documents";
                }
                field("Approved Incoming Documents"; Rec."Approved Incoming Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Approved Incoming Documents';
                    DrillDownPageID = "Incoming Documents";
                }
                field("OCR Completed"; Rec."OCR Completed")
                {
                    ApplicationArea = All;
                    ToolTip = 'OCR Completed';
                    DrillDownPageID = "Incoming Documents";
                }
                //Code Comment The Web client does not support displaying both Actions and Fields in the Cue Group 'Payments'. Only Fields will be displayed.
                /*   actions
                   {
                       action(CheckForOCR)
                       {
                           ApplicationArea = All;
                           ToolTip = 'Receive from OCR Service';
                           Caption = 'Receive from OCR Service';
                           RunObject = Codeunit 881;
                           RunPageMode = View;
                       }
                   }*/
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;

        Rec.SETFILTER("Due Date Filter", '<=%1', WORKDATE());
        Rec.SETFILTER("Overdue Date Filter", '<%1', WORKDATE());
    end;
}


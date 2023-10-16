// page 50404 "Led. Entries of Bank Acc-CS"
// {
//     // version V.001-CS

//     // Sr.No   Emp.ID      Date            Trigger                                     Remarks
//     // -----------------------------------------------------------------------------------------------
//     // 01    CSPL-00059   07/02/2019       Cheque Reprint Approve - OnAction()         Code added for cheque printing validation.
//     // 02    CSPL-00059   07/02/2019       Stale Cheque - OnAction()                   Code added for Stale Cheque validation.

//     Caption = 'Led. Entries of Bank Acc-CS';
//     DataCaptionFields = "Bank Account No.";
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Bank Account Ledger Entry";
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Bank Account No."; Rec."Bank Account No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Stale Cheque"; Rec.'Stale Cheque')
//                 {
//                     Caption = 'Stale Cheque';
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Stale Cheque Expiry Date"; Rec.'Stale Cheque Expiry Date')
//                 {
//                     Caption = 'Stale Cheque Expiry Date';
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Cheque Stale Date"; Rec.'Cheque Stale Date')
//                 {
//                     Caption = 'Cheque Stale Date';
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Our Contact Code"; Rec."Our Contact Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Amount (LCY)"; Rec."Amount (LCY)")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Remaining Amount"; Rec."Remaining Amount")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Bal. Account Type"; Rec."Bal. Account Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Bal. Account No."; Rec."Bal. Account No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Open; Rec.Open)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Source Code"; Rec."Source Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Reason Code"; Rec."Reason Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Reversed; Rec.Reversed)
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Reversed by Entry No."; Rec."Reversed by Entry No.")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Reversed Entry No."; Rec."Reversed Entry No.")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Location Code"; Rec.'Location Code')
//                 {
//                     Caption = 'Location Code';
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Entry No."; Rec."Entry No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {

//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Ent&ry")
//             {
//                 Caption = 'Ent&ry';
//                 Image = Entry;
//                 action("Check Ledger E&ntries")
//                 {
//                     Caption = 'Check Ledger E&ntries';
//                     Image = CheckLedger;
//                     RunObject = Page 374;
//                     RunPageLink = "Bank Account Ledger Entry No." = FIELD("Entry No.");
//                     RunPageView = SORTING("Bank Account Ledger Entry No.");
//                     ShortCutKey = 'Shift+F7';
//                     ApplicationArea = All;
//                 }
//                 action(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';
//                     ApplicationArea = All;

//                     trigger OnAction()
//                     begin
//                         ShowDimensions();
//                     end;
//                 }
//                 /* action(Narration)
//                  {
//                      Caption = 'Narration';
//                      Image = Description;
//                      ApplicationArea = All;
//                      // RunObject = Page 16578;
//                      //  RunPageLink = "Entry No."=FILTER(0),
//                      //"Transaction No."=FIELD("Transaction No.");
//                  }
//                  action("Line Narration")
//                  {
//                      Caption = 'Line Narration';
//                      Image = LineDescription;
//                      ApplicationArea = All;
//                      //RunObject = Page 16568;
//                      //  RunPageLink = Entry No.=FIELD(Entry No.),
//                      //Transaction No.=FIELD(Transaction No.);
//                  }*/
//                 action("Print Voucher")
//                 {
//                     Caption = 'Print Voucher';
//                     Ellipsis = true;
//                     Image = PrintVoucher;
//                     ApplicationArea = All;
//                     trigger OnAction()
//                     var
//                         GLEntry: Record "G/L Entry";
//                     begin
//                         GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
//                         GLEntry.SETRANGE("Document No.", Rec."Document No.");
//                         GLEntry.SETRANGE("Posting Date", Rec."Posting Date");
//                         IF GLEntry.FindFirst() THEN
//                             REPORT.RUNMODAL(16567, TRUE, TRUE, GLEntry);
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Reverse Transaction")
//                 {
//                     Caption = 'Reverse Transaction';
//                     Ellipsis = true;
//                     Image = ReverseRegister;
//                     ApplicationArea = All;

//                     trigger OnAction()
//                     var
//                         ReversalEntry: Record "Reversal Entry";
//                     begin
//                         CLEAR(ReversalEntry);
//                         IF Rec.Reversed THEN
//                             ReversalEntry.AlreadyReversedEntry(FORMAT(Rec.TABLECAPTION()), Rec."Entry No.");
//                         IF Rec."Journal Batch Name" = '' THEN
//                             ReversalEntry.TestFieldError();
//                         Rec.TESTFIELD("Transaction No.");
//                         ReversalEntry.ReverseTransaction(Rec."Transaction No.");
//                     end;
//                 }

//                 /*                action("Stale Cheques")
//                                 {
//                                     Caption = 'Stale Cheque';
//                                     Image = StaleCheck;
//                                     ApplicationArea = All;

//                                     trigger OnAction()
//                                     begin
//                                         //Code added for Stale Cheque validation::CSPL-00059::07022019: Start
//                                         /* IF "Stale Cheque" = FALSE THEN BEGIN
//                                              IF CONFIRM(Text16502, FALSE, "Cheque No.", "Bal. Account Type",
//                                                   "Bal. Account No.") THEN BEGIN
//                                                  IF "Stale Cheque Expiry Date" >= WORKDATE THEN
//                                                      ERROR(Text16500, "Stale Cheque Expiry Date");
//                                                  "Stale Cheque" := TRUE;
//                                                  "Cheque Stale Date" := WORKDATE();
//                                                  Modify();
//                                              END; Rec.*/
//                 //END
//                 //ELSE
//                 //   MESSAGE(Text16501);
//                 //Code added for Stale Cheque validation::CSPL-00059::07022019: End;
//                 // end;

//             }
//             action("&Navigate")
//             {
//                 Caption = '&Navigate';
//                 Image = Navigate;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Process;
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin
//                     Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
//                     Navigate.RUN();
//                 end;
//             }
//             action("Cheque Reprint Approve")
//             {
//                 Image = Approval;
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin
//                     //Code added for cheque printing validation::CSPL-00059::07022019: Start
//                     Rec."Cheque Printed" := FALSE;
//                     Rec."Cheque Reprint" := FALSE;
//                     Rec.Modify();
//                     MESSAGE('%1', Test001Lbl);
//                     //Code added for cheque printing validation::CSPL-00059::07022019: End;
//                 end;
//             }
//         }
//     }

//     var
//         Navigate: Page "Navigate";
//         Test001Lbl: Label 'Cheque approve for reprinted';
// }
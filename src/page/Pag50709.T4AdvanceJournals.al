page 50709 "T4 Advance Journal"
{
    AdditionalSearchTerms = 'print check,payment file export,electronic payment';
    ApplicationArea = Basic, Suite;
    AutoSplitKey = true;
    Caption = 'T4 Advance Journals';
    //DataCaptionExpression = DataCaption;//GMCSCOM
    DelayedInsert = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Bank,Prepare,Approve,Page,Post/Print,Line,Account,Check';
    SaveValues = true;
    SourceTable = "Gen. Journal Line";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Batch Name';
                Lookup = true;
                ToolTip = 'Specifies the name of the journal batch, a personalized journal layout, that the journal is based on.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord;
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    SetControlAppearanceFromBatch;
                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the type of document that the entry on the journal line is.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies a document number for the journal line.';
                    Editable = False;
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the incoming document that this general journal line is created for.';
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec."Incoming Document Entry No." > 0 then
                            HyperLink(Rec.GetIncomingDocumentURL);
                    end;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Applies-to Ext. Doc. No."; Rec."Applies-to Ext. Doc. No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the external document number that will be exported in the payment file.';
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of account that the entry on the journal line will be posted to.';

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        EnableApplyEntriesAction;
                        CurrPage.SaveRecord;
                    end;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the account number that the entry on the journal line will be posted to.';

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        CurrPage.SaveRecord;
                    end;
                }
                field("Recipient Bank Account"; Rec."Recipient Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = RecipientBankAccountMandatory;
                    ToolTip = 'Specifies the bank account that the amount will be transferred to after it has been exported from the payment journal.';
                }
                field("Message to Recipient"; Rec."Message to Recipient")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the salesperson or purchaser who is linked to the journal line.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the number of the campaign that the journal line is linked to.';
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    AssistEdit = true;
                    ToolTip = 'Specifies the code of the currency for the amounts on the journal line.';

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        if ChangeExchangeRate.RunModal = ACTION::OK then
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);

                        Clear(ChangeExchangeRate);
                    end;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of transaction.';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor who sent the purchase invoice.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of.';
                    Visible = AmountVisible;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total amount in local currency (including VAT) that the journal line consists of.';
                    Visible = false;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = DebitCreditVisible;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = DebitCreditVisible;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the amount of VAT that is included in the total amount.';
                    Visible = false;
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the difference between the calculated VAT amount and a VAT amount that you have entered manually.';
                    Visible = false;
                }
                field("Bal. VAT Amount"; Rec."Bal. VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the amount of Bal. VAT included in the total amount.';
                    Visible = false;
                }
                field("Bal. VAT Difference"; Rec."Bal. VAT Difference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.';
                    Visible = false;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of account that a balancing entry is posted to, such as BANK for a cash account.';

                    trigger OnValidate()
                    begin
                        EnableApplyEntriesAction;
                    end;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account that the balancing entry is posted to, such as a cash account for cash purchases.';

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                Field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Bal. Gen. Posting Type"; Rec."Bal. Gen. Posting Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the general posting type associated with the balancing account that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Bal. Gen. Bus. Posting Group"; Rec."Bal. Gen. Bus. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the general business posting group code associated with the balancing account that will be used when you post the entry.';
                    Visible = false;
                }
                field("Bal. Gen. Prod. Posting Group"; Rec."Bal. Gen. Prod. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the general product posting group code associated with the balancing account that will be used when you post the entry.';
                    Visible = false;
                }
                field("Bal. VAT Bus. Posting Group"; Rec."Bal. VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the VAT business posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Bal. VAT Prod. Posting Group"; Rec."Bal. VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Applied (Yes/No)"; Rec.IsApplied)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Applied (Yes/No)';
                    ToolTip = 'Specifies if the payment has been applied.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field(AppliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                    Visible = false;
                }
                field(GetAppliesToDocDueDate; Rec.GetAppliesToDocDueDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Applies-to Doc. Due Date';
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the due date from the Applies-to Doc. on the journal line.';
                }
                field("Bank Payment Type"; Rec."Bank Payment Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code for the payment type to be used for the entry on the journal line.';
                }
                // field("Foreign Exchange Indicator"; Rec."Foreign Exchange Indicator")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies an exchange indicator for the journal line. This is a required field. You can edit this field in the Purchase Journal window.';
                //     Visible = false;
                // }
                // field("Foreign Exchange Ref.Indicator"; Rec."Foreign Exchange Ref.Indicator")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies an exchange reference indicator for the journal line. This is a required field. You can edit this field in the Purchase Journal and the Payment Journal window.';
                //     Visible = false;
                // }
                // field("Foreign Exchange Reference"; "Foreign Exchange Reference")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies a foreign exchange reference code. This is a required field. You can edit this field in the Purchase Journal window.';
                //     Visible = false;
                // }
                // field("Origin. DFI ID Qualifier"; "Origin. DFI ID Qualifier")
                // {
                //     ApplicationArea = BasicMX;
                //     ToolTip = 'Specifies the financial institution that will initiate the payment transactions sent by the originator. Select an ID for the originator''s Designated Financial Institution (DFI). This is a required field. You can edit this field in the Payment Journal window and the Purchase Journal window.';
                //     Visible = false;
                // }
                // field("Receiv. DFI ID Qualifier"; "Receiv. DFI ID Qualifier")
                // {
                //     ApplicationArea = BasicMX;
                //     ToolTip = 'Specifies the financial institution that will receive the payment transactions. Select an ID for the receiver''s Designated Financial Institution (DFI). This is a required field. You can edit this field in the Payment Journal window and the Purchase Journal window.';
                //     Visible = false;
                // }
                // field("Transaction Type Code"; "Transaction Type Code")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies a transaction type code for the general journal line. This code identifies the transaction type for the Electronic Funds Transfer (EFT).';
                // }
                // field("Gateway Operator OFAC Scr.Inc"; "Gateway Operator OFAC Scr.Inc")
                // {
                //     ApplicationArea = BasicUS;
                //     ToolTip = 'Specifies an Office of Foreign Assets Control (OFAC) gateway operator screening indicator. This is a required field. You can edit this field in the Payment Journal window and the Purchase Journal window.';
                //     Visible = false;
                // }
                // field("Secondary OFAC Scr.Indicator"; "Secondary OFAC Scr.Indicator")
                // {
                //     ApplicationArea = BasicUS;
                //     ToolTip = 'Specifies a secondary Office of Foreign Assets Control (OFAC) gateway operator screening indicator. This is a required field. You can edit this field in the Payment Journal window and the Purchase Journal window.';
                //     Visible = false;
                // }
                // field("Transaction Code"; "Transaction Code")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies a transaction code for the general journal line. This code identifies the transaction type for the Electronic Funds Transfer (EFT).';
                //     Visible = false;
                // }
                // field("Company Entry Description"; "Company Entry Description")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies a company description for the journal line.';
                //     Visible = false;
                // }
                // field("Payment Related Information 1"; "Payment Related Information 1")
                // {
                //     ToolTip = 'Specifies payment related information for the general journal line.';
                //     Visible = false;
                // }
                // field("Payment Related Information 2"; "Payment Related Information 2")
                // {
                //     ToolTip = 'Specifies additional payment related information for the general journal line.';
                //     Visible = false;
                // }
                field("Check Printed"; Rec."Check Printed")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether a check has been printed for the amount on the payment journal line.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                    Visible = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the customer or vendor that the payment relates to.';
                    Visible = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the customer or vendor that the payment relates to.';
                    Visible = false;
                }
                field(CommentField; Rec.Comment)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies a comment about the activity on the journal line. Note that the comment is not carried forward to posted entries.';
                    Visible = false;
                }
                field("Exported to Payment File"; Rec."Exported to Payment File")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the payment journal line was exported to a payment file.';
                    Visible = false;
                }
                field(TotalExportedAmount; Rec.TotalExportedAmount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Exported Amount';
                    DrillDown = true;
                    ToolTip = 'Specifies the amount for the payment journal line that has been exported to payment files that are not canceled.';
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        Rec.DrillDownExportedAmount
                    end;
                }
                field("Has Payment Export Error"; Rec."Has Payment Export Error")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that an error occurred when you used the Export Payments to File function in the Payment Journal window.';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of general journals.';
                    Visible = JobQueuesUsed;

                    trigger OnDrillDown()
                    var
                        JobQueueEntry: Record "Job Queue Entry";
                    begin
                        if Rec."Job Queue Status" = Rec."Job Queue Status"::" " then
                            exit;
                        JobQueueEntry.ShowStatusMsg(Rec."Job Queue Entry ID");
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible2;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible3;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 3);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible4;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 4);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible5;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 5);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible6;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 6);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible7;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 7);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible8;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 8);
                    end;
                }
            }
            group(Control24)
            {
                ShowCaption = false;
                fixed(Control80)
                {
                    ShowCaption = false;
                    group(Control82)
                    {
                        ShowCaption = false;
                        field(OverdueWarningText; OverdueWarningText)
                        {
                            ApplicationArea = Basic, Suite;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                            ToolTip = 'Specifies the text that is displayed for overdue payments.';
                        }
                    }
                }
                fixed(Control1903561801)
                {
                    ShowCaption = false;
                    group("Number of Lines")
                    {
                        Caption = 'Number of Lines';
                        field(NumberOfJournalRecords; NumberOfRecords)
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            ShowCaption = false;
                            Editable = false;
                            ToolTip = 'Specifies the number of lines in the current journal batch.';
                        }
                    }
                    group("Account Name")
                    {
                        Caption = 'Account Name';
                        field(AccName; AccName)
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = false;
                            ShowCaption = false;
                            ToolTip = 'Specifies the name of the account.';
                        }
                    }
                    group("Bal. Account Name")
                    {
                        Caption = 'Bal. Account Name';
                        field(BalAccName; BalAccName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Account Name';
                            Editable = false;
                            ToolTip = 'Specifies the name of the balancing account that has been entered on the journal line.';
                        }
                    }
                    group(Control1900545401)
                    {
                        Caption = 'Balance';
                        field(Balance; Balance + Rec."Balance (LCY)" - xRec."Balance (LCY)")
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                            ToolTip = 'Specifies the balance that has accumulated in the payment journal on the line where the cursor is.';
                            Visible = BalanceVisible;
                        }
                    }
                    group("Total Balance")
                    {
                        Caption = 'Total Balance';
                        field(TotalBalance; TotalBalance + Rec."Balance (LCY)" - xRec."Balance (LCY)")
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            Caption = 'Total Balance';
                            Editable = false;
                            ToolTip = 'Specifies the total balance in the payment journal.';
                            Visible = TotalBalanceVisible;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
            }
            part("Payment File Errors"; "Payment Journal Errors Part")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment File Errors';
                SubPageLink = "Journal Template Name" = FIELD("Journal Template Name"),
                              "Journal Batch Name" = FIELD("Journal Batch Name"),
                              "Journal Line No." = FIELD("Line No.");
            }
            part(Control1900919607; "Dimension Set Entries FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                Visible = false;
            }
            part(WorkflowStatusBatch; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Batch Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnBatch;
            }
            part(WorkflowStatusLine; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Line Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnLine;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                        CurrPage.SaveRecord;
                    end;
                }
                action(IncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Scope = Repeater;
                    ToolTip = 'View or create an incoming document record that is linked to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                    end;
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                Image = ChartOfAccounts;
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Category10;
                    RunObject = Codeunit "Gen. Jnl.-Show Card";
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the record on the document or journal line.';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = GLRegisters;
                    Promoted = true;
                    PromotedCategory = Category9;
                    RunObject = Codeunit "Gen. Jnl.-Show Entries";
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
            }
            group("&Payments")
            {
                Caption = '&Payments';
                Image = Payment;
                action(SuggestVendorPayments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Suggest Vendor Payments';
                    Ellipsis = true;
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Create payment suggestions as lines in the payment journal.';

                    trigger OnAction()
                    var
                        SuggestVendorPayments: Report "Suggest Vendor Payments";
                    begin
                        Clear(SuggestVendorPayments);
                        SuggestVendorPayments.SetGenJnlLine(Rec);
                        SuggestVendorPayments.RunModal;
                    end;
                }
                action(SuggestEmployeePayments)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Suggest Employee Payments';
                    Ellipsis = true;
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Create payment suggestions as lines in the payment journal.';

                    trigger OnAction()
                    var
                        SuggestEmployeePayments: Report "Suggest Employee Payments";
                    begin
                        Clear(SuggestEmployeePayments);
                        SuggestEmployeePayments.SetGenJnlLine(Rec);
                        SuggestEmployeePayments.RunModal;
                    end;
                }
                action(PreviewCheck)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&review Check';
                    Image = ViewCheck;
                    Promoted = true;
                    PromotedCategory = Category11;
                    RunObject = Page "Check Preview";
                    RunPageLink = "Journal Template Name" = FIELD("Journal Template Name"),
                                  "Journal Batch Name" = FIELD("Journal Batch Name"),
                                  "Line No." = FIELD("Line No.");
                    ToolTip = 'Preview the check before printing it.';
                }
                action(PrintCheck)
                {
                    AccessByPermission = TableData "Check Ledger Entry" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print Check';
                    Ellipsis = true;
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Category11;
                    ToolTip = 'Prepare to print the check.';

                    trigger OnAction()
                    begin
                        GenJnlLine.Reset;
                        GenJnlLine.Copy(Rec);
                        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        DocPrint.PrintCheck(GenJnlLine);
                        CODEUNIT.Run(CODEUNIT::"Adjust Gen. Journal Balance", Rec);
                    end;
                }
                group("Electronic Payments")
                {
                    Caption = 'Electronic Payments';
                    Image = ElectronicPayment;
                    action(ExportPaymentsToFile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'E&xport';
                        Ellipsis = true;
                        Image = ExportFile;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        ToolTip = 'Export a file with the payment information on the journal lines.';

                        trigger OnAction()
                        var
                            BankExportImportSetup: Record "Bank Export/Import Setup";
                            BankAccount: Record "Bank Account";
                            CompanyInformation: Record "Company Information";
                            GenJournalBatch: Record "Gen. Journal Batch";
                            // BulkVendorRemitReporting: Codeunit "Bulk Vendor Remit Reporting";
                            PaymentExportGenJnlCheck: Codeunit "Payment Export Gen. Jnl Check";
                            GenJnlLineRecordRef: RecordRef;
                            Window: Dialog;
                            ExportNewLines: Boolean;
                        begin
                            Rec.CheckIfPrivacyBlocked;

                            Window.Open(GeneratingPaymentsMsg);
                            GenJournalBatch.Get(Rec."Journal Template Name", CurrentJnlBatchName);
                            BankAccount.Get(GenJournalBatch."Bal. Account No.");

                            //if (BankAccount."Export Format" = 0) or (BankAccount."Export Format" = BankAccount."Export Format"::Other) 
                            //then 
                            begin
                                // Export Format is either empty or 'OTHER'
                                GenJnlLine.CopyFilters(Rec);
                                GenJnlLine.FindFirst;
                                GenJnlLine.ExportPaymentFile;
                            end;
                            begin
                                CompanyInformation.Get;
                                //CompanyInformation.TestField("Federal ID No.");
                                GenJnlLine.Reset;
                                GenJnlLine.Copy(Rec);
                                GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                                GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");

                                if GenJnlLine.FindFirst then begin
                                    repeat
                                        GenJnlLine.DeletePaymentFileErrors;
                                        if GenJnlLine."Currency Code" <> BankAccount."Currency Code" then
                                            GenJnlLine.InsertPaymentFileError(NoExportDiffCurrencyErr);
                                        if ((GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account") or
                                            (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"Bank Account")) and
                                           ((GenJnlLine."Bank Payment Type" <> GenJnlLine."Bank Payment Type"::"Electronic Payment") and
                                            (GenJnlLine."Bank Payment Type" <> GenJnlLine."Bank Payment Type"::"Electronic Payment-IAT"))
                                        then
                                            GenJnlLine.InsertPaymentFileError(StrSubstNo(WrongBankPaymentTypeErr, Rec.FieldCaption("Bank Payment Type"),
                                                "Bank Payment Type"::"Electronic Payment", "Bank Payment Type"::"Electronic Payment-IAT"));
                                        if not GenJournalBatch."Allow Payment Export" then
                                            PaymentExportGenJnlCheck.AddBatchEmptyError(GenJnlLine, GenJournalBatch.FieldCaption("Allow Payment Export"), '');
                                        if GenJnlLine.Amount < 0 then
                                            GenJnlLine.InsertPaymentFileError(NoExportNegativeErr);
                                        if GenJnlLine."Recipient Bank Account" = '' then
                                            GenJnlLine.InsertPaymentFileError(RecipientBankAccountEmptyErr)
                                        else
                                            if not UseForElecPaymentChecked(GenJnlLine) then
                                                GenJnlLine.InsertPaymentFileError(UseForElecPaymentCheckedErr);
                                    until GenJnlLine.Next = 0;
                                end;

                                //if BankAccount.Rec."Last Remittance Advice No." = '' then//GMCSCOM
                                Rec.InsertPaymentFileError(LastRemittanceErr);

                                if GenJnlLine.HasPaymentFileErrorsInBatch then begin
                                    Commit;
                                    Error(HasErrorsErr);
                                end;

                                if Rec."Bank Payment Type" = "Bank Payment Type"::"Electronic Payment" then
                                    BankExportImportSetup.Get(BankAccount."Payment Export Format")
                                else
                                    if Rec."Bank Payment Type" = "Bank Payment Type"::"Electronic Payment-IAT" then
                                        // BankExportImportSetup.Get(BankAccount."EFT Export Code");//GMCSCOM

                                        if GenJnlLine.FindFirst then begin
                                            repeat
                                            // ExportNewLines := BulkVendorRemitReporting.ProcessLine(GenJnlLine);
                                            until (ExportNewLines = true) or (GenJnlLine.Next = 0);
                                        end;

                                if ExportNewLines then begin
                                    GenJnlLineRecordRef.GetTable(GenJnlLine);
                                    GenJnlLineRecordRef.SetView(GenJnlLine.GetView);
                                    // BulkVendorRemitReporting.RunWithRecord(GenJnlLine)
                                end;
                            end;

                            Window.Close;
                        end;
                    }
                    action(VoidPayments)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Void';
                        Ellipsis = true;
                        Image = VoidElectronicDocument;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        ToolTip = 'Void the exported electronic payment file.';

                        trigger OnAction()
                        var
                            BankAccount: Record "Bank Account";
                        begin
                            if Rec."Account Type" = Rec."Account Type"::"Bank Account" then
                                BankAccount.Get(Rec."Account No.");
                            if Rec."Bal. Account Type" = Rec."Bal. Account Type"::"Bank Account" then
                                BankAccount.Get(Rec."Bal. Account No.");
                            //  if (BankAccount.Rec."Export Format" = 0) or (BankAccount.Rec."Export Format" = BankAccount.Rec."Export Format"::Other) then begin//GMCSCOM
                            //     GenJnlLine.CopyFilters(Rec);

                            //     if not EntriesToVoid(GenJnlLine, true) then
                            //         Error(NoEntriesToVoidErr);
                            //     if GenJnlLine.FindFirst then
                            //         GenJnlLine.VoidPaymentFile;
                            // end else begin
                            //     GenJnlLine.Reset;
                            //     GenJnlLine := Rec;
                            //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                            //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");

                            if not EntriesToVoid(GenJnlLine, false) then
                                Error(NoEntriesToVoidErr);
                            // Clear(VoidTransmitElecPayments);
                            // VoidTransmitElecPayments.SetUsageType(1);   // Void
                            // VoidTransmitElecPayments.SetTableView(GenJnlLine);
                            // if Rec."Account Type" = Rec."Account Type"::"Bank Account" then
                            //     VoidTransmitElecPayments.SetBankAccountNo(Rec."Account No.")
                            // else
                            //     if Rec."Bal. Account Type" = Rec."Bal. Account Type"::"Bank Account" then
                            //         VoidTransmitElecPayments.SetBankAccountNo(Rec."Bal. Account No.");
                            // VoidTransmitElecPayments.RunModal;
                        end;

                    }
                    action(TransmitPayments)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transmit';
                        Ellipsis = true;
                        Enabled = AMCFormat;
                        Image = TransmitElectronicDoc;
                        Promoted = true;
                        PromotedCategory = Category4;
                        ToolTip = 'Transmit the exported electronic payment file to the bank.';

                        trigger OnAction()
                        var
                            BankAccount: Record "Bank Account";
                        begin
                            if Rec."Account Type" = Rec."Account Type"::"Bank Account" then
                                BankAccount.Get(Rec."Account No.");
                            if Rec."Bal. Account Type" = Rec."Bal. Account Type"::"Bank Account" then
                                BankAccount.Get(Rec."Bal. Account No.");
                            //if (BankAccount."Export Format" = 0) or (BankAccount."Export Format" = BankAccount."Export Format"::Other) then begin//GMCSCOM
                            GenJnlLine.CopyFilters(Rec);
                            if GenJnlLine.FindFirst then
                                GenJnlLine.TransmitPaymentFile;
                        end;

                    }
                }
                action("Void Check")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Void Check';
                    Image = VoidCheck;
                    Promoted = true;
                    PromotedCategory = Category11;
                    ToolTip = 'Void the check if, for example, the check is not cashed by the bank.';

                    trigger OnAction()
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                    begin
                        Rec.TestField("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                        Rec.TestField("Check Printed", true);
                        if ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text000, Rec."Document No."), true) then
                            CheckManagement.VoidCheck(Rec);
                    end;
                }
                action("Void &All Checks")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Void &All Checks';
                    Image = VoidAllChecks;
                    Promoted = true;
                    PromotedCategory = Category11;
                    ToolTip = 'Void all checks if, for example, the checks are not cashed by the bank.';

                    trigger OnAction()
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                    begin
                        if ConfirmManagement.GetResponseOrDefault(Text001, true) then begin
                            GenJnlLine.Reset;
                            GenJnlLine.Copy(Rec);
                            GenJnlLine.SetRange("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                            GenJnlLine.SetRange("Check Printed", true);
                            if GenJnlLine.Find('-') then
                                repeat
                                    GenJnlLine2 := GenJnlLine;
                                    CheckManagement.VoidCheck(GenJnlLine2);
                                until GenJnlLine.Next = 0;
                        end;
                    end;
                }
                action(CreditTransferRegEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Credit Transfer Reg. Entries';
                    Enabled = AMCFormat;
                    Image = ExportReceipt;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Codeunit "Gen. Jnl.-Show CT Entries";
                    ToolTip = 'View or edit the credit transfer entries that are related to file export for credit transfers.';
                }
                action(CreditTransferRegisters)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Credit Transfer Registers';
                    Enabled = AMCFormat;
                    Image = ExportElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Credit Transfer Registers";
                    ToolTip = 'View or edit the payment files that have been exported in connection with credit transfers.';
                }
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    GetCurrentlySelectedLines(GenJournalLine);
                    ApprovalsMgmt.ShowJournalApprovalEntries(GenJournalLine);
                end;
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Renumber Document Numbers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Renumber Document Numbers';
                    Image = EditLines;
                    ToolTip = 'Resort the numbers in the Document No. column to avoid posting errors because the document numbers are not in sequence. Entry applications and line groupings are preserved.';

                    trigger OnAction()
                    begin
                        Rec.RenumberDocumentNo
                    end;
                }
                action(ApplyEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Enabled = ApplyEntriesActionEnabled;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Gen. Jnl.-Apply";
                    ShortCutKey = 'Shift+F11';
                    ToolTip = 'Apply the payment amount on a journal line to a sales or purchase document that was already posted for a customer or vendor. This updates the amount on the posted document, and the document can either be partially paid, or closed as paid or refunded.';
                }
                action(CalculatePostingDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate Posting Date';
                    Image = CalcWorkCenterCalendar;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Calculate the date that will appear as the posting date on the journal lines.';

                    trigger OnAction()
                    begin
                        Rec.CalculatePostingDate;
                    end;
                }
                action("Insert Conv. LCY Rndg. Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Insert Conv. LCY Rndg. Lines';
                    Image = InsertCurrency;
                    RunObject = Codeunit "Adjust Gen. Journal Balance";
                    ToolTip = 'Insert a rounding correction line in the journal. This rounding correction line will balance in LCY when amounts in the foreign currency also balance. You can then post the journal.';
                }
                action(PositivePayExport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Positive Pay Export';
                    Image = Export;
                    ToolTip = 'Export a Positive Pay file that contains vendor information, check number, and payment amount, which you send to the bank to make sure that your bank only clears validated checks and amounts when you process payments.';
                    Visible = false;

                    trigger OnAction()
                    var
                        GenJnlBatch: Record "Gen. Journal Batch";
                        BankAcc: Record "Bank Account";
                    begin
                        GenJnlBatch.Get(Rec."Journal Template Name", CurrentJnlBatchName);
                        if GenJnlBatch."Bal. Account Type" = GenJnlBatch."Bal. Account Type"::"Bank Account" then begin
                            BankAcc."No." := GenJnlBatch."Bal. Account No.";
                            PAGE.Run(PAGE::"Positive Pay Export", BankAcc);
                        end;
                    end;
                }
                action(GenerateEFT)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generate EFT File';
                    Enabled = NOT (AMCFormat = TRUE);
                    Image = ExportFile;
                    ToolTip = 'Generate a file based on the exported payment journal lines. A window showing the file content opens from where you complete the electronic funds transfer.';

                    // trigger OnAction()
                    // var
                    //     GenJournalBatch: Record "Gen. Journal Batch";
                    //     GenerateEFTFiles: Page "Generate EFT Files";
                    // begin
                    //     GenJournalBatch.Get(Rec."Journal Template Name", CurrentJnlBatchName);
                    //     GenerateEFTFiles.SetBalanceAccount(GenJournalBatch."Bal. Account No.");
                    //     GenerateEFTFiles.Run;
                    // end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Reconcile)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F11';
                    ToolTip = 'View the balances on bank accounts that are marked for reconciliation, usually liquid accounts.';

                    trigger OnAction()
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.Run;
                    end;
                }
                action(PreCheck)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Pre-Payment Journal';
                    Image = PreviewChecks;
                    ToolTip = 'View journal line entries, payment discounts, discount tolerance amounts, payment tolerance, and any errors associated with the entries. You can use the results of the report to review payment journal lines and to review the results of posting before you actually post.';

                    trigger OnAction()
                    var
                        GenJournalBatch: Record "Gen. Journal Batch";
                    begin
                        GenJournalBatch.Init;
                        GenJournalBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                        GenJournalBatch.SetRange(Name, Rec."Journal Batch Name");
                        REPORT.Run(REPORT::"Vendor Pre-Payment Journal", true, false, GenJournalBatch);
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                        SetJobQueueVisibility();
                        CurrPage.Update(false);
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    var
                        GenJnlPost: Codeunit "Gen. Jnl.-Post";
                    begin
                        GenJnlPost.Preview(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                        SetJobQueueVisibility();
                        CurrPage.Update(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                        SetJobQueueVisibility();
                        CurrPage.Update(false);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                group(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Journal Batch';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrAnyJnlLineExist AND CanRequestFlowApprovalForBatchAndAllLines;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TrySendJournalBatchApprovalRequest(Rec);
                            SetControlAppearanceFromBatch;
                            SetControlAppearance;
                        end;
                    }
                    action(SendApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Selected Journal Lines';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist AND CanRequestFlowApprovalForBatchAndCurrentLine;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send selected journal lines for approval.';

                        trigger OnAction()
                        var
                            GenJournalLine: Record "Gen. Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            GetCurrentlySelectedLines(GenJournalLine);
                            ApprovalsMgmt.TrySendJournalLineApprovalRequests(GenJournalLine);
                        end;
                    }
                }
                group(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    action(CancelApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Journal Batch';
                        Enabled = CanCancelApprovalForJnlBatch OR CanCancelFlowApprovalForBatch;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
                            SetControlAppearanceFromBatch;
                            SetControlAppearance;
                        end;
                    }
                    action(CancelApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Selected Journal Lines';
                        Enabled = CanCancelApprovalForJnlLine OR CanCancelFlowApprovalForLine;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending selected journal lines for approval.';

                        trigger OnAction()
                        var
                            GenJournalLine: Record "Gen. Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            GetCurrentlySelectedLines(GenJournalLine);
                            ApprovalsMgmt.TryCancelJournalLineApprovalRequests(GenJournalLine);
                        end;
                    }
                }
                action(CreateFlow)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create a Flow';
                    Image = Flow;
                    ToolTip = 'Create a new Flow from a list of relevant Flow templates.';
                    Visible = IsSaaS;

                    trigger OnAction()
                    var
                        FlowServiceManagement: Codeunit "Flow Service Management";
                        FlowTemplateSelector: Page "Flow Template Selector";
                    begin
                        // Opens page 6400 where the user can use filtered templates to create new flows.
                        FlowTemplateSelector.SetSearchText(FlowServiceManagement.GetJournalTemplateFilter);
                        FlowTemplateSelector.Run;
                    end;
                }
                action(SeeFlows)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'See my Flows';
                    Image = Flow;
                    RunObject = Page "Flow Selector";
                    ToolTip = 'View and configure Flows that you created.';
                }
            }
            group(Workflow)
            {
                Caption = 'Workflow';
                action(CreateApprovalWorkflow)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Approval Workflow';
                    Enabled = NOT EnabledApprovalWorkflowsExist;
                    Image = CreateWorkflow;
                    ToolTip = 'Set up an approval workflow for payment journal lines, by going through a few pages that will guide you.';

                    trigger OnAction()
                    var
                        TempApprovalWorkflowWizard: Record "Approval Workflow Wizard" temporary;
                    begin
                        TempApprovalWorkflowWizard."Journal Batch Name" := Rec."Journal Batch Name";
                        TempApprovalWorkflowWizard."Journal Template Name" := Rec."Journal Template Name";
                        TempApprovalWorkflowWizard."For All Batches" := false;
                        TempApprovalWorkflowWizard.Insert;

                        PAGE.RunModal(PAGE::"Pmt. App. Workflow Setup Wzrd.", TempApprovalWorkflowWizard);
                    end;
                }
                action(ManageApprovalWorkflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Manage Approval Workflows';
                    Enabled = EnabledApprovalWorkflowsExist;
                    Image = WorkflowSetup;
                    ToolTip = 'View or edit existing approval workflows for payment journal lines.';

                    trigger OnAction()
                    var
                        WorkflowManagement: Codeunit "Workflow Management";
                    begin
                        WorkflowManagement.NavigateToWorkflows(DATABASE::"Gen. Journal Line", EventFilter);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveGenJournalLineRequest(Rec);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectGenJournalLineRequest(Rec);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateGenJournalLineRequest(Rec);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        GenJournalBatch: Record "Gen. Journal Batch";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if OpenApprovalEntriesOnJnlLineExist then
                            ApprovalsMgmt.GetApprovalComment(Rec)
                        else
                            if OpenApprovalEntriesOnJnlBatchExist then
                                if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
                                    ApprovalsMgmt.GetApprovalComment(GenJournalBatch);
                    end;
                }
            }
            group("Page")
            {
                Caption = 'Page';
                action(EditInExcel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Edit in Excel';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send the data in the journal to an Excel file for analysis or editing.';
                    Visible = IsSaasExcelAddinEnabled;

                    trigger OnAction()
                    var
                        ODataUtility: Codeunit ODataUtility;
                    begin
                        ODataUtility.EditJournalWorksheetInExcel(CurrPage.Caption, CurrPage.ObjectId(false), Rec."Journal Batch Name", Rec."Journal Template Name");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        StyleTxt := Rec.GetOverdueDateInteractions(OverdueWarningText);
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance;
        EnableApplyEntriesAction;
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

        if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
            ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(GenJournalBatch.RecordId);
            IsAllowPaymentExport := GenJournalBatch."Allow Payment Export";
        end;
        ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);

        EventFilter := WorkflowEventHandling.RunWorkflowOnSendGeneralJournalLineForApprovalCode;
        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::"Gen. Journal Line", EventFilter);
        SetJobQueueVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.GetOverdueDateInteractions(OverdueWarningText);
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        HasPmtFileErr := Rec.HasPaymentFileErrors;
        RecipientBankAccountMandatory := IsAllowPaymentExport and
          ((Rec."Bal. Account Type" = Rec."Bal. Account Type"::Vendor) or (Rec."Bal. Account Type" = Rec."Bal. Account Type"::Customer));
        SetAMCAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.SetCurrentRecordID(Rec.RecordId);
    end;

    trigger OnInit()
    begin
        TotalBalanceVisible := true;
        BalanceVisible := true;
        AmountVisible := true;
        GeneralLedgerSetup.Get();
        SetJobQueueVisibility();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.SetCurrentRecordID(Rec.RecordId);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CheckForPmtJnlErrors;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        HasPmtFileErr := false;
        UpdateBalance;
        EnableApplyEntriesAction;
        Rec.SetUpNewLine(xRec, Balance, BelowxRec);
        Clear(ShortcutDimCode);
        if not VoidWarningDisplayed then begin
            GenJnlTemplate.Get(Rec."Journal Template Name");
            if not GenJnlTemplate."Force Doc. Balance" then
                Message(CheckCannotVoidMsg);
            VoidWarningDisplayed := true;
        end;
        SetAMCAppearance;
    end;

    trigger OnOpenPage()
    var
        ServerSetting: Codeunit "Server Setting";
        ClientTypeManagement: Codeunit "Client Type Management";
        EnvironmentInfo: Codeunit "Environment Information";
        JnlSelected: Boolean;
    begin
        IsSaasExcelAddinEnabled := ServerSetting.GetIsSaasExcelAddinEnabled;
        IsSaaS := EnvironmentInfo.IsSaaS;
        if ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::ODataV4 then
            exit;

        BalAccName := '';
        SetControlVisibility;
        SetDimensionsVisibility;

        if Rec.IsOpenedFromBatch then begin
            CurrentJnlBatchName := Rec."Journal Batch Name";
            GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
            SetControlAppearanceFromBatch;
            exit;
        end;
        // GenJnlManagement.TemplateSelection(PAGE::"T4 Advance Journal", 4, false, Rec, JnlSelected);//GMCSCOM
        if not JnlSelected then
            Error('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
        SetControlAppearanceFromBatch;
        VoidWarningDisplayed := false;
    end;

    var
        Text000: Label 'Void Check %1?';
        Text001: Label 'Void all printed checks?';
        GeneratingPaymentsMsg: Label 'Generating Payment file...';
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        // VoidTransmitElecPayments: Report "Void/Transmit Elec. Payments";
        GenJnlManagement: Codeunit GenJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        CheckManagement: Codeunit CheckManagement;
        ChangeExchangeRate: Page "Change Exchange Rate";
        GLReconcile: Page Reconciliation;
        CurrentJnlBatchName: Code[10];
        AccName: Text[100];
        BalAccName: Text[100];
        Balance: Decimal;
        TotalBalance: Decimal;
        NumberOfRecords: Integer;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        VoidWarningDisplayed: Boolean;
        HasPmtFileErr: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        ApplyEntriesActionEnabled: Boolean;
        [InDataSet]

        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;
        StyleTxt: Text;
        OverdueWarningText: Text;
        CheckCannotVoidMsg: Label 'Warning:  Checks cannot be financially voided when Force Doc. Balance is set to No in the Journal Template.';
        EventFilter: Text;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExistForCurrUserBatch: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        AMCFormat: Boolean;
        WrongBankPaymentTypeErr: Label '%1 type must be either %2 or %3.', Comment = '%1=Bank Payment Type field caption, %2=Electronic Payment bank payment type, %3=Electronic Payment-IAT bank payment type';
        HasErrorsErr: Label 'The file export has one or more errors.\\For each line to be exported, resolve the errors displayed to the right and then try to export again.';
        NoEntriesToVoidErr: Label 'There are no entries to void.';
        LastRemittanceErr: Label 'Last Remittance Advice No. must have a value in the bank account.';
        NoExportNegativeErr: Label 'You cannot export journal entries with negative amounts.';
        UseForElecPaymentCheckedErr: Label 'The Use for Electronic Payments check box must be selected on the vendor or customer bank account card.';
        IsAllowPaymentExport: Boolean;
        IsSaasExcelAddinEnabled: Boolean;
        RecipientBankAccountMandatory: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        CanRequestFlowApprovalForBatchAndAllLines: Boolean;
        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForLine: Boolean;
        AmountVisible: Boolean;
        IsSaaS: Boolean;
        DebitCreditVisible: Boolean;
        JobQueuesUsed: Boolean;
        JobQueueVisible: Boolean;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        NoExportDiffCurrencyErr: Label 'You cannot export journal entries if Currency Code is different in Gen. Journal Line and Bank Account.';
        RecipientBankAccountEmptyErr: Label 'Recipient Bank Account must be filled.';

    local procedure CheckForPmtJnlErrors()
    var
        BankAccount: Record "Bank Account";
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        if HasPmtFileErr then
            if (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"Bank Account") and BankAccount.Get(Rec."Bal. Account No.") then
                if BankExportImportSetup.Get(BankAccount."Payment Export Format") then
                    if BankExportImportSetup."Check Export Codeunit" > 0 then
                        CODEUNIT.Run(BankExportImportSetup."Check Export Codeunit", Rec);
    end;

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcBalance(
          Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
        if ShowTotalBalance then
            NumberOfRecords := Rec.Count();
    end;

    local procedure EnableApplyEntriesAction()
    begin
        ApplyEntriesActionEnabled :=
          (Rec."Account Type" in [Rec."Account Type"::Customer, Rec."Account Type"::Vendor]) or
          (Rec."Bal. Account Type" in [Rec."Bal. Account Type"::Customer, Rec."Bal. Account Type"::Vendor]);
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord;
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        SetControlAppearanceFromBatch;
        CurrPage.Update(false);
    end;

    local procedure GetCurrentlySelectedLines(var GenJournalLine: Record "Gen. Journal Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(GenJournalLine);
        exit(GenJournalLine.FindSet);
    end;

    local procedure SetControlAppearanceFromBatch()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        CanRequestFlowApprovalForAllLines: Boolean;
    begin
        if (Rec."Journal Template Name" <> '') and (Rec."Journal Batch Name" <> '') then
            GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name")
        else
            if not GenJournalBatch.Get(Rec.GetRangeMax("Journal Template Name"), CurrentJnlBatchName) then
                exit;

        CheckOpenApprovalEntries(GenJournalBatch.RecordId);

        CanCancelApprovalForJnlBatch := ApprovalsMgmt.CanCancelApprovalForRecord(GenJournalBatch.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancelJournalBatch(
          GenJournalBatch, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForBatch, CanRequestFlowApprovalForAllLines);
        CanRequestFlowApprovalForBatchAndAllLines := CanRequestFlowApprovalForBatch and CanRequestFlowApprovalForAllLines;
    end;

    local procedure CheckOpenApprovalEntries(BatchRecordId: RecordID)
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUserBatch := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(BatchRecordId);

        OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(BatchRecordId);

        OpenApprovalEntriesOnBatchOrAnyJnlLineExist :=
          OpenApprovalEntriesOnJnlBatchExist or
          ApprovalsMgmt.HasAnyOpenJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        CanRequestFlowApprovalForLine: Boolean;
    begin
        OpenApprovalEntriesExistForCurrUser :=
          OpenApprovalEntriesExistForCurrUserBatch or ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);

        OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or OpenApprovalEntriesOnJnlLineExist;

        CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestFlowApprovalForLine, CanCancelFlowApprovalForLine);
        CanRequestFlowApprovalForBatchAndCurrentLine := CanRequestFlowApprovalForBatch and CanRequestFlowApprovalForLine;
    end;

    local procedure SetControlVisibility()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        AmountVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Debit/Credit Only");
        DebitCreditVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Amount Only");
    end;

    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);
    end;

    local procedure SetAMCAppearance()
    var
        BankAccount: Record "Bank Account";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        AMCFormat := false;
        //if GenJournalBatch.Get("Journal Template Name", CurrentJnlBatchName) then//GMCSCOM
        if BankAccount.Get(GenJournalBatch."Bal. Account No.") then
            if GenJournalBatch."Bal. Account Type" = GenJournalBatch."Bal. Account Type"::"Bank Account" then
                //if (BankAccount."Export Format" = 0) or (BankAccount."Export Format" = BankAccount."Export Format"::Other) then//GMCSCOM
                AMCFormat := true;
    end;

    local procedure EntriesToVoid(GenJnlLine3: Record "Gen. Journal Line"; AMC: Boolean): Boolean
    begin
        GenJnlLine3.SetFilter("Document Type", 'Payment|Refund');
        GenJnlLine3.SetFilter("Bank Payment Type", 'Electronic Payment|Electronic Payment-IAT');
        if AMC then
            GenJnlLine3.SetRange("Exported to Payment File", true)
        else begin
            GenJnlLine3.SetRange("Check Printed", true);
            GenJnlLine3.SetRange("Check Exported", true);
        end;
        GenJnlLine3.SetRange("Check Transmitted", false);
        exit(GenJnlLine3.FindFirst);
    end;

    local procedure UseForElecPaymentChecked(GenJnlLine3: Record "Gen. Journal Line"): Boolean
    var
        CustomerBankAccount: Record "Customer Bank Account";
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        if GenJnlLine3."Bal. Account Type" <> GenJnlLine3."Bal. Account Type"::"Bank Account" then
            if GenJnlLine3."Bal. Account Type" = GenJnlLine3."Bal. Account Type"::Vendor then begin
                VendorBankAccount.SetRange("Vendor No.", GenJnlLine3."Bal. Account No.");
                VendorBankAccount.SetRange(Code, GenJnlLine3."Recipient Bank Account");
                if VendorBankAccount.FindFirst then
                    //exit(VendorBankAccount."Use for Electronic Payments")//GMCSCOM
                    // end else
                    if GenJnlLine3."Bal. Account Type" = GenJnlLine3."Bal. Account Type"::Customer then begin
                        CustomerBankAccount.SetRange("Customer No.", GenJnlLine3."Bal. Account No.");
                        CustomerBankAccount.SetRange(Code, GenJnlLine3."Recipient Bank Account");
                        if CustomerBankAccount.FindFirst then
                            //exit(CustomerBankAccount."Use for Electronic Payments");//GMCSCOM
                            //end else
                            exit(true)
                        else
                            if GenJnlLine3."Account Type" <> GenJnlLine3."Account Type"::"Bank Account" then
                                if GenJnlLine3."Account Type" = GenJnlLine3."Account Type"::Vendor then begin
                                    VendorBankAccount.SetRange("Vendor No.", GenJnlLine3."Account No.");
                                    VendorBankAccount.SetRange(Code, GenJnlLine3."Recipient Bank Account");
                                    if VendorBankAccount.FindFirst then
                                        //exit(VendorBankAccount."Use for Electronic Payments");//GMCSCOM
                                        //  end else
                                        if GenJnlLine3."Account Type" = GenJnlLine3."Account Type"::Customer then begin
                                            CustomerBankAccount.SetRange("Customer No.", GenJnlLine3."Account No.");
                                            CustomerBankAccount.SetRange(Code, GenJnlLine3."Recipient Bank Account");
                                            if CustomerBankAccount.FindFirst then
                                                //exit(CustomerBankAccount."Use for Electronic Payments");//GMCSCOM
                                                //  end else
                                                exit(true);
                                        end;
                                end;
                    end;
            end;
    end;

    local procedure SetJobQueueVisibility()
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        JobQueuesUsed := GeneralLedgerSetup.JobQueueActive;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var GenJournalLine: Record "Gen. Journal Line"; var ShortcutDimCode: array[8] of Code[20]; DimIndex: Integer)
    begin
    end;
}


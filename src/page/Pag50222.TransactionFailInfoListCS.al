page 50222 "Transaction Fail Info List-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID       Date       Trigger                       Remarks
    // .............................................................................................
    // 03.   CSPL-00174   03-02-19   Post  Entry  - OnAction()    Code has been added to post entries
    ApplicationArea = All;
    UsageCategory = Administration;
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Failed Transaction Details-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Reciept No."; Rec."Reciept No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Documnet No."; Rec."Documnet No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }
                field("Batch Name"; Rec."Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Apply To Doc No."; Rec."Apply To Doc No.")
                {
                    ApplicationArea = All;
                }
                field("Fee Code"; Rec."Fee Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Success/Fail"; Rec."Success/Fail")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post  Entry ")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code has been added to post entries::CSPL-00174::030219: Start
                    IF CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN
                        DocNo := '';
                        FailedTransactionDetailsCS.Reset();
                        FailedTransactionDetailsCS.SETCURRENTKEY("Student No.", "Document Type", "Fee Code");
                        FailedTransactionDetailsCS.SETRANGE("Success/Fail", FailedTransactionDetailsCS."Success/Fail"::Failed);
                        IF FailedTransactionDetailsCS.FINDSET() THEN
                            REPEAT
                                IF FailedTransactionDetailsCS."Document Type" = FailedTransactionDetailsCS."Document Type"::Invoice THEN BEGIN
                                    FailedTransactionDetailsCS.TESTFIELD("Template Name");
                                    FailedTransactionDetailsCS.TESTFIELD("Batch Name");
                                    FailedTransactionDetailsCS.TESTFIELD("Student No.");
                                    FailedTransactionDetailsCS.TESTFIELD(Amount);
                                    FailedTransactionDetailsCS.TESTFIELD("Bal. Account No.");
                                    FailedTransactionDetailsCS.TESTFIELD("Fee Code");
                                    GenWebJournalCS.CSInsertCustomerInvoice(FailedTransactionDetailsCS."Template Name", FailedTransactionDetailsCS."Batch Name",
                                                                        FailedTransactionDetailsCS."Student No.", FailedTransactionDetailsCS.Amount, '',
                                                                        FailedTransactionDetailsCS."Bal. Account No.", DocNo,
                                                                        FailedTransactionDetailsCS."Fee Code");
                                    GenWebJournalCS.CSPostCustomerEntry(FailedTransactionDetailsCS."Template Name",
                                                                    FailedTransactionDetailsCS."Batch Name");

                                    FailedTransactionDetails1CS.Reset();
                                    FailedTransactionDetails1CS.SETRANGE("Student No.", FailedTransactionDetailsCS."Student No.");
                                    FailedTransactionDetails1CS.SETRANGE("Document Type", FailedTransactionDetailsCS."Document Type");
                                    FailedTransactionDetails1CS.SETRANGE("Fee Code", FailedTransactionDetailsCS."Fee Code");
                                    IF FailedTransactionDetails1CS.FINDFIRST() THEN
                                        FailedTransactionDetails1CS.DELETE();

                                END ELSE
                                    IF FailedTransactionDetailsCS."Document Type" = FailedTransactionDetailsCS."Document Type"::Payment THEN BEGIN
                                        DocNo := '';
                                        FailedTransactionDetailsCS.TESTFIELD("Template Name");
                                        FailedTransactionDetailsCS.TESTFIELD("Batch Name");
                                        FailedTransactionDetailsCS.TESTFIELD("Student No.");
                                        FailedTransactionDetailsCS.TESTFIELD(Amount);
                                        FailedTransactionDetailsCS.TESTFIELD("Bank Account No.");
                                        FailedTransactionDetailsCS.TESTFIELD("Fee Code");
                                        FailedTransactionDetailsCS.TESTFIELD("Transaction No.");
                                        FailedTransactionDetailsCS.TESTFIELD("Reciept No.");

                                        IF FailedTransactionDetailsCS."Documnet No." <> '' THEN
                                            DocNo := FailedTransactionDetailsCS."Documnet No."
                                        ELSE BEGIN
                                            CustLedgerEntry.Reset();
                                            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                                            CustLedgerEntry.SETRANGE("Customer No.", FailedTransactionDetailsCS."Student No.");
                                            CustLedgerEntry.SETRANGE("Fee Code", FailedTransactionDetailsCS."Fee Code");
                                            CustLedgerEntry.SETRANGE(Open, TRUE);
                                            IF CustLedgerEntry.FINDFIRST() THEN
                                                DocNo := CustLedgerEntry."Document No.";
                                        END;

                                        FeeComponentMasterCS.Reset();
                                        FeeComponentMasterCS.SETRANGE(Code, Rec."Fee Code");
                                        IF FeeComponentMasterCS.FINDFIRST() THEN
                                            GenWebJournalCS.CSInsertCustomerPayment(FailedTransactionDetailsCS."Template Name", FailedTransactionDetailsCS."Batch Name",
                                                                                FailedTransactionDetailsCS."Student No.", FailedTransactionDetailsCS.Amount, '',
                                                                                FailedTransactionDetailsCS."Bank Account No.", DocNo,
                                                                                FailedTransactionDetailsCS."Fee Code", FeeComponentMasterCS.Description,
                                                                                FailedTransactionDetailsCS."Transaction No.", FailedTransactionDetailsCS."Reciept No.");
                                        GenWebJournalCS.CSPostCustomerEntry(FailedTransactionDetailsCS."Template Name",
                                                                        FailedTransactionDetailsCS."Batch Name");
                                    END;


                                FailedTransactionDetails1CS.Reset();
                                FailedTransactionDetails1CS.SETRANGE("Student No.", FailedTransactionDetailsCS."Student No.");
                                FailedTransactionDetails1CS.SETRANGE("Document Type", FailedTransactionDetailsCS."Document Type");
                                FailedTransactionDetails1CS.SETRANGE("Fee Code", FailedTransactionDetailsCS."Fee Code");
                                IF FailedTransactionDetails1CS.FINDFIRST() THEN
                                    FailedTransactionDetails1CS.DELETE();

                            UNTIL FailedTransactionDetailsCS.NEXT() = 0;
                        CurrPage.Update();
                        MESSAGE('Entries SuccessFully Posted !!');
                    END ELSE
                        EXIT;
                    //Code has been added to post entries ::CSPL-00174::030219: End
                end;
            }
        }
    }

    var
        FailedTransactionDetailsCS: Record "Failed Transaction Details-CS";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        FailedTransactionDetails1CS: Record "Failed Transaction Details-CS";
        GenWebJournalCS: Codeunit "Gen. Web  Journal -CS";

        DocNo: Code[20];
        Text_10001Lbl: Label 'Do You Want To Post  ?  ';


}
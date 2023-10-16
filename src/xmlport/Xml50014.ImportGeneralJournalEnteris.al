xmlport 50014 "Import General Journal Enteris"
{
    // version V.001-CS


    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoUpdate = true;
                XmlName = 'GenJournalLine';
                fieldelement(JournalTemplateName; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(JournalBatchName; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement("LineNo."; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(PostingDate; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(DocumentType; "Gen. Journal Line"."Document Type")
                {
                }
                fieldelement("DocumentNo."; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(AccountType; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement("AccountNo."; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement("EnrollmentNo."; "Gen. Journal Line"."Enrollment No.")
                {
                }
                fieldelement(CurrencyCode; "Gen. Journal Line"."Currency Code")
                {
                }
                fieldelement(CurrencyExchRate; "Gen. Journal Line"."Currency Exch. Rate")
                {
                }
                fieldelement(Amount; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(DebitAmount; "Gen. Journal Line"."Debit Amount")
                {
                }
                fieldelement(CreditAmount; "Gen. Journal Line"."Credit Amount")
                {
                }
                fieldelement(AmountLCY; "Gen. Journal Line"."Amount (LCY)")
                {
                }
                fieldelement(Description; "Gen. Journal Line".Description)
                {
                }
                fieldelement(DueDate; "Gen. Journal Line"."Due Date")
                {
                }
                fieldelement(g; "Gen. Journal Line"."Source Code")
                {
                }
                fieldelement(FeeCode; "Gen. Journal Line"."Fee Code")
                {
                }
                fieldelement(BalAccountType; "Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement("BalAccountNo."; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(DepartmentCode; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(InstituteCode; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Gen. Journal Line"."Shortcut Dimension 1 Code" := FORMAT('0' + "Gen. Journal Line"."Shortcut Dimension 1 Code");
                    end;
                }
                fieldelement(Narration; "Gen. Journal Line".Narration)
                {
                }
                fieldelement(SynchronisedwithSFAS; "Gen. Journal Line"."Synchronised with SFAS")
                {
                }
            }
        }
    }


}


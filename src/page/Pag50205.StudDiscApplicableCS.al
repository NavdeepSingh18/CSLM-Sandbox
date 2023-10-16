page 50205 "Stud. Disc Applicable-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00130   07/03/2019       Discount Applied-OnPush()                   For Applied Discount
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Application-CS";
    SourceTableView = WHERE("Discount Applicable" = CONST(true),
                            "Discount Status" = FILTER("Discount Pending"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                }
                field("Discount Code"; Rec."Discount Code")
                {
                    ApplicationArea = All;
                }
                field("Discount Status"; Rec."Discount Status")
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
            group(Discount)
            {
                Caption = 'Discount';
                action("Discount Applied")
                {
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(RecApplication);
                        IF RecApplication.FindSet() THEN
                            REPEAT
                                CLE.Reset();
                                CLE.SETRANGE("Customer No.", RecApplication."Student No.");
                                CLE.SETFILTER(CLE."Document Type", '%1', CLE."Document Type"::Invoice);
                                MESSAGE('Cle....1');
                                IF CLE.FINDFIRST() THEN
                                    REPEAT
                                        MESSAGE('Cle....1');
                                        DiscountRec.Reset();
                                        DiscountRec.SETRANGE("Document No.", RecApplication."Discount Code");
                                        DiscountRec.SETRANGE("Fee Code", CLE."Fee Code");
                                        CLEAR(NoSeries);
                                        FeeSetup.GET();
                                        FeeSetup.TESTFIELD("Journal Template Name");
                                        FeeSetup.TESTFIELD("Journal Batch Name");
                                        Fee_Amount := 0;
                                        IF DiscountRec.FindSet() THEN BEGIN
                                            MESSAGE('No Series');
                                            "TempDocNo.1" := NoSeries.GetNextNo(FeeSetup."Fee Discount", 0D, TRUE);
                                            MESSAGE('%1', "TempDocNo.1");
                                            REPEAT
                                                CLE.CALCFIELDS(CLE."Amount (LCY)");
                                                Fee_Amount := Fee_Amount + CLE."Amount (LCY)";
                                                MESSAGE('%1', Fee_Amount);
                                                IF DiscountRec."Discount%" <> 0 THEN BEGIN
                                                    DiscountAmount := (Fee_Amount * DiscountRec."Discount%") / 100;
                                                    IF DiscountAmount <> 0 THEN BEGIN
                                                        GenJournalLine.Reset();
                                                        GenJournalLine.SETRANGE("Journal Template Name", FeeSetup."Journal Template Name");
                                                        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetup."Journal Batch Name");
                                                        IF GenJournalLine.FINDLAST() THEN
                                                            LineNo := GenJournalLine."Line No." + 10000
                                                        ELSE
                                                            LineNo := 10000;
                                                        GenJournalLine.INIT();
                                                        GenJournalLine."Journal Template Name" := FeeSetup."Journal Template Name";
                                                        GenJournalLine."Journal Batch Name" := FeeSetup."Journal Batch Name";
                                                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                                                        IF Fee_Amount > 0 THEN
                                                            GenJournalLine."Document Type" := GenJournalLine."Document Type"::"Credit Memo"
                                                        ELSE
                                                            IF Fee_Amount < 0 THEN
                                                                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account No." := Rec."Student No.";
                                                        GenJournalLine.VALIDATE("Account No.");
                                                        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                                        GenJournalLine."Bal. Account No." := DiscountRec."G/L Account";
                                                        GenJournalLine.Description := DiscountRec.Description;
                                                        GenJournalLine."Posting Date" := TODAY();
                                                        GenJournalLine.VALIDATE(Amount, (-1 * DiscountAmount));
                                                        GenJournalLine.Course := RecStudent."Course Code";
                                                        GenJournalLine.Semester := RecStudent.Semester;
                                                        GenJournalLine."Document No." := "TempDocNo.1";
                                                        GenJournalLine."Academic Year" := RecStudent."Academic Year";
                                                        GenJournalLine."Fee Code" := DiscountRec."Fee Code";
                                                        GenJournalLine.INSERT(TRUE);
                                                    END;
                                                END;
                                            UNTIL DiscountRec.NEXT() = 0;
                                        END;
                                    UNTIL CLE.NEXT() = 0;
                                RecApplication.Modify();
                            UNTIL RecApplication.NEXT() = 0;
                    end;
                }
            }
        }
    }

    var
        RecApplication: Record "Application-CS";
        RecStudent: Record "Student Master-CS";
        DiscountRec: Record "Fee Discount Line-CS";
        FeeSetup: Record "Fee Setup-CS";
        GenJournalLine: Record "Gen. Journal Line";
        CLE: Record "Cust. Ledger Entry";
        NoSeries: Codeunit "NoSeriesManagement";
        Fee_Amount: Decimal;
        "TempDocNo.1": Code[20];
        DiscountAmount: Decimal;
        LineNo: Integer;

}
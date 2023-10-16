page 50641 "Pending Financial Aid Roster"
{
    PageType = List;
    SourceTable = "Financial Aid Roster";
    Caption = 'Pending Financial Aid Roster';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = where(Status = filter("Pending for Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Fund Type"; Rec."Fund Type")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Uploaded Amount"; Rec."Uploaded Amount")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Rejection Remarks"; Rec."Rejection Remarks")
                {
                    ApplicationArea = All;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("&Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                        CurrPage.SetSelectionFilter(FinancialAidRosterRec);
                        IF FinancialAidRosterRec.FindSet() Then begin
                            repeat
                                if FinancialAidRosterRec.Status = FinancialAidRosterRec.Status::Approved then
                                    Error('Status is already Approved');
                                FinancialAidRosterRec.TestField(FinancialAidRosterRec."Bank Account No.");
                                FinancialAidRosterRec.TestField(FinancialAidRosterRec."Student No.");
                                FinancialAidRosterRec.TestField(FinancialAidRosterRec."Approved Amount");
                                If FinancialAidRosterRec."Approved Amount" < 0 then
                                    Error('Amount must be greater then Zero');

                                FinancialAidRosterRec.Status := FinancialAidRosterRec.Status::Approved;
                                FinancialAidRosterRec."Approved/Rejected By" := UserId();
                                FinancialAidRosterRec."Approved/Rejected On" := WorkDate();
                                FinancialAidRosterRec.Modify();
                                InsertPaymentJournal(FinancialAidRosterRec);
                            until FinancialAidRosterRec.Next() = 0;
                            MESSAGE('Financial Aid Roster has been uploaded on Payment Journal !');
                        end;
                    end;
                end;
            }
            action("&Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF CONFIRM(Text003Lbl, FALSE) THEN BEGIN
                        CurrPage.SetSelectionFilter(FinancialAidRosterRec);
                        IF FinancialAidRosterRec.FindSet() Then begin
                            repeat
                                FinancialAidRosterRec.TestField(FinancialAidRosterRec."Rejection Remarks");
                                if FinancialAidRosterRec.Status = FinancialAidRosterRec.Status::Approved then
                                    Error('Approved Financial Aid cannot be Rejected');
                                FinancialAidRosterRec.Status := FinancialAidRosterRec.Status::Rejected;
                                FinancialAidRosterRec."Approved/Rejected By" := UserId();
                                FinancialAidRosterRec."Approved/Rejected On" := WorkDate();
                                FinancialAidRosterRec.Modify();
                            until FinancialAidRosterRec.Next() = 0;
                            MESSAGE('Financial Aid Roster has been Rejected !');
                        end;
                    end;
                end;
            }
            action("Fee Generation")
            {
                ApplicationArea = All;
                Caption = 'Fee Generation';
                Image = Report;
                RunObject = report "Fee Generation New";
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

            }
            action("Payment Journal")
            {
                ApplicationArea = All;
                Caption = 'Payment Journal';
                RunObject = Page "Payment Journal";
                Image = ViewPage;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
            }
            action("General Journal")
            {
                ApplicationArea = All;
                Caption = 'General Journal';
                RunObject = Page "General Journal";
                Image = ViewPage;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
            }

        }
    }

    var
        FinancialAidRosterRec: Record "Financial Aid Roster";
        Text001Lbl: Label 'Do you want to Approve Financial Aid Roster?';
        Text003Lbl: Label 'Do you want to Rejected Financial Aid Roster?';

    procedure InsertPaymentJournal(CurrentRec: Record "Financial Aid Roster")
    var
        GenJournalLine1: Record "Gen. Journal Line";
        GenJournalLine: Record "Gen. Journal Line";
        FeeSetupCS: Record "Fee Setup-CS";
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeries: Codeunit NoSeriesManagement;
        TempDocNo: Code[20];
        LineNo: Integer;
    Begin
        IF CurrentRec.Status = CurrentRec.Status::Approved THEN BEGIN

            //  Customer.Get(CurrentRec."Student No.");
            FeeSetupCS.Reset();
            FeeSetupCS.SetRange("Global Dimension 1 Code", CurrentRec."Global Dimension 1 Code");
            IF FeeSetupCS.FindFirst() then begin
                FeeSetupCS.TESTFIELD("Payment Template Name");
                FeeSetupCS.TESTFIELD("Receipt Batch");
            end;

            // GenJournalLine1.Reset();
            // GenJournalLine1.SETRANGE("Journal Template Name", FeeSetupCS."Payment Template Name");
            // GenJournalLine1.SETRANGE("Journal Batch Name", FeeSetupCS."Receipt Batch");
            // IF GenJournalLine1.FINDLAST() THEN
            //     TempDocNo := INCSTR(GenJournalLine1."Document No.")
            // ELSE begin
            GenJournalBatch.RESET();
            GenJournalBatch.SETRANGE("Journal Template Name", FeeSetupCS."Payment Template Name");
            GenJournalBatch.SETRANGE(Name, FeeSetupCS."Receipt Batch");
            IF GenJournalBatch.FINDFIRST() THEN;
            TempDocNo := NoSeries.GetNextNo(GenJournalBatch."No. Series", 0D, true);
            //end;


            GenJournalLine1.RESET();
            GenJournalLine1.SetRange("Journal Template Name", FeeSetupCS."Payment Template Name");
            GenJournalLine1.SetRange("Journal Batch Name", FeeSetupCS."Receipt Batch");
            IF GenJournalLine1.FINDLAST() THEN
                LineNo := GenJournalLine1."Line No." + 10000
            ELSE
                LineNo := 10000;

            GenJournalLine.RESET();
            GenJournalLine.INIT();
            GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Payment Template Name");
            GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Receipt Batch");
            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
            GenJournalLine.VALIDATE("Document No.", TempDocNo);
            GenJournalLine."Line No." := LineNo;
            GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"Bank Account");
            GenJournalLine.VALIDATE("Account No.", CurrentRec."Bank Account No.");
            GenJournalLine.VALIDATE("Posting Date", CurrentRec."Approved/Rejected On");
            GenJournalLine.VALIDATE("Document Date", CurrentRec."Date");
            GenJournalLine.VALIDATE("Debit Amount", CurrentRec."Approved Amount");
            GenJournalLine.VALIDATE("Fund Type", CurrentRec."Fund Type");
            GenJournalLine.VALIDATE("Roster Entry No.", CurrentRec."Entry No");
            GenJournalLine."Payment By Financial Aid" := true;
            GenJournalLine.Semester := CurrentRec.Semester;
            GenJournalLine."Academic Year" := CurrentRec."Academic Year";
            GenJournalLine.Course := CurrentRec.Course;
            GenJournalLine."Enrollment No." := CurrentRec."Enrollment No.";
            GenJournalLine.Year := CurrentRec.Year;
            GenJournalLine.Term := CurrentRec.Term;
            GenJournalLine.Validate("Applies-to Doc. Type", CurrentRec."Applies to Doc. Type");
            GenJournalLine.Validate("Applies-to Doc. No.", CurrentRec."Applies to Doc. No.");
            GenJournalLine.INSERT();
            InsertPaymentJournalSub(CurrentRec, FeeSetupCS."Payment Template Name", FeeSetupCS."Receipt Batch", LineNo, TempDocNo);

        END;
    End;

    procedure InsertPaymentJournalSub(CurrentRec: Record "Financial Aid Roster"; Template: Code[10]; BatchName: Code[10]; LineNo: Integer; TempDocNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        StudentMasterRec: Record "Student Master-CS";
    Begin
        StudentMasterRec.Get(CurrentRec."Student No.");

        GenJournalLine.RESET();
        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", Template);
        GenJournalLine.VALIDATE("Journal Batch Name", BatchName);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Document No.", TempDocNo);
        GenJournalLine."Line No." := LineNo + 10000;
        GenJournalLine.VALIDATE("Posting Date", CurrentRec."Approved/Rejected On");
        GenJournalLine.VALIDATE("Document Date", CurrentRec."Date");
        GenJournalLine.VALIDATE("Credit Amount", CurrentRec."Approved Amount");
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", CurrentRec."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.VALIDATE("Account No.", StudentMasterRec."Original Student No.");
        GenJournalLine.VALIDATE("Fund Type", CurrentRec."Fund Type");
        GenJournalLine.VALIDATE("Roster Entry No.", CurrentRec."Entry No");
        GenJournalLine."Payment By Financial Aid" := true;
        GenJournalLine.Semester := CurrentRec.Semester;
        GenJournalLine."Academic Year" := CurrentRec."Academic Year";
        GenJournalLine.Course := CurrentRec.Course;
        GenJournalLine."Enrollment No." := CurrentRec."Enrollment No.";
        GenJournalLine.Year := CurrentRec.Year;
        GenJournalLine.Term := CurrentRec.Term;
        GenJournalLine.Validate("Applies-to Doc. Type", CurrentRec."Applies to Doc. Type");
        GenJournalLine.Validate("Applies-to Doc. No.", CurrentRec."Applies to Doc. No.");
        GenJournalLine.INSERT();
    End;
    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
}
page 50577 "Clinical Billing Reversal"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "CLN Billing Reversal Detail";
    SourceTableView = where("Posted No." = const(''));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Details")
            {
                field(StudentNo; StudentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(StudentName; StudentName)
                {
                    ApplicationArea = All;
                    Caption = 'Student Name';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(WeekstoReverse; WeekstoReverse)
                {
                    ApplicationArea = All;
                    Caption = 'Week(s) to Reverse';
                    Style = Unfavorable;

                    trigger OnValidate()
                    var
                        CBRD: Record "CLN Billing Reversal Detail";
                    begin
                        CBRD.Reset();
                        CBRD.SetRange("Student No.", StudentNo);
                        CBRD.SetRange("Posted No.", '');
                        if CBRD.FindSet() then
                            repeat
                                CBRD.Delete();
                            until CBRD.Next() = 0;
                    end;
                }
                field(FIUWeekstoReverse; FIUWeekstoReverse)
                {
                    ApplicationArea = All;
                    Caption = 'FIU Week(s) to Reverse';
                    Style = Unfavorable;
                    trigger OnValidate()
                    var
                        CBRD: Record "CLN Billing Reversal Detail";
                    begin
                        CBRD.Reset();
                        CBRD.SetRange("Student No.", StudentNo);
                        CBRD.SetRange("Posted No.", '');
                        if CBRD.FindSet() then
                            repeat
                                CBRD.Delete();
                            until CBRD.Next() = 0;
                    end;
                }
                field(TotalInvoiceAmount; TotalInvoiceAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Invoice Amount';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(TotalReversalAmount; TotalReversalAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Reversal Amount';
                    Style = Unfavorable;
                    Editable = false;
                }
            }
            repeater(General)
            {
                Editable = false;
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Fee Code"; Rec."Fee Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Fee Description"; Rec."Fee Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Amount to Reverse"; Rec."Amount to Reverse")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate Reversal Amount")
            {
                ApplicationArea = All;
                Caption = 'Calculate Reversal Amount';
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ShortcutKey = 'F7';
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    FeeCourse: Record "Fee Course Head-CS";
                    FeeCourseLine: Record "Fee Course Line-CS";
                    FeeComponent: Record "Fee Component Master-CS";
                    CBRD: Record "CLN Billing Reversal Detail";
                    ReversalAmount: Decimal;
                    InvoiceAmount: Decimal;
                    FeeSetupNo: Code[20];
                    LSemester: Code[20];
                    LastEntryNo: Integer;
                begin
                    StudentMaster.Reset();
                    if StudentMaster.Get(StudentNo) then;

                    LSemester := 'CLN5';
                    if StudentMaster.ClnBldSem5 then
                        LSemester := 'CLN5';
                    if StudentMaster.ClnBldSem6 then
                        LSemester := 'CLN6';
                    if StudentMaster.ClnBldSem7 then
                        LSemester := 'CLN7';
                    if StudentMaster.ClnBldSem8 then
                        LSemester := 'CLN8';

                    ReversalAmount := 0;
                    InvoiceAmount := 0;

                    FeeCourse.Reset();
                    FeeCourse.SetRange("Course Code", StudentMaster."Course Code");
                    FeeCourse.SetRange("Academic Year", StudentMaster."Academic Year");
                    FeeCourse.SetRange(Semester, LSemester);
                    FeeCourse.SetRange("Other Fees", false);
                    if FeeCourse.FindLast() then
                        FeeSetupNo := FeeCourse."No.";

                    FeeCourseLine.Reset();
                    FeeCourseLine.SetRange("Document No.", FeeSetupNo);
                    FeeCourseLine.SetRange("Course Code", StudentMaster."Course Code");
                    FeeCourseLine.SetRange("Other Fees", false);
                    if FeeCourseLine.FindSet() then
                        repeat
                            FeeComponent.Reset();
                            if FeeComponent.Get(FeeCourseLine."Fee Code") then;

                            IF NOT (FeeComponent."Type Of Fee" IN [FeeComponent."Type Of Fee"::"INSTALMENT FEE"]) then begin
                                LastEntryNo := LastEntryNo + 1;
                                CBRD.Init();
                                CBRD."Entry No." := LastEntryNo;
                                CBRD.Validate("Student No.", StudentNo);
                                CBRD."Account Type" := CBRD."Account Type"::"G/L Account";
                                CBRD.Validate("G/L Account No.", FeeComponent."G/L Account");
                                CBRD.Validate("Fee Code", FeeCourseLine."Fee Code");

                                if (WeekstoReverse <> 0) and (CBRD."FIU Surcharge" = false) AND (CBRD."Account Type" <> CBRD."Account Type"::Customer) then begin
                                    CBRD."Invoice Amount" := FeeCourseLine.Amount;
                                    CBRD."Amount to Reverse" := -1 * Round((CBRD."Invoice Amount" / 21) * WeekstoReverse, 0.01, '=');
                                    CBRD."Reversal Weeks" := WeekstoReverse;
                                end;

                                if (CBRD."FIU Surcharge" = true) and (FIUWeekstoReverse <> 0) and (CBRD."Account Type" <> CBRD."Account Type"::Customer) then begin
                                    CBRD."Invoice Amount" := FeeCourseLine.Amount * 21;
                                    CBRD."Amount to Reverse" := -1 * FeeCourseLine.Amount * FIUWeekstoReverse;
                                    CBRD."Reversal Weeks" := FIUWeekstoReverse;
                                end;

                                InvoiceAmount := InvoiceAmount + CBRD."Invoice Amount";
                                ReversalAmount := ReversalAmount + CBRD."Amount to Reverse";

                                CBRD."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";

                                IF CBRD."Amount to Reverse" <> 0 then begin
                                    CBRD.Insert();

                                    if CBRD."Account Type" = CBRD."Account Type"::"G/L Account" then begin
                                        TotalInvoiceAmount := TotalInvoiceAmount + CBRD."Invoice Amount";
                                        TotalReversalAmount := TotalReversalAmount + CBRD."Amount to Reverse";
                                    end;
                                end;
                            end;
                        until FeeCourseLine.Next() = 0;

                    LastEntryNo := LastEntryNo + 1;
                    CBRD.Init();
                    CBRD."Entry No." := LastEntryNo;
                    CBRD.Validate("Student No.", StudentNo);
                    CBRD."Account Type" := CBRD."Account Type"::Customer;
                    CBRD.Validate("G/L Account No.", StudentNo);

                    CBRD."Invoice Amount" := -1 * InvoiceAmount;
                    CBRD."Amount to Reverse" := -1 * ReversalAmount;

                    CBRD."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                    CBRD.Insert();
                end;
            }
            action("Post Reversal Entry")
            {
                ApplicationArea = All;
                Caption = 'Post Reversal Entry';
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ShortcutKey = 'F9';
                trigger OnAction()
                var
                    CBRD: Record "CLN Billing Reversal Detail";
                    StudentMaster: Record "Student Master-CS";
                    FeeSetup: Record "Fee Setup-CS";
                    GJB: Record "Gen. Journal Batch";
                    GJL: Record "Gen. Journal Line";
                    DocumentNo: Code[20];
                    InvNo: Code[20];
                begin
                    StudentMaster.Reset();
                    if StudentMaster.Get(StudentNo) then
                        StudentMaster.TestField("Global Dimension 1 Code");

                    FeeSetup.Reset();
                    FeeSetup.Reset();
                    FeeSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                    if FeeSetup.FindFirst() then begin
                        FeeSetup.TestField("Journal Template Name");
                        FeeSetup.TestField("Journal Batch Name");
                    end;

                    GJB.Reset();
                    if GJB.Get(FeeSetup."Journal Template Name", FeeSetup."Journal Batch Name") then
                        GJB.TestField("No. Series");

                    GJL.Reset();
                    GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                    GJL.SetRange("Journal Batch Name", GJB.Name);
                    if GJL.FindFirst() then
                        repeat
                            GJL.Delete(true);
                        until GJL.Next() = 0;

                    InvNo := '';
                    CBRD.Reset();
                    CBRD.SetCurrentKey("Invoice No.");
                    CBRD.SetRange("Student No.", StudentNo);
                    CBRD.SetRange("Posted No.", '');
                    CBRD.SetFilter("Amount to Reverse", '<>%1', 0);
                    if CBRD.FindSet() then
                        repeat
                            IF InvNo <> CBRD."Invoice No." then begin
                                InvNo := CBRD."Invoice No.";
                                DocumentNo := '';
                            end;
                            InsertJournalLine(FeeSetup, GJB, StudentMaster, CBRD, DocumentNo);
                        until CBRD.Next() = 0;

                    GJL.Reset();
                    GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                    GJL.SetRange("Journal Batch Name", GJB.Name);
                    IF GJL.FindFirst() then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GJL);

                    GJL.Reset();
                    GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                    GJL.SetRange("Journal Batch Name", GJB.Name);
                    if GJL.FindFirst() then
                        repeat
                            GJL.Delete(true);
                        until GJL.Next() = 0;
                end;
            }
            action("Calculate Reversal Amount NA")
            {
                ApplicationArea = All;
                Caption = 'Calculate Reversal Amount';   //NOT IN USE
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ShortcutKey = 'F7';
                Visible = false;
                Enabled = false;
                Description = 'NOT IN USE';
                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    CLE_1: Record "Cust. Ledger Entry";
                    GLEntry: Record "G/L Entry";
                    CBRD: Record "CLN Billing Reversal Detail";
                    LastEntryNo: Integer;
                    InvoiceNoToReverse: Code[2048];
                    BalanceAmount: Decimal;
                    BilledWeeks: Integer;
                    FIUBilledWeeks: Integer;
                begin
                    CBRD.Reset();
                    CBRD.SetRange("Student No.", StudentNo);
                    CBRD.SetRange("Posted No.", '');
                    if CBRD.FindSet() then
                        repeat
                            CBRD.Delete();
                        until CBRD.Next() = 0;

                    InvoiceNoToReverse := '';
                    BilledWeeks := 0;
                    FIUBilledWeeks := 0;

                    CLE.Reset();
                    CLE.SetCurrentKey("Customer No.");
                    CLE.SetRange("Customer No.", StudentNo);
                    CLE.SetRange("Type of Billing", CLE."Type of Billing"::"Clinical Billing");
                    CLE.SetFilter("Billing Weeks", '>%1', 0);
                    if CLE.FindLast() then begin
                        InvoiceNoToReverse := CLE."Document No.";
                        BilledWeeks := CLE."Billing Weeks";
                    end;

                    CLE.Reset();
                    CLE.SetCurrentKey("Customer No.");
                    CLE.SetRange("Customer No.", StudentNo);
                    CLE.SetRange("Type of Billing", CLE."Type of Billing"::"Clinical Billing");
                    CLE.SetFilter("FIU Billing Weeks", '>%1', 0);
                    if CLE.FindLast() then begin
                        if InvoiceNoToReverse = '' then
                            InvoiceNoToReverse := CLE."Document No."
                        else
                            InvoiceNoToReverse := InvoiceNoToReverse + '|' + CLE."Document No.";
                        FIUBilledWeeks := CLE."FIU Billing Weeks";
                    end;

                    CLE_1.Reset();
                    CLE_1.SetCurrentKey("Customer No.");
                    CLE_1.SetFilter("Entry No.", '<>%1', CLE."Entry No.");
                    CLE_1.SetRange("Customer No.", StudentNo);
                    CLE_1.SetRange("Type of Billing", CLE."Type of Billing"::"Clinical Billing");
                    CLE_1.SetRange(Semester, CLE.Semester);
                    if CLE_1.FindSet() then
                        repeat
                            if StrPos(InvoiceNoToReverse, CLE_1."Document No.") = 0 then
                                InvoiceNoToReverse := InvoiceNoToReverse + '|' + CLE_1."Document No.";
                        until CLE_1.Next() = 0;

                    CBRD.Reset();
                    if CBRD.FindLast() then
                        LastEntryNo := CBRD."Entry No.";

                    TotalInvoiceAmount := 0;
                    TotalReversalAmount := 0;
                    BalanceAmount := 0;

                    GLEntry.Reset();
                    GLEntry.SetCurrentKey("Document No.");
                    GLEntry.SetFilter("Document No.", InvoiceNoToReverse);
                    if GLEntry.FindSet() then
                        repeat
                            LastEntryNo := LastEntryNo + 1;
                            GLEntry.CalcFields("G/L Account Name");
                            CBRD.Init();
                            CBRD."Entry No." := LastEntryNo;
                            CBRD."Invoice No." := GLEntry."Document No.";
                            CBRD.Validate("Student No.", StudentNo);
                            CBRD."G/L Account No." := GLEntry."G/L Account No.";
                            CBRD."G/L Account Name" := GLEntry."G/L Account Name";
                            if GLEntry."Source Type" = GLEntry."Source Type"::Customer then begin
                                CBRD."Account Type" := CBRD."Account Type"::Customer;
                                CBRD.Validate("G/L Account No.", GLEntry."Source No.");
                            end
                            else
                                CBRD."Account Type" := CBRD."Account Type"::"G/L Account";

                            CBRD."Due Date" := CLE."Due Date";
                            CBRD.Validate("Fee Code", GLEntry."Fee Code");
                            CBRD."Invoice Amount" := GLEntry.Amount;

                            if (BilledWeeks <> 0) and (CBRD."Account Type" <> CBRD."Account Type"::Customer) then begin
                                CBRD."Amount to Reverse" := -1 * (GLEntry.Amount / BilledWeeks) * WeekstoReverse;
                                CBRD."Reversal Weeks" := WeekstoReverse;
                                BalanceAmount := BalanceAmount + (-1 * CBRD."Amount to Reverse");
                            end;

                            if (CBRD."FIU Surcharge") and (FIUBilledWeeks <> 0) and (CBRD."Account Type" <> CBRD."Account Type"::Customer) then begin
                                CBRD."Amount to Reverse" := -1 * (GLEntry.Amount / FIUBilledWeeks) * FIUWeekstoReverse;
                                CBRD."Reversal Weeks" := FIUWeekstoReverse;
                                BalanceAmount := BalanceAmount + (-1 * CBRD."Amount to Reverse");
                            end;

                            if (CBRD."Account Type" = CBRD."Account Type"::Customer) then begin
                                CBRD."Amount to Reverse" := BalanceAmount;
                                BalanceAmount := 0;
                            end;

                            CBRD."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                            CBRD."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                            CBRD."Financial Aid Approved" := GLEntry."Financial Aid Approved";

                            CBRD.Insert();
                            if CBRD."Account Type" = CBRD."Account Type"::"G/L Account" then begin
                                TotalInvoiceAmount := TotalInvoiceAmount + CBRD."Invoice Amount";
                                TotalReversalAmount := TotalReversalAmount + CBRD."Amount to Reverse";
                            end;
                        until GLEntry.Next() = 0;
                end;
            }

        }
    }

    var
        StudentNo: Code[20];
        StudentName: Text[100];
        WeekstoReverse: Integer;
        FIUWeekstoReverse: Integer;
        TotalInvoiceAmount: Decimal;
        TotalReversalAmount: Decimal;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        CBRD: Record "CLN Billing Reversal Detail";
    begin
        CBRD.Reset();
        CBRD.SetRange("Student No.", StudentNo);
        CBRD.SetRange("Posted No.", '');
        if CBRD.FindSet() then
            repeat
                CBRD.Delete();
            until CBRD.Next() = 0;
    end;

    procedure SetVariables(LStudentNo: Code[20]; LStudentName: Text[100]; LWeekstoReverse: Integer; LFIUWeekstoReverse: Integer)
    begin
        StudentNo := LStudentNo;
        "StudentName" := LStudentName;
        WeekstoReverse := LWeekstoReverse;
        FIUWeekstoReverse := LFIUWeekstoReverse;
    end;

    procedure InsertJournalLine(
        FeeSetup: Record "Fee Setup-CS";
        GJB: Record "Gen. Journal Batch";
        StudentMaster: Record "Student Master-CS";
        CBRD: Record "CLN Billing Reversal Detail";
        Var
            DocumentNo: Code[20]);
    var
        SAPFeeCode: Record "SAP Fee Code";
        GJT: Record "Gen. Journal Template";
        GJL: Record "Gen. Journal Line";
        GJLIns: Record "Gen. Journal Line";
        FeeComponent: Record "Fee Component Master-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LineNo: Integer;
        BillingType: Option " ","Clinical Billing","FIU Surchage";
    begin
        BillingType := BillingType::"Clinical Billing";

        GJT.Reset();
        if GJT.Get(FeeSetup."Journal Template Name") then;

        if DocumentNo = '' then begin
            GJL.Reset();
            GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
            GJL.SetRange("Journal Batch Name", GJB.Name);
            if GJL.FindLast() then
                DocumentNo := IncStr(GJL."Document No.")
            else
                DocumentNo := NoSeriesManagement.GetNextNo(GJB."No. Series", WorkDate(), false);
        end;

        GJL.Reset();
        GJL.SetCurrentKey("Line No.");
        GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
        GJL.SetRange("Journal Batch Name", GJB.Name);
        if GJL.FindLast() then
            LineNo := GJL."Line No.";

        LineNo := LineNo + 10000;

        GJLIns.Init();
        GJLIns."Journal Template Name" := GJB."Journal Template Name";
        GJLIns."Journal Batch Name" := GJB.Name;
        GJLIns."Line No." := LineNo;
        GJLIns."Posting No. Series" := GJB."Posting No. Series";
        GJLIns.Insert(true);

        GJLIns.VALIDATE("Document No.", DocumentNo);
        GJLIns.VALIDATE("Document Type", GJLIns."Document Type"::"Credit Memo");

        IF CBRD."Account Type" <> CBRD."Account Type"::Customer then begin
            GJLIns.VALIDATE("Account Type", GJLIns."Account Type"::"G/L Account");
            GJLIns.VALIDATE("Account No.", CBRD."G/L Account No.");
            GJLIns.VALIDATE(Description, CBRD."Fee Description");
        end
        else begin
            GJLIns.VALIDATE("Account Type", GJLIns."Account Type"::Customer);
            if UserId = 'X250\MICROSOFT' then
                GJLIns.VALIDATE("Account No.", StudentMaster."No.")
            else
                GJLIns.VALIDATE("Account No.", StudentMaster."Original Student No.");
            GJLIns.VALIDATE(Description, 'Semester Fee');
        end;

        GJLIns.VALIDATE("Posting Date", WorkDate());
        GJLIns.VALIDATE(Amount, -1 * CBRD."Amount to Reverse");
        GJLIns.VALIDATE("Shortcut Dimension 1 Code", CBRD."Global Dimension 1 Code");
        GJLIns.VALIDATE("Shortcut Dimension 2 Code", CBRD."Global Dimension 2 Code");

        GJLIns.VALIDATE(Course, StudentMaster."Course Code");
        GJLIns."Enrollment No." := StudentMaster."Enrollment No.";
        GJLIns.VALIDATE(Year, StudentMaster.Year);
        GJLIns.VALIDATE("Academic Year", CBRD."Academic Year");
        GJLIns.Validate(Semester, CBRD.Semester);
        GJLIns.Term := StudentMaster.Term;

        GJLIns."Fee Code" := CBRD."Fee Code";
        GJLIns."Source Code" := GJT."Source Code";

        IF GJLIns."Account Type" = GJLIns."Account Type"::Customer then begin
            GJLIns."Billing Weeks" := -1 * WeekstoReverse;
            GJLIns."FIU Billing Weeks" := -1 * FIUWeekstoReverse;
        end;

        GJLIns."Type of Billing" := BillingType;
        if CBRD."FIU Surcharge" then
            GJLIns."Type of Billing" := GJLIns."Type of Billing"::"FIU Surcharge";

        FeeComponent.Reset();
        if FeeComponent.Get(CBRD."Fee Code") then begin
            SAPFeeCode.Reset();
            SAPFeeCode.SetRange("SAP Code", FeeComponent."SAP Code");
            IF SAPFeeCode.FindFirst() then begin
                GJLIns."SAP Code" := SAPFeeCode."SAP Code";
                GJLIns."SAP G/L Account" := SAPFeeCode."SAP G/L Account";
                GJLIns."SAP Assignment Code" := SAPFeeCode."SAP Assignment Code";
                GJLIns."SAP Description" := SAPFeeCode."SAP Description";
                GJLIns."SAP Cost Centre" := SAPFeeCode."SAP Cost Centre";
                GJLIns."SAP Profit Centre" := SAPFeeCode."SAP Profit Centre";
                GJLIns."SAP Company Code" := SAPFeeCode."SAP Company Code";
                GJLIns."SAP Bus. Area" := SAPFeeCode."SAP Bus. Area";
                GJLIns."Fee Group" := SAPFeeCode."Fee Group";
            end;
        end;

        //GJLIns."Auto Generated" := True;
        GJLIns."Financial Aid Approved" := CBRD."Financial Aid Approved";
        GJLIns.Modify(true);
    end;
}
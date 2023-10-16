codeunit 50029 PostCustomisedFieldsInBaseTbl
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostGLAccOnBeforeInsertGLEntry', '', false, false)]
    procedure AssignValueToGLEntryTbl(GenJournalLine: Record "Gen. Journal Line"; Var GLEntry: Record "G/L Entry"; IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
        RecStud: Record "Student Master-CS";
    begin
        GLEntry.Semester := GenJournalLine.Semester;
        GLEntry."1098-T From" := GenJournalLine."1098-T From";
        GLEntry."Academic Year" := GenJournalLine."Academic Year";
        GLEntry."Admitted Year" := GenJournalLine."Admitted Year";
        GLEntry."Course Code" := GenJournalLine.Course;
        GLEntry."Enrollment No." := GenJournalLine."Enrollment No.";
        //01-03-2022
        GLEntry."Student ID" := GenJournalLine."Student ID";
        //01-03-2022
        GLEntry.Year := GenJournalLine.Year;
        GLEntry.Term := GenJournalLine.Term;
        GLEntry."Cheque Dates" := GenJournalLine."Cheque Dates";
        GLEntry."Cheque Nos." := GenJournalLine."Cheque Nos.";
        GLEntry."Withdrawal No." := GenJournalLine."Withdrawal No.";
        GLEntry."Credit Memo Type" := GenJournalLine."Credit Memo Type";
        GLEntry."Customer Bank Code" := GenJournalLine."Customer Bank Code";
        GLEntry."Customer Bank Branch Code" := GenJournalLine."Customer Bank Branch Code";
        GLEntry."Instrument Type" := GenJournalLine."Instrument Type";
        GLEntry."Instrument Date" := GenJournalLine."Instrument Date";
        GLEntry."Transaction Number" := GenJournalLine."Transaction Number";
        GLEntry.Posted := GenJournalLine.Posted;
        GLEntry."Currency Code" := GenJournalLine."Currency Code";
        GLEntry."Fee Description" := GenJournalLine."Fee Description";
        //GLEntry."Currency Exch. Rate" := (1/GenJournalLine."Currency Exch. Rate");  
        GLEntry."Currency Factor" := GenJournalLine."Currency Factor";
        GLEntry."Receipt No." := GenJournalLine."Receipt No.";
        GLEntry.Category := GenJournalLine.Category;
        GLEntry."Reversal New" := GenJournalLine."Reversal New";
        GLEntry."Applies To Rev. Doc. No." := GenJournalLine."Applies To Rev. Doc. No.";
        GLEntry."Show INR" := GenJournalLine."Show INR";
        GLEntry."Currency Code Receipt" := GenJournalLine."Currency Code Receipt";
        GLEntry."Amount Receipt" := GenJournalLine."Amount Receipt";
        GLEntry."Fee Code" := GenJournalLine."Fee Code";
        GLEntry."SAP Code" := GenJournalLine."SAP Code";
        GLEntry."SAP G/L Account" := GenJournalLine."SAP G/L Account";
        GLEntry."SAP Assignment Code" := GenJournalLine."SAP Assignment Code";
        GLEntry."SAP Description" := GenJournalLine."SAP Description";
        GLEntry."SAP Cost Centre" := GenJournalLine."SAP Cost Centre";
        GLEntry."SAP Profit Centre" := GenJournalLine."SAP Profit Centre";
        GLEntry."SAP Company Code" := GenJournalLine."SAP Company Code";
        GLEntry."SAP Bus. Area" := GenJournalLine."SAP Bus. Area";
        GLEntry."Fee Group" := GenJournalLine."Fee Group";
        SalesLine.RESET();
        SalesLine.SETRANGE("Document No.", GenJournalLine."Document No.");
        SalesLine.SETRANGE("No.", GLEntry."G/L Account No.");
        IF SalesLine.FINDFIRST() THEN
            GLEntry."ShortCut Dimension Code 3" := SalesLine."ShortCut Dimension Code 3";
        GLEntry."Synchronised with SFAS" := GenJournalLine."Synchronised with SFAS";
        GLEntry."ShortCut Dimension Code 3" := GenJournalLine."ShortCut Dimension Code 3";
        GLEntry."Payment By Financial Aid" := GenJournalLine."Payment By Financial Aid";
        GLEntry."Fund Type" := GenJournalLine."Fund Type";
        GLEntry."Roster Entry No." := GenJournalLine."Roster Entry No.";
        GLEntry."Financial Aid Approved" := GenJournalLine."Financial Aid Approved";
        GLEntry."Payment Plan Applied" := GenJournalLine."Payment Plan Applied";
        GLEntry."Payment Plan Instalment" := GenJournalLine."Payment Plan Instalment";
        GLEntry."Auto Generated" := GenJournalLine."Auto Generated";
        GLEntry."Deposit Type" := GenJournalLine."Deposit Type";
        GLEntry."Self Payment Applied" := GenJournalLine."Self Payment Applied";
        If GenJournalLine."Entry Date" <> 0D then
            GLEntry."Entry Date" := GenJournalLine."Entry Date"
        Else
            GLEntry."Entry Date" := Today();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    procedure AssignValueBankAccLedgerEntryTbl(Var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //Code added for Assing Value in Fields BankAccLedgEntry Table::CSPL-00136::05-05-2019: Start

        BankAccountLedgerEntry."Enrollment No." := GenJournalLine."Enrollment No.";
        BankAccountLedgerEntry.Term := GenJournalLine.Term;
        BankAccountLedgerEntry."1098-T From" := GenJournalLine."1098-T From";
        BankAccountLedgerEntry."Cheque Dates" := GenJournalLine."Cheque Dates";
        BankAccountLedgerEntry."Cheque Nos." := GenJournalLine."Cheque Nos.";
        BankAccountLedgerEntry.Narration := GenJournalLine.Narration;
        BankAccountLedgerEntry."UnRelazised Doc No." := GenJournalLine."UnRelazised Doc No.";
        BankAccountLedgerEntry."Transaction Number" := GenJournalLine."Transaction Number";
        BankAccountLedgerEntry."Reversal New" := GenJournalLine."Reversal New";
        BankAccountLedgerEntry."Applies To Rev. Doc. No." := GenJournalLine."Applies To Rev. Doc. No.";
        BankAccountLedgerEntry."Show INR" := GenJournalLine."Show INR";
        BankAccountLedgerEntry."Currency Code Receipt" := GenJournalLine."Currency Code Receipt";
        BankAccountLedgerEntry."Currency Code" := GenJournalLine."Currency Code";
        BankAccountLedgerEntry."Amount Receipt" := GenJournalLine."Amount Receipt";
        BankAccountLedgerEntry.Posted := GenJournalLine.Posted;
        BankAccountLedgerEntry."Receipt No." := GenJournalLine."Receipt No.";
        BankAccountLedgerEntry."Instrument Type" := GenJournalLine."Instrument Type";
        BankAccountLedgerEntry."Customer Bank Code" := GenJournalLine."Customer Bank Code";
        BankAccountLedgerEntry."Customer Bank Branch Code" := GenJournalLine."Customer Bank Branch Code";
        BankAccountLedgerEntry."SAP G/L Account" := GenJournalLine."SAP G/L Account";
        BankAccountLedgerEntry."SAP Profit Centre" := GenJournalLine."SAP Profit Centre";
        BankAccountLedgerEntry."SAP Company Code" := GenJournalLine."SAP Company Code";
        BankAccountLedgerEntry."SAP Bus. Area" := GenJournalLine."SAP Bus. Area";
        BankAccountLedgerEntry."Payment By Financial Aid" := GenJournalLine."Payment By Financial Aid";
        BankAccountLedgerEntry."Fund Type" := GenJournalLine."Fund Type";
        BankAccountLedgerEntry."Roster Entry No." := GenJournalLine."Roster Entry No.";
        BankAccountLedgerEntry."Financial Aid Approved" := GenJournalLine."Financial Aid Approved";
        BankAccountLedgerEntry."Payment Plan Applied" := GenJournalLine."Payment Plan Applied";
        BankAccountLedgerEntry."Payment Plan Instalment" := GenJournalLine."Payment Plan Instalment";
        BankAccountLedgerEntry."Auto Generated" := GenJournalLine."Auto Generated";
        BankAccountLedgerEntry."Deposit Type" := GenJournalLine."Deposit Type";
        BankAccountLedgerEntry."Self Payment Applied" := GenJournalLine."Self Payment Applied";
        BankAccountLedgerEntry."Waiver/Scholar/Grant Code" := GenJournalLine."Waiver/Scholar/Grant Code";
        BankAccountLedgerEntry."Waiver/Scholar/Grant Desc" := GenJournalLine."Waiver/Scholar/Grant Desc";
        BankAccountLedgerEntry."Withdrawal No." := GenJournalLine."Withdrawal No.";
        BankAccountLedgerEntry.Reason := GenJournalLine.Reason;
        BankAccountLedgerEntry."Item Code" := GenJournalLine."Item Code";
        BankAccountLedgerEntry.Paid := GenJournalLine.Paid;
        BankAccountLedgerEntry."Payment Status" := GenJournalLine."Payment Status";
        BankAccountLedgerEntry."Processed Date" := GenJournalLine."Processed Date";
        BankAccountLedgerEntry."Student Application" := GenJournalLine."Student Application";
        BankAccountLedgerEntry."Transaction ID" := GenJournalLine."Transaction ID";
        BankAccountLedgerEntry."Transaction Status" := GenJournalLine."Transaction Status";
        BankAccountLedgerEntry."Transaction Sub-Type" := GenJournalLine."Transaction Sub-Type";
        BankAccountLedgerEntry."Transaction Types" := GenJournalLine."Transaction Types";
        BankAccountLedgerEntry."18 Digit Transaction ID" := GenJournalLine."18 Digit Transaction ID";
        //Code added for Assing Value in Fields BankAccLedgEntry Table::CSPL-00136::05-05-2019: End
        BankAccountLedgerEntry.Comment := GenJournalLine.Comment;//CSPL-00307
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure AssignValueCustLedgerEntryTbl(Var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Enrollment No." := GenJournalLine."Enrollment No.";
        CustLedgerEntry."1098-T From" := GenJournalLine."1098-T From";
        CustLedgerEntry."Cheque Dates" := GenJournalLine."Cheque Dates";
        CustLedgerEntry."Cheque Nos." := GenJournalLine."Cheque Nos.";
        CustLedgerEntry."Instrument Type" := GenJournalLine."Instrument Type";
        CustLedgerEntry."Customer Bank Code" := GenJournalLine."Customer Bank Code";
        CustLedgerEntry."Customer Bank Branch Code" := GenJournalLine."Customer Bank Branch Code";
        CustLedgerEntry.Narration := GenJournalLine.Narration;
        CustLedgerEntry."UnRelazised Doc No." := GenJournalLine."UnRelazised Doc No.";
        CustLedgerEntry."Transaction Number" := GenJournalLine."Transaction Number";
        CustLedgerEntry.Posted := GenJournalLine.Posted;
        CustLedgerEntry."Receipt No." := GenJournalLine."Receipt No.";
        CustLedgerEntry.Category := GenJournalLine.Category;
        CustLedgerEntry."Reversal New" := GenJournalLine."Reversal New";
        CustLedgerEntry."Applies To Rev. Doc. No." := GenJournalLine."Applies To Rev. Doc. No.";
        CustLedgerEntry."Show INR" := GenJournalLine."Show INR";
        CustLedgerEntry."Course Code" := GenJournalLine.Course;
        CustLedgerEntry."Academic Year" := GenJournalLine."Academic Year";
        CustLedgerEntry."Admitted Year" := GenJournalLine."Admitted Year";
        CustLedgerEntry."Fee Code" := GenJournalLine."Fee Code";
        CustLedgerEntry.Semester := GenJournalLine.Semester;
        CustLedgerEntry.Category := GenJournalLine.Category;
        CustLedgerEntry."Fee Description" := GenJournalLine."Fee Description";
        CustLedgerEntry."Late Fee Amount %" := GenJournalLine."Late Fee %";
        CustLedgerEntry.Year := GenJournalLine.Year;
        CustLedgerEntry.Term := GenJournalLine.Term;
        CustLedgerEntry."Payment By Financial Aid" := GenJournalLine."Payment By Financial Aid";
        CustLedgerEntry."Fund Type" := GenJournalLine."Fund Type";
        CustLedgerEntry."Roster Entry No." := GenJournalLine."Roster Entry No.";
        CustLedgerEntry."Financial Aid Approved" := GenJournalLine."Financial Aid Approved";
        CustLedgerEntry."Payment Plan Applied" := GenJournalLine."Payment Plan Applied";
        CustLedgerEntry."Payment Plan Instalment" := GenJournalLine."Payment Plan Instalment";
        CustLedgerEntry."Auto Generated" := GenJournalLine."Auto Generated";
        CustLedgerEntry."Deposit Type" := GenJournalLine."Deposit Type";
        CustLedgerEntry."Self Payment Applied" := GenJournalLine."Self Payment Applied";
        CustLedgerEntry."Waiver/Scholar/Grant Code" := GenJournalLine."Waiver/Scholar/Grant Code";
        CustLedgerEntry."Waiver/Scholar/Grant Desc" := GenJournalLine."Waiver/Scholar/Grant Desc";
        CustLedgerEntry."Withdrawal No." := GenJournalLine."Withdrawal No.";
        CustLedgerEntry.Reason := GenJournalLine.Reason;
        CustLedgerEntry."Item Code" := GenJournalLine."Item Code";
        CustLedgerEntry.Paid := GenJournalLine.Paid;
        CustLedgerEntry."Payment Status" := GenJournalLine."Payment Status";
        CustLedgerEntry."Processed Date" := GenJournalLine."Processed Date";
        CustLedgerEntry."Student Application" := GenJournalLine."Student Application";
        CustLedgerEntry."Transaction ID" := GenJournalLine."Transaction ID";
        CustLedgerEntry."Transaction Status" := GenJournalLine."Transaction Status";
        CustLedgerEntry."Transaction Sub-Type" := GenJournalLine."Transaction Sub-Type";
        CustLedgerEntry."Transaction Types" := GenJournalLine."Transaction Types";
        CustLedgerEntry."18 Digit Transaction ID" := GenJournalLine."18 Digit Transaction ID";
        CustLedgerEntry.Comment := GenJournalLine.Comment;//CSPL-00307
        IF GenJournalLine."Entry Date" <> 0D then
            CustLedgerEntry."Entry Date" := GenJournalLine."Entry Date"
        Else
            CustLedgerEntry."Entry Date" := Today();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    procedure AssignValueDtldCustLedgerEntryTbl(Var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //Code added for Assing Value in Fields DtldCustLedgEntry Table::CSPL-00136::05-05-2019: Start
        DtldCustLedgEntry."Enrollment No." := GenJournalLine."Enrollment No.";
        DtldCustLedgEntry.Semester := GenJournalLine.Semester;
        DtldCustLedgEntry."1098-T From" := GenJournalLine."1098-T From";
        DtldCustLedgEntry."Academic Year" := GenJournalLine."Academic Year";
        DtldCustLedgEntry."Admitted Year" := GenJournalLine."Admitted Year";
        DtldCustLedgEntry."Course Code" := GenJournalLine.Course;
        DtldCustLedgEntry.Year := GenJournalLine.Year;
        DtldCustLedgEntry.Term := GenJournalLine.Term;
        DtldCustLedgEntry."Cheque Dates" := GenJournalLine."Cheque Dates";
        DtldCustLedgEntry."Cheque Nos." := GenJournalLine."Cheque Nos.";
        DtldCustLedgEntry."Instrument Type" := GenJournalLine."Instrument Type";
        DtldCustLedgEntry."Customer Bank Code" := GenJournalLine."Customer Bank Code";
        DtldCustLedgEntry."Customer Bank Branch Code" := GenJournalLine."Customer Bank Branch Code";
        DtldCustLedgEntry.Narration := GenJournalLine.Narration;
        DtldCustLedgEntry."UnRelazised Doc No." := GenJournalLine."UnRelazised Doc No.";
        DtldCustLedgEntry."Transaction Number" := GenJournalLine."Transaction Number";
        DtldCustLedgEntry.Posted := GenJournalLine.Posted;
        DtldCustLedgEntry."Receipt No." := GenJournalLine."Receipt No.";
        DtldCustLedgEntry."Reversal New" := GenJournalLine."Reversal New";
        DtldCustLedgEntry."Applies To Rev. Doc. No." := GenJournalLine."Applies To Rev. Doc. No.";
        DtldCustLedgEntry."Show INR" := GenJournalLine."Show INR";
        DtldCustLedgEntry."Late Fee Amount %" := GenJournalLine."Late Fee %";
        DtldCustLedgEntry."Payment By Financial Aid" := GenJournalLine."Payment By Financial Aid";
        DtldCustLedgEntry."Fund Type" := GenJournalLine."Fund Type";
        DtldCustLedgEntry."Roster Entry No." := GenJournalLine."Roster Entry No.";
        DtldCustLedgEntry."Financial Aid Approved" := GenJournalLine."Financial Aid Approved";
        DtldCustLedgEntry."Payment Plan Applied" := GenJournalLine."Payment Plan Applied";
        DtldCustLedgEntry."Payment Plan Instalment" := GenJournalLine."Payment Plan Instalment";
        DtldCustLedgEntry."Auto Generated" := GenJournalLine."Auto Generated";
        DtldCustLedgEntry."Deposit Type" := GenJournalLine."Deposit Type";
        DtldCustLedgEntry."Self Payment Applied" := GenJournalLine."Self Payment Applied";
        DtldCustLedgEntry."Waiver/Scholar/Grant Code" := GenJournalLine."Waiver/Scholar/Grant Code";
        DtldCustLedgEntry."Waiver/Scholar/Grant Desc" := GenJournalLine."Waiver/Scholar/Grant Desc";
        DtldCustLedgEntry."Withdrawal No." := GenJournalLine."Withdrawal No.";
        DtldCustLedgEntry.Reason := GenJournalLine.Reason;
        DtldCustLedgEntry."Item Code" := GenJournalLine."Item Code";
        DtldCustLedgEntry.Paid := GenJournalLine.Paid;
        DtldCustLedgEntry."Payment Status" := GenJournalLine."Payment Status";
        DtldCustLedgEntry."Processed Date" := GenJournalLine."Processed Date";
        DtldCustLedgEntry."Student Application" := GenJournalLine."Student Application";
        DtldCustLedgEntry."Transaction ID" := GenJournalLine."Transaction ID";
        DtldCustLedgEntry."Transaction Status" := GenJournalLine."Transaction Status";
        DtldCustLedgEntry."Transaction Sub-Type" := GenJournalLine."Transaction Sub-Type";
        DtldCustLedgEntry."Transaction Types" := GenJournalLine."Transaction Types";
        DtldCustLedgEntry."18 Digit Transaction ID" := GenJournalLine."18 Digit Transaction ID";
        //Code added for Assing Value in Fields DtldCustLedgEntry Table::CSPL-00136::05-05-2019: Start 
        DtldCustLedgEntry.Comment := GenJournalLine.Comment;//CSPL-00307    
        If GenJournalLine."Entry Date" <> 0D then
            DtldCustLedgEntry."Entry Date" := GenJournalLine."Entry Date"
        Else
            DtldCustLedgEntry."Entry Date" := Today();
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostInvPostBuffer', '', false, false)]
    procedure AssignValueGenJnlLine(GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    begin
        //Code added for Assing Value in Fields GenJnlLine Table::CSPL-00136::05-05-2019: Start
        GenJnlLine."Enrollment No." := SalesHeader."Enrollment No.";
        GenJnlLine."Cheque Dates" := SalesHeader."Cheque Date";
        GenJnlLine."Cheque Nos." := SalesHeader."Cheque No.";
        GenJnlLine."Withdrawal No." := SalesHeader."Withdrawal No.";
        GenJnlLine."Credit Memo Type" := SalesHeader."Credit Memo Type";
        GenJnlLine.Course := SalesHeader.Course;
        GenJnlLine."Academic Year" := SalesHeader."Academic Year";
        GenJnlLine.Semester := SalesHeader.Semester;
        //Code added for Assing Value in Fields GenJnlLine Table::CSPL-00136::05-05-2019: End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', false, false)]
    procedure AssignValueGenJnlLineOnPostCustEntry(GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    begin
        //Code added for Assing Value in Fields GenJnlLine Table::CSPL-00136::05-05-2019: Start
        GenJnlLine."Enrollment No." := SalesHeader."Enrollment No.";
        GenJnlLine."Cheque Dates" := SalesHeader."Cheque Date";
        GenJnlLine."Cheque Nos." := SalesHeader."Cheque No.";
        GenJnlLine."Withdrawal No." := SalesHeader."Withdrawal No.";
        GenJnlLine."Credit Memo Type" := SalesHeader."Credit Memo Type";
        //Code added for Assing Value in Fields GenJnlLine Table::CSPL-00136::05-05-2019: End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostBalancingEntry', '', false, false)]
    procedure AssignValueGenJnlLineOnBeforePostBalancingEntry(GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    begin
        //Code added for Assing Value in Fields GenJnlLine Table::CSPL-00136::05-05-2019: Start
        GenJnlLine."Enrollment No." := SalesHeader."Enrollment No.";
        GenJnlLine."Cheque Dates" := SalesHeader."Cheque Date";
        GenJnlLine."Cheque Nos." := SalesHeader."Cheque No.";
        GenJnlLine."Withdrawal No." := SalesHeader."Withdrawal No.";
        GenJnlLine."Credit Memo Type" := SalesHeader."Credit Memo Type";
        //Code added for Assing Value in Fields GenJnlLine Table::CSPL-00136::05-05-2019: End
    end;


    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", 'OnBeforeCustLedgEntryModify', '', false, false)]
    procedure AssignValueCLEandDCLE(CustLedgEntry: Record "Cust. Ledger Entry"; Rec: Record "Cust. Ledger Entry")
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.");
        DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
        IF DtldCustLedgEntry.FINDSET()THEN
            REPEAT
                DtldCustLedgEntry.Apply := Rec.Apply;
                IF Rec.Apply = TRUE THEN
                    DtldCustLedgEntry."APPLY USER ID" := FORMAT(UserId())
                ELSE
                    DtldCustLedgEntry."APPLY USER ID" := '';
                DtldCustLedgEntry.MODIFY(TRUE);
            UNTIL DtldCustLedgEntry.NEXT() = 0;

        CustLedgEntry.Apply := Rec.Apply;

        IF Rec.Apply = TRUE THEN
            CustLedgEntry."APPLY USER ID" := FORMAT(UserId())
        ELSE
            CustLedgEntry."APPLY USER ID" := '';
    end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine', '', false, false)]
    procedure AssignValueWhseReceiptLine(WarehouseReceiptLine: Record "Warehouse Receipt Line"; PurchaseLine: Record "Purchase Line")
    begin
        WarehouseReceiptLine."Requisition No." := PurchaseLine."Indent No";
        WarehouseReceiptLine."Requisition Line No." := PurchaseLine."Indent Line No";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnAfterPostedWhseRcptLineInsert', '', false, false)]
    procedure UpdateIssuedQtyinRequisitionLine(PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        RequisitionLineCS: Record "Requisition Line-CS";
    begin
        RequisitionLineCS.Reset();
        IF RequisitionLineCS.GET(PostedWhseReceiptLine."Requisition No.", PostedWhseReceiptLine."Requisition Line No.") THEN BEGIN
            RequisitionLineCS."Issued Qty" := PostedWhseReceiptLine.Quantity;
            RequisitionLineCS.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeStartOrContinuePosting', '', true, true)]
    /// <summary> 
    /// Description for BeforePostValidation.
    /// </summary>
    /// <param name="GenJnlLine">Parameter of type Record "Gen. Journal Line".</param>
    local procedure BeforePostValidation(Var GenJnlLine: Record "Gen. Journal Line");
    var
        FeeSetupRec: Record "Fee Setup-CS";
        RecGenJnlLine: Record "Gen. Journal Line";
        RecGenJnlLine1: Record "Gen. Journal Line";
        FeeComponent: Record "Fee Component Master-CS";
        StudentMAster_lRec: Record "Student Master-CS";

    begin
        If GenJnlLine."Document Type" In [GenJnlLine."Document Type"::"Finance Charge Memo", GenJnlLine."Document Type"::Reminder] then
            Error('Please do not select Document Type as a %1 in Document No. %2 and Line No. %3', GenJnlLine."Document Type", GenJnlLine."Document No.", GenJnlLine."Line No.");

        If GenJnlLine."Fee Code" In ['SCHLSP-AICASA', 'SCHLSP-AUA', 'WAIV-AICASA', 'WAIV-AUA'] then     //26-08-2021
            GenJnlLine.TestField("Waiver/Scholar/Grant Code");

        IF GenJnlLine."Enrollment No." <> '' then begin         //01-09-2021
            StudentMAster_lRec.Reset();
            StudentMAster_lRec.SetRange("Enrollment No.", GenJnlLine."Enrollment No.");
            IF StudentMAster_lRec.FindFirst() then
                IF StudentMAster_lRec."Global Dimension 1 Code" <> GenJnlLine."Shortcut Dimension 1 Code" then
                    Error('Institute code must be equal to %1', StudentMAster_lRec."Global Dimension 1 Code");
        end;

        If (GenJnlLine."Journal Batch Name" <> 'STUDENTADJ') and (not (GenJnlLine."Source Code" IN ['ITEMJNL', 'INVTPCOST', 'RECLASSJNL', 'REVALJNL', 'PURCHASES', 'PURCHJNL'])) then     //07-07-2021
            GenJnlLine.TestField("Document Type");

        If (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) and (GenJnlLine."Account No." <> '') then begin
            GenJnlLine.TestField("Enrollment No.");
            StudentMAster_lRec.Reset();
            StudentMAster_lRec.SetRange("Original Student No.", GenJnlLine."Account No.");
            StudentMAster_lRec.SetFilter("Enrollment No.", GenJnlLine."Enrollment No.");
            StudentMAster_lRec.FindFirst();
        end;

        If (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer) and (GenJnlLine."Bal. Account No." <> '') then begin
            GenJnlLine.TestField("Enrollment No.");
            StudentMAster_lRec.Reset();
            StudentMAster_lRec.SetRange("Original Student No.", GenJnlLine."Bal. Account No.");
            StudentMAster_lRec.SetFilter("Enrollment No.", GenJnlLine."Enrollment No.");
            StudentMAster_lRec.FindFirst();
        end;




        RecGenJnlLine.Reset();
        RecGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        RecGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        RecGenJnlLine.SetRange("Pre Document No.", GenJnlLine."Pre Document No.");
        RecGenJnlLine.SetRange("Account Type", RecGenJnlLine."Account Type"::Customer);
        IF RecGenJnlLine.FindFirst() then begin
            RecGenJnlLine1.Reset();
            RecGenJnlLine1.SetRange("Journal Template Name", RecGenJnlLine."Journal Template Name");
            RecGenJnlLine1.SetRange("Journal Batch Name", RecGenJnlLine."Journal Batch Name");
            RecGenJnlLine1.SetRange("Pre Document No.", RecGenJnlLine."Pre Document No.");
            RecGenJnlLine1.SetRange("Account Type", RecGenJnlLine1."Account Type"::Customer);
            RecGenJnlLine1.SetFilter("Account No.", '<>%1', RecGenJnlLine."Account No.");
            IF RecGenJnlLine1.FindFirst() then
                if RecGenJnlLine1."Journal Batch Name" <> 'STUDENTADJ' then
                    Error('Multiple Customers cannot be used in same Document No. %1', GenJnlLine."Document No.");
        End;

        If (GenJnlLine."Account Type" <> GenJnlLine."Account Type"::Customer) AND (GenJnlLine."Account No." <> '') then begin
            If GenJnlLine."Enrollment No." = '' then begin
                RecGenJnlLine.Reset();
                RecGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                RecGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                RecGenJnlLine.SetRange("Pre Document No.", GenJnlLine."Pre Document No.");
                RecGenJnlLine.SetFilter("Enrollment No.", '<>%1', '');
                IF RecGenJnlLine.FindFirst() then begin
                    GenJnlLine."Enrollment No." := RecGenJnlLine."Enrollment No.";
                    GenJnlLine.Semester := RecGenJnlLine.Semester;
                    GenJnlLine."Academic Year" := RecGenJnlLine."Academic Year";
                    GenJnlLine."Admitted Year" := RecGenJnlLine."Admitted Year";
                    GenJnlLine."Course" := RecGenJnlLine.Course;
                    GenJnlLine.Year := RecGenJnlLine.Year;
                    GenJnlLine.Term := RecGenJnlLine.Term;
                    GenJnlLine.Modify();
                end;
            end;
        end;

        If (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) AND (GenJnlLine."Account No." <> '') then begin
            RecGenJnlLine.Reset();
            RecGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
            RecGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
            RecGenJnlLine.SetRange("Pre Document No.", GenJnlLine."Pre Document No.");
            RecGenJnlLine.SetFilter("Line No.", '<>%1', GenJnlLine."Line No.");
            RecGenJnlLine.SetRange("Enrollment No.", '');
            IF RecGenJnlLine.FindSet() then begin
                Repeat
                    RecGenJnlLine."Enrollment No." := GenJnlLine."Enrollment No.";
                    RecGenJnlLine.Semester := GenJnlLine.Semester;
                    RecGenJnlLine."Academic Year" := GenJnlLine."Academic Year";
                    RecGenJnlLine."Admitted Year" := GenJnlLine."Admitted Year";
                    RecGenJnlLine.Course := GenJnlLine.Course;
                    RecGenJnlLine.Year := GenJnlLine.Year;
                    RecGenJnlLine.Term := GenJnlLine.Term;
                    RecGenJnlLine.Modify();
                until RecGenJnlLine.Next() = 0;
            end;
        end;
        If (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) AND (GenJnlLine."Account No." <> '') then begin
            RecGenJnlLine.Reset();
            RecGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
            RecGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
            RecGenJnlLine.SetRange("Pre Document No.", GenJnlLine."Pre Document No.");
            RecGenJnlLine.SetRange("Enrollment No.", '');
            if RecGenJnlLine.FindFirst() then
                Error('Enrollment No. must not be blank for Document No. %1', RecGenJnlLine."Document No.");
        END;

        If (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer) AND (GenJnlLine."Bal. Account No." <> '') then begin
            RecGenJnlLine.Reset();
            RecGenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
            RecGenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
            RecGenJnlLine.SetRange("Pre Document No.", GenJnlLine."Pre Document No.");
            RecGenJnlLine.SetRange("Enrollment No.", '');
            if RecGenJnlLine.FindFirst() then
                Error('Enrollment No. must not be blank for Document No. %1', RecGenJnlLine."Document No.");
        END;

        If GenJnlLine."Fee Code" <> '' then begin
            FeeComponent.Reset();
            FeeComponent.SetRange(Code, GenJnlLine."Fee Code");
            FeeComponent.SetFilter("Global Dimension 2 Code", '<>%1', '');
            if FeeComponent.FindFirst() then begin
                if GenJnlLine."Shortcut Dimension 2 Code" = '' then
                    Error('Department Code must not be blank for Document No. %1', GenJnlLine."Document No.");
            end;

        END;


        FeeSetupRec.Reset();
        FeeSetupRec.SetRange("Global Dimension 1 Code", GenJnlLine."Shortcut Dimension 1 Code");
        if FeeSetupRec.FindFirst() then begin
            if (GenJnlLine."Journal Batch Name" = FeeSetupRec."ScholarShip Batch Name") or (GenJnlLine."Journal Batch Name" = FeeSetupRec."Withdrawal Batch Name") then
                if GenJnlLine."Waiver/Scholar/Grant Code" = '' then
                    Error('Waiver/Scholar/Grant Code must have value');
        end;

        If not (GenJnlLine."Source Code" IN ['ITEMJNL', 'INVTPCOST', 'RECLASSJNL', 'REVALJNL', 'PURCHASES', 'PURCHJNL']) then
            If GenJnlLine."SAP Code" = '' Then begin
                If (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account") AND (GenJnlLine."Account No." <> '') then
                    Error('Fee Code Should not be Blank for Line No %1.', GenJnlLine."Line No.");

                If (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"G/L Account") AND (GenJnlLine."Bal. Account No." <> '') then
                    Error('Fee Code Should not be Blank for Line No %1.', GenJnlLine."Line No.");
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure PaymentJournalToGL(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        GLEntry.Semester := GenJournalLine.Semester;
        GLEntry."Academic Year" := GenJournalLine."Academic Year";
        GLEntry."Admitted Year" := GenJournalLine."Admitted Year";
        GLEntry."Course Code" := GenJournalLine.Course;
        GLEntry."Enrollment No." := GenJournalLine."Enrollment No.";
        GLEntry."Student ID" := GenJournalLine."Student ID";
        GLEntry.Year := GenJournalLine.Year;
        GLEntry.Term := GenJournalLine.Term;
        GLEntry."1098-T From" := GenJournalLine."1098-T From";
        GLEntry."Fee Code" := GenJournalLine."Fee Code";
        GLEntry."SAP Code" := GenJournalLine."SAP Code";
        GLEntry."SAP G/L Account" := GenJournalLine."SAP G/L Account";
        GLEntry."SAP Assignment Code" := GenJournalLine."SAP Assignment Code";
        GLEntry."SAP Description" := GenJournalLine."SAP Description";
        GLEntry."SAP Cost Centre" := GenJournalLine."SAP Cost Centre";
        GLEntry."SAP Profit Centre" := GenJournalLine."SAP Profit Centre";
        GLEntry."SAP Company Code" := GenJournalLine."SAP Company Code";
        GLEntry."SAP Bus. Area" := GenJournalLine."SAP Bus. Area";
        GLEntry."Fee Group" := GenJournalLine."Fee Group";
        GLEntry."Payment By Financial Aid" := GenJournalLine."Payment By Financial Aid";
        GLEntry."Fund Type" := GenJournalLine."Fund Type";
        GLEntry."Roster Entry No." := GenJournalLine."Roster Entry No.";
        GLEntry."Financial Aid Approved" := GenJournalLine."Financial Aid Approved";
        GLEntry."Payment Plan Applied" := GenJournalLine."Payment Plan Applied";
        GLEntry."Payment Plan Instalment" := GenJournalLine."Payment Plan Instalment";
        GLEntry."Auto Generated" := GenJournalLine."Auto Generated";
        GLEntry."Deposit Type" := GenJournalLine."Deposit Type";
        GLEntry."Self Payment Applied" := GenJournalLine."Self Payment Applied";
        GLEntry."Waiver/Scholar/Grant Code" := GenJournalLine."Waiver/Scholar/Grant Code";
        GLEntry."Waiver/Scholar/Grant Desc" := GenJournalLine."Waiver/Scholar/Grant Desc";
        GLEntry."Withdrawal No." := GenJournalLine."Withdrawal No.";
        GLEntry.Reason := GenJournalLine.Reason;
        GLEntry."Fee Description" := GenJournalLine."Fee Description";
        GLEntry."Cheque Nos." := GenJournalLine."Cheque Nos.";
        GLEntry."Cheque Dates" := GenJournalLine."Cheque Dates";
        GLEntry.Comment := GenJournalLine.Comment;//CSPL-00307
        IF GenJournalLine."Entry Date" <> 0D then
            GLEntry."Entry Date" := GenJournalLine."Entry Date"
        Else
            GLEntry."Entry Date" := Today();


    end;

    [EventSubscriber(ObjectType::table, 225, 'OnAfterValidateEvent', 'County', false, false)]
    procedure CountyOnValidate(VAR Rec: Record "Post Code"; VAR xRec: Record "Post Code"; CurrFieldNo: Integer)
    var
        State2: Record "State SLcM CS";
    begin
        if strlen(Rec.County) > 20 then
            Error('Maximum length allowed is 20 characters for State Code.');
        State2.GET(Rec.County);
        Rec."State Code" := Rec.county;
        Rec."State Description 3" := State2.Description;
    end;

    [EventSubscriber(ObjectType::table, 91, 'OnAfterValidateEvent', 'Allow Posting From', false, false)]
    local procedure AllPostFromOnValidate(VAR Rec: Record "User Setup"; VAR xRec: Record "User Setup"; CurrFieldNo: Integer)
    var
        DateToChk: Date;
    begin
        DateToChk := DMY2Date(20, 03, 2021);
        if Rec."Allow Posting From" <> 0D then
            if Rec."Allow Posting From" < DateToChk then
                Error('Date before 03-20-2021 is not allowed to enter in the field "Allow Posting From"');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeRun', '', False, False)]
    Local PRocedure FinalQuotationCheck(var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.TestField("Final Quotation");
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Quote to Order", 'OnAfterInsertAllPurchOrderLines', '', False, false)]
    local procedure PurchOrderNoUpdate(var PurchOrderLine: Record "Purchase Line")
    var
        RequisitionLine: Record "Requisition Line_";
    begin
        RequisitionLine.Reset();
        RequisitionLine.Setrange("Document No.", PurchOrderLine."Requisition No.");
        RequisitionLine.SetRange("Line No.", PurchOrderLine."Requisition Line No.");
        If RequisitionLine.FindFirst() then begin
            RequisitionLine."PO No." := PurchOrderLine."Document No.";
            RequisitionLine.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Quote to Order", 'OnAfterInsertPurchOrderLine', '', False, false)]
    local procedure PurchaseOrderBudgetCodeUpdate(var PurchaseQuoteLine: Record "Purchase Line"; var PurchaseOrderLine: Record "Purchase Line")
    begin
        PurchaseOrderLine."Budget Code" := PurchaseQuoteLine."Budget Code";
        PurchaseOrderLine."Requisition No." := PurchaseQuoteLine."Requisition No.";
        PurchaseOrderLine."Requisition Line No." := PurchaseQuoteLine."Requisition Line No.";
    end;

    [EventSubscriber(ObjectType::Table, 121, 'OnBeforeInsertInvLineFromRcptLine', '', False, false)]
    Local procedure PurchaseInvLneBudgetCodeUpdate(var PurchLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        PurchLine."Budget Code" := PurchRcptLine."Budget Code";
        PurchLine."Requisition No." := PurchRcptLine."Requisition No.";
        PurchLine."Requisition Line No." := PurchRcptLine."Requisition Line No.";
    end;


    //CSPL-00307---Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    begin
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            HideDialog := true;

            if not ConfirmPost(PurchaseHeader, DefaultOption) then begin
                IsHandled := true;
                exit;
            end;
        end;
    End;

    local procedure ConfirmPost(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer): Boolean
    var
        Selection: Integer;
        CustomText: Label '&Receive';
    begin

        PurchaseHeader.TestField("Requisition Type");//Mandatory
        Selection := StrMenu(CustomText, 1);
        if Selection = 0 then
            exit(false);
        PurchaseHeader.Receive := true;
        PurchaseHeader.Invoice := false;
        DefaultOption := 1;
        PurchaseHeader."Print Posted Documents" := false;
        exit(true);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Post', false, false)]
    local procedure Post(var Rec: Record "Purchase Header")
    begin
        IF Rec."Document Type" = Rec."Document Type"::Order then begin
            Rec.Receive := true;
            Rec.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure OnBeforeSendApprovalRequest(var Rec: Record "Purchase Header")
    begin
        Rec.Testfield("Requisition Type"); //Mandatory
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforePrintCheck', '', false, false)]
    // local procedure OnBeforePrintCheck(var GenJournalLine: Record "Gen. Journal Line"; var IsPrinted: Boolean)
    // begin
    //     GenJournalLine.TestField(Comment);
    //     Report.RunModal(50255, true, false, GenJournalLine);//Custom Report in Replacement of Base Report 1401 Check
    //     IsPrinted := true;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnAfterBankAccLedgEntryInsert', '', false, false)]
    local procedure OnPostBankAccOnAfterBankAccLedgEntryInsert(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account")
    var
        CheckLedgEntry: Record "Check Ledger Entry";
        CheckLedgEntry2: Record "Check Ledger Entry";
    begin
        IF GenJournalLine."Bank Payment Type" = GenJournalLine."Bank Payment Type"::"Computer Check" then begin
            GenJournalLine.TestField("Check Printed", true);
            CheckLedgEntry.LockTable;
            CheckLedgEntry.Reset;
            CheckLedgEntry.SetCurrentKey("Bank Account No.", "Entry Status", "Check No.");
            CheckLedgEntry.SetRange("Bank Account No.", GenJournalLine."Account No.");
            CheckLedgEntry.SetRange("Entry Status", CheckLedgEntry."Entry Status"::Printed);
            CheckLedgEntry.SetRange("Check No.", GenJournalLine."Cheque Nos.");
            if CheckLedgEntry.FindSet() then
                repeat
                    CheckLedgEntry2 := CheckLedgEntry;
                    CheckLedgEntry2."Entry Status" := CheckLedgEntry2."Entry Status"::Posted;
                    CheckLedgEntry2."Bank Account Ledger Entry No." := BankAccountLedgerEntry."Entry No.";
                    CheckLedgEntry2.Modify();
                until CheckLedgEntry.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCheckLedgEntry', '', false, false)]
    local procedure OnAfterInitCheckLedgEntry(var CheckLedgerEntry: Record "Check Ledger Entry"; BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        CheckLedgerEntry."Check No." := BankAccountLedgerEntry."Cheque Nos.";
        CheckLedgerEntry."Document No." := BankAccountLedgerEntry."Document No.";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Bank Account Card", 'OnBeforeValidateEvent', 'Last Check No.', False, False)]
    local procedure LastCheckNo(var Rec: Record "Bank Account")
    var
        CheckLedgerEntry: Record "Check Ledger Entry";
    begin
        CheckLedgerEntry.Reset();
        CheckLedgerEntry.SetRange("Bank Account No.", Rec."No.");
        CheckLedgerEntry.SetRange("Check No.", Rec."Last Check No.");
        CheckLedgerEntry.SetFilter("Entry Status", '<>%1', CheckLedgerEntry."Entry Status"::Voided);
        IF CheckLedgerEntry.FindFirst() then
            Error('You Can Not Change Last Check No. Check Ledger Entry already Exist');//Lucky - 09-08-2022
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure AssignValueToVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry.Comment := GenJournalLine.Comment;//CSPL-00307
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure AssignValueToDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldVendLedgEntry.Comment := GenJournalLine.Comment;//CSPL-00307
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEvent(var Rec: Record "Document Attachment"; RunTrigger: Boolean)
    begin
        Rec."Document Flow Purchase" := true;
        Rec.Modify();
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnAfterRun', '', false, false)]
    // local procedure OnAfterRun(var PurchaseHeader: Record "Purchase Header"; PurchOrderHeader: Record "Purchase Header")
    // Var
    //     Vendor: Record Vendor;
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     // SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;
    // // WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    // begin
    //     SMTPMailSetup.GET;

    //     Vendor.Get(PurchaseHeader."Buy-from Vendor No.");
    //     // Vendor.TESTFIELD("E-Mail");
    //     // Recipient := Vendor."E-Mail";
    //     Recipient := 'raja.biswas@corporateserve.com;lucky.kumar@corporateserve.com';
    //     CLEAR(SMTPMail);
    //     Subject := 'Quotation No. ' + PurchaseHeader."No." + ' finalised';

    //     SMTPMail.Create(Recipient, Subject, '', true);
    //     Smtpmail.AppendtoBody('Dear ' + Vendor.Name + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('Your Quotation No ' + PurchaseHeader."No." + ' has been finalised<br/>');
    //     SMTPMail.AppendtoBody('<br/><br/>[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].<br/><br/>');
    //     // SMTPMail.AppendtoBody('Regards,<br/>');
    //     // SMTPMail.AppendtoBody('SLCM Department');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    // local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    // var
    //     Vendor: Record Vendor;
    //     PurchaseHeader: Record "Purchase Header";
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     // SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;

    // // WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    // begin
    //     IF (ApprovalEntry."Table ID" = 38) AND (ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::Order) AND (ApprovalEntry.Status = ApprovalEntry.Status::Approved) then begin
    //         PurchaseHeader.Reset();
    //         IF PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, ApprovalEntry."Document No.") Then begin
    //             SMTPMailSetup.GET;
    //             Vendor.Get(PurchaseHeader."Buy-from Vendor No.");
    //             // Vendor.TESTFIELD("E-Mail");
    //             // Recipient := Vendor."E-Mail";
    //             Recipient := 'raja.biswas@corporateserve.com;lucky.kumar@corporateserve.com';
    //             CLEAR(SMTPMail);
    //             SMTPMail.Create(Recipient, 'Purchase Order No. ' + PurchaseHeader."No." + ' Approved', '', TRUE);
    //             Smtpmail.AppendtoBody('Dear ' + Vendor.Name + ',');
    //             Smtpmail.AppendtoBody('<br/>');
    //             Smtpmail.AppendtoBody('<br/>');
    //             SMTPMail.AppendtoBody('Your Purchase Order No. <b>' + PurchaseHeader."No." + '</b> has been Approved <br/>');
    //             SMTPMail.AppendtoBody('<br/><br/>[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].<br/><br/>');
    //             // SMTPMail.AppendtoBody('Regards,<br/>');
    //             // SMTPMail.AppendtoBody('SLCM Department');
    //             BodyText := SmtpMail.GetBody();
    //             Mail_lCU.Send();
    //         end;
    //     end else
    //         exit;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeDeletePurchQuote', '', False, False)]
    local procedure OnBeforeDeletePurchQuote(var QuotePurchHeader: Record "Purchase Header"; var OrderPurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
        QuotePurchHeader.OrderCreated := true;
        QuotePurchHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', False, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    begin
        ItemJnlLine."Purchase Budget" := PurchLine."Budget Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', false, false)]
    local procedure OnBeforeInsertInvLineFromRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line")
    begin
        PurchLine."Budget Code" := PurchRcptLine."Budget Code";
        PurchLine."Requisition No." := PurchRcptLine."Requisition No.";
        PurchLine."Requisition Type" := PurchRcptLine."Requisition Type";
        PurchLine."Requisition Line No." := PurchRcptLine."Requisition Line No.";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Quote", 'OnAfterCalculateCurrentShippingAndPayToOption', '', false, false)]
    local procedure ChangeShiptoOptionQuote(var ShipToOptions: Option "Default (Company Address)",Location,"Custom Address"; var PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address"; PurchaseHeader: Record "Purchase Header")
    begin
        ShipToOptions := ShipToOptions::Location;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterCalculateCurrentShippingAndPayToOption', '', false, false)]
    local procedure ChangeShiptoOptionOrder(var ShipToOptions: Option "Default (Company Address)",Location,"Customer Address","Custom Address"; var PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address"; PurchaseHeader: Record "Purchase Header")
    begin
        ShipToOptions := ShipToOptions::Location;
    end;
    //CSPL-00307---Ends

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, False)]
    Local procedure PurchaseBudgetILE(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."Purchase Budget" := ItemJournalLine."Purchase Budget";
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterInsertEvent', '', False, False)]
    Local Procedure GenjournalLineOnInsert(var Rec: Record "Gen. Journal Line")
    Begin
        Rec."Entry Date" := Today();
    End;

    [EventSubscriber(ObjectType::Table, 21, 'OnAfterInsertEvent', '', false, false)]
    local Procedure UpdateCLE(var Rec: Record "Cust. Ledger Entry")
    begin
        Rec."Entry Date" := Today();
    end;

    [EventSubscriber(ObjectType::Table, 17, 'OnAfterInsertEvent', '', false, false)]
    Local procedure UpdateGLE(var Rec: Record "G/L Entry")
    begin
        Rec."Entry Date" := Today();
    end;

    // [EventSubscriber(ObjectType::Table, 50345, 'OnAfterValidateEvent', 'Rotation Grade', false, false)]
    // Local Procedure CheckPGRStudents(var Rec: Record "Roster Ledger Entry"; var xRec: Record "Roster Ledger Entry")
    // Var
    //     StudentMaster: Record "Student Master-CS";
    //     StudentStatus: Record "Student Status";
    //     SMTPMailSetup: Record "Email Account";
    //     ReverseTrans: Record "Reversal Entry";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     ClinicalNotification: Codeunit "Clinical Notification";
    //     Recipients: List of [Text];
    //     Recipient: Text;
    //     CCs: List of [Text];
    //     CC: Text;
    //     BCCs: List of [Text];
    //     BCC: Text;
    //     Subject: Text[100];
    //     BodyText: Text;
    // Begin
    //     //If xRec."Rotation Grade" <> Rec."Rotation Grade" then
    //     If not (Rec."Rotation Grade" in ['F', 'X', 'SC', 'UC']) then
    //         exit;
    //     StudentMaster.Reset();//GMCS//27062023//START
    //     if StudentMaster.Get(Rec."Student ID") then begin
    //         StudentStatus.Reset();
    //         StudentStatus.SetRange(Code, StudentMaster.Status);
    //         StudentStatus.SetRange(Status, StudentStatus.Status::"Pending Graduation");
    //         If StudentStatus.FindFirst() then begin

    //             SMTPMailSetup.Reset();
    //             SMTPMailSetup.Get();
    //             Subject := 'PGR status reversal for ' + StudentMaster."Student Name";
    //             clear(Bodytext);
    //             Recipient := 'mmorell@auamed.org;astevens@AUAMED.ORG';
    //             CC := 'navdeep.singh@corporateserve.com;stuti.khandelwal@corporateserve.com';
    //             CCs := CC.Split(';');
    //             //Recipient := 'navdeep.singh@corporateserve.com;stuti.khandelwal@corporateserve.com';
    //             Recipients := Recipient.Split(';');
    //             SMTPMail.Create(Recipients, Subject, '', true, CCs, BCCs);
    //             SMTPMail.AppendtoBody('Dear Registrar,');
    //             Smtpmail.AppendtoBody('<br/>');
    //             Smtpmail.AppendtoBody('<br/>');
    //             SMTPMail.AppendtoBody('Student ' + StudentMaster."No." + ' is currently on a status of PGR and will need their status reverted/updated due to a schedule change/update.');
    //             Smtpmail.AppendtoBody('<br/>');
    //             Smtpmail.AppendtoBody('<br/>');
    //             SMTPMail.AppendtoBody('Regards,');
    //             Smtpmail.AppendtoBody('<br/>');
    //             Smtpmail.AppendtoBody('<br/>');
    //             SMTPMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail ID.');


    //             BodyText := SMTPMail.GetBody();
    //             Mail_lCU.Send();
    //             ClinicalNotification.EmailNotificationSave('REGISTRAR', 'MEA', SmtpMailSetup."Email Address", StudentMaster."No.", StudentMaster."Student Name", Subject, BodyText, 'PGR status reversal Notification to Registrar Team', Subject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
    //         end;
    //     end;
    // END;



}
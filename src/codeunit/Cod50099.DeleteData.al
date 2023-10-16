Codeunit 50099 "Data Delete Tool"
{

    Permissions = TableData 17 = rimd,
    TableData 21 = rimd,
    TableData 25 = rimd
    ;
    trigger OnRun()
    BEGIN
        IF NOT CONFIRM(Text0001, FALSE) THEN
            EXIT;

        Window.OPEN(Text0002);

        Window.UPDATE(1, FORMAT(DATABASE::"Action Message Entry"));
        RecRef.OPEN(DATABASE::"Action Message Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Analysis View Budget Entry"));
        RecRef.OPEN(DATABASE::"Analysis View Budget Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Analysis View Entry"));
        RecRef.OPEN(DATABASE::"Analysis View Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Analysis View"));
        RecRef.OPEN(DATABASE::"Analysis View");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Approval Comment Line"));
        RecRef.OPEN(DATABASE::"Approval Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Approval Entry"));
        RecRef.OPEN(DATABASE::"Approval Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Assemble-to-Order Link"));
        RecRef.OPEN(DATABASE::"Assemble-to-Order Link");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Assembly Comment Line"));
        RecRef.OPEN(DATABASE::"Assembly Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Assembly Header"));
        RecRef.OPEN(DATABASE::"Assembly Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Assembly Line"));
        RecRef.OPEN(DATABASE::"Assembly Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Avg. Cost Adjmt. Entry Point"));
        RecRef.OPEN(DATABASE::"Avg. Cost Adjmt. Entry Point");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Bank Acc. Reconciliation Line"));
        RecRef.OPEN(DATABASE::"Bank Acc. Reconciliation Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Bank Acc. Reconciliation"));
        RecRef.OPEN(DATABASE::"Bank Acc. Reconciliation");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Bank Account Ledger Entry"));
        RecRef.OPEN(DATABASE::"Bank Account Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Bank Account Statement Line"));
        RecRef.OPEN(DATABASE::"Bank Account Statement Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Bank Account Statement"));
        RecRef.OPEN(DATABASE::"Bank Account Statement");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Bank Stmt Multiple Match Line"));
        RecRef.OPEN(DATABASE::"Bank Stmt Multiple Match Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Campaign Entry"));
        RecRef.OPEN(DATABASE::"Campaign Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Capacity Ledger Entry"));
        RecRef.OPEN(DATABASE::"Capacity Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cash Flow Manual Revenue"));
        RecRef.OPEN(DATABASE::"Cash Flow Manual Revenue");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cash Flow Manual Expense"));
        RecRef.OPEN(DATABASE::"Cash Flow Manual Expense");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cash Flow Forecast Entry"));
        RecRef.OPEN(DATABASE::"Cash Flow Forecast Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cash Flow Worksheet Line"));
        RecRef.OPEN(DATABASE::"Cash Flow Worksheet Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Certificate of Supply"));
        RecRef.OPEN(DATABASE::"Certificate of Supply");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Change Log Entry"));
        RecRef.OPEN(DATABASE::"Change Log Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Check Ledger Entry"));
        RecRef.OPEN(DATABASE::"Check Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Comment Line"));
        RecRef.OPEN(DATABASE::"Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Contract Change Log"));
        RecRef.OPEN(DATABASE::"Contract Change Log");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Contract Gain/Loss Entry"));
        RecRef.OPEN(DATABASE::"Contract Gain/Loss Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Contract/Service Discount"));
        RecRef.OPEN(DATABASE::"Contract/Service Discount");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cost Budget Entry"));
        RecRef.OPEN(DATABASE::"Cost Budget Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cost Budget Register"));
        RecRef.OPEN(DATABASE::"Cost Budget Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cost Entry"));
        RecRef.OPEN(DATABASE::"Cost Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cost Journal Line"));
        RecRef.OPEN(DATABASE::"Cost Journal Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cost Register"));
        RecRef.OPEN(DATABASE::"Cost Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Credit Trans Re-export History"));
        RecRef.OPEN(DATABASE::"Credit Trans Re-export History");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Credit Transfer Entry"));
        RecRef.OPEN(DATABASE::"Credit Transfer Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Credit Transfer Register"));
        RecRef.OPEN(DATABASE::"Credit Transfer Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"G/L Account"));
        RecRef.OPEN(DATABASE::"G/L Account");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Customer));
        RecRef.OPEN(DATABASE::Customer);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Vendor));
        RecRef.OPEN(DATABASE::Vendor);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Item));
        RecRef.OPEN(DATABASE::Item);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Dimension));
        RecRef.OPEN(DATABASE::Dimension);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Dimension Value"));
        RecRef.OPEN(DATABASE::"Dimension Value");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Customer));
        RecRef.OPEN(DATABASE::Customer);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Cust. Ledger Entry"));
        RecRef.OPEN(DATABASE::"Cust. Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Date Compr. Register"));
        RecRef.OPEN(DATABASE::"Date Compr. Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Detailed Cust. Ledg. Entry"));
        RecRef.OPEN(DATABASE::"Detailed Cust. Ledg. Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Detailed Vendor Ledg. Entry"));
        RecRef.OPEN(DATABASE::"Detailed Vendor Ledg. Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Dimension Set Entry"));
        RecRef.OPEN(DATABASE::"Dimension Set Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Dimension Set Tree Node"));
        RecRef.OPEN(DATABASE::"Dimension Set Tree Node");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Direct Debit Collection Entry"));
        RecRef.OPEN(DATABASE::"Direct Debit Collection Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Direct Debit Collection"));
        RecRef.OPEN(DATABASE::"Direct Debit Collection");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        // Window.UPDATE(1, FORMAT(DATABASE::"DO Payment Trans. Log Entry"));
        // RecRef.OPEN(DATABASE::"DO Payment Trans. Log Entry");
        // RecRef.DELETEALL;
        // RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Document Entry"));
        RecRef.OPEN(DATABASE::"Document Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Email Item"));
        RecRef.OPEN(DATABASE::"Email Item");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Employee Absence"));
        RecRef.OPEN(DATABASE::"Employee Absence");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Error Buffer"));
        RecRef.OPEN(DATABASE::"Error Buffer");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Exch. Rate Adjmt. Reg."));
        RecRef.OPEN(DATABASE::"Exch. Rate Adjmt. Reg.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"FA G/L Posting Buffer"));
        RecRef.OPEN(DATABASE::"FA G/L Posting Buffer");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"FA Ledger Entry"));
        RecRef.OPEN(DATABASE::"FA Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"FA Register"));
        RecRef.OPEN(DATABASE::"FA Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Filed Contract Line"));
        RecRef.OPEN(DATABASE::"Filed Contract Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Filed Service Contract Header"));
        RecRef.OPEN(DATABASE::"Filed Service Contract Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Fin. Charge Comment Line"));
        RecRef.OPEN(DATABASE::"Fin. Charge Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Finance Charge Memo Header"));
        RecRef.OPEN(DATABASE::"Finance Charge Memo Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Finance Charge Memo Line"));
        RecRef.OPEN(DATABASE::"Finance Charge Memo Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"G/L - Item Ledger Relation"));
        RecRef.OPEN(DATABASE::"G/L - Item Ledger Relation");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"G/L Budget Entry"));
        RecRef.OPEN(DATABASE::"G/L Budget Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"G/L Budget Name"));
        RecRef.OPEN(DATABASE::"G/L Budget Name");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"G/L Entry - VAT Entry Link"));
        RecRef.OPEN(DATABASE::"G/L Entry - VAT Entry Link");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"G/L Entry"));
        RecRef.OPEN(DATABASE::"G/L Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"G/L Register"));
        RecRef.OPEN(DATABASE::"G/L Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Gen. Jnl. Allocation"));
        RecRef.OPEN(DATABASE::"Gen. Jnl. Allocation");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Gen. Journal Line"));
        RecRef.OPEN(DATABASE::"Gen. Journal Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        // Window.UPDATE(1, FORMAT(DATABASE::"Gen. Journal Narration"));
        // RecRef.OPEN(DATABASE::"Gen. Journal Narration");
        // RecRef.DELETEALL;
        // RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Inbox Jnl. Line"));
        RecRef.OPEN(DATABASE::"Handled IC Inbox Jnl. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Inbox Purch. Header"));
        RecRef.OPEN(DATABASE::"Handled IC Inbox Purch. Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Inbox Purch. Line"));
        RecRef.OPEN(DATABASE::"Handled IC Inbox Purch. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Inbox Sales Header"));
        RecRef.OPEN(DATABASE::"Handled IC Inbox Sales Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Inbox Sales Line"));
        RecRef.OPEN(DATABASE::"Handled IC Inbox Sales Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Inbox Trans."));
        RecRef.OPEN(DATABASE::"Handled IC Inbox Trans.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Outbox Jnl. Line"));
        RecRef.OPEN(DATABASE::"Handled IC Outbox Jnl. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Outbox Purch. Hdr"));
        RecRef.OPEN(DATABASE::"Handled IC Outbox Purch. Hdr");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Outbox Purch. Line"));
        RecRef.OPEN(DATABASE::"Handled IC Outbox Purch. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Outbox Sales Header"));
        RecRef.OPEN(DATABASE::"Handled IC Outbox Sales Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Outbox Sales Line"));
        RecRef.OPEN(DATABASE::"Handled IC Outbox Sales Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Handled IC Outbox Trans."));
        RecRef.OPEN(DATABASE::"Handled IC Outbox Trans.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Comment Line"));
        RecRef.OPEN(DATABASE::"IC Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Document Dimension"));
        RecRef.OPEN(DATABASE::"IC Document Dimension");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Inbox Jnl. Line"));
        RecRef.OPEN(DATABASE::"IC Inbox Jnl. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Inbox Purchase Header"));
        RecRef.OPEN(DATABASE::"IC Inbox Purchase Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Inbox Purchase Line"));
        RecRef.OPEN(DATABASE::"IC Inbox Purchase Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Inbox Sales Header"));
        RecRef.OPEN(DATABASE::"IC Inbox Sales Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Inbox Sales Line"));
        RecRef.OPEN(DATABASE::"IC Inbox Sales Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Inbox Transaction"));
        RecRef.OPEN(DATABASE::"IC Inbox Transaction");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Inbox/Outbox Jnl. Line Dim."));
        RecRef.OPEN(DATABASE::"IC Inbox/Outbox Jnl. Line Dim.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Outbox Jnl. Line"));
        RecRef.OPEN(DATABASE::"IC Outbox Jnl. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Outbox Purchase Header"));
        RecRef.OPEN(DATABASE::"IC Outbox Purchase Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Outbox Purchase Line"));
        RecRef.OPEN(DATABASE::"IC Outbox Purchase Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Outbox Sales Header"));
        RecRef.OPEN(DATABASE::"IC Outbox Sales Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Outbox Sales Line"));
        RecRef.OPEN(DATABASE::"IC Outbox Sales Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"IC Outbox Transaction"));
        RecRef.OPEN(DATABASE::"IC Outbox Transaction");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Incoming Document"));
        RecRef.OPEN(DATABASE::"Incoming Document");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Ins. Coverage Ledger Entry"));
        RecRef.OPEN(DATABASE::"Ins. Coverage Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Insurance Register"));
        RecRef.OPEN(DATABASE::"Insurance Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Inter. Log Entry Comment Line"));
        RecRef.OPEN(DATABASE::"Inter. Log Entry Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Interaction Log Entry"));
        RecRef.OPEN(DATABASE::"Interaction Log Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Internal Movement Header"));
        RecRef.OPEN(DATABASE::"Internal Movement Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Internal Movement Line"));
        RecRef.OPEN(DATABASE::"Internal Movement Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Intrastat Jnl. Line"));
        RecRef.OPEN(DATABASE::"Intrastat Jnl. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Inventory Adjmt. Entry (Order)"));
        RecRef.OPEN(DATABASE::"Inventory Adjmt. Entry (Order)");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Inventory Adjmt. Entry (Order)"));
        RecRef.OPEN(DATABASE::"Inventory Adjmt. Entry (Order)");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Inventory Period Entry"));
        RecRef.OPEN(DATABASE::"Inventory Period Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Inventory Report Entry"));
        RecRef.OPEN(DATABASE::"Inventory Report Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Issued Fin. Charge Memo Header"));
        RecRef.OPEN(DATABASE::"Issued Fin. Charge Memo Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Issued Fin. Charge Memo Line"));
        RecRef.OPEN(DATABASE::"Issued Fin. Charge Memo Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Issued Reminder Header"));
        RecRef.OPEN(DATABASE::"Issued Reminder Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Issued Reminder Line"));
        RecRef.OPEN(DATABASE::"Issued Reminder Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Analysis View Budg. Entry"));
        RecRef.OPEN(DATABASE::"Item Analysis View Budg. Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Analysis View Entry"));
        RecRef.OPEN(DATABASE::"Item Analysis View Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Analysis View"));
        RecRef.OPEN(DATABASE::"Item Analysis View");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Application Entry History"));
        RecRef.OPEN(DATABASE::"Item Application Entry History");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Application Entry"));
        RecRef.OPEN(DATABASE::"Item Application Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Budget Entry"));
        RecRef.OPEN(DATABASE::"Item Budget Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Charge Assignment (Purch)"));
        RecRef.OPEN(DATABASE::"Item Charge Assignment (Purch)");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Charge Assignment (Sales)"));
        RecRef.OPEN(DATABASE::"Item Charge Assignment (Sales)");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Entry Relation"));
        RecRef.OPEN(DATABASE::"Item Entry Relation");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Journal Line"));
        RecRef.OPEN(DATABASE::"Item Journal Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Ledger Entry"));
        RecRef.OPEN(DATABASE::"Item Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Register"));
        RecRef.OPEN(DATABASE::"Item Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Item Tracking Comment"));
        RecRef.OPEN(DATABASE::"Item Tracking Comment");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Entry No."));
        RecRef.OPEN(DATABASE::"Job Entry No.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job G/L Account Price"));
        RecRef.OPEN(DATABASE::"Job G/L Account Price");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Item Price"));
        RecRef.OPEN(DATABASE::"Job Item Price");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Journal Line"));
        RecRef.OPEN(DATABASE::"Job Journal Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Ledger Entry"));
        RecRef.OPEN(DATABASE::"Job Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Planning Line Invoice"));
        RecRef.OPEN(DATABASE::"Job Planning Line Invoice");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Planning Line"));
        RecRef.OPEN(DATABASE::"Job Planning Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Queue Log Entry"));
        RecRef.OPEN(DATABASE::"Job Queue Log Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Register"));
        RecRef.OPEN(DATABASE::"Job Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Resource Price"));
        RecRef.OPEN(DATABASE::"Job Resource Price");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Task Dimension"));
        RecRef.OPEN(DATABASE::"Job Task Dimension");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Task"));
        RecRef.OPEN(DATABASE::"Job Task");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job Usage Link"));
        RecRef.OPEN(DATABASE::"Job Usage Link");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job WIP Entry"));
        RecRef.OPEN(DATABASE::"Job WIP Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;


        Window.UPDATE(1, FORMAT(DATABASE::"Job WIP G/L Entry"));
        RecRef.OPEN(DATABASE::"Job WIP G/L Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Job WIP Total"));
        RecRef.OPEN(DATABASE::"Job WIP Total");
        RecRef.DELETEALL;
        RecRef.CLOSE;


        Window.UPDATE(1, FORMAT(DATABASE::"Job WIP Warning"));
        RecRef.OPEN(DATABASE::"Job WIP Warning");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Loaner Entry"));
        RecRef.OPEN(DATABASE::"Loaner Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Lot No. Information"));
        RecRef.OPEN(DATABASE::"Lot No. Information");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Maintenance Ledger Entry"));
        RecRef.OPEN(DATABASE::"Maintenance Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Maintenance Registration"));
        RecRef.OPEN(DATABASE::"Maintenance Registration");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Opportunity Entry"));
        RecRef.OPEN(DATABASE::"Opportunity Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Order Promising Line"));
        RecRef.OPEN(DATABASE::"Order Promising Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Order Tracking Entry"));
        RecRef.OPEN(DATABASE::"Order Tracking Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Overdue Approval Entry"));
        RecRef.OPEN(DATABASE::"Overdue Approval Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Payable Vendor Ledger Entry"));
        RecRef.OPEN(DATABASE::"Payable Vendor Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Payment Application Proposal"));
        RecRef.OPEN(DATABASE::"Payment Application Proposal");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Payment Export Data"));
        RecRef.OPEN(DATABASE::"Payment Export Data");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Payment Jnl. Export Error Text"));
        RecRef.OPEN(DATABASE::"Payment Jnl. Export Error Text");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Payment Matching Details"));
        RecRef.OPEN(DATABASE::"Payment Matching Details");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Phys. Inventory Ledger Entry"));
        RecRef.OPEN(DATABASE::"Phys. Inventory Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Planning Assignment"));
        RecRef.OPEN(DATABASE::"Planning Assignment");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Planning Component"));
        RecRef.OPEN(DATABASE::"Planning Component");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Planning Error Log"));
        RecRef.OPEN(DATABASE::"Planning Error Log");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Planning Routing Line"));
        RecRef.OPEN(DATABASE::"Planning Routing Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Post Value Entry to G/L"));
        RecRef.OPEN(DATABASE::"Post Value Entry to G/L");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Approval Comment Line"));
        RecRef.OPEN(DATABASE::"Posted Approval Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Approval Entry"));
        RecRef.OPEN(DATABASE::"Posted Approval Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Assemble-to-Order Link"));
        RecRef.OPEN(DATABASE::"Posted Assemble-to-Order Link");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Assembly Header"));
        RecRef.OPEN(DATABASE::"Posted Assembly Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Assembly Line"));
        RecRef.OPEN(DATABASE::"Posted Assembly Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Invt. Pick Header"));
        RecRef.OPEN(DATABASE::"Posted Invt. Pick Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Invt. Pick Line"));
        RecRef.OPEN(DATABASE::"Posted Invt. Pick Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Invt. Put-away Header"));
        RecRef.OPEN(DATABASE::"Posted Invt. Put-away Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Invt. Put-away Line"));
        RecRef.OPEN(DATABASE::"Posted Invt. Put-away Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        // Window.UPDATE(1, FORMAT(DATABASE::"Posted Narration"));
        // RecRef.OPEN(DATABASE::"Posted Narration");
        // RecRef.DELETEALL;
        // RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Payment Recon. Hdr"));
        RecRef.OPEN(DATABASE::"Posted Payment Recon. Hdr");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Payment Recon. Line"));
        RecRef.OPEN(DATABASE::"Posted Payment Recon. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Whse. Receipt Header"));
        RecRef.OPEN(DATABASE::"Posted Whse. Receipt Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Whse. Receipt Line"));
        RecRef.OPEN(DATABASE::"Posted Whse. Receipt Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Whse. Shipment Header"));
        RecRef.OPEN(DATABASE::"Posted Whse. Shipment Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Posted Whse. Shipment Line"));
        RecRef.OPEN(DATABASE::"Posted Whse. Shipment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Data Exch. Field"));
        RecRef.OPEN(DATABASE::"Data Exch. Field");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Data Exch."));
        RecRef.OPEN(DATABASE::"Data Exch.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Capacity Need"));
        RecRef.OPEN(DATABASE::"Prod. Order Capacity Need");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Comment Line"));
        RecRef.OPEN(DATABASE::"Prod. Order Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Component"));
        RecRef.OPEN(DATABASE::"Prod. Order Component");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Line"));
        RecRef.OPEN(DATABASE::"Prod. Order Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Routing Line"));
        RecRef.OPEN(DATABASE::"Prod. Order Routing Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Routing Personnel"));
        RecRef.OPEN(DATABASE::"Prod. Order Routing Personnel");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Routing Tool"));
        RecRef.OPEN(DATABASE::"Prod. Order Routing Tool");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Rtng Comment Line"));
        RecRef.OPEN(DATABASE::"Prod. Order Rtng Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Prod. Order Rtng Qlty Meas."));
        RecRef.OPEN(DATABASE::"Prod. Order Rtng Qlty Meas.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Production Forecast Entry"));
        RecRef.OPEN(DATABASE::"Production Forecast Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Production Order"));
        RecRef.OPEN(DATABASE::"Production Order");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purch. Comment Line Archive"));
        RecRef.OPEN(DATABASE::"Purch. Comment Line Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purch. Comment Line"));
        RecRef.OPEN(DATABASE::"Purch. Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purch. Cr. Memo Hdr."));
        RecRef.OPEN(DATABASE::"Purch. Cr. Memo Hdr.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purch. Cr. Memo Line"));
        RecRef.OPEN(DATABASE::"Purch. Cr. Memo Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purch. Inv. Header"));
        RecRef.OPEN(DATABASE::"Purch. Inv. Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purch. Inv. Line"));
        RecRef.OPEN(DATABASE::"Purch. Inv. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purch. Rcpt. Header"));
        RecRef.OPEN(DATABASE::"Purch. Rcpt. Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purch. Rcpt. Line"));
        RecRef.OPEN(DATABASE::"Purch. Rcpt. Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purchase Header Archive"));
        RecRef.OPEN(DATABASE::"Purchase Header Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purchase Header"));
        RecRef.OPEN(DATABASE::"Purchase Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purchase Line Archive"));
        RecRef.OPEN(DATABASE::"Purchase Line Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Purchase Line"));
        RecRef.OPEN(DATABASE::"Purchase Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Registered Invt. Movement Hdr."));
        RecRef.OPEN(DATABASE::"Registered Invt. Movement Hdr.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Registered Invt. Movement Line"));
        RecRef.OPEN(DATABASE::"Registered Invt. Movement Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Registered Whse. Activity Hdr."));
        RecRef.OPEN(DATABASE::"Registered Whse. Activity Hdr.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Registered Whse. Activity Line"));
        RecRef.OPEN(DATABASE::"Registered Whse. Activity Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Reminder Comment Line"));
        RecRef.OPEN(DATABASE::"Reminder Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Reminder Header"));
        RecRef.OPEN(DATABASE::"Reminder Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Reminder Line"));
        RecRef.OPEN(DATABASE::"Reminder Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Reminder/Fin. Charge Entry"));
        RecRef.OPEN(DATABASE::"Reminder/Fin. Charge Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Requisition Line"));
        RecRef.OPEN(DATABASE::"Requisition Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Res. Capacity Entry"));
        RecRef.OPEN(DATABASE::"Res. Capacity Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Res. Journal Line"));
        RecRef.OPEN(DATABASE::"Res. Journal Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Res. Ledger Entry"));
        RecRef.OPEN(DATABASE::"Res. Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Reservation Entry"));
        RecRef.OPEN(DATABASE::"Reservation Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Resource Register"));
        RecRef.OPEN(DATABASE::"Resource Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Return Receipt Header"));
        RecRef.OPEN(DATABASE::"Return Receipt Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Return Receipt Line"));
        RecRef.OPEN(DATABASE::"Return Receipt Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Return Shipment Header"));
        RecRef.OPEN(DATABASE::"Return Shipment Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Return Shipment Line"));
        RecRef.OPEN(DATABASE::"Return Shipment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Returns-Related Document"));
        RecRef.OPEN(DATABASE::"Returns-Related Document");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Reversal Entry"));
        RecRef.OPEN(DATABASE::"Reversal Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Rounding Residual Buffer"));
        RecRef.OPEN(DATABASE::"Rounding Residual Buffer");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Comment Line Archive"));
        RecRef.OPEN(DATABASE::"Sales Comment Line Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Comment Line"));
        RecRef.OPEN(DATABASE::"Sales Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Cr.Memo Header"));
        RecRef.OPEN(DATABASE::"Sales Cr.Memo Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;


        Window.UPDATE(1, FORMAT(DATABASE::"Sales Cr.Memo Line"));
        RecRef.OPEN(DATABASE::"Sales Cr.Memo Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Cr.Memo Line"));
        RecRef.OPEN(DATABASE::"Sales Cr.Memo Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Header Archive"));
        RecRef.OPEN(DATABASE::"Sales Header Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Header"));
        RecRef.OPEN(DATABASE::"Sales Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Invoice Header"));
        RecRef.OPEN(DATABASE::"Sales Invoice Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Invoice Line"));
        RecRef.OPEN(DATABASE::"Sales Invoice Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Line Archive"));
        RecRef.OPEN(DATABASE::"Sales Line Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Line Archive"));
        RecRef.OPEN(DATABASE::"Sales Line Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Line"));
        RecRef.OPEN(DATABASE::"Sales Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Planning Line"));
        RecRef.OPEN(DATABASE::"Sales Planning Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Shipment Header"));
        RecRef.OPEN(DATABASE::"Sales Shipment Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Sales Shipment Line"));
        RecRef.OPEN(DATABASE::"Sales Shipment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Segment Criteria Line"));
        RecRef.OPEN(DATABASE::"Segment Criteria Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Segment Header"));
        RecRef.OPEN(DATABASE::"Segment Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Segment History"));
        RecRef.OPEN(DATABASE::"Segment History");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Segment Interaction Language"));
        RecRef.OPEN(DATABASE::"Segment Interaction Language");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Segment Line"));
        RecRef.OPEN(DATABASE::"Segment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Serial No. Information"));
        RecRef.OPEN(DATABASE::"Serial No. Information");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Comment Line"));
        RecRef.OPEN(DATABASE::"Service Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Contract Header"));
        RecRef.OPEN(DATABASE::"Service Contract Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Contract Line"));
        RecRef.OPEN(DATABASE::"Service Contract Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Cr.Memo Header"));
        RecRef.OPEN(DATABASE::"Service Cr.Memo Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Cr.Memo Line"));
        RecRef.OPEN(DATABASE::"Service Cr.Memo Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Document Log"));
        RecRef.OPEN(DATABASE::"Service Document Log");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Document Register"));
        RecRef.OPEN(DATABASE::"Service Document Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        // Window.UPDATE(1, FORMAT(DATABASE::"Service E-Mail Queue"));
        // RecRef.OPEN(DATABASE::"Service E-Mail Queue");
        // RecRef.DELETEALL;
        // RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Header"));
        RecRef.OPEN(DATABASE::"Service Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Invoice Header"));
        RecRef.OPEN(DATABASE::"Service Invoice Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Invoice Line"));
        RecRef.OPEN(DATABASE::"Service Invoice Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Item Component"));
        RecRef.OPEN(DATABASE::"Service Item Component");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Item Line"));
        RecRef.OPEN(DATABASE::"Service Item Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Item Log"));
        RecRef.OPEN(DATABASE::"Service Item Log");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Item"));
        RecRef.OPEN(DATABASE::"Service Item");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Ledger Entry"));
        RecRef.OPEN(DATABASE::"Service Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Line Price Adjmt."));
        RecRef.OPEN(DATABASE::"Service Line Price Adjmt.");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Line"));
        RecRef.OPEN(DATABASE::"Service Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Order Allocation"));
        RecRef.OPEN(DATABASE::"Service Order Allocation");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Register"));
        RecRef.OPEN(DATABASE::"Service Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Shipment Header"));
        RecRef.OPEN(DATABASE::"Service Shipment Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Shipment Item Line"));
        RecRef.OPEN(DATABASE::"Service Shipment Item Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Service Shipment Line"));
        RecRef.OPEN(DATABASE::"Service Shipment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Cmt. Line Archive"));
        RecRef.OPEN(DATABASE::"Time Sheet Cmt. Line Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Comment Line"));
        RecRef.OPEN(DATABASE::"Time Sheet Comment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Detail Archive"));
        RecRef.OPEN(DATABASE::"Time Sheet Detail Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Detail"));
        RecRef.OPEN(DATABASE::"Time Sheet Detail");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Header Archive"));
        RecRef.OPEN(DATABASE::"Time Sheet Header Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Header"));
        RecRef.OPEN(DATABASE::"Time Sheet Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Line Archive"));
        RecRef.OPEN(DATABASE::"Time Sheet Line Archive");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Line"));
        RecRef.OPEN(DATABASE::"Time Sheet Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Time Sheet Posting Entry"));
        RecRef.OPEN(DATABASE::"Time Sheet Posting Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"To-do"));
        RecRef.OPEN(DATABASE::"To-do");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Tracking Specification"));
        RecRef.OPEN(DATABASE::"Tracking Specification");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Transfer Header"));
        RecRef.OPEN(DATABASE::"Transfer Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Transfer Line"));
        RecRef.OPEN(DATABASE::"Transfer Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Transfer Receipt Header"));
        RecRef.OPEN(DATABASE::"Transfer Receipt Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Transfer Receipt Line"));
        RecRef.OPEN(DATABASE::"Transfer Receipt Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Transfer Shipment Header"));
        RecRef.OPEN(DATABASE::"Transfer Shipment Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Transfer Shipment Line"));
        RecRef.OPEN(DATABASE::"Transfer Shipment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Unplanned Demand"));
        RecRef.OPEN(DATABASE::"Unplanned Demand");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Untracked Planning Element"));
        RecRef.OPEN(DATABASE::"Untracked Planning Element");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Value Entry Relation"));
        RecRef.OPEN(DATABASE::"Value Entry Relation");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Value Entry"));
        RecRef.OPEN(DATABASE::"Value Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"VAT Entry"));
        RecRef.OPEN(DATABASE::"VAT Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"VAT Rate Change Log Entry"));
        RecRef.OPEN(DATABASE::"VAT Rate Change Log Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"VAT Report Header"));
        RecRef.OPEN(DATABASE::"VAT Report Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"VAT Report Line"));
        RecRef.OPEN(DATABASE::"VAT Report Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"VAT Report Line Relation"));
        RecRef.OPEN(DATABASE::"VAT Report Line Relation");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"VAT Report Error Log"));
        RecRef.OPEN(DATABASE::"VAT Report Error Log");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Vendor Ledger Entry"));
        RecRef.OPEN(DATABASE::"Vendor Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Activity Header"));
        RecRef.OPEN(DATABASE::"Warehouse Activity Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Activity Line"));
        RecRef.OPEN(DATABASE::"Warehouse Activity Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Entry"));
        RecRef.OPEN(DATABASE::"Warehouse Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Journal Line"));
        RecRef.OPEN(DATABASE::"Warehouse Journal Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Receipt Header"));
        RecRef.OPEN(DATABASE::"Warehouse Receipt Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Receipt Line"));
        RecRef.OPEN(DATABASE::"Warehouse Receipt Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Register"));
        RecRef.OPEN(DATABASE::"Warehouse Register");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Request"));
        RecRef.OPEN(DATABASE::"Warehouse Request");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Shipment Header"));
        RecRef.OPEN(DATABASE::"Warehouse Shipment Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warehouse Shipment Line"));
        RecRef.OPEN(DATABASE::"Warehouse Shipment Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Warranty Ledger Entry"));
        RecRef.OPEN(DATABASE::"Warranty Ledger Entry");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Internal Pick Header"));
        RecRef.OPEN(DATABASE::"Whse. Internal Pick Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Internal Pick Line"));
        RecRef.OPEN(DATABASE::"Whse. Internal Pick Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Internal Put-away Header"));
        RecRef.OPEN(DATABASE::"Whse. Internal Put-away Header");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Internal Put-away Line"));
        RecRef.OPEN(DATABASE::"Whse. Internal Put-away Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Item Entry Relation"));
        RecRef.OPEN(DATABASE::"Whse. Item Entry Relation");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Item Tracking Line"));
        RecRef.OPEN(DATABASE::"Whse. Item Tracking Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Pick Request"));
        RecRef.OPEN(DATABASE::"Whse. Pick Request");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Put-away Request"));
        RecRef.OPEN(DATABASE::"Whse. Put-away Request");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::"Whse. Worksheet Line"));
        RecRef.OPEN(DATABASE::"Whse. Worksheet Line");
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Attachment));
        RecRef.OPEN(DATABASE::Attachment);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Attendee));
        RecRef.OPEN(DATABASE::Attendee);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Job));
        RecRef.OPEN(DATABASE::Job);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.UPDATE(1, FORMAT(DATABASE::Opportunity));
        RecRef.OPEN(DATABASE::Opportunity);
        RecRef.DELETEALL;
        RecRef.CLOSE;

        Window.CLOSE;

        MESSAGE('Done');
    END;

    var
        Window: Dialog;
        RecRef: RecordRef;
        Text0001: Label 'ENU=Delete Records?';
        Text0002: Label 'ENU=Deleting Records!\Table: #1#######';
}

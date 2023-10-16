codeunit 50015 "Issue Indent -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   18/02/2019     ()-OnRun                        Code added for insert data Item Journal.
    // 02    CSPL-00059   18/02/2019     InsertItemPost()-Function       Code added for indent posting .


    trigger OnRun()
    begin
        //Code added for insert data Item Journal::CSPL-00059::18022019: Start
        IndentLCS.Reset();
        IndentLCS.SETRANGE(Select, TRUE);
        IF IndentLCS.FINDSET() THEN
            REPEAT
                ItemJournalLine.INIT();
                IF ItemJournalLine.FINDLAST() THEN
                    Linenum := ItemJournalLine."Line No." + 10000
                ELSE
                    Linenum := 10000;

                ItemJournalLine."Journal Batch Name" := 'DEFAULT';
                ItemJournalLine."Journal Template Name" := 'ITEM';
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                ItemJournalLine."Source No." := IndentLCS."No.";
                ItemJournalLine."Document No." := IndentLCS."Document No";
                ItemJournalLine.Description := IndentLCS.Name;
                ItemJournalLine."Item No." := IndentLCS."Item No";
                ItemJournalLine.VALIDATE(ItemJournalLine."Item No.");
                ItemJournalLine."Location Code" := IndentLCS.Location;
                ItemJournalLine."Variant Code" := IndentLCS."Varient Code";
                ItemJournalLine."Posting Date" := WORKDATE();
                ItemJournalLine.Quantity := IndentLCS."Issue Qty";
                ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
                ItemJournalLine."Line No." := Linenum;
                //ItemJournalLine."Document Type" := ItemJournalLine."Document Type"::"Item Indent";
                ItemJournalLine."Unit Cost" := IndentLCS."Unit Price";
                ItemJournalLine."Indent For" := ItemJournalLine."Indent For";
                ItemJournalLine."Gen. Prod. Posting Group" := IndentLCS."Gen. Prod. Posting Group";
                ItemJournalLine."Document Line No." := IndentLCS."Line No.";
                ItemJournalLine."Source Type" := IndentLCS.Type;
                ItemJournalLine."Unit of Measure Code" := IndentLCS."Unit of Measure";
                ItemJournalLine.Remarks := IndentLCS.Remarks;
                ItemJournalLine."Gen. Bus. Posting Group" := 'DOMESTIC';
                IndentLCS.Select := FALSE;
                IF IndentLCS."Rem.Qty" <> 0.0 THEN
                    IndentLCS."Indent Status" := IndentLCS."Indent Status"::Pending
                ELSE BEGIN
                    IndentLCS."Issue Indent" := TRUE;
                    IndentLCS."Indent Status" := IndentLCS."Indent Status"::Issue;
                END;

                IndentLCS.Modify();
                MESSAGE('%1--%2--%3', IndentLCS."Document No", IndentLCS."No.", IndentLCS."Line No.");
            UNTIL IndentLCS.NEXT() = 0;
        //Code added for insert data Item Journal::CSPL-00059::18022019: End
    end;

    var

        IndentLCS: Record "Indent L-CS";
        ItemJournalLine: Record "Item Journal Line";
        Linenum: Integer;


    procedure InsertItemPost(IndentLCS: Record "Indent L-CS"; var Flag: Boolean)
    begin
        //Code added for indent post ::CSPL-00059::18022019: Start
        ItemJournalLine.Reset();
        ItemJournalLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        ItemJournalLine.SETRANGE("Journal Template Name", 'ITEM');
        IF ItemJournalLine.FINDSET() THEN
            ItemJournalLine.DELETEALL();

        IndentLCS.Reset();
        IndentLCS.SETRANGE(Select, TRUE);
        IF IndentLCS.FINDSET() THEN
            REPEAT
                ItemJournalLine.INIT();
                IF ItemJournalLine.FINDLAST() THEN
                    Linenum := ItemJournalLine."Line No." + 10000
                ELSE
                    Linenum := 10000;

                ItemJournalLine.VALIDATE("Journal Batch Name", 'DEFAULT');
                ItemJournalLine.VALIDATE("Journal Template Name", 'ITEM');
                ItemJournalLine.VALIDATE("Line No.", Linenum);
                ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                ItemJournalLine.VALIDATE("Source No.", IndentLCS."No.");
                ItemJournalLine.VALIDATE("Document No.", IndentLCS."Document No");
                ItemJournalLine.VALIDATE("Item No.", IndentLCS."Item No");
                ItemJournalLine.VALIDATE(ItemJournalLine."Item No.");
                ItemJournalLine.VALIDATE("Location Code", IndentLCS.Location);
                ItemJournalLine.VALIDATE("Variant Code", IndentLCS."Varient Code");
                ItemJournalLine.VALIDATE("Posting Date", WORKDATE());
                ItemJournalLine.VALIDATE(Quantity, IndentLCS."Issue Qty");
                //ItemJournalLine.VALIDATE("Document Type", ItemJournalLine."Document Type"::"Item Indent");
                ItemJournalLine.VALIDATE("Unit Cost", IndentLCS."Unit Price");
                ItemJournalLine.VALIDATE("Indent For", IndentLCS."Indent For");
                ItemJournalLine.VALIDATE("Gen. Prod. Posting Group", IndentLCS."Gen. Prod. Posting Group");
                ItemJournalLine.VALIDATE("Document Line No.", IndentLCS."Line No.");
                ItemJournalLine.VALIDATE("Source Type", IndentLCS.Type);
                ItemJournalLine.VALIDATE("Unit of Measure Code", IndentLCS."Unit of Measure");
                ItemJournalLine.VALIDATE(Remarks, IndentLCS.Remarks);
                ItemJournalLine.VALIDATE("Gen. Bus. Posting Group", 'DOMESTIC');
                ItemJournalLine.INSERT(TRUE);
                Flag := TRUE;
            UNTIL IndentLCS.NEXT() = 0;
        IF Flag THEN
            CODEUNIT.RUN(22, ItemJournalLine);
        //Code added for indent post ::CSPL-00059::18022019: End
    end;
}


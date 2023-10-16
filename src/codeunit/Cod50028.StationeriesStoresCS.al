codeunit 50028 "Stationeries & Stores-CS"
{
    // version V.001-CS

    // -----------------------------------------------------------------------------------------------
    // Sr.No.   Emp Id        Date    Trigger                        Remark
    // 1       CSPL-00067    20-02-19LinePostCS                    Code Added for Insert Issue Line
    // 2       CSPL-00067    20-02-19PostItemsCS                  Code Added for Sale Document Insert & Post
    // 3       CSPL-00067    20-02-19IssueLineInsertCS            Code Added for Insert Bulk Line
    // 4       CSPL-00067    20-02-19BulkStationeryLinePostCS    Code Added for Insert Bulk Stationery Line & Post
    // 5       CSPL-00067    20-02-19InsertBulkStationeryLineCS  Code Added for Insert Bulk Stationery Line
    // 6       CSPL-00067    20-02-19PostBulkStationeryItemsCS    Code Added for Post Bulk Stationery Items


    trigger OnRun()
    begin
    end;

    var

    procedure LinePostCS("IssueNo.": Code[20])
    begin
        /*
        //Code Added for Insert Issue Line::CSPL-00114::20022019: Start
        BulkHeader.GET("IssueNo.");
        BulkHeader.TESTFIELD("Indent No");
        BulkHeader.TESTFIELD("Issue Date");
        BulkHeader.TESTFIELD(Class);
        BulkHeader.TESTFIELD(Section);
        BulkHeader.TESTFIELD(Curriculum);
        BulkHeader.TESTFIELD("Academic Year");
        BulkLine."Line No." := 0;
        
        IF BulkHeader.Item <> '' THEN BEGIN
          BulkHeader.TESTFIELD(Quantity);
          Student.Reset();
          Student.SETCURRENTKEY(Class,Section,Curriculum,"Academic Year");
          Student.SETRANGE(Class,BulkHeader.Class);
          Student.SETRANGE(Section,BulkHeader.Section);
          Student.SETRANGE(Curriculum,BulkHeader.Curriculum);
          Student.SETRANGE("Academic Year",BulkHeader."Academic Year");
          Student.SETRANGE("Student Status",Student."Student Status"::Student);
          IF Student.FINDSET()THEN
            REPEAT
              "Insert Issue Line"("IssueNo.",BulkHeader."Issue Date",Student."No.",Student.Name,
                BulkHeader.Item,BulkHeader.Quantity);
            UNTIL Student.NEXT() = 0;
        END ELSE BEGIN
          BulkIssues.Reset();
          BulkIssues.SETRANGE("Document No.","IssueNo.");
          IF BulkIssues.FINDSET()THEN
            REPEAT
              BulkIssues.TESTFIELD(Quantity);
              Student.Reset();
              Student.SETCURRENTKEY(Class,Section,Curriculum,"Academic Year");
              Student.SETRANGE(Class,BulkHeader.Class);
              Student.SETRANGE(Section,BulkHeader.Section);
              Student.SETRANGE(Curriculum,BulkHeader.Curriculum);
              Student.SETRANGE("Academic Year",BulkHeader."Academic Year");
              Student.SETRANGE("Student Status",Student."Student Status"::Student);
              IF Student.FINDSET()THEN
                REPEAT
                  "Insert Issue Line"("IssueNo.",BulkHeader."Issue Date",Student."No.",Student.Name,
                    BulkIssues."Item No",BulkIssues.Quantity);
                UNTIL Student.NEXT() = 0;
            UNTIL BulkIssues.NEXT() = 0
          ELSE
            ERROR(Text000Lbl);
        END;
        //Code Added for Insert Issue Line::CSPL-00114::20022019: End
        */

    end;

    procedure PostItemsCS("IssueNo.": Code[20])
    begin
        //Code Added for Sale Document Insert & Post::CSPL-00114::20022019: Start
        /*
        BulkLine.Reset();
        BulkHeader.GET("IssueNo.");
        StoresSetup.GET();
        StoresSetup.TESTFIELD("Fee Code");
        BulkLine.SETRANGE("Document No.","IssueNo.");
        IF BulkLine.ISEMPTY() then
          ERROR(Text001Lbl);
        IF BulkLine.FINDSET()THEN
          REPEAT
            SalesHead.INIT();
            SalesHead."Document Type" := SalesHead."Document Type"::Order;
            SalesHead."No." := '';
            SalesHead."Document Date" := TODAY();
            SalesHead."Posting Date" := BulkLine."Issue Date";
            SalesHead.VALIDATE("Sell-to Customer No.",BulkLine."Student No.");
            SalesHead."External Document No." := BulkLine."Document No.";
            SalesHead."Due Date" := TODAY();
            SalesHead."Order Date" := BulkLine."Issue Date";
            SalesHead."Fee Code" := StoresSetup."Fee Code";
            SalesHead.Ship := TRUE;
            SalesHead.Invoice := TRUE;
            IF BulkHeader."Free Supply" THEN
              SalesHead."Free Supply" := TRUE;
            BulkLine.CALCFIELDS(Location);
            SalesHead.INSERT(TRUE);
            IF BulkLine.Location <> '' THEN BEGIN
              SalesHead.VALIDATE("Location Code",BulkLine.Location);
              SalesHead.Modify();
            END;
            SalesLine.INIT();
            SalesLine."Document Type" := SalesHead."Document Type";
            SalesLine."Document No." := SalesHead."No.";
            SalesLine."Line No." := SalesLine."Line No." + 10000;
            SalesLine.VALIDATE("Sell-to Customer No.",SalesHead."Sell-to Customer No.");
            SalesLine.Type := SalesLine.Type::Item;
            SalesLine.VALIDATE("No.",BulkLine."Item No");
            SalesLine.Description := BulkLine.Description;
            SalesLine.Quantity := BulkLine.Quantity;
            SalesLine.VALIDATE(Quantity,BulkLine.Quantity);
            SalesLine."Unit of Measure" := BulkLine.UOM;
            SalesLine."Unit Price" := BulkLine."Unit Price";
            SalesLine."Line Amount" := BulkLine."Line Amount";
            SalesLine.INSERT(TRUE);
            SalesPost.RUN(SalesHead);
          UNTIL BulkLine.NEXT() = 0;
        IF BulkHeader.GET("IssueNo.") THEN BEGIN
          BulkHeader.Posted := TRUE;
          BulkHeader.Modify();
        END;
        //Code Added for Sale Document Insert & Post::CSPL-00114::20022019: End;
        */

    end;

    procedure IssueLineInsertCS("IssNo.": Code[20]; IssDate: Date; "StudNo.": Code[20]; Name: Text[100]; "ItmNo.": Code[20]; Qty: Integer)
    begin
        /*
        //Code Added for Insert Bulk Line::CSPL-00114::20022019: Start
        BulkLine."Document No." := "IssNo.";
        BulkLine."Issue Date" := IssDate;
        BulkLine."Line No." += 10000;
        BulkLine."Serial No" += 1;
        BulkLine."Student No." := "StudNo.";
        BulkLine."Student Name" := Name;
        BulkLine.Type := BulkLine.Type::Item;
        BulkLine."Item No" := "ItmNo.";
        BulkLine.VALIDATE("Item No");
        BulkLine.Quantity := Qty;
        BulkLine."Line Amount" := BulkHeader.Quantity * BulkLine."Unit Price";
        BulkLine.VALIDATE(Quantity);
        BulkLine.INSERT();
        //Code Added for Insert Bulk Line::CSPL-00114::20022019: End
        */

    end;

    procedure BulkStationeryLinePostCS("IssueNo.": Code[20])
    begin
        /*
        //Code Added for Insert Bulk Stationery Line & Post::CSPL-00114::20022019: Start
        "SetLineNo." := 0;
        BulkStationeryHeader.GET("IssueNo.");
        BulkStationeryHeader.TESTFIELD("Indent No");
        BulkStationeryHeader.TESTFIELD("Issue Date");
        BulkStationeryHeader.TESTFIELD(Course);
        BulkStationeryHeader.TESTFIELD(Semester);
        BulkStationeryHeader.TESTFIELD("Academic Year");
        BulkIssues.Reset();
        BulkIssues.SETRANGE("Document No.","IssueNo.");
        IF BulkIssues.FINDSET()THEN
          REPEAT
            BulkIssues.TESTFIELD(Quantity);
            StudentCOLLEGE.Reset();
            StudentCOLLEGE.SETCURRENTKEY("Course Code",Semester,"Academic Year");
            StudentCOLLEGE.SETRANGE("Course Code",BulkStationeryHeader.Course);
            StudentCOLLEGE.SETRANGE(Semester,BulkStationeryHeader.Semester);
            StudentCOLLEGE.SETRANGE("Academic Year",BulkStationeryHeader."Academic Year");
            StudentCOLLEGE.SETRANGE(Section,BulkStationeryHeader.Section);
            StudentCOLLEGE.SETRANGE("Student Status",StudentCOLLEGE."Student Status"::Student);
            IF StudentCOLLEGE.FINDSET()THEN
              REPEAT
                "SetLineNo." := "SetLineNo." + 10000;
                "Insert Bulk Stationery Line"(BulkStationeryHeader."No.",BulkStationeryHeader."Issue Date",
                  StudentCOLLEGE."No.",StudentCOLLEGE."Student Name",BulkIssues."Item No",BulkIssues.Quantity,"SetLineNo.");
              UNTIL StudentCOLLEGE.NEXT() = 0;
          UNTIL BulkIssues.NEXT() = 0
        ELSE
          ERROR(Text000Lbl);
        //Code Added for Insert Bulk Stationery Line & Post::CSPL-00114::20022019: End
        */

    end;

    procedure InsertBulkStationeryLineCS("getIssueNo.": Code[20]; getIssueDate: Date; "getStudentNo.": Code[20]; getName: Text[100]; "getItemNo.": Code[20]; getQuantity: Integer; "getLineNo.": Integer)
    begin
        /*
        //Code Added for Insert Bulk Stationery Line::CSPL-00114::20022019: Start
        BulkStationeryLine.INIT();
        BulkStationeryLine."Document No." := "getIssueNo.";
        BulkStationeryLine."Line No." := "getLineNo.";
        BulkStationeryLine."Student No." := "getStudentNo.";
        BulkStationeryLine."Student Name" := getName;
        BulkStationeryLine.Type := BulkStationeryLine.Type::Item;
        BulkStationeryLine."Item No" := "getItemNo.";
        BulkStationeryLine.VALIDATE("Item No");
        BulkStationeryLine.Quantity := getQuantity;
        BulkStationeryLine."Line Amount" := BulkStationeryLine.Quantity * BulkStationeryLine."Unit Price";
        BulkStationeryLine.VALIDATE(Quantity);
        BulkStationeryLine.INSERT();
        //Code Added for Insert Bulk Stationery Line::CSPL-00114::20022019: End
        */

    end;

    procedure PostBulkStationeryItemsCS("IssueNo.": Code[20])
    begin
        /*
        //Code Added for Post Bulk Stationery Items::CSPL-00114::20022019: Start
        BulkStationeryLine.Reset();
        BulkStationeryHeader.GET("IssueNo.");
        
        StoresSetup.GET();
        StoresSetup.TESTFIELD("Fee Code");
        BulkStationeryLine.SETRANGE("Document No.","IssueNo.");
        IF BulkStationeryLine.ISEMPTY() then
          ERROR(Text001Lbl);
        IF BulkStationeryLine.FINDSET()THEN
          REPEAT
            SalesHead.INIT();
            SalesHead."Document Type" := SalesHead."Document Type"::Order;
            SalesHead."No." := '';
            SalesHead."Document Date" := TODAY();
            SalesHead."Posting Date" := BulkStationeryLine."Issue Date";
            SalesHead.VALIDATE("Sell-to Customer No.",BulkStationeryLine."Student No.");
            SalesHead."External Document No." := BulkStationeryLine."Document No.";
            SalesHead."Due Date" := TODAY();
            SalesHead."Order Date" := BulkStationeryLine."Issue Date";
            SalesHead."Fee Code" := StoresSetup."Fee Code";
            SalesHead.Ship := TRUE;
            SalesHead.Invoice := TRUE;
            IF BulkStationeryHeader."Free Supply" THEN
              SalesHead."Free Supply" := TRUE;
        
            BulkStationeryLine.CALCFIELDS(Location);
            SalesHead.INSERT(TRUE);
            IF BulkStationeryLine.Location <> '' THEN BEGIN
              SalesHead.VALIDATE("Location Code",BulkStationeryLine.Location);
              SalesHead.Modify();
            END;
            SalesLine.INIT();
            SalesLine."Document Type" := SalesHead."Document Type";
            SalesLine."Document No." := SalesHead."No.";
            SalesLine."Line No." := SalesLine."Line No." + 10000;
            SalesLine.VALIDATE("Sell-to Customer No.",SalesHead."Sell-to Customer No.");
            SalesLine.Type := SalesLine.Type::Item;
            SalesLine.VALIDATE("No.",BulkStationeryLine."Item No");
            SalesLine.Description := BulkStationeryLine.Description;
            SalesLine.Quantity := BulkStationeryLine.Quantity;
            SalesLine.VALIDATE(Quantity,BulkStationeryLine.Quantity);
            SalesLine."Unit of Measure" := BulkStationeryLine.UOM;
            SalesLine."Unit Price" := BulkStationeryLine."Unit Price";
            SalesLine."Line Amount" := BulkStationeryLine."Line Amount";
            SalesLine.INSERT(TRUE);
            SalesPost.RUN(SalesHead);
          UNTIL BulkStationeryLine.NEXT() = 0;
        
        IF BulkStationeryHeader.GET("IssueNo.") THEN BEGIN
          BulkStationeryHeader.Posted := TRUE;
          BulkStationeryHeader.Modify();
        END;
        //Code Added for Post Bulk Stationery Items::CSPL-00114::20022019: End
        */

    end;
}


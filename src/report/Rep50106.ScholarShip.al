Report 50106 "Scholarship"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            //DataItemTableView = WHERE("Student Status" = FILTER(Student));
            //RequestFilterFields = "Enrollment No.", "Academic Year", Semester, "Admitted Year";
            trigger OnPreDataItem()
            begin
                ScholarshipCount := 0;
                "Student Master-CS".SETRANGE("Global Dimension 1 Code", InstituteCode);
                IF AcademicYear <> '' THEN
                    "Student Master-CS".SETRANGE("Academic Year", AcademicYear);
                IF SemesterCode <> '' THEN
                    "Student Master-CS".SetFilter(Semester, SemesterCode);
                IF EnrollmentNo <> '' THEN
                    "Student Master-CS".SetFilter("Enrollment No.", EnrollmentNo);
            end;

            trigger OnAfterGetRecord()
            begin

                if "Student Master-CS".Status = '' then
                    CurrReport.Skip();
                StudentStatus.Get("Student Master-CS".Status, "Student Master-CS"."Global Dimension 1 Code");
                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                StudentStatus.Status::Suspension, StudentStatus.Status::Withdrawn, StudentStatus.Status::Dismissed,
                StudentStatus.Status::Deceased] then
                    CurrReport.Skip();

                CheckGenJournalLine("No.");
                CustomerRec2.Reset();
                if CustomerRec2.FindSet() then
                    CustomerRec2.DeleteAll();

                //Scholarship Generation-Start-------------------------------------------
                if ("Scholarship Source" <> '') then begin
                    if StudentMasterCS.CheckFeeGeneration("No.") = False then
                        error('Fee is not Generated or all components of fee is not Generated')
                    ELSE BEGIN
                        CLE.Reset();
                        // CLE.SETRANGE(CLE."Customer No.", Customer."No.");
                        CLE.SETRANGE(CLE."Customer No.", "Student Master-CS"."Original Student No.");
                        CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::"Credit Memo");
                        CLE.SETRANGE(CLE."Academic Year", "Academic Year");
                        CLE.SETRANGE(CLE.Year, Year);
                        ClE.SETRANGE(Semester, Semester);
                        CLE.SETRANGE("Waiver/Scholar/Grant Code", "Scholarship Source");
                        CLE.SETRANGE(CLE.Reversed, FALSE);
                        CLE.SetRange("Enrollment No.", "Enrollment No.");
                        IF not CLE.FINDFIRST() THEN begin
                            ScholarshipHeaderCS.Reset();
                            ScholarshipHeaderCS.SETRANGE("Source Code", "Scholarship Source");
                            ScholarshipHeaderCS.SETRANGE("Admitted Year", "Admitted Year");
                            ScholarshipHeaderCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                            IF ScholarshipHeaderCS.FINDFIRST() THEN BEGIN
                                if ScholarshipHeaderCS."SAP Code" = '' then
                                    Error('SAP Code must not be blank for Scholarship Header No. %1', ScholarshipHeaderCS."No.");
                                ScholarshipLineCS.Reset();
                                ScholarshipLineCS.SETRANGE(ScholarshipLineCS."Document No.", ScholarshipHeaderCS."No.");
                                ScholarshipLineCS.SETRANGE(Semester, Semester);
                                IF ScholarshipLineCS.FINDFIRST() THEN begin
                                    Flag := ScholarshipGeneration("No.", ScholarshipLineCS."Amount To Pay", ScholarshipHeaderCS."G/L Account No.",
                                     ScholarshipHeaderCS."Source Code", ScholarshipHeaderCS."Source Name", ScholarshipHeaderCS."SAP Code");
                                    if Flag = true then
                                        ScholarshipCount += 1;
                                end else
                                    Error('There is no setup within the filter Scholarship No %1 & Semester %2', ScholarshipHeaderCS."No.", Semester);
                            end else
                                Error('There is no setup within the filter Scholarship Code %1 , Admitted Year %2 & Institute Code %3',
                                        "Scholarship Source", "Admitted Year", "Global Dimension 1 Code");
                        end;
                    end;
                end;
                //-------------------------------------------Scholarship Generation-End

                // Grant Start
                if "Grant Code 1" <> '' then
                    GrantCalc("Grant Code 1", "Student Master-CS");
                if "Grant Code 2" <> '' then
                    GrantCalc("Grant Code 2", "Student Master-CS");
                if "Grant Code 3" <> '' then
                    GrantCalc("Grant Code 3", "Student Master-CS");
                // Grant End
            end;

            trigger OnPostDataItem()
            var
                GenJournalBatch: Record "Gen. Journal Batch";
                GenJnlManagement: Codeunit GenJnlManagement;
            begin
                FeeSetupRec.Reset();
                FeeSetupRec.SetRange("Global Dimension 1 Code", InstituteCode);
                if FeeSetupRec.FindFirst() then;
                if ScholarshipCount > 0 then begin
                    if Confirm('Scholarship Generated, Do you want Open General Journal', false) then begin
                        GenJournalBatch.RESET();
                        GenJournalBatch.SETRANGE("Journal Template Name", FeeSetupRec."ScholarShip Template Name");
                        GenJournalBatch.SETRANGE(Name, FeeSetupRec."ScholarShip Batch Name");
                        IF GenJournalBatch.FindFirst() then
                            GenJnlManagement.TemplateSelectionFromBatch(GenJournalBatch);
                    end;
                end else
                    Message('Scholarship is not Generated');
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Global Dimension 1 Code"; InstituteCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Institue Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field("Academic Year"; AcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        ToolTip = 'Academic Year may have a value';
                        TableRelation = "Academic Year Master-CS";

                    }
                    field("Semester Code"; SemesterCode)
                    {
                        ApplicationArea = ALL;
                        TableRelation = "Semester Master-CS".code;
                        Caption = 'Semester';
                        ToolTip = 'Semester may have a value';
                    }
                    field("Enrollment No"; EnrollmentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Enrollment No.';
                        ToolTip = 'Enrollment No. may have a value';
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            StudentMasterCS.Reset();
                            StudentMasterCS.findset();
                            IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                                EnrollmentNo := StudentMasterCS."Enrollment No.";
                        end;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        IF (InstituteCode = '') THEN
            ERROR('Institue Code must have a value in it');
    end;

    var
        CLE: Record "Cust. Ledger Entry";
        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        ScholarshipHeaderCS: Record "Scholarship Header-CS";
        ScholarshipLineCS: Record "Scholarship Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
        FeeComponentMasterCS: Record "Fee Component Master-CS";

        CustomerRec2: Record Customer temporary;
        FeeSetupRec: Record "Fee Setup-CS";
        InstituteCode: Code[20];
        AcademicYear: Code[20];
        SemesterCode: Code[1000];
        EnrollmentNo: Code[2048];
        Amount2: Decimal;
        Amount3: Decimal;
        ScholarshipCount: Integer;
        Flag: Boolean;

    procedure ScholarshipGeneration(StudNo: Code[20]; Amount: Decimal; BalAccountNo: Code[20]; SourceCode: Code[20]; SourceDesc: text[50]; SapCode: Code[20]): Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine1: Record "Gen. Journal Line";
        //   GenJournalBatch: Record "Gen. Journal Batch";
        FeeSetupCS: Record "Fee Setup-CS";
        // CustRec: Record "Customer";
        Stud: Record "Student Master-CS";
        SapRec: Record "SAP Fee Code";
        NoSeries: Codeunit "NoSeriesManagement";
        LineNo: Integer;
        DocumentNo: Code[20];
    begin
        // CustRec.GET(CustNo);
        Stud.Get(StudNo);
        FeeSetupCS.Reset();
        FeeSetupCS.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        IF FeeSetupCS.FindFirst() then begin
            FeeSetupCS.TESTFIELD(FeeSetupCS."ScholarShip Template Name");
            FeeSetupCS.TESTFIELD(FeeSetupCS."ScholarShip Batch Name");
            // GenJournalLine.Reset();
            // GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."ScholarShip Template Name");
            // GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."ScholarShip Batch Name");
            // IF GenJournalLine.FINDLAST() THEN
            //     DocumentNo := INCSTR(GenJournalLine."Document No.")
            // ELSE begin
            //     GenJournalBatch.RESET();
            //     GenJournalBatch.SETRANGE("Journal Template Name", FeeSetupCS."ScholarShip Template Name");
            //     GenJournalBatch.SETRANGE(Name, FeeSetupCS."ScholarShip Batch Name");
            //     IF GenJournalBatch.FINDFIRST() THEN;
            //     DocumentNo := NoSeries.GetNextNo(GenJournalBatch."No. Series", 0D, false);
            // end;
            DocumentNo := NoSeries.GetNextNo(FeeSetupCS."Fee Discount No.", 0D, TRUE);
        End;

        LineNo := 0;
        GenJournalLine1.Reset();
        GenJournalLine1.SETRANGE(GenJournalLine1."Journal Template Name", FeeSetupCS."ScholarShip Template Name");
        GenJournalLine1.SETRANGE(GenJournalLine1."Journal Batch Name", FeeSetupCS."ScholarShip Batch Name");
        IF GenJournalLine1.FINDLAST() THEN
            LineNo := GenJournalLine1."Line No." + 10000
        ELSE
            LineNo := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", FeeSetupCS."ScholarShip Template Name");
        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", FeeSetupCS."ScholarShip Batch Name");
        GenJournalLine.VALIDATE(GenJournalLine."Line No.", LineNo);
        GenJournalLine.VALIDATE(GenJournalLine."Posting Date", WORKDATE());
        GenJournalLine.VALIDATE(GenJournalLine."Document Type", GenJournalLine."Document Type"::"Credit Memo");
        GenJournalLine.VALIDATE(GenJournalLine."Document No.", DocumentNo);
        GenJournalLine.VALIDATE(GenJournalLine."Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE(GenJournalLine."Account No.", BalAccountNo);
        GenJournalLine.VALIDATE(GenJournalLine."Debit Amount", Amount);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", Stud."Original Student No.");

        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code", Stud."Global Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code", Stud."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code", Stud."Currency Code");
        GenJournalLine.VALIDATE(GenJournalLine.Year, Stud.Year);
        GenJournalLine.VALIDATE(GenJournalLine.Course, Stud."Course Code");
        GenJournalLine.VALIDATE(GenJournalLine."Academic Year", Stud."Academic Year");
        GenJournalLine.VALIDATE(GenJournalLine."Admitted Year", Stud."Admitted Year");
        GenJournalLine.Description := Stud."Student Name";
        GenJournalLine."Waiver/Scholar/Grant Code" := SourceCode;
        GenJournalLine."Waiver/Scholar/Grant Desc" := SourceDesc;
        GenJournalLine.VALIDATE("Source Code", 'Scholarshp');
        SapRec.Reset();
        SapRec.SetRange("SAP Code", SapCode);
        if SapRec.FindFirst() then begin
            GenJournalLine."Fee Code" := SapRec."SAP Code";
            GenJournalLine."SAP Code" := SapRec."SAP Code";
            GenJournalLine."SAP G/L Account" := SapRec."SAP G/L Account";
            GenJournalLine."SAP Assignment Code" := SapRec."SAP Assignment Code";
            GenJournalLine."SAP Description" := SapRec."SAP Description";
            GenJournalLine."SAP Cost Centre" := SapRec."SAP Cost Centre";
            GenJournalLine."SAP Profit Centre" := SapRec."SAP Profit Centre";
            GenJournalLine."SAP Company Code" := SapRec."SAP Company Code";
            GenJournalLine."SAP Bus. Area" := SapRec."SAP Bus. Area";
            GenJournalLine."Fee Group" := SapRec."Fee Group";
        end;
        GenJournalLine.Validate("Enrollment No.", Stud."Enrollment No.");
        if GenJournalLine.INSERT(TRUE) then
            Exit(true);

    end;

    procedure FeeCourseHeader(StudNo: Code[20]) Amount1: Decimal;
    var

        Stud: Record "Student Master-CS";
    begin
        // CustomerRec.GET(CustNo);
        Stud.Get(StudNo);
        FeeCourseHeadCS.Reset();
        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Course Code", Stud."Course Code");
        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Other Fees", false);
        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Admitted Year", Stud."Admitted Year");
        FeeCourseHeadCS.SETRANGE(Semester, Stud.Semester);
        FeeCourseHeadCS.SETRANGE("Academic Year", Stud."Academic Year");
        IF FeeCourseHeadCS.findfirst() THEN BEGIN
            FeeCourseLineCS.Reset();
            FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
            IF FeeCourseLineCS.findfirst() THEN begin
                REPEAT
                    FeeComponentMasterCS.GET(FeeCourseLineCS."Fee Code");
                    IF FeeComponentMasterCS."Type Of Fee" = FeeComponentMasterCS."Type Of Fee"::TUITION then
                        Amount1 += FeeCourseLineCS.Amount;
                Until FeeCourseLineCS.Next() = 0;
            end;
        end;
    end;

    procedure FeeCourseHeaderInstituional(CustNo: Code[20]) Amount1: Decimal;
    var


        CourseMasterRec: Record "Course Master-CS";
    begin
        StudentMasterCS.Get(CustNo);
        // CustomerRec.GET(CustNo);
        CourseMasterRec.Get(StudentMasterCS."Course Code");
        FeeCourseHeadCS.Reset();
        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Course Code", StudentMasterCS."Course Code");
        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");
        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Other Fees", false);
        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Admitted Year", StudentMasterCS."Admitted Year");
        FeeCourseHeadCS.SETRANGE(Semester, StudentMasterCS.Semester);
        FeeCourseHeadCS.SETRANGE("Academic Year", StudentMasterCS."Academic Year");
        IF FeeCourseHeadCS.findfirst() THEN BEGIN
            FeeCourseLineCS.Reset();
            FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
            IF FeeCourseLineCS.findfirst() THEN begin
                REPEAT
                    FeeComponentMasterCS.GET(FeeCourseLineCS."Fee Code");
                    IF FeeComponentMasterCS."Fee Group" = FeeComponentMasterCS."Fee Group"::Institutional then begin
                        IF FeeComponentMasterCS."Type Of Fee" = FeeComponentMasterCS."Type Of Fee"::GHTSURCHRG then begin
                            if CourseMasterRec."Course Category" = CourseMasterRec."Course Category"::GHT then
                                Amount1 += FeeCourseLineCS.Amount;
                        end else
                            Amount1 += FeeCourseLineCS.Amount;
                    end;
                Until FeeCourseLineCS.Next() = 0;
            end;
        end;
    end;

    procedure CheckFeeGeneration(StudentNo: Code[20]): Boolean
    var
        GLEntry: Record "G/L Entry";

        StudentRec: Record "Student Master-CS";
        FeeCourseHead: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        CourseRec: Record "Course Master-CS";
        FeeCompMas: Record "Fee Component Master-CS";
        HousingApplication: Record "Housing Application";
        StudentRegistration: Record "Student Registration-CS";
        CourseMasterRec: Record "Course Master-CS";
        Count1: Integer;
        Count2: Integer;
    begin
        Count1 := 0;
        Count2 := 0;
        // CustRec.Get(StudentNo);
        StudentRec.Get(StudentNo);
        CourseMasterRec.Get(StudentRec."Course Code");

        FeeCourseHead.Reset();
        FeeCourseHead.SETRANGE(FeeCourseHead."Course Code", StudentRec."Course Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", StudentRec."Academic Year");
        FeeCourseHead.SETRANGE(FeeCourseHead."Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Other Fees", false);
        CourseRec.Get(StudentRec."Course Code");
        If CourseRec."Admitted Year Wise Fee" then
            FeeCourseHead.SETRANGE(FeeCourseHead."Admitted Year", StudentRec."Admitted Year");
        If CourseRec."Semester Wise Fee" then
            FeeCourseHead.SETRANGE(FeeCourseHead.Semester, StudentRec.Semester);
        FeeCourseHead.SETRANGE(Year, StudentRec.Year);
        IF FeeCourseHead.findfirst() THEN BEGIN
            FeeCourseLine.Reset();
            FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
            IF FeeCourseLine.findfirst() THEN
                REPEAT
                    FeeCompMas.GET(FeeCourseLine."Fee Code");

                    If FeeCompMas."Fee Category" = FeeCompMas."Fee Category"::Optional then begin
                        IF FeeCompMas."Type Of Fee" = FeeCompMas."Type Of Fee"::RENT then begin
                            HousingApplication.Reset();
                            HousingApplication.SetRange("Student No.", StudentRec."No.");
                            HousingApplication.SetRange("Academic Year", StudentRec."Academic Year");
                            HousingApplication.SetRange(Semester, StudentRec.Semester);
                            HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                            HousingApplication.SetRange("Global Dimension 2 Code", FeeCompMas."Global Dimension 2 Code");
                            If HousingApplication.FindLast() then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeCompMas."Type Of Fee" = FeeCompMas."Type Of Fee"::DAMAGEDEP then begin
                            HousingApplication.Reset();
                            HousingApplication.SetRange("Student No.", StudentRec."No.");
                            HousingApplication.SetRange("Academic Year", StudentRec."Academic Year");
                            HousingApplication.SetRange(Semester, StudentRec.Semester);
                            HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                            HousingApplication.SetRange("Global Dimension 2 Code", FeeCompMas."Global Dimension 2 Code");
                            If HousingApplication.FindLast() then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeCompMas."Type Of Fee" = FeeCompMas."Type Of Fee"::"BUS-SEMESTER" then begin
                            If StudentRec."Transport Allot" then
                                Count2 := Count2 + 1;
                        end;
                        IF FeeCompMas."Type Of Fee" = FeeCompMas."Type Of Fee"::GHTSURCHRG then begin
                            if CourseMasterRec."Course Category" = CourseMasterRec."Course Category"::GHT then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeCompMas."Type Of Fee" = FeeCompMas."Type Of Fee"::HEALTHINS then begin
                            StudentRegistration.Reset();
                            StudentRegistration.SetRange("Student No", StudentRec."No.");
                            StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year");
                            StudentRegistration.SetRange(Semester, StudentRec.Semester);
                            StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                            StudentRegistration.SetRange("Apply for Insurance", true);
                            IF StudentRegistration.FindFirst() Then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeCompMas."Type Of Fee" = FeeCompMas."Type Of Fee"::REPATINS then begin
                            StudentRegistration.Reset();
                            StudentRegistration.SetRange("Student No", StudentRec."No.");
                            StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year");
                            StudentRegistration.SetRange(Semester, StudentRec.Semester);
                            StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                            StudentRegistration.SetRange("Apply for Insurance", false);
                            IF StudentRegistration.FindFirst() Then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeCompMas."Type Of Fee" = FeeCompMas."Type Of Fee"::"INSTALMENT FEE" then begin
                            If StudentRec."Payment Plan Applied" = true then
                                Count2 := Count2 + 1;
                        end;
                    end Else
                        Count2 := Count2 + 1;

                    GLEntry.Reset();
                    GLEntry.SETRANGE("Enrollment No.", StudentRec."Enrollment No.");
                    GLEntry.SETRANGE("Academic Year", StudentRec."Academic Year");
                    GLEntry.SETRANGE(Year, StudentRec.Year);
                    GLEntry.SETRANGE(Semester, StudentRec.Semester);
                    GLEntry.SETRANGE(Reversed, false);
                    GLEntry.SETRANGE("Fee Code", FeeCourseLine."Fee Code");
                    GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Invoice);
                    IF GLEntry.findfirst() THEN
                        Count1 := Count1 + 1;

                until FeeCourseLine.Next() = 0;
        end;

        If Count1 = Count2 then
            exit(true)
        else
            exit(false);

    End;

    procedure CheckGenJournalLine(StudNo: Code[20])
    var
        FeeSetupCS1: Record "Fee Setup-CS";
        Stud: Record "Student Master-CS";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        Stud.Get(StudNo);
        FeeSetupCS1.Reset();
        FeeSetupCS1.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        IF FeeSetupCS1.FindFirst() then;

        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", FeeSetupCS1."ScholarShip Template Name");
        GenJournalLine.SetRange("Journal Batch Name", FeeSetupCS1."ScholarShip Batch Name");
        GenJournalLine.SETRANGE("Document Type", GenJournalLine."Document Type"::"Credit Memo");
        GenJournalLine.SETRANGE("Enrollment No.", Stud."Enrollment No.");
        GenJournalLine.SETRANGE("Academic Year", Stud."Academic Year");
        GenJournalLine.SETRANGE(Semester, Stud.Semester);
        if GenJournalLine.FindFirst() then
            GenJournalLine.DeleteAll();
    end;

    //New Grant Calculation Start
    //procedure GrantCalc(GrantSeq: Option Grant1,Grant2,Graant3; GrantNo: Code[10])
    procedure GrantCalc(GrantNo: Code[10]; Stud: Record "Student Master-CS")
    var
        Stud2: Record "Student Master-CS";
    begin
        if Stud.CheckFeeGeneration(Stud."No.") = False then
            error('Fee is not Generated or all components of fee is not Generated')
        ELSE BEGIN
            CLE.Reset();
            CLE.SETRANGE("Customer No.", Stud."No.");
            CLE.SETRANGE("Document Type", CLE."Document Type"::"Credit Memo");
            CLE.SETRANGE("Academic Year", Stud."Academic Year");
            CLE.SETRANGE(Year, Stud.Year);
            ClE.SETRANGE(Semester, Stud.Semester);
            CLE.SetRange("Enrollment No.", Stud."Enrollment No.");
            CLE.SETRANGE("Waiver/Scholar/Grant Code", GrantNo);
            CLE.SETRANGE(Reversed, FALSE);
            IF not CLE.FINDFIRST() THEN begin
                ScholarshipHeaderCS.Reset();
                ScholarshipHeaderCS.SETRANGE("Source Code", GrantNo);
                ScholarshipHeaderCS.SETRANGE("Admitted Year", Stud."Admitted Year");
                ScholarshipHeaderCS.SETRANGE("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                ScholarshipHeaderCS.SETFILTER("Grant Criteria", '%1', ScholarshipHeaderCS."Grant Criteria"::"Sibling/Spouse");
                IF ScholarshipHeaderCS.FINDFIRST() THEN BEGIN
                    if ScholarshipHeaderCS."SAP Code" = '' then
                        Error('SAP Code must not be blank for Scholarship Header No. %1', ScholarshipHeaderCS."No.");
                    ScholarshipLineCS.Reset();
                    ScholarshipLineCS.SETRANGE(ScholarshipLineCS."Document No.", ScholarshipHeaderCS."No.");
                    ScholarshipLineCS.SETRANGE(Semester, Stud.Semester);
                    IF ScholarshipLineCS.FINDFIRST() THEN BEGIN
                        Amount2 := FeeCourseHeader(Stud."No.");
                        if Stud."Sibling/Spouse No." <> '' then begin
                            Stud2.Reset();
                            Stud2.SetRange("No.", '<>%1', Stud."No.");
                            Stud2.SetRange("Sibling/Spouse No.", Stud."Sibling/Spouse No.");
                            if Stud2.FindSet() then
                                // CustomerRec1.Reset();
                                // CustomerRec1.Setfilter(CustomerRec1."No.", '<>%1', Customer."No.");
                                // CustomerRec1.SetRange(CustomerRec1."Sibling/Spouse No.", Customer."Sibling/Spouse No.");
                                // if CustomerRec1.FindSet() then
                                repeat
                                    Amount3 := FeeCourseHeader(Stud2."No.");
                                    CustomerRec2.Init();
                                    CustomerRec2."No." := Stud2."No.";
                                    CustomerRec2.Amount := Amount3;
                                    CustomerRec2.Insert();
                                Until Stud2.Next() = 0;

                            // CustomerRec1.Reset();
                            // CustomerRec1.SetRange(CustomerRec1."No.", Customer."Sibling/Spouse No.");
                            // if CustomerRec1.FindFirst() then begin
                            Stud2.Reset();
                            Stud2.SetRange("No.", Stud."No.");
                            if Stud2.FindFirst() then begin
                                Amount3 := FeeCourseHeader(Stud2."No.");
                                CustomerRec2.Init();
                                CustomerRec2."No." := Stud2."No.";
                                CustomerRec2.Amount := Amount3;
                                CustomerRec2.Insert();
                            end;

                            CustomerRec2.Reset();
                            CustomerRec2.SetCurrentKey(CustomerRec2.Amount);
                            if CustomerRec2.FindFirst() then begin
                                if (Amount2 < CustomerRec2.Amount) then begin
                                    Amount3 := 0;
                                    Amount3 := Round(((Amount2 * ScholarshipLineCS."Percentage To Pay") / 100), 0.01, '=');
                                    flag := ScholarshipGeneration(Stud."No.", Amount3, ScholarshipHeaderCS."G/L Account No.",
                                     ScholarshipHeaderCS."Source Code", ScholarshipHeaderCS."Source Name", ScholarshipHeaderCS."SAP Code");
                                    if Flag = true then
                                        ScholarshipCount += 1;
                                end;
                                if (Amount2 = CustomerRec2.Amount) then begin
                                    Amount3 := 0;
                                    Amount3 := Round(((Amount2 * ScholarshipLineCS."Alternative Percentage to Pay") / 100), 0.01, '=');
                                    Flag := ScholarshipGeneration(Stud."No.", Amount3, ScholarshipHeaderCS."G/L Account No.",
                                     ScholarshipHeaderCS."Source Code", ScholarshipHeaderCS."Source Name", ScholarshipHeaderCS."SAP Code");
                                    if Flag = true then
                                        ScholarshipCount += 1;
                                end;
                            end;
                        end else begin
                            // CustomerRec1.Reset();
                            // CustomerRec1.SetRange(CustomerRec1."Sibling/Spouse No.", Customer."No.");
                            // if CustomerRec1.FindSet() then
                            Stud2.Reset();
                            Stud2.SetRange("Sibling/Spouse No.", stud."No.");
                            if stud2.FindSet() then
                                repeat
                                    Amount3 := FeeCourseHeader(Stud2."No.");
                                    CustomerRec2.Init();
                                    CustomerRec2."No." := Stud2."No.";
                                    CustomerRec2.Amount := Amount3;
                                    CustomerRec2.Insert();
                                Until Stud2.Next() = 0;

                            CustomerRec2.Reset();
                            CustomerRec2.SetCurrentKey(CustomerRec2.Amount);
                            if CustomerRec2.FindFirst() then begin
                                if (Amount2 < CustomerRec2.Amount) then begin
                                    Amount3 := 0;
                                    Amount3 := Round(((Amount2 * ScholarshipLineCS."Percentage To Pay") / 100), 0.01, '=');
                                    Flag := ScholarshipGeneration(Stud."No.", Amount3, ScholarshipHeaderCS."G/L Account No.",
                                     ScholarshipHeaderCS."Source Code", ScholarshipHeaderCS."Source Name", ScholarshipHeaderCS."SAP Code");
                                    if Flag = true then
                                        ScholarshipCount += 1;
                                end;
                                if (Amount2 = CustomerRec2.Amount) then begin
                                    Amount3 := 0;
                                    Amount3 := Round(((Amount2 * ScholarshipLineCS."Alternative Percentage to Pay") / 100), 0.01, '=');
                                    Flag := ScholarshipGeneration(Stud."No.", Amount3, ScholarshipHeaderCS."G/L Account No.",
                                     ScholarshipHeaderCS."Source Code", ScholarshipHeaderCS."Source Name", ScholarshipHeaderCS."SAP Code");
                                    if Flag = true then
                                        ScholarshipCount += 1;
                                end;
                            end;

                        end;
                    end else
                        Error('There is no setup within the filter Scholarship No %1 & Semester %2', ScholarshipHeaderCS."No.", Stud.Semester);

                end;

                ScholarshipHeaderCS.Reset();
                ScholarshipHeaderCS.SETRANGE("Source Code", GrantNo);
                ScholarshipHeaderCS.SETRANGE("Admitted Year", Stud."Admitted Year");
                ScholarshipHeaderCS.SETRANGE("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                ScholarshipHeaderCS.SETFILTER("Grant Criteria", '%1|%2', ScholarshipHeaderCS."Grant Criteria"::Antiguan,
                                              ScholarshipHeaderCS."Grant Criteria"::Montserrat);
                IF ScholarshipHeaderCS.FINDFIRST() THEN BEGIN
                    if ScholarshipHeaderCS."SAP Code" = '' then
                        Error('SAP Code must not be blank for Scholarship Header No. %1', ScholarshipHeaderCS."No.");
                    ScholarshipLineCS.Reset();
                    ScholarshipLineCS.SETRANGE(ScholarshipLineCS."Document No.", ScholarshipHeaderCS."No.");
                    ScholarshipLineCS.SETRANGE(Semester, Stud.Semester);
                    IF ScholarshipLineCS.FINDFIRST() THEN BEGIN
                        Amount2 := FeeCourseHeaderInstituional(Stud."No.");
                        Amount3 := 0;
                        Amount3 := Round(((Amount2 * ScholarshipLineCS."Percentage to Pay") / 100), 0.01, '=');
                        Flag := ScholarshipGeneration(Stud."No.", Amount3, ScholarshipHeaderCS."G/L Account No.",
                         ScholarshipHeaderCS."Source Code", ScholarshipHeaderCS."Source Name", ScholarshipHeaderCS."SAP Code");
                        if Flag = true then
                            ScholarshipCount += 1;
                    end else
                        Error('There is no setup within the filter Scholarship No %1 & Semester %2', ScholarshipHeaderCS."No.", Stud.Semester);
                end;

                ScholarshipHeaderCS.Reset();
                ScholarshipHeaderCS.SETRANGE("Source Code", GrantNo);
                ScholarshipHeaderCS.SETRANGE("Admitted Year", Stud."Admitted Year");
                ScholarshipHeaderCS.SETRANGE("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                ScholarshipHeaderCS.SETFILTER("Grant Criteria", '%1', ScholarshipHeaderCS."Grant Criteria"::" ");
                IF ScholarshipHeaderCS.FINDFIRST() THEN BEGIN
                    if ScholarshipHeaderCS."SAP Code" = '' then
                        Error('SAP Code must not be blank for Scholarship Header No. %1', ScholarshipHeaderCS."No.");
                    ScholarshipLineCS.Reset();
                    ScholarshipLineCS.SETRANGE(ScholarshipLineCS."Document No.", ScholarshipHeaderCS."No.");
                    ScholarshipLineCS.SETRANGE(Semester, Stud.Semester);
                    IF ScholarshipLineCS.FINDFIRST() THEN begin
                        Flag := ScholarshipGeneration(Stud."No.", ScholarshipLineCS."Amount To Pay", ScholarshipHeaderCS."G/L Account No.",
                         ScholarshipHeaderCS."Source Code", ScholarshipHeaderCS."Source Name", ScholarshipHeaderCS."SAP Code");
                        if Flag = true then
                            ScholarshipCount += 1;
                    end else
                        Error('There is no setup within the filter Scholarship No %1 & Semester %2', ScholarshipHeaderCS."No.", Stud.Semester);
                end;
            end;
        end;

    end;
    //New Grant Calculation End


}
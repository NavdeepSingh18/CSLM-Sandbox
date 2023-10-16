report 50219 "FinancialAidReports"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Financial Aid Report';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = where("Course Code" = Filter('AUACOM | AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL|SEMCOM|SEMCOM2|STDPROG|TRICOM'));
            RequestFilterFields = "Course Code", Semester, "Academic Year", Status;
            trigger OnPreDataItem()
            var
                PrevAcademicYear: Code[20];
                PrevAcademicYearInt: Integer;
                PrevTerm: Option FALL,SPRING,SUMMER;
            begin

                "Student Master-CS".SetCurrentKey("Original Student No.", "Enrollment Order");
                "Student Master-CS".Ascending(False);

                TempExcelBuffer.AddColumn('Student Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('LastName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FirstName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('School Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA Semester', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Registrar Semester', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Registered', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Received FAFSA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('In SFP', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Last Date of SAFI Sent', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Current Billing', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('AR Balance', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Award #1 Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Award #2 Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Award #3 Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                EducationSetup.Reset();
                //EducationSetup.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                IF EducationSetup.FindLast() then begin
                    IF EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::SPRING then begin
                        Evaluate(PrevAcademicYearInt, EducationSetup."Academic Year");
                        PrevAcademicYear := Format(PrevAcademicYearInt - 1);
                        PrevTerm := PrevTerm::FALL;
                    end;
                    IF EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::FALL then begin
                        PrevAcademicYear := EducationSetup."Academic Year";
                        PrevTerm := PrevTerm::SPRING;
                    end;

                    TempExcelBuffer.AddColumn(Format(PrevTerm) + ' ' + PrevAcademicYear + ' FA Pmt #1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(PrevTerm) + ' ' + PrevAcademicYear + ' FA Pmt #2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(PrevTerm) + ' ' + PrevAcademicYear + ' FA Pmt #3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(Format(PrevTerm) + ' ' + PrevAcademicYear + ' FA Pmt #4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(Format(PrevTerm) + ' ' + PrevAcademicYear + ' FA Pmt #5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(Format(PrevTerm) + ' ' + PrevAcademicYear + ' FA Pmt #6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(EducationSetup."Even/Odd Semester") + ' ' + EducationSetup."Academic Year" + ' FA Pmt #1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(EducationSetup."Even/Odd Semester") + ' ' + EducationSetup."Academic Year" + ' FA Pmt #2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(EducationSetup."Even/Odd Semester") + ' ' + EducationSetup."Academic Year" + ' FA Pmt #3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(Format(EducationSetup."Even/Odd Semester") + ' ' + EducationSetup."Academic Year" + ' FA Pmt #4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(Format(EducationSetup."Even/Odd Semester") + ' ' + EducationSetup."Academic Year" + ' FA Pmt #5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    // TempExcelBuffer.AddColumn(Format(EducationSetup."Even/Odd Semester") + ' ' + EducationSetup."Academic Year" + ' FA Pmt #6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    StartYear := DATE2DMY(TODAY, 3);



                end;
                totalcount := "Student Master-CS".Count();
                if GuiAllowed then
                    WindowDialog.Open('Fetching Data....\' + Text001Lbl);
            end;

            trigger OnAfterGetRecord()
            var
                StudentSubjectExam: Record "Student Subject Exam";
                StudentSubjectExam1: Record "Student Subject Exam";
                RecCustPostGroup: Record "Customer Posting Group";
                StudentSubj: record "Main Student Subject-CS";
                CustLedgerEntry: Record "Cust. Ledger Entry";
                CourseSemMasterCs: Record "Course Sem. Master-CS";
                CustLedgerEntry1: Record "Cust. Ledger Entry";
                Customer_lRec: Record Customer;
                CustomerPostingGroup: Record "Customer Posting Group";
                GLEntry_lRec: Record "G/L Entry";
                SemesterMasterCS1: Record "Semester Master-CS";
                CourseMasterCs: Record "Course Master-CS";
                StudentMaster_lRec: Record "Student Master-CS";
                SourceScholarShip: Record "Source Scholarship-CS";
                i: Integer;
                ArAmount: Decimal;
                CurrBilAmt: Decimal;
                ScholarAmt: Decimal;
                GrantAmt: array[50] of Decimal;
                Amt_lDec: array[50] of Decimal;
                PrevAcademicYear: Code[20];
                PrevAcademicYearInt: Integer;
                PrevTerm: Option FALL,SPRING,SUMMER;
                FASEmester: Text;
                EnrollmentNoFilter: Text;
                CourseFilter: Text;
                ScholarShipFilter: Text;
                GrandCodeFilter: Text;
                GrandCodeFilter1: Text;
            begin
                IF OriginalStudentID <> "Student Master-CS"."Original Student No." then begin
                    CourseFilter := '';
                    CourseFilter := 'AUACOM | AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL|SEMCOM|SEMCOM2|STDPROG|TRICOM';
                    EnrollmentNoFilter := '';
                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetCurrentKey("Enrollment Order");
                    StudentMaster_lRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    StudentMaster_lRec.SetFilter("Course Code", CourseFilter);
                    IF StudentMaster_lRec.FindSet() then begin
                        repeat
                            If EnrollmentNoFilter = '' then
                                EnrollmentNoFilter := StudentMaster_lRec."Enrollment No."
                            Else
                                EnrollmentNoFilter += '|' + StudentMaster_lRec."Enrollment No.";
                        until StudentMaster_lRec.Next() = 0;
                    end;

                    ScholarShipFilter := '';
                    SourceScholarShip.Reset();
                    SourceScholarShip.SetRange("Discount Type", SourceScholarShip."Discount Type"::Scholarship);
                    SourceScholarShip.SetRange("Global Dimension 1 Code", '9000');
                    If SourceScholarShip.FindSet() then begin
                        repeat
                            If ScholarShipFilter = '' then
                                ScholarShipFilter := SourceScholarShip.Code
                            Else
                                ScholarShipFilter += '|' + SourceScholarShip.Code;
                        until SourceScholarShip.Next() = 0;
                    end;

                    GrandCodeFilter := '';
                    SourceScholarShip.Reset();
                    SourceScholarShip.SetRange("Discount Type", SourceScholarShip."Discount Type"::Grant);
                    SourceScholarShip.SetRange("Global Dimension 1 Code", '9000');
                    If SourceScholarShip.FindSet() then begin
                        repeat
                            If GrandCodeFilter = '' then
                                GrandCodeFilter := SourceScholarShip.Code
                            Else
                                GrandCodeFilter += '|' + SourceScholarShip.Code;
                        until SourceScholarShip.Next() = 0;
                    end;

                    Customer_lRec.Reset();
                    If Customer_lRec.get("Student Master-CS"."Original Student No.") then;
                    CustomerPostingGroup.Reset();
                    CustomerPostingGroup.SetRange(Code, Customer_lRec."Customer Posting Group");
                    If CustomerPostingGroup.FindFirst() then;

                    FASEmester := '';
                    IF "Student Master-CS"."FA Semester" <> '' then
                        FASEmester := "Student Master-CS"."FA Semester";

                    IF "Student Master-CS".Semester IN ['CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9'] then begin //  Clinical
                        IF (Today >= "Student Master-CS"."5 FA Start Date") AND (Today <= "Student Master-CS"."5 FA End Date") then
                            FASEmester := 'CLN5';
                        IF (Today >= "Student Master-CS"."6 FA Start Date") AND (Today <= "Student Master-CS"."6 FA End Date") then
                            FASEmester := 'CLN6';
                        IF (Today >= "Student Master-CS"."7 FA Start Date") AND (Today <= "Student Master-CS"."7 FA End Date") then
                            FASEmester := 'CLN7';
                        IF (Today >= "Student Master-CS"."8 FA Start Date") AND (Today <= "Student Master-CS"."8 FA End Date") then
                            FASEmester := 'CLN8';
                    end;


                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn("Student Master-CS"."Original Student No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FASEmester, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::text);
                    TempExcelBuffer.AddColumn("Student Master-CS".Semester, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."On Ground Check-In Complete On", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::date);
                    TempExcelBuffer.AddColumn(FormaT("Student Master-CS"."FAFSA Received"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::text);

                    IF "Student Master-CS"."Student SFP Initiation" = 0 Then
                        TempExcelBuffer.AddColumn(FALSE, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    ELSE
                        TempExcelBuffer.AddColumn(TRUE, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    TempExcelBuffer.AddColumn(FormaT("Student Master-CS"."Safi Sent"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);

                    //Current Billing
                    CurrBilAmt := 0;
                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetCurrentKey("Enrollment No.", "Posting Date", Reversed, "Document Type", "G/L Account No.");
                    // GLEntry_lRec.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    GLEntry_lRec.SetFilter("Enrollment No.", EnrollmentNoFilter);
                    GLEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    GLEntry_lRec.SetRange(Reversed, false);
                    GLEntry_lRec.Setfilter("Document Type", '%1|%2', GLEntry_lRec."Document Type"::Invoice, GLEntry_lRec."Document Type"::"Credit Memo");
                    GLEntry_lRec.Setrange("G/L Account No.", CustomerPostingGroup."Receivables Account");
                    GLEntry_lRec.CalcSums(Amount);
                    CurrBilAmt := GLEntry_lRec.Amount;
                    TempExcelBuffer.AddColumn(FormaT(CurrBilAmt), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);

                    //AR Balances
                    ArAmount := 0;
                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetCurrentKey("Enrollment No.", "Global Dimension 2 Code", Reversed, "Posting Date", "G/L Account No.");
                    // GLEntry_lRec.SetRange("Student No.", "Student Master-CS"."No.");
                    GLEntry_lRec.SetFilter("Enrollment No.", EnrollmentNoFilter);
                    GLEntry_lRec.SetRange("Global Dimension 2 Code", '');
                    GLEntry_lRec.SetRange(Reversed, false);
                    GLEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    GLEntry_lRec.Setrange("G/L Account No.", CustomerPostingGroup."Receivables Account");
                    GLEntry_lRec.CalcSums(Amount);
                    ArAmount := GLEntry_lRec.Amount;
                    TempExcelBuffer.AddColumn(FormaT(ArAmount), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);

                    //AwardAmount #2
                    Clear(GrantAmt);
                    i := 0;
                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetCurrentKey("Enrollment No.", "Posting Date", "Waiver/Scholar/Grant Code");
                    // GLEntry_lRec.SetRange(GLEntry_lRec."Student No.", "No.");
                    GLEntry_lRec.SetFilter("Enrollment No.", EnrollmentNoFilter);
                    GLEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    GLEntry_lRec.SetFilter("Waiver/Scholar/Grant Code", GrandCodeFilter);
                    GLEntry_lRec.SetRange("G/L Account No.", CustomerPostingGroup."Receivables Account");
                    IF GLEntry_lRec.FindSet() then begin
                        repeat
                            i += 1;
                            If i <= 2 then
                                GrantAmt[i] := GLEntry_lRec.Amount;
                        Until GLEntry_lRec.Next() = 0;
                    end;

                    TempExcelBuffer.AddColumn(FormaT(GrantAmt[1]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(FormaT(GrantAmt[2]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);

                    //AwardAmount #1
                    ScholarAmt := 0;
                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetCurrentKey("Enrollment No.", "Posting Date", "Waiver/Scholar/Grant Code");
                    // GLEntry_lRec.SetRange(GLEntry_lRec."Student No.", "No.");
                    GLEntry_lRec.SetFilter("Enrollment No.", EnrollmentNoFilter);
                    GLEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    GLEntry_lRec.Setfilter("Waiver/Scholar/Grant Code", ScholarShipFilter);
                    GLEntry_lRec.SetRange("G/L Account No.", CustomerPostingGroup."Receivables Account");
                    GLEntry_lRec.CalcSums(Amount);
                    ScholarAmt := GLEntry_lRec.Amount;
                    TempExcelBuffer.AddColumn(FormaT(ScholarAmt), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    IF EducationSetup.FindFirst() then begin
                        If EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::SPRING then begin
                            Evaluate(PrevAcademicYearInt, EducationSetup."Academic Year");
                            PrevAcademicYear := Format(PrevAcademicYearInt - 1);
                            PrevTerm := PrevTerm::FALL;
                        end;
                        IF EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::FALL then begin
                            PrevAcademicYear := EducationSetup."Academic Year";
                            PrevTerm := PrevTerm::SPRING;
                        end;

                        i := 1;
                        Clear(Amt_lDec);
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetCurrentKey("Customer No.", "Academic Year", Term);
                        CustLedgerEntry.SetRange("Customer No.", "Student Master-CS"."Original Student No.");
                        CustLedgerEntry.SetRange("Academic Year", PrevAcademicYear);
                        CustLedgerEntry.SetRange(Term, PrevTerm);
                        CustLedgerEntry.SetFilter(Description, '%1', '*FDSL*');
                        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Payment);
                        IF CustLedgerEntry.FindSet() then begin
                            repeat
                                IF i <= 3 then begin
                                    CustLedgerEntry.CalcFields(Amount);
                                    Amt_lDec[i] := CustLedgerEntry.Amount;
                                end;
                                i += 1;
                            until CustLedgerEntry.Next() = 0;
                        end;
                        TempExcelBuffer.AddColumn(FormaT(Amt_lDec[1]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FormaT(Amt_lDec[2]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FormaT(Amt_lDec[3]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        // TempExcelBuffer.AddColumn(FormaT(Amt_lDec[4]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        // TempExcelBuffer.AddColumn(FormaT(Amt_lDec[5]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        // TempExcelBuffer.AddColumn(FormaT(Amt_lDec[6]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);

                        i := 1;
                        Clear(Amt_lDec);
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetCurrentKey("Customer No.", "Academic Year", Term);
                        CustLedgerEntry.SetRange("Customer No.", "Student Master-CS"."Original Student No.");
                        CustLedgerEntry.SetRange("Academic Year", EducationSetup."Academic Year");
                        CustLedgerEntry.SetRange(Term, EducationSetup."Even/Odd Semester");
                        CustLedgerEntry.SetFilter(Description, '%1', '*FDSL*');
                        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Payment);
                        IF CustLedgerEntry.FindSet() then begin
                            repeat
                                If i <= 3 then begin
                                    CustLedgerEntry.CalcFields(Amount);
                                    Amt_lDec[i] := CustLedgerEntry.Amount;
                                end;
                                i += 1;
                            until CustLedgerEntry.Next() = 0;
                        end;

                        TempExcelBuffer.AddColumn(FormaT(Amt_lDec[1]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FormaT(Amt_lDec[2]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FormaT(Amt_lDec[3]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        // TempExcelBuffer.AddColumn(FormaT(Amt_lDec[4]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        // TempExcelBuffer.AddColumn(FormaT(Amt_lDec[5]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        // TempExcelBuffer.AddColumn(FormaT(Amt_lDec[6]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);

                    end;
                    OriginalStudentID := "Student Master-CS"."Original Student No.";
                    counter += 1;
                    if GuiAllowed then
                        WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(counter) + ' of ' + format(totalcount));
                end;

            end;

            trigger OnPostDataItem()
            begin
                IF GuiAllowed then
                    WindowDialog.Close();

                TempExcelBuffer.CreateNewBook(StudentList);
                TempExcelBuffer.WriteSheet(StudentList, CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, StartDate, EndDate));
                TempExcelBuffer.OpenExcel();



            end;
        }


    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Option")
                {
                    field("StartDate From"; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    field("StartDate To"; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';

                    }
                }
            }
        }

    }


    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        if StartDate = 0D then
            ERROR('Start Date must have a value');
        if EndDate = 0D then
            ERROR('End Date must have a value');
    end;


    var
        StudentSubExam: Record "Student Subject Exam";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StudentMasterCS: Record "Student Master-CS";
        EducationSetup: record "Education Setup-CS";
        ScoreType: Option " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK";
        AcademicYear: code[20];
        StudentList: Label 'Financial Aid Report';
        ExcelFileName: Label 'FinancialAidReport_%1_%2';
        Terms: Code[20];
        StartDate: Date;
        EndDate: Date;


        FallPayment: array[5] of Decimal;
        SprPayment: array[5] of Decimal;
        StartYear: Integer;
        LastYear: Integer;
        StartYearCode: Text[20];
        Awad: array[2] of Decimal;
        i: integer;
        f: Integer;
        GrandValue2: Decimal;
        GrandValue1: Decimal;
        GrandValue3: Decimal;

        PreValue: Integer;
        counter: Integer;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Students No.     ############1################\';
        totalcount: Integer;
        OriginalStudentID: Code[20];



}
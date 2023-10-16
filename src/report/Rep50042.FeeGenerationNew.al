report 50042 "Fee Generation New"
{
    Caption = 'Fee Generation';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {


            trigger OnPreDataItem()
            begin
                "Student Master-CS".SETRANGE("Global Dimension 1 Code", InstituteCode);
                "Student Master-CS".SETRANGE("Academic Year", AcademicYear);
                IF SemesterCode <> '' THEN
                    "Student Master-CS".SetFilter(Semester, SemesterCode);
                IF EnrollmentNo <> '' THEN
                    "Student Master-CS".SetFilter("Enrollment No.", EnrollmentNo);
            end;

            trigger OnAfterGetRecord()
            var
                StudentStatus: Record "Student Status";
            begin
                if "Student Master-CS".Status = '' then
                    CurrReport.Skip();
                StudentStatus.Get("Student Master-CS".Status, "Student Master-CS"."Global Dimension 1 Code");
                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                StudentStatus.Status::Suspension, StudentStatus.Status::Withdrawn, StudentStatus.Status::Dismissed,
                StudentStatus.Status::Deceased] then
                    CurrReport.Skip();

                IF ("Student Master-CS"."Financial Aid Approved" = False) AND ("Student Master-CS"."Payment Plan Applied" = False) AND ("Student Master-CS"."Self Payment Applied" = False) then
                    CurrReport.Skip();

                CourseMaster.Reset();
                CourseMaster.Get("Student Master-CS"."Course Code");

                FeeSetupCS.Reset();
                FeeSetupCS.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF FeeSetupCS.FindFirst() then;

                SQNo := 0;
                NextSemester := '';
                NextYear := '';
                NextYear := Year;
                FinalAmount1 := 0;
                RemainingAmt := 0;
                FAidBudgetAmt := 0;
                FAidRosterAmt := 0;
                If NextSemesterFeeGeneration = true Then begin
                    CourseSemMasterCS.Reset();
                    CourseSemMasterCS.SETCURRENTKEY("Semester Code");
                    CourseSemMasterCS.SETRANGE("Course Code", "Course Code");
                    CourseSemMasterCS.SETRANGE("Semester Code", Semester);
                    IF CourseSemMasterCS.FINDFIRST() THEN begin
                        SQNo := CourseSemMasterCS."Sequence No" + 1;
                    end;

                    IF SQNo <> 0 Then begin
                        CourseSemMasterCS.Reset();
                        CourseSemMasterCS.SETRANGE("Course Code", "Course Code");
                        CourseSemMasterCS.SetRange("Sequence No", SQNo);
                        IF CourseSemMasterCS.FindFirst() then
                            NextSemester := CourseSemMasterCS."Semester Code";
                    end;
                    SemesterMaster.Reset();
                    SemesterMaster.SetRange(Code, NextSemester);
                    IF SemesterMaster.FindFirst() then
                        NextYear := Format(SemesterMaster.Year);
                end;

                CheckGenJournalLineForFee("Student Master-CS"."No.");

                IF ("Student Master-CS"."Financial Aid Approved" = true) AND ("Student Master-CS"."Payment Plan Applied" = False) AND ("Student Master-CS"."Self Payment Applied" = false) then Begin
                    FAidRosterAmt := RosterCheck("Student Master-CS"."No.", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration);
                    If FAidRosterAmt <> 0 then
                        FAidBudgetAmt := FAidRosterAmt
                    Else
                        FAidBudgetAmt := FinancialAidBudgetCheck("Student Master-CS"."No.", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration);

                    IF (FAidRosterAmt = 0) AND (FAidBudgetAmt = 0) Then
                        Error('Financial Aid Roster & Budgeted Financial Aid Amount must be not Zero for Student No. %1', "Student Master-CS"."No.");

                    FinalAmount1 := StudentTotalFee("Student Master-CS"."No.", '', NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, SemFee, Grenville);

                    IF FinalAmount1 > FAidBudgetAmt then begin
                        RemainingAmt := FinalAmount1 - FAidBudgetAmt;
                        FAidBudgetAmtNew := FAidBudgetAmt;
                    end Else begin
                        FAidBudgetAmtNew := FinalAmount1;
                        RemainingAmt := 0;
                    end;

                    Count4 += FeeGenrationFinancialAid("Student Master-CS"."No.", FAidBudgetAmtNew, NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, True, False, False, TemplateName, BatchName);
                End;

                IF ("Student Master-CS"."Financial Aid Approved" = False) AND ("Student Master-CS"."Payment Plan Applied" = True) AND ("Student Master-CS"."Self Payment Applied" = False) then begin
                    TestField("Payment Plan Instalment");
                    Count4 += FeeGenrationPaymentPaln("No.", 0, NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, False, True, False, TemplateName, BatchName);
                end;

                IF ("Student Master-CS"."Financial Aid Approved" = False) AND ("Student Master-CS"."Payment Plan Applied" = False) AND ("Student Master-CS"."Self Payment Applied" = true) then
                    Count4 += FeeGenrationFinancialAid("No.", 0, NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, False, False, True, TemplateName, BatchName);


                IF ("Student Master-CS"."Financial Aid Approved" = True) AND ("Student Master-CS"."Payment Plan Applied" = False) AND ("Student Master-CS"."Self Payment Applied" = True) then begin

                    FAidRosterAmt := RosterCheck("Student Master-CS"."No.", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration);
                    If FAidRosterAmt <> 0 then
                        FAidBudgetAmt := FAidRosterAmt
                    Else
                        FAidBudgetAmt := FinancialAidBudgetCheck("Student Master-CS"."No.", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration);

                    IF (FAidRosterAmt = 0) AND (FAidBudgetAmt = 0) Then
                        Error('Financial Aid Roster & Budgeted Financial Aid Amount must not be 0(zero) for Student No. %1', "Student Master-CS"."No.");

                    FinalAmount1 := StudentTotalFee("Student Master-CS"."No.", '', NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, SemFee, Grenville);

                    IF FinalAmount1 > FAidBudgetAmt then begin
                        RemainingAmt := FinalAmount1 - FAidBudgetAmt;
                        FAidBudgetAmtNew := FAidBudgetAmt;
                    end Else begin
                        FAidBudgetAmtNew := FinalAmount1;
                        RemainingAmt := 0;
                    end;

                    Count4 += FeeGenrationFinancialAid("Student Master-CS"."No.", FAidBudgetAmtNew, NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, True, false, false, TemplateName, BatchName);
                    IF RemainingAmt <> 0 then
                        Count4 += FeeGenrationFinancialAid("Student Master-CS"."No.", RemainingAmt, NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, false, false, True, TemplateName, BatchName);

                end;

                IF ("Student Master-CS"."Financial Aid Approved" = True) AND ("Student Master-CS"."Payment Plan Applied" = True) AND ("Student Master-CS"."Self Payment Applied" = False) then begin
                    TestField("Payment Plan Instalment");

                    FAidRosterAmt := RosterCheck("Student Master-CS"."No.", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration);
                    If FAidRosterAmt <> 0 then
                        FAidBudgetAmt := FAidRosterAmt
                    Else
                        FAidBudgetAmt := FinancialAidBudgetCheck("Student Master-CS"."No.", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration);

                    IF (FAidRosterAmt = 0) AND (FAidBudgetAmt = 0) Then
                        Error('Financial Aid Roster & Budgeted Financial Aid Amount must be not Zero for Student No. %1', "Student Master-CS"."No.");

                    FinalAmount1 := StudentTotalFee("Student Master-CS"."No.", '', NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, SemFee, Grenville);

                    IF FinalAmount1 > FAidBudgetAmt then begin
                        RemainingAmt := FinalAmount1 - FAidBudgetAmt;
                        FAidBudgetAmtNew := FAidBudgetAmt;
                    end Else begin
                        FAidBudgetAmtNew := FinalAmount1;
                        RemainingAmt := 0;
                    end;

                    Count4 += FeeGenrationFinancialAid("Student Master-CS"."No.", FAidBudgetAmtNew, NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, True, false, false, TemplateName, BatchName);
                    IF RemainingAmt <> 0 then
                        Count4 += FeeGenrationPaymentPaln("Student Master-CS"."No.", RemainingAmt, NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration, false, True, false, TemplateName, BatchName);
                end;
                //SD-SN-18-Dec-2020 +
                CheckGenJournalLineForGd2("Student Master-CS"."No.");
                //SD-SN-18-Dec-2020 -
            end;

            trigger OnPostDataItem()
            var
                GenJournalBatch: Record "Gen. Journal Batch";
                GenJnlManagement: Codeunit GenJnlManagement;
            begin
                If AutoPosting = true then begin
                    GenJournalLinePost.Reset();
                    GenJournalLinePost.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
                    GenJournalLinePost.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
                    IF GenJournalLinePost.Findset() THEN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLinePost);

                    GenJournalLinePost.Reset();
                    GenJournalLinePost.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
                    GenJournalLinePost.SETRANGE("Journal Batch Name", FeeSetupCS."Payment Plan Batch Name");
                    IF GenJournalLinePost.Findset() THEN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLinePost);
                end Else begin
                    If Count4 > 0 then begin
                        IF CONFIRM('Fees Generated, do you want to open General Journal', FALSE) THEN begin
                            GenJournalBatch.RESET();
                            GenJournalBatch.SETRANGE("Journal Template Name", TemplateName);
                            GenJournalBatch.SETRANGE(Name, BatchName);
                            IF GenJournalBatch.FindFirst() then
                                GenJnlManagement.TemplateSelectionFromBatch(GenJournalBatch);
                        end;
                    end Else
                        Message('Fees Not Generated!');
                end;
            End;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                field("Institute Code"; InstituteCode)
                {
                    ApplicationArea = All;
                    Caption = 'Institute Code';
                    ToolTip = 'Institute Code must have a value';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                }
                field("Academic Year"; AcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    ToolTip = 'Academic Year must have a value';
                    TableRelation = "Academic Year Master-CS";

                }
                field("Semester Code"; SemesterCode)
                {
                    ApplicationArea = ALL;
                    TableRelation = "Semester Master-CS".code;
                    Caption = 'Semester';
                    ToolTip = 'Semester must have a value';
                }
                field("Enrollment No"; EnrollmentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                    ToolTip = 'Enrollment No. must have a value';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        StudentMaster: Record "Student Master-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.findset();
                        IF PAGE.RUNMODAL(0, StudentMaster) = ACTION::LookupOK THEN
                            EnrollmentNo := StudentMaster."Enrollment No.";
                    end;
                }

                field("Next Semester Fee Generation"; NextSemesterFeeGeneration)
                {
                    ApplicationArea = ALL;
                    Caption = 'Next Semester Fee Generation';
                }
                field("Next Academic Year"; NextAcademicYearFeeGeneration)
                {
                    ApplicationArea = All;
                    Caption = 'Next Academic Year Fee Generation';
                    TableRelation = "Academic Year Master-CS";
                    trigger OnValidate()
                    begin
                        IF NextAcademicYearFeeGeneration <> '' then begin
                            IF NextSemesterFeeGeneration = false THEN
                                Error('Next Semester Fee Generation Boolean must be Tick');
                        end;
                    end;
                }
                field("Auto Posting"; AutoPosting)
                {
                    ApplicationArea = ALL;
                    Caption = 'Auto Posting';
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        IF InstituteCode = '' THEN
            ERROR('Institute Code must have a value in it');

        IF AcademicYear = '' THEN
            ERROR('Academic Year must have a value in it');

        IF (NextSemesterFeeGeneration = true) THEN begin
            If NextAcademicYearFeeGeneration = '' Then
                ERROR('Next Academic Year must have a value in it');
        end;
        Count4 := 0;
    end;

    var
        GenJournalLinePost: Record "Gen. Journal Line";
        FeeSetupCS: Record "Fee Setup-CS";

        CourseSemMasterCS: Record "Course Sem. Master-CS";
        SemesterMaster: Record "Semester Master-CS";
        CourseMaster: Record "Course Master-CS";
        FAidRosterAmt: Decimal;
        FAidBudgetAmt: Decimal;
        FAidBudgetAmtNew: Decimal;
        SQNo: Integer;
        NextSemester: Code[20];
        NextYear: Code[10];
        AcademicYear: Code[100];
        EnrollmentNo: Code[2048];
        SemesterCode: Code[2048];
        NextSemesterFeeGeneration: Boolean;
        NextAcademicYearFeeGeneration: Code[20];
        SemFee: Decimal;
        Grenville: Decimal;
        AutoPosting: Boolean;
        RemainingAmt: Decimal;
        FinalAmount1: Decimal;
        Count4: Integer;
        InstituteCode: Code[20];
        Boolean_New: Boolean;
        TemplateName: Code[20];
        BatchName: Code[20];
        HousingDepositApply: Boolean;


    procedure GetLastDocumemtNo(TemplateName: Code[10]; BatchName: Code[10]) TempDocNo1: Code[20];
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLineRec: Record "Gen. Journal Line";
        NoSeries: Codeunit NoSeriesManagement;
    begin
        GenJournalLineRec.Reset();
        GenJournalLineRec.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLineRec.SETRANGE("Journal Batch Name", BatchName);
        IF GenJournalLineRec.FINDLAST() THEN
            TempDocNo1 := INCSTR(GenJournalLineRec."Document No.")
        ELSE begin
            GenJournalBatch.RESET();
            GenJournalBatch.SETRANGE("Journal Template Name", TemplateName);
            GenJournalBatch.SETRANGE(Name, BatchName);
            IF GenJournalBatch.FINDFIRST() THEN;
            TempDocNo1 := NoSeries.GetNextNo(GenJournalBatch."No. Series", 0D, false);
        end;
    end;

    procedure CheckFeeGenerated(StudentNo: Code[20]; FeeComponent: Code[20]; NextSem: Code[20]; NextAdYear: Code[20]; NextSemFeeGenration: Boolean): Boolean
    var
        GLEntry: Record "G/L Entry";
        // CustRec: Record Customer;
        StudentRec: Record "Student Master-CS";
        FeeCourseHead: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        CourseRec: Record "Course Master-CS";
        FeeComp: Record "Fee Component Master-CS";
        HousingApplication: Record "Housing Application";
        StudentRegistration: Record "Student Registration-CS";
        Count1: Integer;
        Count2: Integer;
    begin
        Count1 := 0;
        Count2 := 0;
        // CustRec.Get(StudentNo);
        StudentRec.Get(StudentNo);
        FeeCourseHead.Reset();
        FeeCourseHead.SETRANGE(FeeCourseHead."Course Code", StudentRec."Course Code");
        IF NextSemFeeGenration = false then
            FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", StudentRec."Academic Year")
        else
            FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", NextAdYear);
        FeeCourseHead.SETRANGE(FeeCourseHead."Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Other Fees", false);
        CourseRec.Get(StudentRec."Course Code");
        If CourseRec."Admitted Year Wise Fee" then
            FeeCourseHead.SETRANGE(FeeCourseHead."Admitted Year", StudentRec."Admitted Year");
        If CourseRec."Semester Wise Fee" then begin
            IF NextSemFeeGenration = false then
                FeeCourseHead.SETRANGE(FeeCourseHead.Semester, StudentRec.Semester)
            Else
                FeeCourseHead.SETRANGE(FeeCourseHead.Semester, NextSem);
        end;
        IF FeeCourseHead.findfirst() THEN BEGIN
            FeeCourseLine.Reset();
            FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
            If FeeComponent <> '' then
                FeeCourseLine.SETRANGE("Fee Code", FeeComponent);
            IF FeeCourseLine.findfirst() THEN
                REPEAT
                    FeeComp.GET(FeeCourseLine."Fee Code");
                    IF FeeComp."Fee Category" = FeeComp."Fee Category"::Optional then begin

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::RENT then begin
                            HousingApplication.Reset();
                            HousingApplication.SetRange("Student No.", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                            else
                                HousingApplication.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange(Semester, StudentRec.Semester)
                            else
                                HousingApplication.SetRange(Semester, NextSem);
                            HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                            HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                            HousingApplication.SetRange(Term, StudentRec.Term);
                            If HousingApplication.FindLast() then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::DAMAGEDEP then begin
                            HousingApplication.Reset();
                            HousingApplication.SetRange("Student No.", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                            else
                                HousingApplication.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange(Semester, StudentRec.Semester)
                            else
                                HousingApplication.SetRange(Semester, NextSem);
                            HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                            HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                            HousingApplication.SetRange(Term, StudentRec.Term);
                            If HousingApplication.FindLast() then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::"BUS-SEMESTER" then begin
                            HousingApplication.Reset();
                            HousingApplication.SetRange("Student No.", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                            else
                                HousingApplication.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange(Semester, StudentRec.Semester)
                            else
                                HousingApplication.SetRange(Semester, NextSem);
                            HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                            HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                            HousingApplication.SetRange(Term, StudentRec.Term);
                            If HousingApplication.FindLast() then
                                If StudentRec."Transport Allot" then
                                    Count2 := Count2 + 1;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::GHTSURCHRG then begin
                            //If StudentRec."Student Type" = StudentRec."Student Type"::"GHT Student" then
                            if CourseRec."Course Category" = CourseRec."Course Category"::GHT then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::HEALTHINS then begin
                            StudentRegistration.Reset();
                            StudentRegistration.SetRange("Student No", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year")
                            else
                                StudentRegistration.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                StudentRegistration.SetRange(Semester, StudentRec.Semester)
                            else
                                StudentRegistration.SetRange(Semester, NextSem);
                            StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                            StudentRegistration.SetRange("Apply for Insurance", true);
                            StudentRegistration.SetRange(Term, StudentRec.Term);
                            IF StudentRegistration.FindFirst() Then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::REPATINS then begin
                            StudentRegistration.Reset();
                            StudentRegistration.SetRange("Student No", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year")
                            else
                                StudentRegistration.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                StudentRegistration.SetRange(Semester, StudentRec.Semester)
                            else
                                StudentRegistration.SetRange(Semester, NextSem);
                            StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                            StudentRegistration.SetRange("Apply for Insurance", false);
                            StudentRegistration.SetRange(Term, StudentRec.Term);
                            IF StudentRegistration.FindFirst() Then
                                Count2 := Count2 + 1;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::"INSTALMENT FEE" then begin
                            If StudentRec."Payment Plan Applied" = true then
                                Count2 := Count2 + 1;
                        end;
                    End Else
                        Count2 := Count2 + 1;

                    GLEntry.Reset();
                    GLEntry.SETRANGE("Enrollment No.", StudentRec."Enrollment No.");
                    IF NextSemFeeGenration = false then
                        GLEntry.SETRANGE("Academic Year", StudentRec."Academic Year")
                    else
                        GLEntry.SETRANGE("Academic Year", NextAdYear);
                    GLEntry.SETRANGE(Year, StudentRec.Year);
                    IF NextSemFeeGenration = false then
                        GLEntry.SETRANGE(Semester, StudentRec.Semester)
                    else
                        GLEntry.SETRANGE(Semester, NextSem);
                    GLEntry.SETRANGE(Reversed, false);
                    GLEntry.SETRANGE("Fee Code", FeeCourseLine."Fee Code");
                    GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Invoice);
                    GLEntry.SetRange(Term, StudentRec.Term);
                    IF GLEntry.findfirst() THEN
                        Count1 := Count1 + 1;
                until FeeCourseLine.Next() = 0;
        End;

        If Count1 = Count2 then
            exit(true)
        Else
            exit(false);
    End;

    procedure GetStartEndDate(StudentNo: Code[20]; i: Integer; var StartDate: Date; var DueDate: Date; NextSem: Code[20]; NextAdYear: Code[20]; NextSemFeeGenration: Boolean): Boolean
    var
        // EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        // CustRec: Record Customer;
        // EducationSetup: Record "Education Setup-CS";
        Stud: Record "Student Master-CS";
        CourseSem: Record "Course Sem. Master-CS";
    begin
        Stud.Get(StudentNo);
        CourseSem.Get(Stud."Course Code", Stud.Semester, Stud."Academic Year", Stud.Term);
        if CourseSem."Fee Due Date" = 0D then
            Error('"Fee Due Date" in "Course Semester" for Course %1 Semester %2 is mandatory to generate fees. It cannot be empty.', CourseSem."Course Code", CourseSem."Semester Code");
        if i = 1 then begin
            StartDate := CourseSem."Fee Due Date";
            DueDate := StartDate;
        end
        else
            if i = 2 then begin
                StartDate := Calcdate('1M', CourseSem."Fee Due Date");
                DueDate := StartDate;
            end
            else
                if i = 3 then begin
                    StartDate := Calcdate('2M', CourseSem."Fee Due Date");
                    DueDate := StartDate;
                end
                else
                    if i = 4 then begin
                        StartDate := Calcdate('3M', CourseSem."Fee Due Date");
                        DueDate := StartDate;
                    end
                    else
                        if i = 5 then begin
                            StartDate := Calcdate('4M', CourseSem."Fee Due Date");
                            DueDate := StartDate;
                        end
                        else
                            if i = 6 then begin
                                StartDate := Calcdate('5M', CourseSem."Fee Due Date");
                                DueDate := StartDate;
                            end;



        // CustRec.Get(StudentNo);
        // Stud.Get(StudentNo);
        // EducationSetup.Reset();
        // EducationSetup.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        // If EducationSetup.FindFirst() then begin

        //     EducationMultiEventCalCS.Reset();
        //     If i = 1 then
        //         EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT 1');
        //     If i = 2 then
        //         EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT 2');
        //     If i = 3 then
        //         EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT 3');
        //     If i = 4 then
        //         EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT 4');
        //     EducationMultiEventCalCS.SETRANGE("Global Dimension 1 Code", Stud."Global Dimension 1 Code");

        //     IF NextSemFeeGenration = false then begin
        //         EducationMultiEventCalCS.SETRANGE("Academic Year", Stud."Academic Year");
        //         EducationMultiEventCalCS.SETRANGE("Even/Odd Semester", EducationSetup."Even/Odd Semester");
        //     End Else begin
        //         If EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::FALL then
        //             EducationMultiEventCalCS.SETRANGE("Even/Odd Semester", EducationMultiEventCalCS."Even/Odd Semester"::SPRING);
        //         If EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::SPRING then
        //             EducationMultiEventCalCS.SETRANGE("Even/Odd Semester", EducationMultiEventCalCS."Even/Odd Semester"::FALL);
        //         EducationMultiEventCalCS.SETRANGE("Academic Year", NextAdYear);
        //     end;
        //     IF EducationMultiEventCalCS.findfirst() THEN begin
        // StartDate := WorkDate();
        // EndDate := EducationMultiEventCalCS."End Date";
        // end;
        // end;
    End;

    procedure FeeGenrationFinancialAid(StudentNo: Code[20]; FAidAmount: Decimal; NextSem: Code[20]; NextAdYear: Code[20]; NextSemFeeGenration: Boolean; FABool: Boolean; PPBool: Boolean; SelfBool: Boolean; var TemplateName1: Code[20]; var BatchName1: Code[20]) Count3: Integer
    var
        FeeSetup: Record "Fee Setup-CS";
        // CustRec: Record Customer;
        FeeCourseHead: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        CourseRec: Record "Course Master-CS";
        StudentRec: Record "Student Master-CS";
        FeeComp: Record "Fee Component Master-CS";
        HousingApplication: Record "Housing Application";
        RoomCategoryFeeSetup: Record "Room Category Fee Setup";
        StudentRegistration: Record "Student Registration-CS";
        RecWebJournal: Codeunit WebJournal1;
        GD2: Code[20];
        DueDate: Date;
        StartDate: Date;
        TempDocNo: Code[20];
        Amount1: Decimal;
        Amount2: Decimal;
        TotalAmount1: Decimal;
        FinalAmount: Decimal;
        ComponentAmt: Decimal;
        GeneratedAmt1: Decimal;
        SourceCode: Option "Semester Fee","Grenville Realty","Installment Fee";
        DepositType: Option "Housing Deposit","Seat Deposit";
        AppliedDocNo: Code[20];
        Temp1: Code[20];
        Batch: Code[20];
        SemFee1: Decimal;
        Grenville1: Decimal;
        FeeCode_lCode: Code[20];

    begin
        // CustRec.Get(StudentNo);
        StudentRec.Get(StudentNo);
        FinalAmount := StudentTotalFee(StudentRec."No.", '', NextSem, NextAdYear, NextSemFeeGenration, SemFee1, Grenville1);

        FeeSetup.Reset();
        FeeSetup.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        IF FeeSetup.FindFirst() then begin
            FeeSetup.TESTFIELD("Journal Template Name");
            FeeSetup.TESTFIELD("Journal Batch Name");
        end;

        // For Semester Fee >>>>
        DueDate := 0D;
        StartDate := 0D;
        Amount2 := 0;
        Amount1 := 0;
        Temp1 := '';
        Batch := '';
        FeeCode_lCode := '';
        TotalAmount1 := 0;
        Clear(TempDocNo);
        TempDocNo := GetLastDocumemtNo(FeeSetup."Journal Template Name", FeeSetup."Journal Batch Name");
        GetStartEndDate(StudentRec."No.", 1, StartDate, DueDate, NextSem, NextAdYear, NextSemFeeGenration);

        FeeCourseHead.Reset();
        FeeCourseHead.SETRANGE(FeeCourseHead."Course Code", StudentRec."Course Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", StudentRec."Academic Year");
        FeeCourseHead.SETRANGE(FeeCourseHead."Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Other Fees", false);
        CourseRec.Get(StudentRec."Course Code");
        If CourseRec."Admitted Year Wise Fee" then
            FeeCourseHead.SETRANGE(FeeCourseHead."Admitted Year", StudentRec."Admitted Year");
        If CourseRec."Semester Wise Fee" then begin
            If NextSemFeeGenration = false then
                FeeCourseHead.SETRANGE(FeeCourseHead.Semester, StudentRec.Semester)
            else
                FeeCourseHead.SETRANGE(FeeCourseHead.Semester, NextSem);
        end;
        IF FeeCourseHead.findfirst() THEN BEGIN
            FeeCourseLine.Reset();
            FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
            IF FeeCourseLine.findfirst() THEN
                REPEAT
                    ComponentAmt := 0;
                    GeneratedAmt1 := 0;
                    FeeComp.GET(FeeCourseLine."Fee Code");
                    IF NOT (FeeComp."Type Of Fee" In [FeeComp."Type Of Fee"::RENT, FeeComp."Type Of Fee"::DAMAGEDEP, FeeComp."Type Of Fee"::"BUS-SEMESTER", FeeComp."Type Of Fee"::"INSTALMENT FEE"]) then begin

                        IF CheckFeeGenerated(StudentRec."No.", FeeCourseLine."Fee Code", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration) = False Then begin
                            IF FAidAmount <> 0 then begin
                                Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                Amount1 := (FAidAmount * Amount2) / 100;
                            end Else begin
                                Amount1 := FeeCourseLine.Amount;
                            end;
                            GD2 := FeeComp."Global Dimension 2 Code";
                            IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::HEALTHINS then begin
                                Amount2 := 0;
                                Amount1 := 0;
                                StudentRegistration.Reset();
                                StudentRegistration.SetRange("Student No", StudentRec."No.");
                                If NextSemFeeGenration = false then
                                    StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year")
                                else
                                    StudentRegistration.SetRange("Academic Year", NextAdYear);
                                If NextSemFeeGenration = false then
                                    StudentRegistration.SetRange(Semester, StudentRec.Semester)
                                Else
                                    StudentRegistration.SetRange(Semester, NextSem);
                                StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                                StudentRegistration.SetRange("Apply for Insurance", true);
                                IF StudentRegistration.FindFirst() Then begin
                                    IF FAidAmount <> 0 then begin
                                        Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                        Amount1 := (FAidAmount * Amount2) / 100;
                                    end Else begin
                                        Amount1 := FeeCourseLine.Amount;
                                    End;
                                end;
                            end;

                            IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::REPATINS then begin
                                Amount2 := 0;
                                Amount1 := 0;
                                StudentRegistration.Reset();
                                StudentRegistration.SetRange("Student No", StudentRec."No.");
                                If NextSemFeeGenration = false then
                                    StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year")
                                Else
                                    StudentRegistration.SetRange("Academic Year", NextAdYear);
                                If NextSemFeeGenration = false then
                                    StudentRegistration.SetRange(Semester, StudentRec.Semester)
                                else
                                    StudentRegistration.SetRange(Semester, NextSem);
                                StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                                StudentRegistration.SetRange("Apply for Insurance", false);
                                IF StudentRegistration.FindFirst() Then begin
                                    IF FAidAmount <> 0 then begin
                                        Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                        Amount1 := (FAidAmount * Amount2) / 100;
                                    end Else begin
                                        Amount1 := FeeCourseLine.Amount;
                                    End;
                                end;
                            end;

                            IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::GHTSURCHRG then begin
                                Amount2 := 0;
                                Amount1 := 0;
                                // If StudentRec."Student Type" = StudentRec."Student Type"::"GHT Student" then Begin
                                if CourseMaster."Course Category" = CourseMaster."Course Category"::GHT then Begin
                                    IF FAidAmount <> 0 then begin
                                        Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                        Amount1 := (FAidAmount * Amount2) / 100;
                                    end Else begin
                                        Amount1 := FeeCourseLine.Amount;
                                    End;
                                End;
                                ;
                            end;

                            IF Amount1 <> 0 Then begin
                                RecWebJournal.FeeProcess(StudentRec."No.", FeeCourseLine."Fee Code", Amount1, TempDocNo, FeeCourseHead."Currency Code", DueDate, FeeComp."Source Code", GD2, StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, 0, SelfBool, Temp1, Batch);
                                FeeCode_lCode := FeeCourseLine."Fee Code";
                            end;
                            TotalAmount1 += Amount1;
                        end;
                    end;
                UNTIL FeeCourseLine.NEXT() = 0;
            IF TotalAmount1 <> 0 then begin
                IF (FABool = False) then
                    AppliedDocNo := GetAppliedDocNo(StudentNo, NextSem, NextAdYear, NextSemFeeGenration, DepositType::"Seat Deposit");

                IF RecWebJournal.CustomerInsert(StudentRec."No.", TotalAmount1, TempDocNo, FeeCourseHead."Currency Code", DueDate, SourceCode::"Semester Fee", StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, 0, AppliedDocNo, SelfBool, GD2, FeeCode_lCode) then //SD-SN-18-Dec-2020 +
                    Count3 := Count3 + 1;
            end;
            TemplateName1 := Temp1;
            BatchName1 := Batch;
        End;

        // For Grenville Realty Fee >>>>>>>
        Amount2 := 0;
        Amount1 := 0;
        TotalAmount1 := 0;
        Temp1 := '';
        Batch := '';
        FeeCode_lCode := '';
        Clear(TempDocNo);
        HousingDepositApply := false;
        TempDocNo := GetLastDocumemtNo(FeeSetup."Journal Template Name", FeeSetup."Journal Batch Name");

        FeeCourseHead.Reset();
        FeeCourseHead.SETRANGE(FeeCourseHead."Course Code", StudentRec."Course Code");
        If NextSemFeeGenration = false then
            FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", StudentRec."Academic Year")
        Else
            FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", NextAdYear);
        FeeCourseHead.SETRANGE(FeeCourseHead."Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Other Fees", false);
        CourseRec.Get(StudentRec."Course Code");
        If CourseRec."Admitted Year Wise Fee" then
            FeeCourseHead.SETRANGE(FeeCourseHead."Admitted Year", StudentRec."Admitted Year");
        If CourseRec."Semester Wise Fee" then begin
            If NextSemFeeGenration = false then
                FeeCourseHead.SETRANGE(FeeCourseHead.Semester, StudentRec.Semester)
            else
                FeeCourseHead.SETRANGE(FeeCourseHead.Semester, NextSem);
        end;
        IF FeeCourseHead.findfirst() THEN BEGIN
            FeeCourseLine.Reset();
            FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
            IF FeeCourseLine.findfirst() THEN
                REPEAT
                    ComponentAmt := 0;
                    GeneratedAmt1 := 0;
                    FeeComp.GET(FeeCourseLine."Fee Code");
                    IF (FeeComp."Type Of Fee" In [FeeComp."Type Of Fee"::RENT, FeeComp."Type Of Fee"::DAMAGEDEP, FeeComp."Type Of Fee"::"BUS-SEMESTER"]) then begin

                        IF CheckFeeGenerated(StudentRec."No.", FeeCourseLine."Fee Code", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration) = False Then begin
                            GD2 := FeeComp."Global Dimension 2 Code";
                            IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::RENT then begin
                                Amount2 := 0;
                                Amount1 := 0;
                                HousingApplication.Reset();
                                HousingApplication.SetRange("Student No.", StudentRec."No.");
                                If NextSemFeeGenration = false then
                                    HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                                else
                                    HousingApplication.SetRange("Academic Year", NextAdYear);
                                If NextSemFeeGenration = false then
                                    HousingApplication.SetRange(Semester, StudentRec.Semester)
                                else
                                    HousingApplication.SetRange(Semester, NextSem);
                                HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                                HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                                If HousingApplication.FindLast() then begin
                                    RoomCategoryFeeSetup.Reset();
                                    RoomCategoryFeeSetup.SetCurrentKey("Effective From");
                                    RoomCategoryFeeSetup.SetRange("Housing ID", HousingApplication."Housing ID");
                                    RoomCategoryFeeSetup.SetRange("Room Category Code", HousingApplication."Room Category Code");
                                    RoomCategoryFeeSetup.SetFilter("Effective From", '<=%1', WorkDate());
                                    IF RoomCategoryFeeSetup.Findlast() then begin
                                        HousingDepositApply := true;
                                        If HousingApplication."With Spouse" = true then begin
                                            IF FAidAmount <> 0 then begin
                                                Amount2 := (RoomCategoryFeeSetup."With Spouse Cost" / FinalAmount) * 100;
                                                Amount1 := (FAidAmount * Amount2) / 100;
                                            end Else begin
                                                Amount1 := RoomCategoryFeeSetup."With Spouse Cost";
                                            End;
                                        end Else begin
                                            IF FAidAmount <> 0 then begin
                                                Amount2 := (RoomCategoryFeeSetup.Cost / FinalAmount) * 100;
                                                Amount1 := (FAidAmount * Amount2) / 100;
                                            end Else begin
                                                Amount1 := RoomCategoryFeeSetup.Cost;
                                            End;
                                        end;
                                    end;
                                end;
                            End;

                            IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::DAMAGEDEP then begin
                                Amount2 := 0;
                                Amount1 := 0;
                                HousingApplication.Reset();
                                HousingApplication.SetRange("Student No.", StudentRec."No.");
                                If NextSemFeeGenration = false then
                                    HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                                else
                                    HousingApplication.SetRange("Academic Year", NextAdYear);
                                If NextSemFeeGenration = false then
                                    HousingApplication.SetRange(Semester, StudentRec.Semester)
                                else
                                    HousingApplication.SetRange(Semester, NextSem);
                                HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                                HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                                If HousingApplication.FindLast() then Begin
                                    IF FAidAmount <> 0 then begin
                                        Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                        Amount1 := (FAidAmount * Amount2) / 100;
                                    end Else begin
                                        Amount1 := FeeCourseLine.Amount;
                                    End;
                                End;
                            end;

                            IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::"BUS-SEMESTER" then begin
                                Amount2 := 0;
                                Amount1 := 0;
                                //SD-SN-18-Dec-2020 +
                                HousingApplication.Reset();
                                HousingApplication.SetRange("Student No.", StudentRec."No.");
                                If NextSemFeeGenration = false then
                                    HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                                else
                                    HousingApplication.SetRange("Academic Year", NextAdYear);
                                If NextSemFeeGenration = false then
                                    HousingApplication.SetRange(Semester, StudentRec.Semester)
                                else
                                    HousingApplication.SetRange(Semester, NextSem);
                                HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                                HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                                If HousingApplication.FindLast() then Begin
                                    If StudentRec."Transport Allot" then Begin
                                        IF FAidAmount <> 0 then begin
                                            Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                            Amount1 := (FAidAmount * Amount2) / 100;
                                        end Else begin
                                            Amount1 := FeeCourseLine.Amount;
                                        End;
                                    End;
                                end;
                                //SD-SN-18-Dec-2020 -
                            end;

                            IF Amount1 <> 0 Then begin
                                RecWebJournal.FeeProcess(StudentRec."No.", FeeCourseLine."Fee Code", Amount1, TempDocNo, FeeCourseHead."Currency Code", DueDate, FeeComp."Source Code", GD2, StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, 0, SelfBool, Temp1, Batch);
                                FeeCode_lCode := FeeCourseLine."Fee Code";
                            end;
                            TotalAmount1 += Amount1;
                        end;
                    end;
                UNTIL FeeCourseLine.NEXT() = 0;
            IF TotalAmount1 <> 0 then begin
                IF HousingDepositApply = true then
                    AppliedDocNo := GetAppliedDocNo(StudentNo, NextSem, NextAdYear, NextSemFeeGenration, DepositType::"Housing Deposit");
                IF RecWebJournal.CustomerInsert(StudentRec."No.", TotalAmount1, TempDocNo, FeeCourseHead."Currency Code", DueDate, SourceCode::"Grenville Realty", StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, 0, AppliedDocNo, SelfBool, GD2, FeeCode_lCode) then //SD-SN-18-Dec-2020 +
                    Count3 := Count3 + 1;
            end;
            TemplateName1 := Temp1;
            BatchName1 := Batch;
        End;
    end;

    procedure FeeGenrationPaymentPaln(StudentNo: Code[20]; FAidAmount: Decimal; NextSem: Code[20]; NextAdYear: Code[20]; NextSemFeeGenration: Boolean; FABool: Boolean; PPBool: Boolean; SelfBool: Boolean; var TemplateName1: Code[20]; var BatchName1: Code[20]) Count3: Integer
    var
        FeeSetup: Record "Fee Setup-CS";
        // CustRec: Record Customer;
        FeeCourseHead: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        CourseRec: Record "Course Master-CS";
        StudentRec: Record "Student Master-CS";
        FeeComp: Record "Fee Component Master-CS";
        HousingApplication: Record "Housing Application";
        RoomCategoryFeeSetup: Record "Room Category Fee Setup";
        StudentRegistration: Record "Student Registration-CS";
        RecWebJournal: Codeunit WebJournal1;
        GD2: Code[20];
        DueDate: Date;
        StartDate: Date;
        TempDocNo: Code[20];
        Amount1: Decimal;
        Amount2: Decimal;
        TotalAmount1: Decimal;
        FinalAmount: Decimal;
        PaymentPlanAmt: Decimal;
        ComponentAmt: Decimal;
        GeneratedAmt1: Decimal;
        SourceCode: Option "Semester Fee","Grenville Realty","Installment Fee";
        DepositType: Option "Housing Deposit","Seat Deposit";
        i: Integer;
        AppliedDocNo: Code[20];
        Temp1: Code[20];
        Batch: Code[20];
        SemFee2: Decimal;
        Grenville2: Decimal;
        FeeCode_lCode: Code[20];
    begin
        // CustRec.Get(StudentNo);
        StudentRec.Get(StudentNo);
        FeeSetup.Reset();
        FeeSetup.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        IF FeeSetup.FindFirst() then begin
            FeeSetup.TESTFIELD("Payment Plan Template Name");
            FeeSetup.TESTFIELD("Payment Plan Batch Name");
        end;

        IF FAidAmount <> 0 then begin
            FinalAmount := StudentTotalFee(StudentRec."No.", '', NextSem, NextAdYear, NextSemFeeGenration, SemFee2, Grenville2);
            PaymentPlanAmt := FAidAmount;
        end;

        IF (FAidAmount <> 0) AND (PaymentPlanAmt = 0) then
            CurrReport.Skip()
        else begin
            FeeCourseHead.Reset();
            FeeCourseHead.SETRANGE(FeeCourseHead."Course Code", StudentRec."Course Code");
            If NextSemFeeGenration = false then
                FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", StudentRec."Academic Year")
            else
                FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", NextAdYear);
            FeeCourseHead.SETRANGE(FeeCourseHead."Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            FeeCourseHead.SETRANGE(FeeCourseHead."Other Fees", false);
            CourseRec.Get(StudentRec."Course Code");
            If CourseRec."Admitted Year Wise Fee" then
                FeeCourseHead.SETRANGE(FeeCourseHead."Admitted Year", StudentRec."Admitted Year");
            If CourseRec."Semester Wise Fee" then begin
                If NextSemFeeGenration = false then
                    FeeCourseHead.SETRANGE(FeeCourseHead.Semester, StudentRec.Semester)
                else
                    FeeCourseHead.SETRANGE(FeeCourseHead.Semester, NextSem);
            end;
            IF FeeCourseHead.findfirst() THEN BEGIN
                for i := 1 To StudentRec."Payment Plan Instalment" do begin

                    // Installment Fee Generated
                    if i = 1 then begin
                        FeeCourseLine.Reset();
                        FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
                        IF FeeCourseLine.findfirst() THEN begin
                            REPEAT
                                ComponentAmt := 0;
                                GeneratedAmt1 := 0;
                                FeeComp.GET(FeeCourseLine."Fee Code");
                                IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::"INSTALMENT FEE" then begin
                                    IF CheckFeeGenerated(StudentRec."No.", FeeCourseLine."Fee Code", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration) = False Then begin
                                        DueDate := 0D;
                                        StartDate := 0D;
                                        Clear(TempDocNo);
                                        TempDocNo := GetLastDocumemtNo(FeeSetup."Payment Plan Template Name", FeeSetup."Payment Plan Batch Name");
                                        GetStartEndDate(StudentRec."No.", i, StartDate, DueDate, NextSem, NextAdYear, NextSemFeeGenration);

                                        RecWebJournal.FeeProcess(StudentRec."No.", FeeCourseLine."Fee Code", FeeCourseLine.Amount, TempDocNo, FeeCourseHead."Currency Code", DueDate, FeeComp."Source Code", FeeComp."Global Dimension 2 Code", StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, i, SelfBool, Temp1, Batch);
                                        RecWebJournal.CustomerInsert(StudentRec."No.", FeeCourseLine.Amount, TempDocNo, FeeCourseHead."Currency Code", DueDate, SourceCode::"Installment Fee", StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, i, '', SelfBool, GD2, FeeCourseLine."Fee Code");
                                    End;
                                end;
                            Until FeeCourseLine.Next() = 0;
                        end;
                    End;

                    // For Semester Fee >>>>
                    DueDate := 0D;
                    StartDate := 0D;
                    Amount2 := 0;
                    Amount1 := 0;
                    Temp1 := '';
                    Batch := '';
                    FeeCode_lCode := '';
                    TotalAmount1 := 0;
                    Clear(TempDocNo);
                    TempDocNo := GetLastDocumemtNo(FeeSetup."Payment Plan Template Name", FeeSetup."Payment Plan Batch Name");
                    GetStartEndDate(StudentRec."No.", i, StartDate, DueDate, NextSem, NextAdYear, NextSemFeeGenration);

                    FeeCourseLine.Reset();
                    FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
                    IF FeeCourseLine.findfirst() THEN
                        REPEAT
                            ComponentAmt := 0;
                            GeneratedAmt1 := 0;
                            FeeComp.GET(FeeCourseLine."Fee Code");
                            IF NOT (FeeComp."Type Of Fee" In [FeeComp."Type Of Fee"::RENT, FeeComp."Type Of Fee"::DAMAGEDEP, FeeComp."Type Of Fee"::"BUS-SEMESTER", FeeComp."Type Of Fee"::"INSTALMENT FEE"]) then begin

                                IF CheckFeeGenerated(StudentRec."No.", FeeCourseLine."Fee Code", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration) = False Then begin
                                    IF FAidAmount <> 0 then begin
                                        Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                        Amount1 := ((PaymentPlanAmt * Amount2) / 100) / StudentRec."Payment Plan Instalment";
                                    End Else begin
                                        Amount1 := FeeCourseLine.Amount / StudentRec."Payment Plan Instalment";
                                    end;
                                    GD2 := FeeComp."Global Dimension 2 Code";

                                    IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::HEALTHINS then begin
                                        Amount2 := 0;
                                        Amount1 := 0;
                                        StudentRegistration.Reset();
                                        StudentRegistration.SetRange("Student No", StudentRec."No.");
                                        If NextSemFeeGenration = false then
                                            StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year")
                                        else
                                            StudentRegistration.SetRange("Academic Year", NextAdYear);
                                        If NextSemFeeGenration = false then
                                            StudentRegistration.SetRange(Semester, StudentRec.Semester)
                                        Else
                                            StudentRegistration.SetRange(Semester, NextSem);
                                        StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                                        StudentRegistration.SetRange("Apply for Insurance", true);
                                        IF StudentRegistration.FindFirst() Then begin
                                            IF FAidAmount <> 0 then begin
                                                Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                                Amount1 := ((PaymentPlanAmt * Amount2) / 100) / StudentRec."Payment Plan Instalment";
                                            End Else begin
                                                Amount1 := FeeCourseLine.Amount / StudentRec."Payment Plan Instalment";
                                            end;
                                        end;
                                    end;

                                    IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::REPATINS then begin
                                        Amount2 := 0;
                                        Amount1 := 0;
                                        StudentRegistration.Reset();
                                        StudentRegistration.SetRange("Student No", StudentRec."No.");
                                        If NextSemFeeGenration = false then
                                            StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year")
                                        else
                                            StudentRegistration.SetRange("Academic Year", NextAdYear);
                                        If NextSemFeeGenration = false then
                                            StudentRegistration.SetRange(Semester, StudentRec.Semester)
                                        Else
                                            StudentRegistration.SetRange(Semester, NextSem);
                                        StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                                        StudentRegistration.SetRange("Apply for Insurance", false);
                                        IF StudentRegistration.FindFirst() Then begin
                                            IF FAidAmount <> 0 then begin
                                                Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                                Amount1 := ((PaymentPlanAmt * Amount2) / 100) / StudentRec."Payment Plan Instalment";
                                            End Else begin
                                                Amount1 := FeeCourseLine.Amount / StudentRec."Payment Plan Instalment";
                                            end;
                                        end;
                                    end;

                                    IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::GHTSURCHRG then begin
                                        Amount2 := 0;
                                        Amount1 := 0;
                                        // If StudentRec."Student Type" = StudentRec."Student Type"::"GHT Student" then Begin
                                        if CourseMaster."Course Category" = CourseMaster."Course Category"::GHT then begin
                                            IF FAidAmount <> 0 then begin
                                                Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                                Amount1 := ((PaymentPlanAmt * Amount2) / 100) / StudentRec."Payment Plan Instalment";
                                            End Else begin
                                                Amount1 := FeeCourseLine.Amount / StudentRec."Payment Plan Instalment";
                                            end;
                                        End;
                                    end;

                                    IF Amount1 <> 0 Then begin
                                        RecWebJournal.FeeProcess(StudentRec."No.", FeeCourseLine."Fee Code", Amount1, TempDocNo, FeeCourseHead."Currency Code", DueDate, FeeComp."Source Code", GD2, StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, i, SelfBool, Temp1, Batch);
                                        FeeCode_lCode := FeeCourseLine."Fee Code";
                                    end;
                                    TotalAmount1 += Amount1;
                                end;
                            end;
                        UNTIL FeeCourseLine.NEXT() = 0;
                    IF TotalAmount1 <> 0 then begin
                        IF (FABool = False) then
                            AppliedDocNo := GetAppliedDocNo(StudentNo, NextSem, NextAdYear, NextSemFeeGenration, DepositType::"Seat Deposit");

                        IF RecWebJournal.CustomerInsert(StudentRec."No.", TotalAmount1, TempDocNo, FeeCourseHead."Currency Code", DueDate, SourceCode::"Semester Fee", StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, i, AppliedDocNo, SelfBool, GD2, FeeCode_lCode) Then //SD-SN-18-Dec-2020 +
                            Count3 := Count3 + 1;
                    end;
                    TemplateName1 := Temp1;
                    BatchName1 := Batch;

                    // For Grenville Realty Fee >>>>>>>
                    Amount2 := 0;
                    Amount1 := 0;
                    Temp1 := '';
                    Batch := '';
                    FeeCode_lCode := '';
                    TotalAmount1 := 0;
                    Clear(TempDocNo);
                    HousingDepositApply := false;
                    TempDocNo := GetLastDocumemtNo(FeeSetup."Payment Plan Template Name", FeeSetup."Payment Plan Batch Name");

                    FeeCourseLine.Reset();
                    FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
                    IF FeeCourseLine.findfirst() THEN
                        REPEAT
                            FeeComp.GET(FeeCourseLine."Fee Code");
                            IF (FeeComp."Type Of Fee" In [FeeComp."Type Of Fee"::RENT, FeeComp."Type Of Fee"::DAMAGEDEP, FeeComp."Type Of Fee"::"BUS-SEMESTER"]) then begin

                                IF CheckFeeGenerated(StudentRec."No.", FeeCourseLine."Fee Code", NextSemester, NextAcademicYearFeeGeneration, NextSemesterFeeGeneration) = False Then begin
                                    GD2 := FeeComp."Global Dimension 2 Code";
                                    IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::RENT then begin
                                        Amount2 := 0;
                                        Amount1 := 0;
                                        HousingApplication.Reset();
                                        HousingApplication.SetRange("Student No.", StudentRec."No.");
                                        If NextSemFeeGenration = false then
                                            HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                                        else
                                            HousingApplication.SetRange("Academic Year", NextAdYear);
                                        If NextSemFeeGenration = false then
                                            HousingApplication.SetRange(Semester, StudentRec.Semester)
                                        else
                                            HousingApplication.SetRange(Semester, NextSem);
                                        HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                                        HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                                        If HousingApplication.FindLast() then begin
                                            RoomCategoryFeeSetup.Reset();
                                            RoomCategoryFeeSetup.SetRange("Housing ID", HousingApplication."Housing ID");
                                            RoomCategoryFeeSetup.SetRange("Room Category Code", HousingApplication."Room Category Code");
                                            RoomCategoryFeeSetup.SetFilter("Effective From", '<=%1', WorkDate());
                                            IF RoomCategoryFeeSetup.FindFirst() then begin
                                                HousingDepositApply := true;
                                                IF HousingApplication."With Spouse" = true then begin
                                                    IF FAidAmount <> 0 then begin
                                                        Amount2 := (RoomCategoryFeeSetup."With Spouse Cost" / FinalAmount) * 100;
                                                        Amount1 := ((PaymentPlanAmt * Amount2) / 100) / StudentRec."Payment Plan Instalment";
                                                    End Else begin
                                                        Amount1 := RoomCategoryFeeSetup."With Spouse Cost" / StudentRec."Payment Plan Instalment";
                                                    end;
                                                end Else begin
                                                    IF FAidAmount <> 0 then begin
                                                        Amount2 := (RoomCategoryFeeSetup.Cost / FinalAmount) * 100;
                                                        Amount1 := ((PaymentPlanAmt * Amount2) / 100) / StudentRec."Payment Plan Instalment";
                                                    End Else begin
                                                        Amount1 := RoomCategoryFeeSetup.Cost / StudentRec."Payment Plan Instalment";
                                                    end;
                                                end;
                                            end;
                                        end;
                                    End;

                                    IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::DAMAGEDEP then begin
                                        Amount2 := 0;
                                        Amount1 := 0;
                                        HousingApplication.Reset();
                                        HousingApplication.SetRange("Student No.", StudentRec."No.");
                                        If NextSemFeeGenration = false then
                                            HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                                        else
                                            HousingApplication.SetRange("Academic Year", NextAdYear);
                                        If NextSemFeeGenration = false then
                                            HousingApplication.SetRange(Semester, StudentRec.Semester)
                                        else
                                            HousingApplication.SetRange(Semester, NextSem);
                                        HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                                        HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                                        If HousingApplication.FindLast() then Begin
                                            IF FAidAmount <> 0 then begin
                                                Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                                Amount1 := ((PaymentPlanAmt * Amount2) / 100) / StudentRec."Payment Plan Instalment";
                                            End Else begin
                                                Amount1 := FeeCourseLine.Amount / StudentRec."Payment Plan Instalment";
                                            end;
                                        End;
                                    end;

                                    IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::"BUS-SEMESTER" then begin
                                        Amount2 := 0;
                                        Amount1 := 0;
                                        //SD-SN-18-Dec-2020 +
                                        HousingApplication.Reset();
                                        HousingApplication.SetRange("Student No.", StudentRec."No.");
                                        If NextSemFeeGenration = false then
                                            HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                                        else
                                            HousingApplication.SetRange("Academic Year", NextAdYear);
                                        If NextSemFeeGenration = false then
                                            HousingApplication.SetRange(Semester, StudentRec.Semester)
                                        else
                                            HousingApplication.SetRange(Semester, NextSem);
                                        HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                                        HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                                        If HousingApplication.FindLast() then Begin
                                            If StudentRec."Transport Allot" then Begin
                                                IF FAidAmount <> 0 then begin
                                                    Amount2 := (FeeCourseLine.Amount / FinalAmount) * 100;
                                                    Amount1 := ((PaymentPlanAmt * Amount2) / 100) / StudentRec."Payment Plan Instalment";
                                                End Else begin
                                                    Amount1 := FeeCourseLine.Amount / StudentRec."Payment Plan Instalment";
                                                end;
                                            End;
                                        end;
                                    End;
                                    //SD-SN-18-Dec-2020 -
                                    IF Amount1 <> 0 Then begin
                                        RecWebJournal.FeeProcess(StudentRec."No.", FeeCourseLine."Fee Code", Amount1, TempDocNo, FeeCourseHead."Currency Code", DueDate, FeeComp."Source Code", GD2, StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, i, SelfBool, Temp1, Batch);
                                        FeeCode_lCode := FeeCourseLine."Fee Code";
                                    end;
                                    TotalAmount1 += Amount1;
                                end;
                            end;
                        UNTIL FeeCourseLine.NEXT() = 0;
                    IF TotalAmount1 <> 0 then begin
                        IF HousingDepositApply = true then
                            AppliedDocNo := GetAppliedDocNo(StudentNo, NextSem, NextAdYear, NextSemFeeGenration, DepositType::"Housing Deposit");
                        IF RecWebJournal.CustomerInsert(StudentRec."No.", TotalAmount1, TempDocNo, FeeCourseHead."Currency Code", DueDate, SourceCode::"Grenville Realty", StartDate, FeeCourseHead.Semester, FeeCourseHead."Academic Year", NextYear, FABool, PPBool, i, AppliedDocNo, SelfBool, GD2, FeeCode_lCode) Then //SD-SN-18-Dec-2020 +
                            Count3 := Count3 + 1;
                    End;
                End;
                TemplateName1 := Temp1;
                BatchName1 := Batch;
            End;
        end;
    End;

    procedure StudentTotalFee(StudentNo: Code[20]; FeeComponent: Code[20]; NextSem: Code[20]; NextAdYear: Code[20]; NextSemFeeGenration: Boolean; var SemesterFee: Decimal; var GrenvilleRealtyFee: Decimal) TotalAmt: Decimal;
    var
        // CustRec: Record Customer;
        StudentRec: Record "Student Master-CS";
        FeeCourseHead: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        CourseRec: Record "Course Master-CS";
        FeeComp: Record "Fee Component Master-CS";
        HousingApplication: Record "Housing Application";
        RoomCategoryFeeSetup: Record "Room Category Fee Setup";
        StudentRegistration: Record "Student Registration-CS";
        Amt: Decimal;
        GrenvilleFee: Decimal;
    begin
        StudentRec.Get(StudentNo);
        // CustRec.Get(StudentNo);

        FeeCourseHead.Reset();
        FeeCourseHead.SETRANGE(FeeCourseHead."Course Code", StudentRec."Course Code");
        IF NextSemFeeGenration = false then
            FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", StudentRec."Academic Year")
        else
            FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", NextAdYear);
        FeeCourseHead.SETRANGE(FeeCourseHead."Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Other Fees", false);
        CourseRec.Get(StudentRec."Course Code");
        If CourseRec."Admitted Year Wise Fee" then
            FeeCourseHead.SETRANGE(FeeCourseHead."Admitted Year", StudentRec."Admitted Year");
        If CourseRec."Semester Wise Fee" then begin
            IF NextSemFeeGenration = false then
                FeeCourseHead.SETRANGE(FeeCourseHead.Semester, StudentRec.Semester)
            else
                FeeCourseHead.SETRANGE(FeeCourseHead.Semester, NextSem);
        End;
        IF FeeCourseHead.findfirst() THEN BEGIN
            FeeCourseLine.Reset();
            FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
            If FeeComponent <> '' then
                FeeCourseLine.SETRANGE("Fee Code", FeeComponent);
            IF FeeCourseLine.findfirst() THEN
                REPEAT
                    FeeComp.GET(FeeCourseLine."Fee Code");
                    IF NOT (FeeComp."Type Of Fee" In [FeeComp."Type Of Fee"::"INSTALMENT FEE"]) then begin
                        Amt := FeeCourseLine.Amount;
                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::RENT then begin
                            Amt := 0;
                            HousingApplication.Reset();
                            HousingApplication.SetRange("Student No.", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                            Else
                                HousingApplication.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange(Semester, StudentRec.Semester)
                            Else
                                HousingApplication.SetRange(Semester, NextSem);
                            HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                            HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                            If HousingApplication.FindLast() then begin
                                RoomCategoryFeeSetup.Reset();
                                RoomCategoryFeeSetup.SetRange("Housing ID", HousingApplication."Housing ID");
                                RoomCategoryFeeSetup.SetRange("Room Category Code", HousingApplication."Room Category Code");
                                RoomCategoryFeeSetup.SetFilter("Effective From", '<=%1', WorkDate());
                                IF RoomCategoryFeeSetup.FindFirst() then
                                    If HousingApplication."With Spouse" = true then
                                        Amt := RoomCategoryFeeSetup."With Spouse Cost"
                                    Else
                                        Amt := RoomCategoryFeeSetup.Cost;
                                GrenvilleFee += Amt;
                            end;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::DAMAGEDEP then begin
                            Amt := 0;
                            HousingApplication.Reset();
                            HousingApplication.SetRange("Student No.", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                            Else
                                HousingApplication.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange(Semester, StudentRec.Semester)
                            Else
                                HousingApplication.SetRange(Semester, NextSem);
                            HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                            HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                            If HousingApplication.FindLast() then
                                Amt := FeeCourseLine.Amount;
                            GrenvilleFee += Amt;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::"BUS-SEMESTER" then begin
                            Amt := 0;
                            //SN-24-Dec-2020 +
                            HousingApplication.Reset();
                            HousingApplication.SetRange("Student No.", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange("Academic Year", StudentRec."Academic Year")
                            Else
                                HousingApplication.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                HousingApplication.SetRange(Semester, StudentRec.Semester)
                            Else
                                HousingApplication.SetRange(Semester, NextSem);
                            HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                            HousingApplication.SetRange("Global Dimension 2 Code", FeeComp."Global Dimension 2 Code");
                            If HousingApplication.FindLast() then//SN-24-Dec-2020 -
                                If StudentRec."Transport Allot" then
                                    Amt := FeeCourseLine.Amount;
                            GrenvilleFee += Amt;
                        end;
                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::GHTSURCHRG then begin
                            Amt := 0;
                            // If StudentRec."Student Type" = StudentRec."Student Type"::"GHT Student" then
                            if CourseRec."Course Category" = CourseRec."Course Category"::GHT then
                                Amt := FeeCourseLine.Amount;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::HEALTHINS then begin
                            Amt := 0;
                            StudentRegistration.Reset();
                            StudentRegistration.SetRange("Student No", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year")
                            else
                                StudentRegistration.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                StudentRegistration.SetRange(Semester, StudentRec.Semester)
                            else
                                StudentRegistration.SetRange(Semester, NextSem);
                            StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                            StudentRegistration.SetRange("Apply for Insurance", true);
                            IF StudentRegistration.FindFirst() Then
                                Amt := FeeCourseLine.Amount;
                        end;

                        IF FeeComp."Type Of Fee" = FeeComp."Type Of Fee"::REPATINS then begin
                            Amt := 0;
                            StudentRegistration.Reset();
                            StudentRegistration.SetRange("Student No", StudentRec."No.");
                            IF NextSemFeeGenration = false then
                                StudentRegistration.SetRange("Academic Year", StudentRec."Academic Year")
                            else
                                StudentRegistration.SetRange("Academic Year", NextAdYear);
                            IF NextSemFeeGenration = false then
                                StudentRegistration.SetRange(Semester, StudentRec.Semester)
                            else
                                StudentRegistration.SetRange(Semester, NextSem);
                            StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
                            StudentRegistration.SetRange("Apply for Insurance", false);
                            IF StudentRegistration.FindFirst() Then
                                Amt := FeeCourseLine.Amount;
                        end;
                        TotalAmt += Amt;
                    End;
                Until FeeCourseLine.Next() = 0;

            GrenvilleRealtyFee := GrenvilleFee;
            SemesterFee := TotalAmt - GrenvilleRealtyFee;

            exit(TotalAmt);
        End;
    End;

    procedure CheckGenJournalLineForFee(StudNo: Code[20])
    var
        FeeSetupCS1: Record "Fee Setup-CS";
        // CustomerRec: Record Customer;
        GenJournalLineRec: Record "Gen. Journal Line";
        Stud: Record "Student Master-CS";
    begin
        // CustomerRec.Get(CustNo);
        Stud.Get(StudNo);

        FeeSetupCS1.Reset();
        FeeSetupCS1.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        IF FeeSetupCS1.FindFirst() then;

        GenJournalLineRec.Reset();
        GenJournalLineRec.SetRange("Journal Template Name", FeeSetupCS1."Journal Template Name");
        GenJournalLineRec.SetRange("Journal Batch Name", FeeSetupCS1."Journal Batch Name");
        GenJournalLineRec.SETRANGE("Document Type", GenJournalLineRec."Document Type"::Invoice);
        GenJournalLineRec.SETRANGE("Enrollment No.", Stud."Enrollment No.");
        GenJournalLineRec.SETRANGE("Academic Year", Stud."Academic Year");
        GenJournalLineRec.SETRANGE(Semester, Stud.Semester);
        if GenJournalLineRec.FindFirst() then
            GenJournalLineRec.DeleteAll();

    end;

    //SD-SN-18-12-2020 +
    procedure CheckGenJournalLineForGd2(StudNo: Code[20])
    var
        FeeSetupCS1: Record "Fee Setup-CS";
        // CustomerRec: Record Customer;
        GenJournalLineRec: Record "Gen. Journal Line";
        Stud: Record "Student Master-CS";
        GD2: Code[20];
    begin
        // CustomerRec.Get(CustNo);
        Stud.Get(StudNo);
        FeeSetupCS1.Reset();
        FeeSetupCS1.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        IF FeeSetupCS1.FindFirst() then;

        GenJournalLineRec.Reset();
        GenJournalLineRec.SetCurrentKey("Shortcut Dimension 2 Code");
        GenJournalLineRec.SetRange("Journal Template Name", FeeSetupCS1."Journal Template Name");
        GenJournalLineRec.SetRange("Journal Batch Name", FeeSetupCS1."Journal Batch Name");
        GenJournalLineRec.SETRANGE("Document Type", GenJournalLineRec."Document Type"::Invoice);
        GenJournalLineRec.SETRANGE("Enrollment No.", Stud."Enrollment No.");
        GenJournalLineRec.SETRANGE("Academic Year", Stud."Academic Year");
        GenJournalLineRec.SETRANGE(Semester, Stud.Semester);
        if GenJournalLineRec.FindSet() then begin
            Repeat
                if GD2 = '' then
                    GD2 := GenJournalLineRec."Shortcut Dimension 2 Code"
                Else
                    if GD2 <> GenJournalLineRec."Shortcut Dimension 2 Code" then
                        Error('Global Dimension 2 Code must be Same For All Lines of Journal');
            until GenJournalLineRec.Next() = 0
        end
    end;
    //SD-SN-18-12-2020 -

    procedure RosterCheck(StudentNo: Code[20]; NextSem: Code[20]; NextAdYear: Code[20]; NextSemFeeGenration: Boolean) FAidRosterAmt: Decimal
    var
        FinancialAidRoster: Record "Financial Aid Roster";
        //CustRec1: Record Customer;
        Stud: Record "Student Master-CS";
    begin
        // CustRec1.Get(StudentNo);
        Stud.Get(StudentNo);
        FinancialAidRoster.Reset();
        FinancialAidRoster.SetRange("Student No.", Stud."No.");
        If NextSemesterFeeGeneration = false then
            FinancialAidRoster.SetRange("Academic Year", Stud."Academic Year")
        else
            FinancialAidRoster.SetRange("Academic Year", NextAcademicYearFeeGeneration);
        If NextSemesterFeeGeneration = false then
            FinancialAidRoster.SetRange(Semester, Stud.Semester)
        else
            FinancialAidRoster.SetRange(Semester, NextSemester);
        If FinancialAidRoster.FindSet() then
            repeat
                IF FinancialAidRoster.Status <> FinancialAidRoster.Status::Approved then
                    Error('Financial Aid Roster must be Completely Approved For Student No. %1', FinancialAidRoster."Student No.");
                FAidRosterAmt += FinancialAidRoster."Approved Amount";
            Until FinancialAidRoster.Next() = 0;
        exit(FAidRosterAmt);
    end;



    procedure FinancialAidBudgetCheck(StudentNo: Code[20]; NextSem: Code[20]; NextAdYear: Code[20]; NextSemFeeGenration: Boolean) FAidBudgetAmt: Decimal
    var
        FinancialAid: Record "Financial AID";
        // CustRec1: Record Customer;
        Stud: Record "Student Master-CS";
    begin
        // CustRec1.Get(StudentNo);
        Stud.Get(StudentNo);
        FinancialAid.Reset();
        FinancialAid.SetRange("Student No.", Stud."No.");
        FinancialAid.SetRange(Type, FinancialAid.Type::"Financial Aid");
        FinancialAid.SetRange(Status, FinancialAid.Status::Approved);
        If NextSemesterFeeGeneration = false then
            FinancialAid.SetRange("Academic Year", Stud."Academic Year")
        else
            FinancialAid.SetRange("Academic Year", NextAcademicYearFeeGeneration);
        If NextSemesterFeeGeneration = false then
            FinancialAid.SetRange(Semester, Stud.Semester)
        else
            FinancialAid.SetRange(Semester, NextSemester);
        If FinancialAid.FindFirst() then
            FAidBudgetAmt := FinancialAid."Grad. Plus Transaction Amount" + FinancialAid."Unsubsidized Transation Amount";
        exit(FAidBudgetAmt);

    end;

    procedure GetAppliedDocNo(StudentNo: Code[20]; NextSem: Code[20]; NextAdYear: Code[20]; NextSemFeeGenration: Boolean; DepType: Option "Housing Deposit","Seat Deposit") DocNo: Code[20]
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        // CustRec2: Record Customer;
        Stud: Record "Student Master-CS";
    begin
        Stud.Get(StudentNo);
        // CustRec2.Get(StudentNo);
        CustLedgerEntry.Reset();
        CustLedgerEntry.SETRANGE("Customer No.", Stud."Original Student No.");
        IF NextSemFeeGenration = false then
            CustLedgerEntry.SETRANGE("Academic Year", Stud."Academic Year")
        Else
            CustLedgerEntry.SETRANGE("Academic Year", NextAdYear);
        IF NextSemFeeGenration = false then
            CustLedgerEntry.SETRANGE(Semester, Stud.Semester)
        Else
            CustLedgerEntry.SETRANGE(Semester, NextSem);
        CustLedgerEntry.SETRANGE(Reversed, FALSE);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Payment);
        CustLedgerEntry.SetRange("Enrollment No.", Stud."Enrollment No.");
        IF DepType = DepType::"Housing Deposit" then
            CustLedgerEntry.SETRANGE("Deposit Type", CustLedgerEntry."Deposit Type"::"Housing Deposit");
        IF DepType = DepType::"Seat Deposit" then
            CustLedgerEntry.SETRANGE("Deposit Type", CustLedgerEntry."Deposit Type"::"Seat Deposit");
        IF CustLedgerEntry.findfirst() THEN
            DocNo := CustLedgerEntry."Document No.";
        exit(DocNo);

    end;
    //SD-SN-14-Dec-2020 +
    procedure SetParameter(Gb1: Code[20]; AcademicYearPar: Code[100]; SemesterPar: Code[20]; EnrNoPar: code[20])
    var
    begin
        InstituteCode := Gb1;
        AcademicYear := AcademicYearPar;
        SemesterCode := SemesterPar;
        EnrollmentNo := EnrNoPar;
    end;
    //SD-SN-14-Dec-2020 -
}
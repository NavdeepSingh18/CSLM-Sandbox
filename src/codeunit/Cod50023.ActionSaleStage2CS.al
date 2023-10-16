codeunit 50023 "Action Sale Stage2-CS"
{
    // version V.001-CS

    // Sr.No.  Emp. ID      Date    Trigger                      Remarks
    // 1        CSPL-0009211-05-2019PercentageCalculate          Calculate percentage for eligible applicants
    // 2        CSPL-0009211-05-2019ApplicantsAllotmentUpdate    Update eligible allotment for applicants
    // 3        CSPL-0009211-05-2019CreateRankSelection          Create selectoin rank
    // 4        CSPL-0009211-05-2019CreateRankQuota              Create quota rank
    // 5        CSPL-0009211-05-2019SelectApplicantsEligible    Select eligible applicants
    // 6        CSPL-0009211-05-2019CreateSelectionHistoryStage2Create Selection History for stage2
    // 7        CSPL-0009211-05-2019UpdateQuotaSeatsAlloted      Update quota For allocated seats
    // 8        CSPL-0009211-05-2019TestMinorityQuota            Test minority quota
    // 9        CSPL-0009211-05-2019SelectionProcessStage2      Selection process for stage2
    // 10      CSPL-0009211-05-2019TestApplStage2SelStatus      Test application selectin status
    // 11      CSPL-0009211-05-2019CreatedDetailsClearStage2    Clear generated details stage2
    // 12      CSPL-0009211-05-2019SelectionProcessStartStage2  Start selection process stage2
    // 13      CSPL-0009211-05-2019AdmissionLetterSend          Create admission letter for selected students
    // 14      CSPL-0009211-05-2019SelectionListShow            Show selected students list
    // 15      CSPL-0009211-05-2019WaitingListShow              Show waiting list
    // 16      CSPL-0009211-05-2019DemotionApplicant            Application demotion process
    // 17      CSPL-0009211-05-2019PromotionApplicant          Application promotion process


    trigger OnRun()
    begin
    end;

    var

        CourseEvaluation: Record "Evaluation Course-CS";
        Text000Lbl: Label 'Set Quota Percentage in Admission Setup';
        Text001Lbl: Label 'Already More List Has Been Generated';
        Text002Lbl: Label 'Stage2 Selection Process Has Been Completed';
        Text003Lbl: Label 'Already this Selection List Has been Processed';
        Text004Lbl: Label 'Admission Letter Generation Already Completed';
        Text005Lbl: Label 'Reason Should Be Entered';
        Text008Lbl: Label 'Do you want to Generate Admission Letter ?';
        Text009Lbl: Label 'Do you want to generate Selection Process ?';
        Text010Lbl: Label 'Already This List Has Been Generated. Do u want to Regenerate ?';

    procedure CalculatePercentageCS(CourseCode: Code[20]; "List No.": Integer; AppNum: Code[20]): Decimal
    var
        CourseFormulaDetailsCS: Record "Course Formula Details-CS";
        CourseRankingSummaryCS: Record "Course Ranking Summary-CS";
        AdmissionSetupCS: Record "Admission Setup-CS";
        EvaluationRuleCS: Record "Evaluation Rule -CS";
        ApplicationCS: Record "Application-CS";
        MarkApplicationCS: Record "Mark Application-CS";
        EvaluationApplicantCS: Record "Evaluation Applicant-CS";
        Iterator: Integer;

        IntLoop: Integer;
        DecPercentage: Decimal;

        DecTotalMarkObtained: Decimal;
        DecTotalMaxMark: Decimal;
    //DecMaxPercentage: Decimal;
    // Jterator: Integer;

    begin
        //Code added for Calculate percentage for eligible applicants::CSPL-00092::11-05-2019: Start
        AdmissionSetupCS.GET();
        CourseFormulaDetailsCS.Reset();
        CourseFormulaDetailsCS.SETCURRENTKEY("Course Code", "List No.");
        CourseFormulaDetailsCS.SETRANGE("Course Code", CourseCode);
        CourseFormulaDetailsCS.SETRANGE("List No.", "List No.");
        IF CourseFormulaDetailsCS.FINDFIRST() THEN BEGIN
            FOR Iterator := 1 TO CourseFormulaDetailsCS."No of Ranking Formula" DO
                IntLoop := 0;
            DecPercentage := 0;
            CourseRankingSummaryCS.Reset();
            CourseRankingSummaryCS.SETCURRENTKEY("Course Code", "Course Line No.", "List No.", "Order Number");
            CourseRankingSummaryCS.SETRANGE("Course Code", CourseCode);
            CourseRankingSummaryCS.SETRANGE("Course Line No.", CourseFormulaDetailsCS."Line No.");
            CourseRankingSummaryCS.SETRANGE("List No.", "List No.");
            CourseRankingSummaryCS.SETRANGE("Order Number", Iterator);
            IF CourseRankingSummaryCS.FINDSET() THEN
                REPEAT
                    IF CourseRankingSummaryCS.Type = CourseRankingSummaryCS.Type::"Prequalification Subjects" THEN BEGIN
                        MarkApplicationCS.Reset();
                        MarkApplicationCS.SETRANGE("Application No", AppNum);
                        MarkApplicationCS.SETRANGE(Code, CourseRankingSummaryCS.Code);
                        IF MarkApplicationCS.FINDFIRST() THEN
                            DecPercentage += (MarkApplicationCS."Mark Obtained" / MarkApplicationCS.Maximum) * CourseRankingSummaryCS.Percentage
                        ELSE BEGIN
                            DecPercentage := 0;
                            IntLoop := 1;
                        END;
                    END ELSE BEGIN
                        IF CourseRankingSummaryCS.Type = CourseRankingSummaryCS.Type::Evaluation THEN BEGIN
                            CourseEvaluation.Reset();
                            CourseEvaluation.SETRANGE("Course Code", CourseCode);
                            CourseEvaluation.SETRANGE("Evaluation Method Code", CourseRankingSummaryCS.Code);
                            IF CourseEvaluation.FINDFIRST() THEN BEGIN
                                EvaluationRuleCS.GET(CourseRankingSummaryCS.Code);
                                IF EvaluationRuleCS.Type = EvaluationRuleCS.Type::Internal THEN BEGIN
                                    IF EvaluationApplicantCS.GET(AppNum, CourseRankingSummaryCS.Code) THEN
                                        DecPercentage += ((EvaluationApplicantCS."Mark Obtained" / CourseEvaluation."Maximum Mark") * CourseRankingSummaryCS.Percentage)
                                    ELSE BEGIN
                                        DecPercentage := 0;
                                        IntLoop := 1;
                                    END;
                                END ELSE
                                    IF EvaluationRuleCS.Type = EvaluationRuleCS.Type::External THEN BEGIN
                                        MarkApplicationCS.Reset();
                                        MarkApplicationCS.SETRANGE("Application No", AppNum);
                                        MarkApplicationCS.SETRANGE(Type, MarkApplicationCS.Type::"Evaluation");
                                        MarkApplicationCS.SETRANGE(Code, CourseRankingSummaryCS.Code);
                                        IF MarkApplicationCS.FINDFIRST() THEN
                                            DecPercentage += ((MarkApplicationCS."Mark Obtained" / MarkApplicationCS.Maximum) * CourseRankingSummaryCS.Percentage)
                                        ELSE BEGIN
                                            DecPercentage := 0;
                                            IntLoop := 1;
                                        END;
                                    END;
                            END;
                        END ELSE
                            IF CourseRankingSummaryCS.Type = CourseRankingSummaryCS.Type::Category THEN
                                IF CourseRankingSummaryCS.Code = AdmissionSetupCS."Stage1 Category Code" THEN
                                    IF ApplicationCS.GET(AppNum) THEN
                                        DecPercentage += (ApplicationCS."Eligibility Percertage" / 100) * CourseRankingSummaryCS.Percentage
                                    ELSE
                                        DecTotalMarkObtained := 0;
                        DecTotalMaxMark := 0;
                        MarkApplicationCS.Reset();
                        MarkApplicationCS.SETRANGE("Application No", AppNum);
                        IF AdmissionSetupCS."Total Marks Category Code" <> CourseRankingSummaryCS.Code THEN
                            MarkApplicationCS.SETRANGE(Category, CourseRankingSummaryCS.Code)
                        ELSE
                            MarkApplicationCS.SETFILTER(Category, '<>%1', AdmissionSetupCS."Evaluation Category Code");
                        IF MarkApplicationCS.FINDSET() THEN
                            REPEAT
                                DecTotalMarkObtained += MarkApplicationCS."Mark Obtained";
                                DecTotalMaxMark += MarkApplicationCS.Maximum;
                            UNTIL MarkApplicationCS.NEXT() = 0;
                        DecPercentage += (DecTotalMarkObtained / DecTotalMaxMark) * CourseRankingSummaryCS.Percentage;
                    END;

                UNTIL (CourseRankingSummaryCS.NEXT() = 0) OR (IntLoop = 1);

        END;
        EXIT(DecPercentage);
        //Code added for Calculate percentage for eligible applicants::CSPL-00092::11-05-2019: End
    end;

    procedure ApplicantsAllotmentUpdateCS(CourseCode: Code[20]; "List No.": Integer; Strength: Integer)
    var
        ApplicationCS: Record "Application-CS";
        PercentageQuotaCS: Record "Percentage Quota-CS";
        IntTotalseat: Integer;
        IntSeat: Integer;
    begin
        //Code added for Update eligible allotment for applicants::CSPL-00092::11-05-2019: Start
        IntTotalseat := 0;
        PercentageQuotaCS.Reset();
        PercentageQuotaCS.SETCURRENTKEY("Round of Compensation");
        PercentageQuotaCS.SETRANGE("Round of Compensation", FALSE);
        IF PercentageQuotaCS.FINDSET() THEN
            REPEAT
                PercentageQuotaCS.Numofseat := ROUND(PercentageQuotaCS.Percentage * Strength / 100, 1, '=');
                IntTotalseat += PercentageQuotaCS.Numofseat;
                PercentageQuotaCS.Modify();
            UNTIL PercentageQuotaCS.NEXT() = 0;

        PercentageQuotaCS.Reset();
        PercentageQuotaCS.SETCURRENTKEY("Round of Compensation");
        PercentageQuotaCS.SETRANGE("Round of Compensation", TRUE);
        IF PercentageQuotaCS.FINDFIRST() THEN BEGIN
            PercentageQuotaCS.Numofseat := Strength - IntTotalseat;
            PercentageQuotaCS.Modify();
        END;

        CreateRankSelectionCS(CourseCode, "List No.");

        PercentageQuotaCS.Reset();
        PercentageQuotaCS.SETCURRENTKEY(Order);
        IF PercentageQuotaCS.FINDSET() THEN
            REPEAT
                IntSeat := 1;
                ApplicationCS.Reset();
                ApplicationCS.SETCURRENTKEY("Course Code", "Application Selection", "Rank Selection",
                  Alloted, "Stage2 Selection List No.", "Selection Percentage");
                ApplicationCS.ASCENDING(FALSE);
                ApplicationCS.SETRANGE("Course Code", CourseCode);
                ApplicationCS.SETRANGE("Application Selection", TRUE);
                ApplicationCS.SETRANGE("Rank Selection", TRUE);
                ApplicationCS.SETRANGE(Alloted, FALSE);
                ApplicationCS.SETRANGE("Stage2 Selection List No.", "List No.");
                IF NOT PercentageQuotaCS."Open Competition" THEN
                    ApplicationCS.SETRANGE(Quota, PercentageQuotaCS."Qutoa Code");
                IF ApplicationCS.FINDFIRST() THEN
                    REPEAT
                        IF IntSeat <= PercentageQuotaCS.Numofseat THEN BEGIN
                            ApplicationCS.Alloted := TRUE;
                            ApplicationCS."Selected Quota" := PercentageQuotaCS."Qutoa Code";
                            ApplicationCS.Modify();
                            IntSeat += 1;
                        END;
                    UNTIL (ApplicationCS.NEXT() = 0) OR (IntSeat = PercentageQuotaCS.Numofseat);
                CreateRankQuotaCS(CourseCode, "List No.", PercentageQuotaCS."Qutoa Code");
            UNTIL PercentageQuotaCS.NEXT() = 0;
        //Code added for Update eligible allotment for applicants::CSPL-00092::11-05-2019: End
    end;

    procedure CreateRankSelectionCS(CourseCode: Code[20]; "List No.": Integer)
    var
        ApplicationCS: Record "Application-CS";
        StudentRankCS: Record "Student Rank-CS";
        StudentRankCS1: Record "Student Rank-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        Startnum: Code[20];
        // IntRank: Integer;
        Endnum: Code[20];

    begin
        //Code added for Create selectoin rank::CSPL-00092::11-05-2019: Start
        StudentRankCS.LOCKTABLE();
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Course Code", "Application Selection", "Rank Selection",
          "Stage2 Selection List No.", "Selection Percentage");
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Application Selection", TRUE);
        ApplicationCS.SETRANGE("Rank Selection", TRUE);
        ApplicationCS.SETRANGE("Stage2 Selection List No.", "List No.");

        IF ApplicationCS.FINDSET() THEN
            REPEAT
                StudentRankCS.INIT();
                StudentRankCS."No." := ApplicationCS."No.";
                StudentRankCS.Average := ApplicationCS."Selection Percentage";
                StudentRankCS.INSERT(TRUE);
            UNTIL ApplicationCS.NEXT() = 0;

        IF ApplicationCS.FINDFIRST() THEN
            IF StudentRankCS.GET(ApplicationCS."No.") THEN
                Startnum := StudentRankCS."Entry No.";

        IF ApplicationCS.FINDLAST() THEN
            IF StudentRankCS.GET(ApplicationCS."No.") THEN
                Endnum := StudentRankCS."Entry No.";

        VerticalEducationCS.RankCreation(Startnum, Endnum);

        StudentRankCS.Reset();
        StudentRankCS.SETRANGE("Entry No.", Startnum, Endnum);
        IF StudentRankCS.FINDSET() THEN
            REPEAT
                IF ApplicationCS.GET(StudentRankCS."No.") THEN BEGIN
                    ApplicationCS."Selection Rank" := StudentRankCS.Rank;
                    ApplicationCS.Modify();
                END;
            UNTIL StudentRankCS.NEXT() = 0;

        StudentRankCS1.Reset();
        StudentRankCS1.SETRANGE("Entry No.", Startnum, Endnum);
        IF StudentRankCS1.FINDSET() THEN
            StudentRankCS1.DELETEALL();
        //Code added for Create selectoin rank::CSPL-00092::11-05-2019: End
    end;

    procedure CreateRankQuotaCS(CourseCode: Code[20]; "List No.": Integer; Quota: Code[20])
    var
        ApplicationCS: Record "Application-CS";
        StudentRankCS1: Record "Student Rank-CS";
        StudentRankCS: Record "Student Rank-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        Startnum: Code[20];
        // IntRank: Integer;
        Endnum: Code[20];

    begin
        //Code added for Create quota rank::CSPL-00092::11-05-2019: Start
        StudentRankCS.LOCKTABLE();
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Course Code", "Application Selection", "Rank Selection",
          "Stage2 Selection List No.", "Selection Percentage");
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Application Selection", TRUE);
        ApplicationCS.SETRANGE("Rank Selection", TRUE);
        ApplicationCS.SETRANGE("Stage2 Selection List No.", "List No.");
        ApplicationCS.SETRANGE(Quota, Quota);
        IF ApplicationCS.FINDSET() THEN
            REPEAT
                StudentRankCS.INIT();
                StudentRankCS."No." := ApplicationCS."No.";
                StudentRankCS.Average := ApplicationCS."Selection Percentage";
                StudentRankCS.INSERT(TRUE);
            UNTIL ApplicationCS.NEXT() = 0;

        IF ApplicationCS.FINDFIRST() THEN
            IF StudentRankCS.GET(ApplicationCS."No.") THEN
                Startnum := StudentRankCS."Entry No.";

        IF ApplicationCS.FINDLAST() THEN
            IF StudentRankCS.GET(ApplicationCS."No.") THEN
                Endnum := StudentRankCS."Entry No.";

        VerticalEducationCS.RankCreation(Startnum, Endnum);
        StudentRankCS.Reset();
        StudentRankCS.SETRANGE("Entry No.", Startnum, Endnum);
        IF StudentRankCS.FINDSET() THEN
            REPEAT
                IF ApplicationCS.GET(StudentRankCS."No.") THEN BEGIN
                    ApplicationCS."Selected Quota Rank" := StudentRankCS.Rank;
                    ApplicationCS.Modify();
                END;
            UNTIL StudentRankCS.NEXT() = 0;

        StudentRankCS1.Reset();
        StudentRankCS1.SETRANGE("Entry No.", Startnum, Endnum);
        IF StudentRankCS1.FINDSET() THEN
            StudentRankCS1.DELETEALL();
        //Code added for Create quota rank::CSPL-00092::11-05-2019: End
    end;

    procedure SelectApplicantsEligibleCS(CourseCode: Code[20]; "List No.": Integer; AppRecDate: Date; blReserve: Boolean; blStaffChild: Boolean; blBreakStud: Boolean; AcadmicYear: Code[20])
    var
        ApplicationCS: Record "Application-CS";
        DecAppPercentage: Decimal;
    //DecEligiblePercentage: Decimal;
    begin
        //Code added for Select eligible applicants::CSPL-00092::11-05-2019: Start
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Course Code", "Application Status", Alloted,
          "Application Selection", "Date of Receive", "Stage1 Selection List No.");
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Application Status", ApplicationCS."Application Status"::Received);
        ApplicationCS.SETRANGE(Alloted, FALSE);
        ApplicationCS.SETRANGE("Application Selection", TRUE);
        ApplicationCS.SETFILTER("Date of Receive", '<=%1', AppRecDate);
        ApplicationCS.SETRANGE("Stage1 Selection List No.", "List No.");
        ApplicationCS.SETRANGE(ApplicationCS."Academic Year", AcadmicYear);
        IF NOT blBreakStud THEN
            ApplicationCS.SETRANGE("Break In Study", FALSE);
        IF ApplicationCS.FINDSET() THEN
            REPEAT
                IF blReserve AND TestMinorityQuotaCS(ApplicationCS.Quota) THEN
                    ApplicationCS."Rank Selection" := TRUE;

                IF blStaffChild AND ApplicationCS."Staff Child" THEN
                    ApplicationCS."Rank Selection" := TRUE;

                DecAppPercentage := 0;
                DecAppPercentage := CalculatePercentageCS(CourseCode, "List No.", ApplicationCS."No.");
                IF DecAppPercentage <> 0 THEN BEGIN
                    ApplicationCS."Selection Percentage" := DecAppPercentage;
                    ApplicationCS."Rank Selection" := TRUE;
                    ApplicationCS."Stage2 Selection List No." := "List No.";
                    ApplicationCS.Modify();
                END;
            UNTIL ApplicationCS.NEXT() = 0;

        //Code added for Select eligible applicants::CSPL-00092::11-05-2019: End
    end;

    procedure CreateSelectionHistoryStage2CS(CourseCode: Code[20]; "List No.": Integer; ProcessedDate: Date)
    var
        StageSelectionDetails2CS: Record "Stage Selection Details2-CS";

        ApplicationCS: Record "Application-CS";
        "EntryNo.": Integer;
    begin
        //Code added for Create Selection History for stage2::CSPL-00092::11-05-2019: Start
        StageSelectionDetails2CS.Reset();
        StageSelectionDetails2CS.SETCURRENTKEY("Course Code", "Selection List No.");
        StageSelectionDetails2CS.SETRANGE("Course Code", CourseCode);
        StageSelectionDetails2CS.SETRANGE("Selection List No.", "List No.");
        IF StageSelectionDetails2CS.FINDFIRST() THEN
            StageSelectionDetails2CS.DELETEALL();

        StageSelectionDetails2CS.Reset();
        IF StageSelectionDetails2CS.FINDLAST() THEN
            "EntryNo." := StageSelectionDetails2CS."Entry No.";

        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Course Code", "Stage2 Selection List No.", Alloted, Quota);
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Stage2 Selection List No.", "List No.");
        ApplicationCS.SETRANGE("Rank Selection", TRUE);
        IF ApplicationCS.FINDSET() THEN
            REPEAT
                "EntryNo." += 1;
                StageSelectionDetails2CS.INIT();
                StageSelectionDetails2CS."Entry No." := "EntryNo.";
                StageSelectionDetails2CS."Application No." := ApplicationCS."No.";
                StageSelectionDetails2CS."Applicant Name" := ApplicationCS."Applicant Name";
                StageSelectionDetails2CS."Course Code" := CourseCode;
                StageSelectionDetails2CS."Application Selection" := ApplicationCS."Application Selection";
                StageSelectionDetails2CS."Eligibility Percertage" := ApplicationCS."Eligibility Percertage";
                StageSelectionDetails2CS."Eligibility Rank" := ApplicationCS."Eligibility Rank";
                StageSelectionDetails2CS."Eligibility Quota" := ApplicationCS."Eligibilty Quota";
                StageSelectionDetails2CS."Eligibility Quota Rank" := ApplicationCS."Eligibility Quota Rank";
                StageSelectionDetails2CS."Rank Selection" := ApplicationCS."Rank Selection";
                StageSelectionDetails2CS."Selection Percentage" := ApplicationCS."Selection Percentage";
                StageSelectionDetails2CS."Selection Rank" := ApplicationCS."Selection Rank";
                StageSelectionDetails2CS."Selected Quota Rank" := ApplicationCS."Selected Quota Rank";
                StageSelectionDetails2CS."Selected Quota" := ApplicationCS."Selected Quota";
                StageSelectionDetails2CS.Alloted := ApplicationCS.Alloted;
                StageSelectionDetails2CS."Selection List No." := ApplicationCS."Stage2 Selection List No.";
                StageSelectionDetails2CS."Processed Date" := ProcessedDate;
                StageSelectionDetails2CS.Quota := ApplicationCS.Quota;
                StageSelectionDetails2CS.INSERT();
            UNTIL ApplicationCS.NEXT() = 0;
        //Code added for Create Selection History for stage2::CSPL-00092::11-05-2019: End
    end;

    procedure UpdateQuotaSeatsAllotedCS(CourseCode: Code[20]; "List No.": Integer; "Document No.": Code[20])
    var
        SelProcessStageL2CS: Record "Sel Process Stage L2-CS";
        PercentageQuotaCS: Record "Percentage Quota-CS";

        ApplicationCS: Record "Application-CS";
        "IntLineNo.": Integer;
    begin
        //Code added for Update quota For allocated seats::CSPL-00092::11-05-2019: Start
        SelProcessStageL2CS.Reset();
        SelProcessStageL2CS.SETCURRENTKEY("Course Code", "Stage2 Selection List No.");
        SelProcessStageL2CS.SETRANGE("Course Code", CourseCode);
        SelProcessStageL2CS.SETRANGE("Stage2 Selection List No.", "List No.");
        IF SelProcessStageL2CS.FINDFIRST() THEN
            SelProcessStageL2CS.DELETEALL();
        IF PercentageQuotaCS.FINDSET() THEN
            REPEAT
                "IntLineNo." += 1;
                SelProcessStageL2CS.INIT();
                SelProcessStageL2CS."Document No." := "Document No.";
                SelProcessStageL2CS."Line No." := "IntLineNo.";
                SelProcessStageL2CS."Course Code" := CourseCode;
                SelProcessStageL2CS."Stage2 Selection List No." := "List No.";
                SelProcessStageL2CS."Quota Code" := PercentageQuotaCS."Qutoa Code";
                SelProcessStageL2CS.Capacity := PercentageQuotaCS.Numofseat;
                ApplicationCS.Reset();
                ApplicationCS.SETCURRENTKEY("Course Code", "Stage2 Selection List No.", Alloted,
                  Quota);
                ApplicationCS.SETRANGE("Course Code", CourseCode);
                ApplicationCS.SETRANGE("Stage2 Selection List No.", "List No.");
                ApplicationCS.SETRANGE(Alloted, TRUE);
                ApplicationCS.SETRANGE(Quota, PercentageQuotaCS."Qutoa Code");
                SelProcessStageL2CS.Alloted := ApplicationCS.count();
                SelProcessStageL2CS.INSERT();
            UNTIL PercentageQuotaCS.NEXT() = 0;
        //Code added for Update quota For allocated seats::CSPL-00092::11-05-2019: End
    end;

    procedure TestMinorityQuotaCS(QuotaCode: Code[20]) blMinority: Boolean
    var
        QuotaCS: Record "Quota-CS";
    begin
        //Code added for Test minority quota::CSPL-00092::11-05-2019: Start
        blMinority := FALSE;
        IF QuotaCS.GET(QuotaCode) THEN
            blMinority := QuotaCS.Reserve;
        //Code added for Test minority quota::CSPL-00092::11-05-2019: End
    end;

    procedure SelectionProcessStage2CS(SelHeadNo2: Code[20]; AcadYear: Code[20])
    var
        SelProcessStageH2CS: Record "Sel Process Stage H2-CS";
        PercentageQuotaCS: Record "Percentage Quota-CS";
        CourseMasterCS: Record "Course Master-CS";
    begin
        //Code added for Selection process for stage2::CSPL-00092::11-05-2019: Start
        SelProcessStageH2CS.GET(SelHeadNo2);
        SelProcessStageH2CS.TESTFIELD("Course Code");
        SelProcessStageH2CS.TESTFIELD("Stage2 Selection List No.");
        SelProcessStageH2CS.TESTFIELD("Number of Students");
        SelProcessStageH2CS.TESTFIELD("Application Receive Till Date");
        PercentageQuotaCS.Reset();
        IF NOT PercentageQuotaCS.FINDFIRST() THEN
            ERROR(Text000Lbl);

        CourseMasterCS.GET(SelProcessStageH2CS."Course Code");

        IF (CourseMasterCS."Last Stage1 Generated List No." <> 0) AND
           (CourseMasterCS."Last Stage1 Generated List No." > SelProcessStageH2CS."Stage2 Selection List No.")
        THEN
            ERROR(Text001Lbl);

        TestApplStage2SelStatusCS(SelProcessStageH2CS."Course Code", SelProcessStageH2CS."Stage2 Selection List No.");

        IF CONFIRM(Text009Lbl) THEN BEGIN
            IF CourseMasterCS."Last Stage2 Generated List No." = SelProcessStageH2CS."Stage2 Selection List No." THEN BEGIN
                IF CONFIRM(Text010Lbl) THEN BEGIN
                    CreatedDetailsClearStage2CS(SelProcessStageH2CS."Course Code", SelProcessStageH2CS."Stage2 Selection List No.", AcadYear);
                    SelectionProcessStartStage2CS(SelProcessStageH2CS."Course Code", SelProcessStageH2CS."Stage2 Selection List No.",
                     SelProcessStageH2CS."Application Receive Till Date", SelProcessStageH2CS."Excempt Rules - Reserve Quota",
                     SelProcessStageH2CS."Excempt Rules - Staff Child", SelProcessStageH2CS."Consider Break Students",
                     SelProcessStageH2CS."Number of Students", SelProcessStageH2CS."No.", AcadYear);
                END;
            END ELSE
                SelectionProcessStartStage2CS(SelProcessStageH2CS."Course Code", SelProcessStageH2CS."Stage2 Selection List No.",
                  SelProcessStageH2CS."Application Receive Till Date", SelProcessStageH2CS."Excempt Rules - Reserve Quota",
                  SelProcessStageH2CS."Excempt Rules - Staff Child", SelProcessStageH2CS."Consider Break Students",
                  SelProcessStageH2CS."Number of Students", SelProcessStageH2CS."No.", AcadYear);
            CourseMasterCS."Last Stage2 Generated List No." := SelProcessStageH2CS."Stage2 Selection List No.";
            CourseMasterCS.Modify();
            SelProcessStageH2CS."Processed Date" := WORKDATE();
            SelProcessStageH2CS.Modify();
            MESSAGE(Text002Lbl);
        END;
        //Code added for Selection process for stage2::CSPL-00092::11-05-2019: End
    end;

    procedure TestApplStage2SelStatusCS(CourseCode: Code[20]; SelListNo: Integer)
    var
        ApplicationCS: Record "Application-CS";
    begin
        //Code added for Test application selectin status::CSPL-00092::11-05-2019: Start
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Application Status", "Course Code", "Stage2 Selection List No.", "Call Letter Sent");
        ApplicationCS.SETRANGE("Application Status", ApplicationCS."Application Status"::Received);
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Stage2 Selection List No.", SelListNo);
        ApplicationCS.SETRANGE("Admission Letter Sent", TRUE);
        IF ApplicationCS.FINDFIRST() THEN
            ERROR(Text003Lbl);
        //Code added for Test application selectin status::CSPL-00092::11-05-2019: End
    end;

    procedure CreatedDetailsClearStage2CS(CourseCode: Code[20]; SelListNo: Integer; AcadmicYear: Code[20])
    var
        ApplicationCS: Record "Application-CS";
    begin
        //Code added for Clear generated details stage2::CSPL-00092::11-05-2019: Start
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Application Status", "Course Code", "Stage2 Selection List No.");
        ApplicationCS.SETRANGE("Application Status", ApplicationCS."Application Status"::Received);
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Stage2 Selection List No.", SelListNo);
        ApplicationCS.SETRANGE("Rank Selection", TRUE);
        ApplicationCS.SETRANGE(ApplicationCS."Academic Year", AcadmicYear);
        IF ApplicationCS.FINDSET(TRUE, TRUE) THEN BEGIN
            ApplicationCS.MODIFYALL(Alloted, FALSE);
            ApplicationCS.MODIFYALL("Selected Quota", '');
            ApplicationCS.MODIFYALL("Rank Selection", FALSE);
            ApplicationCS.MODIFYALL("Selection Rank", 0);
            ApplicationCS.MODIFYALL("Selection Percentage", 0);
            ApplicationCS.MODIFYALL("Selected Quota Rank", 0);
            ApplicationCS.MODIFYALL("Stage2 Selection List No.", 0);
        END;
        //Code added for Clear generated details stage2::CSPL-00092::11-05-2019: End
    end;

    procedure SelectionProcessStartStage2CS(CourseCode: Code[20]; "List No.": Integer; AppRecDate: Date; blReserve: Boolean; blStaffChild: Boolean; blBreakStud: Boolean; intNumofStudents: Integer; "cdeNo.": Code[20]; AcadYear: Code[20])
    begin
        //Code added for Start selection process stage2::CSPL-00092::11-05-2019: Start
        SelectApplicantsEligibleCS(CourseCode, "List No.", AppRecDate, blReserve, blStaffChild, blBreakStud, AcadYear);
        ApplicantsAllotmentUpdateCS(CourseCode, "List No.", intNumofStudents);
        UpdateQuotaSeatsAllotedCS(CourseCode, "List No.", "cdeNo.");
        CreateSelectionHistoryStage2CS(CourseCode, "List No.", WORKDATE());
        //Code added for Start selection process stage2::CSPL-00092::11-05-2019: End
    end;

    procedure AdmissionLetterSendCS(CourseCode: Code[20]; SelListNo: Integer)
    var
        ApplicationCS: Record "Application-CS";
    begin
        //Code added for Create admission letter for selected students::CSPL-00092::11-05-2019: Start
        IF CONFIRM(Text008Lbl, TRUE) THEN BEGIN
            ApplicationCS.Reset();
            ApplicationCS.SETCURRENTKEY("Course Code", "Stage2 Selection List No.", Alloted, "Admission Letter Sent");
            ApplicationCS.SETRANGE("Course Code", CourseCode);
            ApplicationCS.SETRANGE("Stage2 Selection List No.", SelListNo);
            ApplicationCS.SETRANGE(Alloted, TRUE);
            ApplicationCS.SETRANGE("Admission Letter Sent", TRUE);
            IF ApplicationCS.COUNT() > 0 THEN
                MESSAGE(Text004Lbl)
            ELSE BEGIN
                ApplicationCS.Reset();
                ApplicationCS.SETCURRENTKEY("Course Code", "Stage2 Selection List No.", Alloted, "Admission Letter Sent");
                ApplicationCS.SETRANGE("Course Code", CourseCode);
                ApplicationCS.SETRANGE("Stage2 Selection List No.", SelListNo);
                ApplicationCS.SETRANGE(Alloted, TRUE);
                IF ApplicationCS.FINDSET() THEN
                    ApplicationCS.MODIFYALL("Admission Letter Sent", TRUE);
            END;
            ApplicationCS.Reset();
            ApplicationCS.SETCURRENTKEY("Course Code", "Stage2 Selection List No.", Alloted, "Admission Letter Sent");
            ApplicationCS.SETRANGE("Course Code", CourseCode);
            ApplicationCS.SETRANGE("Stage2 Selection List No.", SelListNo);
            ApplicationCS.SETRANGE(Alloted, TRUE);
            IF ApplicationCS.FINDSET() THEN
                REPORT.RUN(33049767, TRUE, FALSE, ApplicationCS);
        END;
        //Code added for Create admission letter for selected students::CSPL-00092::11-05-2019: End
    end;

    procedure SelectionListShowCS(CourseCode: Code[20]; SelListNo: Integer)
    var
        StageSelectionDetails2CS: Record "Stage Selection Details2-CS";
    begin
        //Code added for Show selected students list::CSPL-00092::11-05-2019: Start
        StageSelectionDetails2CS.Reset();
        StageSelectionDetails2CS.SETCURRENTKEY("Course Code", "Selection List No.", "Application Selection", "Rank Selection", Alloted);
        StageSelectionDetails2CS.SETRANGE("Course Code", CourseCode);
        StageSelectionDetails2CS.SETRANGE("Selection List No.", SelListNo);
        StageSelectionDetails2CS.SETRANGE("Application Selection", TRUE);
        StageSelectionDetails2CS.SETRANGE("Rank Selection", TRUE);
        StageSelectionDetails2CS.SETRANGE(Alloted, TRUE);
        IF PAGE.RUNMODAL(33049386, StageSelectionDetails2CS) = ACTION::LookupOK THEN;
        //Code added for Show selected students list::CSPL-00092::11-05-2019: End
    end;

    procedure WaitingListShowCS(CourseCode: Code[20]; SelListNo: Integer)
    var
        StageSelectionDetails2CS: Record "Stage Selection Details2-CS";
    begin
        //Code added for Show waiting list::CSPL-00092::11-05-2019: Start
        StageSelectionDetails2CS.Reset();
        StageSelectionDetails2CS.SETCURRENTKEY("Course Code", "Selection List No.", "Application Selection", "Rank Selection", Alloted);
        StageSelectionDetails2CS.SETRANGE("Course Code", CourseCode);
        StageSelectionDetails2CS.SETRANGE("Selection List No.", SelListNo);
        StageSelectionDetails2CS.SETRANGE("Application Selection", TRUE);
        StageSelectionDetails2CS.SETRANGE("Rank Selection", TRUE);
        StageSelectionDetails2CS.SETRANGE(Alloted, FALSE);
        IF PAGE.RUNMODAL(33049387, StageSelectionDetails2CS) = ACTION::LookupOK THEN;
        //Code added for Show waiting list::CSPL-00092::11-05-2019: End
    end;

    procedure DemotionApplicantCS(AppNum: Code[20]; CourseCode: Code[20]; "SelListNo.": Integer)
    var
        ApplicationCS: Record "Application-CS";
        StageSelectionDetails2CS: Record "Stage Selection Details2-CS";
    begin
        //Code added for Application demotion process::CSPL-00092::11-05-2019: Start
        StageSelectionDetails2CS.Reset();
        StageSelectionDetails2CS.SETCURRENTKEY("Course Code", "Selection List No.", "Application No.");
        StageSelectionDetails2CS.SETRANGE("Course Code", CourseCode);
        StageSelectionDetails2CS.SETRANGE("Selection List No.", "SelListNo.");
        StageSelectionDetails2CS.SETRANGE("Application No.", AppNum);
        IF StageSelectionDetails2CS.FINDFIRST() THEN BEGIN
            ApplicationCS.Reset();
            ApplicationCS.SETCURRENTKEY("Course Code", "Stage2 Selection List No.", Alloted, "Admission Letter Sent");
            ApplicationCS.SETRANGE("Course Code", CourseCode);
            ApplicationCS.SETRANGE("Stage2 Selection List No.", "SelListNo.");
            ApplicationCS.SETRANGE(Alloted, TRUE);
            ApplicationCS.SETRANGE("Admission Letter Sent", TRUE);
            IF ApplicationCS.COUNT() > 0 THEN
                ERROR(Text004Lbl);

            IF StageSelectionDetails2CS."Reason For Demotion" = '' THEN
                ERROR(Text005Lbl);

            IF ApplicationCS.GET(AppNum) THEN BEGIN
                ApplicationCS."Is Promoted" := StageSelectionDetails2CS."Is Promoted";
                ApplicationCS."Is Demoted" := StageSelectionDetails2CS."Is Demoted";
                ApplicationCS."Reason For Demotion" := StageSelectionDetails2CS."Reason For Demotion";
                ApplicationCS.Modify();
            END;

        END;
        //Code added for Application demotion process::CSPL-00092::11-05-2019: End
    end;

    procedure PromotionApplicantCS(AppNum: Code[20]; CourseCode: Code[20]; "SelListNo.": Integer)
    var
        ApplicationCS: Record "Application-CS";
        StageSelectionDetails2CS: Record "Stage Selection Details2-CS";
    begin
        //Code added for Application promotion process::CSPL-00092::11-05-2019: Start
        StageSelectionDetails2CS.Reset();
        StageSelectionDetails2CS.SETCURRENTKEY("Course Code", "Selection List No.", "Application No.");
        StageSelectionDetails2CS.SETRANGE("Course Code", CourseCode);
        StageSelectionDetails2CS.SETRANGE("Selection List No.", "SelListNo.");
        StageSelectionDetails2CS.SETRANGE("Application No.", AppNum);
        IF StageSelectionDetails2CS.FINDFIRST() THEN BEGIN
            StageSelectionDetails2CS.TESTFIELD("Course Code");
            StageSelectionDetails2CS.TESTFIELD("Selection List No.");
            StageSelectionDetails2CS.TESTFIELD("Application No.");
            ApplicationCS.Reset();
            ApplicationCS.SETCURRENTKEY("Course Code", "Stage2 Selection List No.", Alloted, "Admission Letter Sent");
            ApplicationCS.SETRANGE("Course Code", CourseCode);
            ApplicationCS.SETRANGE("Stage2 Selection List No.", "SelListNo.");
            ApplicationCS.SETRANGE(Alloted, TRUE);
            ApplicationCS.SETRANGE("Admission Letter Sent", TRUE);
            IF ApplicationCS.COUNT() > 0 THEN
                ERROR(Text004Lbl);

            IF StageSelectionDetails2CS."Reason For Promotion" = '' THEN
                ERROR(Text005Lbl);

            IF ApplicationCS.GET(AppNum) THEN BEGIN
                ApplicationCS."Is Promoted" := StageSelectionDetails2CS."Is Promoted";
                ApplicationCS."Is Demoted" := StageSelectionDetails2CS."Is Demoted";
                ApplicationCS."Reason For Promotion" := StageSelectionDetails2CS."Reason For Promotion";
                ApplicationCS.Modify();
            END;

        END;
        //Code added for Application promotion process::CSPL-00092::11-05-2019: End
    end;
}


codeunit 50022 "Action Sale Stage1-CS"
{
    // version V.001-CS

    //   Sr.No  Emp.ID      Date                Trigger                                              Remark
    // ------------------------------------------------------------------------------------------------------------------------------------
    //   01     CSPL-00059   20/02/2019        SelectEligibleStudent()-Function                 Code added for select eligible applicants for Course Seletion
    //   02     CSPL-00059   20/02/2019        CheckMinorityQuotaValidation()-Function          Code added for Check the Minority Quota
    //   03     CSPL-00059   20/02/2019        CheckEligibleSubjectsValid()-Function            Code added for check the applicants has eligible subjects
    //   04     CSPL-00059   20/02/2019        GenerateApplEligibleRankValid()-Function         Code added for generate application eligible rank
    //   05     CSPL-00059   20/02/2019        UpdateQuotaAllotedSeatsValid()-Function          Code added for update the quota alloted seats
    //   06     CSPL-00059   20/02/2019        GenerateStage1SelectionHistoryValid()-Function   Code added for Generage Stage1 Selection History
    //   07     CSPL-00059   20/02/2019        UpdateEligibleApplicantsValid()-Function         Code added for update the eligible candidate for a Selection
    //   08     CSPL-00059   20/02/2019        GenerateEligibilityQuotaRankVCS()-Function       Code added for generate eligibility quota rank
    //   09     CSPL-00059   20/02/2019        Stage1SelectionProcessValid()-Function           Code added for stage1 Selection Process
    //   10     CSPL-00059   20/02/2019        ClearStage1GeneratedDetailsVCS()-Function        Code added for clear the stage1 generated details
    //   11     CSPL-00059   20/02/2019        StartStage1SelectionProcessValid()-Function      Code added for start Stage1 Selection Process
    //   12     CSPL-00059   20/02/2019        CheckApplStage1SelStatusValid()-Function         Code added for check the Application Selection Status
    //   13     CSPL-00059   20/02/2019        CheckApplicantAgeValid()-Function                Code added for check the Applicant Age with course eligible age
    //   14     CSPL-00059   20/02/2019        SendCallLetterValid()-Function                   Code added for generate call letter for eligible applicants
    //   15     CSPL-00059   20/02/2019        ShowSelectionListVlid()-Function                 Code added for show the selected applicants
    //   16     CSPL-00059   20/02/2019        ShowWaitingListValid()-Function                   Code added for show the waiting list applicants
    //   17     CSPL-00059   20/02/2019        CheckCoursePrequalificationValid()-Function       Code added for check the applicant has eligible prequalification


    trigger OnRun()
    begin
    end;

    var

        Text000Lbl: Label 'Set Quota Percentage in Admission Setup';
        Text001Lbl: Label 'Already More List Has Been Generated';
        Text002Lbl: Label 'Stage1 Selection Process Has Been Completed';
        Text003Lbl: Label 'Stage1 Cannot Be Generated, Stage2 Selection List Has been Processed';
        Text004Lbl: Label 'Call Letter Generation Already Completed';
        Text005Lbl: Label 'Do you want to generate Selection Process ?';
        Text006Lbl: Label 'Do you want to Generate Call Letter';

    procedure SelectEligibleStudent(CourseCode: Code[20]; "List No.": Integer; AppRecDate: Date; BlReserve: Boolean; BlStaffChild: Boolean; BlBreakStud: Boolean; AcadmicYear: Code[20])
    var
        ApplicationCS: Record "Application-CS";

        DecEligiblePercentage: Decimal;
    begin
        //Code added for select eligible applicants for Course Seletion::CSPL-00059::20022019: Start
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Course Code", "Application Status", "Application Selection", "Date of Receive");
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Application Status", ApplicationCS."Application Status"::Received);
        ApplicationCS.SETRANGE("Application Selection", FALSE);
        ApplicationCS.SETFILTER("Date of Receive", '<=%1', AppRecDate);
        ApplicationCS.SETRANGE(ApplicationCS."Academic Year", AcadmicYear);
        IF NOT BlBreakStud THEN
            ApplicationCS.SETRANGE("Break In Study", FALSE);
        IF ApplicationCS.FINDSET(TRUE, TRUE) THEN
            REPEAT
                MESSAGE(ApplicationCS."No.");
                IF CheckApplicantAgeValid(ApplicationCS."No.") AND CheckCoursePrequalificationValid(ApplicationCS."No.") THEN BEGIN
                    IF BlReserve AND CheckMinorityQuotaValidation(ApplicationCS.Quota) THEN
                        ApplicationCS."Application Selection" := TRUE;
                    IF BlStaffChild AND ApplicationCS."Staff Child" THEN
                        ApplicationCS."Application Selection" := TRUE;
                    IF NOT ApplicationCS."Application Selection" THEN BEGIN
                        DecEligiblePercentage := 0;
                        DecEligiblePercentage := CheckEligibleSubjectsValid(CourseCode, "List No.", ApplicationCS."No.");
                        IF DecEligiblePercentage <> 0 THEN BEGIN
                            ApplicationCS."Eligibility Percertage" := DecEligiblePercentage;
                            ApplicationCS."Stage1 Selection List No." := "List No.";
                            ApplicationCS.Modify();
                        END;
                    END;
                END;
            UNTIL ApplicationCS.NEXT() = 0;
        GenerateApplEligibleRankValid(CourseCode, "List No.");
        //Code added for select eligible applicants for Course Seletion::CSPL-00059::20022019: End
    end;

    procedure CheckMinorityQuotaValidation(QuotaCode: Code[20]) blMinority: Boolean
    var
        QuotaCS: Record "Quota-CS";
    begin
        //Code added for Check the Minority Quota::CSPL-00059::20022019: Start
        blMinority := FALSE;
        IF QuotaCS.GET(QuotaCode) THEN
            blMinority := QuotaCS.Reserve;
        EXIT(blMinority);
        //Code added for Check the Minority Quota::CSPL-00059::20022019: End
    end;

    procedure CheckEligibleSubjectsValid(CourseCode: Code[20]; "List No.": Integer; AppNum: Code[20]): Decimal
    var
        CourseFormulaDetailsCS: Record "Course Formula Details-CS";
        CourseEligibleSummaryCS: Record "Course Eligible Summary-CS";
        MarkApplicationCS: Record "Mark Application-CS";
        Iterator: Integer;

        IntLoop: Integer;
        DecPercentage: Decimal;
        DecTotPercentage: Decimal;
    begin
        //Code added for check the applicants has eligible subjects::CSPL-00059::20022019: Start
        CourseFormulaDetailsCS.Reset();
        CourseFormulaDetailsCS.SETCURRENTKEY("Course Code", "List No.");
        CourseFormulaDetailsCS.SETRANGE("Course Code", CourseCode);
        CourseFormulaDetailsCS.SETRANGE("List No.", "List No.");
        IF CourseFormulaDetailsCS.FINDFIRST() THEN
            FOR Iterator := 1 TO CourseFormulaDetailsCS."No of Elgible Formula" DO BEGIN
                IntLoop := 0;
                DecPercentage := 0;
                DecTotPercentage := 0;
                CourseEligibleSummaryCS.Reset();
                CourseEligibleSummaryCS.SETCURRENTKEY("Course Code", "Course Line No.", "List No.", "Order Number");
                CourseEligibleSummaryCS.SETRANGE("Course Code", CourseCode);
                CourseEligibleSummaryCS.SETRANGE("Course Line No.", CourseFormulaDetailsCS."Line No.");
                CourseEligibleSummaryCS.SETRANGE("List No.", "List No.");
                CourseEligibleSummaryCS.SETRANGE("Order Number", Iterator);
                IF CourseEligibleSummaryCS.FINDSET() THEN
                    REPEAT
                        MarkApplicationCS.Reset();
                        MarkApplicationCS.SETRANGE("Application No", AppNum);
                        IF CourseEligibleSummaryCS.Type = CourseEligibleSummaryCS.Type::"Prequalification Subjects" THEN
                            MarkApplicationCS.SETRANGE(Type, MarkApplicationCS.Type::"Prequalification Subjects")
                        ELSE
                            IF CourseEligibleSummaryCS.Type = CourseEligibleSummaryCS.Type::Evaluation THEN
                                MarkApplicationCS.SETRANGE(Type, MarkApplicationCS.Type::"Evaluation");
                        MarkApplicationCS.SETRANGE(Code, CourseEligibleSummaryCS.Code);
                        IF MarkApplicationCS.FINDFIRST() THEN BEGIN
                            DecPercentage := ((MarkApplicationCS."Mark Obtained" / MarkApplicationCS.Maximum) * CourseEligibleSummaryCS.Percentage);
                            DecTotPercentage += DecPercentage;
                        END ELSE BEGIN
                            DecTotPercentage := 0;
                            IntLoop := 1;
                        END;
                    UNTIL (CourseEligibleSummaryCS.NEXT() = 0) OR (IntLoop = 1);
                IF DecTotPercentage > 0 THEN
                    EXIT(DecTotPercentage);
                EXIT(DecTotPercentage);
            END;
        //Code added for check the applicants has eligible subjects::CSPL-00059::20022019: End
    end;

    procedure GenerateApplEligibleRankValid(CourseCode: Code[20]; "List No.": Integer)
    var
        ApplicationCS: Record "Application-CS";
        StudentRankCS1: Record "Student Rank-CS";
        StudentRankCS: Record "Student Rank-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        Startnum: Code[20];
        Endnum: Code[20];


    begin
        //Code added for generate application eligible rank::CSPL-00059::20022019: Start
        StudentRankCS.LOCKTABLE();
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Course Code", "Application Selection", "Stage1 Selection List No.", "Eligibility Percertage");
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Stage1 Selection List No.", "List No.");
        ApplicationCS.SETFILTER("Eligibility Percertage", '>%1', 0);
        IF ApplicationCS.FINDSET() THEN
            REPEAT
                StudentRankCS.INIT();
                StudentRankCS."No." := ApplicationCS."No.";
                StudentRankCS.Average := ApplicationCS."Eligibility Percertage";
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
                    ApplicationCS."Eligibility Rank" := StudentRankCS.Rank;
                    ApplicationCS.Modify();
                END;
            UNTIL StudentRankCS.NEXT() = 0;

        StudentRankCS1.Reset();
        StudentRankCS1.SETRANGE("Entry No.", Startnum, Endnum);
        IF StudentRankCS1.FINDSET() THEN
            StudentRankCS1.DELETEALL();
        //Code added for generate application eligible rank::CSPL-00059::20022019: End
    end;

    procedure UpdateQuotaAllotedSeatsValid(CourseCode: Code[20]; "List No.": Integer; "DocumentNo.": Code[20])
    var
        SelProcessStageL1CS: Record "Sel Process Stage L1-CS";
        PercentageQuotaCS: Record "Percentage Quota-CS";
        ApplicationCS: Record "Application-CS";
        "IntLineNo.": Integer;

    begin
        //Code added for update the quota alloted seats::CSPL-00059::20022019: Start
        SelProcessStageL1CS.Reset();
        SelProcessStageL1CS.SETCURRENTKEY("Course Code", "Stage1 Selection List No.");
        SelProcessStageL1CS.SETRANGE("Course Code", CourseCode);
        SelProcessStageL1CS.SETRANGE("Stage1 Selection List No.", "List No.");
        IF SelProcessStageL1CS.FINDFIRST() THEN
            SelProcessStageL1CS.DELETEALL();
        IF PercentageQuotaCS.FINDSET() THEN
            REPEAT
                "IntLineNo." += 1;
                SelProcessStageL1CS.INIT();
                SelProcessStageL1CS."Document No." := "DocumentNo.";
                SelProcessStageL1CS."Line No." := "IntLineNo.";
                SelProcessStageL1CS."Course Code" := CourseCode;
                SelProcessStageL1CS."Stage1 Selection List No." := "List No.";
                SelProcessStageL1CS."Quota Code" := PercentageQuotaCS."Qutoa Code";
                SelProcessStageL1CS.Capacity := PercentageQuotaCS.Numofseat;
                ApplicationCS.Reset();
                ApplicationCS.SETCURRENTKEY("Course Code", "Stage1 Selection List No.", "Application Selection", Quota);
                ApplicationCS.SETRANGE("Course Code", CourseCode);
                ApplicationCS.SETRANGE("Stage1 Selection List No.", "List No.");
                ApplicationCS.SETRANGE("Application Selection", TRUE);
                ApplicationCS.SETRANGE(Quota, PercentageQuotaCS."Qutoa Code");
                SelProcessStageL1CS.Alloted := ApplicationCS.count();
                SelProcessStageL1CS.INSERT();
            UNTIL PercentageQuotaCS.NEXT() = 0;
        //Code added for update the quota alloted seats::CSPL-00059::20022019: End
    end;

    procedure GenerateStage1SelectionHistoryValid(CourseCode: Code[20]; "List No.": Integer; ProcessedDate: Date)
    var
        StageSelectionDetails1CS: Record "Stage Selection Details1-CS";

        ApplicationCS: Record "Application-CS";
        "EntryNo.": Integer;
    begin
        //Code added for Generage Stage1 Selection History::CSPL-00059::20022019: Start
        StageSelectionDetails1CS.Reset();
        StageSelectionDetails1CS.SETCURRENTKEY("Course Code", "Selection List No.");
        StageSelectionDetails1CS.SETRANGE("Course Code", CourseCode);
        StageSelectionDetails1CS.SETRANGE("Selection List No.", "List No.");
        IF StageSelectionDetails1CS.FINDFIRST() THEN
            StageSelectionDetails1CS.DELETEALL();

        StageSelectionDetails1CS.Reset();
        IF StageSelectionDetails1CS.FINDLAST() THEN
            "EntryNo." := StageSelectionDetails1CS."Entry No.";

        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Course Code", "Application Selection", "Stage1 Selection List No.", "Eligibility Percertage");
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Stage1 Selection List No.", "List No.");
        ApplicationCS.SETFILTER("Eligibility Percertage", '>%1', 0);
        IF ApplicationCS.FINDSET() THEN
            REPEAT
                "EntryNo." += 1;
                StageSelectionDetails1CS.INIT();
                StageSelectionDetails1CS."Entry No." := "EntryNo.";
                StageSelectionDetails1CS."Application No." := ApplicationCS."No.";
                StageSelectionDetails1CS."Course Code" := CourseCode;
                StageSelectionDetails1CS."Application Selection" := ApplicationCS."Application Selection";
                StageSelectionDetails1CS."Eligibility Percertage" := ApplicationCS."Eligibility Percertage";
                StageSelectionDetails1CS."Eligibility Rank" := ApplicationCS."Eligibility Rank";
                StageSelectionDetails1CS."Selection List No." := ApplicationCS."Stage1 Selection List No.";
                StageSelectionDetails1CS."Applicant Name" := ApplicationCS."Applicant Name";
                StageSelectionDetails1CS.Quota := ApplicationCS.Quota;
                StageSelectionDetails1CS."Eligibility Quota" := ApplicationCS."Eligibilty Quota";
                StageSelectionDetails1CS."Eligibility Quota Rank" := ApplicationCS."Eligibility Quota Rank";
                StageSelectionDetails1CS."Processed Date" := ProcessedDate;
                StageSelectionDetails1CS.INSERT();
            UNTIL ApplicationCS.NEXT() = 0;
        //Code added for Generage Stage1 Selection History::CSPL-00059::20022019: End
    end;

    procedure UpdateEligibleApplicantsValid(CourseCode: Code[20]; "List No.": Integer; Strength: Integer)
    var
        ApplicationCS: Record "Application-CS";
        PercentageQuotaCS: Record "Percentage Quota-CS";
        IntTotalseat: Integer;
        IntSeat: Integer;
    begin
        //Code added for update the eligible candidate for a Selection::CSPL-00059::20022019: Start
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

        PercentageQuotaCS.Reset();
        PercentageQuotaCS.SETCURRENTKEY(Order);
        IF PercentageQuotaCS.FINDSET() THEN
            REPEAT
                IntSeat := 1;
                ApplicationCS.Reset();
                ApplicationCS.SETCURRENTKEY("Course Code", "Stage1 Selection List No.",
                  "Application Selection", "Rank Selection", Alloted, "Eligibility Percertage");
                ApplicationCS.ASCENDING(FALSE);
                ApplicationCS.SETRANGE("Course Code", CourseCode);
                ApplicationCS.SETRANGE("Stage1 Selection List No.", "List No.");
                ApplicationCS.SETRANGE("Application Selection", FALSE);
                ApplicationCS.SETRANGE("Rank Selection", FALSE);
                ApplicationCS.SETRANGE(Alloted, FALSE);
                ApplicationCS.SETFILTER("Eligibility Percertage", '>%1', 0);
                IF NOT PercentageQuotaCS."Open Competition" THEN
                    ApplicationCS.SETRANGE(Quota, PercentageQuotaCS."Qutoa Code");
                IF ApplicationCS.FINDFIRST() THEN
                    REPEAT
                        IF IntSeat <= PercentageQuotaCS.Numofseat THEN BEGIN
                            ApplicationCS."Application Selection" := TRUE;
                            ApplicationCS."Eligibilty Quota" := PercentageQuotaCS."Qutoa Code";
                            ApplicationCS.Modify();
                            IntSeat += 1;
                        END;
                    UNTIL (ApplicationCS.NEXT() = 0) OR (IntSeat = PercentageQuotaCS.Numofseat + 1);
                GenerateEligibilityQuotaRankVCS(CourseCode, "List No.", PercentageQuotaCS."Qutoa Code");
            UNTIL PercentageQuotaCS.NEXT() = 0;
        //Code added for update the eligible candidate for a Selection::CSPL-00059::20022019: End
    end;

    procedure GenerateEligibilityQuotaRankVCS(CourseCode: Code[20]; "List No.": Integer; Quota: Code[20])
    var
        ApplicationCS: Record "Application-CS";
        StudentRankCS1: Record "Student Rank-CS";
        StudentRankCS: Record "Student Rank-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        Startnum: Code[20];
        Endnum: Code[20];
    // IntRank: Integer;

    begin
        //Code added for generate eligibility quota rank::CSPL-00059::20022019: Start
        StudentRankCS.LOCKTABLE();
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Course Code", "Stage1 Selection List No.", "Eligibility Percertage", Quota);
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Stage1 Selection List No.", "List No.");
        ApplicationCS.SETFILTER("Eligibility Percertage", '>%1', 0);
        ApplicationCS.SETRANGE(Quota, Quota);
        IF ApplicationCS.FINDSET() THEN
            REPEAT
                StudentRankCS.INIT();
                StudentRankCS."No." := ApplicationCS."No.";
                StudentRankCS.Average := ApplicationCS."Eligibility Percertage";
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
                    ApplicationCS."Eligibility Quota Rank" := StudentRankCS.Rank;
                    ApplicationCS.Modify();
                END;
            UNTIL StudentRankCS.NEXT() = 0;

        StudentRankCS1.Reset();
        StudentRankCS1.SETRANGE("Entry No.", Startnum, Endnum);
        IF StudentRankCS1.FINDSET() THEN
            StudentRankCS1.DELETEALL();
        //Code added for generate eligibility quota rank::CSPL-00059::20022019: End
    end;

    procedure Stage1SelectionProcessValid(SelHeadNo1: Code[20])
    var
        SelProcessStageH1CS: Record "Sel Process Stage H1-CS";
        PercentageQuotaCS: Record "Percentage Quota-CS";
        CourseMasterCS: Record "Course Master-CS";
    //ApplicationCS: Record "Application-CS";
    begin
        //Code added for stage1 Selection Process::CSPL-00059::20022019: Start
        SelProcessStageH1CS.GET(SelHeadNo1);
        SelProcessStageH1CS.TESTFIELD("Course Code");
        SelProcessStageH1CS.TESTFIELD("Stage1 Selection List No.");
        SelProcessStageH1CS.TESTFIELD("Number of Students");
        SelProcessStageH1CS.TESTFIELD("Application Receive Till Date");

        PercentageQuotaCS.Reset();
        IF NOT PercentageQuotaCS.FINDFIRST() THEN
            ERROR(Text000Lbl);

        CourseMasterCS.GET(SelProcessStageH1CS."Course Code");
        IF (CourseMasterCS."Last Stage1 Generated List No." <> 0) AND
           (CourseMasterCS."Last Stage1 Generated List No." > SelProcessStageH1CS."Stage1 Selection List No.")
        THEN
            ERROR(Text001Lbl);

        CheckApplStage1SelStatusValid(SelProcessStageH1CS."Course Code", SelProcessStageH1CS."Stage1 Selection List No.");

        IF CONFIRM(Text005Lbl) THEN BEGIN
            IF CourseMasterCS."Last Stage1 Generated List No." = SelProcessStageH1CS."Stage1 Selection List No." THEN BEGIN
                IF CONFIRM(Text001Lbl) THEN BEGIN
                    ClearStage1GeneratedDetailsVCS(SelProcessStageH1CS."Course Code", SelProcessStageH1CS."Stage1 Selection List No.");
                    StartStage1SelectionProcessValid(SelProcessStageH1CS."Course Code", SelProcessStageH1CS."Stage1 Selection List No.",
                    SelProcessStageH1CS."Application Receive Till Date", SelProcessStageH1CS."Excempt Rules - Reserve Quota",
                    SelProcessStageH1CS."Excempt Rules - Staff Child", SelProcessStageH1CS."Consider Break Students",
                    SelProcessStageH1CS."Number of Students", SelProcessStageH1CS."No.", SelProcessStageH1CS."Academic Year");
                END;
            END ELSE
                StartStage1SelectionProcessValid(SelProcessStageH1CS."Course Code", SelProcessStageH1CS."Stage1 Selection List No.",
                SelProcessStageH1CS."Application Receive Till Date", SelProcessStageH1CS."Excempt Rules - Reserve Quota",
                SelProcessStageH1CS."Excempt Rules - Staff Child", SelProcessStageH1CS."Consider Break Students",
                SelProcessStageH1CS."Number of Students", SelProcessStageH1CS."No.", SelProcessStageH1CS."Academic Year");

            CourseMasterCS."Last Stage1 Generated List No." := SelProcessStageH1CS."Stage1 Selection List No.";
            CourseMasterCS.Modify();
            SelProcessStageH1CS."Processed Date" := WORKDATE();
            SelProcessStageH1CS.Modify();
            MESSAGE(Text002Lbl);
        END;
        //Code added for stage1 Selection Process::CSPL-00059::20022019: End
    end;

    procedure ClearStage1GeneratedDetailsVCS(CourseCode: Code[20]; SelListNo: Integer)
    var
        ApplicationCS: Record "Application-CS";
    begin
        //Code added for clear the stage1 generated details::CSPL-00059::20022019: Start
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Application Status", "Course Code", "Stage1 Selection List No.", "Application Selection");
        ApplicationCS.SETRANGE("Application Status", ApplicationCS."Application Status"::Received);
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Stage1 Selection List No.", SelListNo);
        IF ApplicationCS.FINDSET(TRUE, TRUE) THEN BEGIN
            ApplicationCS.MODIFYALL("Application Selection", FALSE);
            ApplicationCS.MODIFYALL("Eligibilty Quota", '');
            ApplicationCS.MODIFYALL("Eligibility Rank", 0);
            ApplicationCS.MODIFYALL("Eligibility Percertage", 0);
            ApplicationCS.MODIFYALL("Stage1 Selection List No.", 0);
            ApplicationCS.MODIFYALL("Eligibility Quota Rank", 0);
        END;
        //Code added for clear the stage1 generated details::CSPL-00059::20022019: End
    end;

    procedure StartStage1SelectionProcessValid(CourseCode: Code[20]; "List No.": Integer; AppRecDate: Date; BlReserve: Boolean; BlStaffChild: Boolean; BlBreakStud: Boolean; IntNumofStudents: Integer; "CdeNo.": Code[20]; AcadYear: Code[20])
    begin
        //Code added for clear the stage1 generated details::CSPL-00059::20022019: Start
        SelectEligibleStudent(CourseCode, "List No.", AppRecDate, BlReserve, BlStaffChild, BlBreakStud, AcadYear);
        UpdateEligibleApplicantsValid(CourseCode, "List No.", IntNumofStudents);
        UpdateQuotaAllotedSeatsValid(CourseCode, "List No.", "CdeNo.");
        GenerateStage1SelectionHistoryValid(CourseCode, "List No.", WORKDATE());
        //Code added for clear the stage1 generated details::CSPL-00059::20022019: End
    end;

    procedure CheckApplStage1SelStatusValid(CourseCode: Code[20]; SelListNo: Integer)
    var
        ApplicationCS: Record "Application-CS";
    begin
        //Code added for check the Application Selection Status::CSPL-00059::20022019: Start
        ApplicationCS.Reset();
        ApplicationCS.SETCURRENTKEY("Application Status", "Course Code", "Stage2 Selection List No.", "Call Letter Sent");
        ApplicationCS.SETRANGE("Application Status", ApplicationCS."Application Status"::Received);
        ApplicationCS.SETRANGE("Course Code", CourseCode);
        ApplicationCS.SETRANGE("Stage2 Selection List No.", SelListNo);
        IF ApplicationCS.FINDFIRST() THEN
            ERROR(Text003Lbl);
        //Code added for check the Application Selection Status::CSPL-00059::20022019: End
    end;

    procedure CheckApplicantAgeValid(AppNo: Code[20]): Boolean
    var
        ApplicationCS: Record "Application-CS";
        CourseMasterCS: Record "Course Master-CS";
        BlAge: Boolean;

    begin
        //Code added for check the Applicant Age with course eligible age::CSPL-00059::20022019: Start
        BlAge := FALSE;
        IF ApplicationCS.GET(AppNo) THEN BEGIN
            CourseMasterCS.GET(ApplicationCS."Course Code");
            IF (ApplicationCS.Age >= CourseMasterCS."Miniimum Age Limit") AND (ApplicationCS.Age <= CourseMasterCS."Maximum Age Limit") THEN
                BlAge := TRUE;
        END;
        EXIT(BlAge);
        //Code added for check the Applicant Age with course eligible age::CSPL-00059::20022019: End
    end;

    procedure SendCallLetterValid(CourseCode: Code[20]; SelListNo: Integer)
    var
        ApplicationCS: Record "Application-CS";
    begin
        //Code added for generate call letter for eligible applicants::CSPL-00059::20022019: Start

        IF CONFIRM(Text006Lbl, TRUE) THEN BEGIN
            ApplicationCS.Reset();
            ApplicationCS.SETCURRENTKEY("Course Code", "Stage1 Selection List No.", "Application Selection", "Call Letter Sent");
            ApplicationCS.SETRANGE("Course Code", CourseCode);
            ApplicationCS.SETRANGE("Stage1 Selection List No.", SelListNo);
            ApplicationCS.SETRANGE("Application Selection", TRUE);
            ApplicationCS.SETRANGE("Call Letter Sent", TRUE);
            IF ApplicationCS.COUNT() > 0 THEN
                MESSAGE(Text004Lbl)
            ELSE BEGIN
                ApplicationCS.Reset();
                ApplicationCS.SETCURRENTKEY("Course Code", "Stage1 Selection List No.", "Application Selection", "Call Letter Sent");
                ApplicationCS.SETRANGE("Course Code", CourseCode);
                ApplicationCS.SETRANGE("Stage1 Selection List No.", SelListNo);
                ApplicationCS.SETRANGE("Application Selection", TRUE);
                IF ApplicationCS.FINDSET() THEN
                    ApplicationCS.MODIFYALL("Call Letter Sent", TRUE);
            END;
            ApplicationCS.Reset();
            ApplicationCS.SETCURRENTKEY("Course Code", "Stage1 Selection List No.", "Application Selection", "Call Letter Sent");
            ApplicationCS.SETRANGE("Course Code", CourseCode);
            ApplicationCS.SETRANGE("Stage1 Selection List No.", SelListNo);
            ApplicationCS.SETRANGE("Application Selection", TRUE);
            IF ApplicationCS.FINDSET() THEN
                REPORT.RUN(33049772, TRUE, FALSE, ApplicationCS);
        END;
        //Code added for generate call letter for eligible applicants::CSPL-00059::20022019: End
    end;

    procedure ShowSelectionListVlid(CourseCode: Code[20]; SelListNo: Integer)
    var
        StageSelectionDetails1CS: Record "Stage Selection Details1-CS";
    begin
        //Code added for show the selected applicants::CSPL-00059::20022019: Start
        StageSelectionDetails1CS.Reset();
        StageSelectionDetails1CS.SETCURRENTKEY("Course Code", "Selection List No.", "Eligibility Percertage", "Application Selection");
        StageSelectionDetails1CS.SETRANGE("Course Code", CourseCode);
        StageSelectionDetails1CS.SETRANGE("Selection List No.", SelListNo);
        StageSelectionDetails1CS.SETFILTER("Eligibility Percertage", '>%1', 0);
        StageSelectionDetails1CS.SETRANGE("Application Selection", TRUE);
        IF PAGE.RUNMODAL(33049384, StageSelectionDetails1CS) = ACTION::LookupOK THEN;
        //Code added for show the selected applicants::CSPL-00059::20022019: End
    end;

    procedure ShowWaitingListValid(CourseCode: Code[20]; SelListNo: Integer)
    var
    // Stage1SelectionHistory: Record "Stage Selection Details1-CS";
    begin
        /*
        //Code added for show waiting list::CSPL-00059::20022019: Start
        
        StageSelectionDetails1CS.Reset();
        StageSelectionDetails1CS.SETCURRENTKEY(Choice,"Selection List No.","Eligibility Percertage","Subject Classification");
        StageSelectionDetails1CS.SETRANGE(Choice,CourseCode);
        StageSelectionDetails1CS.SETRANGE("Selection List No.",SelListNo);
        StageSelectionDetails1CS.SETFILTER("Eligibility Percertage",'>%1',0);
        StageSelectionDetails1CS.SETRANGE("Subject Classification",FALSE);
        IF PAGE.RUNMODAL(33049399,Stage1SelectionHistory) = ACTION::LookupOK THEN;
        
        //Code added for show waiting list::CSPL-00059::20022019: End
        
         */

    end;

    procedure CheckCoursePrequalificationValid(AppNo: Code[20]): Boolean
    var

        ApplicationCS: Record "Application-CS";
        PrequalificationCourseCS: Record "Prequalification Course-CS";
        BlEligible: Boolean;
    begin
        //Code added for check the applicant has eligible prequalification::CSPL-00059::20022019: Start
        BlEligible := FALSE;
        IF ApplicationCS.GET(AppNo) THEN BEGIN
            PrequalificationCourseCS.Reset();
            PrequalificationCourseCS.SETRANGE("Course Code", ApplicationCS."Course Code");
            IF PrequalificationCourseCS.ISEMPTY() then
                BlEligible := TRUE
            ELSE BEGIN
                PrequalificationCourseCS.Reset();
                PrequalificationCourseCS.SETRANGE("Course Code", ApplicationCS."Course Code");
                PrequalificationCourseCS.SETRANGE("Prequalification Code", ApplicationCS.Prequalification);
                IF PrequalificationCourseCS.FINDFIRST() THEN
                    BlEligible := TRUE;
            END;
        END;
        EXIT(BlEligible);
        //Code added for check the applicant has eligible prequalification::CSPL-00059::20022019: End
    end;
}


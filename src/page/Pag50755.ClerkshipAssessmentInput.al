page 50755 "Clerkship Assessment Input"
{
    PageType = Card;
    UsageCategory = None;
    Editable = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                group("Rotation Details")
                {
                    field(StudentNo; StudentNo)
                    {
                        Caption = 'Student No.';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field(StudentName; StudentName)
                    {
                        Caption = 'Student Name';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(RotationID; RotationID)
                    {
                        Caption = 'Rotation ID';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(RotationNo; RotationNo)
                    {
                        Caption = 'Rotation No.';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(ClerkshipType; ClerkshipType)
                    {
                        Caption = 'Clerkship Type';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        OptionCaption = ' ,Core,Elective,FM1/IM1';
                    }
                    field(CourseGroupCode; CourseGroupCode)
                    {
                        Caption = 'Course Group Code';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        Visible = HideNonCore;
                    }
                    field(CourseGroupDescription; CourseGroupDescription)
                    {
                        Caption = 'Course Group Description';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        Visible = HideNonCore;
                    }
                    field(CourseCode; CourseCode)
                    {
                        Caption = 'Course Code';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(CourseDescription; CourseDescription)
                    {
                        Caption = 'Course Description';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(HospitalName; HospitalName)
                    {
                        Caption = 'Hospital Name';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                }
                group("Assessment Inputs")
                {
                    field(PatientCare; PatientCare)
                    {
                        Caption = 'Patient Care';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = not FIUHospital;
                        trigger OnValidate()
                        begin
                            CalculateEvalCount_Sum();
                            CheckPublishVisibility();
                        end;
                    }
                    field(MedicalKnowledge; MedicalKnowledge)
                    {
                        Caption = 'Medical Knowledge';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = not FIUHospital;
                        trigger OnValidate()
                        begin
                            CalculateEvalCount_Sum();
                            CheckPublishVisibility();
                        end;
                    }
                    field(InterpersonalAndCommunicationSkills; InterpersonalAndCommunicationSkills)
                    {
                        Caption = 'Interpersonal and Communication Skills';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = not FIUHospital;
                        trigger OnValidate()
                        begin
                            CalculateEvalCount_Sum();
                            CheckPublishVisibility();
                        end;
                    }
                    field(PracticeBaseLearningAndImprovement; PracticeBaseLearningAndImprovement)
                    {
                        Caption = 'Practice Base Learning and Improvement';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = not FIUHospital;
                        trigger OnValidate()
                        begin
                            CalculateEvalCount_Sum();
                            CheckPublishVisibility();
                        end;
                    }
                    field(SystemBasedLearning; SystemBasedLearning)
                    {
                        Caption = 'System Based Learning';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = not FIUHospital;
                        trigger OnValidate()
                        begin
                            CalculateEvalCount_Sum();
                            CheckPublishVisibility();
                        end;
                    }
                    field(Professionalism; Professionalism)
                    {
                        Caption = 'Professionalism';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = not FIUHospital;
                        trigger OnValidate()
                        begin
                            CalculateEvalCount_Sum();
                            CheckPublishVisibility();
                        end;
                    }
                    field(CCSSEScore; CCSSEScore)
                    {
                        Caption = 'CCSSE Score';
                        ApplicationArea = All;
                        Style = Favorable;
                        Editable = false;
                        Visible = HideNonCore;
                    }
                    field(CCSSEScoreII; CCSSEScoreII)
                    {
                        Caption = 'CCSSE Score II';
                        ApplicationArea = All;
                        Style = Favorable;
                        Editable = false;
                        Visible = HideNonCore;
                    }
                    field(CCSSEScoreIII; CCSSEScoreIII)
                    {
                        Caption = 'CCSSE Score III';
                        ApplicationArea = All;
                        Style = Favorable;
                        Editable = false;
                        Visible = HideNonCore;
                    }
                }
                group("Calculated Values")
                {
                    field(EvalCount; EvalCount)
                    {
                        Caption = 'Evaluation Count';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        BlankNumbers = BlankZero;
                    }
                    field(EvalSum; EvalSum)
                    {
                        Caption = 'Evaluation Sum';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        DecimalPlaces = 0;
                        BlankNumbers = BlankZero;
                        MaxValue = 24;
                        trigger OnValidate()
                        begin
                            EvalPercent := 0;
                            if ClerkshipType = ClerkshipType::Core then
                                EvalPercent := Round(((EvalSum / 24 * 100) * (70 / 100)), 0.01, '=')
                            else
                                EvalPercent := Round((EvalSum / 24 * 100), 0.01, '=');
                            CalculateEvalCount_Sum();
                            CheckPublishVisibility();
                        end;
                    }
                    field(EvalPercent; EvalPercent)
                    {
                        Caption = 'Evaluation Percent';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = FIUHospital;
                        BlankNumbers = BlankZero;
                        MaxValue = 100;
                        trigger OnValidate()
                        begin
                            CalculateEvalCount_Sum();
                            CheckPublishVisibility();
                        end;
                    }
                    field(ShelfValue; ShelfValue)
                    {
                        Caption = 'Shelf Value';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        DecimalPlaces = 0;
                        BlankNumbers = BlankZero;
                        Visible = HideNonCore;
                    }
                    field(GradePercent; GradePercent)
                    {
                        Caption = 'Grade Percent';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        BlankNumbers = BlankZero;
                    }
                    field(Grade; Grade)
                    {
                        Caption = 'Grade';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(GradeDescription; GradeDescription)
                    {
                        Caption = 'Grade Description';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Publish)
            {
                Caption = 'Publish';
                ApplicationArea = All;
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+P';
                Visible = PublishResult;
                trigger OnAction()
                var
                    DocuSign: Record "DocuSign Assessment Scores";
                    RLE: Record "Roster Ledger Entry";
                    StudentSubjectExam: Record "Student Subject Exam";
                begin
                    if not Confirm('Do you want to publish the result of Student No. %1 (%2)?', true, StudentNo, StudentName) then
                        exit;

                    DocuSign.Init();
                    DocuSign."Rotation ID" := RotationID;
                    DocuSign."Rotation No." := RotationNo;
                    DocuSign."Clerkship Type" := ClerkshipType;
                    DocuSign."Course Code" := CourseCode;
                    DocuSign."Course Name" := CourseDescription;
                    DocuSign."Course Group Code" := CourseGroupCode;
                    DocuSign."Course Group Description" := CourseGroupDescription;
                    DocuSign."Course Start Date" := StartDate;
                    DocuSign."Course End Date" := EndDate;
                    DocuSign."Student No." := StudentNo;
                    DocuSign."Student Name" := StudentName;
                    DocuSign."Patient Care" := PatientCare;
                    DocuSign."Medical Knowledge" := MedicalKnowledge;
                    DocuSign."Interpersonal and Comm. Skills" := InterpersonalAndCommunicationSkills;
                    DocuSign."Practice Base Learn and Impro" := PracticeBaseLearningAndImprovement;
                    DocuSign."System Based Learning" := SystemBasedLearning;
                    DocuSign.Professionalism := Professionalism;
                    DocuSign."Evaluation Count" := EvalCount;
                    DocuSign."Assessment Total Score" := EvalSum;
                    DocuSign."Assessment Percentage" := EvalPercent;
                    DocuSign."CCSSE Score" := CCSSEScore;
                    DocuSign."CCSSE Score II" := CCSSEScoreII;
                    DocuSign."CCSSE Score III" := CCSSEScoreIII;
                    DocuSign."CCSSE Weightage" := ShelfValue;
                    DocuSign."Final Percentage" := GradePercent;
                    DocuSign.Grade := Grade;
                    DocuSign."Rotation Entry No." := RotatinLedgerEntryNo;
                    DocuSign.Published := true;
                    DocuSign."Used CCSSE Exam Date" := CCSSEExamDate;
                    DocuSign."Used CCSSE Exam II Date" := IICCSSEExamDate;
                    DocuSign."Used CCSSE Exam III Date" := IIICCSSEExamDate;
                    DocuSign."FIU Grading" := FIUHospital;
                    DocuSign."Published By" := UserId;
                    DocuSign."Published On" := Today;
                    if DocuSign.Insert() then;

                    StudentSubjectExam.Reset();
                    StudentSubjectExam.SetRange("Student No.", StudentNo);
                    StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                    StudentSubjectExam.SetRange("Core Clerkship Subject Code", CourseGroupCode);
                    StudentSubjectExam.SetRange("Start Date", CCSSEExamDate);
                    if StudentSubjectExam.FindFirst() then begin
                        StudentSubjectExam."Considered in Grading" := true;
                        StudentSubjectExam.Modify();
                    end;

                    StudentSubjectExam.Reset();
                    StudentSubjectExam.SetRange("Student No.", StudentNo);
                    StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                    StudentSubjectExam.SetRange("Core Clerkship Subject Code", CourseGroupCode);
                    StudentSubjectExam.SetRange("Start Date", IICCSSEExamDate);
                    if StudentSubjectExam.FindFirst() then begin
                        StudentSubjectExam."Considered in Grading" := true;
                        StudentSubjectExam.Modify();
                    end;

                    StudentSubjectExam.Reset();
                    StudentSubjectExam.SetRange("Student No.", StudentNo);
                    StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                    StudentSubjectExam.SetRange("Core Clerkship Subject Code", CourseGroupCode);
                    StudentSubjectExam.SetRange("Start Date", IIICCSSEExamDate);
                    if StudentSubjectExam.FindFirst() then begin
                        StudentSubjectExam."Considered in Grading" := true;
                        StudentSubjectExam.Modify();
                    end;

                    RLE.Reset();
                    if RLE.Get(RotatinLedgerEntryNo) then begin
                        RLE."Assessment Completed" := true;
                        RLE.Validate("Rotation Grade", Grade);
                        RLE.Modify();
                        StudentTimeLineRec.InsertRecordFun(RLE."Student ID", RLE."Student Name", 'For ' + RLE."Course Description" + ' Grade has been assigned to ' + RLE."Rotation Grade", UserId(), Today());
                    end;

                    Message('Clerkship Assessment updated successfully.');
                    CurrPage.Close();
                end;
            }

            action("Save Assessment")
            {
                Caption = 'Save Assessment';
                ApplicationArea = All;
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+S';
                Visible = SaveResult;
                trigger OnAction()
                var
                    DocuSign: Record "DocuSign Assessment Scores";
                    RLE: Record "Roster Ledger Entry";
                begin
                    if not Confirm('Do you want to Save the Assessment of Student No. %1 (%2)?', true, StudentNo, StudentName) then
                        exit;

                    DocuSign.Init();
                    DocuSign."Rotation ID" := RotationID;
                    DocuSign."Rotation No." := RotationNo;
                    DocuSign."Clerkship Type" := ClerkshipType;
                    DocuSign."Course Code" := CourseCode;
                    DocuSign."Course Name" := CourseDescription;
                    DocuSign."Course Group Code" := CourseGroupCode;
                    DocuSign."Course Group Description" := CourseGroupDescription;
                    DocuSign."Course Start Date" := StartDate;
                    DocuSign."Course End Date" := EndDate;
                    DocuSign."Student No." := StudentNo;
                    DocuSign."Student Name" := StudentName;
                    DocuSign."Patient Care" := PatientCare;
                    DocuSign."Medical Knowledge" := MedicalKnowledge;
                    DocuSign."Interpersonal and Comm. Skills" := InterpersonalAndCommunicationSkills;
                    DocuSign."Practice Base Learn and Impro" := PracticeBaseLearningAndImprovement;
                    DocuSign."System Based Learning" := SystemBasedLearning;
                    DocuSign.Professionalism := Professionalism;
                    DocuSign."CCSSE Score" := CCSSEScore;
                    DocuSign."CCSSE Score II" := CCSSEScoreII;
                    DocuSign."CCSSE Score III" := CCSSEScoreIII;
                    DocuSign."Used CCSSE Exam Date" := CCSSEExamDate;
                    DocuSign."Used CCSSE Exam II Date" := IICCSSEExamDate;
                    DocuSign."Used CCSSE Exam III Date" := IIICCSSEExamDate;
                    DocuSign."CCSSE Weightage" := ShelfValue;
                    DocuSign."Final Percentage" := GradePercent;
                    DocuSign.Grade := Grade;

                    DocuSign."Evaluation Count" := EvalCount;
                    DocuSign."Assessment Total Score" := EvalSum;
                    DocuSign."Assessment Percentage" := EvalPercent;
                    DocuSign."FIU Grading" := FIUHospital;
                    DocuSign."Rotation Entry No." := RotatinLedgerEntryNo;
                    DocuSign."Published By" := UserId;
                    DocuSign."Published On" := Today;
                    if DocuSign.Insert() then;

                    RLE.Reset();
                    if RLE.Get(RotatinLedgerEntryNo) then begin
                        RLE."Assessment Completed" := true;
                        RLE.Validate("Rotation Grade", Grade);
                        RLE.Modify();
                        StudentTimeLineRec.InsertRecordFun(RLE."Student ID", RLE."Student Name", 'For ' + RLE."Course Description" + ' Grade has been assigned to ' + RLE."Rotation Grade", UserId(), Today());
                    end;

                    Message('Clerkship Assessment saved successfully.');
                    CurrPage.Close();
                end;
            }
            action("Assesment Input not Available")
            {
                Caption = 'Assesment Input not Available';
                ApplicationArea = All;
                Image = AdjustEntries;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+N';
                trigger OnAction()
                var
                    DocuSign: Record "DocuSign Assessment Scores";
                    RLE: Record "Roster Ledger Entry";
                    StudentSubjectExam: Record "Student Subject Exam";
                begin
                    if not Confirm('Are you sure Assesment Inputs are not available for Student No. %1 (%2)?Note: System will Publish the Grade automatically....', true, StudentNo, StudentName) then
                        exit;

                    PatientCare := PatientCare::"Not Observed/Insufficient Data";
                    MedicalKnowledge := MedicalKnowledge::"Not Observed/Insufficient Data";
                    InterpersonalAndCommunicationSkills := InterpersonalAndCommunicationSkills::"Not Observed/Insufficient Data";
                    PracticeBaseLearningAndImprovement := PracticeBaseLearningAndImprovement::"Not Observed/Insufficient Data";
                    SystemBasedLearning := SystemBasedLearning::"Not Observed/Insufficient Data";
                    Professionalism := Professionalism::"Not Observed/Insufficient Data";

                    CalculateEvalCount_Sum();

                    if Grade <> '' then begin
                        DocuSign.Init();
                        DocuSign."Rotation ID" := RotationID;
                        DocuSign."Rotation No." := RotationNo;
                        DocuSign."Clerkship Type" := ClerkshipType;
                        DocuSign."Course Code" := CourseCode;
                        DocuSign."Course Name" := CourseDescription;
                        DocuSign."Course Group Code" := CourseGroupCode;
                        DocuSign."Course Group Description" := CourseGroupDescription;
                        DocuSign."Course Start Date" := StartDate;
                        DocuSign."Course End Date" := EndDate;
                        DocuSign."Student No." := StudentNo;
                        DocuSign."Student Name" := StudentName;
                        DocuSign."Patient Care" := PatientCare;
                        DocuSign."Medical Knowledge" := MedicalKnowledge;
                        DocuSign."Interpersonal and Comm. Skills" := InterpersonalAndCommunicationSkills;
                        DocuSign."Practice Base Learn and Impro" := PracticeBaseLearningAndImprovement;
                        DocuSign."System Based Learning" := SystemBasedLearning;
                        DocuSign.Professionalism := Professionalism;
                        DocuSign."Evaluation Count" := EvalCount;
                        DocuSign."Assessment Total Score" := EvalSum;
                        DocuSign."Assessment Percentage" := EvalPercent;
                        DocuSign."CCSSE Score" := CCSSEScore;
                        DocuSign."CCSSE Score II" := CCSSEScoreII;
                        DocuSign."CCSSE Score III" := CCSSEScoreIII;
                        DocuSign."CCSSE Weightage" := ShelfValue;
                        DocuSign."Final Percentage" := GradePercent;
                        DocuSign.Grade := Grade;
                        DocuSign."Rotation Entry No." := RotatinLedgerEntryNo;
                        DocuSign.Published := true;
                        DocuSign."Used CCSSE Exam Date" := CCSSEExamDate;
                        DocuSign."Used CCSSE Exam II Date" := IICCSSEExamDate;
                        DocuSign."Used CCSSE Exam III Date" := IIICCSSEExamDate;
                        DocuSign."FIU Grading" := FIUHospital;
                        DocuSign."Published By" := UserId;
                        DocuSign."Published On" := Today;
                        if DocuSign.Insert() then;

                        StudentSubjectExam.Reset();
                        StudentSubjectExam.SetRange("Student No.", StudentNo);
                        StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                        StudentSubjectExam.SetRange("Core Clerkship Subject Code", CourseGroupCode);
                        StudentSubjectExam.SetRange("Start Date", CCSSEExamDate);
                        if StudentSubjectExam.FindFirst() then begin
                            StudentSubjectExam."Considered in Grading" := true;
                            StudentSubjectExam.Modify();
                        end;

                        StudentSubjectExam.Reset();
                        StudentSubjectExam.SetRange("Student No.", StudentNo);
                        StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                        StudentSubjectExam.SetRange("Core Clerkship Subject Code", CourseGroupCode);
                        StudentSubjectExam.SetRange("Start Date", IICCSSEExamDate);
                        if StudentSubjectExam.FindFirst() then begin
                            StudentSubjectExam."Considered in Grading" := true;
                            StudentSubjectExam.Modify();
                        end;

                        StudentSubjectExam.Reset();
                        StudentSubjectExam.SetRange("Student No.", StudentNo);
                        StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                        StudentSubjectExam.SetRange("Core Clerkship Subject Code", CourseGroupCode);
                        StudentSubjectExam.SetRange("Start Date", IIICCSSEExamDate);
                        if StudentSubjectExam.FindFirst() then begin
                            StudentSubjectExam."Considered in Grading" := true;
                            StudentSubjectExam.Modify();
                        end;

                        RLE.Reset();
                        if RLE.Get(RotatinLedgerEntryNo) then begin
                            RLE."Assessment Completed" := true;
                            RLE.Validate("Rotation Grade", Grade);
                            RLE.Modify();
                            StudentTimeLineRec.InsertRecordFun(RLE."Student ID", RLE."Student Name", 'For ' + RLE."Course Description" + ' Grade has been assigned to ' + RLE."Rotation Grade", UserId(), Today());
                        end;
                    end;

                    if Grade = '' then begin
                        DocuSign.Init();
                        DocuSign."Rotation ID" := RotationID;
                        DocuSign."Rotation No." := RotationNo;
                        DocuSign."Clerkship Type" := ClerkshipType;
                        DocuSign."Course Code" := CourseCode;
                        DocuSign."Course Name" := CourseDescription;
                        DocuSign."Course Group Code" := CourseGroupCode;
                        DocuSign."Course Group Description" := CourseGroupDescription;
                        DocuSign."Course Start Date" := StartDate;
                        DocuSign."Course End Date" := EndDate;
                        DocuSign."Student No." := StudentNo;
                        DocuSign."Student Name" := StudentName;
                        DocuSign."Patient Care" := PatientCare;
                        DocuSign."Medical Knowledge" := MedicalKnowledge;
                        DocuSign."Interpersonal and Comm. Skills" := InterpersonalAndCommunicationSkills;
                        DocuSign."Practice Base Learn and Impro" := PracticeBaseLearningAndImprovement;
                        DocuSign."System Based Learning" := SystemBasedLearning;
                        DocuSign.Professionalism := Professionalism;
                        DocuSign."CCSSE Score" := CCSSEScore;
                        DocuSign."CCSSE Score II" := CCSSEScoreII;
                        DocuSign."CCSSE Score III" := CCSSEScoreIII;
                        DocuSign."Used CCSSE Exam Date" := CCSSEExamDate;
                        DocuSign."Used CCSSE Exam II Date" := IICCSSEExamDate;
                        DocuSign."Used CCSSE Exam III Date" := IIICCSSEExamDate;
                        DocuSign."CCSSE Weightage" := ShelfValue;
                        DocuSign."Final Percentage" := GradePercent;
                        DocuSign.Grade := Grade;

                        DocuSign."Evaluation Count" := EvalCount;
                        DocuSign."Assessment Total Score" := EvalSum;
                        DocuSign."Assessment Percentage" := EvalPercent;
                        DocuSign."FIU Grading" := FIUHospital;
                        DocuSign."Rotation Entry No." := RotatinLedgerEntryNo;
                        DocuSign."Published By" := UserId;
                        DocuSign."Published On" := Today;
                        if DocuSign.Insert() then;

                        RLE.Reset();
                        if RLE.Get(RotatinLedgerEntryNo) then begin
                            RLE."Assessment Completed" := true;
                            RLE.Validate("Rotation Grade", Grade);
                            RLE.Modify();
                            StudentTimeLineRec.InsertRecordFun(RLE."Student ID", RLE."Student Name", 'For ' + RLE."Course Description" + ' Grade has been assigned to ' + RLE."Rotation Grade", UserId(), Today());
                        end;
                    end;
                    Message('Clerkship Assessment updated successfully.');
                    CurrPage.Close();
                end;
            }
            action("Shelf Exam Score")
            {
                Caption = 'Shelf Exam Score';
                ApplicationArea = All;
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentSubjectExam: Record "Student Subject Exam";
                begin
                    StudentSubjectExam.Reset();
                    StudentSubjectExam.FilterGroup(2);
                    StudentSubjectExam.SetRange("Student No.", StudentNo);
                    StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                    StudentSubjectExam.SetRange("Core Clerkship Subject Code", CourseGroupCode);
                    StudentSubjectExam.FilterGroup(0);
                    Page.RunModal(Page::"Student Subject Exam List", StudentSubjectExam);
                end;
            }
            action("Student Subject")
            {
                Caption = 'Student Subject';
                ApplicationArea = All;
                Image = SubcontractingWorksheet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    MainStudentSubject: Record "Main Student Subject-CS";
                begin
                    MainStudentSubject.Reset();
                    MainStudentSubject.FilterGroup(2);
                    MainStudentSubject.SetRange("Student No.", StudentNo);
                    MainStudentSubject.FilterGroup(0);
                    Page.RunModal(Page::"Subject Student-CS", MainStudentSubject);
                end;
            }
        }
    }

    var
        StudentTimeLineRec: Record "Student Time Line";
        StudentNo: Code[20];
        StudentName: Text[100];
        RotationID: Code[20];
        RotationNo: Integer;
        ClerkshipType: Option " ","Core","Elective","FM1/IM1";
        CourseCode: Code[20];
        CourseDescription: Text[100];
        StartDate: Date;
        EndDate: Date;
        CourseGroupCode: Code[20];
        CourseGroupDescription: Text[100];
        PatientCare: Option " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        MedicalKnowledge: Option " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        InterpersonalAndCommunicationSkills: Option " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        PracticeBaseLearningAndImprovement: Option " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        SystemBasedLearning: Option " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        Professionalism: Option " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        CCSSEScore: Decimal;
        CCSSEScoreII: Decimal;
        CCSSEScoreIII: Decimal;
        EvalCount: Integer;
        EvalSum: Decimal;
        EvalPercent: Decimal;
        ShelfValue: Decimal;
        GradePercent: Decimal;
        Grade: Code[20];
        GradeDescription: Text[50];
        RotatinLedgerEntryNo: integer;
        CCSSEExamDate: Date;
        IICCSSEExamDate: Date;
        IIICCSSEExamDate: Date;
        PublishResult: Boolean;
        SaveResult: Boolean;

    procedure SetVariables(LStudentNo: Code[20];
        LStudentName: Text[100];
        LRotationID: Code[20];
        LRotationNo: Integer;
        LClerkshipType: Option " ","Core","Elective","FM1/IM1";
        LCourseCode: Code[20];
        LCourseDescription: Text[100];
        LStartDate: Date;
        LEndDate: Date;
        LCourseGroupCode: Code[20];
        LCourseGroupDescription: Text[100];
        LCCSSEScore: Decimal;
        LCCSSEScoreII: Decimal;
        LCCSSEScoreIII: Decimal;
        LRotatinLedgerEntryNo: Integer;
        LCCSSEExamDate: Date;
        LIICCSSEExamDate: Date;
        LIIICCSSEExamDate: Date)
    begin
        StudentNo := LStudentNo;
        StudentName := LStudentName;
        RotationID := LRotationID;
        RotationNo := LRotationNo;
        ClerkshipType := LClerkshipType;
        CourseCode := LCourseCode;
        CourseDescription := LCourseDescription;
        StartDate := LStartDate;
        EndDate := LEndDate;
        CourseGroupCode := LCourseGroupCode;
        CourseGroupDescription := LCourseGroupDescription;
        CCSSEScore := LCCSSEScore;
        CCSSEScoreII := LCCSSEScoreII;
        CCSSEScoreIII := LCCSSEScoreIII;
        RotatinLedgerEntryNo := LRotatinLedgerEntryNo;
        CCSSEExamDate := LCCSSEExamDate;
        IICCSSEExamDate := LIICCSSEExamDate;
        IIICCSSEExamDate := LIIICCSSEExamDate;
    end;

    procedure CheckPublishVisibility()
    begin
        PublishResult := false;
        if not (Grade IN ['', 'M']) then
            PublishResult := true;

        SaveResult := not PublishResult;
        CurrPage.Update(false);
    end;

    procedure CalculateEvalCount_Sum()
    var
        CCSSEScoreConversion: Record "CCSSE Score Conversion";
        ClerkshipGrading: Record "Clerkship Grading";
        DSAS: Record "DocuSign Assessment Scores";
        ReceivedValue: Option " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        UCCSSEScore: Integer;
        UIICCSSEScore: Integer;
        UIIICCSSEScore: Integer;
        CCSSEScoreUsed: Boolean;
        VarPreviousRotaionPass: Boolean;
    begin
        if FIUHospital = false then begin
            EvalCount := 0;
            EvalSum := 0;

            ////////////////////////////////////////////1//////////////////////////////////////////////////////
            ReceivedValue := PatientCare;
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            /////////////////////////////////////////////2/////////////////////////////////////////////////////
            ReceivedValue := MedicalKnowledge;
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            //////////////////////////////////////////////3////////////////////////////////////////////////////
            ReceivedValue := InterpersonalAndCommunicationSkills;
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            ///////////////////////////////////////////////4///////////////////////////////////////////////////
            ReceivedValue := PracticeBaseLearningAndImprovement;
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            ////////////////////////////////////////////////5//////////////////////////////////////////////////
            ReceivedValue := SystemBasedLearning;
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            ////////////////////////////////////////////////6//////////////////////////////////////////////////
            ReceivedValue := Professionalism;
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            EvalPercent := 0;

            if ClerkshipType = ClerkshipType::Core then
                if EvalCount <> 0 then
                    EvalPercent := Round((EvalSum / EvalCount) / 4 * 70, 0.01, '=');

            if ClerkshipType <> ClerkshipType::Core then
                if EvalCount <> 0 then
                    EvalPercent := Round((EvalSum / EvalCount) / 4 * 100, 0.01, '=');
        end;

        //CSPL-00307-15-12-2022
        Clear(VarPreviousRotaionPass);
        VarPreviousRotaionPass := PreviousRotationPass(); // For Rotations in 2 Parts and one of the rotations having passing grade
        //CSPL-00307-15-12-2022

        ShelfValue := 0;

        if ClerkshipType = ClerkshipType::Core then begin
            CCSSEScoreUsed := false;
            DSAS.Reset();
            DSAS.SetRange("Student No.", StudentNo);
            DSAS.SetRange("Course Group Code", CourseGroupCode);
            DSAS.SetFilter("Rotation ID", '<>%1', RotationID);
            if DSAS.FindSet() then
                repeat
                    if CCSSEExamDate = DSAS."Used CCSSE Exam Date" then
                        CCSSEScoreUsed := true;
                until DSAS.Next() = 0;

            if CCSSEScoreUsed = false OR VarPreviousRotaionPass then
                UCCSSEScore := CCSSEScore;

            CCSSEScoreUsed := false;
            DSAS.Reset();
            DSAS.SetRange("Student No.", StudentNo);
            DSAS.SetRange("Course Group Code", CourseGroupCode);
            DSAS.SetFilter("Rotation ID", '<>%1', RotationID);
            if DSAS.FindSet() then
                repeat
                    if IICCSSEExamDate = DSAS."Used CCSSE Exam II Date" then
                        CCSSEScoreUsed := true;
                until DSAS.Next() = 0;

            if CCSSEScoreUsed = false OR VarPreviousRotaionPass then
                UIICCSSEScore := CCSSEScoreII;

            CCSSEScoreUsed := false;
            DSAS.Reset();
            DSAS.SetRange("Student No.", StudentNo);
            DSAS.SetRange("Course Group Code", CourseGroupCode);
            DSAS.SetFilter("Rotation ID", '<>%1', RotationID);
            if DSAS.FindSet() then
                repeat
                    if IIICCSSEExamDate = DSAS."Used CCSSE Exam III Date" then
                        CCSSEScoreUsed := true;
                until DSAS.Next() = 0;

            if CCSSEScoreUsed = false OR VarPreviousRotaionPass then
                UIIICCSSEScore := CCSSEScoreIII;
        end;

        if ClerkshipType = ClerkshipType::Core then begin
            CCSSEScoreConversion.Reset();
            CCSSEScoreConversion.SetRange("Course Code", CourseGroupCode);
            CCSSEScoreConversion.SetFilter("Effective Date", '<=%1', Today);
            if UIIICCSSEScore <> 0 then
                CCSSEScoreConversion.SetRange(Score, UIIICCSSEScore)
            else
                if UIICCSSEScore <> 0 then
                    CCSSEScoreConversion.SetRange(Score, UIICCSSEScore)
                else
                    CCSSEScoreConversion.SetRange(Score, UCCSSEScore);
            if CCSSEScoreConversion.FindLast() then
                ShelfValue := CCSSEScoreConversion."Score Value";
        end;

        GradePercent := EvalPercent + ShelfValue;

        if FIUHospital = true then
            GradePercent := EvalPercent;

        if FIUHospital = false then
            if ((ShelfValue = 0) or (EvalPercent = 0)) and (ClerkshipType = ClerkshipType::Core) then
                GradePercent := 0;

        Grade := '';
        GradeDescription := '';

        if GradePercent > 0 then begin
            ClerkshipGrading.Reset();
            ClerkshipGrading.SetCurrentKey("Cut-off End");
            IF FIUHospital = false then begin
                ClerkshipGrading.SetRange("Clerkship Type", ClerkshipType);
                if ClerkshipType = ClerkshipType::Core then
                    ClerkshipGrading.SetRange("Course Code", CourseGroupCode);
            end
            else
                ClerkshipGrading.SetRange("Hospital Category", ClerkshipGrading."Hospital Category"::FIU);
            ClerkshipGrading.SetFilter("Effective Date", '<=%1', Today);
            if ClerkshipGrading.FindSet() then
                repeat
                    if (GradePercent >= ClerkshipGrading."Cut-off Start") and (GradePercent < ClerkshipGrading."Cut-off End" + 1) then begin
                        Grade := ClerkshipGrading."Grade Code";
                        GradeDescription := ClerkshipGrading."Grade Description";
                    end;
                until ClerkshipGrading.Next() = 0;
        end;

        //CSPL-00307 NO-SHOW
        if FIUHospital = false then begin
            IF (UIICCSSEScore + UIIICCSSEScore > 0) and (ShelfValue = 0) then begin
                Grade := 'F';
                GradeDescription := 'Fail';
            end else
                IF ((UIICCSSEScore + UIIICCSSEScore = 0) and (ShelfValue = 0)) Then begin
                    IF (IICCSSEExamDate <> 0D) OR (IIICCSSEExamDate <> 0D) then begin
                        Grade := 'F';
                        GradeDescription := 'Fail';
                    end;
                end;
        end;
        //CSPL-00307 NO-SHOW

        if Grade = '' then begin
            Grade := 'M';
            GradeDescription := 'Missing';
        end;
    end;

    var
        HideNonCore: Boolean;
        FIUHospital: Boolean;
        HospitalName: Text;

    trigger OnOpenPage()
    var
        RLE: Record "Roster Ledger Entry";
        Vendor: Record Vendor;
    begin
        HideNonCore := false;
        if ClerkshipType = ClerkshipType::Core then
            HideNonCore := true;

        PublishResult := false;
        SaveResult := false;
        FIUHospital := false;

        RLE.Reset();
        if RLE.Get(RotatinLedgerEntryNo) then begin
            HospitalName := RLE."Hospital Name";
            Vendor.Reset();
            if Vendor.Get(RLE."Hospital ID") then
                if (Vendor."FIU Hospital" = true) and (RLE."Clerkship Type" = RLE."Clerkship Type"::Core) then
                    FIUHospital := true;
        end;

        IF (StrPos(CourseDescription, 'General Surgery') > 0) and (ClerkshipType = ClerkshipType::Elective)
        and (Vendor."FIU Hospital" = true) then
            FIUHospital := true;
    end;

    procedure PreviousRotationPass(): Boolean
    var
        RLE: Record "Roster Ledger Entry";
        SubjectMaster: Record "Subject Master-CS";
        CourseFilter: Text;
    begin
        Clear(CourseFilter);
        SubjectMaster.Reset();
        SubjectMaster.SetRange("Subject Group", CourseGroupCode);
        SubjectMaster.SetRange("Level Description", SubjectMaster."Level Description"::"Level 2 Clinical Rotation");
        SubjectMaster.SetRange(Examination, true);
        IF SubjectMaster.FindSet() then
            repeat
                IF CourseFilter = '' then
                    CourseFilter := SubjectMaster.Code
                else
                    CourseFilter := CourseFilter + '|' + SubjectMaster.Code;
            until SubjectMaster.Next() = 0;
        if CourseFilter <> '' then begin
            RLE.Reset();
            RLE.SetRange("Student ID", StudentNo);
            RLE.SetRange(Status, RLE.Status::Completed);
            RLE.SetFilter("Course Code", CourseFilter);
            RLE.SetFilter("Rotation Grade", 'H|HP|P');
            IF RLE.FindFirst() then
                exit(True)
            else
                exit(False);
        end;
    end;
}
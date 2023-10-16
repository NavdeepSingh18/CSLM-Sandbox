page 50614 "Publish Score Card"
{

    PageType = Card;
    SourceTable = "Publish Scores";
    Caption = 'Publish Score Card';
    UsageCategory = None;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Score Type"; Rec."Score Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SubjectEdit := false;
                        if Rec."Score Type" IN [Rec."Score Type"::CCSSE] then
                            SubjectEdit := true;
                        // GetCoreSubjectGroup();
                    end;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    Editable = SubjectEdit;
                    Visible = false;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
            }
            // part("CBSE Scores"; "CBSE Scores")
            // {
            //     visible = ShowRequestPage;
            //     Caption = 'Scores List';
            //     SubPageLink = "Published Document No." = FIELD("Document No.");
            //     ApplicationArea = All;
            // }
            // part("USMLE Performance Data"; "USMLE Performance Data")
            // {
            //     visible = ShowRequestPage1;
            //     Caption = 'Scores List';
            //     SubPageLink = "Published Document No." = FIELD("Document No.");
            //     ApplicationArea = All;
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Student List")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student List';
                Runobject = page "Student Details-CS";

            }
            action("Match Result")
            {
                ApplicationArea = All;
                Caption = 'Match Result';
                //Visible = ShowButton;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;

                trigger OnAction()
                begin
                    if Rec."Score Type" = Rec."Score Type"::" " then
                        Error('Score Type cannot be blank');

                    if Rec.Status = Rec.Status::Pending then begin
                        If Confirm(Txt001Lbl, false, Rec."Document No.") then begin
                            if Rec."Score Type" IN [Rec."Score Type"::CCSE, Rec."Score Type"::CBSE, Rec."Score Type"::CCSSE] then
                                CBSECCSEScoresFunction(Rec."Score Type", Rec."Document No.");
                            if Rec."Score Type" = Rec."Score Type"::USMLE then
                                USMLEFunction();

                            //Message(Txt002Lbl, "Document No.");
                            CurrPage.Update();
                        end else
                            exit;
                    end;
                end;
            }

            action(Publish)
            {
                ApplicationArea = All;
                Caption = 'Publish';
                //Visible = ShowButton;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;


                trigger OnAction()
                Var
                    ExamPassing: record "Exam Passing";
                    CBSECCSEScores_lRec: Record "CBSE CCSE Scores";
                    USMLEPerformanceData_lRec: Record "USMLE Performance Data";
                    StudentMatser: Record "Student Master-CS";
                    CCSSEScoreConversion: Record "CCSSE Score Conversion";
                    StudentSubjectExam: Record "Student Subject Exam";
                begin
                    if Rec."Score Type" = Rec."Score Type"::" " then
                        Error('Score Type cannot be blank');
                    StudentName := '';
                    CBSECCSEScores_lRec.Reset();
                    CBSECCSEScores_lRec.SetRange("Published Document No.", Rec."Document No.");
                    IF CBSECCSEScores_lRec.FindFirst() then
                        StudentName := CBSECCSEScores_lRec.Examinee;

                    // IF Rec."Score Type" = Rec."Score Type"::CCSE Then begin
                    //     StudentSubjectExamRec.Reset();
                    //     StudentSubjectExamRec.SetRange("Score Type", Rec."Score Type");
                    //     StudentSubjectExamRec.SetRange("Score Type", Rec."Score Type");
                    //     if StudentSubjectExamRec.FindFirst() then
                    //         CCSE(StudentSubjectExamRec."Student No.");

                    // end;



                    if Rec.Status = Rec.Status::Pending then begin
                        If Confirm(Txt004Lbl, false, Rec."Document No.") then begin
                            Rec.Status := Rec.Status::Published;
                            Rec.Modify();
                            PublishedMarks();
                            // Message(Txt003Lbl, "Document No.");
                            CurrPage.Close();
                        end else
                            exit;
                    end;
                end;
            }

            action("USMLE Missing Window")
            {
                ApplicationArea = All;
                Caption = 'USMLE Missing Window Report';
                //Visible = ShowButton;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;

                trigger OnAction()
                var
                    USMLEPerformanceData: Record "USMLE Performance Data";
                begin
                    if Rec."Score Type" <> Rec."Score Type"::USMLE then
                        Error('This is report is only valid for Score Type USMLE');

                    USMLEPerformanceData.Reset();
                    USMLEPerformanceData.SetRange("Published Document No.", Rec."Document No.");
                    USMLEPerformanceData.SetRange("Result Matched", true);
                    IF not USMLEPerformanceData.FindFirst() then
                        Error('Please match the result first');

                    USMLEPerformanceData.Reset();
                    USMLEPerformanceData.SetRange("Published Document No.", Rec."Document No.");
                    Report.Run(Report::"USMLE Missing Window", True, false, USMLEPerformanceData);

                end;
            }
            action(Upload)
            {
                ApplicationArea = All;
                Caption = 'Upload';
                Visible = ShowButton;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                trigger OnAction()
                var
                    CBSC_CCSE: XmlPort "CBSC CCSE Scores";
                    USMLEDataUploading: XmlPort "USMLE Performance Data";
                    Type1: Integer;
                begin
                    Rec.TestField("Score Type");
                    IF Rec."Score Type" IN [Rec."Score Type"::CBSE, Rec."Score Type"::CCSE, Rec."Score Type"::CCSSE] then begin
                        IF Rec."Score Type" = Rec."Score Type"::CBSE then
                            Type1 := 1;
                        IF Rec."Score Type" = Rec."Score Type"::CCSE then
                            Type1 := 2;
                        If Rec."Score Type" = Rec."Score Type"::CCSSE then
                            Type1 := 3;

                        CBSC_CCSE.GetType(Type1);
                        CBSC_CCSE.GetPublishingDocNo(Rec."Document No.");
                        CBSC_CCSE.Run();
                    end;
                    If Rec."Score Type" = Rec."Score Type"::USMLE then begin
                        USMLEDataUploading.GetPublishingDocNo(Rec."Document No.");
                        USMLEDataUploading.Run();
                    end;
                end;
            }
            action("Delete")
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Visible = false;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;

                trigger OnAction()
                var
                    UserSetupRec: Record "User Setup";
                    Txt0001Lbl: Label 'Do you want to delete the Document No. %1 ?';
                begin
                    IF UserSetupRec.GET(UserId()) THEN
                        IF not UserSetupRec."Published Score Delete Allowed" THEN
                            Error('You do not have permission to delete the document.');

                    if Confirm(Txt0001Lbl, false, Rec."Document No.") then begin
                        if Rec."Score Type" IN [Rec."Score Type"::CBSE, Rec."Score Type"::CCSE, Rec."Score Type"::CCSSE] then begin
                            CBSECCSEScoresRec.Reset();
                            CBSECCSEScoresRec.SetRange("Published Document No.", Rec."Document No.");
                            //CBSECCSEScoresRec.SetRange("Result Matched", true);
                            if CBSECCSEScoresRec.Findfirst() then begin
                                //   repeat
                                StudentSubjectExamRec.Reset();
                                StudentSubjectExamRec.SetRange("Score Type", CBSECCSEScoresRec.Type);
                                StudentSubjectExamRec.SetRange("Published Entry No.", CBSECCSEScoresRec."Entry No.");
                                StudentSubjectExamRec.SetRange("Published Document No.", CBSECCSEScoresRec."Published Document No.");
                                if StudentSubjectExamRec.FindSet() then
                                    repeat
                                        StudentSubjectExamRec.Delete(true);
                                    until StudentSubjectExamRec.Next() = 0;
                                CBSECCSEScoresRec.DeleteAll();

                            end;
                            Rec.Delete();
                            // until CBSECCSEScoresRec.Next() = 0;
                        end;
                        if Rec."Score Type" IN [Rec."Score Type"::USMLE] then begin
                            USMLEPerformanceRec.Reset();
                            USMLEPerformanceRec.SetRange("Published Document No.", Rec."Document No.");
                            //USMLEPerformanceRec.SetRange("Result Matched", true);
                            if USMLEPerformanceRec.FindFirst() then begin
                                //repeat
                                StudentSubjectExamRec.Reset();
                                StudentSubjectExamRec.SetRange("Score Type", USMLEPerformanceRec."Step Exam");
                                StudentSubjectExamRec.SetRange("Published Entry No.", USMLEPerformanceRec."Entry No.");
                                StudentSubjectExamRec.SetRange("Published Document No.", USMLEPerformanceRec."Published Document No.");
                                if StudentSubjectExamRec.FindFirst() then
                                    repeat
                                        USMLERec.Reset();
                                        USMLERec.SetCurrentKey("Creation Date");
                                        USMLERec.Ascending(false);
                                        USMLERec.SetRange(UsmleID, USMLEPerformanceRec."USMLE ID");
                                        if USMLEPerformanceRec."Step Exam" = USMLEPerformanceRec."Step Exam"::"STEP 1" then
                                            USMLERec.SetRange(USMLEStepNumber, '1');
                                        if USMLEPerformanceRec."Step Exam" = USMLEPerformanceRec."Step Exam"::"STEP 2 CK" then
                                            USMLERec.SetRange(USMLEStepNumber, 'CK');
                                        if USMLEPerformanceRec."Step Exam" = USMLEPerformanceRec."Step Exam"::"STEP 2 CS" then
                                            USMLERec.SetRange(USMLEStepNumber, 'CS');

                                        USMLERec.Setrange(Block, False);
                                        USMLERec.SetFilter(USMLEWindowStartDate, '<=%1', StudentSubjectExamRec."Sitting Date");
                                        USMLERec.SetFilter(USMLEWindowEndDate, '>=%1', StudentSubjectExamRec."Sitting Date");
                                        if USMLERec.FindFirst() then begin

                                            USMLERec.Status := USMLERec.Status::" ";

                                            USMLERec.Score := '';
                                            USMLERec.USMLETestDate := 0D;
                                            USMLERec.Modify();
                                        end;


                                        StudentSubjectExamRec.Delete(true);
                                    until StudentSubjectExamRec.Next() = 0;
                                USMLEPerformanceRec.DeleteAll();



                            end;
                            Rec.Delete();
                            //until USMLEPerformanceRec.Next() = 0;
                        end;
                        CurrPage.Close();
                    end else
                        exit;

                end;
            }
        }
    }
    procedure CBSECCSEScoresFunction(ScoreType: Option " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK"; DocumentNo: Code[20])
    var
        CBSECCSEScoresRec1: Record "CBSE CCSE Scores";
    begin
        CBSECCSEScoresRec1.Reset();
        CBSECCSEScoresRec1.SetRange(Type, ScoreType);
        CBSECCSEScoresRec1.SetRange(Published, false);
        CBSECCSEScoresRec1.SetRange("Result Matched", false);
        CBSECCSEScoresRec1.SetRange("Published Document No.", DocumentNo);
        CBSECCSEScoresRec1.SetRange(Duplicate, false);
        if CBSECCSEScoresRec1.FindSet() then begin
            repeat
                StudentNumber := StudentMasterFunction(CBSECCSEScoresRec1.ID);
                StudentSubjectExamRec.Reset();
                StudentSubjectExamRec.SetRange("Student No.", StudentNumber);
                StudentSubjectExamRec.SetRange("Sitting Date", CBSECCSEScoresRec1."Test Date");
                IF StudentSubjectExamRec.FindFirst() then begin
                    CBSECCSEScoresRec1.Duplicate := true;
                    CBSECCSEScoresRec1.Modify();
                end;

                if (StudentNumber <> '') AND (CBSECCSEScoresRec1.Duplicate = False) then
                    StudentSubjectExamFunction(StudentNumber, CBSECCSEScoresRec1."Entry No.", CBSECCSEScoresRec1."Total Test", CBSECCSEScoresRec1."Test Date", ScoreType, CBSECCSEScoresRec1."Subject Code");





            //If Rec.Result = Rec.Result::Fail then
            // ExamFailure(StudentNumber);

            //    CCSSEScoreConversion.Reset();
            //    CCSSEScoreConversion/
            //    CCSSEScoreConversion.SetRange("Course Code",Rec."Core Clerkship Subject Code");
            //    IF CCSSEScoreConversion.FindFirst() then
            // If Rec.Result = Rec.Result::pass then begin

            //   IF Rec."Core Clerkship Subject Code" = 'FMCCSSE' then
            // FMCCSECongratulations(StudentNumber);

            // // IF Rec."Core Clerkship Subject Code" = 'IMCCSSE' then
            // IMCCSECongratulations(StudentNumber);

            // // IF Rec."Core Clerkship Subject Code" = 'OBGCCSSE' then
            // OBGCCSSE(StudentNumber);

            // // IF Rec."Core Clerkship Subject Code" = 'PEDCCSSE' then
            // PediatricsCCSE(StudentNumber);

            // // IF Rec."Core Clerkship Subject Code" = 'PSYCCSSE' then
            // PsychCCSE(StudentNumber);

            // // IF Rec."Core Clerkship Subject Code" = 'CK' then
            // Step2CK(StudentNumber);

            // // IF Rec."Core Clerkship Subject Code" = 'SURCCSSE' then
            // SurgeryCCSE(StudentNumber);

            // // IF Rec."Core Clerkship Subject Code" = 'CCSE' then
            // CCSE(StudentNumber);

            Until CBSECCSEScoresRec1.Next() = 0;
        end else
            Error('There is no UnMatched data.');
    end;

    procedure USMLEFunction()
    var
        USMLEPerformanceRec1: Record "USMLE Performance Data";
        LineNo: Integer;
        StudentNumber: Code[20];
    begin
        USMLEPerformanceRec1.Reset();
        USMLEPerformanceRec1.SetRange("Published Document No.", Rec."Document No.");
        USMLEPerformanceRec1.SetRange(Published, false);
        USMLEPerformanceRec1.SetRange("Result Matched", false);
        USMLEPerformanceRec1.SetRange(Duplicate, false);
        if USMLEPerformanceRec1.FindSet() then begin
            Repeat
                StudentNumber := '';
                StudentMasterRec.Reset();
                StudentMasterRec.setrange(USMLEID, USMLEPerformanceRec1."USMLE ID");
                StudentMasterRec.SetRange("Global Dimension 1 Code", '9000');
                IF StudentMasterRec.Findfirst() then begin
                    StudentNumber := StudentMasterFunction(StudentMasterRec."Original Student No.");
                    IF StudentNumber <> '' then begin
                        StudentSubjectExamRec.Reset();
                        StudentSubjectExamRec.SetRange("Student No.", StudentMasterRec."No.");
                        StudentSubjectExamRec.SetRange("Sitting Date", USMLEPerformanceRec1."Date of Exam");
                        IF StudentSubjectExamRec.FindFirst() then begin
                            USMLEPerformanceRec1.Duplicate := true;
                            USMLEPerformanceRec1.Modify();
                        end;
                        If not USMLEPerformanceRec1.Duplicate then
                            USMLEStudentSubjectExamFunction(StudentMasterRec."No.", USMLEPerformanceRec1."Entry No.", USMLEPerformanceRec1."3 Digit Score", USMLEPerformanceRec1."Step Exam");
                    end;

                end ELse begin
                    IF USMLEPerformanceRec1."Unique Medical School ID" <> '' then begin
                        StudentMasterRec.Reset();
                        StudentMasterRec.setrange("Original Student No.", USMLEPerformanceRec1."Unique Medical School ID");
                        StudentMasterRec.SetRange("Global Dimension 1 Code", '9000');
                        IF StudentMasterRec.Findfirst() then begin

                            StudentNumber := StudentMasterFunction(StudentMasterRec."No.");
                            IF StudentNumber <> '' then begin
                                StudentSubjectExamRec.Reset();
                                StudentSubjectExamRec.SetRange("Student No.", StudentMasterRec."No.");
                                StudentSubjectExamRec.SetRange("Sitting Date", USMLEPerformanceRec1."Date of Exam");
                                IF StudentSubjectExamRec.FindFirst() then begin
                                    USMLEPerformanceRec1.Duplicate := true;
                                    USMLEPerformanceRec1.Modify();
                                end;
                                If not USMLEPerformanceRec1.Duplicate then
                                    USMLEStudentSubjectExamFunction(StudentMasterRec."No.", USMLEPerformanceRec1."Entry No.", USMLEPerformanceRec1."3 Digit Score", USMLEPerformanceRec1."Step Exam");
                            end;
                        end;
                    end;
                end;
            until USMLEPerformanceRec1.Next() = 0;
        end else
            Error('There is no UnMatched data.');

    end;

    procedure StudentSubjectExamFunction(StudentNo: Code[20]; EntryNo: Integer; ExtMarks: Decimal; ExamDate: Date; ScoreType: Option " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK"
    ; SubjectCode: Code[20])
    var
        LineNo: Integer;
    begin
        CBSECCSEScoresRec.Reset();
        CBSECCSEScoresRec.SetRange("Entry No.", EntryNo);
        CBSECCSEScoresRec.SetRange(Duplicate, false);
        IF CBSECCSEScoresRec.FindFirst() then begin


            StudentMasterRec.Get(StudentNo);

            StudentSubjectExamRec.Reset();
            StudentSubjectExamRec.SetCurrentKey("Line No.");
            StudentSubjectExamRec.SetRange("Student No.", StudentNo);
            StudentSubjectExamRec.SetFilter("Line No.", '<>%1', 0);
            if StudentSubjectExamRec.FindLast() then
                LineNo := StudentSubjectExamRec."Line No." + 10
            Else
                LineNo := 10;

            StudentSubjectExamRec.Reset();
            StudentSubjectExamRec.SetRange("Student No.", StudentNo);
            StudentSubjectExamRec.SetRange("Score Type", ScoreType);
            if ScoreType = ScoreType::CCSSE then
                StudentSubjectExamRec.SetRange("Core Clerkship Subject Code", SubjectCode);
            if StudentSubjectExamRec.FindLast() then begin
                SubjectMasterRec.Reset();
                SubjectMasterRec.SetRange(Code, StudentSubjectExamRec."Subject Code");

                if SubjectMasterRec.FindFirst() then
                    ExamSeq := SubjectMasterRec."Exam Sequence" + 1;

                SubjectMasterRec1.Reset();
                SubjectMasterRec1.SetRange("Score type", ScoreType);
                SubjectMasterRec1.SetRange("Exam Sequence", ExamSeq);
                SubjectMasterRec1.FindFirst();

                StudentSubjectExamRec.INIT();
                StudentSubjectExamRec.Validate("Student No.", StudentNo);
                StudentSubjectExamRec.Validate("Subject Code", SubjectMasterRec1.Code);
                StudentSubjectExamRec."Line No." := LineNo;

                StudentSubjectExamRec.Validate(Semester, StudentMasterRec.Semester);
                StudentSubjectExamRec.Course := StudentMasterRec."Course Code";
                StudentSubjectExamRec."Published Entry No." := EntryNo;
                StudentSubjectExamRec."Original Student No." := StudentMasterRec."Original Student No.";

                StudentSubjectExamRec."Sitting Date" := ExamDate;
                StudentSubjectExamRec.Validate("Core Clerkship Subject Code", CBSECCSEScoresRec."Subject Code");
                StudentSubjectExamRec."Academic Year" := StudentMasterRec."Academic Year";
                StudentSubjectExamRec."Score Type" := ScoreType;
                if ScoreType = ScoreType::CCSSE then
                    StudentSubjectExamRec.Validate("Shelf Exam Value", ExtMarks)
                else
                    StudentSubjectExamRec.Validate("External Mark", ExtMarks);
                StudentMasterRec.reset();
                IF StudentMasterRec.get(StudentNo) then begin
                    StudentSubjectExamRec.Term := StudentMasterRec.Term;
                    StudentSubjectExamRec.Year := StudentMasterRec.Year;
                    CourseMasterRec.Reset();
                    CourseMasterRec.SetRange(Code, StudentMasterRec."Course Code");
                    IF CourseMasterRec.FindFirst() then begin
                        CourseSemesterMasterRec.Reset();
                        CourseSemesterMasterRec.SetRange("Course Code", CourseMasterRec.Code);
                        CourseSemesterMasterRec.SetRange("Academic Year", StudentMasterRec."Academic Year");
                        CourseSemesterMasterRec.SetRange(Term, StudentMasterRec.Term);
                        CourseSemesterMasterRec.SetRange("Semester Code", StudentMasterRec.Semester);
                        IF CourseSemesterMasterRec.FindFirst() then begin
                            StudentSubjectExamRec."Start Date" := CourseSemesterMasterRec."Start Date";
                            StudentSubjectExamRec."End Date" := CourseSemesterMasterRec."End Date";
                        end;
                    end;
                end;

                StudentSubjectExamRec.Insert(True);
                CBSECCSEScoresRec.Reset();
                IF CBSECCSEScoresRec.Get(EntryNo) then begin
                    CBSECCSEScoresRec."Result Matched" := true;
                    CBSECCSEScoresRec.Modify();
                end;


            end else begin
                SubjectMasterRec1.Reset();
                SubjectMasterRec1.SetRange("Score type", ScoreType);
                SubjectMasterRec1.SetRange("Exam Sequence", 1);
                SubjectMasterRec1.FindFirst();

                StudentSubjectExamRec.INIT();
                StudentSubjectExamRec.Validate("Student No.", StudentNo);
                StudentSubjectExamRec.Validate("Subject Code", SubjectMasterRec1.Code);
                StudentSubjectExamRec."Line No." := LineNo;
                StudentSubjectExamRec.Validate(Semester, StudentMasterRec.Semester);
                StudentSubjectExamRec.Course := StudentMasterRec."Course Code";
                StudentSubjectExamRec."Published Entry No." := EntryNo;
                StudentSubjectExamRec."Original Student No." := StudentMasterRec."Original Student No.";
                StudentSubjectExamRec."Sitting Date" := ExamDate;

                StudentSubjectExamRec."Academic Year" := StudentMasterRec."Academic Year";

                StudentSubjectExamRec.Validate("Core Clerkship Subject Code", CBSECCSEScoresRec."Subject Code");
                StudentSubjectExamRec."Score Type" := ScoreType;
                if ScoreType = ScoreType::CCSSE then
                    StudentSubjectExamRec.Validate("Shelf Exam Value", ExtMarks)
                else
                    StudentSubjectExamRec.Validate("External Mark", ExtMarks);

                StudentMasterRec.reset();
                IF StudentMasterRec.get(StudentNo) then begin
                    StudentSubjectExamRec.Term := StudentMasterRec.Term;
                    StudentSubjectExamRec.Year := StudentMasterRec.Year;
                    CourseMasterRec.Reset();
                    CourseMasterRec.SetRange(Code, StudentMasterRec."Course Code");
                    IF CourseMasterRec.FindFirst() then begin
                        CourseSemesterMasterRec.Reset();
                        CourseSemesterMasterRec.SetRange("Course Code", CourseMasterRec.Code);
                        CourseSemesterMasterRec.SetRange("Academic Year", StudentMasterRec."Academic Year");
                        CourseSemesterMasterRec.SetRange(Term, StudentMasterRec.Term);
                        CourseSemesterMasterRec.SetRange("Semester Code", StudentMasterRec.Semester);
                        IF CourseSemesterMasterRec.FindFirst() then begin
                            StudentSubjectExamRec."Start Date" := CourseSemesterMasterRec."Start Date";
                            StudentSubjectExamRec."End Date" := CourseSemesterMasterRec."End Date";
                        end;
                    end;
                end;

                StudentSubjectExamRec.Insert(True);
                CBSECCSEScoresRec.Reset();
                IF CBSECCSEScoresRec.Get(EntryNo) then begin
                    CBSECCSEScoresRec."Result Matched" := true;
                    CBSECCSEScoresRec.Modify();
                end;
            end;
        End;
    end;

    procedure USMLEStudentSubjectExamFunction(StudentNo: Code[20]; EntryNo: Integer; ExtMarks: Decimal; ScoreType: Option " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK")
    var
        LineNo: Integer;
    begin
        USMLEPerformanceRec.Reset();
        USMLEPerformanceRec.SetRange("Entry No.", EntryNo);
        USMLEPerformanceRec.SetRange(Duplicate, false);
        IF USMLEPerformanceRec.FindFirst() then begin

            StudentSubjectExamRec.Reset();
            StudentSubjectExamRec.SetCurrentKey("Line No.");
            StudentSubjectExamRec.SetRange("Student No.", StudentNo);
            StudentSubjectExamRec.SetFilter("Line No.", '<>%1', 0);
            if StudentSubjectExamRec.FindLast() then
                LineNo := StudentSubjectExamRec."Line No." + 10
            Else
                LineNo := 10;

            StudentSubjectExamRec.Reset();
            StudentSubjectExamRec.SetRange("Student No.", StudentNo);
            StudentSubjectExamRec.SetRange("Score Type", USMLEPerformanceRec."Step Exam");

            if StudentSubjectExamRec.FindLast() then begin
                SubjectMasterRec.Reset();
                SubjectMasterRec.SetRange(Code, StudentSubjectExamRec."Subject Code");
                StudentSubjectExamRec.Term := StudentMasterRec.Term;
                StudentSubjectExamRec.Year := StudentMasterRec.Year;
                if SubjectMasterRec.FindFirst() then
                    ExamSeq := SubjectMasterRec."Exam Sequence" + 1;


                SubjectMasterRec1.Reset();
                SubjectMasterRec1.SetRange("Score type", USMLEPerformanceRec."Step Exam");
                SubjectMasterRec1.SetRange("Exam Sequence", ExamSeq);
                SubjectMasterRec1.FindFirst();

                StudentSubjectExamRec.INIT();
                StudentSubjectExamRec.Validate("Student No.", StudentNo);
                StudentSubjectExamRec.Validate("Subject Code", SubjectMasterRec1.Code);
                StudentSubjectExamRec."Line No." := LineNo;
                StudentSubjectExamRec.Validate("External Mark", ExtMarks);
                StudentSubjectExamRec."Published Entry No." := EntryNo;
                StudentSubjectExamRec."Sitting Date" := USMLEPerformanceRec."Date of Exam";
                IF ScoreType = ScoreType::"STEP 1" then         //15Feb2022
                    Evaluate(StudentSubjectExamRec.Result, USMLEPerformanceRec."P/F");
                StudentSubjectExamRec."Score Type" := USMLEPerformanceRec."Step Exam";

                StudentMasterRec.reset();
                IF StudentMasterRec.get(StudentNo) then begin
                    StudentSubjectExamRec."Original Student No." := StudentMasterRec."Original Student No.";
                    StudentSubjectExamRec.Semester := StudentMasterRec.Semester;
                    StudentSubjectExamRec."Academic Year" := StudentMasterRec."Academic Year";
                    CourseMasterRec.Reset();
                    CourseMasterRec.SetRange(Code, StudentMasterRec."Course Code");
                    IF CourseMasterRec.FindFirst() then begin
                        CourseSemesterMasterRec.Reset();
                        CourseSemesterMasterRec.SetRange("Course Code", CourseMasterRec.Code);
                        CourseSemesterMasterRec.SetRange("Academic Year", StudentMasterRec."Academic Year");
                        CourseSemesterMasterRec.SetRange(Term, StudentMasterRec.Term);
                        CourseSemesterMasterRec.SetRange("Semester Code", StudentMasterRec.Semester);
                        IF CourseSemesterMasterRec.FindFirst() then begin
                            StudentSubjectExamRec."Start Date" := CourseSemesterMasterRec."Start Date";
                            StudentSubjectExamRec."End Date" := CourseSemesterMasterRec."End Date";
                            StudentSubjectExamRec.Validate(Semester, StudentMasterRec.Semester);
                            StudentSubjectExamRec.Course := StudentMasterRec."Course Code";
                        end;
                    end;
                end;

                StudentSubjectExamRec.Insert(True);

                USMLEPerformanceRec."Result Matched" := true;
                USMLEPerformanceRec.Modify();

            end else begin
                SubjectMasterRec1.Reset();
                SubjectMasterRec1.SetRange("Score type", USMLEPerformanceRec."Step Exam");
                SubjectMasterRec1.SetRange("Exam Sequence", 1);
                SubjectMasterRec1.FindFirst();

                StudentSubjectExamRec.INIT();
                StudentSubjectExamRec.Validate("Student No.", StudentNo);
                StudentSubjectExamRec.Validate("Subject Code", SubjectMasterRec1.Code);

                StudentSubjectExamRec.Validate(Semester, StudentMasterRec.Semester);
                StudentSubjectExamRec.Course := StudentMasterRec."Course Code";
                StudentSubjectExamRec.Validate("External Mark", ExtMarks);
                IF ScoreType = ScoreType::"STEP 1" then
                    Evaluate(StudentSubjectExamRec.Result, USMLEPerformanceRec."P/F");
                StudentSubjectExamRec."Published Entry No." := EntryNo;
                StudentSubjectExamRec."Sitting Date" := USMLEPerformanceRec."Date of Exam";

                StudentSubjectExamRec."Score Type" := USMLEPerformanceRec."Step Exam";

                StudentMasterRec.reset();
                IF StudentMasterRec.get(StudentNo) then begin
                    StudentSubjectExamRec.Term := StudentMasterRec.Term;
                    StudentSubjectExamRec.Year := StudentMasterRec.Year;
                    StudentSubjectExamRec."Original Student No." := StudentMasterRec."Original Student No.";
                    StudentSubjectExamRec.Semester := StudentMasterRec.Semester;
                    StudentSubjectExamRec."Academic Year" := StudentMasterRec."Academic Year";
                    CourseMasterRec.Reset();
                    CourseMasterRec.SetRange(Code, StudentMasterRec."Course Code");
                    IF CourseMasterRec.FindFirst() then begin
                        CourseSemesterMasterRec.Reset();
                        CourseSemesterMasterRec.SetRange("Course Code", CourseMasterRec.Code);
                        CourseSemesterMasterRec.SetRange("Academic Year", StudentMasterRec."Academic Year");
                        CourseSemesterMasterRec.SetRange(Term, StudentMasterRec.Term);
                        CourseSemesterMasterRec.SetRange("Semester Code", StudentMasterRec.Semester);
                        IF CourseSemesterMasterRec.FindFirst() then begin
                            StudentSubjectExamRec."Start Date" := CourseSemesterMasterRec."Start Date";
                            StudentSubjectExamRec."End Date" := CourseSemesterMasterRec."End Date";

                        end;
                    end;
                end;
                StudentSubjectExamRec.Insert(True);

                USMLEPerformanceRec."Result Matched" := true;
                USMLEPerformanceRec.Modify();
            end;
        end;
    end;

    procedure StudentMasterFunction(StudentNo: Code[20]): Code[20]
    var
    // SemesterMaster: Record "Semester Master-CS";
    begin
        StudentMasterRec.Reset();
        StudentMasterRec.SetCurrentKey("Enrollment Order");
        StudentMasterRec.SetRange("Original Student No.", StudentNo);
        StudentMasterRec.SetRange("Global Dimension 1 Code", '9000');
        if StudentMasterRec.FindLast() then
            Exit(StudentMasterRec."No.");

        // StudentMasterRec.Reset();
        // StudentMasterRec.SetRange("Original Student No.", StudentNo);
        // StudentMasterRec.SetRange("Global Dimension 1 Code", '9000');
        // if StudentMasterRec.FindSet() then
        //     repeat
        //         SemesterMaster.Reset();
        //         SemesterMaster.SetRange(Code, StudentMasterRec.Semester);
        //         SemesterMaster.SetFilter(Sequence, '>=%1', 4);
        //         If SemesterMaster.FindFirst() then begin
        //             CourseMasterRec.Reset();
        //             CourseMasterRec.SetRange(Code, StudentMasterRec."Course Code");
        //             CourseMasterRec.SetRange("Clinical Clerkship Applicable", true);
        //             if CourseMasterRec.findfirst() then begin
        //                 if StudentStatusRec.Get(StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code") then begin
        //                     if not (StudentStatusRec.Status in [StudentStatusRec.Status::Deferred, StudentStatusRec.Status::Declined,
        //                     StudentStatusRec.Status::Suspension, StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Dismissed,
        //                     StudentStatusRec.Status::Deceased, StudentStatusRec.Status::Graduated, StudentStatusRec.Status::TOPROG]) then
        //                         Exit(StudentMasterRec."No.")
        //                 end else
        //                     Error('The Status does not exist. Identification fields and Values: Code = %1, Institute Code = %2, for Student No. = %3',
        //                     StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code", StudentNo);
        //             end;
        //         end;
        //     until StudentMasterRec.Next() = 0;
    end;

    procedure PublishedMarks()
    Var
        ExamPassing: record "Exam Passing";
        CBSECCSEScores_lRec: Record "CBSE CCSE Scores";
        USMLEPerformanceData_lRec: Record "USMLE Performance Data";
        StudentMatser: Record "Student Master-CS";
        CCSSEScoreConversion: Record "CCSSE Score Conversion";
        StudentSubjectExam: Record "Student Subject Exam";
        StudentNo: Code[20];
    begin
        If Rec."Score Type" IN [Rec."Score Type"::CCSE, Rec."Score Type"::CBSE, Rec."Score Type"::CCSSE] then begin
            CBSECCSEScoresRec.Reset();
            CBSECCSEScoresRec.SetRange(Type, Rec."Score Type");
            CBSECCSEScoresRec.SetRange(Published, false);
            CBSECCSEScoresRec.SetRange("Result Matched", true);
            CBSECCSEScoresRec.SetRange("Published Document No.", Rec."Document No.");
            if CBSECCSEScoresRec.Findfirst() then begin
                repeat
                    StudentNo := '';
                    StudentNo := StudentMasterFunction(CBSECCSEScoresRec.ID);
                    StudentSubjectExamRec.Reset();
                    StudentSubjectExamRec.SetRange("Published Entry No.", CBSECCSEScoresRec."Entry No.");
                    StudentSubjectExamRec.SetRange("Original Student No.", CBSECCSEScoresRec.ID);
                    StudentSubjectExamRec.SetRange("Student No.", StudentNo);
                    StudentSubjectExamRec.SetRange("Score Type", CBSECCSEScoresRec.Type);
                    if StudentSubjectExamRec.FindFirst() then begin
                        StudentSubjectExamRec."Published Document No." := CBSECCSEScoresRec."Published Document No.";
                        StudentSubjectExamRec.Published := true;

                        IF Rec."Score Type" = Rec."Score Type"::CCSSE then
                            UpdateRostationStatus(StudentSubjectExamRec);

                        //key(Key1; Rec."Student No.", Course, Semester, 
                        //"Academic Year", "Subject Code", Section, "Line No.")
                        CBSEExamCount := 0;
                        CBSEExamCount2 := 0;
                        CrsSem.Reset();
                        CrsSem.SetRange("Course Code", StudentSubjectExamRec.Course);
                        CrsSem.SetRange("Semester Code", StudentSubjectExamRec.Semester);
                        if CrsSem.FindFirst() then;

                        if CrsSem."Sequence No" = 4 then begin
                            StudExam.Reset();
                            StudExam.SetRange("Student No.", StudentSubjectExamRec."Student No.");
                            StudExam.SetRange(Course, StudentSubjectExamRec.Course);
                            StudExam.SetRange(Semester, StudentSubjectExamRec.Semester);
                            StudExam.SetRange("Score Type", StudExam."Score Type"::CBSE);
                            StudExam.SetRange("Global Dimension 1 Code", StudentSubjectExamRec."Global Dimension 1 Code");
                            StudExam.SetFilter("Sitting Date", '<>%1', StudentSubjectExamRec."Sitting Date");
                            CBSEExamCount := StudExam.Count();

                            StudentSubjectExamRec."CBSE Version" := '1.' + format(CBSEExamCount + 1);
                        end
                        else
                            if CrsSem."Sequence No" = 5 then begin
                                StudExam.Reset();
                                StudExam.SetRange("Student No.", StudentSubjectExamRec."Student No.");
                                StudExam.SetRange(Course, StudentSubjectExamRec.Course);
                                StudExam.SetRange(Semester, StudentSubjectExamRec.Semester);
                                StudExam.SetRange("Academic Year", StudentSubjectExamRec."Academic Year");
                                StudExam.SetRange(Term, StudentSubjectExamRec.Term);
                                StudExam.SetRange("Score Type", StudExam."Score Type"::CBSE);
                                StudExam.SetRange("Global Dimension 1 Code", StudentSubjectExamRec."Global Dimension 1 Code");
                                StudExam.SetFilter("Sitting Date", '<>%1', StudentSubjectExamRec."Sitting Date");
                                CBSEExamCount := StudExam.Count();

                                if CBSEExamCount = 0 then
                                    StudentSubjectExamRec."CBSE Version" := '2.1'
                                else
                                    // if CBSEExamCount = 1 then
                                    //     StudentSubjectExamRec."CBSE Version" := '3.1'
                                    // else
                                    if CBSEExamCount >= 1 then
                                        StudentSubjectExamRec."CBSE Version" := '3.' + format(CBSEExamCount);

                                CBSEExamCount := StudExam.Count();
                                StudExam.Reset();
                                StudExam.SetRange("Student No.", StudentSubjectExamRec."Student No.");
                                StudExam.SetRange(Course, StudentSubjectExamRec.Course);
                                StudExam.SetRange(Semester, StudentSubjectExamRec.Semester);
                                StudExam.SetFilter(Term, '<>%1', StudentSubjectExamRec.Term);
                                StudExam.SetRange("Score Type", StudExam."Score Type"::CBSE);
                                StudExam.SetRange("Global Dimension 1 Code", StudentSubjectExamRec."Global Dimension 1 Code");
                                StudExam.SetFilter("Sitting Date", '<>%1', StudentSubjectExamRec."Sitting Date");
                                CBSEExamCount2 := StudExam.Count();

                                // StudExam.Reset();
                                // StudExam.SetRange("Student No.", StudentSubjectExamRec."Student No.");
                                // StudExam.SetRange(Course, StudentSubjectExamRec.Course);
                                // StudExam.SetRange(Semester, StudentSubjectExamRec.Semester);
                                // StudExam.SetRange("Academic Year", StudentSubjectExamRec."Academic Year");
                                // StudExam.SetRange(Term, StudentSubjectExamRec.Term);
                                // StudExam.SetRange("Score Type", StudExam."Score Type"::CBSE);
                                // StudExam.SetRange("Global Dimension 1 Code", StudentSubjectExamRec."Global Dimension 1 Code");
                                // StudExam.SetFilter("Sitting Date", '<>%1', StudentSubjectExamRec."Sitting Date");
                                // CBSEExamCount := StudExam.Count();
                                if CBSEExamCount2 > 0 then begin
                                    if CBSEExamCount = 0 then
                                        StudentSubjectExamRec."CBSE Version" := '4.1'
                                    else
                                        if CBSEExamCount > 0 then
                                            StudentSubjectExamRec."CBSE Version" := '4.' + format(CBSEExamCount + 1);
                                end;
                            end;


                        StudentSubjectExamRec.Modify(true);
                        // if StudentSubjectExamRec."Score Type" = StudentSubjectExamRec."Score Type"::CBSE then
                        //     CreateModifyCBSEScoreExtExam(StudentSubjectExamRec);
                    end;
                    CBSECCSEScoresRec.Published := true;
                    CBSECCSEScoresRec.Modify();
                Until CBSECCSEScoresRec.Next() = 0;
            end;
        end;
        If Rec."Score Type" = Rec."Score Type"::USMLE then begin
            USMLEPerformanceRec.Reset();
            USMLEPerformanceRec.SetRange("Published Document No.", Rec."Document No.");
            USMLEPerformanceRec.SetRange(Published, false);
            USMLEPerformanceRec.SetRange("Result Matched", true);
            if USMLEPerformanceRec.FindSet() then begin
                Repeat

                    StudentSubjectExamRec.Reset();
                    StudentSubjectExamRec.SetRange("Published Entry No.", USMLEPerformanceRec."Entry No.");
                    StudentSubjectExamRec.SetRange("Score Type", USMLEPerformanceRec."Step Exam");
                    if StudentSubjectExamRec.FindFirst() then begin
                        StudentSubjectExamRec."Published Document No." := USMLEPerformanceRec."Published Document No.";
                        StudentSubjectExamRec.Published := true;
                        StudentSubjectExamRec.Modify(true);

                        USMLERec.Reset();
                        USMLERec.SetCurrentKey("Creation Date");
                        USMLERec.Ascending(false);
                        USMLERec.SetRange(UsmleID, USMLEPerformanceRec."USMLE ID");
                        if USMLEPerformanceRec."Step Exam" = USMLEPerformanceRec."Step Exam"::"STEP 1" then
                            USMLERec.SetRange(USMLEStepNumber, '1');
                        if USMLEPerformanceRec."Step Exam" = USMLEPerformanceRec."Step Exam"::"STEP 2 CK" then
                            USMLERec.SetRange(USMLEStepNumber, 'CK');
                        if USMLEPerformanceRec."Step Exam" = USMLEPerformanceRec."Step Exam"::"STEP 2 CS" then
                            USMLERec.SetRange(USMLEStepNumber, 'CS');
                        USMLERec.SetRange(Score, '');
                        USMLERec.Setrange(Block, False);
                        USMLERec.SetFilter(USMLEWindowStartDate, '<=%1', StudentSubjectExamRec."Sitting Date");
                        USMLERec.SetFilter(USMLEWindowEndDate, '>=%1', StudentSubjectExamRec."Sitting Date");
                        if USMLERec.FindFirst() then begin
                            if StudentSubjectExamRec.Result = StudentSubjectExamRec.Result::Pass then
                                USMLERec.Status := USMLERec.Status::Passed;
                            if StudentSubjectExamRec.Result = StudentSubjectExamRec.Result::Fail then
                                USMLERec.Status := USMLERec.Status::Failed;

                            USMLERec.Score := FORMAT(USMLEPerformanceRec."3 Digit Score");
                            USMLERec.USMLETestDate := USMLEPerformanceRec."Date of Exam";
                            USMLERec.Modify();

                            StudentSubjectExamRec."Exam Window" := USMLERec."USMLETestWindow";
                            StudentSubjectExamRec.Modify(true);
                        end;
                    end;

                    // TotalWeeks := 0;
                    // CKPassed := False;
                    // RotationCompleted := false;
                    // StudentMasterRec.Reset();
                    // StudentMasterRec.SetRange(UsmleID, USMLEPerformanceRec."USMLE ID");
                    // if StudentMasterRec.FindFirst() then begin

                    //     RosterSchedulingLineRec.Reset();
                    //     RosterSchedulingLineRec.SetCurrentKey("Student No.", "Start Date");
                    //     RosterSchedulingLineRec.SetRange("Student No.", StudentMasterRec."No.");
                    //     RosterSchedulingLineRec.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', '', 'X', 'TC', 'UC', 'SC','R','F');
                    //     if RosterSchedulingLineRec.FindSet() then
                    //         repeat
                    //             TotalWeeks := TotalWeeks + RosterSchedulingLineRec."No. of Weeks";
                    //         until RosterSchedulingLineRec.Next() = 0;

                    //     if TotalWeeks >= StudentMasterRec."Clinical Curriculum" then
                    //         RotationCompleted := true;

                    //     StudentSubjectExamRec1.Reset();
                    //     StudentSubjectExamRec1.SetRange("Student No.", StudentMasterRec."No.");
                    //     StudentSubjectExamRec1.SetRange("Score Type", StudentSubjectExamRec1."Score Type"::"STEP 2 CK");
                    //     StudentSubjectExamRec1.SetRange(Result, StudentSubjectExamRec1.Result::Pass);
                    //     if StudentSubjectExamRec1.FindFirst() then
                    //         CKPassed := true;

                    //     // if (RotationCompleted) and (CKPassed) then begin
                    //     //     StudentMasterRec.Validate(StudentMasterRec.Status, 'PENDGRAD');
                    //     //     StudentMasterRec.Modify(True);
                    //     // end;
                    // end;

                    USMLEPerformanceRec.Published := true;
                    USMLEPerformanceRec.Modify();

                until USMLEPerformanceRec.Next() = 0;
            end;
        end;
        // If Rec."Score Type" = Rec."Score Type"::USMLE then begin
        //     USMLEPerformanceData_lRec.Reset();
        //     USMLEPerformanceData_lRec.SetRange("Result Matched", true);
        //     USMLEPerformanceData_lRec.SetRange(USMLEPerformanceData_lRec."Step Exam", USMLEPerformanceData_lRec."Step Exam"::"STEP 2 CK");
        //     USMLEPerformanceData_lRec.SetRange("Published Document No.", Rec."Document No.");
        //     IF USMLEPerformanceData_lRec.FindSet() then
        //         repeat
        //             StudentMatser.Reset();
        //             StudentMatser.SetRange(UsmleID, USMLEPerformanceData_lRec."USMLE ID");
        //             IF StudentMatser.FindFirst() then begin

        //                 StudentSubjectExamRec.Reset();
        //                 StudentSubjectExamRec.SetRange("Published Document No.", USMLEPerformanceData_lRec."Published Document No.");
        //                 StudentSubjectExamRec.SetRange("Published Entry No.", USMLEPerformanceData_lRec."Entry No.");
        //                 StudentSubjectExam.SetRange("Original Student No.", StudentMatser."Original Student No.");
        //                 if StudentSubjectExamRec.FindFirst() then begin
        //                     ExamPassing.Reset();
        //                     ExamPassing.SetRange("Subject Code", StudentSubjectExamRec."Subject Code");
        //                     IF ExamPassing.FindFirst() then begin
        //                         IF USMLEPerformanceData_lRec."3 Digit Score" >= ExamPassing."Passing Marks" then
        //                             Step2CK(StudentSubjectExamRec."Original Student No.")
        //                         else
        //                             ExamFailure(StudentSubjectExamRec."Original Student No.");
        //                     end;
        //                 End;
        //             end;
        //         Until USMLEPerformanceData_lRec.Next() = 0;
        // End;


        // USMLEPerformanceData_lRec.Reset();
        // USMLEPerformanceData_lRec.SetRange("Published Document No.", Rec."Document No.");
        // USMLEPerformanceData_lRec.SetRange(USMLEPerformanceData_lRec."Step Exam", USMLEPerformanceData_lRec."Step Exam"::CCSE);
        // USMLEPerformanceData_lRec.SetRange("P/F", 'PASS');
        // IF USMLEPerformanceData_lRec.FindFirst() then begin



        //     StudentSubjectExamRec.Reset();
        //     StudentSubjectExamRec.SetRange("Score Type", USMLEPerformanceData_lRec."Step Exam");
        //     StudentSubjectExamRec.SetRange("Published Entry No.", USMLEPerformanceData_lRec."Entry No.");
        //     if StudentSubjectExamRec.FindFirst() then
        //         CCSE(StudentSubjectExamRec."Student No.");
        // End;
        // USMLEPerformanceData_lRec.Reset();
        // USMLEPerformanceData_lRec.SetRange("Published Document No.", Rec."Document No.");
        // USMLEPerformanceData_lRec.SetRange("P/F", 'FAIL');
        // IF USMLEPerformanceData_lRec.FindFirst() then begin
        //     StudentSubjectExamRec.Reset();
        //     StudentSubjectExamRec.SetRange("Score Type", USMLEPerformanceData_lRec."Step Exam");
        //     StudentSubjectExamRec.SetRange("Published Entry No.", USMLEPerformanceData_lRec."Entry No.");
        //     if StudentSubjectExamRec.FindFirst() then
        //         ExamFailure(StudentSubjectExamRec."Student No.");
        // End;

        // // CBSECCSEScores_lRec.Reset();
        // // CBSECCSEScores_lRec.SetRange("Published Document No.", Rec."Document No.");
        // // IF CBSECCSEScores_lRec.FindSet() then
        // //     repeat
        // //         If Rec."Score Type" = Rec."Score Type"::CCSE then begin
        // //             StudentSubjectExamRec.Reset();
        // //             StudentSubjectExamRec.SetRange("Published Document No.", CBSECCSEScores_lRec."Published Document No.");
        // //             StudentSubjectExamRec.SetRange("Published Entry No.", CBSECCSEScores_lRec."Entry No.");
        // //             StudentSubjectExamRec.SetRange("Original Student No.", CBSECCSEScores_lRec.ID);
        // //             if StudentSubjectExamRec.FindFirst() then begin
        // //                 ExamPassing.Reset();
        // //                 //  ExamPassing.SetRange("Effective Date", CBSECCSEScores_lRec."Test Date");
        // //                 ExamPassing.SetRange("Subject Code", StudentSubjectExamRec."Subject Code");
        // //                 IF ExamPassing.FindFirst() then begin

        // //                     IF CBSECCSEScores_lRec."Total Test" >= ExamPassing."Passing Marks" then
        // //                         CCSE(StudentSubjectExamRec."Original Student No.")
        // //                     else
        // //                         ExamFailure(StudentSubjectExamRec."Original Student No.");
        // //                 End
        // //             end;
        // //         end;

        // If Rec."Score Type" = Rec."Score Type"::USMLE then begin
        //     StudentSubjectExamRec.Reset();
        //     StudentSubjectExamRec.SetRange("Published Document No.", CBSECCSEScores_lRec."Published Document No.");
        //     StudentSubjectExamRec.SetRange("Published Entry No.", CBSECCSEScores_lRec."Entry No.");
        //     StudentSubjectExamRec.SetRange("Student No.", CBSECCSEScores_lRec.ID);
        //     if StudentSubjectExamRec.FindFirst() then begin
        //         ExamPassing.Reset();
        //         // ExamPassing.SetRange("Effective Date", CBSECCSEScores_lRec."Test Date");
        //         ExamPassing.SetRange("Subject Code", StudentSubjectExamRec."Subject Code");
        //         IF ExamPassing.FindFirst() then begin
        //             IF CBSECCSEScores_lRec."Total Test" >= ExamPassing."Passing Marks" then
        //                 CCSE(StudentSubjectExamRec."Student No.")
        //         end else
        //             ExamFailure(StudentSubjectExamRec."Student No.");
        //     End;
        // end;


        // StudentSubjectExamRec.Reset();
        // StudentSubjectExamRec.SetRange("Published Document No.", CBSECCSEScores_lRec."Published Document No.");
        // StudentSubjectExamRec.SetRange("Published Entry No.", CBSECCSEScores_lRec."Entry No.");
        // // StudentSubjectExamRec.SetRange("Student No.", CBSECCSEScores_lRec.ID);
        // if StudentSubjectExamRec.FindFirst() then begin






        // CCSSEScoreConversion.Reset();
        // CCSSEScoreConversion.SetRange("Course Code", CBSECCSEScores_lRec."Subject Code");
        // IF CCSSEScoreConversion.FindFirst() then BEGIN



        //     IF CCSSEScoreConversion."Course Description" = 'Family Medicine' then begin
        //         IF 62 < CBSECCSEScores_lRec."Total Test" then
        //             FMCCSSECongratulations(StudentSubjectExamRec."Original Student No.")
        //         else
        //             ExamFailure(StudentSubjectExamRec."Original Student No.");

        //         //Message('%1', '1');
        //     end;

        //     IF CCSSEScoreConversion."Course Description" = 'Internal Medicine' then begin
        //         IF 59 < CBSECCSEScores_lRec."Total Test" then
        //             IMCCSSECongratulations(StudentSubjectExamRec."Original Student No.")
        //         else
        //             ExamFailure(StudentSubjectExamRec."Original Student No.");
        //         //Message('%1', '2');
        //     end;

        //     IF CCSSEScoreConversion."Course Description" = 'Obstetrics and Gynecology' then begin
        //         IF 64 < CBSECCSEScores_lRec."Total Test" then
        //             OBGCCSSE(StudentSubjectExamRec."Original Student No.")
        //         else
        //             ExamFailure(StudentSubjectExamRec."Original Student No.");
        //         //Message('%1', '3');
        //     end;


        //     IF CCSSEScoreConversion."Course Description" = 'Pediatrics' then begin
        //         IF 64 < CBSECCSEScores_lRec."Total Test" then
        //             PediatricsCCSSE(StudentSubjectExamRec."Original Student No.")
        //         else
        //             ExamFailure(StudentSubjectExamRec."Original Student No.");
        //         //Message('%1', '4');
        //     end;

        //     IF CCSSEScoreConversion."Course Description" = 'Psychiatry' then begin
        //         IF 69 < CBSECCSEScores_lRec."Total Test" then
        //             PsychCCSSE(StudentSubjectExamRec."Original Student No.")
        //         else
        //             ExamFailure(StudentSubjectExamRec."Original Student No.");
        //         //Message('%1', '5');
        //     end;


        //     IF CCSSEScoreConversion."Course Description" = 'Surgery' then begin
        //         IF 60 < CBSECCSEScores_lRec."Total Test" then
        //             SurgeryCCSSE(StudentSubjectExamRec."Original Student No.")
        //         else
        //             ExamFailure(StudentSubjectExamRec."Original Student No.");
        //         //Message('%1', '6');
        //     end;
        // END;
        // End;
        //until CBSECCSEScores_lRec.next = 0;




        // ExamPassing.Reset();
        // ExamPassing.SetRange("Subject Code", Rec."Subject Code");
        // IF ExamPassing.FindFirst() then begin
        //     IF ExamPassing."Subject Code" = 'CCSE1' then begin
        //         IF ExamPassing."Passing Marks" <= 210 then;
        //         //Call Function
        //     end;

        //     IF ExamPassing."Subject Code" = 'CK1' then begin
        //         IF ExamPassing."Passing Marks" <= 209 then;
        //         //Call Function
        //     end;
        // End;

    end;

    trigger OnAfterGetRecord()
    begin


        if Rec.Status = Rec.Status::Pending then
            ShowButton := true
        else
            ShowButton := false;

        ShowRequestPage := false;
        if Rec."Score Type" IN [Rec."Score Type"::CCSE, Rec."Score Type"::CBSE, Rec."Score Type"::CCSSE] then
            ShowRequestPage := true;

        ShowRequestPage1 := false;
        if Rec."Score Type" IN [Rec."Score Type"::USMLE] then
            ShowRequestPage1 := true;

        SubjectEdit := false;
        if Rec."Score Type" IN [Rec."Score Type"::CCSSE] then
            SubjectEdit := true;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Pending then
            ShowButton := true
        else
            ShowButton := false;

        SubjectEdit := false;
        if Rec."Score Type" IN [Rec."Score Type"::CCSSE] then
            SubjectEdit := true;

        ShowRequestPage := false;
        if Rec."Score Type" IN [Rec."Score Type"::CCSE, Rec."Score Type"::CBSE, Rec."Score Type"::CCSSE] then
            ShowRequestPage := true;
        ShowRequestPage1 := false;
        if Rec."Score Type" IN [Rec."Score Type"::USMLE] then
            ShowRequestPage1 := true;


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    var
        CBSECCSEScoresRec: Record "CBSE CCSE Scores";
        StudentMasterRec: Record "Student Master-CS";
        StudentSubjectExamRec: Record "Student Subject Exam";
        StudExam: Record "Student Subject Exam";
        CrsSem: Record "Course Sem. Master-CS";
        StudentSubjectExamRec1: Record "Student Subject Exam";
        StudentStatusRec: Record "Student Status";
        CourseMasterRec: Record "Course Master-CS";
        SubjectMasterRec: Record "Subject Master-CS";
        SubjectMasterRec1: Record "Subject Master-CS";
        USMLEPerformanceRec: Record "USMLE Performance Data";
        CourseSemesterMasterRec: Record "Course Sem. Master-CS";
        RosterSchedulingLineRec: Record "Roster Scheduling Line";
        USMLERec: Record USMLE;
        ExamPassingRec: Record "Exam Passing";
        CBSEExamCount: Integer;
        CBSEExamCount2: Integer;
        StudentNumber: Code[20];
        ExamSeq: Integer;
        ShowButton: Boolean;
        ShowRequestPage: Boolean;
        ShowRequestPage1: Boolean;
        SubjectEdit: Boolean;
        TotalWeeks: Integer;
        RotationCompleted: Boolean;
        CKPassed: Boolean;
        ShowDeleteButton: Boolean;
        Txt002Lbl: Label 'Document No. %1 Scores has been Matched.';
        Txt001Lbl: Label 'Do you want to Match Scores of Document No. %1 ?';
        Txt003Lbl: Label 'Document No. %1 Scores has been Published.';
        Txt004Lbl: Label 'Do you want to Published Scores of Document No. %1 ?';

    procedure GetCoreSubjectGroup()
    Var
        EducationSetup: Record "Education Setup-CS";
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Core Subject Group Code");
        Rec.SetFilter("Core Subject Groups", EducationSetup."Core Subject Group Code");
    end;

    procedure CreateModifyCBSEScoreExtExam(StudSubExam: Record "Student Subject Exam")
    //procedure CreateExternalExam(GlobalDimension1Code: Code[20]; Rec.DocNo: Code[20]; Rec.ExamClass: Code[20]; Rec.ExamType: Option " ","Internal","External"; Rec.var TotalLinesCreated: Integer)
    var
        // ExamScheduleLine: Record "Exam Time Table Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        ExternalExamHeader: Record "External Exam Header-CS";
        CourseMaster: Record "Course Master-CS";
        SubjectMaster: Record "Subject Master-CS";
        SubjMaster: Record "Subject Master-CS";
        StudentExternalLine: Record "External Exam Line-CS";
        // StudentSubject: Record "Main Student Subject-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        Lvl1Subj: Code[20];
        NEXTNo: Code[20];
    Begin
        AcademicsSetupCS.Get();
        SubjMaster.Reset();
        SubjMaster.SetRange(Code, StudSubExam."Subject Code");
        SubjMaster.FindFirst();

        StudentExternalLine.Reset();
        StudentExternalLine.SetRange("Global Dimension 1 Code", StudSubExam."Global Dimension 1 Code");
        StudentExternalLine.SetRange(Course, StudSubExam.Course);
        StudentExternalLine.SetRange(Semester, StudSubExam.Semester);
        StudentExternalLine.SetRange("Student No.", StudSubExam."Student No.");
        StudentExternalLine.SetRange("Academic year", StudSubExam."Academic Year");
        StudentExternalLine.SetRange(Term, StudSubExam.Term);
        StudentExternalLine.SetRange("Subject Code", StudSubExam."Subject Code");
        StudentExternalLine.SetRange("Exam Date", StudSubExam."Sitting Date");
        if not StudentExternalLine.FindFirst() then begin
            // NEXTNo := StudSubExam."Published Document No.";

            ExternalExamHeader.Reset();
            ExternalExamHeader.SetRange("Global Dimension 1 Code", StudSubExam."Global Dimension 1 Code");
            ExternalExamHeader.SetRange("Course Code", StudSubExam.Course);
            ExternalExamHeader.SetRange(Semester, StudSubExam.Semester);
            ExternalExamHeader.SetRange("Academic Year", StudSubExam."Academic Year");
            ExternalExamHeader.SetRange(Term, StudSubExam.Term);
            ExternalExamHeader.SetRange("Subject Code", StudSubExam."Subject Code");
            ExternalExamHeader.SetRange("Exam Date", StudSubExam."Sitting Date");
            if ExternalExamHeader.FindFirst() then
                CreateexternalExamLine(ExternalExamHeader, StudSubExam)
            else begin
                NEXTNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."External Marks No.", 0D, TRUE);

                ExternalExamHeader.INIT();
                ExternalExamHeader."No." := NEXTNo;
                // ExternalExamHeader."Exam Schedule Code" := ExamScheduleLine."Document No.";
                ExternalExamHeader."Course Code" := StudSubExam.Course;
                CourseMaster.Get(StudSubExam.Course);
                ExternalExamHeader."Course Name" := CourseMaster.Description;
                // ExternalExamHeader."Program" := ExamScheduleLine."Program";
                ExternalExamHeader."Type Of Course" := CourseMaster."Type Of Course";
                ExternalExamHeader."Academic Year" := StudSubExam."Academic Year";
                ExternalExamHeader.Semester := StudSubExam.Semester;
                ExternalExamHeader.Year := StudSubExam.Year;
                ExternalExamHeader."Global Dimension 1 Code" := StudSubExam."Global Dimension 1 Code";
                ExternalExamHeader."Global Dimension 2 Code" := StudSubExam."Global Dimension 2 Code";
                ExternalExamHeader."Document Type" := ExternalExamHeader."Document Type"::External;
                ExternalExamHeader."Subject Class" := SubjMaster."Subject Classification";
                ExternalExamHeader."Subject Type" := SubjMaster."Subject Type";
                ExternalExamHeader.VALIDATE("Subject Code", StudSubExam."Subject Code");
                SubjectMaster.reset();
                SubjectMaster.Setrange(Code, StudSubExam."Subject Code");
                SubjectMaster.FindFirst();
                ExternalExamHeader."External Maximum" := SubjectMaster."External Maximum";
                SubjectMaster.TestField("Total Maximum");
                ExternalExamHeader."Total Maximum" := SubjectMaster."Total Maximum";

                ExternalExamHeader.Status := ExternalExamHeader.Status::Open;
                ExternalExamHeader.Term := StudSubExam.Term;
                ExternalExamHeader.Year := StudSubExam.Year;
                ExternalExamHeader."Exam Date" := StudSubExam."Sitting Date";
                // ExternalExamHeader."Exam Slot" := ExamScheduleLine."Exam Slot New";
                // ExternalExamHeader.Batch := ExamScheduleLine.Batch;
                // ExternalExamHeader."Student Group" := ExamScheduleLine."Student Group";
                // ExternalExamHeader."Exam Classification" := StudSubExam."Exam Classification";
                ExternalExamHeader."Created By" := FORMAT(UserId());
                ExternalExamHeader."Created On" := TODAY();

                ExternalExamHeader.Insert(true);
                CreateexternalExamLine(ExternalExamHeader, StudSubExam);
            end;

        end;
    End;

    procedure CreateExternalExamLine(RecExternalExamHeader: Record "External Exam Header-CS"; StudSubExam: Record "Student Subject Exam")
    var
        StudentExternalLine: Record "External Exam Line-CS";
        SubjectMaster_1: Record "Subject Master-CS";
        Stud: Record "Student Master-CS";
        // StudentSubject: Record "Main Student Subject-CS";
        StudentLeaveAbsence: Record "Student Leave of Absence";
        SubjMaster: Record "Subject Master-CS";
        MarksWeight: Record "Marks Weightage";
        Lvl1Subj: Code[20];
        LocLineNo: Integer;
        LineExec: Integer;
    Begin

        LineExec := 0;

        if CheckIfActive(StudSubExam."Student No.") then begin
            // if DuplicationFound(ExamScheduleLine, StudentSubject, 1) then
            //     Error('Duplicate entry found for Student No. %1, Subject Code %2, Academic Year %3, Term %4',
            //     StudentSubject."Student No.", StudentSubject."Subject Code", StudentSubject."Academic Year",
            //     StudentSubject.Term);

            StudentExternalLine.RESET();
            StudentExternalLine.SETRANGE("Document No.", RecExternalExamHeader."No.");
            IF StudentExternalLine.FINDLAST() THEN
                LocLineNo := StudentExternalLine."Line No." + 10000
            ELSE
                LocLineNo := 10000;

            StudentExternalLine.INIT();
            StudentExternalLine."Document No." := RecExternalExamHeader."No.";
            StudentExternalLine."Line No." := LocLineNo;
            StudentExternalLine.Semester := StudSubExam.Semester;
            // StudentExternalLine."Type Of Course" := StudSubExam."Type Of Course";
            StudentExternalLine."Exam Schedule No." := RecExternalExamHeader."Exam Schedule Code";
            // StudentExternalLine.Section := ExamScheduleLine."Student Group";
            StudentExternalLine.Course := RecExternalExamHeader."Course Code";
            StudentExternalLine."Exam Classification" := RecExternalExamHeader."Exam Classification";
            StudentExternalLine.Term := RecExternalExamHeader.Term;
            StudentExternalLine.Year := RecExternalExamHeader.Year;

            // StudentExternalLine."Exam Slot" := ExamScheduleLine."Exam Slot New";
            // StudentExternalLine."Start Time" := ExamScheduleLine."Start Time New";
            // StudentExternalLine."End Time" := ExamScheduleLine."End Time New";
            StudentExternalLine."Attendance Type" := StudentExternalLine."Attendance Type"::Withdrawal;
            StudentExternalLine."Academic Year" := StudSubExam."Academic Year";
            // StudentExternalLine."Subject Class" := StudSubExam."Subject Class";
            // StudentExternalLine."Subject Type" := StudSubExam."Subject Type";
            StudentExternalLine."Subject Code" := StudSubExam."Subject Code";
            StudentExternalLine."CBSE Version" := StudSubExam."CBSE Version";
            StudentExternalLine.validate("Student No.", StudSubExam."Student No.");
            StudentExternalLine."Student Name" := StudSubExam."Student Name";
            Stud.Reset();
            Stud.Get(StudentExternalLine."Student No.");
            StudentExternalLine."Original Student No." := Stud."Original Student No.";
            StudentExternalLine."Enrollment No." := StudSubExam."Enrollment No";
            // StudentExternalLine.Batch := StudentSubject.Batch;
            // StudentExternalLine."Student Group" := ExamScheduleLine."Student Group";

            StudentExternalLine.VALIDATE(Status, RecExternalExamHeader.Status);
            StudentExternalLine.VALIDATE("Global Dimension 1 Code", RecExternalExamHeader."Global Dimension 1 Code");
            StudentExternalLine.Year := StudSubExam.Year;
            StudentExternalLine."Exam Type" := RecExternalExamHeader."Exam Type";
            StudentExternalLine."Program" := RecExternalExamHeader."Program";
            SubjectMaster_1.Reset();
            SubjectMaster_1.SetRange(Code, RecExternalExamHeader."Subject Code");
            SubjectMaster_1.FindFirst();

            StudentExternalLine."External Maximum" := SubjectMaster_1."External Maximum";
            SubjectMaster_1.TestField("Total Maximum");
            StudentExternalLine."Total Maximum" := SubjectMaster_1."Total Maximum";
            StudentExternalLine.validate("External Mark", StudSubExam."External Mark");
            MarksWeight.Reset();
            MarksWeight.SetRange("Global Dimension 1 Code", StudentExternalLine."Global Dimension 1 Code");
            MarksWeight.SetRange("Academic Year", StudentExternalLine."Academic year");
            MarksWeight.SetRange("Course Code", StudentExternalLine.Course);
            MarksWeight.SetRange(Semester, StudentExternalLine.Semester);
            MarksWeight.SetRange("Exam Code", StudentExternalLine."Subject Code");
            MarksWeight.SetRange(Term, StudentExternalLine.Term);
            MarksWeight.FindFirst();
            MarksWeight.TestField(Points);
            StudentExternalLine."Maximum Weightage" := MarksWeight.Points;

            StudentExternalLine."Created By" := Format(USERID());
            StudentExternalLine."Created On" := TODAY();
            StudentLeaveAbsence.Reset();
            StudentLeaveAbsence.SetRange("Student No.", StudSubExam."Student No.");
            StudentLeaveAbsence.SetFilter("Start Date", '<=%1', StudSubExam."Sitting Date");
            StudentLeaveAbsence.SetFilter("End Date", '>=%1', StudSubExam."Sitting Date");
            StudentLeaveAbsence.SetRange("Leave Status", StudentLeaveAbsence."Leave Status"::Granted);
            IF StudentLeaveAbsence.FindFirst() then begin
                StudentExternalLine."Leave Types" := Format(StudentLeaveAbsence."Leave Types");
                StudentExternalLine."Std. Grade" := Format(StudentLeaveAbsence."Leave Types");
            end;
            StudentExternalLine."Exam Date" := StudSubExam."Sitting Date";
            StudentExternalLine."Published Document No." := StudSubExam."Published Document No.";
            StudentExternalLine.INSERT(true);
            LineExec += 1;
        end;

        // if LineExec > 0 then begin
        //     ExamScheduleLine."Exam No." := RecExternalExamHeader."No.";
        //     ExamScheduleLine."Select To Generate" := false;
        //     ExamScheduleLine.Modify();
        // end;

        //Until ExamScheduleLine.Next() = 0;
    End;


    procedure CheckIfActive(StudNo: Code[20]): Boolean
    var
        EduSetup: Record "Education Setup-CS";
        Stud: Record "Student Master-CS";
        Stud2: Record "Student Master-CS";
    begin
        Stud.Get(StudNo);
        EduSetup.Reset();
        EduSetup.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        if EduSetup.FindFirst() then begin
            Stud2.Reset();
            Stud2.SetRange("No.", Stud."No.");
            Stud2.SetFilter(Status, EduSetup."Active Statuses");
            if Stud2.FindFirst() then
                Exit(True);
        end;
        Exit(false);

    end;

    procedure UpdateRostationStatus(SSE: Record "Student Subject Exam")
    Var
        SM: Record "Subject Master-CS";
        RLE: Record "Roster Ledger Entry";
        DAS: Record "DocuSign Assessment Scores";
        Hospital: Record "Vendor";
        Subjects: Text;
    begin
        SM.Reset();
        SM.SetRange("Subject Group", SSE."Core Clerkship Subject Code");
        SM.SetRange("Level Description", SM."Level Description"::"Level 2 Clinical Rotation");
        if SM.FindSet() then
            repeat
                if Subjects = '' then
                    Subjects := SM.Code
                else
                    Subjects := Subjects + '|' + SM.Code;
            until SM.Next() = 0;

        RLE.Reset();
        RLE.SetRange("Clerkship Type", RLE."Clerkship Type"::Core);
        RLE.SetRange("Student ID", SSE."Student No.");
        RLE.SetFilter("Course Code", Subjects);
        RLE.SetRange("Assessment Completed", false);
        RLE.SetFilter(Status, '%1|%2', RLE.Status::Published, RLE.Status::Scheduled);
        if RLE.FindFirst() then
            exit;

        DAS.Reset();
        DAS.SetCurrentKey("Course Group Code", "Course Start Date");
        DAS.SetRange("Student No.", SSE."Student No.");
        DAS.SetRange("Course Group Code", SSE."Core Clerkship Subject Code");
        DAS.SetFilter("Course Code", Subjects);
        if DAS.FindLast() then begin
            RLE.Reset();
            if RLE.Get(DAS."Rotation Entry No.") then begin
                Hospital.Reset();
                if Hospital.Get(RLE."Hospital ID") then
                    IF NOT Hospital."FIU Hospital" then begin
                        DAS.Published := false;
                        DAS."Published By" := '';
                        DAS."Published On" := 0D;
                    end;
            end;
            if (DAS."CCSSE Score II" = 0) and (DAS."Used CCSSE Exam Date" <> 0D) then begin //CSPL-00307 Resolving Bug for Duplicate Used CCSSE Exam Date 23-01-23 on Prod
                DAS."CCSSE Score II" := SSE."Shelf Exam Value";
                DAS."Used CCSSE Exam II Date" := SSE."Sitting Date";
            end
            else
                if (DAS."CCSSE Score III" = 0) and (DAS."Used CCSSE Exam II Date" <> 0D) then begin //CSPL-00307-BUG 23-01-2023 on Prod
                    DAS."CCSSE Score III" := SSE."Shelf Exam Value";
                    DAS."Used CCSSE Exam III Date" := SSE."Sitting Date";
                end;

            DAS.CalculateEvalCount_Sum();
            DAS.Modify();

            RLE.Reset();
            if RLE.Get(DAS."Rotation Entry No.") then begin
                RLE.Validate("Rotation Grade", '');
                RLE.Modify();
            end;
        end;
    end;
    ///Nitin
    /*
    procedure ExamFailure(StudentNo: code[20])/// Nitin
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        StudentMasterCS: Record "Student Master-CS";
        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        BCCs: List of [Text];
        BCC: Text[100];
    begin
        SmtpMailRec.Get();
        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'Exam Failure Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'Exam Failure Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentSubjectExamRec."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' We hope that this message finds you well. The Clinical EED Faculty is sorry to hear that you ' +
                          ' were unsuccessful on your recent examination. We want you to know that we are available to ' +
                          ' you for academic advising. We can provide you with cognitive restructuring guidance, study ' +
                          ' strategies and resources to improve your outcomes. The Clinical EED faculty encourage you to ' +
                          ' make an appointment using the student portal link https://portal.auamed.org Once in the portal, ' +
                          ' you can select the faculty you would like to meet with. All 1:1 sessions with C-EED faculty  ' +
                          ' will be 100% confidential and tailored to your academic concerns. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Thank you for scheduling an appointment. We look forward to meeting with you. ');
        SmtpMail.AppendtoBody('<br><br><br>');
        SmtpMail.AppendtoBody(' Sincerely, ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Manipal Education Americas,LLC ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' 40 Wall Street, 10th Floor ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' New York, NY 10005 ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' www.auamed.org ');
        BodyText := SmtpMail.GetBody();
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Exam Failure Letter', '', SenderAddress, StudentSubjectExamRec."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'Exam Failure Letter', 'Exam Failure Letter', '', '',
        Recipient, 1, '', '', 1);
    end;
    /////////////2            
    procedure FMCCSSECongratulations(StudentNo: code[20])
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        StudentMasterCS: Record "Student Master-CS";
        BCCS: List of [Text];
        BCC: Text[100];
    begin
        SmtpMailRec.Get();
        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'FM CCSSE Congratulations Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'FM CCSSE Congratulations Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentSubjectExamRec."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Congratulations on passing the Family Medicine CCSSE examination! Over the past six weeks of your ' +
                            ' Family Medicine rotation, your exposure to common facets of this specialty and sincere efforts at ' +
                            ' success have been fruitful. Completing this core rotation is a significant milestone in your medical ' + ' education. Devote some time to commend yourself for a job well done and engage in some self-care. It ' +
                            ' certainly is a positive way to continue forward along the path to write your next examination. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This ' + ' program is specifically tailored for students who are taking core rotations and focuses on improving test ' +
                            ' taking skills and content mastery.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' You may want to consider enrolling in the QP Comp Prep Program if you are preparing for the CCSE. ' + ' Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and ' +
                            ' prepare you for writing your exams. These new question sets will further enhance the efficacy of the ' + ' Question Partners Program Series, which already has proven to improve outcomes for those who have ' + ' enrolled. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' The sign-up forms for the QP Shelf Prep and the QP Comp Prep Programs are in the <a href="https://elearning.auamed.net/webapps/blackboard/content/listContentEditable.jsp?content_id=_301563_1&course_id=_6756_1&mode=reset">AUA Clinical Pulse</a>. ' +
                            ' If you would like to make an appointment for Appreciative Advising with a C-EED faculty member, ' +
                            ' you can schedule by accessing the student portal using the following link https://portal.auamed.org.  ' +
                            ' Once in the portal, you can select the faculty you would like to meet with. All 1:1 sessions with C-EED ' +
                            ' faculty will be 100% confidential and tailored to your academic concerns. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Best of Regards from the Clinical Education Enhancement Team! ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        BodyText := SmtpMail.GetBody();
        //Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('FM CCSSE Congratulations Letter', '', SenderAddress, StudentSubjectExamRec."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'FM CCSSE Congratulations Letter', 'FM CCSSE Congratulations Letter', '', '',
        Recipient, 1, '', '', 1);
    end;

    ///3
    procedure IMCCSSECongratulations(StudentNo: Code[20])
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        StudentMasterCS: Record "Student Master-CS";
        BCCs: List of [Text];
        BCC: Text[100];
    begin
        SmtpMailRec.Get();
        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'IM CCSSE Congratulations Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'IM CCSSE Congratulations Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentSubjectExamRec."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Congratulations on passing the Internal Medicine CCSSE examination! In the field of medicine, Internal ' +
                         ' Medicine is the largest sub-discipline and has the most subspecialties. Successful completion of this core ' +
                         ' rotation is a huge milestone in your medical education. Take some time to celebrate your success and ' + ' engage in some self-care. It will be a great way to reset yourself as you forge forth on the path to write ' +
                         ' your next examination.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This program is specifically tailored for students who are taking core rotations and focuses on improving test ' +
                            ' taking skills and content mastery.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' You may want to consider enrolling in the QP Comp Prep Program if you are preparing for the CCSE. ' + ' Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and ' +
                            ' prepare you for writing your exams. These new question sets will further enhance the efficacy of the  ' + ' Question Partners Program Series, which already has proven to improve outcomes for those who have ' + ' enrolled. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' The sign-up forms for the QP Shelf Prep and the QP Comp Prep Programs are in the <a href="https://elearning.auamed.net/webapps/blackboard/content/listContentEditable.jsp?content_id=_301563_1&course_id=_6756_1&mode=reset">AUA Clinical Pulse</a>. ' +
                            ' If you would like to make an appointment for Appreciative Advising with a C-EED faculty member, ' +
                            ' you can schedule by accessing the student portal using the following link https://portal.auamed.org.  ' +
                            ' Once in the portal, you can select the faculty you would like to meet with. All 1:1 sessions with C-EED ' +
                            ' faculty will be 100% confidential and tailored to your academic concerns. ');
        SmtpMail.AppendtoBody('<br><br><br>');
        SmtpMail.AppendtoBody(' Best of Regards from the Clinical Education Enhancement Team! ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        BodyText := SmtpMail.GetBody();
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        //Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('IM CCSSE Congratulations Letter', '', SenderAddress, StudentSubjectExamRec."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'IM CCSSE Congratulations Letter', 'IM CCSSE Congratulations Letter', '', '',
        Recipient, 1, '', '', 1);
    end;
    //4
    procedure OBGCCSSE(StudentNo: Code[20])
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        StudentMasterCS: Record "Student Master-CS";
        BCCs: List of [Text];
        BCC: Text[100];
    begin
        SmtpMailRec.Get();

        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'OB.GYN CCSSE Congratulations Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'OB.GYN CCSSE Congratulations Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentSubjectExamRec."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Congratulations on passing the Ob/GYN CCSSE examination! OB/GYN Chair Dr. John Riggs says that ' +
                            ' “OB/GYN is a specialty that incorporates almost all other services being that many female patients only ' +
                            ' see their OB/GYN as their primary care provider”. Your success at the OB/GYN CCSSE demonstrates your ' + ' ability to cover all aspects of womens health as designated by this specialty practice. Do carve out time ' +
                            ' to celebrate your success while you continue to complete the milestones in your medical education. We ' + ' also suggest you partake in self-care along your journey. Self-care is an important part of continued ' +
                            ' success as you advance toward writing your next examination. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This ' + ' program is specifically tailored for students who are taking core rotations and focuses on improving test ' +
                            ' taking skills and content mastery.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' You may want to consider enrolling in the QP Comp Prep Program if you are preparing for the CCSE. ' + ' Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and ' +
                            ' prepare you for writing your exams. These new question sets will further enhance the efficacy of ' + ' Question Partners Program Series, which already has proven to improve outcomes for those who have ' + ' enrolled. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' The sign-up forms for the QP Shelf Prep and the QP Comp Prep Programs are in the <a href="https://elearning.auamed.net/webapps/blackboard/content/listContentEditable.jsp?content_id=_301563_1&course_id=_6756_1&mode=reset">AUA Clinical Pulse</a>. ' +
                            ' If you would like to make an appointment for Appreciative Advising with a C-EED faculty member, ' +
                            ' you can schedule by accessing the student portal using the following link https://portal.auamed.org.  ' +
                            ' Once in the portal, you can select the faculty you would like to meet with. All 1:1 sessions with C-EED ' +
                            ' faculty will be 100% confidential and tailored to your academic concerns. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Best of Regards from the Clinical EducationEnhancement Team! ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        BodyText := SmtpMail.GetBody();
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        //Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('OB.GYN CCSSE Congratulations Letter', '', SenderAddress, StudentSubjectExamRec."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'OB.GYN CCSSE Congratulations Letter', 'OB.GYN CCSSE Congratulations Letter', '', '',
        Recipient, 1, '', '', 1);
    end;
    //5
    procedure PediatricsCCSSE(StudentNo: Code[20])
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        StudentMasterCS: Record "Student Master-CS";
        BCCs: List of [Text];
        BCC: Text[100];
    begin
        SmtpMailRec.Get();

        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'Pediatrics CCSSE Congratulations Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'Pediatrics CCSSE Congratulations Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentSubjectExamRec."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Congratulations on passing the Pediatrics CCSSE examination! Pediatrics has many intricacies that ' +
                            ' require the aspiring physician to be attentive to. Your attention to these details “will go a long way ' +
                            ' toward making you a good doctor, which is what it’s all about” as Pediatrics Chair, Dr. Eden says. As you ' + ' continue to complete the milestones in your medical education, we suggest you take time to celebrate ' +
                            ' your success and engage in some self-care. Self-care is an important part of continued success as you ' + ' progress along your path to write your next examination. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This ' + ' program is specifically tailored for students who are taking core rotations and focuses on improving test ' +
                            ' taking skills and content mastery.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' You may want to consider enrolling in the QP Comp Prep Program if you are preparing for the CCSE. ' + ' Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and ' +
                            ' prepare you for writing your exams. These new question sets will further enhance the efficacy of the ' + ' Question Partners Program Series, which already has proven to improve outcomes for those who have ' + ' enrolled. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' The sign-up forms for the QP Shelf Prep and the QP Comp Prep Programs are in the <a href="https://elearning.auamed.net/webapps/blackboard/content/listContentEditable.jsp?content_id=_301563_1&course_id=_6756_1&mode=reset">AUA Clinical Pulse</a>. ' +
                            ' If you would like to make an appointment for Appreciative Advising with a C-EED faculty member, ' +
                            ' you can schedule by accessing the student portal using the following link https://portal.auamed.org.  ' +
                            ' Once in the portal, you can select the faculty you would like to meet with. All 1:1 sessions with C-EED ' +
                            ' faculty will be 100% confidential and tailored to your academic concerns. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Best of Regards from the Clinical Education Enhancement Team! ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        BodyText := SmtpMail.GetBody();
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        //Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Pediatrics CCSSE Congratulations Letter', '', SenderAddress, StudentSubjectExamRec."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'Pediatrics CCSSE Congratulations Letter', 'Pediatrics CCSSE Congratulations Letter', '', '',
        Recipient, 1, '', '', 1);
    end;
    //6
    procedure PsychCCSSE(StudentNo: Code[20])
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        StudentMasterCS: Record "Student Master-CS";
        BCCs: List of [Text];
        BCC: Text[100];
    begin
        SmtpMailRec.Get();

        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'Psych CCSSE Congratulations Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'Psych CCSSE Congratulations Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentSubjectExamRec."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Congratulations on passing the Psychiatry CCSSE examination! Take pride in your successful completion ' +
                            ' of this core rotation. Be sure to reserve some time to celebrate your achievement while you progress to ' +
                            ' your next milestone in your medical education. Do not forget to engage in some self-care as it is a vital ' +
                            ' part of your success in writing your next examination. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This ' + ' program is specifically tailored for students who are taking core rotations and focuses on improving test ' +
                            ' taking skills and content mastery.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' You may want to consider enrolling in the QP Comp Prep Program if you are preparing for the CCSE. ' + ' Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and ' +
                            ' prepare you for writing your exams. These new question sets will further enhance the efficacy of the ' + ' Question Partners Program Series, which already has proven to improve outcomes for those who have ' + ' enrolled. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' The sign-up forms for the QP Shelf Prep and the QP Comp Prep Programs are in the <a href="https://elearning.auamed.net/webapps/blackboard/content/listContentEditable.jsp?content_id=_301563_1&course_id=_6756_1&mode=reset">AUA Clinical Pulse</a>. ' +
                            ' If you would like to make an appointment for Appreciative Advising with a C-EED faculty member, ' +
                            ' you can schedule by accessing the student portal using the following link https://portal.auamed.org.  ' +
                            ' Once in the portal, you can select the faculty you would like to meet with. All 1:1 sessions with C-EED ' +
                            ' faculty will be 100% confidential and tailored to your academic concerns. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Best of Regards from the Clinical EducationEnhancement Team! ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        BodyText := SmtpMail.GetBody();
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        //Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Psych CCSSE Congratulations Letter', '', SenderAddress, StudentSubjectExamRec."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'Psych CCSSE Congratulations Letter', 'Psych CCSSE Congratulations Letter', '', '',
        Recipient, 1, '', '', 1);
    end;
    //7
    procedure Step2CK(StudentNo: Code[20])
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        StudentMasterCS: Record "Student Master-CS";
        BCCs: List of [Text];
        BCC: Text[100];
    begin
        SmtpMailRec.Get();

        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'Step 2 CK Congratulations.Passed Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'Step 2 CK Congratulations.Passed Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentSubjectExamRec."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Congratulations on passing the Step 2 CK exam! Your Step 2 CK pass mark' +
                            ' demonstrates your ability to apply the knowledge, skills and understanding in the clinical ' +
                            ' sciences that are essential in providing care essential for health promotion and disease ' +
                            ' prevention. Take some time to celebrate this final milestone and the completion of your ' +
                            ' medical degree');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Congratulations, once again and we wish you all the best in your future endeavors! ');
        //SmtpMail.AppendtoBody('<br><br>');
        //SmtpMail.AppendtoBody(' Take a bow, be proud and stand tall. You deserve all the praise for a job well done. ');
        //SmtpMail.AppendtoBody('<br><br>');
        //SmtpMail.AppendtoBody(' Cheers and Best of Regards from the Clinical Education Enhancement Team! ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody(' Manipal Education Americas ');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.AppendtoBody(' 40 Wall Street,10th Floor ');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.AppendtoBody(' LLC New York,NY 10005 ');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody(' www.auamed.org ');
        BodyText := SmtpMail.GetBody();
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Step 2 CK Congratulations.Passed Letter', '', SenderAddress, StudentSubjectExamRec."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'Step 2 CK Congratulations.Passed Letter', 'Step 2 CK Congratulations.Passed Letter', '', '',
        Recipient, 1, '', '', 1);
    end;
    //8
    procedure SurgeryCCSSE(StudentNo: Code[20])
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        StudentMasterCS: Record "Student Master-CS";
        BCCs: List of [Text];
        BCC: Text[100];
    begin
        SmtpMailRec.Get();

        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'Surgery CCSSE Congratulations Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'Surgery CCSSE Congratulations Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentSubjectExamRec."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Congratulations on passing the Surgery CCSSE examination! Surgery is an extensive field of practice and ' +
                            ' includes all specialties from pediatric cardiac surgery to neurosurgery. Take pride in your successful ' +
                            ' completion of this core rotation. It is essential that you reserve some time to celebrate your ' +
                            ' achievement while you progress to your next milestone in your medical education. Do not forget to ' + ' engage in some self-care as it is a vital part of your success in writing your next examination. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This ' + ' program is specifically tailored for students who are taking core rotations and focuses on improving test ' +
                            ' taking skills and content mastery. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' You may want to consider enrolling in the QP Comp Prep Program if you are preparing for the CCSE. ' +
                            ' Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and ' +
                            ' prepare you for writing your exams. These new question sets will further enhance the efficacy of the ' +
                            ' Question Partners Program Series, which already has proven to improve outcomes for those who have ' + 'enrolled. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' The sign-up forms for the QP Shelf Prep and the QP Comp Prep Programs are in the <a href="https://elearning.auamed.net/webapps/blackboard/content/listContentEditable.jsp?content_id=_301563_1&course_id=_6756_1&mode=reset">AUA Clinical Pulse</a>. ' +
                            ' If you would like to make an appointment for Appreciative Advising with a C-EED faculty member, ' +
                            ' you can schedule by accessing the student portal using the following link https://portal.auamed.org.  ' +
                            ' Once in the portal, you can select the faculty you would like to meet with. All 1:1 sessions with C-EED ' +
                            ' faculty will be 100% confidential and tailored to your academic concerns. ');

        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Best of Regards from the Clinical EducationEnhancement Team! ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        BodyText := SmtpMail.GetBody();
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        //Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Surgery CCSSE Congratulations Letter', '', SenderAddress, StudentSubjectExamRec."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'Surgery CCSSE Congratulations Letter', 'Surgery CCSSE Congratulations Letter', '', '',
        Recipient, 1, '', '', 1);
    end;
    //9
    procedure CCSE(StudentNo: Code[20])
    var
        SmtpMailRec: Record "Email Account";

        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        StudentMasterCS: Record "Student Master-CS";
        BCCs: List of [Text];
        BCC: Text[200];
    begin
        SmtpMailRec.Get();

        clear(StudentMasterCS);
        IF StudentMasterCS.Get(StudentNo) Then;
        StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
        Recipient := StudentMasterCS."E-Mail Address";
        // Message('Mail');
        Recipients := Recipient.Split(';');
        SenderName := 'CCSE Congratulations.Passed Letter';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := 'CCSE Congratulations.Passed Letter';

        SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        SmtpMail.AppendtoBody(' Dear ' + ' ' + StudentMasterCS."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Congratulations on passing the CCSE examination! This marks a significant milestone in your medical education. ' +
                            ' Take some time to celebrate your success and engage in some self-care. It will be a great way to reset ' +
                            ' yourself as you progress onward on the path to write your Step 2 CK examination. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' You may want to consider enrolling in QP Step 2 Prep Program prior to taking Step 2 CK. The QP Step 2 Prep ' +
                            ' Program is designed to boost your confidence and your improve outcomes on the Step 2 CK exam. ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' The QP Step 2 Prep Program includes four (4) sessions; Rec.sessions are 1 ½ hour in length. Instructions' +
                            ' on how to sign up for the QP Step 2 Prep Program are located in the <a href="https://elearning.auamed.net/webapps/blackboard/content/listContentEditable.jsp?content_id=_290473_1&course_id=_6756_1&mode=reset">AUA Clinical Pulse Community</a> . ' +//GAURAV//16.08.22//
                            ' Please note that you must be logged into Blackboard to access the page.');
        //SmtpMail.AppendtoBody('https://elearning.auamed.net/webapps/blackboard/content/listContentEditable.jsp?content_id=_290473_1&course_id=_6756_1&mode=reset');

        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' If you would like to make an appointment for Appreciative Advising with a C-EED faculty member, you can ' +
                            ' schedule by accessing the student portal using the following link https://portal.auamed.org. Once in the ' +
                            ' portal, you can select the faculty you would like to meet with. All 1:1 sessions with C-EED faculty will ' +
                            ' be 100% confidential and tailored to your academic concerns.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Best of Regards from the Clinical Education  Enhancement Team! ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Dr. Nelda Ephraim, RN ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' nephraim@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Professor Qunoot Almecci ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' qalmecci@auamed.org ');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Dr. JR. Ratliff');
        // SmtpMail.AppendtoBody('jratliff@auamed.org ');
        // SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' Clinical Education Department Faculty ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' Manipal Education Americas ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' 40 Wall Street,10th Floor ');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody(' LLC New York,NY 10005 ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(' www.auamed.org ');
        BodyText := SmtpMail.GetBody();
        BCC := 'stuti.khandelwal@corporateserve.com;gaurav.kumar@corporateserve.com';// 
        BCCs := BCC.Split(';');
        If BCC <> '' then
            SmtpMail.AddBCC(BCCs);
        Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('CCSE Congratulations.Passed Letter', '', SenderAddress, StudentMasterCS."Student Name",
        StudentSubjectExamRec."Student No.", Subject, BodyText, 'CCSE Congratulations.Passed Letter', 'CCSE Congratulations.Passed Letter', '', '',
        Recipient, 1, '', '', 1);
    end;

*/
    var
        StudentSubjectExam: Record "Student Subject Exam";
        StudentName: Text[100];


}

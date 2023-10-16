page 50519 "Grade Calculation"
{

    Caption = 'Grade Calculation';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            field("Institute Code"; GlobalDimension1)
            {
                Caption = 'Institute Code';
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            }

            field(CourseCode; CourseCode)
            {
                Caption = 'Course Code';
                ApplicationArea = All;
                TableRelation = "Course Master-CS";
                Visible = false;
            }

            field("Semester"; SemesterCode)
            {
                Caption = 'Semester';
                ApplicationArea = All;
                TableRelation = "Semester Master-CS";
            }
            field("Academic Year"; AcademicYear)
            {
                Caption = 'Academic Year';
                ApplicationArea = All;
                TableRelation = "Academic Year Master-CS";
            }
            field(Term; Term)
            {
                Caption = 'Term';
                ApplicationArea = All;
                OptionCaption = 'FALL,SPRING';
            }
            // field("Exam Classification"; ExamClassification)
            // {
            //     Caption = 'Exam Classification';
            //     ApplicationArea = All;
            //     TableRelation = "Examination Type Master-CS";
            // }




        }
    }
    actions
    {
        area(Processing)
        {
            action("Generate Grade Book")
            {
                ApplicationArea = All;
                Caption = 'Generate Grade Book';
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Allocations;
                trigger OnAction()
                var
                    GradeBookHdr: Record "Grade Book Header";
                    // GradeBookHeaderPg: Page GradeBookHeader;
                    TotWT: Decimal;
                    GradeBookNo: Code[20];
                    Subjectfilter: text;
                begin
                    if not confirm('Do you want to generate Grade Book for the specified filters?') then
                        Error('Action Cancelled');
                    If GlobalDimension1 = '' then
                        Error('Institute Code cannot be blank');
                    // If CourseCode = '' then
                    //   Error('Course Code cannot be blank');
                    If SemesterCode = '' then
                        Error('Semester Code cannot be blank');
                    If AcademicYear = '' then
                        Error('Academic Year cannot be blank');
                    // if ExamClassification = '' then
                    //     Error('Exam Classification cannot be blank');

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", GlobalDimension1);
                    If EducationSetup.FindFirst() then begin
                        IF EducationSetup."Academic Year" <> AcademicYear then
                            Error('Academic Year must be same to education setup Academic Year');
                        IF EducationSetup."Even/Odd Semester" <> Term then
                            Error('Semester Type must be same to education setup Semester Type');
                    end;


                    Sem.Reset();
                    Sem.SetRange(Code, SemesterCode);
                    Sem.FindFirst();
                    Subjectfilter := '';

                    GradeBookHdr.Reset();
                    GradeBookHdr.SetRange("Global Dimension 1 Code", GlobalDimension1);
                    // GradeBookHdr.SetRange(Course, CourseCode);
                    GradeBookHdr.SetRange(Semester, SemesterCode);
                    GradeBookHdr.SetRange("Academic year", AcademicYear);
                    GradeBookHdr.SetRange(Term, Term);
                    if GradeBookHdr.FindFirst() then
                        Error('Grade Book No. %1 has already been generated for the current defined filters', GradeBookHdr."Document No.");

                    CourseSubjectLine.Reset();
                    //CourseSubjectLine.SetRange("Course Code", CourseCode);
                    CourseSubjectLine.SetCurrentKey("Subject Code");
                    CourseSubjectLine.SetRange(Semester, SemesterCode);
                    CourseSubjectLine.SETRANGE("Global Dimension 1 Code", GlobalDimension1);
                    CourseSubjectLine.SETRANGE(Examination, true);
                    CourseSubjectLine.SETFilter("Level Description", '%1', CourseSubjectLine."Level Description"::"External Examination");
                    if CourseSubjectLine.FindSet() then begin
                        repeat
                            ExternalExamLine.Reset();
                            ExternalExamLine.SetCurrentKey(ExternalExamLine."Student No.");
                            ExternalExamLine.SetRange("Global Dimension 1 Code", GlobalDimension1);
                            //ExternalExamLine.SetRange(Course, CourseCode);
                            ExternalExamLine.SetRange(Semester, SemesterCode);
                            ExternalExamLine.SetRange("Academic year", AcademicYear);
                            ExternalExamLine.SetRange(Term, Term);
                            ExternalExamLine.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                            if ExternalExamLine.FindFirst() then begin
                                If Subjectfilter <> ExternalExamLine."Subject Code" then begin          //05 June 2023 CSPL-00116
                                    ExternalExamHdr.Reset();
                                    ExternalExamHdr.Get(ExternalExamLine."Document No.");
                                    Sem.TestField("Total Weightage");
                                    TotWT += ExternalExamLine."Maximum Weightage";
                                    Subjectfilter := ExternalExamLine."Subject Code";
                                end;


                            end
                            else
                                if not ExternalExamLine.FindFirst() then
                                    Error('Mandatory Exam %1 %2 is not scheduled. Please Schedule the Exam to generate the Grade Book !',
                                     CourseSubjectLine."Subject Code", CourseSubjectLine.Description);

                        until CourseSubjectLine.Next() = 0;
                        // TotWT := TotWT / 2;
                        if Sem."Total Weightage" <> TotWT then
                            Error('All External Exams are not graded yet. Total External Weightage = %1 in Semester %2; Graded Weightage = %3.', Sem."Total Weightage", Sem.Code, TotWT);
                    end;

                    TotWT := 0;
                    Subjectfilter := '';
                    IF SemesterCode <> 'BSIC' then begin//Lucky - as per Ajay BSIC Not to be Consider for Internal Exams 22-02-22
                        CourseSubjectLine.Reset();
                        //CourseSubjectLine.SetRange("Course Code", CourseCode);
                        CourseSubjectLine.SetCurrentKey("Subject Code");
                        CourseSubjectLine.SetRange(Semester, SemesterCode);
                        CourseSubjectLine.SETRANGE("Global Dimension 1 Code", GlobalDimension1);
                        CourseSubjectLine.SETRANGE(Examination, true);
                        CourseSubjectLine.SETFilter("Level Description", '%1|%2', CourseSubjectLine."Level Description"::"Internal Examination",
                        CourseSubjectLine."Level Description"::"Internal Exam Component");
                        if CourseSubjectLine.FindSet() then begin
                            repeat
                                InternalExamHeader.Reset();
                                // InternalExamHeader.SetCurrentKey(ExternalExamLine."Student No.");
                                InternalExamHeader.SetRange("Global Dimension 1 Code", GlobalDimension1);
                                //InternalExamHeader.SetRange("Course Code", CourseCode);
                                InternalExamHeader.SetRange(Semester, SemesterCode);
                                InternalExamHeader.SetRange("Academic year", AcademicYear);
                                InternalExamHeader.SetRange(Term, Term);
                                InternalExamHeader.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                                if InternalExamHeader.FindFirst() then begin

                                    Sem.TestField("Internal Total Weightage");
                                    InternalExamLn.Reset();
                                    InternalExamLn.SetRange("Document No.", InternalExamHeader."No.");
                                    InternalExamLn.FindFirst();
                                    if CourseSubjectLine.Level = 2 then begin
                                        If Subjectfilter <> InternalExamLn."Subject Code" then begin        //05 June 2023 CSPL-00116
                                            TotWT += InternalExamLn."Maximum Weightage";
                                            Subjectfilter := InternalExamLn."Subject Code";
                                        End;

                                    end;
                                end
                                else
                                    if not InternalExamHeader.FindFirst() then
                                        Error('All neccessary Exams are not taken into consideration for current filters. Refer to Exam %1 in Course Subject Line', CourseSubjectLine."Subject Code");
                            until CourseSubjectLine.Next() = 0;
                            //TotWT := TotWT / 2;
                            if Sem."Internal Total Weightage" <> TotWT then
                                Error('All Internal Exams are not graded yet. Total Internal Weightage = %1 in Semester %2; Graded Weightage = %3.', Sem."Internal Total Weightage", Sem.Code, TotWT);
                        end;


                        InternalExamHeader.Reset();
                        InternalExamHeader.SetRange("Global Dimension 1 Code", GlobalDimension1);
                        //InternalExamHeader.SetRange("Course Code", CourseCode);
                        InternalExamHeader.SetRange(Semester, SemesterCode);
                        InternalExamHeader.SetRange("Academic year", AcademicYear);
                        InternalExamHeader.SetRange(Term, Term);
                        // InternalExamHeader.SetRange("Exam Classification", ExamClassification);
                        InternalExamHeader.SetFilter(Status, '<>%1', InternalExamHeader.Status::Published);
                        IF InternalExamHeader.FindFirst() then
                            Error('All Internal Exam(s) should be Publish. Refer to Internal Exam No. %1', InternalExamHeader."No.");
                    end;
                    ExternalExamLine.Reset();
                    ExternalExamLine.SetCurrentKey(ExternalExamLine."Student No.");
                    ExternalExamLine.SetRange("Global Dimension 1 Code", GlobalDimension1);
                    //ExternalExamLine.SetRange(Course, CourseCode);
                    ExternalExamLine.SetRange(Semester, SemesterCode);
                    ExternalExamLine.SetRange("Academic year", "AcademicYear");
                    ExternalExamLine.SetRange(Term, Term);
                    // ExternalExamLine.SetRange("Exam Classification", ExamClassification);
                    ExternalExamLine.SetFilter(Status, '<>%1', ExternalExamLine.Status::Published);
                    IF ExternalExamLine.FindFirst() then
                        Error('All External Exam(s) should be Publish. Refer to External Exam No. %1 Line %2', ExternalExamLine."Document No.", ExternalExamLine."Line No.");
                    CreateNewGradeBook(GradeBookNo);

                    // clear(GradeBookHeaderPg);
                    // GradeBookHdr.Reset();
                    // GradeBookHdr.get(GradeBookNo);
                    // GradeBookHeaderPg.SetTableView(GradeBookHdr);
                    // GradeBookHeaderPg.GetGradeBookNo(GradeBookNo);
                    // GradeBookHeaderPg.Run();

                    //Running Total Worksheet Page Data Entry
                    ExaminationMagt.RunningTotalCalcData(SemesterCode, AcademicYear, Term, GlobalDimension1);
                    //Running Total Worksheet Page Data Entry

                    // SubjectCode := '';
                    // IF CONFIRM(TEXT0005Lbl, true) THEN begin
                    //     InternalExamHeader.Reset();
                    //     InternalExamHeader.SetRange("Academic year", AcademicYear);
                    //     InternalExamHeader.SetRange(Semester, SemesterCode);
                    //     InternalExamHeader.SetRange("Global Dimension 1 Code", GlobalDimension1);
                    //     InternalExamHeader.SetRange(Term, Term);
                    //     InternalExamHeader.SetRange("Exam Classification", ExamClassification);
                    //     InternalExamHeader.SetRange(Status, InternalExamHeader.Status::Published);
                    //     IF InternalExamHeader.FindSet() then
                    //         repeat
                    //             If SubjectCode = '' then
                    //                 SubjectCode := InternalExamHeader."Subject Code"
                    //             else
                    //                 SubjectCode := Format(SubjectCode + '|' + InternalExamHeader."Subject Code");
                    //         Until InternalExamHeader.Next() = 0;

                    //     ExternalExamLine.Reset();
                    //     ExternalExamLine.SetCurrentKey(ExternalExamLine."Student No.");
                    //     ExternalExamLine.SetRange("Academic year", "AcademicYear");
                    //     ExternalExamLine.SetRange(Semester, "SemesterCode");
                    //     ExternalExamLine.SetRange("Global Dimension 1 Code", GlobalDimension1);
                    //     ExternalExamLine.SetRange(Term, Term);
                    //     ExternalExamLine.SetRange("Exam Classification", ExamClassification);
                    //     ExternalExamLine.SetRange(Status, ExternalExamLine.Status::Published);
                    //     if ExternalExamLine.FindSet() then
                    //         repeat
                    //             If StudentNum <> ExternalExamLine."Student No." then begin
                    //  ExaminationMagt.ExternalEarnedPoints(ExternalExamLine."Student No.", Term, ExamClassification);
                    //                 IF SubjectCode <> '' then
                    //                    // ExaminationMagt.InternalEarnedPoints(ExternalExamLine."Student No.", SubjectCode, Term, ExamClassification);
                    //                 ExaminationMagt.EndTotalAndBest(ExternalExamLine."Student No.", Term, ExamClassification);
                    //             end;
                    //             StudentNum := ExternalExamLine."Student No.";
                    //         until ExternalExamLine.Next() = 0;
                    //     Message('Grade Book has been Generated');
                    //     CurrPage.Close();
                    // end;
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId());
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        If EducationSetup.FindFirst() then begin
            AcademicYear := EducationSetup."Academic Year";
            GlobalDimension1 := EducationSetup."Global Dimension 1 Code";
            Term := EducationSetup."Even/Odd Semester";
        End;
    end;

    var
        InternalExamHeader: Record "Internal Exam Header-CS";
        InternalExamLn: Record "Internal Exam Line-CS";
        ExternalExamHdr: Record "External Exam Header-CS";

        ExternalExamLine: Record "External Exam Line-CS";
        Sem: Record "Semester Master-CS";
        EducationSetup: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        ExaminationMagt: Codeunit "Examination Management";
        CourseSubjectLine: Record "Course Wise Subject Line-CS";
        GradeBookHeader: record "Grade Book Header";
        AcademicYear: Code[20];
        GlobalDimension1: Code[20];
        SemesterCode: Code[20];
        CourseCode: Code[20];
        Term: Option;
        ExamClassification: Code[20];
        StudentNum: Code[20];
        SubjectCode: Code[1000];
        TEXT0005Lbl: Label 'Do You Want To Generate Grade Book ?';

    procedure CreateNewGradeBook(var pGradeBookNo: Code[20])
    var
        IntExamHdr: Record "Internal Exam Header-CS";
        ExtExamHdr: Record "External Exam Header-CS";
        ExtExamLine: Record "External Exam Line-CS";
        ExtExamLine2: Record "External Exam Line-CS";
        IntExamLine: Record "Internal Exam Line-CS";
        IntExamLine2: Record "Internal Exam Line-CS";
        Sem: Record "Semester Master-CS";
        GradeBookHdr: Record "Grade Book Header";
        HdrCreated: Integer;

    begin


        HdrCreated := 0;
        if GlobalDimension1 = '9000' then begin
            CourseSubjectLine.Reset();
            //CourseSubjectLine.SetRange("Course Code", CourseCode);
            CourseSubjectLine.SetRange(Semester, SemesterCode);
            CourseSubjectLine.SETRANGE("Global Dimension 1 Code", GlobalDimension1);
            CourseSubjectLine.SETRANGE(Examination, true);
            CourseSubjectLine.SETFilter("Level Description", '%1', CourseSubjectLine."Level Description"::"External Examination");
            CourseSubjectLine.FindSet();
            repeat
                ExtExamHdr.Reset();
                ExtExamHdr.SetRange("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                ExtExamHdr.SetRange("Course Code", CourseSubjectLine."Course Code");
                ExtExamHdr.SetRange(Semester, CourseSubjectLine.Semester);
                ExtExamHdr.SetRange("Academic Year", AcademicYear);
                ExtExamHdr.SetRange(Term, Term);
                ExtExamHdr.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                if ExtExamHdr.FindFirst() then begin
                    ExtExamLine.Reset();
                    ExtExamLine.SetRange("Document No.", ExtExamHdr."No.");
                    ExtExamLine.FindSet();
                    if HdrCreated = 0 then
                        InsertGradeBookHeader(ExtExamHdr."Global Dimension 1 Code", ExtExamHdr."Course Code", ExtExamHdr.Semester, ExtExamHdr."Academic Year", ExtExamHdr.Term, GradeBookHeader);
                    HdrCreated := 1;
                    pGradeBookNo := GradeBookHeader."Document No.";
                    repeat
                        ExtExamLine2.Reset();
                        ExtExamLine2.SetCurrentKey("Percentage Obtained");
                        ExtExamLine2.Ascending(false);
                        ExtExamLine2.SetRange("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                        ExtExamLine2.SetRange(Course, CourseSubjectLine."Course Code");
                        ExtExamLine2.SetRange(Semester, CourseSubjectLine.Semester);
                        ExtExamLine2.SetRange("Academic Year", AcademicYear);
                        ExtExamLine2.SetRange(Term, Term);
                        ExtExamLine2.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                        ExtExamLine2.SetRange("Student No.", ExtExamLine."Student No.");
                        ExtExamLine2.FindFirst();
                        InsertGradeBookLineExt(ExtExamLine2, GradeBookHeader);
                    until ExtExamLine.Next() = 0;
                end;
            until CourseSubjectLine.Next() = 0;

            GradeBookHdr.Reset();
            GradeBookHdr.Get(pGradeBookNo);
            Sem.Reset();
            Sem.SetRange(Code, GradeBookHdr.Semester);
            Sem.FindFirst();
            // For CBSE Start
            if (Sem.Sequence = 4) or (Sem.Sequence = 5) then begin
                ExtExamLine.Reset();
                ExtExamLine.SetCurrentKey("Percentage Obtained");
                ExtExamLine.Ascending(false);
                ExtExamLine.SetRange("Global Dimension 1 Code", GradeBookHdr."Global Dimension 1 Code");
                ExtExamLine.SetRange(Course, GradeBookHdr.Course);
                ExtExamLine.SetRange(Semester, GradeBookHdr.Semester);
                ExtExamLine.SetRange("Academic Year", GradeBookHdr."Academic year");
                ExtExamLine.SetRange(Term, GradeBookHdr.Term);
                // ExtExamLine.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                // ExtExamLine.SetRange("Student No.", ExtExamLine."Student No.");
                ExtExamLine.SetRange(Status, ExtExamLine.Status::Published);
                ExtExamLine.SetFilter("CBSE Version", '<>%1', '');
                ExtExamLine.FindSet();
                repeat
                    ExtExamLine2.Reset();
                    ExtExamLine2.SetCurrentKey("Percentage Obtained");
                    ExtExamLine2.Ascending(false);
                    ExtExamLine2.SetRange("Global Dimension 1 Code", GradeBookHdr."Global Dimension 1 Code");
                    ExtExamLine2.SetRange(Course, GradeBookHdr.Course);
                    ExtExamLine2.SetRange(Semester, GradeBookHdr.Semester);
                    ExtExamLine2.SetRange("Academic Year", GradeBookHdr."Academic year");
                    ExtExamLine2.SetRange(Term, GradeBookHdr.Term);
                    // ExtExamLine2.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                    ExtExamLine2.SetRange("Student No.", ExtExamLine."Student No.");
                    ExtExamLine2.SetRange(Status, ExtExamLine.Status::Published);
                    ExtExamLine2.SetFilter("CBSE Version", '<>%1', '');
                    ExtExamLine2.FindFirst();
                    InsertGradeBookLineExt(ExtExamLine2, GradeBookHeader);
                until ExtExamLine.Next() = 0;


            end;
            // For CBSE End
        end;

        //Internal Exam Grade Book
        CourseSubjectLine.Reset();
        //CourseSubjectLine.SetRange("Course Code", CourseCode);
        CourseSubjectLine.SetRange(Semester, SemesterCode);
        CourseSubjectLine.SETRANGE("Global Dimension 1 Code", GlobalDimension1);
        CourseSubjectLine.SETRANGE(Examination, true);
        IF GlobalDimension1 = '9000' then
            CourseSubjectLine.SETFilter("Level Description", '%1|%2', CourseSubjectLine."Level Description"::"Internal Examination",
                    CourseSubjectLine."Level Description"::"Internal Exam Component");
        IF GlobalDimension1 = '9100' then
            CourseSubjectLine.SetRange("Level Description", CourseSubjectLine."Level Description"::"Main Subject");
        If CourseSubjectLine.FindSet() then
            repeat
                IntExamHdr.Reset();
                IntExamHdr.SetRange("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                IntExamHdr.SetRange("Course Code", CourseSubjectLine."Course Code");
                IntExamHdr.SetRange(Semester, CourseSubjectLine.Semester);
                IntExamHdr.SetRange("Academic Year", AcademicYear);
                IntExamHdr.SetRange(Term, Term);
                IntExamHdr.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                //arv
                // IntExamHdr.SetRange("Exam Classification", ExamClassification);
                if IntExamHdr.FindFirst() then begin
                    IntExamLine.Reset();
                    IntExamLine.SetRange("Document No.", IntExamHdr."No.");
                    IntExamLine.FindSet();
                    if HdrCreated = 0 then
                        InsertGradeBookHeader(IntExamHdr."Global Dimension 1 Code", IntExamHdr."Course Code", IntExamHdr.Semester, IntExamHdr."Academic Year", IntExamHdr.Term, GradeBookHeader);
                    HdrCreated += 1;
                    pGradeBookNo := GradeBookHeader."Document No.";
                    repeat
                        //arv
                        IntExamLine2.Reset();
                        IntExamLine2.SetCurrentKey("Percentage Obtained");
                        IntExamLine2.Ascending(false);
                        IntExamLine2.SetRange("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                        IntExamLine2.SetRange(Course, CourseSubjectLine."Course Code");
                        IntExamLine2.SetRange(Semester, CourseSubjectLine.Semester);
                        IntExamLine2.SetRange("Academic Year", AcademicYear);
                        IntExamLine2.SetRange(Term, Term);
                        IntExamLine2.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                        IntExamLine2.SetRange("Student No.", IntExamLine."Student No.");
                        IntExamLine2.FindFirst();
                        InsertGradeBookLineInt(IntExamLine2, GradeBookHeader);
                    until IntExamLine.Next() = 0;
                end;
            until CourseSubjectLine.Next() = 0;
    end;

    procedure InsertGradeBookHeader(Inst: Code[20];
        Crs: Code[20];
        Sem: Code[10];
        AY: Code[20];
        Trm: Option FALL,SPRING,SUMMER; var
                                            GradeBookHdr: Record "Grade Book Header")
    var
        AcaSetup: Record "Academics Setup-CS";
        NoSeries: Codeunit NoSeriesManagement;
    begin
        AcaSetup.Get();
        AcaSetup.TestField("Grade Book Nos.");
        GradeBookHdr.Init();
        GradeBookHdr."Document No." := NoSeries.GetNextNo(AcaSetup."Grade Book Nos.", 0D, TRUE);
        GradeBookHdr."Global Dimension 1 Code" := Inst;
        GradeBookHdr.Course := Crs;
        GradeBookHdr.Semester := Sem;
        GradeBookHdr."Academic year" := AY;
        GradeBookHdr.Term := Trm;
        GradeBookHdr.Insert(True);
    end;

    procedure InsertGradeBookLineExt(pExtExamLine: Record "External Exam Line-CS"; pGradeBookHdr: Record "Grade Book Header")
    var
        GradeBook: Record "Grade Book";
        GradeBookChk: Record "Grade Book";
        SubMaster: Record "Subject Master-CS";
        StudentMaster: Record "Student Master-CS";
        RecRecommendations: Record "Recommendations";
        StudentSubjectExam: Record "Student Subject Exam";
        GradeMaster: Record "Grade Master-CS";
        GradeInput: Record "Marks Weightage";
        StudSubExam: Record "Student Subject Exam";
        LastEntryNo: Integer;
    begin
        GradeBookChk.Reset();
        GradeBookChk.SetRange("Global Dimension 1 Code", pExtExamLine."Global Dimension 1 Code");
        GradeBookChk.SetRange(Course, pExtExamLine.Course);
        GradeBookChk.SetRange(Semester, pExtExamLine.Semester);
        GradeBookChk.SetRange("Academic Year", pExtExamLine."Academic Year");
        GradeBookChk.SetRange(Term, pExtExamLine.Term);
        GradeBookChk.SetRange("Exam Code", pExtExamLine."Subject Code");
        GradeBookChk.SetRange("Student No.", pExtExamLine."Student No.");
        if not GradeBookChk.FindFirst() then begin


            GradeInput.Reset();
            GradeInput.SetRange("Global Dimension 1 Code", pExtExamLine."Global Dimension 1 Code");
            GradeInput.SetRange("Exam Code", pExtExamLine."Subject Code");
            GradeInput.SetRange("Academic Year", pExtExamLine."Academic year");
            GradeInput.SetRange("Course Code", pExtExamLine.Course);
            GradeInput.SetRange(Semester, pExtExamLine.Semester);
            GradeInput.SetRange(Term, pExtExamLine.Term);
            GradeInput.FindFirst();

            //     repeat
            StudentMaster.Reset();
            StudentMaster.Get(pExtExamLine."Student No.");
            SubMaster.Reset();
            SubMaster.SetRange(Code, pExtExamLine."Subject Code");
            SubMaster.FindFirst();

            GradeBook.Reset();
            GradeBook.SetRange("Student No.", pExtExamLine."Student No.");
            if GradeBook.FindLast() then;
            LastEntryNo := GradeBook."Entry No." + 1;

            GradeBook.Reset();
            GradeBook.Init();
            GradeBook."Entry No." := LastEntryNo;
            GradeBook."Document No." := pExtExamLine."Document No.";
            GradeBook."Grade Book No." := pGradeBookHdr."Document No.";
            GradeBook."Exam Line No." := pExtExamLine."Line No.";
            GradeBook."Student No." := pExtExamLine."Student No.";
            GradeBook."First Name" := StudentMaster."First Name";
            GradeBook."Middle Name" := StudentMaster."Middle Name";
            GradeBook."Last Name" := StudentMaster."Last Name";
            GradeBook."Student Name" := StudentMaster."Student Name";
            GradeBook."Enrollment No." := StudentMaster."Enrollment No.";
            GradeBook."Academic Year" := pExtExamLine."Academic year";
            GradeBook."Admitted Year" := StudentMaster."Admitted Year";
            GradeBook.Course := pExtExamLine.Course;
            GradeBook.Semester := pExtExamLine.Semester;
            GradeBook."Exam Code" := pExtExamLine."Subject Code";
            GradeBook.Level := SubMaster.Level;
            GradeBook."Exam Description" := SubMaster.Description;
            GradeBook."Global Dimension 1 Code" := pExtExamLine."Global Dimension 1 Code";
            GradeBook.Term := pExtExamLine.Term;
            GradeBook."Exam Classification" := pExtExamLine."Exam Classification";
            // GradeBook."Type of Input" := GradeInput."Type of Input";
            // GradeBook."Input Sequence" := GradeInput."Input Sequence";
            GradeBook."Percentage Obtained" := pExtExamLine."Percentage Obtained";

            //Calculations

            GradeBook."Earned Points" := Round(((pExtExamLine."Percentage Obtained" / 100) * GradeInput.Points), 0.01, '=');
            GradeBook."Available Points" := GradeInput.Points;
            GradeBook."Earned Points Percentage" := Round((GradeBook."Earned Points" / GradeInput.Points) * 100, 0.01, '=');

            RecRecommendations.Reset();
            RecRecommendations.SetRange("Global Dimension 1 Code", pExtExamLine."Global Dimension 1 Code");
            RecRecommendations.SetRange(Semester, pExtExamLine.Semester);
            RecRecommendations.SetFilter("Min. Percentage", '<=%1', GradeBook."Earned Points Percentage");
            RecRecommendations.SetFilter("Max Percentage", '>=%1', GradeBook."Earned Points Percentage");
            RecRecommendations.SetRange("Academic SAP", StudentMaster."Remaining Academic SAP");        //23Mar2023
            If StudentMaster."Remaining Academic SAP" <> 5 then
                RecRecommendations.SetRange(Repeating, (StudentMaster."Semester Decision" = StudentMaster."Semester Decision"::"Repeat ") OR (StudentMaster."Semester Decision" = StudentMaster."Semester Decision"::Restart));
            IF GradeBook.Semester = 'BSIC' then begin
                StudentSubjectExam.Reset();
                StudentSubjectExam.SetCurrentKey("Exam Sequence");
                StudentSubjectExam.SetRange("Student No.", GradeBook."Student No.");
                StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CBSE);
                StudentSubjectExam.SetAscending("Exam Sequence", false);
                IF StudentSubjectExam.FindFirst() then begin
                    RecRecommendations.SetFilter("CBSE Min", '<=%1', StudentSubjectExam.Total);
                    RecRecommendations.SetFilter("CBSE Max", '>=%1', StudentSubjectExam.Total);
                end;
            end;
            IF RecRecommendations.FindFirst() then begin
                GradeBook."% Range" := RecRecommendations."Range Percentage";
                GradeBook.Recommendation := RecRecommendations.Recommendation;
            end;

            GradeMaster.Reset();
            // GradeMaster.SetRange(Graduation, StudentMaster.Graduation);
            GradeMaster.SetRange("Global Dimension 1 Code", pExtExamLine."Global Dimension 1 Code");
            GradeMaster.SetFilter("Min Percentage", '<=%1', GradeBook."Earned Points Percentage");
            GradeMaster.SetFilter("Max Percentage", '>=%1', GradeBook."Earned Points Percentage");
            GradeMaster.SetRange("Blocked for Grading", false);
            GradeMaster.FindFirst();
            GradeBook."Grade Result" := GradeMaster.Code;
            GradeBook.Grade := GradeMaster.Code;

            // GradeBook.Grade := pExtExamLine."Std. Grade";
            // GradeBook.Indentation := 2;
            GradeBook.Insert(True);

            CopyGradeInput(GradeInput, GradeBook);
            CopyGradeList(GradeMaster, GradeBook);
            CopyRecommendations(GradeBook);

            StudSubExam.Reset();
            StudSubExam.SetCurrentKey("Line No.");
            StudSubExam.Ascending(true);
            StudSubExam.SetRange("Student No.", pExtExamLine."Student No.");
            StudSubExam.SetRange(Course, pExtExamLine.Course);
            StudSubExam.SetRange(Semester, pExtExamLine.Semester);
            StudSubExam.SetRange("Academic Year", pExtExamLine."Academic Year");
            StudSubExam.SetRange(Term, pExtExamLine.Term);
            StudSubExam.SetRange("Subject Code", pExtExamLine."Subject Code");
            StudSubExam.SetRange("Published Document No.", pExtExamLine."Document No.");
            if StudSubExam.FindLast() then begin
                StudSubExam."Grade Book No." := GradeBook."Grade Book No.";
                StudSubExam.Grade := GradeBook.Grade;       // 02-Aug-2022
                StudSubExam.Remakrs := GradeBook.Remarks;   // 03-Aug-2022
                StudSubExam."Obtained Weightage" := pExtExamLine."Obtained Weightage";      // CR Point : T1-T1539 24Jan2023
                StudSubExam."Maximum Weightage" := pExtExamLine."Maximum Weightage";    // CR Point : T1-T1539 24Jan2023
                StudSubExam."Total Weightage" := GetTotalWeightageExternal(pExtExamLine.Semester, pExtExamLine."Global Dimension 1 Code", pExtExamLine."Academic year", pExtExamLine.Term);
                StudSubExam.Modify(true);
            end;

        end;
    end;

    procedure InsertGradeBookLineInt(pIntExamLine: Record "Internal Exam Line-CS"; pGradeBookHdr: Record "Grade Book Header")
    var
        GradeBook: Record "Grade Book";
        GradeBookChk: Record "Grade Book";
        SubMaster: Record "Subject Master-CS";
        StudentMaster: Record "Student Master-CS";
        RecRecommendations: Record "Recommendations";
        StudentSubjectExam: Record "Student Subject Exam";
        GradeMaster: Record "Grade Master-CS";
        GradeInput: Record "Marks Weightage";
        StudSubExam: Record "Student Subject Exam";
        LastEntryNo: Integer;
    begin
        GradeBookChk.Reset();
        GradeBookChk.SetRange("Global Dimension 1 Code", pIntExamLine."Global Dimension 1 Code");
        GradeBookChk.SetRange(Course, pIntExamLine.Course);
        GradeBookChk.SetRange(Semester, pIntExamLine.Semester);
        GradeBookChk.SetRange("Academic Year", pIntExamLine."Academic Year");
        GradeBookChk.SetRange(Term, pIntExamLine.Term);
        GradeBookChk.SetRange("Exam Code", pIntExamLine."Subject Code");
        GradeBookChk.SetRange("Student No.", pIntExamLine."Student No.");
        if not GradeBookChk.FindFirst() then begin

            GradeInput.Reset();
            GradeInput.SetRange("Global Dimension 1 Code", pIntExamLine."Global Dimension 1 Code");
            GradeInput.SetRange("Exam Code", pIntExamLine."Subject Code");
            GradeInput.SetRange("Academic Year", pIntExamLine."Academic year");
            GradeInput.SetRange("Course Code", pIntExamLine.Course);
            GradeInput.SetRange(Semester, pIntExamLine.Semester);
            GradeInput.SetRange(Term, pIntExamLine.Term);
            GradeInput.FindFirst();

            //     repeat
            StudentMaster.Reset();
            StudentMaster.Get(pIntExamLine."Student No.");
            SubMaster.Reset();
            SubMaster.SetRange(Code, pIntExamLine."Subject Code");
            SubMaster.FindFirst();

            GradeBook.Reset();
            GradeBook.SetRange("Student No.", pIntExamLine."Student No.");
            if GradeBook.FindLast() then;
            LastEntryNo := GradeBook."Entry No." + 1;

            GradeBook.Reset();
            GradeBook.Init();
            GradeBook."Entry No." := LastEntryNo;
            GradeBook."Document No." := pIntExamLine."Document No.";
            GradeBook."Exam Line No." := pIntExamLine."Line No.";
            GradeBook."Grade Book No." := pGradeBookHdr."Document No.";

            GradeBook."Student No." := pIntExamLine."Student No.";
            GradeBook."First Name" := StudentMaster."First Name";
            GradeBook."Middle Name" := StudentMaster."Middle Name";
            GradeBook."Last Name" := StudentMaster."Last Name";
            GradeBook."Student Name" := StudentMaster."Student Name";
            GradeBook."Enrollment No." := StudentMaster."Enrollment No.";
            GradeBook."Academic Year" := pIntExamLine."Academic year";
            GradeBook."Admitted Year" := StudentMaster."Admitted Year";
            GradeBook.Course := pIntExamLine.Course;
            GradeBook.Semester := pIntExamLine.Semester;
            GradeBook."Exam Code" := pIntExamLine."Subject Code";
            GradeBook.Level := SubMaster.Level;
            GradeBook."Exam Description" := SubMaster.Description;
            GradeBook."Global Dimension 1 Code" := pIntExamLine."Global Dimension 1 Code";
            GradeBook.Term := pIntExamLine.Term;
            GradeBook."Exam Classification" := pIntExamLine."Exam Classification";
            // GradeBook."Type of Input" := GradeInput."Type of Input";
            // GradeBook."Input Sequence" := GradeInput."Input Sequence";
            GradeBook."Percentage Obtained" := pIntExamLine."Percentage Obtained";

            //Calculations

            GradeBook."Earned Points" := Round(((pIntExamLine."Percentage Obtained" / 100) * GradeInput.Points), 0.01, '=');
            GradeBook."Available Points" := GradeInput.Points;
            GradeBook."Earned Points Percentage" := Round((GradeBook."Earned Points" / GradeInput.Points) * 100, 0.01, '=');

            RecRecommendations.Reset();
            RecRecommendations.SetRange("Global Dimension 1 Code", pIntExamLine."Global Dimension 1 Code");
            RecRecommendations.SetRange(Semester, pIntExamLine.Semester);
            RecRecommendations.SetFilter("Min. Percentage", '<=%1', GradeBook."Earned Points Percentage");
            RecRecommendations.SetFilter("Max Percentage", '>=%1', GradeBook."Earned Points Percentage");
            RecRecommendations.SetRange("Academic SAP", StudentMaster."Remaining Academic SAP");        //23Mar2023
            If StudentMaster."Remaining Academic SAP" <> 5 then
                RecRecommendations.SetRange(Repeating, (StudentMaster."Semester Decision" = StudentMaster."Semester Decision"::"Repeat ") OR (StudentMaster."Semester Decision" = StudentMaster."Semester Decision"::Restart));
            IF GradeBook.Semester = 'BSIC' then begin
                StudentSubjectExam.Reset();
                StudentSubjectExam.SetCurrentKey("Exam Sequence");
                StudentSubjectExam.SetRange("Student No.", GradeBook."Student No.");
                StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CBSE);
                StudentSubjectExam.SetAscending("Exam Sequence", false);
                IF StudentSubjectExam.FindFirst() then begin
                    RecRecommendations.SetFilter("CBSE Min", '<=%1', StudentSubjectExam.Total);
                    RecRecommendations.SetFilter("CBSE Max", '>=%1', StudentSubjectExam.Total);
                end;
            end;
            IF RecRecommendations.FindFirst() then begin
                GradeBook."% Range" := RecRecommendations."Range Percentage";
                GradeBook.Recommendation := RecRecommendations.Recommendation;
                GradeBook.Communications := RecRecommendations.Communications;
            end;

            GradeMaster.Reset();
            // GradeMaster.SetRange(Graduation, StudentMaster.Graduation);
            GradeMaster.SetRange("Global Dimension 1 Code", pIntExamLine."Global Dimension 1 Code");
            GradeMaster.SetFilter("Min Percentage", '<=%1', GradeBook."Earned Points Percentage");
            GradeMaster.SetFilter("Max Percentage", '>=%1', GradeBook."Earned Points Percentage");
            GradeMaster.SetRange("Blocked for Grading", false);
            GradeMaster.FindFirst();
            GradeBook."Grade Result" := GradeMaster.Code;
            GradeBook.Grade := GradeMaster.Code;

            // GradeBook.Grade := pIntExamLine."Std. Grade";
            // GradeBook.Indentation := 2;
            GradeBook.Insert(True);

            CopyGradeInput(GradeInput, GradeBook);
            CopyGradeList(GradeMaster, GradeBook);
            CopyRecommendations(GradeBook);

            StudSubExam.Reset();
            StudSubExam.SetCurrentKey("Line No.");
            StudSubExam.Ascending(true);
            StudSubExam.SetRange("Student No.", pIntExamLine."Student No.");
            StudSubExam.SetRange(Course, pIntExamLine.Course);
            StudSubExam.SetRange(Semester, pIntExamLine.Semester);
            StudSubExam.SetRange("Academic Year", pIntExamLine."Academic Year");
            //StudSubExam.SetRange(Term, pIntExamLine.Term);
            StudSubExam.SetRange("Subject Code", pIntExamLine."Subject Code");
            StudSubExam.SetRange("Published Document No.", pIntExamLine."Document No.");
            if StudSubExam.FindLast() then begin
                StudSubExam."Grade Book No." := GradeBook."Grade Book No.";
                StudSubExam.Grade := GradeBook.Grade;       // 02-Aug-2022
                StudSubExam.Remakrs := GradeBook.Remarks;   // 03-Aug-2022
                StudSubExam."Obtained Weightage" := pIntExamLine."Obtained Weightage";      // CR Point : T1-T1539 24Jan2023
                StudSubExam."Maximum Weightage" := pIntExamLine."Maximum Weightage";    // CR Point : T1-T1539 24Jan2023
                StudSubExam."Total Weightage" := GetTotalWeightageInternal(pIntExamLine.Semester, pIntExamLine."Global Dimension 1 Code", pIntExamLine."Academic Year", pIntExamLine.Term);
                StudSubExam.Modify(true);
            end;

        end;
    end;

    procedure CopyGradeInput(pGradeInput: Record "Marks Weightage"; pGradeBook: Record "Grade Book")
    var
        GradeInput: Record "Marks Weightage";
        GradeInputGB: Record "Marks Weightage Grade Book";
        GradeInputGBChk: Record "Marks Weightage Grade Book";
        LastEntryGradeBook: Integer;
    begin
        GradeInput.Reset();
        GradeInput.SetRange("Global Dimension 1 Code", pGradeInput."Global Dimension 1 Code");
        GradeInput.SetRange("Exam Code", pGradeInput."Exam Code");
        GradeInput.SetRange("Academic Year", pGradeInput."Academic year");
        GradeInput.SetRange("Course Code", pGradeInput."Course Code");
        GradeInput.SetRange(Semester, pGradeInput.Semester);
        GradeInput.SetRange(Term, pGradeInput.Term);
        GradeInput.FindSet();
        repeat
            GradeInputGBChk.Reset();
            GradeInputGBChk.SetRange("Grade Book No.", pGradeBook."Grade Book No.");
            GradeInputGBChk.SetRange("Entry No.", GradeInput."Entry No.");
            GradeInputGBChk.SetRange("Global Dimension 1 Code", GradeInput."Global Dimension 1 Code");
            GradeInputGBChk.SetRange("Exam Code", GradeInput."Exam Code");
            GradeInputGBChk.SetRange("Academic Year", GradeInput."Academic Year");
            GradeInputGBChk.SetRange("Course Code", GradeInput."Course Code");
            GradeInputGBChk.SetRange(Semester, GradeInput.Semester);
            GradeInputGBChk.SetRange(Term, GradeInput.Term);
            if not GradeInputGBChk.FindFirst() then begin
                GradeInputGB.Reset();
                if GradeInputGB.FindLast() then;
                LastEntryGradeBook := GradeInputGB."Entry No. PK" + 1;
                GradeInputGB.Reset();
                GradeInputGB.Init();
                GradeInputGB."Entry No. PK" := LastEntryGradeBook;
                GradeInputGB."Entry No." := GradeInput."Entry No.";
                //GradeInputGB.TransferFields(pGradeInput);
                GradeInputGB."Global Dimension 1 Code" := pGradeInput."Global Dimension 1 Code";
                GradeInputGB."Academic Year" := pGradeInput."Academic Year";
                GradeInputGB."Course Code" := pGradeInput."Course Code";
                GradeInputGB."Admitted Year" := pGradeInput."Admitted Year";
                GradeInputGB.Semester := pGradeInput.Semester;
                GradeInputGB."Exam Code" := pGradeInput."Exam Code";
                If pGradeBook.Level = 2 then
                    GradeInputGB."Consider for Marks Weightage" := true;
                GradeInputGB."Exam Description" := pGradeInput."Exam Description";
                GradeInputGB."Type of Input" := pGradeInput."Type of Input";
                GradeInputGB."Input Sequence" := pGradeInput."Input Sequence";
                GradeInputGB.Points := pGradeInput.Points;
                GradeInputGB."Grade Book No." := pGradeBook."Grade Book No.";
                GradeInputGB.Term := pGradeBook.Term;
                GradeInputGB.Cohort := pGradeInput.Cohort;
                GradeInputGB.Insert();
            end;
        until GradeInput.Next() = 0;
    end;

    procedure CopyGradeList(pGradeMaster: Record "Grade Master-CS"; pGradeBook: Record "Grade Book")
    var
        GradeMaster: Record "Grade Master-CS";
        GradeMasterGB: Record "Grade Master Grade Book";
        GradeMasterGBChk: Record "Grade Master Grade Book";
        LastEntryGradeBook: Integer;
    begin
        GradeMaster.Reset();
        GradeMaster.SetRange("Global Dimension 1 Code", pGradeBook."Global Dimension 1 Code");
        GradeMaster.SetRange("Blocked for Grading", false);
        GradeMaster.FindSet();
        repeat
            GradeMasterGBChk.Reset();
            GradeMasterGBChk.SetRange("Grade Book No.", pGradeBook."Grade Book No.");
            GradeMasterGBChk.SetRange(Code, GradeMaster.Code);
            GradeMasterGBChk.SetRange("Global Dimension 1 Code", pGradeBook."Global Dimension 1 Code");
            if not GradeMasterGBChk.FindFirst() then begin
                GradeMasterGB.Reset();
                // GradeMasterGB.SetCurrentKey("Entry No.");
                // GradeMasterGB.Ascending(true);
                // GradeMasterGB.SetRange("Grade Book No.", pGradeBook."Grade Book No.");
                if GradeMasterGB.FindLast() then;
                LastEntryGradeBook := GradeMasterGB."Entry No." + 1;

                GradeMasterGB.Reset();
                GradeMasterGB.Init();
                GradeMasterGB.TransferFields(GradeMaster);
                GradeMasterGB."Entry No." := LastEntryGradeBook;
                GradeMasterGB."Grade Book No." := pGradeBook."Grade Book No.";
                GradeMasterGB.Insert();

            end;
        until GradeMaster.Next() = 0;
    end;

    procedure CopyRecommendations(pGradeBook: Record "Grade Book")
    var
        RecommMaster: Record Recommendations;
        RecommMasterGB: Record "Recommendations GradeBook";
        RecommMasterGBChk: Record "Recommendations GradeBook";
        LastEntryGradeBook: Integer;
    begin
        RecommMaster.Reset();
        RecommMaster.SetRange("Global Dimension 1 Code", pGradeBook."Global Dimension 1 Code");
        RecommMaster.SetRange(Semester, pGradeBook.Semester);
        if RecommMaster.FindSet() then
            repeat
                RecommMasterGBChk.Reset();
                RecommMasterGBChk.SetRange("Global Dimension 1 Code", RecommMaster."Global Dimension 1 Code");
                RecommMasterGBChk.SetRange(Semester, RecommMaster.Semester);
                RecommMasterGBChk.SetRange("Min Percentage", RecommMaster."Min. Percentage");
                RecommMasterGBChk.SetRange("Grade Book No.", pGradeBook."Grade Book No.");
                RecommMasterGBChk.SetRange("Academic SAP", RecommMaster."Academic SAP");
                RecommMasterGBChk.SetRange(Repeating, RecommMaster.Repeating);
                RecommMasterGBChk.SetRange(CBSE, RecommMaster.CBSE);
                if not RecommMasterGBChk.FindFirst() then begin
                    RecommMasterGB.Reset();
                    // RecommMasterGB.SetCurrentKey("Entry No.");
                    // RecommMasterGB.Ascending(true);
                    // RecommMasterGB.SetRange("Grade Book No.", pGradeBook."Grade Book No.");
                    if RecommMasterGB.FindLast() then;
                    LastEntryGradeBook := RecommMasterGB."Entry No." + 1;

                    RecommMasterGB.Reset();
                    RecommMasterGB.Init();
                    RecommMasterGB.TransferFields(RecommMaster);
                    RecommMasterGB."Min Percentage" := RecommMaster."Min. Percentage";
                    RecommMasterGB."Entry No." := LastEntryGradeBook;
                    RecommMasterGB."Grade Book No." := pGradeBook."Grade Book No.";
                    RecommMasterGB.Insert();

                end;
            until RecommMaster.Next() = 0;
    end;


    procedure GetTotalWeightageExternal(SemesterCode: Code[10]; GlobalDimension1: Code[20]; AcademicYear: Code[20]; PTerm: option FALL,SRPING,SUMMER): Decimal
    var
        CourseSubjectLine: Record "Course Wise Subject Line-CS";
        SemesterMAster: Record "Semester Master-CS";
        TotWt: Decimal;
    Begin
        SemesterMAster.Reset();
        SemesterMAster.SetRange(Code, SemesterCode);
        SemesterMAster.FindFirst();

        CourseSubjectLine.Reset();
        //CourseSubjectLine.SetRange("Course Code", CourseCode);
        CourseSubjectLine.SetRange(Semester, SemesterCode);
        CourseSubjectLine.SETRANGE("Global Dimension 1 Code", GlobalDimension1);
        CourseSubjectLine.SETRANGE(Examination, true);
        CourseSubjectLine.SETFilter("Level Description", '%1', CourseSubjectLine."Level Description"::"External Examination");
        if CourseSubjectLine.FindSet() then begin
            repeat
                ExternalExamLine.Reset();
                ExternalExamLine.SetCurrentKey(ExternalExamLine."Student No.");
                ExternalExamLine.SetRange("Global Dimension 1 Code", GlobalDimension1);
                //ExternalExamLine.SetRange(Course, CourseCode);
                ExternalExamLine.SetRange(Semester, SemesterCode);
                ExternalExamLine.SetRange("Academic year", AcademicYear);
                ExternalExamLine.SetRange(Term, PTerm);
                ExternalExamLine.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                if ExternalExamLine.FindFirst() then begin
                    ExternalExamHdr.Reset();
                    ExternalExamHdr.Get(ExternalExamLine."Document No.");
                    SemesterMAster.TestField("Total Weightage");
                    TotWT += ExternalExamLine."Maximum Weightage";
                end;

            until CourseSubjectLine.Next() = 0;
            TotWT := TotWT / 2;
        End;
        exit(TotWt);
    end;

    Procedure GetTotalWeightageInternal(SemesterCode: Code[10]; GlobalDimension1: Code[20]; AcademicYear: Code[20]; PTerm: option FALL,SRPING,SUMMER): Decimal
    var
        CourseSubjectLine: Record "Course Wise Subject Line-CS";
        SemesterMAster: Record "Semester Master-CS";
        TotWt: Decimal;

    Begin
        SemesterMAster.Reset();
        SemesterMAster.SetRange(Code, SemesterCode);
        SemesterMAster.FindFirst();
        CourseSubjectLine.Reset();
        //CourseSubjectLine.SetRange("Course Code", CourseCode);
        CourseSubjectLine.SetRange(Semester, SemesterCode);
        CourseSubjectLine.SETRANGE("Global Dimension 1 Code", GlobalDimension1);
        CourseSubjectLine.SETRANGE(Examination, true);
        CourseSubjectLine.SETFilter("Level Description", '%1|%2', CourseSubjectLine."Level Description"::"Internal Examination",
        CourseSubjectLine."Level Description"::"Internal Exam Component");
        if CourseSubjectLine.FindSet() then begin
            repeat
                InternalExamHeader.Reset();
                // InternalExamHeader.SetCurrentKey(ExternalExamLine."Student No.");
                InternalExamHeader.SetRange("Global Dimension 1 Code", GlobalDimension1);
                //InternalExamHeader.SetRange("Course Code", CourseCode);
                InternalExamHeader.SetRange(Semester, SemesterCode);
                InternalExamHeader.SetRange("Academic year", AcademicYear);
                InternalExamHeader.SetRange(Term, PTerm);
                InternalExamHeader.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                if InternalExamHeader.FindFirst() then begin

                    SemesterMAster.TestField("Internal Total Weightage");
                    InternalExamLn.Reset();
                    InternalExamLn.SetRange("Document No.", InternalExamHeader."No.");
                    InternalExamLn.FindFirst();
                    if CourseSubjectLine.Level = 2 then begin
                        TotWT += InternalExamLn."Maximum Weightage";

                    end;
                end;

            until CourseSubjectLine.Next() = 0;
            TotWT := TotWT / 2;

        end;
        Exit(TotWt);
    End;

}
report 50266 "Grade Book BSIC"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;


    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {

            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            begin
                if InstCode = '' then
                    Error('Institute Code cannot be blank');
                if CourseCode = '' then
                    Error('Course Code cannot be blank');
                if Sem = '' then
                    Error('Semester Code cannot be blank');
                if AY = '' then
                    Error('Academic Year cannot be blank');

                EduSetup.Reset();
                EduSetup.SetRange("Global Dimension 1 Code", InstCode);
                EduSetup.FindFirst();
                "Student Master-CS".SetFilter(Status, EduSetup."Student Status for Exam");

                MakeExcelDataHeader();
            end;

            /*
            trigger OnAfterGetRecord()
            begin
                // Student OnAfterGetRecord
                TotEarnedPoints := 0;
                Cnt := 0;
                Cnt2 := 0;

                CourseSubjectLine2.Reset();
                CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                CourseSubjectLine2.Ascending(true);
                CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                CourseSubjectLine2.SetRange("Course Code", CourseCode);
                CourseSubjectLine2.SetRange(Semester, Sem);
                CourseSubjectLine2.SetRange(Examination, true);
                CourseSubjectLine2.SetRange(Level, 2);
                CourseSubjectLine2.SetFilter("Level Description", '%1|%2',
                CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                CourseSubjectLine2.FindSet();
                repeat
                    GradeBook.Reset();
                    GradeBook.SetRange("Global Dimension 1 Code", CourseSubjectLine2."Global Dimension 1 Code");
                    GradeBook.SetRange(Course, CourseSubjectLine2."Course Code");
                    GradeBook.SetRange(Semester, CourseSubjectLine2.Semester);
                    GradeBook.SetRange("Academic Year", AY);
                    GradeBook.SetRange(Term, Trm);
                    GradeBook.SetRange("Exam Code", CourseSubjectLine2."Subject Code");
                    GradeBook.SetRange("Student No.", "Student Master-CS"."No.");
                    if GradeBook.FindFirst() then begin
                        if Cnt = 0 then begin
                            ExcBuff.NewRow();
                            // ExcBuff.AddColumn('1', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn("Student Master-CS"."Original Student No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn("Student Master-CS"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn("Student Master-CS"."Enrollment No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn("Student Master-CS"."Student Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn(CourseCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn("Student Master-CS"."Remaining Academic SAP", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn("Student Master-CS".Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            Cnt += 1;
                        end;

                        if GradeBook."Percentage Obtained" > 0 then begin
                            ExcBuff.AddColumn(Format(GradeBook."Percentage Obtained") + '%', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            TotEarnedPoints += GradeBook."Earned Points";
                        end
                        else
                            ExcBuff.AddColumn('NO GRADE', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                    end;

                until CourseSubjectLine2.Next() = 0;
                ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

                CourseSubjectLine2.Reset();
                CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                CourseSubjectLine2.Ascending(true);
                CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                CourseSubjectLine2.SetRange("Course Code", CourseCode);
                CourseSubjectLine2.SetRange(Semester, Sem);
                CourseSubjectLine2.SetRange(Examination, true);
                CourseSubjectLine2.SetRange(Level, 2);
                CourseSubjectLine2.SetFilter("Level Description", '%1|%2',
                CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                CourseSubjectLine2.FindSet();
                begin
                    repeat
                        GradeBook.Reset();
                        GradeBook.SetRange("Global Dimension 1 Code", CourseSubjectLine2."Global Dimension 1 Code");
                        GradeBook.SetRange(Course, CourseSubjectLine2."Course Code");
                        GradeBook.SetRange(Semester, CourseSubjectLine2.Semester);
                        GradeBook.SetRange("Academic Year", AY);
                        GradeBook.SetRange(Term, Trm);
                        GradeBook.SetRange("Exam Code", CourseSubjectLine2."Subject Code");
                        GradeBook.SetRange("Student No.", "Student Master-CS"."No.");
                        if GradeBook.FindFirst() then begin
                            if GradeBook."Percentage Obtained" > 0 then
                                ExcBuff.AddColumn(GradeBook.Grade, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                            else
                                ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        end;
                    until CourseSubjectLine2.Next() = 0;
                    // if Cnt2 = 0 then begin
                    ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                    StudSubGB.Reset();
                    StudSubGB.SetRange("Global Dimension 1 Code", InstCode);
                    StudSubGB.SetRange(Course, CourseCode);
                    StudSubGB.SetRange(Semester, Sem);
                    StudSubGB.SetRange("Academic Year", AY);
                    StudSubGB.SetRange(Term, Trm);
                    StudSubGB.SetRange("Student No.", "Student Master-CS"."No.");
                    if StudSubGB.FindFirst() then begin
                        SemRec.Reset();
                        SemRec.SetRange(Code, Sem);
                        SemRec.FindFirst();
                        ExcBuff.AddColumn(TotEarnedPoints, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Number);
                        ExcBuff.AddColumn(SemRec."Total Weightage" + SemRec."Internal Total Weightage", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Number);
                        ExcBuff.AddColumn(Format(StudSubGB."Percentage Obtained") + '%', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        ExcBuff.AddColumn(StudSubGB.Grade, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        ExcBuff.AddColumn(StudSubGB.Recommendation, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        ExcBuff.AddColumn(Format(StudSubGB."Percentage Obtained") + '%', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        ExcBuff.AddColumn(StudSubGB.Communications, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                    end;
                end;
            end;
            */

            trigger OnAfterGetRecord()
            var
                CrsSemLn: Record "Course Sem. Master-CS";
                CrsSemLn2: Record "Course Sem. Master-CS";
                StudSubGBChk: Record "Student Subject GradeBook";
                StudentMaster_lRec: Record "Student Master-CS";
                SemSeq: Integer;
                AYInt: Integer;
                OldAY: Code[20];
                OldTerm: Option FALL,SPRING,SUMMER;
                Found: Boolean;
                CheckAICASAStudent: Boolean;
            begin
                StudSubGBChk.Reset();
                StudSubGBChk.SetRange("Global Dimension 1 Code", InstCode);
                StudSubGBChk.SetRange(Course, CourseCode);
                StudSubGBChk.SetRange(Semester, Sem);
                StudSubGBChk.SetRange("Academic Year", AY);
                StudSubGBChk.SetRange(Term, Trm);
                StudSubGBChk.SetRange("Student No.", "Student Master-CS"."No.");
                if StudSubGBChk.FindFirst() then begin

                    // Student OnAfterGetRecord
                    TotEarnedPoints := 0;
                    Cnt := 0;
                    Cnt2 := 0;

                    CrsSemLn.Reset();
                    CrsSemLn.SetRange("Course Code", CourseCode);
                    CrsSemLn.SetRange("Semester Code", Sem);
                    CrsSemLn.SetRange("Academic Year", AY);
                    CrsSemLn.SetRange(Term, Trm);
                    CrsSemLn.FindFirst();
                    SemSeq := CrsSemLn."Sequence No" - 1;
                    if SemSeq < 0 then
                        Error('Semester Sequence cannot be less than 0');

                    if (CrsSemLn."Sequence No" MOD 2) = 0 then begin
                        if Trm = Trm::SPRING then begin
                            Evaluate(AYInt, AY);
                            OldAY := Format(AYInt - 1);
                            OldTerm := OldTerm::FALL;
                        end
                        else
                            if Trm = Trm::FALL then begin
                                OldAY := AY;
                                OldTerm := OldTerm::SPRING;
                            end;

                        CrsSemLn2.Reset();
                        CrsSemLn2.SetRange("Course Code", CourseCode);
                        CrsSemLn2.SetRange("Sequence No", SemSeq);
                        CrsSemLn2.SetRange("Academic Year", OldAY);
                        CrsSemLn2.SetRange(Term, OldTerm);
                        CrsSemLn2.FindFirst();

                        CourseSubjectLine2.Reset();
                        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                        CourseSubjectLine2.Ascending(true);
                        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                        CourseSubjectLine2.SetRange("Course Code", CourseCode);
                        CourseSubjectLine2.SetRange(Semester, CrsSemLn2."Semester Code");
                        CourseSubjectLine2.SetRange(Examination, true);
                        CourseSubjectLine2.SetRange(Level, 2);
                        CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                        CourseSubjectLine2.FindSet();
                        repeat
                            GradeBook.Reset();
                            GradeBook.SetRange("Global Dimension 1 Code", CourseSubjectLine2."Global Dimension 1 Code");
                            GradeBook.SetRange(Course, CourseSubjectLine2."Course Code");
                            GradeBook.SetRange(Semester, CourseSubjectLine2.Semester);
                            GradeBook.SetRange("Academic Year", OldAY);
                            GradeBook.SetRange(Term, OldTerm);
                            GradeBook.SetRange("Exam Code", CourseSubjectLine2."Subject Code");
                            GradeBook.SetRange("Student No.", "Student Master-CS"."No.");
                            if GradeBook.FindFirst() then begin
                                if Cnt = 0 then begin
                                    ExcBuff.NewRow();
                                    // ExcBuff.AddColumn('1', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS"."Original Student No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS"."Enrollment No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS"."Student Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn(CourseCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    CheckAICASAStudent := false;
                                    StudentMaster_lRec.Reset();
                                    StudentMaster_lRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                    StudentMaster_lRec.SetRange("Global Dimension 1 Code", '9100');
                                    If StudentMaster_lRec.FindFirst() then begin
                                        CheckAICASAStudent := true;
                                        ExcBuff.AddColumn(StudentMaster_lRec."Course Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                                    end;
                                    IF not CheckAICASAStudent then begin
                                        IF not "Student Master-CS"."Returning Student" then
                                            ExcBuff.AddColumn('New', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                                        Else
                                            ExcBuff.AddColumn('Repeat', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    end;
                                    ExcBuff.AddColumn("Student Master-CS"."Remaining Academic SAP", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS".Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    Cnt += 1;
                                    Found := true;
                                end;

                                if GradeBook."Percentage Obtained" > 0 then begin
                                    ExcBuff.AddColumn(Format(GradeBook."Percentage Obtained") + '%', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    TotEarnedPoints += GradeBook."Earned Points";
                                end
                                else
                                    ExcBuff.AddColumn('NO GRADE', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            end;
                        // else//02Nov
                        //     ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        //vvv ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        until CourseSubjectLine2.Next() = 0;

                        CourseSubjectLine2.Reset();
                        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                        CourseSubjectLine2.Ascending(true);
                        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                        CourseSubjectLine2.SetRange("Course Code", CourseCode);
                        CourseSubjectLine2.SetRange(Semester, Sem);
                        CourseSubjectLine2.SetRange(Examination, true);
                        CourseSubjectLine2.SetRange(Level, 2);
                        CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                        CourseSubjectLine2.FindSet();
                        repeat
                            GradeBook.Reset();
                            GradeBook.SetRange("Global Dimension 1 Code", CourseSubjectLine2."Global Dimension 1 Code");
                            GradeBook.SetRange(Course, CourseSubjectLine2."Course Code");
                            GradeBook.SetRange(Semester, CourseSubjectLine2.Semester);
                            GradeBook.SetRange("Academic Year", AY);
                            GradeBook.SetRange(Term, Trm);
                            GradeBook.SetRange("Exam Code", CourseSubjectLine2."Subject Code");
                            GradeBook.SetRange("Student No.", "Student Master-CS"."No.");
                            if GradeBook.FindFirst() then begin
                                if GradeBook."Percentage Obtained" > 0 then begin
                                    ExcBuff.AddColumn(Format(GradeBook."Percentage Obtained") + '%', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    TotEarnedPoints += GradeBook."Earned Points";
                                end
                                else
                                    ExcBuff.AddColumn('NO GRADE', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            end
                            else//02Nov
                                ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        //vvv ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        until CourseSubjectLine2.Next() = 0;
                    end;


                    CrsSemLn.Reset();
                    CrsSemLn.SetRange("Course Code", CourseCode);
                    CrsSemLn.SetRange("Semester Code", Sem);
                    CrsSemLn.SetRange("Academic Year", AY);
                    CrsSemLn.SetRange(Term, Trm);
                    CrsSemLn.FindFirst();
                    IF Sem <> 'BSIC' then
                        SemSeq := CrsSemLn."Sequence No" + 1
                    Else
                        SemSeq := CrsSemLn."Sequence No";
                    if SemSeq < 0 then
                        Error('Semester Sequence cannot be less than 0');
                    if (CrsSemLn."Sequence No" MOD 2) > 0 then begin
                        if Trm = Trm::SPRING then begin
                            OldAY := AY;
                            OldTerm := OldTerm::FALL;
                        end
                        else
                            if Trm = Trm::FALL then begin
                                Evaluate(AYInt, AY);
                                OldAY := Format(AYInt + 1);
                                OldTerm := OldTerm::SPRING;
                            end;

                        CourseSubjectLine2.Reset();
                        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                        CourseSubjectLine2.Ascending(true);
                        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                        CourseSubjectLine2.SetRange("Course Code", CourseCode);
                        CourseSubjectLine2.SetRange(Semester, Sem);
                        CourseSubjectLine2.SetRange(Examination, true);
                        CourseSubjectLine2.SetRange(Level, 2);
                        CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                        CourseSubjectLine2.FindSet();
                        repeat
                            GradeBook.Reset();
                            GradeBook.SetRange("Global Dimension 1 Code", CourseSubjectLine2."Global Dimension 1 Code");
                            GradeBook.SetRange(Course, CourseSubjectLine2."Course Code");
                            GradeBook.SetRange(Semester, CourseSubjectLine2.Semester);
                            GradeBook.SetRange("Academic Year", AY);
                            GradeBook.SetRange(Term, Trm);
                            GradeBook.SetRange("Exam Code", CourseSubjectLine2."Subject Code");
                            GradeBook.SetRange("Student No.", "Student Master-CS"."No.");
                            if GradeBook.FindFirst() then begin
                                if Cnt = 0 then begin
                                    ExcBuff.NewRow();
                                    // ExcBuff.AddColumn('1', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS"."Original Student No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS"."Enrollment No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS"."Student Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn(CourseCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    CheckAICASAStudent := false;
                                    StudentMaster_lRec.Reset();
                                    StudentMaster_lRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                    StudentMaster_lRec.SetRange("Global Dimension 1 Code", '9100');
                                    If StudentMaster_lRec.FindFirst() then begin
                                        CheckAICASAStudent := true;
                                        ExcBuff.AddColumn(StudentMaster_lRec."Course Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                                    end;
                                    IF not CheckAICASAStudent then begin
                                        IF not "Student Master-CS"."Returning Student" then
                                            ExcBuff.AddColumn('New', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                                        Else
                                            ExcBuff.AddColumn('Repeat', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    end;
                                    ExcBuff.AddColumn("Student Master-CS"."Remaining Academic SAP", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn("Student Master-CS".Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    Cnt += 1;
                                    Found := true;
                                end;

                                if GradeBook."Percentage Obtained" > 0 then begin
                                    ExcBuff.AddColumn(Format(GradeBook."Percentage Obtained") + '%', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                    TotEarnedPoints += GradeBook."Earned Points";
                                end
                                else
                                    ExcBuff.AddColumn('NO GRADE', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            end
                            else//02Nov
                                ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        //vvvExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        until CourseSubjectLine2.Next() = 0;

                        CrsSemLn.Reset();
                        CrsSemLn.SetRange("Course Code", CourseCode);
                        CrsSemLn.SetRange("Sequence No", SemSeq);
                        CrsSemLn.SetRange("Academic Year", OldAY);
                        CrsSemLn.SetRange(Term, OldTerm);
                        CrsSemLn.FindFirst();
                        IF Sem <> 'BSIC' then begin
                            CourseSubjectLine2.Reset();
                            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                            CourseSubjectLine2.Ascending(true);
                            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                            CourseSubjectLine2.SetRange("Course Code", CourseCode);
                            CourseSubjectLine2.SetRange(Semester, CrsSemLn."Semester Code");
                            CourseSubjectLine2.SetRange(Examination, true);
                            CourseSubjectLine2.SetRange(Level, 2);
                            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                            CourseSubjectLine2.FindSet();
                            repeat
                                ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

                            //ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            until CourseSubjectLine2.Next() = 0;
                        end;
                    end;
                    //vik
                    ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

                    //zzz
                    CrsSemLn.Reset();
                    CrsSemLn.SetRange("Course Code", CourseCode);
                    CrsSemLn.SetRange("Semester Code", Sem);
                    CrsSemLn.SetRange("Academic Year", AY);
                    CrsSemLn.SetRange(Term, Trm);
                    CrsSemLn.FindFirst();
                    SemSeq := CrsSemLn."Sequence No" - 1;
                    if SemSeq < 0 then
                        Error('Semester Sequence cannot be less than 0');

                    if (CrsSemLn."Sequence No" MOD 2) = 0 then begin
                        if Trm = Trm::SPRING then begin
                            Evaluate(AYInt, AY);
                            OldAY := Format(AYInt - 1);
                            OldTerm := OldTerm::FALL;
                        end
                        else
                            if Trm = Trm::FALL then begin
                                OldAY := AY;
                                OldTerm := OldTerm::SPRING;
                            end;

                        CrsSemLn2.Reset();
                        CrsSemLn2.SetRange("Course Code", CourseCode);
                        CrsSemLn2.SetRange("Sequence No", SemSeq);
                        CrsSemLn2.SetRange("Academic Year", OldAY);
                        CrsSemLn2.SetRange(Term, OldTerm);
                        CrsSemLn2.FindFirst();

                        CourseSubjectLine2.Reset();
                        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                        CourseSubjectLine2.Ascending(true);
                        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                        CourseSubjectLine2.SetRange("Course Code", CourseCode);
                        CourseSubjectLine2.SetRange(Semester, CrsSemLn2."Semester Code");
                        CourseSubjectLine2.SetRange(Examination, true);
                        CourseSubjectLine2.SetRange(Level, 2);
                        CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                        CourseSubjectLine2.FindSet();
                        repeat
                            GradeBook.Reset();
                            GradeBook.SetRange("Global Dimension 1 Code", CourseSubjectLine2."Global Dimension 1 Code");
                            GradeBook.SetRange(Course, CourseSubjectLine2."Course Code");
                            GradeBook.SetRange(Semester, CourseSubjectLine2.Semester);
                            GradeBook.SetRange("Academic Year", OldAY);
                            GradeBook.SetRange(Term, OldTerm);
                            GradeBook.SetRange("Exam Code", CourseSubjectLine2."Subject Code");
                            GradeBook.SetRange("Student No.", "Student Master-CS"."No.");
                            if GradeBook.FindFirst() then begin
                                IF "Student Master-CS".Status = 'WITH' then
                                    ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)            //19Nov2021
                                else
                                    ExcBuff.AddColumn(GradeBook.Grade, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            end
                            else//02Nov
                                ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        //vvv ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        until CourseSubjectLine2.Next() = 0;

                        CourseSubjectLine2.Reset();
                        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                        CourseSubjectLine2.Ascending(true);
                        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                        CourseSubjectLine2.SetRange("Course Code", CourseCode);
                        CourseSubjectLine2.SetRange(Semester, Sem);
                        CourseSubjectLine2.SetRange(Examination, true);
                        CourseSubjectLine2.SetRange(Level, 2);
                        CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                        CourseSubjectLine2.FindSet();
                        repeat
                            GradeBook.Reset();
                            GradeBook.SetRange("Global Dimension 1 Code", CourseSubjectLine2."Global Dimension 1 Code");
                            GradeBook.SetRange(Course, CourseSubjectLine2."Course Code");
                            GradeBook.SetRange(Semester, CourseSubjectLine2.Semester);
                            GradeBook.SetRange("Academic Year", AY);
                            GradeBook.SetRange(Term, Trm);
                            GradeBook.SetRange("Exam Code", CourseSubjectLine2."Subject Code");
                            GradeBook.SetRange("Student No.", "Student Master-CS"."No.");
                            if GradeBook.FindFirst() then begin
                                If "Student Master-CS".Status = 'WITH' then
                                    ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                                Else
                                    ExcBuff.AddColumn(GradeBook.Grade, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            end
                            else//arv
                                ExcBuff.AddColumn('NO GRADE', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        //vvv ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        until CourseSubjectLine2.Next() = 0;
                    end;


                    CrsSemLn.Reset();
                    CrsSemLn.SetRange("Course Code", CourseCode);
                    CrsSemLn.SetRange("Semester Code", Sem);
                    CrsSemLn.SetRange("Academic Year", AY);
                    CrsSemLn.SetRange(Term, Trm);
                    CrsSemLn.FindFirst();
                    IF Sem <> 'BSIC' then
                        SemSeq := CrsSemLn."Sequence No" + 1
                    Else
                        SemSeq := CrsSemLn."Sequence No";
                    if SemSeq < 0 then
                        Error('Semester Sequence cannot be less than 0');
                    if (CrsSemLn."Sequence No" MOD 2) > 0 then begin
                        if Trm = Trm::SPRING then begin
                            OldAY := AY;
                            OldTerm := OldTerm::FALL;
                        end
                        else
                            if Trm = Trm::FALL then begin
                                Evaluate(AYInt, AY);
                                OldAY := Format(AYInt + 1);
                                OldTerm := OldTerm::SPRING;
                            end;

                        CourseSubjectLine2.Reset();
                        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                        CourseSubjectLine2.Ascending(true);
                        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                        CourseSubjectLine2.SetRange("Course Code", CourseCode);
                        CourseSubjectLine2.SetRange(Semester, Sem);
                        CourseSubjectLine2.SetRange(Examination, true);
                        CourseSubjectLine2.SetRange(Level, 2);
                        CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                        CourseSubjectLine2.FindSet();
                        repeat
                            GradeBook.Reset();
                            GradeBook.SetRange("Global Dimension 1 Code", CourseSubjectLine2."Global Dimension 1 Code");
                            GradeBook.SetRange(Course, CourseSubjectLine2."Course Code");
                            GradeBook.SetRange(Semester, CourseSubjectLine2.Semester);
                            GradeBook.SetRange("Academic Year", AY);
                            GradeBook.SetRange(Term, Trm);
                            GradeBook.SetRange("Exam Code", CourseSubjectLine2."Subject Code");
                            GradeBook.SetRange("Student No.", "Student Master-CS"."No.");
                            if GradeBook.FindFirst() then begin
                                If GradeBook."Percentage Obtained" = 0 then begin
                                    If "Student Master-CS".Status = 'WITH' then          //Condition Add
                                        ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                                    Else
                                        ExcBuff.AddColumn(GradeBook.Grade, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                end Else
                                    ExcBuff.AddColumn(GradeBook.Grade, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            end
                            else//02Nov
                                ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        //vvvExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                        until CourseSubjectLine2.Next() = 0;

                        CrsSemLn.Reset();
                        CrsSemLn.SetRange("Course Code", CourseCode);
                        CrsSemLn.SetRange("Sequence No", SemSeq);
                        CrsSemLn.SetRange("Academic Year", OldAY);
                        CrsSemLn.SetRange(Term, OldTerm);
                        CrsSemLn.FindFirst();
                        IF sem <> 'BSIC' then begin
                            CourseSubjectLine2.Reset();
                            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                            CourseSubjectLine2.Ascending(true);
                            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                            CourseSubjectLine2.SetRange("Course Code", CourseCode);
                            CourseSubjectLine2.SetRange(Semester, CrsSemLn."Semester Code");
                            CourseSubjectLine2.SetRange(Examination, true);
                            CourseSubjectLine2.SetRange(Level, 2);
                            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                            CourseSubjectLine2.FindSet();
                            repeat
                                ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

                            //ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            until CourseSubjectLine2.Next() = 0;
                        end;
                    end;


                    //zzz
                    // if Cnt2 = 0 then begin
                    ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                    StudSubGB.Reset();
                    StudSubGB.SetRange(Course, CourseCode);
                    StudSubGB.SetRange(Semester, Sem);
                    StudSubGB.SetRange("Academic Year", AY);
                    StudSubGB.SetRange(Term, Trm);
                    StudSubGB.SetRange("Student No.", "Student Master-CS"."No.");
                    StudSubGB.SetRange("Global Dimension 1 Code", InstCode);
                    if StudSubGB.FindFirst() then begin
                        SemRec.Reset();
                        SemRec.SetRange(Code, Sem);
                        SemRec.FindFirst();
                        If Found then begin
                            IF "Student Master-CS".Status = 'WITH' then
                                ExcBuff.AddColumn('WITH', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                            Else
                                ExcBuff.AddColumn(TotEarnedPoints, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Number);
                            if (SemRec.Sequence = 1) or (SemRec.Sequence = 3) or (SemRec.Sequence = 5) then
                                If "Student Master-CS".Status = 'WITH' then
                                    ExcBuff.AddColumn('WITH', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                                Else
                                    ExcBuff.AddColumn(SemRec."Total Weightage" + SemRec."Internal Total Weightage", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Number)
                            else begin
                                if Trm = Trm::SPRING then begin
                                    Evaluate(AYInt, AY);
                                    OldAY := Format(AYInt - 1);
                                    OldTerm := OldTerm::FALL;
                                end
                                else
                                    if Trm = Trm::FALL then begin
                                        OldAY := AY;
                                        OldTerm := OldTerm::SPRING;
                                    end;


                                CrsSemLn.Reset();
                                CrsSemLn.SetRange("Course Code", CourseCode);
                                CrsSemLn.SetRange("Semester Code", Sem);
                                CrsSemLn.SetRange("Academic Year", AY);
                                CrsSemLn.SetRange(Term, Trm);
                                CrsSemLn.FindFirst();
                                if (CrsSemLn."Sequence No" MOD 2) = 0 then
                                    SemSeq := CrsSemLn."Sequence No" - 1
                                else
                                    if (CrsSemLn."Sequence No" MOD 2) > 0 then
                                        SemSeq := CrsSemLn."Sequence No" + 1;//new

                                CrsSemLn.Reset();
                                CrsSemLn.SetRange("Course Code", CourseCode);
                                CrsSemLn.SetRange("Sequence No", SemSeq);
                                CrsSemLn.SetRange("Academic Year", OldAY);
                                CrsSemLn.SetRange(Term, OldTerm);
                                CrsSemLn.FindFirst();
                                SemRec2.Reset();
                                SemRec2.SetRange(Code, CrsSemLn."Semester Code");
                                SemRec2.FindFirst();

                                IF "Student Master-CS".Status = 'WITH' then
                                    ExcBuff.AddColumn('WITH', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                                Else
                                    ExcBuff.AddColumn(SemRec."Total Weightage" + SemRec."Internal Total Weightage" + SemRec2."Total Weightage" + SemRec2."Internal Total Weightage", FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Number);
                            end;
                            IF "Student Master-CS".Status = 'WITH' then
                                ExcBuff.AddColumn('WITH', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                            Else
                                ExcBuff.AddColumn(Format(StudSubGB."Percentage Obtained") + '%', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            IF "Student Master-CS".Status = 'WITH' then
                                ExcBuff.AddColumn('WITH', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                            Else
                                ExcBuff.AddColumn(StudSubGB.Grade, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            ExcBuff.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            IF "Student Master-CS".Status = 'WITH' then begin
                                ExcBuff.AddColumn('WITH', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                ExcBuff.AddColumn('WITH', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                ExcBuff.AddColumn('WITH', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            end ELSE begin
                                ExcBuff.AddColumn(StudSubGB.Recommendation, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                ExcBuff.AddColumn(Format(StudSubGB."Percentage Obtained") + '%', FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                                ExcBuff.AddColumn(StudSubGB.Communications, FALSE, '', FALSE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                            end;
                        end;
                    end;
                end;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(InstCode; InstCode)
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,1,1';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

                    }
                    field(CourseCode; CourseCode)
                    {
                        ApplicationArea = all;
                        TableRelation = "Course Master-CS";
                        Caption = 'Course Code';
                    }
                    field(Sem; Sem)
                    {
                        ApplicationArea = all;
                        TableRelation = "Semester Master-CS";
                        Caption = 'Semester';
                    }
                    field(AY; AY)
                    {
                        ApplicationArea = all;
                        TableRelation = "Academic Year Master-CS";
                        Caption = 'Academic Year';
                    }
                    field(Trm; Trm)
                    {
                        ApplicationArea = all;
                        Caption = 'Term';
                    }
                }
            }


        }


    }
    var
        EduSetup: Record "Education Setup-CS";
        CourseSubjectLine2: Record "Course Wise Subject Line-CS";
        GradeBook: Record "Grade Book";
        StudSubGB: Record "Student Subject GradeBook";
        SemRec: Record "Semester Master-CS";
        SemRec2: Record "Semester Master-CS";
        ExtExamHdr: Record "External Exam Header-CS";
        IntExamHdr: Record "Internal Exam Header-CS";

        // ExtExamLn: Record "External Exam Line-CS";
        // IntExamLn: Record "Internal Exam Line-CS";
        Cnt: Integer;
        Cnt2: Integer;
        TotEarnedPoints: Decimal;
        ExcBuff: Record "Excel Buffer" temporary;
        EntryFound: Integer;
        InstCode: Code[20];
        CourseCode: Code[20];
        Sem: Code[20];
        AY: Code[20];
        Trm: Option FALL,SPRING,SUMMER;
        IntSeq: Integer;
        ExtSeq: Integer;
        MarksAbsent: Text;
        TotMarks: Decimal;

    trigger OnPostReport()
    begin
        CreateExcelbook();
    end;

    trigger OnInitReport()
    begin
        EduSetup.Reset();
        EduSetup.SetFilter("Global Dimension 1 Code", '%1', '9000');
        EduSetup.FindFirst();
        InstCode := EduSetup."Global Dimension 1 Code";
        AY := EduSetup."Academic Year";
        Trm := EduSetup."Even/Odd Semester";
    end;

    procedure MakeExcelDataHeader()
    var
        lvSem: Record "Semester Master-CS";
        CrsSub: Record "Course Wise Subject Line-CS";
        CrsSemLn: Record "Course Sem. Master-CS";
        CrsSemLn2: Record "Course Sem. Master-CS";
        AttempCount: Integer;
        Rep: Integer;
        SemSeq: Integer;
        AYInt: Integer;
        OldAY: Code[20];
        OldTerm: Option FALL,SPRING,SUMMER;
    begin
        lvSem.Reset();
        lvSem.SetRange(Code, Sem);
        lvSem.FindFirst();
        ExcBuff.NewRow();
        // ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);


        CrsSemLn.Reset();
        CrsSemLn.SetRange("Course Code", CourseCode);
        CrsSemLn.SetRange("Semester Code", Sem);
        CrsSemLn.SetRange("Academic Year", AY);
        CrsSemLn.SetRange(Term, Trm);
        CrsSemLn.FindFirst();
        SemSeq := CrsSemLn."Sequence No" - 1;
        if SemSeq < 0 then
            Error('Semester Sequence cannot be less than 0');

        if (CrsSemLn."Sequence No" MOD 2) = 0 then begin
            if Trm = Trm::SPRING then begin
                Evaluate(AYInt, AY);
                OldAY := Format(AYInt - 1);
                OldTerm := OldTerm::FALL;
            end
            else
                if Trm = Trm::FALL then begin
                    OldAY := AY;
                    OldTerm := OldTerm::SPRING;
                end;

            CrsSemLn2.Reset();
            CrsSemLn2.SetRange("Course Code", CourseCode);
            CrsSemLn2.SetRange("Sequence No", SemSeq);
            CrsSemLn2.SetRange("Academic Year", OldAY);
            CrsSemLn2.SetRange(Term, OldTerm);
            CrsSemLn2.FindFirst();

            Rep := 0;
            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, CrsSemLn2."Semester Code");
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                if Rep = 0 then
                    ExcBuff.AddColumn('HARD CODED EXAM SCORES ---------------------------------------------------------------------------------->', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                else
                    ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                Rep += 1;
            until CourseSubjectLine2.Next() = 0;

            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, Sem);
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until CourseSubjectLine2.Next() = 0;
        end;


        CrsSemLn.Reset();
        CrsSemLn.SetRange("Course Code", CourseCode);
        CrsSemLn.SetRange("Semester Code", Sem);
        CrsSemLn.SetRange("Academic Year", AY);
        CrsSemLn.SetRange(Term, Trm);
        CrsSemLn.FindFirst();
        IF Sem <> 'BSIC' then
            SemSeq := CrsSemLn."Sequence No" + 1
        Else
            SemSeq := CrsSemLn."Sequence No";
        if SemSeq < 0 then
            Error('Semester Sequence cannot be less than 0');
        if (CrsSemLn."Sequence No" MOD 2) > 0 then begin
            if Trm = Trm::SPRING then begin
                OldAY := AY;
                OldTerm := OldTerm::FALL;
            end
            else
                if Trm = Trm::FALL then begin
                    Evaluate(AYInt, AY);
                    OldAY := Format(AYInt + 1);
                    OldTerm := OldTerm::SPRING;
                end;

            Rep := 0;
            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, Sem);
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                if Rep = 0 then
                    ExcBuff.AddColumn('HARD CODED EXAM SCORES ---------------------------------------------------------------------------------->', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                else
                    ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                Rep += 1;
            until CourseSubjectLine2.Next() = 0;

            CrsSemLn.Reset();
            CrsSemLn.SetRange("Course Code", CourseCode);
            CrsSemLn.SetRange("Sequence No", SemSeq);
            CrsSemLn.SetRange("Academic Year", OldAY);
            CrsSemLn.SetRange(Term, OldTerm);
            CrsSemLn.FindFirst();
            IF Sem <> 'BSIC' then begin
                CourseSubjectLine2.Reset();
                CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                CourseSubjectLine2.Ascending(true);
                CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                CourseSubjectLine2.SetRange("Course Code", CourseCode);
                CourseSubjectLine2.SetRange(Semester, CrsSemLn."Semester Code");
                CourseSubjectLine2.SetRange(Examination, true);
                CourseSubjectLine2.SetRange(Level, 2);
                CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                CourseSubjectLine2.FindSet();
                repeat
                    ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                until CourseSubjectLine2.Next() = 0;
            end;
        end;

        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

        CrsSemLn.Reset();
        CrsSemLn.SetRange("Course Code", CourseCode);
        CrsSemLn.SetRange("Semester Code", Sem);
        CrsSemLn.SetRange("Academic Year", AY);
        CrsSemLn.SetRange(Term, Trm);
        CrsSemLn.FindFirst();
        SemSeq := CrsSemLn."Sequence No" - 1;
        if SemSeq < 0 then
            Error('Semester Sequence cannot be less than 0');

        if (CrsSemLn."Sequence No" MOD 2) = 0 then begin
            if Trm = Trm::SPRING then begin
                Evaluate(AYInt, AY);
                OldAY := Format(AYInt - 1);
                OldTerm := OldTerm::FALL;
            end
            else
                if Trm = Trm::FALL then begin
                    OldAY := AY;
                    OldTerm := OldTerm::SPRING;
                end;

            CrsSemLn2.Reset();
            CrsSemLn2.SetRange("Course Code", CourseCode);
            CrsSemLn2.SetRange("Sequence No", SemSeq);
            CrsSemLn2.SetRange("Academic Year", OldAY);
            CrsSemLn2.SetRange(Term, OldTerm);
            CrsSemLn2.FindFirst();

            Rep := 0;
            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, CrsSemLn2."Semester Code");
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                if Rep = 0 then
                    ExcBuff.AddColumn('FORMULAIC EXAM GRADES ------------------------------------------------------------------------------------>', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                else
                    ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                Rep += 1;
            until CourseSubjectLine2.Next() = 0;

            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, Sem);
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until CourseSubjectLine2.Next() = 0;
        end;


        CrsSemLn.Reset();
        CrsSemLn.SetRange("Course Code", CourseCode);
        CrsSemLn.SetRange("Semester Code", Sem);
        CrsSemLn.SetRange("Academic Year", AY);
        CrsSemLn.SetRange(Term, Trm);
        CrsSemLn.FindFirst();
        IF Sem <> 'BSIC' then
            SemSeq := CrsSemLn."Sequence No" + 1
        Else
            SemSeq := CrsSemLn."Sequence No";
        if SemSeq < 0 then
            Error('Semester Sequence cannot be less than 0');
        if (CrsSemLn."Sequence No" MOD 2) > 0 then begin
            if Trm = Trm::SPRING then begin
                OldAY := AY;
                OldTerm := OldTerm::FALL;
            end
            else
                if Trm = Trm::FALL then begin
                    Evaluate(AYInt, AY);
                    OldAY := Format(AYInt + 1);
                    OldTerm := OldTerm::SPRING;
                end;

            Rep := 0;
            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, Sem);
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                if Rep = 0 then
                    ExcBuff.AddColumn('FORMULAIC EXAM GRADES ------------------------------------------------------------------------------------>', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text)
                else
                    ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                Rep += 1;
            until CourseSubjectLine2.Next() = 0;

            CrsSemLn.Reset();
            CrsSemLn.SetRange("Course Code", CourseCode);
            CrsSemLn.SetRange("Sequence No", SemSeq);
            CrsSemLn.SetRange("Academic Year", OldAY);
            CrsSemLn.SetRange(Term, OldTerm);
            CrsSemLn.FindFirst();
            IF Sem <> 'BSIC' then begin
                CourseSubjectLine2.Reset();
                CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                CourseSubjectLine2.Ascending(true);
                CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                CourseSubjectLine2.SetRange("Course Code", CourseCode);
                CourseSubjectLine2.SetRange(Semester, CrsSemLn."Semester Code");
                CourseSubjectLine2.SetRange(Examination, true);
                CourseSubjectLine2.SetRange(Level, 2);
                CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                CourseSubjectLine2.FindSet();
                repeat
                    ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                until CourseSubjectLine2.Next() = 0;
            end;
        end;


        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

        ExcBuff.AddColumn('FORUMULAIC FINAL RESULTS ---------------------------------------------------->', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

        ExcBuff.NewRow();

        ExcBuff.NewRow();
        // ExcBuff.AddColumn('x', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Student ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('SLcM No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Enrollment No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Student Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Source', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Attempts + ' + Format(5 - lvSem.Sequence), FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        //arv
        CrsSemLn.Reset();
        CrsSemLn.SetRange("Course Code", CourseCode);
        CrsSemLn.SetRange("Semester Code", Sem);
        CrsSemLn.SetRange("Academic Year", AY);
        CrsSemLn.SetRange(Term, Trm);
        CrsSemLn.FindFirst();
        SemSeq := CrsSemLn."Sequence No" - 1;
        if SemSeq < 0 then
            Error('Semester Sequence cannot be less than 0');

        if (CrsSemLn."Sequence No" MOD 2) = 0 then begin
            if Trm = Trm::SPRING then begin
                Evaluate(AYInt, AY);
                OldAY := Format(AYInt - 1);
                OldTerm := OldTerm::FALL;
            end
            else
                if Trm = Trm::FALL then begin
                    OldAY := AY;
                    OldTerm := OldTerm::SPRING;
                end;

            CrsSemLn2.Reset();
            CrsSemLn2.SetRange("Course Code", CourseCode);
            CrsSemLn2.SetRange("Sequence No", SemSeq);
            CrsSemLn2.SetRange("Academic Year", OldAY);
            CrsSemLn2.SetRange(Term, OldTerm);
            CrsSemLn2.FindFirst();

            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, CrsSemLn2."Semester Code");
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until CourseSubjectLine2.Next() = 0;

            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, Sem);
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until CourseSubjectLine2.Next() = 0;
        end;


        CrsSemLn.Reset();
        CrsSemLn.SetRange("Course Code", CourseCode);
        CrsSemLn.SetRange("Semester Code", Sem);
        CrsSemLn.SetRange("Academic Year", AY);
        CrsSemLn.SetRange(Term, Trm);
        CrsSemLn.FindFirst();
        IF Sem <> 'BSIC' then
            SemSeq := CrsSemLn."Sequence No" + 1
        Else
            SemSeq := CrsSemLn."Sequence No";
        if SemSeq < 0 then
            Error('Semester Sequence cannot be less than 0');
        if (CrsSemLn."Sequence No" MOD 2) > 0 then begin
            if Trm = Trm::SPRING then begin
                OldAY := AY;
                OldTerm := OldTerm::FALL;
            end
            else
                if Trm = Trm::FALL then begin
                    Evaluate(AYInt, AY);
                    OldAY := Format(AYInt + 1);
                    OldTerm := OldTerm::SPRING;
                end;

            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, Sem);
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until CourseSubjectLine2.Next() = 0;
            IF Sem <> 'BSIC' then begin
                CrsSemLn.Reset();
                CrsSemLn.SetRange("Course Code", CourseCode);
                CrsSemLn.SetRange("Sequence No", SemSeq);
                CrsSemLn.SetRange("Academic Year", OldAY);
                CrsSemLn.SetRange(Term, OldTerm);
                CrsSemLn.FindFirst();

                CourseSubjectLine2.Reset();
                CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                CourseSubjectLine2.Ascending(true);
                CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                CourseSubjectLine2.SetRange("Course Code", CourseCode);
                CourseSubjectLine2.SetRange(Semester, CrsSemLn."Semester Code");
                CourseSubjectLine2.SetRange(Examination, true);
                CourseSubjectLine2.SetRange(Level, 2);
                CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                CourseSubjectLine2.FindSet();
                repeat
                    ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                until CourseSubjectLine2.Next() = 0;
            end;
        end;
        //arv

        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        // CourseSubjectLine2.FindSet();
        // repeat
        //     ExcBuff.AddColumn(CourseSubjectLine2.Description + ' Grade', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        // until CourseSubjectLine2.Next() = 0;
        CrsSemLn.Reset();
        CrsSemLn.SetRange("Course Code", CourseCode);
        CrsSemLn.SetRange("Semester Code", Sem);
        CrsSemLn.SetRange("Academic Year", AY);
        CrsSemLn.SetRange(Term, Trm);
        CrsSemLn.FindFirst();
        SemSeq := CrsSemLn."Sequence No" - 1;
        if SemSeq < 0 then
            Error('Semester Sequence cannot be less than 0');

        if (CrsSemLn."Sequence No" MOD 2) = 0 then begin
            if Trm = Trm::SPRING then begin
                Evaluate(AYInt, AY);
                OldAY := Format(AYInt - 1);
                OldTerm := OldTerm::FALL;
            end
            else
                if Trm = Trm::FALL then begin
                    OldAY := AY;
                    OldTerm := OldTerm::SPRING;
                end;

            CrsSemLn2.Reset();
            CrsSemLn2.SetRange("Course Code", CourseCode);
            CrsSemLn2.SetRange("Sequence No", SemSeq);
            CrsSemLn2.SetRange("Academic Year", OldAY);
            CrsSemLn2.SetRange(Term, OldTerm);
            CrsSemLn2.FindFirst();

            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, CrsSemLn2."Semester Code");
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                ExcBuff.AddColumn(CourseSubjectLine2.Description + ' Grade', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until CourseSubjectLine2.Next() = 0;

            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, Sem);
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                ExcBuff.AddColumn(CourseSubjectLine2.Description + ' Grade', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until CourseSubjectLine2.Next() = 0;
        end;


        CrsSemLn.Reset();
        CrsSemLn.SetRange("Course Code", CourseCode);
        CrsSemLn.SetRange("Semester Code", Sem);
        CrsSemLn.SetRange("Academic Year", AY);
        CrsSemLn.SetRange(Term, Trm);
        CrsSemLn.FindFirst();
        IF Sem <> 'BSIC' then
            SemSeq := CrsSemLn."Sequence No" + 1
        Else
            SemSeq := CrsSemLn."Sequence No";
        if SemSeq < 0 then
            Error('Semester Sequence cannot be less than 0');
        if (CrsSemLn."Sequence No" MOD 2) > 0 then begin
            if Trm = Trm::SPRING then begin
                OldAY := AY;
                OldTerm := OldTerm::FALL;
            end
            else
                if Trm = Trm::FALL then begin
                    Evaluate(AYInt, AY);
                    OldAY := Format(AYInt + 1);
                    OldTerm := OldTerm::SPRING;
                end;

            CourseSubjectLine2.Reset();
            CourseSubjectLine2.SetCurrentKey("Exam Sequence");
            CourseSubjectLine2.Ascending(true);
            CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
            CourseSubjectLine2.SetRange("Course Code", CourseCode);
            CourseSubjectLine2.SetRange(Semester, Sem);
            CourseSubjectLine2.SetRange(Examination, true);
            CourseSubjectLine2.SetRange(Level, 2);
            CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
            CourseSubjectLine2.FindSet();
            repeat
                ExcBuff.AddColumn(CourseSubjectLine2.Description + ' Grade', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until CourseSubjectLine2.Next() = 0;
            IF Sem <> 'BSIC' then begin
                CrsSemLn.Reset();
                CrsSemLn.SetRange("Course Code", CourseCode);
                CrsSemLn.SetRange("Sequence No", SemSeq);
                CrsSemLn.SetRange("Academic Year", OldAY);
                CrsSemLn.SetRange(Term, OldTerm);
                CrsSemLn.FindFirst();

                CourseSubjectLine2.Reset();
                CourseSubjectLine2.SetCurrentKey("Exam Sequence");
                CourseSubjectLine2.Ascending(true);
                CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
                CourseSubjectLine2.SetRange("Course Code", CourseCode);
                CourseSubjectLine2.SetRange(Semester, CrsSemLn."Semester Code");
                CourseSubjectLine2.SetRange(Examination, true);
                CourseSubjectLine2.SetRange(Level, 2);
                CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"External Examination");
                CourseSubjectLine2.FindSet();
                repeat
                    ExcBuff.AddColumn(CourseSubjectLine2.Description + ' Grade', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                until CourseSubjectLine2.Next() = 0;
            end;
        end;


        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

        ExcBuff.AddColumn('Earned Points', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Available Points', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('%', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Current Result', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Recommendation/Decision', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('% email', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Communication', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        ExcBuff.CreateNewBook('Grade Book');
        ExcBuff.WriteSheet('Grade Book', COMPANYNAME, USERID);
        ExcBuff.CloseBook();
        ExcBuff.SetFriendlyFilename('Grade Book');
        ExcBuff.OpenExcel();
    end;

    procedure AddParam(pInstCode: Code[20]; pCourseCode: Code[20]; pSem: Code[20]; pAY: Code[20]; pTrm: Option FALL,SPRING,SUMMER)
    begin
        InstCode := pInstCode;
        CourseCode := pCourseCode;
        Sem := pSem;
        AY := pAY;
        Trm := pTrm;
    end;



}
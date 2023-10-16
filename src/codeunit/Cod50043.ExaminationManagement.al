codeunit 50043 "Examination Management"
{
    /// <summary> 
    /// Description for ExternalEarnedPoints.
    /// </summary>
    /// <param name="StudentNo">Parameter of type Code[20].</param>
    /// <param name="SemesterType">Parameter of type Option "FALL","SPRING".</param>
    /// <param name="ExamClassification">Parameter of type Code[20].</param>
    procedure ExternalEarnedPoints(StudentNo: Code[20]; SemesterType: Option "FALL","SPRING"; ExamClassification: Code[20])
    var
        StudentMaster: Record "Student Master-CS";
        ExternalExamLine: Record "External Exam Line-CS";
        GradeInput: Record "Grade Input";
        GradeBook: Record "Grade Book";
        RecRecommendations: Record "Recommendations";
        StudentSubjectExam: Record "Student Subject Exam";
        GradeMaster: Record "Grade Master-CS";
        ExternalExamHeader: Record "External Exam Header-CS";
        // ExtExamPg: Page "External Student Hdr-CS";
        LastEntryNo: Integer;

    begin
        StudentMaster.Get(StudentNo);
        GradeBook.Reset();
        GradeBook.SetRange("Student No.", StudentMaster."No.");
        GradeBook.SetRange("Academic Year", StudentMaster."Academic Year");
        GradeBook.SetRange(Semester, StudentMaster.Semester);
        GradeBook.SetRange(Term, SemesterType);
        GradeBook.SetRange("Exam Classification", ExamClassification);
        if GradeBook.FindSet() then
            GradeBook.DeleteAll();

        GradeBook.Reset();
        GradeBook.SetRange("Student No.", StudentMaster."No.");
        if GradeBook.FindLast() then
            LastEntryNo := GradeBook."Entry No.";

        ExternalExamLine.Reset();
        ExternalExamLine.SetCurrentKey("Student No.", "Academic year");
        ExternalExamLine.SetRange("Student No.", StudentMaster."No.");
        ExternalExamLine.SetRange("Academic year", StudentMaster."Academic Year");
        ExternalExamLine.SetRange(Semester, StudentMaster.Semester);
        ExternalExamLine.SetRange(Term, SemesterType);
        ExternalExamLine.SetRange("Exam Classification", ExamClassification);
        if ExternalExamLine.FindSet() then
            repeat
                //Main Exam Line >>

                LastEntryNo += 1;
                GradeBook.Init();
                GradeBook."Entry No." := LastEntryNo;
                GradeBook."Student No." := StudentMaster."No.";
                GradeBook."First Name" := StudentMaster."First Name";
                GradeBook."Middle Name" := StudentMaster."Middle Name";
                GradeBook."Last Name" := StudentMaster."Last Name";
                GradeBook."Student Name" := StudentMaster."Student Name";
                GradeBook."Enrollment No." := StudentMaster."Enrollment No.";
                GradeBook."Academic Year" := StudentMaster."Academic Year";
                GradeBook."Admitted Year" := StudentMaster."Admitted Year";
                GradeBook.Semester := StudentMaster.Semester;
                GradeBook."Exam Code" := ExternalExamLine."Subject Code";
                ExternalExamHeader.Reset();
                ExternalExamHeader.SetRange("No.", ExternalExamLine."Document No.");
                ExternalExamHeader.SetRange("Subject Code", ExternalExamLine."Subject Code");
                IF ExternalExamHeader.FindLast() Then
                    GradeBook."Exam Description" := ExternalExamHeader."Subject Description";
                GradeBook."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                GradeBook.Term := ExternalExamLine.Term;
                GradeBook."Exam Classification" := ExternalExamLine."Exam Classification";
                GradeBook."Type of Input" := GradeBook."Type of Input"::" ";
                GradeBook."Percentage Obtained" := ExternalExamLine."Percentage Obtained";
                GradeBook.Grade := ExternalExamLine."Std. Grade";
                GradeBook.Indentation := 1;
                GradeBook.Insert();
                //Main Exam Line <<

                GradeInput.Reset();
                GradeInput.SetRange("Exam Code", ExternalExamLine."Subject Code");
                GradeInput.SetRange("Academic Year", StudentMaster."Academic Year");
                GradeInput.SetRange("Admitted Year", StudentMaster."Admitted Year");
                GradeInput.SetRange(Semester, StudentMaster.Semester);
                if GradeInput.FindSet() then
                    repeat
                        LastEntryNo += 1;
                        GradeBook.Init();
                        GradeBook."Entry No." := LastEntryNo;
                        GradeBook."Student No." := StudentMaster."No.";
                        GradeBook."First Name" := StudentMaster."First Name";
                        GradeBook."Middle Name" := StudentMaster."Middle Name";
                        GradeBook."Last Name" := StudentMaster."Last Name";
                        GradeBook."Student Name" := StudentMaster."Student Name";
                        GradeBook."Enrollment No." := StudentMaster."Enrollment No.";
                        GradeBook."Academic Year" := StudentMaster."Academic Year";
                        GradeBook."Admitted Year" := StudentMaster."Admitted Year";
                        GradeBook.Semester := StudentMaster.Semester;
                        GradeBook."Exam Code" := GradeInput."Exam Code";
                        GradeBook."Exam Description" := GradeInput."Exam Description";
                        GradeBook."Global Dimension 1 Code" := GradeInput."Global Dimension 1 Code";
                        GradeBook.Term := ExternalExamLine.Term;
                        GradeBook."Exam Classification" := ExternalExamLine."Exam Classification";
                        GradeBook."Type of Input" := GradeInput."Type of Input";
                        GradeBook."Input Sequence" := GradeInput."Input Sequence";
                        GradeBook."Percentage Obtained" := ExternalExamLine."Percentage Obtained";
                        GradeBook.Grade := ExternalExamLine."Std. Grade";
                        GradeBook."Earned Points" := Round(((ExternalExamLine."Percentage Obtained" / 100) * GradeInput.Points), 0.01, '=');
                        GradeBook."Available Points" := GradeInput.Points;
                        GradeBook."Earned Points Percentage" := Round((GradeBook."Earned Points" / GradeInput.Points) * 100, 0.01, '=');

                        RecRecommendations.Reset();
                        RecRecommendations.SetRange("Global Dimension 1 Code", GradeInput."Global Dimension 1 Code");
                        RecRecommendations.SetRange(Semester, StudentMaster.Semester);
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
                        GradeMaster.SetRange(Graduation, StudentMaster.Graduation);
                        GradeMaster.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                        GradeMaster.SetFilter("Min Percentage", '<=%1', GradeBook."Earned Points Percentage");
                        GradeMaster.SetFilter("Max Percentage", '>=%1', GradeBook."Earned Points Percentage");
                        If GradeMaster.FindFirst() Then
                            GradeBook."Grade Result" := GradeMaster.Code;
                        GradeBook.Indentation := 2;
                        GradeBook.Insert();
                    until GradeInput.Next() = 0;

            // ExtExamPg.PublishMarksIntoStudExam(ExternalExamLine);
            until ExternalExamLine.Next() = 0;
    End;

    /// <summary> 
    /// Description for InternalEarnedPoints.
    /// </summary>
    /// <param name="StudentNo">Parameter of type Code[20].</param>
    /// <param name="SubjectCode">Parameter of type code[1000].</param>
    /// <param name="SemesterType">Parameter of type Option "FALL","SPRING".</param>
    /// <param name="ExamClassification">Parameter of type Code[20].</param>
    procedure InternalEarnedPoints(StudentNo: Code[20]; SubjectCode: code[1000]; SemesterType: Option "FALL","SPRING"; ExamClassification: Code[20])
    var
        StudentMaster: Record "Student Master-CS";
        InternalExamLine: Record "Internal Exam Line-CS";
        GradeInput: Record "Grade Input";
        GradeBook: Record "Grade Book";
        RecRecommendations: Record "Recommendations";
        StudentSubjectExam: Record "Student Subject Exam";
        GradeMaster: Record "Grade Master-CS";
        InternalExamHeader: Record "Internal Exam Header-CS";
        LastEntryNo: Integer;

    begin
        StudentMaster.Get(StudentNo);
        GradeBook.Reset();
        GradeBook.SetRange("Student No.", StudentMaster."No.");
        if GradeBook.FindLast() then
            LastEntryNo := GradeBook."Entry No.";

        InternalExamLine.Reset();
        InternalExamLine.SetCurrentKey("Student No.", "Academic year");
        InternalExamLine.SetRange("Student No.", StudentMaster."No.");
        InternalExamLine.SetRange("Academic year", StudentMaster."Academic Year");
        InternalExamLine.SetRange(Semester, StudentMaster.Semester);
        InternalExamLine.SetRange("Subject Code", SubjectCode);
        InternalExamLine.SetRange(Term, SemesterType);
        InternalExamLine.SetRange("Exam Classification", ExamClassification);
        if InternalExamLine.FindSet() then
            repeat
                //Main Exam Line >>
                LastEntryNo += 1;
                GradeBook.Init();
                GradeBook."Entry No." := LastEntryNo;
                GradeBook."Student No." := StudentMaster."No.";
                GradeBook."First Name" := StudentMaster."First Name";
                GradeBook."Middle Name" := StudentMaster."Middle Name";
                GradeBook."Last Name" := StudentMaster."Last Name";
                GradeBook."Student Name" := StudentMaster."Student Name";
                GradeBook."Enrollment No." := StudentMaster."Enrollment No.";
                GradeBook."Academic Year" := StudentMaster."Academic Year";
                GradeBook."Admitted Year" := StudentMaster."Admitted Year";
                GradeBook.Semester := StudentMaster.Semester;
                GradeBook."Exam Code" := InternalExamLine."Subject Code";
                InternalExamHeader.Reset();
                InternalExamHeader.SetRange("No.", InternalExamLine."Document No.");
                InternalExamHeader.SetRange("Subject Code", InternalExamLine."Subject Code");
                IF InternalExamHeader.FindLast() Then
                    GradeBook."Exam Description" := InternalExamHeader."Subject Description";
                GradeBook."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                GradeBook.Term := InternalExamLine.Term;
                GradeBook."Exam Classification" := InternalExamLine."Exam Classification";
                GradeBook."Type of Input" := GradeBook."Type of Input"::" ";
                GradeBook."Percentage Obtained" := InternalExamLine."Percentage Obtained";
                GradeBook.Grade := InternalExamLine.Grade;
                GradeBook.Indentation := 1;
                GradeBook.Insert();
                //Main Exam Line <<

                GradeInput.Reset();
                GradeInput.SetRange("Exam Code", InternalExamLine."Subject Code");
                GradeInput.SetRange("Academic Year", StudentMaster."Academic Year");
                GradeInput.SetRange("Admitted Year", StudentMaster."Admitted Year");
                GradeInput.SetRange(Semester, StudentMaster.Semester);
                if GradeInput.FindSet() then
                    repeat
                        LastEntryNo += 1;
                        GradeBook.Init();
                        GradeBook."Entry No." := LastEntryNo;
                        GradeBook."Student No." := StudentMaster."No.";
                        GradeBook."First Name" := StudentMaster."First Name";
                        GradeBook."Middle Name" := StudentMaster."Middle Name";
                        GradeBook."Last Name" := StudentMaster."Last Name";
                        GradeBook."Student Name" := StudentMaster."Student Name";
                        GradeBook."Enrollment No." := StudentMaster."Enrollment No.";
                        GradeBook."Academic Year" := StudentMaster."Academic Year";
                        GradeBook."Admitted Year" := StudentMaster."Admitted Year";
                        GradeBook.Semester := StudentMaster.Semester;
                        GradeBook."Exam Code" := GradeInput."Exam Code";
                        GradeBook."Exam Description" := GradeInput."Exam Description";
                        GradeBook."Global Dimension 1 Code" := GradeInput."Global Dimension 1 Code";
                        GradeBook.Term := InternalExamLine.Term;
                        GradeBook."Exam Classification" := InternalExamLine."Exam Classification";
                        GradeBook."Type of Input" := GradeInput."Type of Input";
                        GradeBook."Input Sequence" := GradeInput."Input Sequence";
                        GradeBook."Percentage Obtained" := InternalExamLine."Percentage Obtained";
                        GradeBook.Grade := InternalExamLine.Grade;

                        GradeBook."Earned Points" := Round(((GradeBook."Percentage Obtained" / 100) * GradeInput.Points), 0.01, '=');
                        GradeBook."Available Points" := GradeInput.Points;
                        GradeBook."Earned Points Percentage" := Round((GradeBook."Earned Points" / GradeInput.Points) * 100, 0.01, '=');

                        RecRecommendations.Reset();
                        RecRecommendations.SetRange("Global Dimension 1 Code", GradeInput."Global Dimension 1 Code");
                        RecRecommendations.SetRange(Semester, StudentMaster.Semester);
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
                        GradeMaster.SetRange(Graduation, StudentMaster.Graduation);
                        GradeMaster.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                        GradeMaster.SetFilter("Min Percentage", '<=%1', GradeBook."Earned Points Percentage");
                        GradeMaster.SetFilter("Max Percentage", '>=%1', GradeBook."Earned Points Percentage");
                        If GradeMaster.FindFirst() Then
                            GradeBook."Grade Result" := GradeMaster.Code;
                        GradeBook.Indentation := 2;
                        GradeBook.Insert();
                    until GradeInput.Next() = 0;
            until InternalExamLine.Next() = 0;
    end;

    /// <summary> 
    /// Description for EndTotalAndBest.
    /// </summary>
    /// <param name="StudentNo">Parameter of type Code[20].</param>
    /// <param name="SemesterType">Parameter of type Option "FALL","SPRING".</param>
    /// <param name="ExamClassification">Parameter of type Code[20].</param>
    procedure EndTotalAndBest(StudentNo: Code[20]; SemesterType: Option "FALL","SPRING"; ExamClassification: Code[20])
    var
        StudentMaster: Record "Student Master-CS";
        GradeInput: Record "Grade Input";
        GradeBook: Record "Grade Book";
        GradeBook_1: Record "Grade Book";
        GradeBook_2: Record "Grade Book";
        GradeBookTemp: Record "Grade Book" temporary;
        RecRecommendations: Record "Recommendations";
        StudentSubjectExam: Record "Student Subject Exam";
        GradeMaster: Record "Grade Master-CS";
        RecSemester: Record "Semester Master-CS";
        ExaminationSetup: Record "Setup Examination -CS";
        MainStudentSubject: Record "Main Student Subject-CS";
        LastEntryNo: Integer;
        AvblPoints: Decimal;
        TotalEarnedPoint: Decimal;

    begin
        Clear(GradeBookTemp);
        StudentMaster.Get(StudentNo);

        // Temp Start >>
        GradeBook.Reset();
        GradeBook.SetRange("Student No.", StudentMaster."No.");
        GradeBook.SetRange("Academic year", StudentMaster."Academic Year");
        GradeBook.SetRange(Semester, StudentMaster.Semester);
        GradeBook.SetRange(Term, SemesterType);
        GradeBook.SetRange("Exam Classification", ExamClassification);
        GradeBook.SetRange("Type of Input", GradeBook."Type of Input"::" ");
        If GradeBook.FindFirst() then begin
            GradeInput.Reset();
            GradeInput.SetRange("Exam Code", GradeBook."Exam Code");
            GradeInput.SetRange("Academic Year", StudentMaster."Academic Year");
            GradeInput.SetRange("Admitted Year", StudentMaster."Admitted Year");
            GradeInput.SetRange(Semester, StudentMaster.Semester);
            if GradeInput.FindSet() then
                repeat
                    GradeBookTemp.Reset();
                    GradeBookTemp.SetRange("Student No.", StudentMaster."No.");
                    GradeBookTemp.SetRange("Academic year", StudentMaster."Academic Year");
                    GradeBookTemp.SetRange(Semester, StudentMaster.Semester);
                    GradeBookTemp.SetRange(Term, SemesterType);
                    GradeBookTemp.SetRange("Type of Input", GradeInput."Type of Input");
                    GradeBookTemp.SetRange("Input Sequence", GradeInput."Input Sequence");
                    If Not GradeBookTemp.FindFirst() then begin
                        AvblPoints := 0;
                        TotalEarnedPoint := 0;

                        GradeBook_1.Reset();
                        GradeBook_1.SetCurrentKey("Student No.", "Academic year");
                        GradeBook_1.SetRange("Student No.", StudentMaster."No.");
                        GradeBook_1.SetRange("Academic year", StudentMaster."Academic Year");
                        GradeBook_1.SetRange(Semester, StudentMaster.Semester);
                        GradeBook_1.SetRange(Term, SemesterType);
                        GradeBook_1.SetRange("Type of Input", GradeInput."Type of Input");
                        GradeBook_1.CalcSums(GradeBook_1."Earned Points", GradeBook_1."Available Points");
                        AvblPoints := GradeBook_1."Available Points";
                        TotalEarnedPoint := GradeBook_1."Earned Points";

                        GradeBookTemp.Init();
                        GradeBookTemp."Entry No." := GradeBookTemp."Entry No." + 1;
                        GradeBookTemp."Student No." := StudentMaster."No.";
                        GradeBookTemp."First Name" := StudentMaster."First Name";
                        GradeBookTemp."Middle Name" := StudentMaster."Middle Name";
                        GradeBookTemp."Last Name" := StudentMaster."Last Name";
                        GradeBookTemp."Student Name" := StudentMaster."Student Name";
                        GradeBookTemp."Enrollment No." := StudentMaster."Enrollment No.";
                        GradeBookTemp."Academic Year" := StudentMaster."Academic Year";
                        GradeBookTemp."Admitted Year" := StudentMaster."Admitted Year";
                        GradeBookTemp.Semester := StudentMaster.Semester;
                        GradeBookTemp."Global Dimension 1 Code" := GradeInput."Global Dimension 1 Code";
                        GradeBookTemp.Term := GradeBook.Term;
                        GradeBookTemp."Exam Classification" := GradeBook."Exam Classification";
                        GradeBookTemp."Type of Input" := GradeInput."Type of Input";
                        GradeBookTemp."Input Sequence" := GradeInput."Input Sequence";
                        GradeBookTemp."Earned Points" := TotalEarnedPoint;
                        GradeBookTemp."Available Points" := AvblPoints;
                        GradeBookTemp."Earned Points Percentage" := round((TotalEarnedPoint / AvblPoints) * 100, 0.01, '=');

                        RecRecommendations.Reset();
                        RecRecommendations.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                        RecRecommendations.SetRange(Semester, StudentMaster.Semester);
                        RecRecommendations.SetFilter("Min. Percentage", '<=%1', GradeBookTemp."Earned Points Percentage");
                        RecRecommendations.SetFilter("Max Percentage", '>=%1', GradeBookTemp."Earned Points Percentage");
                        RecRecommendations.SetRange("Academic SAP", StudentMaster."Remaining Academic SAP");        //23Mar2023
                        If StudentMaster."Remaining Academic SAP" <> 5 then
                            RecRecommendations.SetRange(Repeating, (StudentMaster."Semester Decision" = StudentMaster."Semester Decision"::"Repeat ") OR (StudentMaster."Semester Decision" = StudentMaster."Semester Decision"::Restart));
                        IF GradeBookTemp.Semester = 'BSIC' then begin
                            StudentSubjectExam.Reset();
                            StudentSubjectExam.SetCurrentKey("Exam Sequence");
                            StudentSubjectExam.SetRange("Student No.", GradeBookTemp."Student No.");
                            StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CBSE);
                            StudentSubjectExam.SetAscending("Exam Sequence", false);
                            IF StudentSubjectExam.FindFirst() then begin
                                RecRecommendations.SetFilter("CBSE Min", '<=%1', StudentSubjectExam.Total);
                                RecRecommendations.SetFilter("CBSE Max", '>=%1', StudentSubjectExam.Total);
                            end;
                        end;
                        IF RecRecommendations.FindFirst() then begin
                            GradeBookTemp."% Range" := RecRecommendations."Range Percentage";
                            GradeBookTemp.Recommendation := RecRecommendations.Recommendation;
                        end;

                        GradeBook_2.Reset();
                        GradeBook_2.SetRange("Student No.", StudentMaster."No.");
                        GradeBook_2.SetRange("Academic year", StudentMaster."Academic Year");
                        GradeBook_2.SetRange(Semester, StudentMaster.Semester);
                        GradeBook_2.SetRange(Term, SemesterType);
                        GradeBook_2.SetRange("Exam Classification", ExamClassification);
                        GradeBook_2.SetRange("Type of Input", GradeBook_2."Type of Input"::" ");
                        GradeBook_2.SetFilter(Grade, '%1|%2|%3', 'SLOA', 'ELOA', 'CLOA');
                        If GradeBook_2.FindFirst() then begin
                            GradeBookTemp."Grade Result" := GradeBook_2.Grade;
                        End Else Begin
                            GradeMaster.Reset();
                            GradeMaster.SetRange(Graduation, StudentMaster.Graduation);
                            GradeMaster.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                            GradeMaster.SetFilter("Min Percentage", '<=%1', GradeBookTemp."Earned Points Percentage");
                            GradeMaster.SetFilter("Max Percentage", '>=%1', GradeBookTemp."Earned Points Percentage");
                            If GradeMaster.FindFirst() Then
                                GradeBookTemp."Grade Result" := GradeMaster.Code;
                        End;
                        GradeBookTemp.Insert();
                    end;

                until GradeInput.Next() = 0;
        end;
        // Temp End <<

        //For End Total Line
        GradeBook.Reset();
        GradeBook.SetRange("Student No.", StudentMaster."No.");
        if GradeBook.FindLast() then
            LastEntryNo := GradeBook."Entry No.";

        GradeBookTemp.Reset();
        GradeBookTemp.SetRange("Student No.", StudentMaster."No.");
        GradeBookTemp.SetRange("Academic year", StudentMaster."Academic Year");
        GradeBookTemp.SetRange(Semester, StudentMaster.Semester);
        If GradeBookTemp.Findset() then
            repeat
                LastEntryNo += 1;
                GradeBook.Init();
                GradeBook."Entry No." := LastEntryNo;
                GradeBook."Student No." := GradeBookTemp."Student No.";
                GradeBook."First Name" := GradeBookTemp."First Name";
                GradeBook."Middle Name" := GradeBookTemp."Middle Name";
                GradeBook."Last Name" := GradeBookTemp."Last Name";
                GradeBook."Student Name" := GradeBookTemp."Student Name";
                GradeBook."Enrollment No." := GradeBookTemp."Enrollment No.";
                GradeBook."Academic Year" := GradeBookTemp."Academic Year";
                GradeBook."Admitted Year" := GradeBookTemp."Admitted Year";
                GradeBook.Semester := GradeBookTemp.Semester;
                GradeBook."Global Dimension 1 Code" := GradeBookTemp."Global Dimension 1 Code";
                GradeBook.Term := GradeBookTemp.Term;
                GradeBook."Exam Classification" := GradeBookTemp."Exam Classification";
                GradeBook."Type of Input" := GradeBookTemp."Type of Input";
                GradeBook."Input Sequence" := GradeBookTemp."Input Sequence";
                GradeBook."Earned Points" := GradeBookTemp."Earned Points";
                GradeBook."Available Points" := GradeBookTemp."Available Points";
                GradeBook."Earned Points Percentage" := GradeBookTemp."Earned Points Percentage";
                GradeBook."% Range" := GradeBookTemp."% Range";
                GradeBook.Recommendation := GradeBookTemp.Recommendation;
                GradeBook."Grade Result" := GradeBookTemp."Grade Result";
                GradeBook.Insert();
            Until GradeBookTemp.Next() = 0;


        //FOR BEST LINE CALCULATION
        GradeBook.Reset();
        GradeBook.SetRange("Student No.", StudentMaster."No.");
        if GradeBook.FindLast() then
            LastEntryNo := GradeBook."Entry No.";

        GradeBookTemp.Reset();
        GradeBookTemp.SetCurrentKey("Student No.", "Academic Year", Semester, "Earned Points Percentage");
        GradeBookTemp.SetRange("Student No.", StudentMaster."No.");
        GradeBookTemp.SetRange("Academic Year", StudentMaster."Academic Year");
        GradeBookTemp.SetRange(Semester, StudentMaster.Semester);
        GradeBookTemp.SetRange(Term, SemesterType);
        If GradeBookTemp.FindLast() then begin
            LastEntryNo += 1;
            GradeBook.Init();
            GradeBook."Entry No." := LastEntryNo;
            GradeBook."Student No." := GradeBookTemp."Student No.";
            GradeBook."First Name" := GradeBookTemp."First Name";
            GradeBook."Middle Name" := GradeBookTemp."Middle Name";
            GradeBook."Last Name" := GradeBookTemp."Last Name";
            GradeBook."Student Name" := GradeBookTemp."Student Name";
            GradeBook."Enrollment No." := GradeBookTemp."Enrollment No.";
            GradeBook."Academic Year" := GradeBookTemp."Academic Year";
            GradeBook."Admitted Year" := GradeBookTemp."Admitted Year";
            GradeBook.Semester := GradeBookTemp.Semester;
            GradeBook."Global Dimension 1 Code" := GradeBookTemp."Global Dimension 1 Code";
            GradeBook.Term := GradeBookTemp.Term;
            GradeBook."Exam Classification" := GradeBookTemp."Exam Classification";
            GradeBook."Type of Input" := GradeBook."Type of Input"::Best;
            GradeBook."Input Sequence" := 0;
            GradeBook."Earned Points" := GradeBookTemp."Earned Points";
            GradeBook."Available Points" := GradeBookTemp."Available Points";
            GradeBook."Earned Points Percentage" := GradeBookTemp."Earned Points Percentage";
            GradeBook."% Range" := GradeBookTemp."% Range";
            GradeBook.Recommendation := GradeBookTemp.Recommendation;
            GradeBook."Grade Result" := GradeBookTemp."Grade Result";
            GradeBook.Indentation := 0;

            GradeMaster.Reset();
            GradeMaster.SetRange(Graduation, StudentMaster.Graduation);
            GradeMaster.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
            GradeMaster.SetRange(Code, GradeBookTemp."Grade Result");
            If GradeMaster.FindFirst() Then
                GradeBook."Quality Point" := GradeMaster."Grade Points";

            RecSemester.Reset();
            RecSemester.SetRange(Code, StudentMaster.Semester);
            RecSemester.SetRange(Graduation, StudentMaster.Graduation);
            if RecSemester.FindFirst() then
                GradeBook.Credit := RecSemester.Credit;

            GradeBook."Credit Earned" := Round((GradeBook."Quality Point" * GradeBook.Credit), 0.01, '=');
            GradeBook.Insert();

            ExaminationSetup.Reset();
            ExaminationSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
            IF ExaminationSetup.FindFirst() then begin
                IF StudentMaster.Semester = ExaminationSetup."Semester I" then begin
                    StudentMaster."Semester I Credit Earned" := GradeBook."Credit Earned";
                    StudentMaster."Semester I GPA" := Round((GradeBook."Credit Earned" / GradeBook.Credit), 0.01, '=');
                end;

                IF StudentMaster.Semester = ExaminationSetup."Semester II" then begin
                    StudentMaster."Semester II Credit Earned" := GradeBook."Credit Earned";
                    StudentMaster."Semester II GPA" := Round((GradeBook."Credit Earned" / GradeBook.Credit), 0.01, '=');
                End;
                IF StudentMaster.Semester = ExaminationSetup."Semester III" then begin
                    StudentMaster."Semester III Credit Earned" := GradeBook."Credit Earned";
                    StudentMaster."Semester III GPA" := Round((GradeBook."Credit Earned" / GradeBook.Credit), 0.01, '=');
                End;
                IF StudentMaster.Semester = ExaminationSetup."Semester IV" then begin
                    StudentMaster."Semester IV Credit Earned" := GradeBook."Credit Earned";
                    StudentMaster."Semester IV GPA" := Round((GradeBook."Credit Earned" / GradeBook.Credit), 0.01, '=');
                End;
                IF StudentMaster.Semester = ExaminationSetup."Semester V" then begin
                    StudentMaster."Semester V Credit Earned" := GradeBook."Credit Earned";
                    StudentMaster."Semester V GPA" := Round((GradeBook."Credit Earned" / GradeBook.Credit), 0.01, '=');
                End;
                IF StudentMaster.Semester = ExaminationSetup."Semester VI" then begin
                    StudentMaster."Semester VI Credit Earned" := GradeBook."Credit Earned";
                    StudentMaster."Semester VI GPA" := Round((GradeBook."Credit Earned" / GradeBook.Credit), 0.01, '=');
                End;
                IF StudentMaster.Semester = ExaminationSetup."Semester VII" then begin
                    StudentMaster."Semester VII Credit Earned" := GradeBook."Credit Earned";
                    StudentMaster."Semester VII GPA" := Round((GradeBook."Credit Earned" / GradeBook.Credit), 0.01, '=');
                End;
                IF StudentMaster.Semester = ExaminationSetup."Semester VIII" then begin
                    StudentMaster."Semester VIII Credit Earned" := GradeBook."Credit Earned";
                    StudentMaster."Semester VIII GPA" := Round((GradeBook."Credit Earned" / GradeBook.Credit), 0.01, '=');
                End;

                GradeBook_1.Reset();
                GradeBook_1.SetRange("Student No.", StudentMaster."No.");
                GradeBook_1.SetRange("Type of Input", GradeBook_1."Type of Input"::Best);
                GradeBook_1.CalcSums(Credit, "Credit Earned");

                StudentMaster."Net Semester CGPA" := Round((GradeBook_1."Credit Earned" / GradeBook_1.Credit), 0.01, '=');
                StudentMaster.Updated := TRUE;
                StudentMaster.MODIFY();

                MainStudentSubject.Reset();
                MainStudentSubject.SetRange("Student No.", StudentMaster."No.");
                MainStudentSubject.SetRange(Semester, StudentMaster.Semester);
                MainStudentSubject.SetRange("Academic Year", StudentMaster."Academic Year");
                MainStudentSubject.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                IF MainStudentSubject.FindSet() then begin
                    MainStudentSubject.ModifyAll(MainStudentSubject.Publish, true);
                end;
            end;
        END;
    end;

    /// <summary> 
    /// Description for CreateInternalExam.
    /// </summary>
    /// <param name="GlobalDimension1Code">Parameter of type Code[20].</param>
    /// <param name="DocNo">Parameter of type Code[20].</param>
    /// <param name="ExamClass">Parameter of type Code[20].</param>
    /// <param name="ExamType">Parameter of type Option " ","Internal","External".</param>
    procedure CreateInternalExam(GlobalDimension1Code: Code[20]; DocNo: Code[20]; ExamClass: Code[20]; ExamType: Option " ","Internal","External"; var TotalLinesCreated: Integer)
    var
        ExamScheduleLine: Record "Exam Time Table Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        InternalExamHeader: Record "Internal Exam Header-CS";
        SubjectMaster: Record "Subject Master-CS";
        SubjMaster: Record "Subject Master-CS";
        CourseMaster: Record "Course Master-CS";
        StudentSubject: Record "Main Student Subject-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        Lvl: Integer;
        NEXTNo: Code[20];
        Lvl1Subj: Code[20];
    Begin
        AcademicsSetupCS.Get();
        ExamScheduleLine.Reset();
        ExamScheduleLine.SetRange("Document No.", DocNo);
        // ExamScheduleLine.SetRange("Global Dimension 1 Code", GlobalDimension1Code);
        // ExamScheduleLine.SetRange("Exam Classification", ExamClass);
        // ExamScheduleLine.SetRange("Examiner Type", ExamType);
        ExamScheduleLine.SetFilter("Exam Date", '<>%1', 0D);
        ExamScheduleLine.SetRange("Exam No.", '');
        ExamScheduleLine.SetFilter("Exam Slot New", '<>%1', '');
        ExamScheduleLine.SetRange("Select To Generate", true);
        If ExamScheduleLine.FindSet() then
            repeat
                CheckSameSubjectWithOrWTGrp(ExamScheduleLine);
                ExamScheduleLine.TestField("Start Time New");
                ExamScheduleLine.TestField("End Time New");
                AcademicsSetupCS.TestField("Internal Marks No.");
                NEXTNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Internal Marks No.", 0D, TRUE);

                InternalExamHeader.INIT();
                InternalExamHeader."No." := NEXTNo;
                InternalExamHeader."Exam Schedule Code" := ExamScheduleLine."Document No.";
                InternalExamHeader."Course Code" := ExamScheduleLine."Course Code";
                CourseMaster.Get(ExamScheduleLine."Course Code");
                InternalExamHeader."Course Name" := CourseMaster.Description;
                InternalExamHeader."Program" := ExamScheduleLine."Program";
                InternalExamHeader."Type Of Course" := CourseMaster."Type Of Course";
                InternalExamHeader."Academic Year" := ExamScheduleLine."Academic Year";
                InternalExamHeader.Semester := ExamScheduleLine."Semester Code";
                InternalExamHeader.Year := ExamScheduleLine.Year;
                InternalExamHeader."Global Dimension 1 Code" := ExamScheduleLine."Global Dimension 1 Code";
                InternalExamHeader."Global Dimension 2 Code" := ExamScheduleLine."Global Dimension 2 Code";
                InternalExamHeader."Document Type" := ExamType;
                InternalExamHeader."Exam Classification" := ExamScheduleLine."Exam Classification";
                InternalExamHeader."Subject Class" := ExamScheduleLine."Subject Class";
                InternalExamHeader."Subject Type" := ExamScheduleLine."Subject Type";
                InternalExamHeader.VALIDATE("Subject Code", ExamScheduleLine."Subject Code");
                SubjectMaster.reset();
                SubjectMaster.Setrange(Code, ExamScheduleLine."Subject Code");
                SubjectMaster.FindFirst();
                // InternalExamHeader."Student Group" := SubjectMaster."Group Code";
                SubjectMaster.TestField("Internal Maximum");
                InternalExamHeader."Maximum Mark" := SubjectMaster."Internal Maximum";

                // InternalExamHeader."Maximum Weightage" := SubjectMaster."Maximum Weightage";

                InternalExamHeader.Status := InternalExamHeader.Status::Open;
                InternalExamHeader.Term := ExamScheduleLine.Term;
                InternalExamHeader."Exam Date" := ExamScheduleLine."Exam Date";
                InternalExamHeader."Exam Slot" := ExamScheduleLine."Exam Slot New";
                InternalExamHeader."Start Time" := ExamScheduleLine."Start Time New";
                InternalExamHeader."End Time" := ExamScheduleLine."End Time New";
                InternalExamHeader.Batch := ExamScheduleLine.Batch;
                InternalExamHeader."Student Group" := ExamScheduleLine."Student Group";
                InternalExamHeader."Exam Classification" := ExamScheduleLine."Exam Classification";
                InternalExamHeader."Created By" := FORMAT(UserId());
                InternalExamHeader."Created On" := TODAY();

                StudentSubject.Reset();
                StudentSubject.SetCurrentKey(StudentSubject."Student No.");
                StudentSubject.SetRange("Global Dimension 1 Code", InternalExamHeader."Global Dimension 1 Code");
                StudentSubject.SetRange("Academic Year", InternalExamHeader."Academic Year");
                StudentSubject.SetRange(Term, InternalExamHeader.Term);
                StudentSubject.SetRange(Semester, InternalExamHeader.Semester);

                // if InternalExamHeader."Global Dimension 1 Code" = '9100' then
                //     StudentSubject.SetRange("Subject Code", InternalExamHeader."Subject Code")
                // else
                // if InternalExamHeader."Global Dimension 1 Code" = '9000' then begin
                Lvl := SubjectMaster.Level;
                if Lvl = 2 then begin
                    SubjMaster.Reset();
                    SubjMaster.SetRange(Code, InternalExamHeader."Subject Code");
                    SubjMaster.FindFirst();

                    Lvl1Subj := SubjMaster."Subject Group";
                    SubjMaster.Reset();
                    SubjMaster.SetRange(Code, Lvl1Subj);
                    SubjMaster.FindFirst();
                end
                else
                    if Lvl = 3 then begin
                        SubjMaster.Reset();
                        SubjMaster.SetRange(Code, InternalExamHeader."Subject Code");
                        SubjMaster.FindFirst();

                        Lvl1Subj := SubjMaster."Subject Group";
                        SubjMaster.Reset();
                        SubjMaster.SetRange(Code, Lvl1Subj);
                        SubjMaster.FindFirst();

                        Lvl1Subj := SubjMaster."Subject Group";
                        SubjMaster.Reset();
                        SubjMaster.SetRange(Code, Lvl1Subj);
                        SubjMaster.FindFirst();
                    end;
                StudentSubject.SetRange("Subject Code", SubjMaster.Code);

                // end
                // else
                //     Error('Institute Code must be 9000 or 9100');

                StudentSubject.SetRange(Course, InternalExamHeader."Course Code");
                if ExamScheduleLine."Student Group" <> '' then
                    StudentSubject.SetRange(Section, ExamScheduleLine."Student Group");
                // StudentSubject.SetRange(Publish, false);
                StudentSubject.SetRange("Grade Confirmed", false);
                IF StudentSubject.FindFirst() then begin
                    InternalExamHeader.Insert(true);
                    // ExamScheduleLine."Exam No." := NEXTNo;
                    // ExamScheduleLine.Modify();
                    CreateInternalExamLine(InternalExamHeader, ExamScheduleLine)
                end;


            Until ExamScheduleLine.Next() = 0;
    End;

    /// <summary> 
    /// Description for CreateInternalExamLine.
    /// </summary>
    /// <param name="RecInternalExamHeader">Parameter of type Record "Internal Exam Header-CS".</param>
    procedure CreateInternalExamLine(RecInternalExamHeader: Record "Internal Exam Header-CS"; ExamScheduleLine: Record "Exam Time Table Line-CS")
    var
        StudentInternalLine: Record "Internal Exam Line-CS";
        MarksWeight: Record "Marks Weightage";
        SubjectMaster_1: Record "Subject Master-CS";
        SubjMaster: Record "Subject Master-CS";
        StudentSubject: Record "Main Student Subject-CS";
        StudentSubject_1: Record "Main Student Subject-CS";
        StudentLeaveAbsence: Record "Student Leave of Absence";
        Stud: Record "Student Master-CS";
        LocLineNo: Integer;
        LineExec: Integer;
        Lvl1Subj: Code[20];
        Lvl: Integer;
    Begin
        LineExec := 0;
        StudentSubject.Reset();
        StudentSubject.SetCurrentKey(StudentSubject."Student No.");
        StudentSubject.SetRange("Global Dimension 1 Code", RecInternalExamHeader."Global Dimension 1 Code");
        StudentSubject.SetRange("Academic Year", RecInternalExamHeader."Academic Year");
        StudentSubject.SetRange(Term, RecInternalExamHeader.Term);
        StudentSubject.SetRange(Semester, RecInternalExamHeader.Semester);

        // StudentSubject.SetRange("Subject Code", RecInternalExamHeader."Subject Code");
        // if RecInternalExamHeader."Global Dimension 1 Code" = '9100' then
        //     StudentSubject.SetRange("Subject Code", RecInternalExamHeader."Subject Code")
        // else
        //     if RecInternalExamHeader."Global Dimension 1 Code" = '9000' then begin
        SubjMaster.Reset();
        SubjMaster.SetRange(Code, RecInternalExamHeader."Subject Code");
        SubjMaster.FindFirst();
        Lvl := SubjMaster.Level;
        if Lvl = 2 then begin
            SubjMaster.Reset();
            SubjMaster.SetRange(Code, RecInternalExamHeader."Subject Code");
            SubjMaster.FindFirst();
            Lvl1Subj := SubjMaster."Subject Group";
            SubjMaster.Reset();
            SubjMaster.SetRange(Code, Lvl1Subj);
            SubjMaster.FindFirst();
        end
        else
            if Lvl = 3 then begin
                SubjMaster.Reset();
                SubjMaster.SetRange(Code, RecInternalExamHeader."Subject Code");
                SubjMaster.FindFirst();
                Lvl1Subj := SubjMaster."Subject Group";
                SubjMaster.Reset();
                SubjMaster.SetRange(Code, Lvl1Subj);
                SubjMaster.FindFirst();
                Lvl1Subj := SubjMaster."Subject Group";
                SubjMaster.Reset();
                SubjMaster.SetRange(Code, Lvl1Subj);
                SubjMaster.FindFirst();
            end;
        StudentSubject.SetRange("Subject Code", SubjMaster.Code);

        // end
        // else
        //     Error('Institute Code must be 9000 or 9100');


        StudentSubject.SetRange(Course, RecInternalExamHeader."Course Code");
        if ExamScheduleLine."Student Group" <> '' then
            StudentSubject.SetRange(Section, ExamScheduleLine."Student Group");
        // StudentSubject.SetRange(Publish, false);
        StudentSubject.SetRange("Grade Confirmed", false);
        IF StudentSubject.FindSet() then begin
            repeat
                if CheckIfActive(StudentSubject."Student No.") then begin


                    StudentInternalLine.RESET();
                    StudentInternalLine.SETRANGE("Document No.", RecInternalExamHeader."No.");
                    IF StudentInternalLine.FINDLAST() THEN
                        LocLineNo := StudentInternalLine."Line No." + 10000
                    ELSE
                        LocLineNo := 10000;

                    StudentInternalLine.INIT();
                    StudentInternalLine."Document No." := RecInternalExamHeader."No.";
                    StudentInternalLine."Line No." := LocLineNo;
                    StudentInternalLine.Semester := StudentSubject.Semester;
                    StudentInternalLine."Type Of Course" := StudentSubject."Type Of Course";
                    StudentInternalLine."Exam Schedule No." := RecInternalExamHeader."Exam Schedule Code";
                    StudentInternalLine.Section := ExamScheduleLine."Student Group";
                    StudentInternalLine.Course := RecInternalExamHeader."Course Code";
                    StudentInternalLine."Exam Classification" := RecInternalExamHeader."Exam Classification";
                    StudentInternalLine.Term := RecInternalExamHeader.Term;

                    StudentInternalLine."Exam Slot" := ExamScheduleLine."Exam Slot New";
                    StudentInternalLine."Start Time" := ExamScheduleLine."Start Time New";
                    StudentInternalLine."End Time" := ExamScheduleLine."End Time New";


                    StudentInternalLine."Academic Year" := StudentSubject."Academic Year";
                    StudentInternalLine."Subject Class" := StudentSubject."Subject Class";
                    StudentInternalLine."Subject Type" := StudentSubject."Subject Type";

                    StudentInternalLine."Subject Code" := ExamScheduleLine."Subject Code";
                    StudentInternalLine.validate("Student No.", StudentSubject."Student No.");
                    // if DuplicationFound(RecInternalExamHeader."Academic Year", RecInternalExamHeader.Term, RecInternalExamHeader."Subject Code", RecInternalExamHeader."Subject Class", StudentInternalLine."Student No.", 2) then
                    //     Error('Duplicate entry found for Student No. %1, Subject Code %2, Academic Year %3, Term %4',
                    //     StudentSubject."Student No.", StudentSubject."Subject Code", StudentSubject."Academic Year",
                    //     StudentSubject.Term);
                    // StudentInternalLine."Student Name" := StudentSubject."Student Name";
                    // Stud.Reset();
                    // Stud.Get(StudentInternalLine."Student No.");
                    // StudentInternalLine."Original Student No." := Stud."Original Student No.";
                    // StudentInternalLine."Enrollment No." := StudentSubject."Enrollment No";
                    // StudentInternalLine.Batch := StudentSubject.Batch;
                    // StudentInternalLine."Student Group" := ExamScheduleLine."Student Group";

                    // StudentInternalLine.VALIDATE(Status, RecInternalExamHeader.Status);
                    // StudentInternalLine.VALIDATE("Global Dimension 1 Code", RecInternalExamHeader."Global Dimension 1 Code");
                    // StudentInternalLine.Year := StudentSubject.Year;

                    // StudentInternalLine."Exam Group" := RecInternalExamHeader."Exam Group";
                    // StudentInternalLine."Exam Method Code" := RecInternalExamHeader."Exam Method Code";

                    // StudentInternalLine."Exam Type" := RecInternalExamHeader."Exam Type";
                    // StudentInternalLine."Program" := RecInternalExamHeader."Program";
                    // SubjectMaster_1.Reset();
                    // SubjectMaster_1.SetRange(Code, RecInternalExamHeader."Subject Code");
                    // SubjectMaster_1.FindFirst();
                    // // StudentInternalLine."Maximum Weightage" := SubjectMaster_1."Maximum Weightage";
                    // SubjectMaster_1.TestField("Internal Maximum");
                    // StudentInternalLine."Maximum Internal  Marks" := SubjectMaster_1."Internal Maximum";


                    // MarksWeight.Reset();
                    // MarksWeight.SetRange("Global Dimension 1 Code", StudentInternalLine."Global Dimension 1 Code");
                    // MarksWeight.SetRange("Academic Year", StudentInternalLine."Academic year");
                    // MarksWeight.SetRange("Course Code", StudentInternalLine.Course);
                    // MarksWeight.SetRange(Semester, StudentInternalLine.Semester);
                    // MarksWeight.SetRange("Exam Code", StudentInternalLine."Subject Code");
                    // MarksWeight.FindFirst();
                    // MarksWeight.TestField(Points);
                    // StudentInternalLine."Maximum Weightage" := MarksWeight.Points;

                    // StudentInternalLine."Created By" := Format(USERID());
                    // StudentInternalLine."Created On" := TODAY();
                    // StudentInternalLine."Exam Date" := ExamScheduleLine."Exam Date";
                    StudentInternalLine.INSERT(true);
                    LineExec += 1;
                end;
            until StudentSubject.Next() = 0;
            if LineExec > 0 then begin
                ExamScheduleLine."Exam No." := RecInternalExamHeader."No.";
                ExamScheduleLine."Select To Generate" := false;
                ExamScheduleLine.Modify();
            end;
        end;
    End;

    /// <summary> 
    /// Description for CreateExternalExam.
    /// </summary>
    /// <param name="GlobalDimension1Code">Parameter of type Code[20].</param>
    /// <param name="DocNo">Parameter of type Code[20].</param>
    /// <param name="ExamClass">Parameter of type Code[20].</param>
    /// <param name="ExamType">Parameter of type Option " ","Internal","External".</param>
    procedure CreateExternalExam(GlobalDimension1Code: Code[20]; DocNo: Code[20]; ExamClass: Code[20]; ExamType: Option " ","Internal","External"; var TotalLinesCreated: Integer)
    var
        ExamScheduleLine: Record "Exam Time Table Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";

        ExternalExamHeader: Record "External Exam Header-CS";
        CourseMaster: Record "Course Master-CS";
        SubjectMaster: Record "Subject Master-CS";
        SubjMaster: Record "Subject Master-CS";
        StudentSubject: Record "Main Student Subject-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        Lvl1Subj: Code[20];
        NEXTNo: Code[20];
    Begin
        AcademicsSetupCS.Get();
        ExamScheduleLine.Reset();
        ExamScheduleLine.SetRange("Document No.", DocNo);
        // ExamScheduleLine.SetRange("Global Dimension 1 Code", GlobalDimension1Code);
        // ExamScheduleLine.SetRange("Exam Classification", ExamClass);
        // ExamScheduleLine.SetRange("Examiner Type", ExamType);
        ExamScheduleLine.SetFilter("Exam Date", '<>%1', 0D);
        ExamScheduleLine.SetRange("Exam No.", '');
        ExamScheduleLine.SetFilter("Exam Slot New", '<>%1', '');
        ExamScheduleLine.SetRange("Select To Generate", true);
        If ExamScheduleLine.FindSet() then
            repeat
                CheckSameSubjectWithOrWTGrp(ExamScheduleLine);
                ExamScheduleLine.TestField("Start Time New");
                ExamScheduleLine.TestField("End Time New");
                AcademicsSetupCS.TestField("External Marks No.");
                NEXTNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."External Marks No.", 0D, TRUE);

                ExternalExamHeader.INIT();
                ExternalExamHeader."No." := NEXTNo;
                ExternalExamHeader."Exam Schedule Code" := ExamScheduleLine."Document No.";
                ExternalExamHeader."Course Code" := ExamScheduleLine."Course Code";
                CourseMaster.Get(ExamScheduleLine."Course Code");
                ExternalExamHeader."Course Name" := CourseMaster.Description;
                ExternalExamHeader."Program" := ExamScheduleLine."Program";
                ExternalExamHeader."Type Of Course" := CourseMaster."Type Of Course";
                ExternalExamHeader."Academic Year" := ExamScheduleLine."Academic Year";
                ExternalExamHeader.Semester := ExamScheduleLine."Semester Code";
                ExternalExamHeader.Year := ExamScheduleLine.Year;
                ExternalExamHeader."Global Dimension 1 Code" := ExamScheduleLine."Global Dimension 1 Code";
                ExternalExamHeader."Global Dimension 2 Code" := ExamScheduleLine."Global Dimension 2 Code";
                ExternalExamHeader."Document Type" := ExamType;
                ExternalExamHeader."Subject Class" := ExamScheduleLine."Subject Class";
                ExternalExamHeader."Subject Type" := ExamScheduleLine."Subject Type";
                ExternalExamHeader.VALIDATE("Subject Code", ExamScheduleLine."Subject Code");
                SubjectMaster.reset();
                SubjectMaster.Setrange(Code, ExamScheduleLine."Subject Code");
                SubjectMaster.FindFirst();
                ExternalExamHeader."External Maximum" := SubjectMaster."External Maximum";
                SubjectMaster.TestField("Total Maximum");
                ExternalExamHeader."Total Maximum" := SubjectMaster."Total Maximum";

                ExternalExamHeader.Status := ExternalExamHeader.Status::Open;
                ExternalExamHeader.Term := ExamScheduleLine.Term;
                ExternalExamHeader."Exam Date" := ExamScheduleLine."Exam Date";
                ExternalExamHeader."Exam Slot" := ExamScheduleLine."Exam Slot New";
                ExternalExamHeader."Start Time" := ExamScheduleLine."Start Time New";
                ExternalExamHeader."End Time" := ExamScheduleLine."End Time New";
                ExternalExamHeader.Batch := ExamScheduleLine.Batch;
                ExternalExamHeader."Student Group" := ExamScheduleLine."Student Group";
                ExternalExamHeader."Exam Classification" := ExamScheduleLine."Exam Classification";
                ExternalExamHeader."Created By" := FORMAT(UserId());
                ExternalExamHeader."Created On" := TODAY();

                StudentSubject.Reset();
                StudentSubject.SetCurrentKey(StudentSubject."Student No.");
                StudentSubject.SetRange("Global Dimension 1 Code", ExternalExamHeader."Global Dimension 1 Code");
                StudentSubject.SetRange("Academic Year", ExternalExamHeader."Academic Year");
                StudentSubject.SetRange(Term, ExternalExamHeader.Term);
                StudentSubject.SetRange(Semester, ExternalExamHeader.Semester);

                if ExternalExamHeader."Global Dimension 1 Code" = '9100' then
                    StudentSubject.SetRange("Subject Code", ExternalExamHeader."Subject Code")
                else
                    if ExternalExamHeader."Global Dimension 1 Code" = '9000' then begin
                        SubjMaster.Reset();
                        SubjMaster.SetRange(Code, ExternalExamHeader."Subject Code");
                        SubjMaster.FindFirst();
                        Lvl1Subj := SubjMaster."Subject Group";
                        SubjMaster.Reset();
                        SubjMaster.SetRange(Code, Lvl1Subj);
                        SubjMaster.FindFirst();
                        StudentSubject.SetRange("Subject Code", SubjMaster.Code)
                    end
                    else
                        Error('Institute Code must be 9000 or 9100');

                StudentSubject.SetRange(Course, ExternalExamHeader."Course Code");
                if ExamScheduleLine."Student Group" <> '' then
                    StudentSubject.SetRange(Section, ExamScheduleLine."Student Group");
                // StudentSubject.SetRange(Publish, false);
                StudentSubject.setrange("Grade Confirmed", false);
                IF StudentSubject.FindFirst() then begin
                    ExternalExamHeader.Insert(true);
                    IF ExternalExamHeader."Exam Classification" <> 'MAKEUP' then begin
                        CreateexternalExamLine(ExternalExamHeader, ExamScheduleLine);
                        TotalLinesCreated += 1;
                    end Else begin
                        ExamScheduleLine."Exam No." := ExternalExamHeader."No.";
                        ExamScheduleLine."Select To Generate" := false;
                        ExamScheduleLine.Modify();
                    end;
                end;
            Until ExamScheduleLine.Next() = 0;
    End;

    /// <summary> 
    /// Description for CreateExternalExamLine.
    /// </summary>
    /// <param name="RecExternalExamHeader">Parameter of type Record "External Exam Header-CS".</param>
    procedure CreateExternalExamLine(RecExternalExamHeader: Record "External Exam Header-CS"; ExamScheduleLine: Record "Exam Time Table Line-CS")
    var
        StudentExternalLine: Record "External Exam Line-CS";
        // SubjectMaster_1: Record "Subject Master-CS";
        Stud: Record "Student Master-CS";
        StudentSubject: Record "Main Student Subject-CS";
        StudentLeaveAbsence: Record "Student Leave of Absence";
        SubjMaster: Record "Subject Master-CS";
        MarksWeight: Record "Marks Weightage";
        Lvl1Subj: Code[20];
        LocLineNo: Integer;
        LineExec: Integer;
    Begin
        // ExamScheduleLine.Reset();
        // ExamScheduleLine.SetRange("Document No.", RecExternalExamHeader."Exam Schedule Code");
        // ExamScheduleLine.SetRange("Subject Code", RecExternalExamHeader."Subject Code");
        // ExamScheduleLine.SetFilter("Exam Date", '<>%1', 0D);
        // ExamScheduleLine.SetRange("Exam No.", '');
        // IF ExamScheduleLine.FindSet() then
        //     repeat
        LineExec := 0;
        StudentSubject.Reset();
        StudentSubject.SetCurrentKey(StudentSubject."Student No.");
        StudentSubject.SetRange("Global Dimension 1 Code", RecExternalExamHeader."Global Dimension 1 Code");
        StudentSubject.SetRange("Academic Year", RecExternalExamHeader."Academic Year");
        StudentSubject.SetRange(Term, RecExternalExamHeader.Term);
        StudentSubject.SetRange(Semester, RecExternalExamHeader.Semester);

        if RecExternalExamHeader."Global Dimension 1 Code" = '9100' then
            StudentSubject.SetRange("Subject Code", RecExternalExamHeader."Subject Code")
        else
            if RecExternalExamHeader."Global Dimension 1 Code" = '9000' then begin
                SubjMaster.Reset();
                SubjMaster.SetRange(Code, RecExternalExamHeader."Subject Code");
                SubjMaster.FindFirst();
                Lvl1Subj := SubjMaster."Subject Group";
                SubjMaster.Reset();
                SubjMaster.SetRange(Code, Lvl1Subj);
                SubjMaster.FindFirst();
                StudentSubject.SetRange("Subject Code", SubjMaster.Code)
            end
            else
                Error('Institute Code must be 9000 or 9100');

        StudentSubject.SetRange(Course, RecExternalExamHeader."Course Code");
        // if ExamScheduleLine.Batch <> '' then
        //     StudentSubject.SetRange(Batch, ExamScheduleLine.Batch);
        if ExamScheduleLine."Student Group" <> '' then
            StudentSubject.SetRange(Section, ExamScheduleLine."Student Group");

        // StudentSubject.SetRange(Publish, false);
        StudentSubject.SetRange("Grade Confirmed", false);
        IF StudentSubject.FindSet() then begin
            repeat
                if CheckIfActive(StudentSubject."Student No.") then begin
                    // if DuplicationFound(ExamScheduleLine, StudentSubject, 1) then


                    StudentExternalLine.RESET();
                    StudentExternalLine.SETRANGE("Document No.", RecExternalExamHeader."No.");
                    IF StudentExternalLine.FINDLAST() THEN
                        LocLineNo := StudentExternalLine."Line No." + 10000
                    ELSE
                        LocLineNo := 10000;

                    StudentExternalLine.INIT();
                    StudentExternalLine."Document No." := RecExternalExamHeader."No.";
                    StudentExternalLine."Line No." := LocLineNo;
                    StudentExternalLine.validate("Student No.", StudentSubject."Student No.");
                    // if DuplicationFound(RecExternalExamHeader."Academic Year", RecExternalExamHeader.Term, RecExternalExamHeader."Subject Code", RecExternalExamHeader."Subject Class", StudentExternalLine."Student No.", 1) then
                    //     Error('Duplicate entry found for Student No. %1, Subject Code %2, Academic Year %3, Term %4',
                    //     StudentSubject."Student No.", StudentSubject."Subject Code", StudentSubject."Academic Year",
                    //     StudentSubject.Term);
                    // StudentExternalLine.Semester := RecExternalExamHeader.Semester;
                    // StudentExternalLine."Type Of Course" := RecExternalExamHeader."Type Of Course";
                    // StudentExternalLine."Exam Schedule No." := RecExternalExamHeader."Exam Schedule Code";
                    // StudentExternalLine.Section := RecExternalExamHeader."Student Group";
                    // StudentExternalLine.Course := RecExternalExamHeader."Course Code";
                    // StudentExternalLine."Exam Classification" := RecExternalExamHeader."Exam Classification";
                    // StudentExternalLine.Term := RecExternalExamHeader.Term;
                    // StudentExternalLine."Exam Slot" := RecExternalExamHeader."Exam Slot";
                    // StudentExternalLine."Start Time" := RecExternalExamHeader."Start Time";
                    // StudentExternalLine."End Time" := RecExternalExamHeader."End Time";
                    // StudentExternalLine."Attendance Type" := StudentExternalLine."Attendance Type"::Present;
                    // StudentExternalLine."Academic Year" := RecExternalExamHeader."Academic Year";
                    // StudentExternalLine."Subject Class" := RecExternalExamHeader."Subject Class";
                    // StudentExternalLine."Subject Type" := RecExternalExamHeader."Subject Type";
                    // StudentExternalLine."Subject Code" := RecExternalExamHeader."Subject Code";

                    // Stud.Reset();
                    // Stud.Get(StudentExternalLine."Student No.");
                    // StudentExternalLine."Student Name" := Stud."Student Name";
                    // StudentExternalLine."Original Student No." := Stud."Original Student No.";
                    // StudentExternalLine."Enrollment No." := Stud."Enrollment No.";
                    // StudentExternalLine.Batch := RecExternalExamHeader.Batch;
                    // StudentExternalLine."Student Group" := RecExternalExamHeader."Student Group";
                    // StudentExternalLine.VALIDATE(Status, RecExternalExamHeader.Status);
                    // StudentExternalLine.VALIDATE("Global Dimension 1 Code", RecExternalExamHeader."Global Dimension 1 Code");
                    // StudentExternalLine.Year := RecExternalExamHeader.Year;
                    // StudentExternalLine."Exam Type" := RecExternalExamHeader."Exam Type";
                    // StudentExternalLine."Program" := RecExternalExamHeader."Program";
                    // StudentExternalLine."External Maximum" := RecExternalExamHeader."External Maximum";
                    // StudentExternalLine."Total Maximum" := RecExternalExamHeader."Total Maximum";

                    // MarksWeight.Reset();
                    // MarksWeight.SetRange("Global Dimension 1 Code", StudentExternalLine."Global Dimension 1 Code");
                    // MarksWeight.SetRange("Academic Year", StudentExternalLine."Academic year");
                    // MarksWeight.SetRange("Course Code", StudentExternalLine.Course);
                    // MarksWeight.SetRange(Semester, StudentExternalLine.Semester);
                    // MarksWeight.SetRange("Exam Code", StudentExternalLine."Subject Code");
                    // MarksWeight.FindFirst();
                    // MarksWeight.TestField(Points);
                    // StudentExternalLine."Maximum Weightage" := MarksWeight.Points;

                    // StudentExternalLine."Exam Date" := RecExternalExamHeader."Exam Date";
                    // StudentExternalLine."Created By" := Format(USERID());
                    // StudentExternalLine."Created On" := TODAY();

                    StudentExternalLine.INSERT(true);
                    LineExec += 1;
                end;
            until StudentSubject.Next() = 0;
            if LineExec > 0 then begin
                ExamScheduleLine."Exam No." := RecExternalExamHeader."No.";
                ExamScheduleLine."Select To Generate" := false;
                ExamScheduleLine.Modify();
            end;
        end;
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
            Stud2.SetFilter(Status, EduSetup."Grading Status");
            if Stud2.FindFirst() then
                Exit(True);
        end;
        Exit(false);

    end;

    procedure DuplicationFound(AY: Code[20]; Term: Option; SubCode: Code[20]; ExamClass: Code[20]; StudNo: code[20]; IntExt: Integer): Boolean
    var
        lvStudentExternalLine: Record "External Exam Line-CS";
        lvStudentInternalLine: Record "Internal Exam Line-CS";
    begin
        if IntExt = 1 then begin
            lvStudentInternalLine.Reset();
            lvStudentInternalLine.SetRange("Academic year", AY);
            lvStudentInternalLine.setrange(term, Term);
            lvStudentInternalLine.SetRange("Student No.", StudNo);
            lvStudentInternalLine.SetRange("Subject Code", SubCode);
            lvStudentInternalLine.SetRange("Exam Classification", ExamClass);
            if lvStudentInternalLine.FindFirst() then
                Exit(true);
        end
        else
            if IntExt = 2 then begin
                lvStudentExternalLine.Reset();
                lvStudentExternalLine.SetRange("Academic year", AY);
                lvStudentExternalLine.setrange(term, Term);
                lvStudentExternalLine.SetRange("Student No.", StudNo);
                lvStudentExternalLine.SetRange("Subject Code", SubCode);
                lvStudentExternalLine.SetRange("Exam Classification", ExamClass);
                if lvStudentExternalLine.FindFirst() then
                    Exit(true);
            end;
    end;

    /// <summary> 
    /// Description for GenerateExternalExamSchedule.
    /// </summary>
    /// <param name="DocNo">Parameter of type Code[20].</param>
    procedure GenerateExternalExamSchedule(DocNo: Code[20]; ExtInt: Integer)
    var
        ExamScheduleLine: Record "Exam Time Table Line-CS";
        ExamScheduleHead: Record "Exam Time Table Head-CS";
        CourseSubjectLine: Record "Course Wise Subject Line-CS";
        SubjMaster: Record "Subject Master-CS";
        SubjMaster2: Record "Subject Master-CS";
        BatchMaster: Record "Batch-CS";
        Sem: Record "Semester Master-CS";
        MainStudentSubject: Record "Main Student Subject-CS";
        MarksWeight: Record "Marks Weightage";
        MarksWeight1: Record "Marks Weightage";
        Lvl1Subj: Code[20];
        TotWeightage: Decimal;
        LineNo: Integer;
    begin
        // Message('Done');
        LineNo := 0;
        ExamScheduleHead.Get(DocNo);
        CourseSubjectLine.Reset();
        // CourseSubjectLine.SETRANGE("Academic Year", ExamScheduleHead."Academic Year");
        if ExamScheduleHead."Course Code" <> '' then
            CourseSubjectLine.SetRange("Course Code", ExamScheduleHead."Course Code");
        if ExamScheduleHead."Semester Code" <> '' then
            CourseSubjectLine.SetRange(Semester, ExamScheduleHead."Semester Code");
        CourseSubjectLine.SETRANGE("Global Dimension 1 Code", ExamScheduleHead."Global Dimension 1 Code");
        CourseSubjectLine.SETRANGE(Examination, true);
        if ExtInt = 1 then
            CourseSubjectLine.SETRANGE("Level Description", CourseSubjectLine."Level Description"::"External Examination")
        else
            if ExtInt = 2 then
                CourseSubjectLine.SETFilter("Level Description", '%1|%2', CourseSubjectLine."Level Description"::"Internal Examination",
                CourseSubjectLine."Level Description"::"Internal Exam Component");
        IF CourseSubjectLine.FindSet() THEN
            repeat

                Sem.Reset();
                Sem.SetRange(Code, CourseSubjectLine.Semester);
                Sem.FindFirst();
                if ExtInt = 1 then
                    Sem.TestField("Total Weightage")
                else
                    if ExtInt = 2 then
                        Sem.TestField("Internal Total Weightage");
                SubjMaster2.Reset();
                SubjMaster2.SetRange(code, CourseSubjectLine."Subject Code");
                if SubjMaster2.FindFirst() then
                    if SubjMaster2."Exam Schedule" then begin

                        MainStudentSubject.Reset();
                        MainStudentSubject.SETRANGE("Academic Year", ExamScheduleHead."Academic Year");
                        MainStudentSubject.SetRange(Term, ExamScheduleHead.Term);
                        MainStudentSubject.SETRANGE("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                        MainStudentSubject.SETRANGE("Course", CourseSubjectLine."Course Code");
                        MainStudentSubject.SETRANGE(Semester, CourseSubjectLine."Semester");

                        // if ExamScheduleHead."Global Dimension 1 Code" = '9100' then
                        // MainStudentSubject.SetRange("Subject Code", CourseSubjectLine."Subject Code")

                        // else
                        if ExamScheduleHead."Global Dimension 1 Code" = '9000' then begin
                            if CourseSubjectLine.Level = 2 then begin
                                SubjMaster.Reset();
                                SubjMaster.SetRange(Code, CourseSubjectLine."Subject Code");
                                SubjMaster.FindFirst();
                                Lvl1Subj := SubjMaster."Subject Group";
                                SubjMaster.Reset();
                                SubjMaster.SetRange(Code, Lvl1Subj);
                                SubjMaster.FindFirst();

                                MainStudentSubject.SetRange("Subject Code", SubjMaster.Code);
                            end
                            else
                                if CourseSubjectLine.Level = 3 then begin
                                    SubjMaster.Reset();
                                    SubjMaster.SetRange(Code, CourseSubjectLine."Subject Code");
                                    SubjMaster.FindFirst();
                                    Lvl1Subj := SubjMaster."Subject Group";
                                    SubjMaster.Reset();
                                    SubjMaster.SetRange(Code, Lvl1Subj);
                                    SubjMaster.FindFirst();
                                    Lvl1Subj := SubjMaster."Subject Group";
                                    SubjMaster.Reset();
                                    SubjMaster.SetRange(Code, Lvl1Subj);
                                    SubjMaster.FindFirst();
                                    MainStudentSubject.SetRange("Subject Code", SubjMaster.Code);
                                end;
                        end;
                        // else
                        //     Error('Institute Code must be 9000 or 9100');

                        // MainStudentSubject.SetRange(Graduation, CourseSubjectLine."Program");
                        MainStudentSubject.SetRange("Grade Confirmed", false);
                        If MainStudentSubject.FindFirst() then begin
                            MarksWeight.Reset();
                            MarksWeight.SetRange("Global Dimension 1 Code", ExamScheduleHead."Global Dimension 1 Code");
                            MarksWeight.SetRange("Academic Year", ExamScheduleHead."Academic year");
                            MarksWeight.SetRange("Course Code", MainStudentSubject.Course);
                            MarksWeight.SetRange(Semester, CourseSubjectLine.Semester);
                            //If ExamScheduleHead."Global Dimension 1 Code" = '9000' then
                            MarksWeight.SetRange("Exam Code", CourseSubjectLine."Subject Code");
                            // IF ExamScheduleHead."Global Dimension 1 Code" = '9100' then
                            //     MarksWeight.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                            //MarksWeight.SetRange(Term, CourseSubjectLine.Term);       08Aug2022
                            MarksWeight.SetRange(Term, ExamScheduleHead.Term);
                            //If ExamScheduleHead."Exam Code" <> 'NON NBME' then
                            // IF ExamScheduleHead."Exam Type" = ExamScheduleHead."Exam Type"::External then
                            //     MarksWeight.SetRange("Exam Selection", ExamScheduleHead."Exam Code");  //08Aug2022
                            IF MarksWeight.FindSet() then begin
                                repeat
                                    MarksWeight.TestField(Points);
                                    if CourseSubjectLine.Level = 2 then
                                        TotWeightage += MarksWeight.Points;
                                until MarksWeight.Next() = 0;

                            end;

                            MarksWeight.Reset();
                            MarksWeight.SetRange("Global Dimension 1 Code", ExamScheduleHead."Global Dimension 1 Code");
                            MarksWeight.SetRange("Academic Year", ExamScheduleHead."Academic year");
                            MarksWeight.SetRange("Course Code", MainStudentSubject.Course);
                            MarksWeight.SetRange(Semester, CourseSubjectLine.Semester);
                            //If ExamScheduleHead."Global Dimension 1 Code" = '9000' then
                            MarksWeight.SetRange("Exam Code", CourseSubjectLine."Subject Code");
                            // IF ExamScheduleHead."Global Dimension 1 Code" = '9100' then
                            //     MarksWeight.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                            //MarksWeight.SetRange(Term, CourseSubjectLine.Term);       08Aug2022
                            MarksWeight.SetRange(Term, ExamScheduleHead.Term);
                            //If ExamScheduleHead."Exam Code" <> 'NON NBME' then
                            MarksWeight.SetRange("Exam Selection", ExamScheduleHead."Exam Code");  //08Aug2022
                            IF MarksWeight.FindFirst() then begin
                                MarksWeight.TestField(Points);

                                // IF ExamScheduleHead."Global Dimension 1 Code" = '9000' then  //11Jan2021



                                //CourseSubjectLine.TestField(Year);
                                ExamScheduleLine.Reset();
                                ExamScheduleLine.SetRange("Course Code", CourseSubjectLine."Course Code");
                                ExamScheduleLine.SetRange("Semester Code", CourseSubjectLine.Semester);
                                ExamScheduleLine.SetRange("Academic Year", ExamScheduleHead."Academic Year");
                                ExamScheduleLine.SetRange(Term, ExamScheduleHead.Term);
                                ExamScheduleLine.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                                IF not ExamScheduleLine.FindFirst() then begin
                                    ExamScheduleLine.Init();
                                    ExamScheduleLine."Document No." := DocNo;
                                    ExamScheduleLine."Line No." := LineNo + 10000;
                                    ExamScheduleLine."Subject Code" := CourseSubjectLine."Subject Code";
                                    ExamScheduleLine."Subject Name" := CourseSubjectLine.Description;
                                    ExamScheduleLine."Subject Group" := CourseSubjectLine."Subject Group";
                                    ExamScheduleLine."Subject Type" := CourseSubjectLine."Subject Type";
                                    ExamScheduleLine."Subject Class" := CourseSubjectLine."Subject Classification";
                                    ExamScheduleLine."Course Code" := CourseSubjectLine."Course Code";
                                    ExamScheduleLine."Program" := CourseSubjectLine."Program";
                                    ExamScheduleLine."Semester Code" := CourseSubjectLine.Semester;
                                    ExamScheduleLine.Year := CourseSubjectLine.Year;
                                    //ExamScheduleLine.Batch := CourseSubjectLine."Applicable Batch";
                                    ExamScheduleLine."Examiner Type" := ExamScheduleHead."Exam Type";
                                    ExamScheduleLine."Academic Year" := ExamScheduleHead."Academic Year";
                                    ExamScheduleLine."Exam Classification" := ExamScheduleHead."Exam Classification";
                                    ExamScheduleLine."Global Dimension 1 Code" := ExamScheduleHead."Global Dimension 1 Code";
                                    ExamScheduleLine.Term := ExamScheduleHead.Term;
                                    ExamScheduleLine.Insert(true);
                                    LineNo := ExamScheduleLine."Line No.";
                                end;
                            end;
                        end;
                    end;
            Until CourseSubjectLine.Next() = 0;

        if ExtInt = 1 then begin
            if Sem."Total Weightage" > 0 then
                if Sem."Total Weightage" <> TotWeightage then
                    Error('External Total Weightage for Semester %1 is %2 which does not match with total Weightage %3 of Subjects in Course %4 Semester %5', Sem.Code, Sem."Total Weightage", TotWeightage, ExamScheduleHead."Course Code", ExamScheduleHead."Semester Code");
        end
        else
            if ExtInt = 2 then begin
                if Sem."Internal Total Weightage" > 0 then
                    if Sem."Internal Total Weightage" <> TotWeightage then
                        If ExamScheduleHead."Exam Code" <> 'NON NBME' then
                            Error('Internal Total Weightage for Semester %1 is %2 which does not match with total Weightage %3 of Subjects in Course %4 Semester %5', Sem.Code, Sem."Internal Total Weightage", TotWeightage, ExamScheduleHead."Course Code", ExamScheduleHead."Semester Code");
            end;
    end;

    /// <summary> 
    /// Description for StudentPromotionHeader.
    /// </summary>
    /// <param name="CurrentAcademicYear">Parameter of type Code[20].</param>
    /// <param name="NextAcademicYear">Parameter of type Code[20].</param>
    /// <param name="CurrentSemesterType">Parameter of type Option "FALL","SPRING".</param>
    /// <param name="NextSemesterType">Parameter of type Option "FALL","SPRING".</param>
    /// <param name="InstituteCode">Parameter of type Code[20].</param>
    procedure StudentPromotionHeader(CurrentAcademicYear: Code[20];
        NextAcademicYear: Code[20];
        CurrentSemesterType: Option "FALL","SPRING";
        NextSemesterType: Option "FALL","SPRING";
        InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        SemesterMaster: Record "Semester Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        PromotionHeaderCS: Record "Promotion Header-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        NextNo: Code[20];
    begin
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS.TestField(EducationSetupCS."Promotion No.");
        END ELSE
            ERROR('Education Setup Not Defined !!');

        SemesterMaster.Reset();
        SemesterMaster.SetRange("Global Dimension 1 Code", InstituteCode);
        If SemesterMaster.FindSet() then
            REPEAT
                StudentMasterCS.Reset();
                StudentMasterCS.SetRange("Global Dimension 1 Code", InstituteCode);
                StudentMasterCS.SetRange("Academic Year", CurrentAcademicYear);
                StudentMasterCS.SetRange(Semester, SemesterMaster.Code);
                If StudentMasterCS.FindFirst() then begin
                    NextNo := NoSeriesManagement.GetNextNo(EducationSetupCS."Promotion No.", 0D, TRUE);

                    PromotionHeaderCS.INIT();
                    PromotionHeaderCS."No." := NextNo;
                    PromotionHeaderCS.VALIDATE(Course, StudentMasterCS."Course Code");
                    PromotionHeaderCS."Academic Year" := CurrentAcademicYear;
                    PromotionHeaderCS."Next Academic Year" := NextAcademicYear;
                    PromotionHeaderCS.Term := CurrentSemesterType;
                    PromotionHeaderCS."Next Term" := NextSemesterType;
                    PromotionHeaderCS.Semester := StudentMasterCS.Semester;
                    PromotionHeaderCS.Year := StudentMasterCS.Year;
                    PromotionHeaderCS.Graduation := StudentMasterCS.Graduation;
                    PromotionHeaderCS."Created By" := FORMAT(UserId());
                    PromotionHeaderCS."Created On" := TODAY();
                    PromotionHeaderCS.INSERT();
                    GetStudentsPromotionLine(PromotionHeaderCS);
                end;
            UNTIL SemesterMaster.NEXT() = 0;
    END;

    /// <summary> 
    /// Description for GetStudentsPromotionLine.
    /// </summary>
    /// <param name="PromotionHeaderCS">Parameter of type Record "Promotion Header-CS".</param>
    procedure GetStudentsPromotionLine(PromotionHeaderCS: Record "Promotion Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        PromotionLineCS: Record "Promotion Line-CS";
        StudentPromotionLine1: Record "Promotion Line-CS";
        StudentStatusRec: Record "Student Status";
        GradeBook: Record "Grade Book";
        PromotionCriteria: Record "Promotion Criteria-CS";
        "LocalLineNo.": Integer;
        ShowMessage: Boolean;
        PreviousSemesterNo: Decimal;
        PreviousSemesterNo1: Decimal;
        AvailablePoints: Decimal;
        TotalAvailablePoints: Decimal;
        EarndCredit: Decimal;
        AdjustedTotal: Decimal;
    begin
        ShowMessage := false;
        "LocalLineNo." := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", Year, Section);
        StudentMasterCS.SETRANGE(Graduation, PromotionHeaderCS.Graduation);
        StudentMasterCS.SETRANGE("Global Dimension 1 Code", PromotionHeaderCS."Global Dimension 1 Code");
        StudentMasterCS.SETRANGE("Academic Year", PromotionHeaderCS."Academic Year");
        StudentMasterCS.SETRANGE("Course Code", PromotionHeaderCS.Course);
        StudentMasterCS.SETRANGE(Semester, PromotionHeaderCS.Semester);
        //  StudentMasterCS.SETRANGE(Year, PromotionHeaderCS.Year);
        StudentMasterCS.SetRange(Term, PromotionHeaderCS.Term);
        // StudentMasterCS.SETRANGE("Pending For Registration", FALSE);
        //StudentMasterCS.SETRANGE("Student Status", StudentMasterCS."Student Status"::Student);
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                if StudentStatusRec.Get(StudentMasterCS.Status, StudentMasterCS."Global Dimension 1 Code") then
                    if StudentStatusRec.Status = StudentStatusRec.Status::Active then begin

                        StudentPromotionLine1.RESET;
                        StudentPromotionLine1.SETRANGE("Document No.", PromotionHeaderCS."No.");
                        IF StudentPromotionLine1.FINDLAST THEN
                            "LocalLineNo." := StudentPromotionLine1."Line No." + 10000
                        ELSE
                            "LocalLineNo." := 10000;

                        PreviousSemesterNo1 := 0;
                        TotalAvailablePoints := 0;
                        AdjustedTotal := 0;
                        PromotionLineCS.INIT();
                        PromotionLineCS."Document No." := PromotionHeaderCS."No.";
                        PromotionLineCS."Line No." := "LocalLineNo.";
                        PromotionLineCS."Student No." := StudentMasterCS."No.";
                        PromotionLineCS."Enrollment No." := StudentMasterCS."Enrollment No.";
                        PromotionLineCS."Student Name" := StudentMasterCS."Student Name";
                        PromotionLineCS."Type Of Course" := PromotionHeaderCS."Type Of Course";
                        PromotionLineCS."Course Code" := StudentMasterCS."Course Code";
                        PromotionLineCS.Semester := StudentMasterCS.Semester;
                        PromotionLineCS.Section := StudentMasterCS.Section;
                        PromotionLineCS.Year := StudentMasterCS.Year;
                        PromotionLineCS."Graduation Code" := StudentMasterCS.Graduation;
                        PromotionLineCS."Department Code" := StudentMasterCS.Department;
                        PromotionLineCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                        PromotionLineCS."Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                        PromotionLineCS."Academic Year" := StudentMasterCS."Academic Year";
                        PromotionLineCS."Admitted Year" := StudentMasterCS."Admitted Year";
                        PromotionLineCS."Promoted Semester" := StudentMasterCS.Semester;
                        PromotionLineCS."Promoted Year" := StudentMasterCS.Year;
                        PromotionLineCS."Promoted  Academic Year" := StudentMasterCS."Academic Year";

                        // IF PromotionHeaderCS."Next Term" = PromotionHeaderCS."Next Term"::FALL Then begin
                        //     PromotionCriteria.Reset();
                        //     PromotionCriteria.SetRange(Year, PromotionHeaderCS.Semester);
                        //     PromotionCriteria.SetRange("Global Dimension 1 Code", PromotionHeaderCS."Global Dimension 1 Code");
                        //     IF PromotionCriteria.FindSet() then begin
                        //         GradeBook.Reset();
                        //         GradeBook.SetRange("Student No.", StudentMasterCS."No.");
                        //         GradeBook.SetRange(Semester, StudentMasterCS.Semester);
                        //         GradeBook.SetRange("Academic Year", StudentMasterCS."Academic Year");
                        //         GradeBook.SetRange("Global Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");
                        //         GradeBook.SetRange("Type of Input", GradeBook."Type of Input"::Best);
                        //         If GradeBook.FindLast() Then
                        //             EarndCredit := ((GradeBook."Earned Points" / GradeBook."Available Points") * PromotionCriteria."Passing Input Point %");
                        //     end;
                        //     PromotionLineCS."Earnd Percentage" := Round((EarndCredit / PromotionCriteria."Passing Input Point %") * 100, 0.01, '=');
                        // end Else begin
                        //     PromotionCriteria.Reset();
                        //     PromotionCriteria.SetRange(Year, PromotionHeaderCS.Year);
                        //     PromotionCriteria.SetRange("Global Dimension 1 Code", PromotionHeaderCS."Global Dimension 1 Code");
                        //     PromotionCriteria.CalcSums(PromotionCriteria."Adjusted Input Point %");
                        //     IF PromotionCriteria.FindSet() then
                        //         Repeat
                        //             IF PromotionCriteria."Adjusted Input Point %" <> 100 then
                        //                 Error('Adjusted Input Point % should be equal to 100 for Year %1 in Promotion Criteria', PromotionCriteria.Year);
                        //             PreviousSemesterNo := 0;
                        //             AvailablePoints := 0;
                        //             GradeBook.Reset();
                        //             GradeBook.SetRange("Student No.", StudentMasterCS."No.");
                        //             GradeBook.SetRange(Semester, PromotionCriteria.Semester);
                        //             GradeBook.SetRange("Academic Year", StudentMasterCS."Academic Year");
                        //             GradeBook.SetRange("Global Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");
                        //             GradeBook.SetRange("Type of Input", GradeBook."Type of Input"::Best);
                        //             If GradeBook.FindLast() Then begin
                        //                 EarndCredit := ((GradeBook."Earned Points" / GradeBook."Available Points") * PromotionCriteria."Passing Input Point %");

                        //                 IF PromotionCriteria."Adjusted Input Point %" <> 0 then begin
                        //                     PreviousSemesterNo := ((EarndCredit / PromotionCriteria."Passing Input Point %") * PromotionCriteria."Adjusted Input Point %");
                        //                     AvailablePoints := PromotionCriteria."Adjusted Input Point %";
                        //                 End else begin
                        //                     PreviousSemesterNo := EarndCredit;
                        //                     AvailablePoints := PromotionCriteria."Passing Input Point %";
                        //                 End;
                        //             end;
                        //             PreviousSemesterNo1 := PreviousSemesterNo1 + PreviousSemesterNo;
                        //             TotalAvailablePoints := TotalAvailablePoints + AvailablePoints;
                        //         Until PromotionCriteria.Next() = 0;
                        //     PromotionLineCS."Earnd Percentage" := Round((PreviousSemesterNo1 / TotalAvailablePoints) * 100, 0.01, '=');
                        // end;

                        PromotionLineCS."Created By" := FORMAT(UserId());
                        PromotionLineCS."Created On" := TODAY();
                        PromotionLineCS.INSERT();
                    end;
            UNTIL StudentMasterCS.NEXT() = 0;
    end;

    /// <summary> 
    /// Description for AcademicsPromotion.
    /// </summary>
    /// <param name="StudentPromotionHeader">Parameter of type Record "Promotion Header-CS".</param>
    procedure AcademicsPromotion(StudentPromotionHeader: Record "Promotion Header-CS")
    Var
        StudentPromotionLine: Record "Promotion Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        CourseSemMasterCS: Record "Course Sem. Master-CS";
        SemesterMaster: Record "Semester Master-CS";
        PromotionCriteria: Record "Promotion Criteria-CS";
        OptOut: Record "Opt Out";
        MainStudentSubject: Record "Main Student Subject-CS";
        StudStatus: Record "Student Status";
        StudStatusMgt: Codeunit "Student Status Mangement";
        SQNo: Integer;
        SQNo1: Integer;
        NextSemester: Code[20];
        PreviousSemester: Code[20];
        NextYear: Code[20];
        PreviousYear: Code[20];
        MinimumPer: Decimal;
        MaximumPer: Decimal;
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentHoldRec: Record "Student Hold";
        StudentStatusMangCod: Codeunit "Student Status Mangement";
        HousingMailCod: Codeunit "Hosusing Mail";
        LastNo: Integer;
        StudentTimeLine: Record "Student Time Line";
    begin
        CourseSemMasterCS.Reset();
        CourseSemMasterCS.SETCURRENTKEY("Semester Code");
        CourseSemMasterCS.SETRANGE("Course Code", StudentPromotionHeader."Course");
        CourseSemMasterCS.SETRANGE("Semester Code", StudentPromotionHeader.Semester);
        IF CourseSemMasterCS.FINDFIRST() THEN begin
            SQNo := CourseSemMasterCS."Sequence No" + 1;
            SQNo1 := CourseSemMasterCS."Sequence No" - 1;
        end;

        IF SQNo <> 0 Then begin
            CourseSemMasterCS.Reset();
            CourseSemMasterCS.SetRange("Sequence No", SQNo);
            IF CourseSemMasterCS.FindFirst() then
                NextSemester := CourseSemMasterCS."Semester Code";
        end;
        IF SQNo1 <> 0 Then begin
            CourseSemMasterCS.Reset();
            CourseSemMasterCS.SetRange("Sequence No", SQNo1);
            IF CourseSemMasterCS.FindFirst() then
                PreviousSemester := CourseSemMasterCS."Semester Code";
        end;

        SemesterMaster.Reset();
        SemesterMaster.SetRange(Code, NextSemester);
        IF SemesterMaster.FindFirst() then
            NextYear := SemesterMaster.Year;//arv

        SemesterMaster.Reset();
        SemesterMaster.SetRange(Code, PreviousSemester);
        IF SemesterMaster.FindFirst() then
            PreviousYear := SemesterMaster.Year;//arv

        StudentPromotionLine.Reset();
        StudentPromotionLine.SetRange("Document No.", StudentPromotionHeader."No.");
        IF StudentPromotionLine.FindSet() then
            repeat

                // MinimumPer := 0;
                // MaximumPer := 0;
                // PromotionCriteria.Reset();
                // PromotionCriteria.SetRange("Global Dimension 1 Code", StudentPromotionLine."Global Dimension 1 Code");
                // PromotionCriteria.SetRange(Semester, StudentPromotionLine.Semester);
                // PromotionCriteria.SetRange("Academic Year", StudentPromotionLine."Academic Year");
                // PromotionCriteria.SetRange("Admitted Year", StudentPromotionLine."Admitted Year");
                // IF PromotionCriteria.FindFirst() then begin
                //     MinimumPer := PromotionCriteria."Minimum Passing %";
                //     MaximumPer := PromotionCriteria."Maximum Passing %";
                // end;


                //IF StudentPromotionLine."Earnd Percentage" >= MaximumPer then begin
                //if TempStudentPromotion(StudentPromotionLine."Student No.") then begin
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentPromotionLine."Student No.");
                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                    StudentMasterCS.VALIDATE(Semester, NextSemester);
                    // StudentMasterCS.VALIDATE("Remaining Academic SAP", (StudentMasterCS."Remaining Academic SAP" - 1));
                    StudentMasterCS.VALIDATE(Year, NextYear);
                    StudentMasterCS.VALIDATE("Academic Year", StudentPromotionHeader."Next Academic Year");
                    StudentMasterCS.VALIDATE("OLR Completed", false);
                    StudentMasterCS.Validate("Registrar Signoff", false);
                    StudStatus.Reset();
                    StudStatus.GET(StudentMasterCS.Status, StudentMasterCS."Global Dimension 1 Code");
                    StudentMasterCS.VALIDATE(Status, StudStatusMgt.StudentSemPromotion(StudentMasterCS."No.", StudentMasterCS.Status, StudentMasterCS.Semester, StudentMasterCS."Global Dimension 1 Code"));
                    StudentMasterCS.Modify();
                    StudentTimeLine.InsertRecordFun(StudentMasterCS."No.", StudentMasterCS."Student Name", 'Student ' + StudentMasterCS."No." + ' has been promoted to ' + StudentMasterCS.Semester, UserId(), Today());
                    StudStatusMgt.EnableStudentWiseHold(StudentMasterCS);
                    //olr existing student email pending
                    HousingMailCod.ReturningStudentOnlineRegistrationEmail(StudentMasterCS."No.");

                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger."Student No." := StudentMasterCS."No.";
                    RecHoldStatusLedger."Student Name" := StudentMasterCS."Student Name";
                    RecHoldStatusLedger."Academic Year" := StudentMasterCS."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := StudentMasterCS."Admitted Year";
                    RecHoldStatusLedger.Semester := StudentMasterCS.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::"Registrar Sign-off";

                    StudentHoldRec.Reset();
                    StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");
                    StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::"Registrar Sign-off");
                    StudentHoldRec.FindFirst();

                    RecHoldStatusLedger."Hold Code" := StudentHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentHoldRec."Hold Description";
                    RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
                    RecHoldStatusLedger.Insert();
                    HousingMailCod.HousingAutomaticVacatebyStudentNo(StudentMasterCS."No.");

                END;

                StudentPromotionLine."Promoted Semester" := NextSemester;
                StudentPromotionLine."Promoted Year" := NextYear;
                StudentPromotionLine."Promoted  Academic Year" := StudentPromotionHeader."Next Academic Year";
                StudentPromotionLine."Student Promoted" := TRUE;
                StudentPromotionLine.Modify();
            //end;

            // IF (StudentPromotionLine."Earnd Percentage" < MaximumPer) AND (StudentPromotionLine."Earnd Percentage" > MinimumPer) then begin
            //     OptOut.Reset();
            //     OptOut.SetRange("Student No.", StudentPromotionLine."Student No.");
            //     OptOut.SetRange("Academic Year", StudentPromotionLine."Academic Year");
            //     OptOut.SetRange(Semester, StudentPromotionLine.Semester);
            //     OptOut.SetRange("Application Type", OptOut."Application Type"::"Repeat");
            //     OptOut.SetRange(Status, OptOut.Status::Submit);
            //     OptOut.SetRange("Application Used", false);
            //     IF Not OptOut.FindFirst() then begin
            //         StudentMasterCS.Reset();
            //         StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentPromotionLine."Student No.");
            //         IF StudentMasterCS.FINDFIRST() THEN BEGIN
            //             StudentMasterCS.VALIDATE(Semester, NextSemester);
            //             StudentMasterCS.VALIDATE("Remaining Academic SAP", (StudentMasterCS."Remaining Academic SAP" - 1));
            //             StudentMasterCS.VALIDATE(Year, NextYear);
            //             StudentMasterCS.VALIDATE("Academic Year", StudentPromotionHeader."Next Academic Year");
            //             StudentMasterCS.VALIDATE("Pending For Registration", TRUE);
            //             StudentMasterCS.Modify();
            //         END;

            //         StudentPromotionLine."Promoted Semester" := NextSemester;
            //         StudentPromotionLine."Promoted Year" := NextYear;
            //         StudentPromotionLine."Promoted  Academic Year" := StudentPromotionHeader."Next Academic Year";
            //         StudentPromotionLine."Student Promoted" := TRUE;
            //         StudentPromotionLine.Modify();
            //     end Else begin
            //         IF OptOut."Type Of Repeat" = OptOut."Type Of Repeat"::Semester Then begin
            //             StudentMasterCS.Reset();
            //             StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentPromotionLine."Student No.");
            //             IF StudentMasterCS.FINDFIRST() THEN BEGIN
            //                 StudentMasterCS.VALIDATE("Remaining Academic SAP", (StudentMasterCS."Remaining Academic SAP" - 1));
            //                 StudentMasterCS.VALIDATE("Pending For Registration", TRUE);
            //                 StudentMasterCS.Modify();
            //             END;
            //             StudentPromotionLine."Promoted Semester" := StudentMasterCS.Semester;
            //             StudentPromotionLine."Promoted Year" := StudentMasterCS.Year;
            //             StudentPromotionLine."Promoted  Academic Year" := StudentPromotionHeader."Next Academic Year";
            //             StudentPromotionLine."Type Of Repeat" := StudentPromotionLine."Type Of Repeat"::Semester;
            //             StudentPromotionLine."Student Promoted" := TRUE;
            //             StudentPromotionLine."Repeat Application No" := OptOut."Application No.";
            //             StudentPromotionLine.Modify();

            //             OptOut."Application Used" := true;
            //             OptOut.Modify();

            //     MainStudentSubject.Reset();
            //     MainStudentSubject.SetRange("Student No.", StudentMasterCS."No.");
            //     MainStudentSubject.SetRange(Semester, StudentMasterCS.Semester);
            //     MainStudentSubject.SetRange("Academic Year", StudentMasterCS."Academic Year");
            //     MainStudentSubject.SetRange("Global Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");
            //     IF MainStudentSubject.FindSet() then begin
            //         MainStudentSubject.ModifyAll(MainStudentSubject.Publish, false);
            //     end;

            // end;
            //             IF OptOut."Type Of Repeat" = OptOut."Type Of Repeat"::Year Then begin
            //                 StudentMasterCS.Reset();
            //                 StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentPromotionLine."Student No.");
            //                 IF StudentMasterCS.FINDFIRST() THEN BEGIN
            //                     StudentMasterCS.VALIDATE(Semester, PreviousSemester);
            //                     StudentMasterCS.VALIDATE("Remaining Academic SAP", (StudentMasterCS."Remaining Academic SAP" + 1));
            //                     StudentMasterCS.VALIDATE(Year, PreviousYear);
            //                     StudentMasterCS.VALIDATE("Academic Year", StudentPromotionHeader."Next Academic Year");
            //                     StudentMasterCS.VALIDATE("Pending For Registration", TRUE);
            //                     StudentMasterCS.Modify();
            //                 END;
            //                 StudentPromotionLine."Promoted Semester" := PreviousSemester;
            //                 StudentPromotionLine."Promoted Year" := PreviousYear;
            //                 StudentPromotionLine."Promoted  Academic Year" := StudentPromotionHeader."Next Academic Year";
            //                 StudentPromotionLine."Type Of Repeat" := StudentPromotionLine."Type Of Repeat"::Year;
            //                 StudentPromotionLine."Student Promoted" := TRUE;
            //                 StudentPromotionLine."Repeat Application No" := OptOut."Application No.";
            //                 StudentPromotionLine.Modify();

            //                 OptOut."Application Used" := true;
            //                 OptOut.Modify();

            //             end;
            //                 end;
            // end;
            // IF StudentPromotionLine."Earnd Percentage" < MinimumPer then begin
            //     StudentMasterCS.Reset();
            //     StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentPromotionLine."Student No.");
            //     IF StudentMasterCS.FINDFIRST() THEN BEGIN
            //         StudentMasterCS.VALIDATE("Remaining Academic SAP", (StudentMasterCS."Remaining Academic SAP" - 1));
            //         StudentMasterCS.VALIDATE("Student Status", StudentMasterCS."Student Status"::Inactive);
            //         StudentMasterCS.VALIDATE("Pending For Registration", TRUE);
            //         StudentMasterCS.Modify();
            //     END;
            //     StudentPromotionLine."Student Promoted" := TRUE;
            //     StudentPromotionLine.Modify();
            // end;
            Until StudentPromotionLine.Next() = 0;
    end;

    procedure TempStudentPromotion(StudNo: Code[20]): Boolean
    var
        StudStatus: Record "Student Master-CS";
        StudStatusMgt: Codeunit "Student Status Mangement";
    begin

        // StudStatusMgt.StudentSemPromotion()
    end;

    local procedure CheckSameSubjectWithOrWTGrp(pExamScheduleLine: Record "Exam Time Table Line-CS")
    var
        lvExamScheduleLine: Record "Exam Time Table Line-CS";
    begin

        lvExamScheduleLine.Reset();
        lvExamScheduleLine.SetRange("Document No.", pExamScheduleLine."Document No.");
        lvExamScheduleLine.SetFilter("Line No.", '<>%1', pExamScheduleLine."Line No.");
        lvExamScheduleLine.SetRange("Subject Code", pExamScheduleLine."Subject Code");
        if pExamScheduleLine."Student Group" <> '' then begin
            lvExamScheduleLine.SetRange("Student Group", '');
            if lvExamScheduleLine.FindFirst() then
                error('Same Subject Code in multiple lines must have "Student Group" filled in');
        end
        else
            if pExamScheduleLine."Student Group" = '' then begin
                lvExamScheduleLine.SetFilter("Student Group", '<>%1', '');
                if lvExamScheduleLine.FindFirst() then
                    error('Same Subject Code in multiple lines must have "Student Group" filled in');
            end;

        lvExamScheduleLine.Reset();
        lvExamScheduleLine.SetRange("Document No.", pExamScheduleLine."Document No.");
        lvExamScheduleLine.SetFilter("Line No.", '<>%1', pExamScheduleLine."Line No.");
        lvExamScheduleLine.SetRange("Subject Code", pExamScheduleLine."Subject Code");
        lvExamScheduleLine.SetRange("Student Group", pExamScheduleLine."Student Group");
        if lvExamScheduleLine.FindFirst() then
            error('Same Subject Code in multiple lines must have different "Student Group"');
    end;

    procedure RunningTotalCalcMapping()
    Var
        CourseSubjectLine: Record "Course Wise Subject Line-CS";
        CourseSubjectLine1: Record "Course Wise Subject Line-CS";
        RunningTotalMappingRec1: Record "Enquiry Type-CS";
        RunningTotalMappingRec: Record "Enquiry Type-CS";
        EducationSetup: Record "Education Setup-CS";
        SubjectMAster: Record "Subject Master-CS";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        DataCaptionField: Text;
        Int: Integer;
        TotalCnt: Integer;
        RunningTotalCnt: Integer;
        FieldInt: Integer;
    Begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        If EducationSetup.FindFirst() then;
        EducationSetup.TestField("Dummy No.");

        Int := 1;
        FieldInt := 12;
        CourseSubjectLine.Reset();
        CourseSubjectLine.SetCurrentKey("Course Code");
        CourseSubjectLine.SetFilter("Global Dimension 1 Code", '%1|%2', '9000', '9100');
        CourseSubjectLine.SetRange(Level, 2);
        CourseSubjectLine.SetFilter("Level Description", '%1|%2', CourseSubjectLine."Level Description"::"External Examination", CourseSubjectLine."Level Description"::"Internal Examination");
        If CourseSubjectLine.FindSet() then begin
            repeat
                SubjectMAster.Reset();
                SubjectMAster.SetRange(Code, CourseSubjectLine."Subject Code");
                SubjectMAster.FindFirst();

                RunningTotalMappingRec.Reset();
                RunningTotalMappingRec.Init();
                RunningTotalMappingRec.Code := NoSeriesMgmt.GetNextNo(EducationSetup."Dummy No.", Today(), true);
                RunningTotalMappingRec."Course Code" := CourseSubjectLine."Course Code";
                RunningTotalMappingRec."Semester Code" := CourseSubjectLine.Semester;
                RunningTotalMappingRec."Subject Code" := CourseSubjectLine."Subject Code";

                TotalCnt := 0;
                CourseSubjectLine1.Reset();
                CourseSubjectLine1.SetRange("Course Code", CourseSubjectLine."Course Code");
                CourseSubjectLine1.SetRange(Semester, CourseSubjectLine.Semester);
                CourseSubjectLine1.SetRange(Level, 2);
                CourseSubjectLine1.SetFilter("Level Description", '%1|%2', CourseSubjectLine1."Level Description"::"External Examination", CourseSubjectLine1."Level Description"::"Internal Examination");
                TotalCnt := CourseSubjectLine1.Count();
                RunningTotalMappingRec."Table ID" := 50019;
                RunningTotalMappingRec."Total Maximum" := SubjectMAster."Total Maximum";

                RunningTotalCnt := 0;

                If Int = 1 then begin
                    DataCaptionField := 'Field01';
                    RunningTotalMappingRec."Data Mapping Field" := DataCaptionField;
                    RunningTotalMappingRec."Field ID" := FieldInt;
                end;
                If Int <> 1 then begin
                    DataCaptionField := IncStr(DataCaptionField);
                    FieldInt += 1;
                    RunningTotalMappingRec."Data Mapping Field" := DataCaptionField;
                    RunningTotalMappingRec."Field ID" := FieldInt;
                end;
                If Int = TotalCnt then begin
                    Int := 1;
                    DataCaptionField := 'Field01';
                    FieldInt := 12;
                end;

                RunningTotalMappingRec.Insert();
                Int += 1;
                Commit();

                RunningTotalMappingRec1.Reset();
                RunningTotalMappingRec1.SetRange("Course Code", CourseSubjectLine."Course Code");
                RunningTotalMappingRec1.SetRange("Semester Code", CourseSubjectLine.Semester);
                RunningTotalCnt := RunningTotalMappingRec1.Count();
                If TotalCnt = RunningTotalCnt then begin
                    Int := 1;
                    FieldInt := 12;
                end;

            until CourseSubjectLine.Next() = 0;
        end;
    End;

    procedure RunningTotalCalcData(SemesterCode: Code[20]; AcaYEar: Code[20]; pTerm: Option FALL,SPRING,SUMMER; InstituteCode: Code[20])
    var
        RunningTotalCalcRec: Record "Discipline Level-CS";
        StudentMaster: Record "Student Master-CS";
        GradeBook: Record "Grade Book";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        StudentNoFilter: Text;
    Begin
        GradeBook.Reset();
        GradeBook.SetCurrentKey("Student No.");
        GradeBook.SetRange("Global Dimension 1 Code", InstituteCode);
        GradeBook.SetRange(Semester, SemesterCode);
        GradeBook.SetRange("Academic Year", AcaYEar);
        GradeBook.SetRange(Term, pTerm);
        IF GradeBook.FindSet() then begin
            repeat
                If StudentNoFilter <> GradeBook."Student No." then begin
                    StudentMaster.Reset();
                    StudentMaster.SetRange("No.", GradeBook."Student No.");
                    StudentMaster.FindFirst();

                    RunningTotalCalcRec.Reset();
                    RunningTotalCalcRec.SetRange("SLcM No.", GradeBook."Student No.");
                    RunningTotalCalcRec.SetRange("Academic Year", GradeBook."Academic Year");
                    RunningTotalCalcRec.SetRange(Semester, GradeBook.Semester);
                    RunningTotalCalcRec.SetRange(Term, pTerm);
                    IF Not RunningTotalCalcRec.FindFirst() then begin
                        RunningTotalCalcRec.Reset();
                        RunningTotalCalcRec.Init();
                        RunningTotalCalcRec.Code := NoSeriesMgmt.GetNextNo('RTC', Today(), true);
                        RunningTotalCalcRec."SLcM No." := GradeBook."Student No.";
                        RunningTotalCalcRec."Student ID" := StudentMaster."Original Student No.";
                        RunningTotalCalcRec."Last Name" := StudentMaster."Last Name";
                        RunningTotalCalcRec."First Name" := StudentMaster."First Name";
                        RunningTotalCalcRec."Enrollment No." := StudentMaster."Enrollment No.";
                        RunningTotalCalcRec."Course Code" := StudentMaster."Course Code";
                        RunningTotalCalcRec.Semester := GradeBook.Semester;
                        RunningTotalCalcRec."Academic Year" := GradeBook."Academic Year";
                        RunningTotalCalcRec.Term := GradeBook.Term;
                        RunningTotalCalcExamMarks(RunningTotalCalcRec);
                        RunningTotalCalcRec.Insert();
                        Commit();
                    end;
                    If RunningTotalCalcRec.FindFirst() then begin
                        RunningTotalCalcExamMarks(RunningTotalCalcRec);
                        RunningTotalCalcRec.Modify();
                    end;
                    StudentNoFilter := GradeBook."Student No.";
                end;
            Until GradeBook.Next() = 0;
        end;

        RunningTotalCalcRec.Reset();
        RunningTotalCalcRec.SetRange("SLcM No.", '');
        RunningTotalCalcRec.DeleteAll();
    End;

    procedure RunningTotalCalcExamMarks(Var RunningTotalCalcRec: Record "Discipline Level-CS")
    var
        GradeBook: Record "Grade Book";
        ObtainedValue: Array[12] of Decimal;
        Availablepoint: Array[12] of Decimal;
        StudentNoFilter: Text;
        Int: Integer;
        AvailablePointsSum: Decimal;
    Begin
        AvailablePointsSum := 0;
        Int := 1;
        GradeBook.Reset();
        GradeBook.SetCurrentKey("Student No.", "Exam Code");
        GradeBook.Setrange("Student No.", RunningTotalCalcRec."SLcM No.");
        GradeBook.SetRange(Semester, RunningTotalCalcRec.Semester);
        GradeBook.SetRange("Academic Year", RunningTotalCalcRec."Academic Year");
        GradeBook.SetRange(Term, RunningTotalCalcRec.Term);
        GradeBook.SetRange(Level, 2);
        GradeBook.CalcSums("Available Points");
        AvailablePointsSum := GradeBook."Available Points";
        IF GradeBook.FindSet() then begin
            repeat
                ObtainedValue[Int] := GradeBook."Percentage Obtained";
                Availablepoint[Int] := GradeBook."Available Points";
                RunningTotalCalcRec.Field01 := ObtainedValue[1];
                RunningTotalCalcRec.Field02 := ObtainedValue[2];
                RunningTotalCalcRec.Field03 := ObtainedValue[3];
                RunningTotalCalcRec.Field04 := ObtainedValue[4];
                RunningTotalCalcRec.Field05 := ObtainedValue[5];
                RunningTotalCalcRec.Field06 := ObtainedValue[6];
                RunningTotalCalcRec.Field07 := ObtainedValue[7];
                RunningTotalCalcRec.Field08 := ObtainedValue[8];
                RunningTotalCalcRec.Field09 := ObtainedValue[9];
                RunningTotalCalcRec.Field10 := ObtainedValue[10];
                RunningTotalCalcRec.Field11 := ObtainedValue[11];
                RunningTotalCalcRec.Field12 := ObtainedValue[12];
                RunningTotalCalcRec.Total := Round((((ObtainedValue[1] * Availablepoint[1] / 100) + (ObtainedValue[2] * Availablepoint[2] / 100) + (ObtainedValue[3] * Availablepoint[3] / 100) +
                                              (ObtainedValue[4] * Availablepoint[4] / 100) + (ObtainedValue[5] * Availablepoint[5] / 100) + (ObtainedValue[6] * Availablepoint[6] / 100) +
                                              (ObtainedValue[7] * Availablepoint[7] / 100) + (ObtainedValue[8] * Availablepoint[8] / 100) + (ObtainedValue[9] * Availablepoint[9] / 100) +
                                              (ObtainedValue[10] * Availablepoint[10] / 100) + (ObtainedValue[11] * Availablepoint[11] / 100) + (ObtainedValue[12] * Availablepoint[12] / 100)) / AvailablePointsSum) * 100);
                Int += 1;
            until GradeBook.Next() = 0;
        end;
    End;
}
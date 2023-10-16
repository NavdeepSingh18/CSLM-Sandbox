xmlport 50066 "Import Internal Scores"
{
    Caption = 'Import Internal Scores';
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement("Internal Exam Line-CS"; "Internal Exam Line-CS")
            {
                XmlName = 'StudentInternalMarks';
                textelement(EnrollmentNo)
                {
                }
                textelement(SubjectCode)
                {
                }
                textelement(InternalMark)
                {
                }
                textelement(ExamDate)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    Total1 := "Internal Exam Line-CS".Count;
                    WindowDialogBox.OPEN('Importing Internal Marks.....\' + Text001Lbl + Text002Lbl);

                    IF (Flag = TRUE) THEN
                        Flag := FALSE
                    ELSE BEGIN
                        if EnrollmentNo = '' then
                            Error('Enrollment No. must not be blank');
                        if SubjectCode = '' then
                            Error('Subject Code must not be blank');
                        Evaluate(InternalMarkDec, InternalMark);
                        if InternalMarkDec < 0 then
                            Error('Internal Marks must be more than 0');
                        if ExamDate = '' then
                            Error('Exam Date must not be blank');

                        Stud.Reset();
                        Stud.SetRange("Enrollment No.", EnrollmentNo);
                        Stud.FindFirst();

                        // key(Key1; "Course Code", Semester, "Academic Year", Year, "Subject Code", "Line No.")
                        CourseSubLn.Reset();
                        CourseSubLn.SetRange("Course Code", stud."Course Code");
                        CourseSubLn.SetRange(Semester, Stud.Semester);
                        CourseSubLn.SetRange("Academic Year", Stud."Academic Year");
                        // CourseSubLn.SetRange(Year, Stud.Year);
                        CourseSubLn.SetRange("Subject Code", SubjectCode);
                        CourseSubLn.SetRange(Term, Stud.Term);
                        if CourseSubLn.FindFirst() then begin
                            IntExamHdr2.Reset();
                            IntExamHdr2.SetCurrentKey("Course Code", "Academic Year", Year, Semester, Term, "Global Dimension 1 Code", "Subject Code");
                            IntExamHdr2.SetRange("Course Code", Stud."Course Code");
                            IntExamHdr2.SetRange("Academic Year", Stud."Academic Year");
                            IntExamHdr2.SetRange(Year, Stud.Year);
                            IntExamHdr2.SetRange(Semester, Stud.Semester);
                            IntExamHdr2.SetRange(Term, Stud.Term);
                            IntExamHdr2.SetRange("Global Dimension 1 Code", stud."Global Dimension 1 Code");
                            IntExamHdr2.SetRange("Subject Code", SubjectCode);
                            IntExamHdr2.setfilter(Status, '<>%1', IntExamHdr2.Status::Published);
                            if not IntExamHdr2.FindFirst() then begin
                                clear(IntExamHdr);
                                IntExamHdr.Reset();
                                IntExamHdr.Init();
                                IntExamHdr.Insert(True);
                                IntExamHdr.Validate("Course Code", Stud."Course Code");
                                IntExamHdr.Validate("Academic Year", Stud."Academic Year");
                                IntExamHdr.Validate(Year, Stud.Year);
                                IntExamHdr.Validate(Semester, Stud.Semester);
                                IntExamHdr.Validate(Term, Stud.Term);
                                IntExamHdr.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                                IntExamHdr.Validate("Subject Code", SubjectCode);
                                IntExamHdr.Status := IntExamHdr.Status::Released;
                                IntExamHdr.Modify(True);
                            end
                            else begin
                                IntExamHdr.Get(IntExamHdr2."No.");
                            end;
                            GradeInput.Reset();
                            //key(PK; "Global Dimension 1 Code", "Academic Year", "Admitted Year", 
                            //Semester, "Exam Code", "Type of Input", "Input Sequence")
                            GradeInput.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                            GradeInput.SetRange("Academic Year", Stud."Academic Year");
                            GradeInput.SetRange(Semester, Stud.Semester);
                            GradeInput.SetRange("Exam Code", SubjectCode);
                            if not GradeInput.FindFirst() then
                                Error('Grade Input Setup must be completed For Institute Code %1, Academic Year %2, Semester %3, Subject Code %4',
                                Stud."Global Dimension 1 Code", Stud."Academic Year", Stud.Semester, SubjectCode);
                            if GradeInput.FindFirst() then;
                            if GradeInput.Points <= 0 then
                                Error('Points must have value in Grade Input for Subject Code %1', SubjectCode);

                            IntExamLn2.Reset();
                            IntExamLn2.SetRange("Document No.", IntExamHdr."No.");
                            IntExamLn2.SetRange("Enrollment No.", Stud."Enrollment No.");
                            IntExamLn2.SetRange("Subject Code", SubjectCode);
                            if IntExamLn2.FindFirst() then begin
                                IntExamLn.Get(IntExamLn2."Document No.", IntExamLn2."Line No.");
                                IntExamLn.Validate("Maximum Internal  Marks", CourseSubLn."Internal Maximum");
                                IntExamLn."Obtained Internal Marks" := InternalMarkDec;
                                IntExamLn."Maximum Weightage" := GradeInput.Points;
                                IntExamLn."Obtained Weightage" := Round(((IntExamLn."Obtained Internal Marks" / IntExamLn."Maximum Internal  Marks") * IntExamLn."Maximum Weightage"), 0.02);
                                IntExamLn."Percentage Obtained" := ROund(((IntExamLn."Obtained Internal Marks" / IntExamLn."Maximum Internal  Marks") * 100), 0.02);

                                Evaluate(IntExamLn."Exam Date", ExamDate);
                                IntExamLn."Attendance Type" := IntExamLn."Attendance Type"::" ";
                                IntExamLn.Term := Stud.Term;
                                IntExamLn.Updated := TRUE;
                                IntExamLn.Modify();
                            end
                            else begin
                                IntExamLn.Reset();
                                IntExamLn.SetRange("Document No.", IntExamHdr."No.");
                                if IntExamLn.FindLast() then;
                                LineNo := IntExamLn."Line No." + 10000;

                                IntExamLn.Reset();
                                IntExamLn.Init();
                                IntExamLn.Validate("Document No.", IntExamHdr."No.");
                                IntExamLn.Validate("Line No.", LineNo);
                                IntExamLn.Validate("Student No.", Stud."No.");
                                IntExamLn.Validate("Maximum Internal  Marks", CourseSubLn."Internal Maximum");
                                IntExamLn.Validate("Maximum Weightage", GradeInput.Points);

                                IntExamLn."Obtained Internal Marks" := InternalMarkDec;
                                IntExamLn."Maximum Weightage" := GradeInput.Points;
                                IntExamLn."Obtained Weightage" := (IntExamLn."Obtained Internal Marks" / IntExamLn."Maximum Internal  Marks") * IntExamLn."Maximum Weightage";
                                IntExamLn."Percentage Obtained" := (IntExamLn."Obtained Internal Marks" / IntExamLn."Maximum Internal  Marks") * 100;
                                Evaluate(IntExamLn."Exam Date", ExamDate);
                                IntExamLn."Attendance Type" := IntExamLn."Attendance Type"::" ";
                                IntExamLn.Term := Stud.Term;
                                IntExamLn.Updated := TRUE;
                                IntExamLn.Insert();
                            end;
                        end
                        else
                            Error('Subject Code %1 is not mapped with Course Code %2; Semester %3; Academic Year %4',
                            SubjectCode, Stud."Course Code", Stud.Semester, Stud."Academic Year");
                    END;
                    CurrXMLport.SKIP();
                end;

                trigger OnAfterInsertRecord()
                begin
                    Count1 := Count1 + 1;
                    WindowDialogBox.UPDATE(1, Total1);
                    WindowDialogBox.UPDATE(2, Count1);
                end;

                trigger OnAfterInitRecord()
                begin
                    // if Flag then begin
                    //     Flag := false;
                    //     currXMLport.Skip();
                    // end;
                end;
            }
        }
    }
    trigger OnInitXmlPort()
    begin

    end;

    trigger OnPreXmlPort()
    begin
        Flag := true;
    end;

    trigger OnPostXmlPort()
    begin

        MESSAGE('Internal Marks Imported Sucessfully !');
    end;

    var
        GradeInput: Record "Grade Input";
        Stud: Record "Student Master-CS";
        CourseSubHdr: Record "Course Wise Subject Head-CS";
        CourseSubLn: Record "Course Wise Subject Line-CS";
        IntExamHdr: Record "Internal Exam Header-CS";
        IntExamHdr2: Record "Internal Exam Header-CS";
        IntExamLn: Record "Internal Exam Line-CS";
        IntExamLn2: Record "Internal Exam Line-CS";
        LineNo: Integer;
        Count1: Integer;
        Total1: Integer;
        Flag: Boolean;
        InternalMarkDec: Decimal;
        InternalObtainMarks: Decimal;
        WindowDialogBox: Dialog;
        Text001Lbl: Label 'Count    #########1########\';
        Text002Lbl: Label 'Importing    #########2########\';
}


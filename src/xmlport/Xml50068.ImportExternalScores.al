xmlport 50068 "Import External Scores"
{
    Caption = 'Import External Scores';
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement("External Exam Line-CS"; "External Exam Line-CS")
            {
                XmlName = 'StudentInternalMarks';
                textelement(EnrollmentNo)
                {
                }
                textelement(SubjectCode)
                {
                }
                textelement(ExternalMark)
                {
                }
                textelement(ExamDate)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    Total1 := "External Exam Line-CS".Count;
                    WindowDialogBox.OPEN('Importing External Marks.....\' + Text001Lbl + Text002Lbl);

                    IF (Flag = TRUE) THEN
                        Flag := FALSE
                    ELSE BEGIN
                        if EnrollmentNo = '' then
                            Error('Enrollment No. must not be blank');
                        if SubjectCode = '' then
                            Error('Subject Code must not be blank');
                        Evaluate(ExternalMarkDec, ExternalMark);
                        if ExternalMarkDec < 0 then
                            Error('External Marks must be more than 0');
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
                            ExtExamHdr2.Reset();
                            ExtExamHdr2.SetCurrentKey("Course Code", "Academic Year", Year, Semester, Term, "Global Dimension 1 Code", "Subject Code");
                            ExtExamHdr2.SetRange("Course Code", Stud."Course Code");
                            ExtExamHdr2.SetRange("Academic Year", Stud."Academic Year");
                            ExtExamHdr2.SetRange(Year, Stud.Year);
                            ExtExamHdr2.SetRange(Semester, Stud.Semester);
                            ExtExamHdr2.SetRange(Term, Stud.Term);
                            ExtExamHdr2.SetRange("Global Dimension 1 Code", stud."Global Dimension 1 Code");
                            ExtExamHdr2.SetRange("Subject Code", SubjectCode);
                            ExtExamHdr2.SetFilter(Status, '<>%1', ExtExamhdr2.status::Published);
                            if not ExtExamHdr2.FindFirst() then begin
                                clear(ExtExamHdr);
                                ExtExamHdr.Reset();
                                ExtExamHdr.Init();
                                ExtExamHdr.Insert(True);
                                ExtExamHdr.Validate("Course Code", Stud."Course Code");
                                ExtExamHdr.Validate("Academic Year", Stud."Academic Year");
                                ExtExamHdr.Validate(Year, Stud.Year);
                                ExtExamHdr.Validate(Semester, Stud.Semester);
                                ExtExamHdr.Validate(Term, Stud.Term);
                                ExtExamHdr.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                                ExtExamHdr.Validate("Subject Code", SubjectCode);
                                ExtExamHdr.Status := ExtExamHdr.Status::Released;
                                ExtExamHdr.Modify(True);
                            end
                            else begin
                                ExtExamHdr.Get(ExtExamHdr2."No.");
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

                            ExtExamLn2.Reset();
                            ExtExamLn2.SetRange("Document No.", ExtExamHdr."No.");
                            ExtExamLn2.SetRange("Enrollment No.", Stud."Enrollment No.");
                            ExtExamLn2.SetRange("Subject Code", SubjectCode);
                            if ExtExamLn2.FindFirst() then begin
                                ExtExamLn.Get(ExtExamLn2."Document No.", ExtExamLn2."Line No.");

                                ExtExamLn.Validate("External Mark", ExternalMarkDec);
                                ExtExamLn.Validate(Total, ExternalMarkDec);
                                ExtExamLn.Validate("Total Maximum", CourseSubLn."External Maximum");
                                ExtExamLn.Validate("Total Maximum", CourseSubLn."External Maximum");
                                ExtExamLn."Maximum Weightage" := GradeInput.Points;
                                ExtExamLn."Obtained Weightage" := (ExtExamLn."External Mark" / ExtExamLn."Total Maximum") * ExtExamLn."Maximum Weightage";
                                ExtExamLn."Percentage Obtained" := (ExtExamLn."External Mark" / ExtExamLn."Total Maximum") * 100;
                                Evaluate(ExtExamLn."Exam Date", ExamDate);
                                ExtExamLn."Attendance Type" := ExtExamLn."Attendance Type"::" ";
                                ExtExamLn.Term := Stud.Term;
                                ExtExamLn.Updated := TRUE;
                                ExtExamLn.Modify();
                            end
                            else begin
                                ExtExamLn.Reset();
                                ExtExamLn.SetRange("Document No.", ExtExamHdr."No.");
                                if ExtExamLn.FindLast() then;
                                LineNo := ExtExamLn."Line No." + 10000;

                                ExtExamLn.Reset();
                                ExtExamLn.Init();
                                ExtExamLn.Validate("Document No.", ExtExamHdr."No.");
                                ExtExamLn.Validate("Line No.", LineNo);
                                ExtExamLn.Validate("Student No.", Stud."No.");
                                ExtExamLn.Validate("Subject Code", SubjectCode);
                                ExtExamLn.Validate("Total Maximum", CourseSubLn."External Maximum");
                                ExtExamLn.Validate("External Mark", ExternalMarkDec);
                                ExtExamLn.Validate(Total, ExternalMarkDec);
                                ExtExamLn."Maximum Weightage" := GradeInput.Points;
                                ExtExamLn."Obtained Weightage" := (ExtExamLn."External Mark" / ExtExamLn."Total Maximum") * ExtExamLn."Maximum Weightage";
                                ExtExamLn."Percentage Obtained" := (ExtExamLn."External Mark" / ExtExamLn."Total Maximum") * 100;
                                Evaluate(ExtExamLn."Exam Date", ExamDate);
                                ExtExamLn."Attendance Type" := ExtExamLn."Attendance Type"::" ";
                                ExtExamLn.Term := Stud.Term;
                                ExtExamLn.Updated := TRUE;
                                ExtExamLn.Insert();
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

        MESSAGE('External Marks Imported Sucessfully !');
    end;

    var
        GradeInput: Record "Grade Input";
        Stud: Record "Student Master-CS";
        CourseSubHdr: Record "Course Wise Subject Head-CS";
        CourseSubLn: Record "Course Wise Subject Line-CS";
        ExtExamHdr: Record "External Exam Header-CS";
        ExtExamHdr2: Record "External Exam Header-CS";
        ExtExamLn: Record "External Exam Line-CS";
        ExtExamLn2: Record "External Exam Line-CS";
        LineNo: Integer;
        Count1: Integer;
        Total1: Integer;
        Flag: Boolean;
        ExternalMarkDec: Decimal;
        ExternalObtainMarks: Decimal;
        WindowDialogBox: Dialog;
        Text001Lbl: Label 'Count    #########1########\';
        Text002Lbl: Label 'Importing    #########2########\';
}


xmlport 50020 "Grade Book Header "
{
    Caption = 'Grade Book Header';
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement("Grade Book Header"; "Grade Book Header")
            {
                XmlName = 'StudentGradeBookHeader';

                textelement(StudentId)
                {
                }
                textelement(SubjectCode)
                {
                }
                textelement(Percentageobtained)
                {
                }
                textelement(Grade)
                {
                }
                trigger OnBeforeInsertRecord()
                Var
                    AcaSetup: Record "Academics Setup-CS";
                    GradeInput: Record "Marks Weightage";
                    NoSeries: Codeunit NoSeriesManagement;
                begin

                    Total1 := "Grade Book Header".Count;
                    WindowDialogBox.OPEN('Importing Grade Book.....\' + Text001Lbl + Text002Lbl);

                    IF (Flag = TRUE) THEN begin
                        Flag := FALSE;

                    end
                    ELSE BEGIN
                        AcaSetup.Get();
                        AcaSetup.TestField("Grade Book Nos.");
                        if StudentId = '' then
                            Error('Student Id must not be blank');
                        if SubjectCode = '' then
                            Error('Subject Code must not be blank');

                        Stud.Reset();
                        Stud.SetCurrentKey("Enrollment Order");
                        Stud.Ascending(true);
                        Stud.SetRange("Original Student No.", StudentId);
                        Stud.FindLast();

                        EduSetup.Reset();
                        EduSetup.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                        EduSetup.FindFirst();
                        // if Stud."Academic Year" <> EduSetup."Academic Year" then
                        //     Error('Enrollment No. %1 of Student Id %2 does not belong to the Academic Year %3 defined in the education Setup',
                        //     Stud."Enrollment No.", Stud."Original Student No.", EduSetup."Academic Year");
                        // if Stud.Term <> EduSetup."Even/Odd Semester" then
                        //     Error('Enrollment No. %1 of Student Id %2 does not belong to the Term %3 defined in the education Setup',
                        //     Stud."Enrollment No.", Stud."Original Student No.", EduSetup."Even/Odd Semester");

                        CourseSubLn.Reset();
                        CourseSubLn.SetRange("Course Code", Stud."Course Code");
                        CourseSubLn.SetRange(Semester, Stud.Semester);
                        CourseSubLn.SetRange("Subject Code", SubjectCode);
                        if CourseSubLn.FindFirst() then begin
                            GradeHd2.Reset();
                            GradeHd2.SetCurrentKey(Course, Semester, "Academic Year", Term, "Global Dimension 1 Code");
                            GradeHd2.SetRange(Course, Stud."Course Code");
                            GradeHd2.SetRange(Semester, Stud.Semester);
                            GradeHd2.SetRange("Academic Year", Stud."Academic Year");
                            GradeHd2.SetRange(Term, Stud.Term);
                            GradeHd2.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                            if GradeHd2.FindFirst() then begin
                                if GradeHd2.Status = GradeHd2.Status::Published then
                                    Error('Examination Header No. %1 is already Published, its Status should be Open or Released in order to upload', GradeHd2."Document No.");
                                GradeHdr.Get(GradeHd2."Document No.");
                            end
                            else begin
                                clear(GradeHdr);
                                GradeHdr.Reset();
                                GradeHdr.Init();
                                GradeHdr."Document No." := NoSeries.GetNextNo(AcaSetup."Grade Book Nos.", 0D, TRUE);
                                GradeHdr.Insert(True);
                                GradeHdr.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                                GradeHdr.Validate("Academic Year", Stud."Academic Year");
                                GradeHdr.Validate(Term, Stud.Term);
                                GradeHdr.Validate(Course, Stud."Course Code");
                                GradeHdr.Validate(Semester, Stud.Semester);
                                GradeHdr.Status := GradeHdr.Status::Open;
                                GradeHdr."Created By" := FORMAT(UserId());
                                GradeHdr."Created On" := TODAY();
                                GradeHdr.Modify(True);


                            end;
                            IntExamLn.Reset();
                            IntExamLn.SetRange("Grade Book No.", GradeHdr."Document No.");
                            IntExamLn.SetRange("Student No.", Stud."No.");
                            IntExamLn.SetRange("Exam Code", SubjectCode);
                            IF not IntExamLn.FindFirst() then begin
                                IntExamLn1.Reset();
                                IntExamLn1.SetRange("Document No.", GradeHdr."Document No.");
                                if IntExamLn1.FindLast() then
                                    LineNo := IntExamLn1."Entry No." + 10000
                                Else
                                    LineNo := 10000;

                                IntExamLn.Reset();
                                IntExamLn.Init();
                                IntExamLn.Validate("Entry No.", LineNo);
                                IntExamLn.Validate("Student No.", StudentId);
                                IntExamLn.Validate("Document No.", GradeHdr."Document No.");
                                IntExamLn."Grade Book No." := GradeHdr."Document No.";
                                IntExamLn.Insert();
                                IntExamLn.Validate(IntExamLn.Grade, Grade);
                                IF Percentageobtained <> '' Then
                                    evaluate(Per, Percentageobtained);
                                IntExamLn.Validate("Percentage Obtained", Per);
                                IntExamLn.Validate("Exam Code", SubjectCode);
                                GradeInput.Reset();
                                GradeInput.SetRange("Global Dimension 1 Code", GradeHdr."Global Dimension 1 Code");
                                GradeInput.SetRange("Exam Code", SubjectCode);
                                GradeInput.SetRange("Academic Year", GradeHdr."Academic year");
                                GradeInput.SetRange("Course Code", GradeHdr.Course);
                                GradeInput.SetRange(Semester, GradeHdr.Semester);
                                GradeInput.SetRange(Term, GradeHdr.Term);
                                GradeInput.FindFirst();
                                IntExamLn."Earned Points" := Round(((Per / 100) * GradeInput.Points), 0.01, '=');
                                IntExamLn."Available Points" := GradeInput.Points;
                                IntExamLn."Earned Points Percentage" := Round((IntExamLn."Earned Points" / GradeInput.Points) * 100, 0.01, '=');
                                //IntExamLn.Validate("Student No.", Stud."No.");
                                IntExamLn.Level := CourseSubLn.Level;
                                IntExamLn.Modify();
                            end;
                        end
                        else
                            Error('Subject Code %1 is not mapped with Course Code %2; Semester %3',
                            SubjectCode, Stud."Course Code", Stud.Semester);
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

        MESSAGE('Grade Book Imported Sucessfully !');
    end;

    var
        EduSetup: Record "Education Setup-CS";
        Stud: Record "Student Master-CS";
        CourseSubHdr: Record "Course Wise Subject Head-CS";
        CourseSubLn: Record "Course Wise Subject Line-CS";
        GradeHdr: Record "Grade Book Header";
        GradeHd2: Record "Grade Book Header";
        IntExamLn: Record "Grade Book";
        IntExamLn1: Record "Grade Book";
        IntExamLn2: Record "Grade Book";
        SubjectMaster: Record "Subject Master-CS";
        StudentSubject: Record "Main Student Subject-CS";
        Lvl1Subj: Code[20];
        LineNo: Integer;
        Count1: Integer;
        Total1: Integer;
        Flag: Boolean;
        InternalMarkDec: Decimal;
        InternalObtainMarks: Decimal;
        WindowDialogBox: Dialog;
        Text001Lbl: Label 'Count    #########1########\';
        Text002Lbl: Label 'Importing    #########2########\';
        ExamClass: Text[20];
        ExamDateDt: Date;
        Per: decimal;
}


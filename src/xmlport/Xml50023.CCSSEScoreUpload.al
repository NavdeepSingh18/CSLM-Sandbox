xmlport 50023 CCSSEScoreUpload
{
    Caption = 'CCSSEScoreUpload';
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    schema
    {
        textelement(Root)
        {
            tableelement("Student Subject Exam"; "Student Subject Exam")
            {
                xmlName = 'CCSSEScoreUpload';
                textelement(StudentID)
                {

                }
                textelement(SubjectDesc)
                {

                }
                textelement(Examdate)
                {

                }

                trigger OnBeforeInsertRecord()
                begin
                    IF (Flag = TRUE) THEN
                        Flag := FALSE
                    ELSE BEGIN
                        IF StudentID = '' then
                            Error('Student ID must have a value');

                        If SubjectDesc = '' then
                            Error('Subject Description must have a value');

                        If StudentID <> '' then begin
                            StudentMAster.Reset();
                            StudentMAster.SetCurrentKey("Enrollment Order");
                            StudentMAster.SetRange("Original Student No.", StudentID);
                            IF StudentMAster.FindLast() then begin
                                SubjectCode := '';
                                SubjectMAster.Reset();
                                SubjectMAster.SetRange("CCSSE Exam Description", SubjectDesc);
                                IF SubjectMAster.FindFirst() then
                                    SubjectCode := SubjectMaster.Code;


                                StudentSubjectExamRec.Reset();
                                StudentSubjectExamRec.SetCurrentKey("Line No.");
                                StudentSubjectExamRec.SetRange("Student No.", StudentMAster."No.");
                                StudentSubjectExamRec.SetFilter("Line No.", '<>%1', 0);
                                if StudentSubjectExamRec.FindLast() then
                                    LineNo := StudentSubjectExamRec."Line No." + 10
                                Else
                                    LineNo := 10;

                                StudentSubjectExamRec.Reset();
                                StudentSubjectExamRec.SetRange("Student No.", StudentMAster."No.");
                                StudentSubjectExamRec.SetRange("Score Type", StudentSubjectExamRec."Score Type"::CCSSE);
                                StudentSubjectExamRec.SetRange("Core Clerkship Subject Code", SubjectCode);
                                if StudentSubjectExamRec.FindLast() then begin
                                    SubjectMaster.Reset();
                                    SubjectMaster.SetRange(Code, StudentSubjectExamRec."Subject Code");
                                    if SubjectMaster.FindFirst() then
                                        ExamSeq := SubjectMaster."Exam Sequence" + 1;

                                    SubjectMasterRec1.Reset();
                                    SubjectMasterRec1.SetRange("Score type", SubjectMasterRec1."Score type"::CCSSE);
                                    SubjectMasterRec1.SetRange("Exam Sequence", ExamSeq);
                                    SubjectMasterRec1.FindFirst();

                                    SittingDate := 0D;
                                    If Examdate <> '' then
                                        Evaluate(SittingDate, Examdate);
                                    StudentSubjectExamRec1.Reset();
                                    StudentSubjectExamRec1.SetRange("Student No.", StudentMAster."No.");
                                    // StudentSubjectExamRec1.SetRange("Subject Code", SubjectMasterRec1.Code);
                                    StudentSubjectExamRec1.SetRange("Sitting Date", SittingDate);
                                    If StudentSubjectExamRec1.FindFirst() then
                                        Error('Student already given an Exam on this Exam Date : %1', SittingDate);

                                    StudentSubjectExamRec.INIT();
                                    StudentSubjectExamRec.Validate("Student No.", StudentMaster."No.");
                                    StudentSubjectExamRec.Validate("Subject Code", SubjectMasterRec1.Code);
                                    StudentSubjectExamRec."Line No." := LineNo;

                                    StudentSubjectExamRec.Validate(Semester, StudentMaster.Semester);
                                    StudentSubjectExamRec.Course := StudentMaster."Course Code";
                                    StudentSubjectExamRec."Original Student No." := StudentMaster."Original Student No.";

                                    // StudentSubjectExamRec."Sitting Date" := 0D;
                                    If Examdate <> '' then
                                        Evaluate(StudentSubjectExamRec."Sitting Date", Examdate);
                                    StudentSubjectExamRec.Validate("Core Clerkship Subject Code", SubjectCode);
                                    StudentSubjectExamRec."Academic Year" := StudentMaster."Academic Year";
                                    StudentSubjectExamRec."Score Type" := StudentSubjectExamRec."Score Type"::CCSSE;

                                    StudentSubjectExamRec.Validate("Shelf Exam Value", 0);

                                    StudentSubjectExamRec.Term := StudentMaster.Term;
                                    StudentSubjectExamRec.Year := StudentMaster.Year;
                                    StudentSubjectExamRec.Published := True;

                                    CourseSemesterMasterRec.Reset();
                                    CourseSemesterMasterRec.SetRange("Course Code", StudentMaster."Course Code");
                                    CourseSemesterMasterRec.SetRange("Academic Year", StudentMaster."Academic Year");
                                    CourseSemesterMasterRec.SetRange(Term, StudentMaster.Term);
                                    CourseSemesterMasterRec.SetRange("Semester Code", StudentMaster.Semester);
                                    IF CourseSemesterMasterRec.FindFirst() then begin
                                        StudentSubjectExamRec."Start Date" := CourseSemesterMasterRec."Start Date";
                                        StudentSubjectExamRec."End Date" := CourseSemesterMasterRec."End Date";
                                    end;
                                    StudentSubjectExamRec.Insert(True);
                                end Else begin
                                    SubjectMaster.Reset();
                                    SubjectMaster.SetRange(Code, 'CCSSE1');
                                    if SubjectMaster.FindFirst() then
                                        ExamSeq := SubjectMaster."Exam Sequence";

                                    SubjectMasterRec1.Reset();
                                    SubjectMasterRec1.SetRange("Score type", SubjectMasterRec1."Score type"::CCSSE);
                                    SubjectMasterRec1.SetRange("Exam Sequence", ExamSeq);
                                    SubjectMasterRec1.FindFirst();

                                    SittingDate := 0D;
                                    If Examdate <> '' then
                                        Evaluate(SittingDate, Examdate);
                                    StudentSubjectExamRec1.Reset();
                                    StudentSubjectExamRec1.SetRange("Student No.", StudentMAster."No.");
                                    // StudentSubjectExamRec1.SetRange("Subject Code", SubjectMasterRec1.Code);
                                    StudentSubjectExamRec1.SetRange("Sitting Date", SittingDate);
                                    If StudentSubjectExamRec1.FindFirst() then
                                        Error('Student already given an Exam on this Exam Date : %1', SittingDate);

                                    StudentSubjectExamRec.INIT();
                                    StudentSubjectExamRec.Validate("Student No.", StudentMaster."No.");
                                    StudentSubjectExamRec.Validate("Subject Code", SubjectMasterRec1.Code);
                                    StudentSubjectExamRec."Line No." := LineNo;

                                    StudentSubjectExamRec.Validate(Semester, StudentMaster.Semester);
                                    StudentSubjectExamRec.Course := StudentMaster."Course Code";
                                    StudentSubjectExamRec."Original Student No." := StudentMaster."Original Student No.";

                                    // StudentSubjectExamRec."Sitting Date" := 0D;
                                    If Examdate <> '' then
                                        Evaluate(StudentSubjectExamRec."Sitting Date", Examdate);
                                    StudentSubjectExamRec.Validate("Core Clerkship Subject Code", SubjectCode);
                                    StudentSubjectExamRec."Academic Year" := StudentMaster."Academic Year";
                                    StudentSubjectExamRec."Score Type" := StudentSubjectExamRec."Score Type"::CCSSE;

                                    StudentSubjectExamRec.Validate("Shelf Exam Value", 0);

                                    StudentSubjectExamRec.Term := StudentMaster.Term;
                                    StudentSubjectExamRec.Year := StudentMaster.Year;
                                    StudentSubjectExamRec.Published := True;

                                    CourseSemesterMasterRec.Reset();
                                    CourseSemesterMasterRec.SetRange("Course Code", StudentMaster."Course Code");
                                    CourseSemesterMasterRec.SetRange("Academic Year", StudentMaster."Academic Year");
                                    CourseSemesterMasterRec.SetRange(Term, StudentMaster.Term);
                                    CourseSemesterMasterRec.SetRange("Semester Code", StudentMaster.Semester);
                                    IF CourseSemesterMasterRec.FindFirst() then begin
                                        StudentSubjectExamRec."Start Date" := CourseSemesterMasterRec."Start Date";
                                        StudentSubjectExamRec."End Date" := CourseSemesterMasterRec."End Date";
                                    end;
                                    StudentSubjectExamRec.Insert(True);
                                end;
                            end;
                        end;
                    end;



                    currXMLport.Skip();
                end;

            }
        }
    }


    var
        StudentMAster: Record "Student Master-CS";
        StudentSubjectExamRec: Record "Student Subject Exam";
        StudentSubjectExamRec1: Record "Student Subject Exam";
        SubjectMaster: Record "Subject Master-CS";
        SubjectMasterRec1: Record "Subject Master-CS";
        CourseSemesterMasterRec: REcord "Course Sem. Master-CS";
        Flag: Boolean;
        LineNo: Integer;
        SubjectCode: Code[20];
        ExamSeq: Integer;
        SittingDate: Date;

    trigger OnInitXmlPort()
    begin
        Flag := true;
    end;

    trigger OnPostXmlPort()
    begin
        Message('CCSSE Scores upload successfully.');
    end;
}
codeunit 50013 "Action Hall Ticket-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   18/02/2019     GetSubject()-Function                Code added for get student.
    // 02    CSPL-00059   18/02/2019     CreateSubject()-Function             Code added for create subject Line .
    // 03    CSPL-00059   18/02/2019     DeldmitCard()-Function               Code added for delete admit card.
    // 04    CSPL-00059   18/02/2019     PaidExamFee()-Function               Code added for paid exam fee.


    trigger OnRun()
    begin
    end;

    var
        Text001Lbl: Label 'You Can Not Delete the Regular Subject', Comment = 'Foo', MaxLength = 999, Locked = true;
        Text002Lbl: Label 'Exam Fee Amount is Zero', Comment = 'Foo', MaxLength = 999, Locked = true;
        Text003Lbl: Label 'Fees Already Generated for this Student', Comment = 'Foo', MaxLength = 999, Locked = true;
        Text004Lbl: Label 'Fees Generated', Comment = 'Foo', MaxLength = 999, Locked = true;
        Text005Lbl: Label 'Do you want to update the subjects ?', Comment = 'Foo', MaxLength = 999, Locked = true;
        Text006Lbl: Label 'Do you Pay the fee ?', Comment = 'Foo', MaxLength = 999, Locked = true;
        Text_10001Lbl: Label 'Student No. %1  Is Not A Valid Student !!', Comment = 'Foo', MaxLength = 999, Locked = true;

    procedure GetSubject(AdmitCardHeaderCS: Record "Admit Card Header-CS")
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";

        StudentMasterCS: Record "Student Master-CS";

        AdmitCardLineCS: Record "Admit Card Line-CS";
        // CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        IntSubjectCount: Integer;

        "LocalLineNo.": Integer;

    begin
        //Code added for get student::CSPL-00059::18022019: Start

        IF NOT CONFIRM(Text005Lbl, FALSE) THEN
            EXIT;

        AdmitCardLineCS.Reset();
        AdmitCardLineCS.SETRANGE("Document No.", AdmitCardHeaderCS."No.");
        IF NOT AdmitCardLineCS.FINDFIRST() THEN
            StudentMasterCS.GET(AdmitCardHeaderCS."Student No.");
        IF StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::Student THEN BEGIN

            IntSubjectCount := 0;
            "LocalLineNo." := 0;
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETCURRENTKEY("Student No.", Semester, Section);
            MainStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
            MainStudentSubjectCS.SETRANGE(Semester, StudentMasterCS.Semester);
            MainStudentSubjectCS.SETRANGE(Section, StudentMasterCS.Section);
            MainStudentSubjectCS.SETRANGE("Academic Year", StudentMasterCS."Academic Year");
            IF MainStudentSubjectCS.FINDSET() THEN
                REPEAT
                    "LocalLineNo." += 10000;
                    AdmitCardLineCS.INIT();
                    AdmitCardLineCS."Document No." := AdmitCardHeaderCS."No.";
                    AdmitCardLineCS."Student No." := MainStudentSubjectCS."Student No.";
                    AdmitCardLineCS.Course := MainStudentSubjectCS.Course;
                    AdmitCardLineCS.Semester := MainStudentSubjectCS.Semester;
                    AdmitCardLineCS."Subject Type" := MainStudentSubjectCS."Subject Type";
                    AdmitCardLineCS."Subject Code" := MainStudentSubjectCS."Subject Code";
                    AdmitCardLineCS.Section := MainStudentSubjectCS.Section;
                    AdmitCardLineCS."Subject Description" := MainStudentSubjectCS.Description;
                    AdmitCardLineCS."Apply Type" := AdmitCardLineCS."Apply Type"::Regular;
                    AdmitCardLineCS."Academic Year" := AdmitCardHeaderCS."Academic Year";
                    AdmitCardLineCS.INSERT();
                UNTIL MainStudentSubjectCS.NEXT() = 0;

            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETCURRENTKEY("Student No.", Semester, Result);
            MainStudentSubjectCS.SETRANGE("Student No.", AdmitCardHeaderCS."Student No.");
            MainStudentSubjectCS.SETFILTER(Semester, '<>%1', AdmitCardHeaderCS.Semester);
            MainStudentSubjectCS.SETRANGE(Result, MainStudentSubjectCS.Result::Fail);
            IF MainStudentSubjectCS.FINDSET() THEN
                REPEAT
                    "LocalLineNo." += 10000;
                    AdmitCardLineCS.INIT();
                    AdmitCardLineCS."Document No." := AdmitCardHeaderCS."No.";
                    AdmitCardLineCS."Student No." := MainStudentSubjectCS."Student No.";
                    AdmitCardLineCS.Course := MainStudentSubjectCS.Course;
                    AdmitCardLineCS.Semester := MainStudentSubjectCS.Semester;
                    AdmitCardLineCS."Subject Type" := MainStudentSubjectCS."Subject Type";
                    AdmitCardLineCS."Subject Code" := MainStudentSubjectCS."Subject Code";
                    AdmitCardLineCS.Section := MainStudentSubjectCS.Section;
                    AdmitCardLineCS."Subject Description" := MainStudentSubjectCS.Description;
                    AdmitCardLineCS."Apply Type" := AdmitCardLineCS."Apply Type"::"Re-Registration";
                    AdmitCardLineCS."Academic Year" := AdmitCardHeaderCS."Academic Year";
                UNTIL MainStudentSubjectCS.NEXT() = 0;
        END ELSE
            ERROR(Text_10001Lbl, AdmitCardHeaderCS."Student No.");

        //Code added for get student::CSPL-00059::18022019: End
    end;

    procedure CreateSubject(getProgrm: Code[20]; getSem: Code[10]; GetSec: Code[10]; Session: Code[10])
    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        AdmitCardHeaderCS: Record "Admit Card Header-CS";
        StudentMasterCS: Record "Student Master-CS";

        AdmitCardHeaderCS1: Record "Admit Card Header-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        "No.seriesManagement": Codeunit NoSeriesManagement;
        "DocuNo.": Code[20];
        UpdateBool: Boolean;
    begin
        //Code added for create subject line::CSPL-00059::18022019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Hall Ticket Entry No.");
        "DocuNo." := '';
        UpdateBool := TRUE;
        StudentMasterCS.Reset();
        StudentMasterCS.SETCURRENTKEY("Course Code", Semester, "Academic Year");
        StudentMasterCS.SETRANGE("Course Code", getProgrm);
        StudentMasterCS.SETRANGE(Semester, getSem);
        StudentMasterCS.SETRANGE(Section, GetSec);
        StudentMasterCS.SETRANGE("Student Status", StudentMasterCS."Student Status"::Student);
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                AdmitCardHeaderCS.Reset();
                AdmitCardHeaderCS.SETCURRENTKEY("Student No.", "Course Code", Semester, Section, "Academic Year");
                AdmitCardHeaderCS.SETRANGE("Student No.", StudentMasterCS."No.");
                AdmitCardHeaderCS.SETRANGE("Course Code", getProgrm);
                AdmitCardHeaderCS.SETRANGE(Semester, getSem);
                AdmitCardHeaderCS.SETRANGE(Section, GetSec);
                AdmitCardHeaderCS.SETRANGE("Academic Year", Session);
                AdmitCardHeaderCS.SETRANGE("Result Generated", FALSE);
                IF AdmitCardHeaderCS.ISEMPTY() then BEGIN
                    "DocuNo." := "No.seriesManagement".GetNextNo(AcademicsSetupCS."Hall Ticket Entry No.", 0D, TRUE);
                    AdmitCardHeaderCS1.Reset();
                    AdmitCardHeaderCS1.INIT();
                    AdmitCardHeaderCS1."No." := "DocuNo.";
                    AdmitCardHeaderCS1."Student No." := StudentMasterCS."No.";
                    AdmitCardHeaderCS1."Student Name" := StudentMasterCS."Student Name";
                    AdmitCardHeaderCS1."Course Code" := StudentMasterCS."Course Code";
                    AdmitCardHeaderCS1.Semester := StudentMasterCS.Semester;
                    AdmitCardHeaderCS1."Academic Year" := Session;
                    AdmitCardHeaderCS1.Section := StudentMasterCS.Section;
                    AdmitCardHeaderCS1.INSERT();
                END ELSE BEGIN
                    AdmitCardHeaderCS.FINDFIRST();
                    AdmitCardLineCS.Reset();
                    AdmitCardLineCS.SETRANGE("Document No.", AdmitCardHeaderCS."No.");
                    IF AdmitCardLineCS.FINDFIRST() AND UpdateBool THEN BEGIN
                        IF CONFIRM(Text005Lbl, FALSE) THEN
                            AdmitCardLineCS.DELETEALL()
                        ELSE
                            EXIT;
                        UpdateBool := FALSE;
                    END ELSE
                        AdmitCardLineCS.DELETEALL();
                    "DocuNo." := AdmitCardHeaderCS."No.";
                END;
                GetSubject(AdmitCardHeaderCS1);
            UNTIL StudentMasterCS.NEXT() = 0;
        //Code added for create subject line::CSPL-00059::18022019: End
    end;

    procedure DeldmitCard(DocN: Code[20]; LineNo: Integer)
    var
        AdmitCardHeaderCS: Record "Admit Card Header-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";

    begin
        //Code added for delete admit card::CSPL-00059::18022019: Start

        AdmitCardHeaderCS.GET(DocN);
        AdmitCardLineCS.Reset();
        IF AdmitCardLineCS.GET(DocN, LineNo) THEN BEGIN
            IF AdmitCardLineCS."Apply Type" = AdmitCardLineCS."Apply Type"::Regular THEN
                ERROR(Text001Lbl);
            CourseWiseSubjectLineCS.Reset();
            CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Type", "Subject Code");
            CourseWiseSubjectLineCS.SETRANGE("Course Code", AdmitCardHeaderCS."Course Code");
            CourseWiseSubjectLineCS.SETRANGE(Semester, AdmitCardHeaderCS.Semester);
            CourseWiseSubjectLineCS.SETRANGE("Subject Type", AdmitCardLineCS."Subject Type");
            CourseWiseSubjectLineCS.SETRANGE("Subject Code", AdmitCardLineCS."Subject Code");
            IF CourseWiseSubjectLineCS.FINDFIRST() THEN BEGIN
                AdmitCardHeaderCS."Exam Fee Total Amount" :=
                  AdmitCardHeaderCS."Exam Fee Total Amount" - CourseWiseSubjectLineCS."Exam Fee";
                AdmitCardHeaderCS.MODIFY();
            END;
        END;
        //Code added for delete admit card::CSPL-00059::18022019: End
    end;

    procedure PaidExamFee("getDocNo.": Code[20])
    var
        AdmitCardHeaderCS: Record "Admit Card Header-CS";
        FeeSetupCS: Record "Fee Setup-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        LocalAmount: Decimal;

    begin
        //Code added for paid exam fee::CSPL-00059::18022019: Start
        AdmitCardHeaderCS.GET("getDocNo.");
        IF NOT CONFIRM(Text006Lbl, FALSE) THEN
            EXIT;
        AdmitCardLineCS.SETCURRENTKEY("Document No.", "Student No.");
        AdmitCardLineCS.SETRANGE("Document No.", AdmitCardHeaderCS."No.");
        AdmitCardLineCS.SETRANGE("Student No.", AdmitCardHeaderCS."Student No.");
        AdmitCardLineCS.CALCSUMS(Amount);
        LocalAmount := AdmitCardLineCS.Amount;
        IF LocalAmount = 0 THEN
            ERROR(Text002Lbl);
        IF AdmitCardHeaderCS."Receipt No." <> '' THEN
            ERROR(Text003Lbl);
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Exam Fee Code");

        AdmitCardHeaderCS."Receipt No." := ManagementsFeeCS."Post SalesCS"(AdmitCardHeaderCS."Student No.", FeeSetupCS."Exam Fee Code", LocalAmount);
        AdmitCardHeaderCS.MODIFY();
        MESSAGE(Text004Lbl);
        //Code added for paid exam fee::CSPL-00059::18022019: End
    end;
}


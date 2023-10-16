codeunit 50024 "Evaluation Action-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   20/02/2019     ValidGetApplicantsforEvaluation()-Function      Code added for get applicant evaluation.
    // 02    CSPL-00059   20/02/2019     ValidUpdateEvaluationMark()-Function            Code added for update evaluation mark .
    // 03    CSPL-00059   20/02/2019     ValidGetPreQualificationSubjects()-Function     Code added for get pre qualification subjects.


    trigger OnRun()
    begin
    end;

    var
        Text000Lbl: Label 'Stage2 Has Been Processed';
        Text001Lbl: Label 'Please update Evaluation Marks For Students';
        Text002Lbl: Label 'Update Completed';
        Text003Lbl: Label 'Do you want to Delete & update the Students';
        Text004Lbl: Label 'Do you want to update the Evaluation Mark';
        Text005Lbl: Label 'Do you want to delete the Subjects & Update';

    procedure ValidGetApplicantsforEvaluation(getCourse: Code[20]; getEvaluationCode: Code[20]; getAcademicYear: Code[20]; Stage1SelListNo: Integer)
    var
        ApplicationCS: Record "Application-CS";
        EvaluationCourseLineCS: Record "Evaluation Course Line-CS";
    begin
        //Code added for get applicant evaluation::CSPL-00059::20022019: Start
        EvaluationCourseLineCS.RESET();
        EvaluationCourseLineCS.SETRANGE("Course Code", getCourse);
        EvaluationCourseLineCS.SETRANGE("Evaluation Method Code", getEvaluationCode);
        EvaluationCourseLineCS.SETRANGE("Academic Year", getAcademicYear);
        EvaluationCourseLineCS.SETRANGE("Stage1 Selection List No.", Stage1SelListNo);
        IF EvaluationCourseLineCS.FINDFIRST() THEN
            IF CONFIRM(Text003Lbl, FALSE) THEN
                EvaluationCourseLineCS.DELETEALL()
            ELSE
                EXIT;


        ApplicationCS.RESET();
        ApplicationCS.SETRANGE("Course Code", getCourse);
        ApplicationCS.SETRANGE("Application Status", ApplicationCS."Application Status"::Received);
        ApplicationCS.SETRANGE("Stage2 Selection List No.", Stage1SelListNo);
        ApplicationCS.SETRANGE(Alloted, TRUE);
        IF ApplicationCS.FINDFIRST() THEN
            ERROR(Text000Lbl);

        ApplicationCS.RESET();
        ApplicationCS.SETRANGE("Course Code", getCourse);
        ApplicationCS.SETRANGE("Application Status", ApplicationCS."Application Status"::Received);
        ApplicationCS.SETRANGE("Stage1 Selection List No.", Stage1SelListNo);
        ApplicationCS.SETRANGE("Application Selection", TRUE);
        IF ApplicationCS.FINDSET() THEN
            REPEAT
                EvaluationCourseLineCS.INIT();
                EvaluationCourseLineCS."Course Code" := getCourse;
                EvaluationCourseLineCS."Evaluation Method Code" := getEvaluationCode;
                EvaluationCourseLineCS."Academic Year" := getAcademicYear;
                EvaluationCourseLineCS."Application No." := ApplicationCS."No.";
                EvaluationCourseLineCS."Applicant Name" := ApplicationCS."Applicant Name";
                EvaluationCourseLineCS."Attendance Status" := EvaluationCourseLineCS."Attendance Status"::Present;
                EvaluationCourseLineCS."Stage1 Selection List No." := ApplicationCS."Stage1 Selection List No.";
                EvaluationCourseLineCS.INSERT();
            UNTIL ApplicationCS.NEXT() = 0;
        //Code added for get applicant evaluation::CSPL-00059::20022019: End
    end;

    procedure ValidUpdateEvaluationMark(getCourse: Code[20]; getEvaluationCode: Code[20]; getAcademicYear: Code[20]; Stage1SelListNo: Integer)
    var
        EvaluationApplicantCS: Record "Evaluation Applicant-CS";
        EvaluationCourseLineCS: Record "Evaluation Course Line-CS";
        StudentExtensionNewCS: Record "Student Extension New-CS";
    begin
        //Code added for update evaluation mark::CSPL-00059::20022019: Start
        EvaluationCourseLineCS.RESET();
        EvaluationCourseLineCS.SETRANGE("Course Code", getCourse);
        EvaluationCourseLineCS.SETRANGE("Evaluation Method Code", getEvaluationCode);
        EvaluationCourseLineCS.SETRANGE("Stage1 Selection List No.", Stage1SelListNo);
        EvaluationCourseLineCS.SETRANGE("Academic Year", getAcademicYear);
        IF EvaluationCourseLineCS.ISEMPTY() then
            ERROR(Text001Lbl);

        IF CONFIRM(Text004Lbl, FALSE) THEN BEGIN
            EvaluationCourseLineCS.RESET();
            EvaluationCourseLineCS.SETRANGE("Course Code", getCourse);
            EvaluationCourseLineCS.SETRANGE("Evaluation Method Code", getEvaluationCode);
            EvaluationCourseLineCS.SETRANGE("Academic Year", getAcademicYear);
            EvaluationCourseLineCS.SETRANGE("Stage1 Selection List No.", Stage1SelListNo);
            IF EvaluationCourseLineCS.FINDSET() THEN
                REPEAT
                    IF EvaluationApplicantCS.GET(EvaluationCourseLineCS."Application No.", EvaluationCourseLineCS."Evaluation Method Code") THEN
                        EvaluationApplicantCS.DELETE();
                    EvaluationApplicantCS.INIT();
                    EvaluationApplicantCS."Application No." := EvaluationCourseLineCS."Application No.";
                    EvaluationApplicantCS."Evaluation Method Code" := EvaluationCourseLineCS."Evaluation Method Code";
                    IF StudentExtensionNewCS.GET(EvaluationCourseLineCS."Evaluation Method Code") THEN
                        EvaluationApplicantCS.Desription := StudentExtensionNewCS."Enrollment No.";
                    EvaluationApplicantCS."Mark Obtained" := EvaluationCourseLineCS."Marks Obtained";
                    EvaluationApplicantCS."Attendance Status" := EvaluationCourseLineCS."Attendance Status";
                    EvaluationApplicantCS.INSERT();
                UNTIL EvaluationCourseLineCS.NEXT() = 0;
            MESSAGE(Text002Lbl);
        END;
        //Code added for update evaluation mark::CSPL-00059::20022019: End
    end;

    procedure ValidGetPreQualificationSubjects("getDocNo.": Code[20])
    var
        GroupCS: Record "Group-CS";
        CourseGroupLineCS: Record "Course Group Line-CS";
        ApplicationCS: Record "Application-CS";
        MarkApplicationCS: Record "Mark Application-CS";
        // DueClearanceCS: Record "Due Clearance-CS";
        GetGroupCode: Code[20];

    begin
        //Code added for get pre qualification subjects::CSPL-00059::20022019: Start

        GetGroupCode := '';
        GroupCS.RESET();
        GroupCS.FINDFIRST();
        IF PAGE.RUNMODAL(33049389, GroupCS) = ACTION::LookupOK THEN
            GetGroupCode := GroupCS.Code;

        ApplicationCS.GET("getDocNo.");
        ApplicationCS.TESTFIELD("Course Code");

        IF GetGroupCode <> '' THEN BEGIN
            MarkApplicationCS.RESET();
            MarkApplicationCS.SETRANGE("Application No", "getDocNo.");
            IF MarkApplicationCS.FINDFIRST() THEN
                IF CONFIRM(Text005Lbl, FALSE) THEN
                    MarkApplicationCS.DELETEALL()
                ELSE
                    EXIT;
            CourseGroupLineCS.RESET();
            CourseGroupLineCS.SETRANGE("Course Code", ApplicationCS."Course Code");
            CourseGroupLineCS.SETRANGE("Group Code", GetGroupCode);
            IF CourseGroupLineCS.FINDSET() THEN
                REPEAT
                    MarkApplicationCS.INIT();
                    MarkApplicationCS.Type := MarkApplicationCS.Type::"Prequalification Subjects";
                    MarkApplicationCS."Application No" := "getDocNo.";
                    MarkApplicationCS.Code := CourseGroupLineCS."Prequalification Subject Code";
                    MarkApplicationCS.Description := CourseGroupLineCS.Description;
                    MarkApplicationCS."Course Code" := ApplicationCS."Course Code";
                    IF CourseGroupLineCS.GET(CourseGroupLineCS."Prequalification Subject Code") THEN
                        MarkApplicationCS.INSERT();
                UNTIL CourseGroupLineCS.NEXT() = 0;
        END;
        //Code added for get pre qualification subjects::CSPL-00059::20022019: End
    end;
}


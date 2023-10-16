report 50135 "Update Subject InfoCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Subject Master-CS")
        {

            trigger OnAfterGetRecord()
            begin

                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE("Academic Year", '2017-2018');
                MainStudentSubjectCS.SETRANGE(Semester, 'VII');
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Subject Code", Code);
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        MainStudentSubjectCS.Description := Description;
                        MainStudentSubjectCS.Updated := TRUE;
                        MainStudentSubjectCS.Modify();
                    UNTIL MainStudentSubjectCS.NEXT() = 0;


                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE("Academic Year", '2017-2018');
                OptionalStudentSubjectCS.SETRANGE(Semester, 'VII');
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Subject Code", Code);
                IF OptionalStudentSubjectCS.findset() THEN
                    REPEAT
                        OptionalStudentSubjectCS.Description := Description;
                        OptionalStudentSubjectCS."Elective Group Code" := "Elective Group Code";
                        OptionalStudentSubjectCS.Updated := TRUE;
                        OptionalStudentSubjectCS.Modify();
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;


                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", '2017-2018');
                CourseWiseSubjectLineCS.SETRANGE(Semester, 'VII');
                CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Subject Code", Code);
                IF CourseWiseSubjectLineCS.findset() THEN
                    REPEAT
                        CourseWiseSubjectLineCS.Description := Description;
                        CourseWiseSubjectLineCS."Elective Group Code" := "Elective Group Code";
                        CourseWiseSubjectLineCS.Updated := TRUE;
                        CourseWiseSubjectLineCS.Modify();
                    UNTIL CourseWiseSubjectLineCS.NEXT() = 0;


                FacultyCourseWiseCS.Reset();
                FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Academic Year", '2017-2018');
                FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Subject Code", Code);
                FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Semester Code", Semester);
                FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Global Dimension 1 Code", '09');
                IF FacultyCourseWiseCS.findset() THEN
                    REPEAT
                        FacultyCourseWiseCS."Subject Description" := Description;
                        FacultyCourseWiseCS.Updated := TRUE;
                        FacultyCourseWiseCS.Modify();
                    UNTIL FacultyCourseWiseCS.NEXT() = 0;


                ClassAttendanceHeaderCS.Reset();
                ClassAttendanceHeaderCS.SETRANGE("Academic Year", '2017-2018');
                ClassAttendanceHeaderCS.SETRANGE(Semester, 'VII');
                ClassAttendanceHeaderCS.SETRANGE(ClassAttendanceHeaderCS."Subject Code", Code);
                IF ClassAttendanceHeaderCS.findset() THEN
                    REPEAT
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETRANGE("Document No.", ClassAttendanceHeaderCS."No.");
                        IF ClassAttendanceLineCS.findset() THEN
                            REPEAT
                                ClassAttendanceLineCS.Description := Description;
                                ClassAttendanceLineCS.Updated := TRUE;
                                ClassAttendanceLineCS.Modify();
                            UNTIL ClassAttendanceLineCS.NEXT() = 0;
                        ClassAttendanceHeaderCS."Subject Description" := Description;
                        ClassAttendanceHeaderCS.Updated := TRUE;
                        ClassAttendanceHeaderCS.Modify();
                    UNTIL ClassAttendanceHeaderCS.NEXT() = 0;


                InternalExamHeaderCS.Reset();
                InternalExamHeaderCS.SETRANGE("Academic Year", '2017-2018');
                InternalExamHeaderCS.SETRANGE(Semester, 'VII');
                InternalExamHeaderCS.SETRANGE("Subject Code", Code);
                IF InternalExamHeaderCS.findset() THEN
                    REPEAT
                        InternalExamHeaderCS."Subject Description" := Description;
                        InternalExamHeaderCS.Updated := TRUE;
                        InternalExamHeaderCS.Modify();
                    UNTIL InternalExamHeaderCS.NEXT() = 0;


                ClassAssignmentHeaderCS.Reset();
                ClassAssignmentHeaderCS.SETRANGE("Academic Year", '2017-2018');
                ClassAssignmentHeaderCS.SETRANGE(Semester, 'VII');
                ClassAssignmentHeaderCS.SETRANGE(ClassAssignmentHeaderCS."Subject Code", Code);
                IF ClassAssignmentHeaderCS.findset() THEN
                    REPEAT
                        ClassAssignmentHeaderCS."Subject Description" := Description;
                        ClassAssignmentHeaderCS.Updated := TRUE;
                        ClassAssignmentHeaderCS.Modify();
                    UNTIL ClassAssignmentHeaderCS.NEXT() = 0;


                ClassTimeTableHeaderCS.Reset();
                ClassTimeTableHeaderCS.SETRANGE("Academic Year", '2017-2018');
                ClassTimeTableHeaderCS.SETRANGE(Semester, 'VII');
                IF ClassTimeTableHeaderCS.findset() THEN
                    REPEAT
                        ClassTimeTableLineCS.Reset();
                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Document No.", ClassTimeTableHeaderCS."No.");
                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Code);
                        IF ClassTimeTableLineCS.findset() THEN
                            REPEAT
                                ClassTimeTableLineCS."Subject Name" := Description;
                                ClassTimeTableLineCS."Program/Open Elective Temp" := "Program/Open Elective Temp";
                                ClassTimeTableLineCS.Updated := TRUE;
                                ClassTimeTableLineCS.Modify();
                            UNTIL ClassTimeTableLineCS.NEXT() = 0;
                    UNTIL ClassTimeTableHeaderCS.NEXT() = 0;


                FinalClassTimeTableCS.Reset();
                FinalClassTimeTableCS.SETRANGE(FinalClassTimeTableCS."Academic Code", '2017-2018');
                FinalClassTimeTableCS.SETRANGE(FinalClassTimeTableCS.Semester, 'VII');
                FinalClassTimeTableCS.SETRANGE(FinalClassTimeTableCS."Subject Code", Code);
                IF FinalClassTimeTableCS.findset() THEN
                    REPEAT
                        FinalClassTimeTableCS."Subject Name" := Description;
                        FinalClassTimeTableCS.Updated := TRUE;
                    UNTIL FinalClassTimeTableCS.NEXT() = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        ClassAssignmentHeaderCS: Record "Class Assignment Header-CS";
        ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";
        ClassTimeTableLineCS: Record "Class Time Table Line-CS";
        FinalClassTimeTableCS: Record "Final Class Time Table-CS";
        ClassAttendanceHeaderCS: Record "Class Attendance Header-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
}


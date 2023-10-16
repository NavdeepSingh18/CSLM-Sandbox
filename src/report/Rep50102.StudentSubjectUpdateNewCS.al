report 50102 "Student Subject UpdateNew CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = WHERE("New Student" = CONST(True));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                "Student Master-CS"."Student Status" := "Student Master-CS"."Student Status"::Student;
                "Student Master-CS".VALIDATE("Student Master-CS"."Course Code");
                "Student Master-CS".Modify();

                MainStudentSubjectCS1.Reset();
                MainStudentSubjectCS1.SETRANGE("Student No.", "No.");
                MainStudentSubjectCS1.SETRANGE(Course, "Student Master-CS"."Course Code");
                MainStudentSubjectCS1.SETRANGE(Semester, "Student Master-CS".Semester);
                IF Group <> '' THEN
                    MainStudentSubjectCS1.SETRANGE(Group, "Student Master-CS".Group);
                MainStudentSubjectCS1.SETRANGE("Academic Year", "Student Master-CS"."Academic Year");
                IF NOT MainStudentSubjectCS1.findset() THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                    IF Group <> '' THEN
                        CourseWiseSubjectLineCS.SETRANGE("Student Group", "Student Master-CS".Group);
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", 'CORE');
                    IF CourseWiseSubjectLineCS.findset() THEN
                        REPEAT
                            MainStudentSubjectCS.init();
                            MainStudentSubjectCS."Student No." := "No.";
                            MainStudentSubjectCS."Student Name" := "Student Name";
                            MainStudentSubjectCS.Course := "Course Code";
                            MainStudentSubjectCS.Semester := Semester;
                            MainStudentSubjectCS.Year := Year;
                            MainStudentSubjectCS."Enrollment No" := "Enrollment No.";
                            MainStudentSubjectCS.Section := Section;
                            MainStudentSubjectCS."Academic Year" := "Academic Year";
                            MainStudentSubjectCS."Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                            MainStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;

                            MainStudentSubjectCS.VALIDATE("Actual Academic Year", "Student Master-CS"."Academic Year");
                            MainStudentSubjectCS.VALIDATE("Actual Semester", "Student Master-CS".Semester);
                            MainStudentSubjectCS.VALIDATE("Actual Year", "Student Master-CS".Year);
                            MainStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            MainStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;

                            MainStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            MainStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            MainStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            MainStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                            MainStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                            MainStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                            MainStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                            MainStudentSubjectCS.Group := CourseWiseSubjectLineCS."Student Group";
                            MainStudentSubjectCS.Insert();
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                END ELSE
                    Commit();


                OptionalStudentSubjectCS1.Reset();
                OptionalStudentSubjectCS1.SETRANGE("Student No.", "Student Master-CS"."No.");
                OptionalStudentSubjectCS1.SETRANGE(Course, "Student Master-CS"."Course Code");
                OptionalStudentSubjectCS1.SETRANGE(Semester, "Student Master-CS".Semester);
                OptionalStudentSubjectCS1.SETRANGE("Academic Year", "Student Master-CS"."Academic Year");
                IF Group <> '' THEN
                    OptionalStudentSubjectCS1.SETRANGE(Group, "Student Master-CS".Group);
                OptionalStudentSubjectCS1.SETRANGE("Subject Type", 'OPEN ELECTIVE');
                IF NOT OptionalStudentSubjectCS1.findset() THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                    IF Group <> '' THEN
                        CourseWiseSubjectLineCS.SETRANGE("Student Group", "Student Master-CS".Group);
                    CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::"Open Elective Common Subject");
                    IF CourseWiseSubjectLineCS.findset() THEN
                        REPEAT
                            OptionalStudentSubjectCS.init();
                            OptionalStudentSubjectCS."Student No." := "No.";
                            OptionalStudentSubjectCS."Student Name" := "Student Name";
                            OptionalStudentSubjectCS.Course := "Course Code";
                            OptionalStudentSubjectCS.Semester := Semester;
                            OptionalStudentSubjectCS.Year := Year;
                            OptionalStudentSubjectCS."Enrollment No" := "Enrollment No.";
                            OptionalStudentSubjectCS.Section := Section;
                            OptionalStudentSubjectCS."Academic Year" := "Academic Year";
                            OptionalStudentSubjectCS."Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                            OptionalStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";

                            OptionalStudentSubjectCS.VALIDATE("Actual Academic Year", "Student Master-CS"."Academic Year");
                            OptionalStudentSubjectCS.VALIDATE("Actual Semester", "Student Master-CS".Semester);
                            OptionalStudentSubjectCS.VALIDATE("Actual Year", "Student Master-CS".Year);
                            OptionalStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;

                            OptionalStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            OptionalStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            OptionalStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                            OptionalStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                            OptionalStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                            OptionalStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                            OptionalStudentSubjectCS.Group := CourseWiseSubjectLineCS."Student Group";
                            OptionalStudentSubjectCS."Program/Open Elective Temp" := OptionalStudentSubjectCS."Program/Open Elective Temp"::"Open Elective Common Subject";
                            OptionalStudentSubjectCS.Insert();
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                END ELSE
                    Commit();


                OptionalStudentSubjectCS1.Reset();
                OptionalStudentSubjectCS1.SETRANGE("Student No.", "Student Master-CS"."No.");
                OptionalStudentSubjectCS1.SETRANGE(Course, "Student Master-CS"."Course Code");
                OptionalStudentSubjectCS1.SETRANGE(Semester, "Student Master-CS".Semester);
                OptionalStudentSubjectCS1.SETRANGE("Academic Year", "Student Master-CS"."Academic Year");
                OptionalStudentSubjectCS1.SETRANGE("Subject Type", 'ELECTIVE');
                IF Group <> '' THEN
                    OptionalStudentSubjectCS1.SETRANGE(Group, "Student Master-CS".Group);
                IF NOT OptionalStudentSubjectCS1.findset() THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                    IF Group <> '' THEN
                        CourseWiseSubjectLineCS.SETRANGE("Student Group", "Student Master-CS".Group);
                    CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::"Program Elective Common Subject");
                    IF CourseWiseSubjectLineCS.findset() THEN
                        REPEAT
                            OptionalStudentSubjectCS.init();
                            OptionalStudentSubjectCS."Student No." := "No.";
                            OptionalStudentSubjectCS."Student Name" := "Student Name";
                            OptionalStudentSubjectCS.Course := "Course Code";
                            OptionalStudentSubjectCS.Semester := Semester;
                            OptionalStudentSubjectCS.Year := Year;
                            OptionalStudentSubjectCS."Enrollment No" := "Enrollment No.";
                            OptionalStudentSubjectCS.Section := Section;
                            OptionalStudentSubjectCS."Academic Year" := "Academic Year";
                            OptionalStudentSubjectCS."Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                            OptionalStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";

                            OptionalStudentSubjectCS.VALIDATE("Actual Academic Year", "Student Master-CS"."Academic Year");
                            OptionalStudentSubjectCS.VALIDATE("Actual Semester", "Student Master-CS".Semester);
                            OptionalStudentSubjectCS.VALIDATE("Actual Year", "Student Master-CS".Year);
                            OptionalStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;

                            OptionalStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            OptionalStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            OptionalStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                            OptionalStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                            OptionalStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                            OptionalStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                            OptionalStudentSubjectCS.Group := CourseWiseSubjectLineCS."Student Group";
                            OptionalStudentSubjectCS."Program/Open Elective Temp" := OptionalStudentSubjectCS."Program/Open Elective Temp"::"Program Elective Common Subject";
                            OptionalStudentSubjectCS.Insert();
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                END ELSE
                    Commit();
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

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS1: Record "Optional Student Subject-CS";
}


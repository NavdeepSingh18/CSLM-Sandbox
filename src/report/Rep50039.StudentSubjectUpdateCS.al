report 50039 "Student Subject Update CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Student Master-CS")
        {
            DataItemTableView = WHERE("Student Status" = FILTER('<>Withdrawl/Discontinue'));
            RequestFilterFields = "No.", "Enrollment No.", Semester, Graduation, "Academic Year", "Admitted Year", "Course Code";

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);                          //To Update All Semester Subject
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                IF (Year = '1ST') AND (Group <> '') THEN
                    CourseWiseSubjectLineCS.SETRANGE("Student Group", Group);   ///
                CourseWiseSubjectLineCS.SETRANGE("Subject Type", 'CORE');
                IF CourseWiseSubjectLineCS.findset() THEN
                    REPEAT
                        MainStudentSubjectCS1.Reset();
                        MainStudentSubjectCS1.SETRANGE("Student No.", "No.");

                        MainStudentSubjectCS1.SETRANGE(Course, "Course Code");
                        MainStudentSubjectCS1.SETRANGE(Semester, Semester);
                        MainStudentSubjectCS1.SETRANGE("Academic Year", "Academic Year");
                        MainStudentSubjectCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        IF NOT MainStudentSubjectCS1.findfirst() THEN BEGIN
                            MainStudentSubjectCS.init();
                            MainStudentSubjectCS."Student No." := "No.";
                            MainStudentSubjectCS."Student Name" := "Student Name";
                            MainStudentSubjectCS.Course := "Course Code";
                            MainStudentSubjectCS.VALIDATE("Academic Year", "Academic Year");
                            MainStudentSubjectCS.VALIDATE(Semester, CourseWiseSubjectLineCS.Semester);
                            MainStudentSubjectCS.VALIDATE(Year, Year);
                            MainStudentSubjectCS.Graduation := Graduation;
                            MainStudentSubjectCS."Enrollment No" := "Enrollment No.";
                            MainStudentSubjectCS.Section := Section;
                            MainStudentSubjectCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            MainStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            MainStudentSubjectCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            MainStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            MainStudentSubjectCS.VALIDATE("Actual Academic Year", "Academic Year");
                            MainStudentSubjectCS.VALIDATE("Actual Semester", CourseWiseSubjectLineCS.Semester);
                            MainStudentSubjectCS.VALIDATE("Actual Year", Year);
                            MainStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            MainStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;
                            MainStudentSubjectCS."Roll No." := "Roll No.";
                            MainStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            MainStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            MainStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                            MainStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                            MainStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                            MainStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                            MainStudentSubjectCS.Group := Group;   ///
                            IF Semester = 'III & IV' THEN BEGIN
                                MainStudentSubjectCS."Current Session" := 'JUL-MAY';
                                MainStudentSubjectCS."Previous Session" := 'JUL-MAY';
                                MainStudentSubjectCS."Actual Session" := 'JUL-MAY';
                            END ELSE BEGIN
                                EducationSetupCS.Reset();
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                                    MainStudentSubjectCS."Current Session" := 'JAN-MAY';
                                    MainStudentSubjectCS."Previous Session" := 'JAN-MAY';
                                    MainStudentSubjectCS."Actual Session" := 'JAN-MAY';
                                END ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                                        MainStudentSubjectCS."Current Session" := 'JUL-NOV';
                                        MainStudentSubjectCS."Previous Session" := 'JUL-NOV';
                                        MainStudentSubjectCS."Actual Session" := 'JUL-NOV';
                                    END;
                            END;
                            MainStudentSubjectCS.Insert();
                        END;
                    UNTIL CourseWiseSubjectLineCS.NEXT() = 0
                ELSE
                    CurrReport.Skip();


                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);                           //To Update All Semester Subject
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", StudentMasterCS."Academic Year");
                IF Group <> '' THEN
                    CourseWiseSubjectLineCS.SETRANGE("Student Group", Group);
                CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::"Open Elective Common Subject");
                IF CourseWiseSubjectLineCS.findset() THEN
                    REPEAT
                        OptionalStudentSubjectCS1.Reset();
                        OptionalStudentSubjectCS1.SETRANGE("Student No.", "No.");
                        OptionalStudentSubjectCS1.SETRANGE(Course, "Course Code");
                        OptionalStudentSubjectCS1.SETRANGE(Semester, Semester);
                        OptionalStudentSubjectCS1.SETRANGE("Academic Year", "Academic Year");
                        IF Group <> '' THEN
                            OptionalStudentSubjectCS1.SETRANGE(Group, Group);
                        OptionalStudentSubjectCS1.SETRANGE("Subject Type", 'OPEN ELECTIVE');
                        OptionalStudentSubjectCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        IF NOT OptionalStudentSubjectCS1.findset() THEN BEGIN

                            OptionalStudentSubjectCS.init();
                            OptionalStudentSubjectCS."Student No." := "No.";
                            OptionalStudentSubjectCS."Student Name" := "Student Name";
                            OptionalStudentSubjectCS.Course := "Course Code";
                            OptionalStudentSubjectCS.VALIDATE(Semester, CourseWiseSubjectLineCS.Semester);
                            OptionalStudentSubjectCS.VALIDATE(Year, Year);
                            OptionalStudentSubjectCS."Enrollment No" := "Enrollment No.";
                            OptionalStudentSubjectCS.Section := Section;
                            OptionalStudentSubjectCS.Graduation := Graduation;
                            OptionalStudentSubjectCS.VALIDATE("Academic Year", "Academic Year");
                            OptionalStudentSubjectCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            OptionalStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            OptionalStudentSubjectCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS.VALIDATE("Actual Academic Year", "Academic Year");
                            OptionalStudentSubjectCS.VALIDATE("Actual Semester", CourseWiseSubjectLineCS.Semester);
                            OptionalStudentSubjectCS.VALIDATE("Actual Year", Year);
                            OptionalStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            OptionalStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            OptionalStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                            OptionalStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                            OptionalStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                            OptionalStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                            OptionalStudentSubjectCS.Group := Group;
                            OptionalStudentSubjectCS."Program/Open Elective Temp" := OptionalStudentSubjectCS."Program/Open Elective Temp"::"Open Elective Common Subject";
                            IF Semester = 'III & IV' THEN BEGIN
                                OptionalStudentSubjectCS."Current Session" := 'JUL-MAY';
                                OptionalStudentSubjectCS."Previous Session" := 'JUL-MAY';
                                OptionalStudentSubjectCS."Actual Session" := 'JUL-MAY';
                            END ELSE BEGIN
                                EducationSetupCS.Reset();
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                                    CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
                                    OptionalStudentSubjectCS."Current Session" := 'JAN-MAY';
                                    OptionalStudentSubjectCS."Previous Session" := 'JAN-MAY';
                                    OptionalStudentSubjectCS."Actual Session" := 'JAN-MAY';
                                END ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                                        CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
                                        OptionalStudentSubjectCS."Current Session" := 'JUL-NOV';
                                        OptionalStudentSubjectCS."Previous Session" := 'JUL-NOV';
                                        OptionalStudentSubjectCS."Actual Session" := 'JUL-NOV';
                                    END;
                            END;
                            OptionalStudentSubjectCS.Insert();
                        END;
                    UNTIL CourseWiseSubjectLineCS.NEXT() = 0
                //MESSAGE(Text002);
                ELSE
                    //ERROR(Text001);
                    CurrReport.Skip();


                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                IF Group <> '' THEN
                    CourseWiseSubjectLineCS.SETRANGE("Student Group", Group);
                CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::"Program Elective Common Subject");
                IF CourseWiseSubjectLineCS.findset() THEN
                    REPEAT
                        OptionalStudentSubjectCS1.Reset();
                        OptionalStudentSubjectCS1.SETRANGE("Student No.", "No.");
                        OptionalStudentSubjectCS1.SETRANGE(Course, "Course Code");
                        OptionalStudentSubjectCS1.SETRANGE(Semester, Semester);
                        OptionalStudentSubjectCS1.SETRANGE("Academic Year", "Academic Year");
                        OptionalStudentSubjectCS1.SETRANGE("Subject Type", 'ELECTIVE');
                        IF Group <> '' THEN
                            OptionalStudentSubjectCS1.SETRANGE(Group, Group);
                        OptionalStudentSubjectCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        IF NOT OptionalStudentSubjectCS1.findset() THEN BEGIN
                            OptionalStudentSubjectCS.init();
                            OptionalStudentSubjectCS."Student No." := "No.";
                            OptionalStudentSubjectCS."Student Name" := "Student Name";
                            OptionalStudentSubjectCS.Course := "Course Code";
                            OptionalStudentSubjectCS.VALIDATE(Semester, Semester);
                            OptionalStudentSubjectCS.VALIDATE(Year, Year);
                            OptionalStudentSubjectCS."Enrollment No" := "Enrollment No.";
                            OptionalStudentSubjectCS.Section := Section;
                            OptionalStudentSubjectCS.Graduation := Graduation;
                            OptionalStudentSubjectCS.VALIDATE("Academic Year", "Academic Year");
                            OptionalStudentSubjectCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            OptionalStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            OptionalStudentSubjectCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS.VALIDATE("Actual Academic Year", "Academic Year");
                            OptionalStudentSubjectCS.VALIDATE("Actual Semester", Semester);
                            OptionalStudentSubjectCS.VALIDATE("Actual Year", Year);
                            OptionalStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            OptionalStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            OptionalStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                            OptionalStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                            OptionalStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                            OptionalStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                            OptionalStudentSubjectCS.Group := Group;  ///
                            OptionalStudentSubjectCS."Program/Open Elective Temp" := OptionalStudentSubjectCS."Program/Open Elective Temp"::"Program Elective Common Subject";
                            IF Semester = 'III & IV' THEN BEGIN
                                OptionalStudentSubjectCS."Current Session" := 'JUL-MAY';
                                OptionalStudentSubjectCS."Previous Session" := 'JUL-MAY';
                                OptionalStudentSubjectCS."Actual Session" := 'JUL-MAY';
                            END ELSE BEGIN
                                EducationSetupCS.Reset();
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                                    CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
                                    OptionalStudentSubjectCS."Current Session" := 'JAN-MAY';
                                    OptionalStudentSubjectCS."Previous Session" := 'JAN-MAY';
                                    OptionalStudentSubjectCS."Actual Session" := 'JAN-MAY';
                                END ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                                        CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
                                        OptionalStudentSubjectCS."Current Session" := 'JUL-NOV';
                                        OptionalStudentSubjectCS."Previous Session" := 'JUL-NOV';
                                        OptionalStudentSubjectCS."Actual Session" := 'JUL-NOV';
                                    END;
                            END;
                            OptionalStudentSubjectCS.Insert();
                        END;
                    UNTIL CourseWiseSubjectLineCS.NEXT() = 0
                //MESSAGE(Text003);
                ELSE
                    //ERROR(Text001);
                    CurrReport.Skip();
            end;

            trigger OnPostDataItem()
            begin
                PROGRESS.Close();
            end;

            trigger OnPreDataItem()
            begin
                TotalCount := COUNT();
                PROGRESS.OPEN(Text_10001Lbl);
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
        StudentMasterCS: Record "Student Master-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS1: Record "Optional Student Subject-CS";
        EducationSetupCS: Record "Education Setup-CS";
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label 'PROCESSING #1  Out Of  @2 .', Comment = '#1 = No. of Counts';
}


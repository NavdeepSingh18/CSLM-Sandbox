report 50040 "Student Subject UpdatePromCS"
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
            RequestFilterFields = "No.", "Enrollment No.", Semester;

            trigger OnAfterGetRecord()
            begin


                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                MainStudentSubjectCS1.Reset();
                MainStudentSubjectCS1.SETRANGE("Student No.", "No.");
                MainStudentSubjectCS1.SETRANGE(Course, "Course Code");
                MainStudentSubjectCS1.SETRANGE(Semester, Semester);
                IF (Year = '1ST') AND (Group <> '') THEN
                    MainStudentSubjectCS1.SETRANGE(Group, Group);   ///
                MainStudentSubjectCS1.SETRANGE("Academic Year", "Academic Year");
                IF NOT MainStudentSubjectCS1.findset() THEN BEGIN
                    //IF MainStudentSubjectCS1.findset() THEN
                    //MainStudentSubjectCS1.deleteall();
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);              //To Update All Semester Subject
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                    IF (Year = '1ST') AND (Group <> '') THEN
                        CourseWiseSubjectLineCS.SETRANGE("Student Group", Group);   ///
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", 'CORE');
                    IF CourseWiseSubjectLineCS.findset() THEN
                        REPEAT
                            MainStudentSubjectCS.init();
                            MainStudentSubjectCS."Student No." := "No.";
                            MainStudentSubjectCS."Student Name" := "Student Name";
                            MainStudentSubjectCS.Course := "Course Code";
                            MainStudentSubjectCS.VALIDATE("Academic Year", "Academic Year");
                            MainStudentSubjectCS.VALIDATE(Semester, CourseWiseSubjectLineCS.Semester);
                            MainStudentSubjectCS.VALIDATE(Year, CourseWiseSubjectLineCS.Year);
                            MainStudentSubjectCS.Graduation := Graduation;
                            MainStudentSubjectCS."Enrollment No" := "Enrollment No.";
                            MainStudentSubjectCS.Section := Section;
                            MainStudentSubjectCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            MainStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            MainStudentSubjectCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            MainStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            MainStudentSubjectCS.VALIDATE("Actual Academic Year", "Academic Year");
                            MainStudentSubjectCS.VALIDATE("Actual Semester", CourseWiseSubjectLineCS.Semester);
                            MainStudentSubjectCS.VALIDATE("Actual Year", CourseWiseSubjectLineCS.Year);
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
                                    CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
                                    MainStudentSubjectCS."Current Session" := 'JAN-MAY';
                                    MainStudentSubjectCS."Previous Session" := 'JAN-MAY';
                                    MainStudentSubjectCS."Actual Session" := 'JAN-MAY';
                                END ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                                        CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
                                        MainStudentSubjectCS."Current Session" := 'JUL-NOV';
                                        MainStudentSubjectCS."Previous Session" := 'JUL-NOV';
                                        MainStudentSubjectCS."Actual Session" := 'JUL-NOV';
                                    END;
                            END;
                            MainStudentSubjectCS.Insert();
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                    //MESSAGE(Text000);
                END ELSE
                    //ERROR(Text001);
                    CurrReport.Skip();

                /*
                   StudentOptionalSubjectCOL1.Reset();
                   StudentOptionalSubjectCOL1.SETRANGE("Student No.","No.");
                   StudentOptionalSubjectCOL1.SETRANGE(Course,"Course Code");
                   //StudentOptionalSubjectCOL1.SETRANGE(Semester,Semester);
                   StudentOptionalSubjectCOL1.SETFILTER(Semester,'>%1',Semester);
                   StudentOptionalSubjectCOL1.SETRANGE("Academic Year","Academic Year");
                   IF Group <> '' THEN   ///
                     StudentOptionalSubjectCOL1.SETRANGE(Group,Group);  ///
                   StudentOptionalSubjectCOL1.SETRANGE("Subject Type",'OPEN ELECTIVE');
                   IF  NOT StudentOptionalSubjectCOL1.findset() THEN BEGIN
                     CourseWiseSubjectLineCS.Reset();
                     CourseWiseSubjectLineCS.SETRANGE("Course Code","Course Code");
                     //CourseWiseSubjectLineCS.SETRANGE(Semester,Semester);                           //To Update All Semester Subject
                    CourseWiseSubjectLineCS.SETFILTER(Semester,'>%1',Semester);
                     CourseWiseSubjectLineCS.SETRANGE("Academic Year","Academic Year");
                     IF Group <> '' THEN  ///
                       CourseWiseSubjectLineCS.SETRANGE("Student Group",Group);   ///
                     CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp",CourseWiseSubjectLineCS."Program/Open Elective Temp" ::"Open Elective Common Subject" );
                     IF CourseWiseSubjectLineCS.findset() THEN
                       REPEAT
                         StudentOptionalSubjectCOL.init();
                         StudentOptionalSubjectCOL."Student No." := "No.";
                         StudentOptionalSubjectCOL."Student Name" := "Student Name";
                         StudentOptionalSubjectCOL.Course := "Course Code";
                         StudentOptionalSubjectCOL.VALIDATE(Semester,CourseWiseSubjectLineCS.Semester);
                         StudentOptionalSubjectCOL.VALIDATE(Year,CourseWiseSubjectLineCS.Year);
                         StudentOptionalSubjectCOL."Enrollment No" := "Enrollment No.";
                         StudentOptionalSubjectCOL.Section := Section;
                         StudentOptionalSubjectCOL.Graduation := Graduation;
                         StudentOptionalSubjectCOL.VALIDATE("Academic Year","Academic Year");
                         StudentOptionalSubjectCOL."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                         StudentOptionalSubjectCOL."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                         StudentOptionalSubjectCOL.VALIDATE("Subject Code",CourseWiseSubjectLineCS."Subject Code");
                         StudentOptionalSubjectCOL.Description := CourseWiseSubjectLineCS.Description;
                         StudentOptionalSubjectCOL.VALIDATE("Actual Academic Year","Academic Year");
                         StudentOptionalSubjectCOL.VALIDATE("Actual Semester",CourseWiseSubjectLineCS.Semester);
                         StudentOptionalSubjectCOL.VALIDATE("Actual Year",CourseWiseSubjectLineCS.Year);
                         StudentOptionalSubjectCOL.VALIDATE("Actual Subject Code",CourseWiseSubjectLineCS."Subject Code");
                         StudentOptionalSubjectCOL."Actual Subject Description" := CourseWiseSubjectLineCS.Description;
                         StudentOptionalSubjectCOL.Credit := CourseWiseSubjectLineCS.Credit;
                         StudentOptionalSubjectCOL."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                         StudentOptionalSubjectCOL."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                         StudentOptionalSubjectCOL."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                         StudentOptionalSubjectCOL."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                         StudentOptionalSubjectCOL."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                         StudentOptionalSubjectCOL.Group  := Group;
                         StudentOptionalSubjectCOL."Elective Group Code" := CourseWiseSubjectLineCS."Elective Group Code";
                         StudentOptionalSubjectCOL."Program/Open Elective Temp":=StudentOptionalSubjectCOL."Program/Open Elective Temp"::"Open Elective Common Subject";
                         EducationSetupCS.Reset();
                         IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                           StudentOptionalSubjectCOL."Current Session":= 'JAN-MAY';
                           StudentOptionalSubjectCOL."Previous Session":= 'JAN-MAY';
                           StudentOptionalSubjectCOL."Actual Session":= 'JAN-MAY';
                         END ELSE IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                           StudentOptionalSubjectCOL."Current Session":= 'JUL-NOV';
                           StudentOptionalSubjectCOL."Previous Session":= 'JUL-NOV';
                           StudentOptionalSubjectCOL."Actual Session":= 'JUL-NOV';
                         END;
                         StudentOptionalSubjectCOL.Insert();
                       UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                     //MESSAGE(Text002);
                   END ELSE
                     //ERROR(Text001);
                     CurrReport.Skip();

                   StudentOptionalSubjectCOL1.Reset();
                   StudentOptionalSubjectCOL1.SETRANGE("Student No.","No.");
                   StudentOptionalSubjectCOL1.SETRANGE(Course,"Course Code");
               //  StudentOptionalSubjectCOL1.SETRANGE(Course,'0904');
               //  StudentOptionalSubjectCOL1.SETRANGE(Semester,Semester);
                   StudentOptionalSubjectCOL1.SETFILTER(Semester,'>%1',Semester);
               //  StudentOptionalSubjectCOL1.SETRANGE(Semester,'VI');
                   StudentOptionalSubjectCOL1.SETRANGE("Academic Year","Academic Year");
                   StudentOptionalSubjectCOL1.SETRANGE("Subject Type",'ELECTIVE');
               //  StudentOptionalSubjectCOL1.SETRANGE("Subject Code",'PE-III');
                   IF Group <> '' THEN  ///
                     StudentOptionalSubjectCOL1.SETRANGE(Group,Group);  ///
                   IF  NOT StudentOptionalSubjectCOL1.findset() THEN BEGIN
                     CourseWiseSubjectLineCS.Reset();
                     CourseWiseSubjectLineCS.SETRANGE("Course Code","Course Code");
                 //  CourseWiseSubjectLineCS.SETRANGE("Course Code",'0904');
               //    CourseWiseSubjectLineCS.SETRANGE(Semester,'VI');                       //To Update All Semester Subject
                     CourseWiseSubjectLineCS.SETFILTER(Semester,'>%1',Semester);
                     CourseWiseSubjectLineCS.SETRANGE("Academic Year","Academic Year");
                //     CourseWiseSubjectLineCS.SETRANGE("Subject Code",'PE-III');
                     IF Group <> '' THEN  ///
                       CourseWiseSubjectLineCS.SETRANGE("Student Group",Group);   ///
                     CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp",CourseWiseSubjectLineCS."Program/Open Elective Temp" ::"Program Elective Common Subject" );
                     IF CourseWiseSubjectLineCS.findset() THEN
                       REPEAT
                         StudentOptionalSubjectCOL.init();
                         StudentOptionalSubjectCOL."Student No." := "No.";
                         StudentOptionalSubjectCOL."Student Name" := "Student Name";
                         StudentOptionalSubjectCOL.Course := "Course Code";
                         StudentOptionalSubjectCOL.VALIDATE(Semester,CourseWiseSubjectLineCS.Semester);
                         StudentOptionalSubjectCOL.VALIDATE(Year,CourseWiseSubjectLineCS.Year);
                         StudentOptionalSubjectCOL."Enrollment No" := "Enrollment No.";
                         StudentOptionalSubjectCOL.Section := Section;
                         StudentOptionalSubjectCOL.Graduation := Graduation;
                         StudentOptionalSubjectCOL.VALIDATE("Academic Year","Academic Year");
                         StudentOptionalSubjectCOL."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                         StudentOptionalSubjectCOL."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                         StudentOptionalSubjectCOL.VALIDATE("Subject Code",CourseWiseSubjectLineCS."Subject Code");
                         StudentOptionalSubjectCOL.Description := CourseWiseSubjectLineCS.Description;
                         StudentOptionalSubjectCOL.VALIDATE("Actual Academic Year","Academic Year");
                         StudentOptionalSubjectCOL.VALIDATE("Actual Semester",Semester);
                         StudentOptionalSubjectCOL.VALIDATE("Actual Year",CourseWiseSubjectLineCS.Year);
                         StudentOptionalSubjectCOL.VALIDATE("Actual Subject Code",CourseWiseSubjectLineCS."Subject Code");
                         StudentOptionalSubjectCOL."Actual Subject Description" := CourseWiseSubjectLineCS.Description;
                         StudentOptionalSubjectCOL.Credit := CourseWiseSubjectLineCS.Credit;
                         StudentOptionalSubjectCOL."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                         StudentOptionalSubjectCOL."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                         StudentOptionalSubjectCOL."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                         StudentOptionalSubjectCOL."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                         StudentOptionalSubjectCOL."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                         StudentOptionalSubjectCOL.Group  := Group;  ///
                         StudentOptionalSubjectCOL."Elective Group Code" := CourseWiseSubjectLineCS."Elective Group Code";
                         StudentOptionalSubjectCOL."Program/Open Elective Temp":=StudentOptionalSubjectCOL."Program/Open Elective Temp"::"Program Elective Common Subject";
                         EducationSetupCS.Reset();
                         IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                           StudentOptionalSubjectCOL."Current Session":= 'JAN-MAY';
                           StudentOptionalSubjectCOL."Previous Session":= 'JAN-MAY';
                           StudentOptionalSubjectCOL."Actual Session":= 'JAN-MAY';
                         END ELSE IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                           StudentOptionalSubjectCOL."Current Session":= 'JUL-NOV';
                           StudentOptionalSubjectCOL."Previous Session":= 'JUL-NOV';
                           StudentOptionalSubjectCOL."Actual Session":= 'JUL-NOV';
                         END;
                         StudentOptionalSubjectCOL.Insert();
                       UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                     //MESSAGE(Text003);
                   END ELSE
                     //ERROR(Text001);
                     CurrReport.Skip();
                 //UNTIL StudentCOLLEGE.NEXT() = 0;
                 */

            end;

            trigger OnPostDataItem()
            begin
                //PROGRESS.close();
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
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";

        EducationSetupCS: Record "Education Setup-CS";
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label 'PROCESSING #1  Out Of  @2 .', Comment = '#1 = No. of Counts';

}


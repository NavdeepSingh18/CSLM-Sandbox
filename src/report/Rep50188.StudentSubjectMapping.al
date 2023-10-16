report 50188 "Student Subject Mapping"
{

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DataItem1000000000; "Student Master-CS")
        {
            // DataItemTableView = WHERE("Student Status" = FILTER('<>Withdrawl/Discontinue'));
            DataItemTableView = where("Global Dimension 1 Code" = filter('9000'));
            RequestFilterFields = "No.", "Enrollment No.", Semester, Graduation, "Academic Year", "Admitted Year", "Course Code";

            trigger OnAfterGetRecord()
            var
                CourseMAster: Record "Course Master-CS";
            begin


                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                // CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                CourseWiseSubjectLineCS.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF CourseWiseSubjectLineCS.findset() THEN
                    REPEAT
                        if CourseWiseSubjectLineCS."Global Dimension 1 Code" = '9000' then begin
                            //                            if (CourseWiseSubjectLineCS.Level = 1) or (CourseWiseSubjectLineCS.Examination = true) then begin
                            if (CourseWiseSubjectLineCS.Level = 1) then begin
                                CourseMAster.Reset();
                                CourseMAster.SetRange(Code, CourseWiseSubjectLineCS."Course Code");
                                CourseMAster.FindFirst();

                                CourseSemesterMasterRec.Reset();
                                CourseSemesterMasterRec.SetRange("Course Code", CourseWiseSubjectLineCS."Course Code");
                                CourseSemesterMasterRec.SetRange("Semester Code", DataItem1000000000.Semester);
                                CourseSemesterMasterRec.SetRange("Academic Year", DataItem1000000000."Academic Year");
                                CourseSemesterMasterRec.SetRange("Global Dimension 1 Code", DataItem1000000000."Global Dimension 1 Code");
                                CourseSemesterMasterRec.SetRange(Term, DataItem1000000000.Term);
                                CourseSemesterMasterRec.FindFirst();


                                MainStudentSubjectCS1.Reset();
                                MainStudentSubjectCS1.SETRANGE("Student No.", "No.");
                                MainStudentSubjectCS1.SETRANGE(Course, "Course Code");
                                MainStudentSubjectCS1.SETRANGE(Semester, Semester);
                                MainStudentSubjectCS1.SETRANGE("Academic Year", "Academic Year");
                                MainStudentSubjectCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                MainStudentSubjectCS1.SetRange("Start Date", CourseSemesterMasterRec."Start Date");
                                IF NOT MainStudentSubjectCS1.findfirst() THEN BEGIN
                                    MainStudentSubjectCS.init();
                                    MainStudentSubjectCS."Student No." := "No.";
                                    MainStudentSubjectCS."Original Student No." := DataItem1000000000."Original Student No.";
                                    MainStudentSubjectCS."Student Name" := "Student Name";
                                    MainStudentSubjectCS.Validate(Course, "Course Code");
                                    MainStudentSubjectCS.VALIDATE("Academic Year", "Academic Year");
                                    MainStudentSubjectCS.Term := Term;
                                    MainStudentSubjectCS.VALIDATE(Semester, CourseWiseSubjectLineCS.Semester);


                                    MainStudentSubjectCS."Start Date" := CourseSemesterMasterRec."Start Date";
                                    MainStudentSubjectCS."End Date" := CourseSemesterMasterRec."End Date";

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
                                    MainStudentSubjectCS.Level := CourseWiseSubjectLineCS.Level;
                                    MainStudentSubjectCS."Level Description" := CourseWiseSubjectLineCS."Level Description";
                                    MainStudentSubjectCS."Subject Group" := CourseWiseSubjectLineCS."Subject Group";
                                    //MainStudentSubjectCS."Goal Code" := CourseWiseSubjectLineCS."Goal Code";

                                    MainStudentSubjectCS."Term Description" := CourseWiseSubjectLineCS."Term Description";
                                    MainStudentSubjectCS.Examination := CourseWiseSubjectLineCS.Examination;
                                    MainStudentSubjectCS."Core Rotation Group" := CourseWiseSubjectLineCS."Core Rotation Group";
                                    if CourseWiseSubjectLineCS."Category Code" = '' then
                                        Error('Category code is not mapped for the subject code %1 in subject master and course subject line', CourseWiseSubjectLineCS."Subject Code")
                                    else
                                        MainStudentSubjectCS."Category-Course Description" := CourseWiseSubjectLineCS."Category Code";

                                    MainStudentSubjectCS.Insert();
                                END;
                            end;
                        end;
                        if CourseWiseSubjectLineCS."Global Dimension 1 Code" = '9100' then begin
                            if (CourseWiseSubjectLineCS.Level = 1) then begin
                                MainStudentSubjectCS1.Reset();
                                MainStudentSubjectCS1.SETRANGE("Student No.", "No.");
                                MainStudentSubjectCS1.SETRANGE(Course, "Course Code");
                                MainStudentSubjectCS1.SETRANGE(Semester, Semester);
                                MainStudentSubjectCS1.SETRANGE("Academic Year", "Academic Year");
                                MainStudentSubjectCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                IF NOT MainStudentSubjectCS1.findfirst() THEN BEGIN
                                    MainStudentSubjectCS.init();
                                    MainStudentSubjectCS."Student No." := "No.";
                                    MainStudentSubjectCS."Original Student No." := DataItem1000000000."Original Student No.";
                                    MainStudentSubjectCS."Student Name" := "Student Name";
                                    MainStudentSubjectCS.Validate(Course, "Course Code");
                                    MainStudentSubjectCS.VALIDATE("Academic Year", "Academic Year");
                                    MainStudentSubjectCS.Term := Term;
                                    MainStudentSubjectCS.VALIDATE(Semester, CourseWiseSubjectLineCS.Semester);
                                    // CourseSemesterMasterRec.Reset();
                                    // CourseSemesterMasterRec.SetRange("Course Code", CourseWiseSubjectLineCS."Course Code");
                                    // CourseSemesterMasterRec.SetRange("Semester Code", CourseWiseSubjectLineCS.Semester);
                                    // CourseSemesterMasterRec.SetRange("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                                    // CourseSemesterMasterRec.FindFirst();
                                    //MainStudentSubjectCS."Start Date" := CourseSemesterMasterRec."Start Date";
                                    //MainStudentSubjectCS."End Date" := CourseSemesterMasterRec."End Date";
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
                                    MainStudentSubjectCS.Level := CourseWiseSubjectLineCS.Level;
                                    MainStudentSubjectCS."Level Description" := CourseWiseSubjectLineCS."Level Description";
                                    MainStudentSubjectCS."Subject Group" := CourseWiseSubjectLineCS."Subject Group";
                                    //MainStudentSubjectCS."Goal Code" := CourseWiseSubjectLineCS."Goal Code";
                                    MainStudentSubjectCS.Term := Term;
                                    MainStudentSubjectCS."Term Description" := CourseWiseSubjectLineCS."Term Description";
                                    MainStudentSubjectCS.Examination := CourseWiseSubjectLineCS.Examination;
                                    MainStudentSubjectCS."Core Rotation Group" := CourseWiseSubjectLineCS."Core Rotation Group";
                                    if CourseWiseSubjectLineCS."Category Code" = '' then
                                        Error('Category code is not mapped for the subject code %1 in subject master and course subject line', CourseWiseSubjectLineCS."Subject Code")
                                    else
                                        MainStudentSubjectCS."Category-Course Description" := CourseWiseSubjectLineCS."Category Code";

                                    MainStudentSubjectCS.Insert();
                                END;
                            end;
                        end;
                    UNTIL CourseWiseSubjectLineCS.NEXT() = 0
                ELSE
                    //CurrReport.Skip();
                    error('There is no Course Subject Lines are mapped for Course Code %1..Semester %2..Academic Year %3..Institute Code %4', "Course Code", Semester, "Academic Year", "Global Dimension 1 Code");

            end;

            trigger OnPostDataItem()
            begin

            end;

            trigger OnPreDataItem()
            begin
                IF StudentNoCode <> '' then
                    SetRange("No.", StudentNoCode);
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
        //MESSAGE('Done');
    end;

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";
        CourseSemesterMasterRec: Record "Course Sem. Master-CS";

        StudentNoCode: Text;

    procedure Setdata(_Rec: Record "Student Master-CS")
    begin
        StudentNoCode := _Rec."No.";
    end;
}



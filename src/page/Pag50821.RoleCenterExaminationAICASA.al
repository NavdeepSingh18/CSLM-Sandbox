page 50821 "Examination Role Center AICASA"
{
    PageType = RoleCenter;
    UsageCategory = Administration;
    Caption = 'Examination Role Center';

    layout
    {
        area(RoleCenter)
        {

            part(Part1; RoleCenterHeadlineExamination)
            {
                ApplicationArea = All;
            }
            part(Activities; RoleCenterExamAICASACuepage)
            {
                ApplicationArea = All;
            }
            //SD-SN-04-Dec-2020 +

            part(chart1; "Course Wise Student Chart")
            {
                Caption = 'Course wise Student Chart';
                ApplicationArea = All;
                Visible = true;
            }
            part(Chart2; "Semester Wise Student Chart")
            {
                ApplicationArea = basic, suite;
                Visible = true;
            }
            part(Chart3; "Exam Sub. Wise student")
            {
                Caption = 'Exam subject wise student';
                Visible = false;
                ApplicationArea = All;
            }
            group(StudentList)
            {
                Caption = 'Students List';
                part("Students"; "Student Detail ListPart")
                {
                    Caption = 'Student List';
                    ApplicationArea = All;
                }
            }
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = All;
                visible = true;
            }
            systempart(Control1901377608; MyNotes)
            {
                Caption = 'My Notes';
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(Sections)
        {
            group("Examination")
            {


                group(Setups)
                {

                    action("Exam Classification")
                    {
                        RunObject = Page "50160";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Subject Classification")
                    {
                        RunObject = Page "50003";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Exam Slot List")
                    {
                        RunObject = Page "50103";
                        ApplicationArea = Basic, Suite;
                    }

                    action("Grade Input List")
                    {
                        RunObject = Page "Grade Input List";
                        ApplicationArea = all;
                    }
                    action("Grade Master List")
                    {
                        RunObject = Page "Grade List-CS";
                        ApplicationArea = all;
                    }

                    action("Recommendation List")
                    {
                        RunObject = Page "Recommendation List";
                        ApplicationArea = all;
                    }
                }
                Group("Scores Upload")
                {
                    action("Publish Score List")
                    {
                        RunObject = page 50613;
                        ApplicationArea = All;
                    }
                    action("Published Score List")
                    {
                        RunObject = page PublishedScoreList;
                        ApplicationArea = All;
                    }
                }
                group("External Examinations")
                {
                    action("Exam Schedule List")
                    {
                        RunObject = Page "50083";
                        ApplicationArea = Basic, Suite;
                    }
                    action("External Exam List")
                    {
                        RunObject = Page "External Student List-CS";
                        ApplicationArea = Basic, Suite;
                    }
                    action("External Exam Published List")
                    {
                        RunObject = Page "External Exam Published List";
                        ApplicationArea = all;
                    }
                    action("External Exam Line Ledger")
                    {
                        RunObject = page "External Exam Line Ledgers";
                        ApplicationArea = All;
                    }
                }
                Group("Internal Examination")
                {
                    action("Internal Exam-Schedule List")
                    {
                        RunObject = Page "Internal Exam Schedule List";
                        ApplicationArea = All;
                    }
                    action("Internal Exams")
                    {
                        RunObject = page "Internal Student List-CS";
                        ApplicationArea = All;
                    }
                    action("Published Internal Exams")
                    {
                        RunObject = page "Internal Exam Published List";
                        ApplicationArea = All;
                    }
                    action("Internal Exam Line Ledger")
                    {
                        RunObject = page "Internal Exam Line Ledgers";
                        ApplicationArea = All;
                    }

                }
                Group("Grades")
                {
                    action("Export Grades")
                    {
                        RunObject = xmlport "Export Grades";
                        ApplicationArea = All;
                    }
                    action("Import Grades")
                    {
                        RunObject = xmlport "Import Grades";
                        ApplicationArea = All;
                    }
                    action("Grade Book Calculations")
                    {
                        RunObject = Page "Grade Calculation";
                        ApplicationArea = all;
                    }
                    action("Grade Book Open")
                    {
                        RunObject = Page GradeBooks;
                        ApplicationArea = all;
                    }
                    action("Grade Book Pending For Approval")
                    {
                        RunObject = Page GradeBooksPendApp;
                        ApplicationArea = all;
                    }
                    action("Grade Book Approved")
                    {
                        RunObject = Page GradeBooksApproved;
                        ApplicationArea = all;
                    }
                    action("Grade Book Published")
                    {
                        RunObject = Page GradeBooksPublished;
                        ApplicationArea = all;
                    }
                    action("Grade Book Status Ledger")
                    {
                        RunObject = Page GradeBookHeaderLedgerList;
                        ApplicationArea = all;
                        Caption = 'Grade Book Status Ledger';
                    }

                }
                group("Student Semester Decision")
                {
                    action("Open Student Semester Decision")
                    {
                        RunObject = Page StudentSemesterDecisionList;
                        ApplicationArea = all;
                    }
                    action("Pending Student Semester Decision")
                    {
                        RunObject = Page StudentSemesterDecisionPenList;
                        ApplicationArea = all;
                    }
                    action("Approved Student Semester Decision")
                    {
                        RunObject = Page StudentSemesterDecisionAppList;
                        ApplicationArea = all;
                    }
                    action("Rejected Student Semester Decision")
                    {
                        RunObject = Page StudentSemesterDecisionRejList;
                        ApplicationArea = all;
                    }
                }

                group(Report)
                {
                    action("ICM Marks")
                    {
                        RunObject = report 50163;
                        ApplicationArea = All;
                    }
                    action("Student Marks")
                    {
                        RunObject = report 50191;
                        ApplicationArea = All;
                    }
                    action("Student Exam Stats")
                    {
                        RunObject = report "Student Exam Stats";
                        ApplicationArea = all;
                    }
                    action("Grade Book")
                    {
                        RunObject = report "Grade Book";
                        ApplicationArea = all;
                    }
                    action("Grade Center")
                    {
                        RunObject = Report "Student Grade Center";
                        ApplicationArea = All;
                    }
                    action("Column statistics - Descriptive stats")
                    {
                        RunObject = Report ExternalExamStats;
                        ApplicationArea = All;
                    }
                }
            }
            group(Academics)
            {
                group("Academic Master")
                {

                    action("Student List")
                    {
                        RunObject = Page "Student Details-CS";      //50296
                        ApplicationArea = All;

                    }
                    action("Education Calendar List")
                    {
                        RunObject = Page "Educ. Time Table List-CS";        //50022
                        ApplicationArea = All;
                    }
                    action("Course Subject List")
                    {
                        RunObject = Page "Stud. Course Subject List-CS";        //50174
                        ApplicationArea = All;
                    }
                    action("Course Wise Faculty")
                    {
                        RunObject = Page "Faculty-Course Wise";      //50059
                        ApplicationArea = All;
                    }
                    action("Student Subject List")
                    {
                        RunObject = Page "Subject Student-CS";      //50001
                        ApplicationArea = All;
                    }
                    // action("Student Optional Subject List")
                    // {
                    //     RunObject = Page "Opt. Subject of Student-CS";      //50004
                    //     ApplicationArea = All;
                    // }

                    action("Subject Master List")
                    {
                        RunObject = Page "Subject Detail -CS";      //50298
                        ApplicationArea = All;
                    }

                    action("Exam Passing Criteria List")
                    {
                        RunObject = Page "50980";
                        ApplicationArea = All;
                    }

                    action("Course List")
                    {
                        RunObject = Page "50291";
                        ApplicationArea = All;
                    }
                }
                group("Academics Periodic Activities")
                {
                    action("Course Wise Faculty Upload")
                    {
                        RunObject = Xmlport "Faculty Course Wise-CS";       //XMLPort 50005
                        ApplicationArea = All;
                    }
                }
                group("Academics List")
                {
                    action("Attendance Student List")
                    {
                        RunObject = page "Attendance Student-CS";       //50010
                        ApplicationArea = All;
                    }
                }
            }
            group(Evaluation)
            {
                group("Grade Master")
                {
                    action("Grade List")
                    {
                        RunObject = page "Grade List-CS";       //50184
                        ApplicationArea = All;
                    }
                }
                group("List")
                {
                    action("Grade Allocatoin List")
                    {
                        RunObject = page "Allocation Grade List-CS";        //50078
                        ApplicationArea = All;
                    }
                }
            }

        }
    }
}
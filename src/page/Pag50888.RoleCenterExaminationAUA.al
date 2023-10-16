page 50888 "Examination Role Center AUA"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; "Headline RC Team Member")
            {
                ApplicationArea = All;
            }
            part(Activities; RoleCenterExamAICASACuepage)
            {
                ApplicationArea = Basic, Suite;
            }
            //SD-SN-04-Dec-2020 +
            part(Chart1; "Sem. Wise Stud.Chart(Exam)")
            {
                Caption = 'Semester wise Student Chart';
                ApplicationArea = Basic, suite;
                Visible = true;
            }
            //SD-SN-04-Dec-2020 -
            group(ExamScheduleList)
            {
                Caption = 'Exam Schedule List';
                Part("Exam Schedule List"; "Schedule(Exam) List Part-CS")
                {
                    Caption = 'Exam Schedule List';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(ExamGroupCode)
            {
                Caption = 'Exam Group Code';
                part("Exam Group"; "Group(Exam)-CS")
                {
                    Caption = 'Exam Group Code';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(StudentList)
            {
                Caption = 'Students List';
                part("Students"; "Student Detail ListPart")
                {
                    Caption = 'Student List';
                    ApplicationArea = Basic, Suite;
                }
            }
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
            }
            systempart(Control1901377608; MyNotes)
            {
                Caption = 'My Notes';
                ApplicationArea = Basic, Suite;
            }

        }
    }

    actions
    {
        area(Sections)
        {

            group("Student Promotion")
            {
                group("Promotion Master")
                {
                    action("Student Promotion Credit Criteria")
                    {
                        RunObject = Page "Credit Criteria Promotion-CS";        //50168
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Promotion List")
                {
                    action("Student Promotion List")
                    {
                        RunObject = Page "Promotion Student List-CS";       //50052
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Examination")
            {
                group("Exam Master")
                {
                    action("Exam Classification")
                    {
                        RunObject = page "Exam Classification Detail-CS";       //50160
                        ApplicationArea = Basic, Suite;
                    }
                    action("Batch Master List")
                    {
                        RunObject = Page "Batch Detail-CS";     //50012
                        ApplicationArea = Basic, Suite;
                    }
                    action("Exam Room List")
                    {
                        RunObject = page "Room Detail-CS";      //50139
                        ApplicationArea = Basic, Suite;
                    }
                    action("Exam Code List")
                    {
                        RunObject = page "Code(Exam) List-CS";      //50067
                        ApplicationArea = Basic, Suite;
                    }
                    action("Exam Group Code")
                    {
                        RunObject = page "Group(Exam)-CS";      //50109
                        ApplicationArea = Basic, Suite;
                    }
                    action("Exam Slot List")
                    {
                        RunObject = page "Slot(Exam) List-CS";      //50103
                        ApplicationArea = Basic, Suite;
                    }
                    action("Subject Classification")
                    {
                        RunObject = page "Subject Detail Clsific-CS";       //50003
                        ApplicationArea = Basic, Suite;
                    }
                    action("Reason Master List")
                    {
                        RunObject = page "Reason Master List-CS";       //50023
                        ApplicationArea = Basic, Suite;
                    }
                    action("Grade Input List")
                    {
                        RunObject = page "Grade List-CS";       //50184
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Recommendation Master List")
                    // {
                    //     //RunObject = page "";
                    //     ApplicationArea = basic, suite;
                    // }
                }
                group("Examination List")
                {
                    // action("Revolution List")
                    // {
                    //     RunObject = page "Detail Revaluation-CS";       //50014
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("GPA List")
                    // {
                    //     //RunObject = page "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                // group("External Exams")
                // {
                //     action("External Exam Marks Entry")
                //     {
                //         //RunObject = page "";
                //         ApplicationArea = Basic, Suite;
                //     }
                //     action("External Exam Schedule List")
                //     {
                //         //RunObject = page "";
                //         ApplicationArea = Basic, Suite;
                //     }
                //     action("External Exam Attendance List")
                //     {
                //         //RunObject = page "";
                //         ApplicationArea = Basic, Suite;
                //     }
                // }
                // Group("Internal Exams")
                // {
                //     action("Internal Exam Schedule List")
                //     {
                //         //RunObject = page "";
                //         ApplicationArea = basic, suite;
                //     }
                //     action("Internal Exam Marks Entry")
                //     {
                //         //RunObject = page "";
                //         ApplicationArea = basic, suite;
                //     }
                //     action("Student Assignment List")
                //     {
                //         //RunObject = page "";
                //         ApplicationArea = basic, suite;
                //     }
                //     action("Internal Exam Attendance List")
                //     {
                //         //RunObject = page "";
                //         ApplicationArea = basic, suite;
                //     }
                // }
                // group(Report)
                // {
                //     action("Reports on Historical Grades and Courses")
                //     {
                //         //RunObject = report 
                //         ApplicationArea = Basic, Suite;
                //     }
                // }
            }
            group(Academics)
            {
                group("Academic Master")
                {
                    action("Education Celendar List")
                    {
                        RunObject = Page "Educ. Time Table List-CS";        //50022
                        ApplicationArea = Basic, Suite;
                    }
                    action("Course Subject List")
                    {
                        RunObject = Page "Stud. Course Subject List-CS";        //50174
                        ApplicationArea = Basic, Suite;
                    }
                    action("Course Wise Faculty")
                    {
                        RunObject = Page "Faculty-Course Wise";      //50059
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Subject List")
                    {
                        RunObject = Page "Subject Student-CS";      //50001
                        ApplicationArea = Basic, Suite;
                    }

                    action("Student List")
                    {
                        RunObject = Page "Student Details-CS";      //50296
                        ApplicationArea = Basic, Suite;

                    }

                    action("Subject Master List")
                    {
                        RunObject = Page "Subject Detail -CS";      //50298
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Academics Periodic Activities")
                {
                    action("Course Wise Faculty Upload")
                    {
                        RunObject = Xmlport "Faculty Course Wise-CS";       //XMLPort 50005
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Academics List")
                {
                    action("Attendance Student List")
                    {
                        RunObject = page "Attendance Student-CS";       //50010
                        ApplicationArea = Basic, Suite;
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
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("List")
                {
                    action("Grade Allocatoin List")
                    {
                        RunObject = page "Allocation Grade List-CS";        //50078
                        ApplicationArea = basic, suite;
                    }
                }
            }

        }
    }
}
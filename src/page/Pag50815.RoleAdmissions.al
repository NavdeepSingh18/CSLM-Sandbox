page 50815 "Admissions Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineAdmission)
            {
                ApplicationArea = All;
            }
            // part(Activities; AdmissionRoleCenterCuepage)//"RoleCenterCuepage")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            //SD-SN-04-Dec-2020 +
            // part(Chart1; "Course Wise Student Chart")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;
            // }
            // part(Chart2; "Semester Wise Student Chart")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;
            // }//SD-SN-04-Dec-2020 -

            //SN-25-DEC-20  +
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
            }//SN-25-DEC-20 -
            group(StudentList)
            {
                Caption = 'Students List';
                // part("Students"; "Student Detail ListPart")
                // {
                //     Caption = 'Student List';
                //     ApplicationArea = Basic, Suite;
                // }
            }
            group(CourseList)
            {
                Caption = 'Course List';
                part(Course; "Course Detail")
                {
                    Caption = 'Course List';
                    ApplicationArea = Basic, Suite;
                }
            }
            // group(StudentStatusDeferredDeclinedList)
            // {
            //     caption = 'Student Status Deferred/Declined List';
            //     //"Deferred/Declined Buffer"
            //     part(StudStatus; "Defrd/Declined Bfr List Part")
            //     {//"Deferred/Declined Buffer List" - given page is API
            //         caption = 'Student Status Deferred/Declined List';
            //         ApplicationArea = Basic, Suite;
            //     }
            // }

            // group(StudentTransferList)
            // {
            //     Caption = 'Student Transfer List';
            //     part("Student Transfer List"; "Student Branch Tranfr ListPart")
            //     {
            //         caption = 'Student Transfer List';
            //         ApplicationArea = Basic, Suite;

            //     }
            // }
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
            group(Admission)
            {
                group("Admission Master")
                {
                    action("Student List")
                    {
                        RunObject = page "Student Details-CS";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Session List")
                    {
                        RunObject = Page "Session Detail-CS";//"50294";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Course Subject Line List")
                    {
                        RunObject = Page "Course Sub L Un Editable-CS";//"50235";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Academic Year List")
                    {
                        RunObject = Page "List Academic Year-CS";//"50033";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Semester List")
                    {
                        RunObject = Page "Semester Detail-CS";//"50166";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Year List")
                    {
                        RunObject = Page "Year List College -CS";//"50055";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Group Master")
                    {
                        RunObject = Page "Group Detail-CS";//"50227";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Group")
                    {
                        RunObject = Page "Group(Student)-CS";//"50111";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Program List")
                    {
                        RunObject = Page "Graduation Detail-CS";//"50293";
                        ApplicationArea = Basic, Suite;
                    }

                    action("Course List")
                    {
                        RunObject = Page "Course Detail-CS";//"50291";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Section List")
                    {
                        RunObject = Page "Sections List-CS";//"50032";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Branch Transfer List")
                    {
                        Caption = 'Student Transfer List';
                        RunObject = Page "Student Branch Tranfr Dtl-CS";//"50269";
                        ApplicationArea = Basic, Suite;
                    }

                    action("Admission Calendar List")
                    {
                        RunObject = Page "Educ. Time Table List-CS";//"50022";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Admission Report")
                {
                    action("Country Wise Strength")
                    {
                        RunObject = Report "Country Wise Strength";//"50074";
                        ApplicationArea = Basic, Suite;
                    }
                    action("New Student WithoutSchoolEmail")
                    {
                        RunObject = Report "New Student WithoutSchoolEmail";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("View Student Group")
                    // {
                    //     Caption = 'View Student Group';
                    //     RunObject = page "View Students Group New";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Student Group Deatil")
                    // {
                    //     Caption = 'Student Group Deatil';
                    //     RunObject = page "Student Group Detail";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Broadcast E-Mail")
                    // {
                    //     Caption = 'Broadcast E-Mail';
                    //     RunObject = page "Broadcast E-Mail";
                    //     ApplicationArea = Basic, Suite
                    // }
                    action("E-Mail Notification List")
                    {
                        Caption = 'E-Mail Notification List';
                        RunObject = page "E-Mail Notification List";
                        ApplicationArea = Basic, Suite;
                    }

                }
                group("Admission Setups")
                {
                    action("Admission Setup")
                    {
                        RunObject = Page "Admission Setup-CS";//"50241";
                        ApplicationArea = Basic, Suite;
                    }
                }


            }
            Group("Housing")
            {

                group("Housing Periodic Activities")
                {
                    action("Pending Housing Application List")
                    {
                        RunObject = Page "Housing Application List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Housing Waiver List")
                    {
                        RunObject = Page "Pending Housing Wavier List";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Approved/Rejected Housing List")
                {
                    action("Approved/Rejected Housing Application")
                    {
                        RunObject = Page "Posted Housing Application";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Housing Waiver List")
                    {
                        RunObject = Page "Housing Wavier Approved List";
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
    }
}
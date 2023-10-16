page 50826 "Graduation Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineGraduation)
            {
                ApplicationArea = All;
            }
            part(Activities; "GraduationRoleCenterCuepage")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Chart1; "Total Degree/Certi Awarded")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(Chart2; "User Tasks Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part("Students"; "Student Detail ListPart")
            {
                Caption = 'Eligible Student List';
                SubPageView = where(Status = const('PENDGRAD|PGR'));
                ApplicationArea = Basic, Suite;
            }
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = false;
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
            group("Graduation Lists")
            {
                action("Task Master List")
                {
                    RunObject = page "User Task List"; //1170
                    ApplicationArea = Basic, Suite;
                }
                action("Degree List")
                {
                    RunObject = Page "Degree Detail-CS";//50157
                    ApplicationArea = Basic, Suite;
                }
                action("Course Degree")
                {
                    RunObject = Page "Course Degree";//50783
                    ApplicationArea = Basic, Suite;
                }
                action("Student Degree")
                {
                    RunObject = page "Student Degree";//50782
                    ApplicationArea = Basic, Suite;
                }
                Action("Course List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Course Detail-CS";
                }
                Action("Graduation Date Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Graduation Date Setup List";
                }

                Action("Email Setup(Transcript / Degree Request)")
                {
                    ApplicationArea = All;
                    Runobject = Page "Email Setup List";
                    RunPageView = where(Type = filter("Transcript/Degree"));
                }
                Action("Email Setup(Graduation Contact)")
                {
                    ApplicationArea = All;
                    Runobject = Page "Email Setup List";
                    RunPageView = where(Type = filter("Graduation Contact"));
                }
            }
            group("Degree Audit")
            {
                action("Eligible Student List")
                {
                    RunObject = Page "Student Detail-CS";//50011 
                    RunPageView = where(status = const('PENDGRAD|PGR'));
                    ApplicationArea = Basic, Suite;
                }
                action("Graduated Student List")
                {
                    RunObject = Page "Student Details-CS";//50296
                    RunPageView = where(status = const('GRAD'));
                    ApplicationArea = Basic, Suite;
                }
                action("Pending Degree Audit List")
                {
                    RunObject = page "Degree Audit list";//50893
                    RunPageView = where("Document Status" = filter("Pending for Verification"));
                    ApplicationArea = Basic, Suite;
                }
                action("Approved/ Rejected Degree Audit List")
                {
                    RunObject = page "Approved Rejected Degree Audit";//50896
                    ApplicationArea = Basic, Suite;
                }

            }

            group("Degree/Transcript Printing")
            {
                action("Pending Transcript Printing Request")
                {
                    caption = 'Pending Printing Request';
                    RunObject = Page "Certificates Application-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Completed Transcript Printing Request")
                {
                    Caption = 'Completed Printing Request';
                    RunObject = Page "Certificates Application -CS";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Students List")
            {
                action("Student List")
                {
                    RunObject = page "Student Details-CS";//50296
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Admission Master")
            {
                action("Group Master")
                {
                    RunObject = Page "Group Detail-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Student Group")
                {
                    RunObject = Page "Group(Student)-CS";
                    ApplicationArea = Basic, Suite;
                }

            }
        }
    }
}
page 50825 "Graduate Affairs Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineGraAffairs)
            {
                ApplicationArea = All;
            }
            Part(Activities; RoleCenterGradAffairsCuePage)
            {
                ApplicationArea = Basic, Suite;
            }
            part("Pndg MSPE Application List"; "Pending MSPE Application LP")
            {
                Caption = 'Pending MSPE Application List';
                ApplicationArea = Basic, Suite;
                visible = true;
            }
            part("Completed MSPE App Listpart"; "Completed MSPE App Listpart")
            {
                Caption = 'Completed MSPE Application List';
                ApplicationArea = Basic, Suite;
                visible = true;
            }

            part(Chart2; "Yearly Stud. Residency Status")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
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
            group("Graduate Affairs")
            {
                group("Residency Status Master")
                {
                    action("Residency Status List")
                    {
                        RunObject = page "Residency Status List";//50840
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("MSPE Application")
                {
                    group("MSPE Application (New)")
                    {
                        action("Pending MSPE Application List1")
                        {
                            Caption = 'Pending MSPE Application List';
                            RunObject = Page "Pending MSPE Application List";//50807
                            RunPageView = where("Application Type" = filter(New));
                            ApplicationArea = Basic, Suite;
                        }
                        action("In-Review MSPE Application List")
                        {
                            RunObject = page "In-Review MSPE App List";//50809
                            RunPageView = where("Application Type" = filter(New));
                            ApplicationArea = Basic, Suite;
                        }
                        action("Review Required MSPE Application List")
                        {
                            RunObject = page "Review Required MSPE App List";//50917
                            RunPageView = where("Application Type" = filter(New));
                            ApplicationArea = Basic, Suite;
                        }
                        action("Completed MSPE Application List1")
                        {
                            Caption = 'Completed MSPE Application List';
                            RunObject = page "Completed MSPE App List";//50918
                            RunPageView = where("Application Type" = filter(New));
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group("MSPE Application (Repeat)")
                    {
                        action("Pending MSPE Application List")
                        {
                            RunObject = Page "Pending MSPE Application List";//50807
                            RunPageView = where("Application Type" = filter(Repeated));
                            ApplicationArea = Basic, Suite;
                        }
                        action("Completed MSPE Application List")
                        {
                            RunObject = page "Completed MSPE App List";//50918
                            RunPageView = where("Application Type" = filter(Repeated));
                            ApplicationArea = Basic, Suite;
                        }
                    }
                }
                group(NRMP)
                {
                    action("NRMP Match List")
                    {
                        RunObject = page "NRMP Match List";//50804
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Residency Status List")
                    {
                        RunObject = page "Residency List";//50805
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Lists")
                    {
                        RunObject = page "Student List for Residency";//50923
                        ApplicationArea = Basic, Suite;
                    }
                    action("Residency Ledger")
                    {
                        RunObject = page "Residency Ledger";//50805
                        ApplicationArea = Basic, Suite;
                    }
                }

                Group("Post Graduate Form")
                {
                    Action("Post Graduate Request Form List")
                    {
                        RunObject = Page "Post Grd. Doc. Req. Form";
                        ApplicationArea = Basic, Suite;
                    }
                }

                Group("Residency P. Form")
                {
                    Caption = 'Residency Placement Form';
                    Action("Residency Placement Form")
                    {
                        Runobject = Page "Residency Plac. Result List";
                        ApplicationArea = Basic, Suite;
                    }
                }

                group("Hospital Details")
                {
                    action("Hospital List")
                    {
                        RunObject = Page "Hospital List";       //50435
                        ApplicationArea = Basic, Suite;
                    }

                }
                group(Licensing)
                {
                    action("License Tracking")
                    {
                        RunObject = page "License Tracking";//50925
                        ApplicationArea = Basic, Suite;
                    }
                    action("License Tracking Ledger")
                    {
                        RunObject = page "License Tracking Ledger";//50924
                        ApplicationArea = Basic, Suite;
                    }
                }

                group(Academics)
                {
                    Action("Student List")
                    {
                        RunObject = Page "Student Details-CS";       //50296
                        RunPageView = where(Year = filter(<> '1ST' & <> '2ND' & <> ' '));
                        ApplicationArea = Basic, Suite;
                    }

                    action("Student Subject Exam List")
                    {
                        caption = 'Student Subject Exam List';
                        ApplicationArea = All;
                        Image = List;
                        // Promoted = true;
                        // PromotedOnly = true;
                        // PromotedIsBig = true;
                        // PromotedCategory = Process;
                        RunObject = page "Student Subject Exam List";
                    }

                    action("Student Rotation Audit")
                    {
                        RunObject = page "Std Rotation Audit View";//50052
                        ApplicationArea = Basic, Suite;
                    }
                    action("Roster Ledger Entries")
                    {
                        RunObject = page "Roster Ledger";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Promotion List")
                    {
                        RunObject = page "Promotion Student List-CS";//50052
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Score Details")
                {
                    action("CCSE Score_1")
                    {
                        Caption = 'CCSE Score';
                        ApplicationArea = Basic, Suite;
                        // Promoted = true;
                        // PromotedOnly = true;
                        // PromotedIsBig = true;
                        // PromotedCategory = Process;
                        RunObject = page "Student Subject Exam List";
                        RunPageLink = "Score Type" = filter(CCSE);

                        //  ApplicationArea = Basic, Suite;
                    }
                    action("CCSSE Score")
                    {
                        Caption = 'CCSSE Score';
                        ApplicationArea = Basic, Suite;
                        // Promoted = true;
                        // PromotedOnly = true;
                        // PromotedIsBig = true;
                        // PromotedCategory = Process;
                        RunObject = page "Student Subject Exam List";
                        RunPageLink = "Score Type" = filter(CCSSE);
                        //ApplicationArea = Basic, Suite;
                    }
                    // action("Test")
                    // {
                    //     Caption = 'CCSSE Score';
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = page "Student Subject Exam List";
                    //     RunPageLink = "Score Type" = filter(CCSSE);
                    // }
                    action("CBSE Score_1")
                    {
                        Caption = 'CBSE Score';
                        ApplicationArea = Basic, Suite;
                        // Promoted = true;
                        // PromotedOnly = true;
                        // PromotedIsBig = true;
                        //PromotedCategory = Process;
                        RunObject = page "Student Subject Exam List";
                        RunPageView = where("Score Type" = filter('CBSE'));
                        //ApplicationArea = Basic, Suite;
                    }
                    action("USMLE Score")
                    {
                        ApplicationArea = Basic, Suite;
                        // Promoted = true;
                        // PromotedOnly = true;
                        // PromotedIsBig = true;
                        // PromotedCategory = Process;
                        RunObject = page "Student Subject Exam List";
                        RunPageView = where("Score Type" = filter("STEP 1" | "STEP 2 CK" | "STEP 2 CS"));
                    }
                }
                Group(Reports)
                {
                    action("MSPE 1st Time Applicants")
                    {
                        RunObject = Report "MSPE 1st Time Applicants";//50227
                        ApplicationArea = Basic, Suite;
                    }
                    action("MSPE Repeat Applicants")
                    {
                        RunObject = Report "MSPE Repeat Applicants";//50228
                        ApplicationArea = Basic, Suite;
                    }
                    action("MSPE Submitted Report")
                    {
                        RunObject = Report "MSPE Submitted Applicants";//50229
                        ApplicationArea = Basic, Suite;
                    }
                    action("MSPE Weekly Report")
                    {
                        RunObject = Report "MSPE Weekly Report";//50269
                        ApplicationArea = Basic, Suite;
                    }
                    action("View Student Group")
                    {
                        Caption = 'View Student Group';
                        RunObject = page "View Students Group New";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Group Deatil")
                    {
                        Caption = 'Student Group Deatil';
                        RunObject = page "Student Group Detail";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Broadcast E-Mail")
                    {
                        Caption = 'Broadcast E-Mail';
                        RunObject = page "Broadcast E-Mail";
                        ApplicationArea = Basic, Suite;
                    }
                    action("E-Mail Notification List")
                    {
                        Caption = 'E-Mail Notification List';
                        RunObject = page "E-Mail Notification List";
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
}
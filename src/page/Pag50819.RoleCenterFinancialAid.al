page 50819 "Financial Aid Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineFinancialAid)
            {
                ApplicationArea = All;
            }
            part(Activities; FinancialAidRoleCenterCuepage)
            {
                ApplicationArea = Basic, Suite;
            }
            part(Chart1; "Students by FA Roster")
            {
                visible = true;
                ApplicationArea = Basic, Suite;
            }
            part("Student Details-CS LP"; "Student Details-CS LP")
            {
                Caption = 'Student List';
                visible = true;
                ApplicationArea = Basic, Suite;
            }
            part("Pending Fin Aid Apps"; "Financial AID Pending Listpart")
            {
                Caption = 'Pending Financial Aid Application';
                visible = true;
                ApplicationArea = Basic, Suite;
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
            group("Financial Aid")
            {
                group("Financial Aid Master")
                {
                    Action("SAP Requirement Setup")
                    {
                        Runobject = Page "SAP Requirement Setup List";      //50972
                        ApplicationArea = Basic, Suite;
                    }

                    Action("FA Academic Year Setup")
                    {
                        RunObject = Page "FA Academic Year Setup List";     //50973
                        ApplicationArea = Basic, Suite;
                    }
                    action("ISIR Upload")
                    {
                        RunObject = page "ISIR File List";//50891
                        ApplicationArea = Basic, Suite;
                    }
                    action("SFP Activity")
                    {
                        RunObject = page "Student For SFP List";//50898
                        RunPageView = where("Type of FA Roster" = FILTER(SFP));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Legacy FA Loan Master")
                    {
                        RunObject = page "FA Loan Master";//50791
                        ApplicationArea = Basic, Suite;
                    }
                    action("Legacy FA Refund Master")
                    {
                        RunObject = page "FA Refund Master";//50792
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Financial Periodic Activities")
                {
                    action("Pending Financial Aid Application")
                    {
                        RunObject = page "Financial AID Pending List";//50652
                        ApplicationArea = Basic, Suite;
                    }

                    action("Pending ELOA Application")
                    {
                        RunObject = page "Pending Leaves Approvals";//50719
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(ELOA), "Approved for Department" = filter('FINANCIALAID'));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending CLOA Application")
                    {
                        RunObject = page "Pending Leaves Approvals";//50719
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(CLOA), "Approved for Department" = filter('FINANCIALAID'));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Withdrawal Application")
                    {
                        RunObject = page "Pending College Withdrawal";//50858
                        RunPageView = where("Approved for Department" = filter('FINANCIALAID'), "Type of Withdrawal" = FILTER("College-Withdrawal"));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Financial Aid Sign-Off")
                    {
                        RunObject = page "Pending Financial Aid SignOff";//50803
                        RunPageView = where("Financial Aid Hold" = filter(true), "Global Dimension 1 Code" = filter('9000'));
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Approved/Rejected Application List")
                {
                    action("Approved/Rejected Financial Aid Application")
                    {
                        RunObject = page "FinancialAIDApprovRejectList";//50653
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected ELOA Application")
                    {
                        RunObject = page "Approved Rejected Leave List";//50528
                        RunPageView = where("Leave Types" = filter(ELOA), "Approved By" = filter('FINANCIALAID'));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected CLOA Application")
                    {
                        RunObject = page "Approved Rejected Leave List";//50528
                        RunPageView = where("Leave Types" = filter(CLOA), "Approved by" = filter('FINANCIALAID'));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Withdrawal Application")
                    {
                        RunObject = page "Approved College Withdrawal";//50594
                        RunPageView = WHERE("Withdrawal Status" = FILTER(Approved), "Type of Withdrawal" = filter("College-Withdrawal"));
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Financial Aid Roster")
                {
                    action("Financial Aid Roster List")
                    {
                        RunObject = page "Financial Aid Roster";//50640
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Financial Aid Roster")
                    {
                        RunObject = page "Pending Financial Aid Roster";//50641
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Financial Aid Roster")
                    {
                        RunObject = page "FAid Roster Approved/Rejected";//50642
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Financial Aid Reports")
                {
                    action("SAFI Financial Entries Export")
                    {

                        RunObject = report "SAFI Financial Entries Export";
                        ApplicationArea = All;
                    }
                    action("KK Report")
                    {
                        RunObject = report "KK Report";//50221
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
            }
            group(Academics)
            {
                group("Academics Master")
                {
                    action("Student List")
                    {
                        RunObject = page "Student Details-CS";//50296
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Grade List")
                    {
                        RunObject = page "Grade List-CS";//50184
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Subject List")
                    {
                        RunObject = page "Subject Student-CS";//50001
                        RunPageView = where("Global Dimension 1 Code" = filter('9000'));
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group(Bursar)
            {
                group("Fee Master")
                {
                    action("Waiver List")
                    {
                        RunObject = page "Scholar. Source L-CS";//50257
                        RunPageView = where("Discount Type" = filter(Waiver));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Grant List")
                    {
                        RunObject = page "Scholar. Source L-CS";//50257
                        RunPageView = where("Discount Type" = filter(Grant));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Scholarship List")
                    {
                        RunObject = page "Scholar. Source L-CS";//50257
                        RunPageView = where("Discount Type" = filter(Scholarship));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Fee Component List")
                    {
                        RunObject = page "Fee Components Detail-CS";//50195
                        ApplicationArea = Basic, Suite;
                    }
                    action("Program Fee List")
                    {
                        RunObject = page "Fee Course Hdr List-CS";//50071
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Student Promotion")
            {
                group("Promotion List")
                {
                    action("Student Promotion List")
                    {
                        RunObject = page "Promotion Student List-CS";//50052
                        applicationarea = Basic, Suite;
                    }
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

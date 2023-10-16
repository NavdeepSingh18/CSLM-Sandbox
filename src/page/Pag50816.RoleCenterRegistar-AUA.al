page 50816 "Registrar Role Center AUA"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineRegistrar)
            {
                ApplicationArea = All;
            }
            // part(Activities; RegistrarRoleCenterCuepage)
            // {
            //     ApplicationArea = Basic, Suite;
            // }

            // part(Chart1; "Course Wise Student Chart")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;
            // }
            // part(Chart2; "Semester Wise Student Chart")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;
            // }
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
            }
            // part("Students"; "Student Detail ListPart")
            // {
            //     Caption = 'Students';
            //     ApplicationArea = Basic, Suite;
            // }
            part(Course; "Course Detail")
            {
                Caption = 'Course';
                ApplicationArea = Basic, Suite;
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
            group("In-Person Registration")
            {
                action("In-Person Registration Slots")
                {
                    RunObject = Page "In Person Registration";
                    ApplicationArea = all;
                }

                Action("OLR Returning Students Activation")
                {
                    RunObject = Page "OLR Returning Student List";
                    ApplicationArea = Basic, Suite;
                }
                action("OLR Returning Student Activation Details")
                {
                    RunObject = Page OLRUpdateLine;
                    ApplicationArea = Basic, Suite;
                }
                action("Student On Ground Check In")
                {
                    RunObject = page "Student On Ground CheckIn";
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                action("Pending On-Ground Check-In")
                {
                    RunObject = Page "On-Ground Check-In List"; //(50756, List)
                    ApplicationArea = Basic, Suite;
                    // Visible = False;
                }
                action("Pending On-Ground Check-In Completed")
                {
                    RunObject = Page "On-Ground Check-Completed List"; //(50757, List)
                    ApplicationArea = Basic, Suite;
                }

                Action("On-Ground Check In Completed")
                {
                    RunObject = Page "Completed On-Ground Check List";
                    ApplicationArea = Basic, Suite;
                }

                action("Pending Registrar Signoff")
                {
                    RunObject = Page "Registrar Sign off List"; //(50758, List)
                    ApplicationArea = Basic, Suite;
                    Visible = False;
                }

            }
            group(Registrar)
            {
                group("Registrar Master")
                {
                    action("Academic Department List")
                    {
                        RunObject = Page "Academic Department List"; //(50687, List)
                        ApplicationArea = Basic, Suite;
                    }
                    action("User Group List")
                    {
                        RunObject = Page "Workflow User Groups";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Withdrawal Department List")
                    {
                        RunObject = Page "Withdrawal Department List";//(50591,List)
                        RunPageLink = "Document Type" = filter(Withdrawal | "Withdrawal CLN");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Leaves Department List")
                    {
                        RunObject = Page "Withdrawal Department List";//(50591,List)
                        RunPageLink = "Document Type" = filter(<> Withdrawal & <> "Withdrawal CLN");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Course Degree")
                    {
                        RunObject = Page "Course Degree"; //(50783, List)
                        ApplicationArea = Basic, Suite;
                    }
                    action(Honors)
                    {
                        RunObject = Page "Honors"; //(50784, List)
                        ApplicationArea = Basic, Suite;
                    }
                    action("Registrar Team Mapping")
                    {
                        Caption = 'Assistant Registrar Mapping';
                        RunObject = page "Assistant Registrar Mapping";
                        RunPageMode = View;
                        Image = Vendor;
                        ApplicationArea = All;
                    }

                }
                group("Student Details")
                {
                    action("Student List")
                    {
                        RunObject = Page "Student Details-CS"; //(50296, List)
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Honors")
                    {
                        RunObject = Page "Student Honors"; //(50785, List)
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Degree")
                    {
                        RunObject = Page "Student Degree"; //(50782, List)
                        ApplicationArea = Basic, Suite;
                    }
                    action("Group wise Students")
                    {
                        RunObject = Page "Group Wise Students"; //(50899, List)
                        ApplicationArea = All;
                    }
                    action("View Student Group")
                    {
                        Caption = 'View Student Group';
                        RunObject = page "View Students Group New";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Group Detail")
                    {
                        Caption = 'Student Group Detail';
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
            group(Faculty)
            {
                action("Faculty Feedback")
                {
                    RunObject = Page "Feedback Detail-CS";//(50250, List)
                    ApplicationArea = Basic, Suite;
                }
                action(StudentAdvisorDetail)
                {
                    Caption = 'Student Advisor Detail';
                    RunObject = Page "Student Advisor Detail";//(50074, List)
                    ApplicationArea = Basic, Suite;
                }
            }

            group("Withdrawal")
            {
                group("Withdrawal Periodic Activities")
                {
                    action("College Withdrawal Application Form")
                    {
                        RunObject = Page "Stud. College Withdrawal List";
                        ApplicationArea = Basic, Suite;

                    }
                    action("Course Withdrawal Application Form")
                    {
                        RunObject = Page "Stud. Course Withdrawal List";
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }

                    action("Pending College Withdrawal Approvals List")
                    {
                        RunObject = Page "Pending College Withdrawal";
                        RunPageLink = "Type of Withdrawal" = filter("College-Withdrawal");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Course Withdrawal Approvals List")
                    {
                        RunObject = Page "Pending Withdrawal Approvals";
                        RunPageLink = "Type of Withdrawal" = filter("Course-Withdrawal");
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }
                }
                group("Withdrawal Approved Rejected Applications")
                {
                    action("Approved Course Department Withdrawal List")
                    {
                        RunObject = Page "Approved Course Department";
                        // RunPageLink = "Type of Withdrawal" = filter("Course-Withdrawal"), Status = FILTER(Approved);
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }
                    action("Approved College Department Withdrawal List")
                    {
                        RunObject = Page "Approved College Department";
                        // RunPageLink = "Type of Withdrawal" = filter("College-Withdrawal"), Status = FILTER(Approved);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved College Withdrawal List")
                    {
                        RunObject = Page "Approved College Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Approved);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Rejected College Withdrawal List")
                    {
                        RunObject = Page "Approved College Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Rejected);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Course Withdrawal List")
                    {
                        RunObject = Page "Approved Course Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Approved);
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }
                    action("Rejected Course Withdrawal List")
                    {
                        RunObject = Page "Approved Course Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Rejected);
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }

                }

            }
            group("Leave Of Absence")
            {
                group("Leave Periodic Activities")
                {
                    action("SLOA List")
                    {
                        RunObject = Page "SLOA List";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Short Leave Of Absence List';
                    }
                    action("ELOA List")
                    {
                        RunObject = Page "ELOA List";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Extended Leave Of Absence List';
                    }
                    action("CLOA List")
                    {
                        RunObject = Page "CLOA List";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Clinical Leave Of Absence List';
                    }
                    action("Pending SLOA Application List")
                    {
                        RunObject = Page "Pending Leaves Approvals";//"50719"
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(SLOA));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending ELOA Application List")
                    {
                        RunObject = Page "Pending Leaves Approvals";//"50719"
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(ELOA));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending CLOA Application List")
                    {
                        RunObject = Page "Pending Leaves Approvals";//"50719"
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(CLOA));
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Approved/Rejected Leaves")
                {
                    action("Approved Departmentwise SLOA Application Leave List")
                    {
                        RunObject = Page "Approved Departmentment Leave";        //50104
                        RunPageLink = status = filter(Approved | Rejected), "Type of Leaves" = filter(SLOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Departmentwise ELOA Application Leave List")
                    {
                        RunObject = Page "Approved Departmentment Leave";        //50104
                        RunPageLink = status = filter(Approved | Rejected), "Type of Leaves" = filter(ELOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Departmentwise CLOA Application Leave List")
                    {
                        RunObject = Page "Approved Departmentment Leave";        //50104
                        RunPageLink = status = filter(Approved | Rejected), "Type of Leaves" = filter(CLOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved SLOA Application Leave List")
                    {
                        RunObject = Page "Approved Rejected Leave List";//"50528"
                        RunPageLink = status = filter(Approved | Rejected), "Leave Types" = filter(SLOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved ELOA Application Leave List")
                    {
                        RunObject = Page "Approved Rejected Leave List";//"50528"
                        RunPageLink = status = filter(Approved | Rejected), "Leave Types" = filter(ELOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved CLOA Application Leave List")
                    {
                        RunObject = Page "Approved Rejected Leave List";//"50528"
                        RunPageLink = status = filter(Approved | Rejected), "Leave Types" = filter(CLOA);
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group(Examination)
            {
                Group("Scores Upload")
                {
                    action("Publish Score List")
                    {
                        RunObject = page PendingPublishScoreList;//50613
                        ApplicationArea = All;
                    }
                    action("Published Score List")
                    {
                        RunObject = page PublishedScoreList;//50978
                        ApplicationArea = All;
                    }
                    action("USMLE Window")
                    {
                        RunObject = page "USMLE Windows";//50986
                        ApplicationArea = All;
                    }
                    action("USMLE Change Log Entry List")
                    {
                        ApplicationArea = All;
                        RunObject = page "USMLE Change Log Entry List";//50721
                    }
                }
                group("Grades")
                {
                    action("Export Grades")
                    {
                        RunObject = xmlport "Export Grades";//50076
                        ApplicationArea = All;
                    }
                    action("Import Grades")
                    {
                        RunObject = xmlport "Import Grades";//50077
                        ApplicationArea = All;
                    }
                }
                group("Clerkship Assessment")
                {
                    group(Transaction)
                    {
                        action("CLN Assessment Student List")
                        {
                            Caption = 'Student List';
                            RunObject = page "Student Detail-CS";
                            RunPageMode = Edit;
                            Image = WorkCenter;
                            ApplicationArea = All;
                        }
                        action("Saved Assessment Scores")
                        {
                            RunObject = page "DocuSign Assessment Scores";
                            RunPageMode = Edit;
                            Image = WorkCenter;
                            ApplicationArea = All;
                        }
                        action("Published Assessment Scores")
                        {
                            RunObject = page "DocuSign Assessment Scores+";
                            RunPageMode = Edit;
                            Image = WorkCenter;
                            ApplicationArea = All;
                        }
                        action("Clerkship Assessment Report")
                        {
                            RunObject = report "Clerkship Assessment";
                            RunPageMode = Edit;
                            Image = WorkCenter;
                            ApplicationArea = All;
                        }
                        action("No Show Exam")
                        {
                            ApplicationArea = All;
                            RunObject = xmlport CCSSEScoreUpload;
                        }
                    }
                    group(Setup)
                    {
                        action("Clerkship Assessment Weightage")
                        {
                            RunObject = page "Clerkship Assessment Weightage";
                            RunPageMode = Edit;
                            Image = WorkCenter;
                            ApplicationArea = All;
                        }
                        action("Clerkship Grading")
                        {
                            RunObject = page "Clerkship Grading";
                            RunPageMode = Edit;
                            Image = WorkCenter;
                            ApplicationArea = All;
                        }
                        action("CCSSE Score Conversion")
                        {
                            RunObject = page "CCSSE Score Conversion";
                            RunPageMode = Edit;
                            Image = WorkCenter;
                            ApplicationArea = All;
                        }
                    }
                }
            }
            group(Applications)
            {
                Group("Elective Application")
                {
                    action("Elective Application List")
                    {
                        RunObject = page "Elective Application List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Elective Application List")
                    {
                        RunObject = page "Elective App Pending List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Elective Application List")
                    {
                        RunObject = page "Elective App Approved List";
                        ApplicationArea = Basic, Suite;
                    }

                }
                action("Pending Application List")
                {
                    RunObject = page "Certificates Application-CS";
                    RunPageLink = Status = filter(Pending);
                    ApplicationArea = Basic, Suite;
                }
                action("Completed Rejected Application List")
                {
                    RunObject = page "Certificates Application-CS";
                    RunPageLink = Status = filter(Completed | Rejected);
                    ApplicationArea = Basic, Suite;
                }

            }
            group("Clinical")
            {
                action("Clinical Assessment")
                {
                    RunObject = Page "DocuSign Assessment Scores";
                    ApplicationArea = Basic, Suite;
                }
                action("Rotation GAP Analysis")
                {
                    RunObject = page "Rotation GAP Analysis";
                    ApplicationArea = All;
                }
                action("TWD Analysis")
                {
                    RunObject = page "TWD Analysis";
                    ApplicationArea = All;
                }
                action("Clinical Semester Analysis")
                {
                    RunObject = report "Clinical Semester Progression";
                    ApplicationArea = all;
                }
                action("Missing Grades")
                {
                    RunObject = report "Missing Grade";
                    ApplicationArea = all;
                }
                action("First Core Report")
                {
                    RunObject = report "1st Core";
                    ApplicationArea = all;
                }
                action("FIU Core Rotation Passed")
                {
                    RunObject = Report "FIU Core Rotation Passed";
                    ApplicationArea = All;
                }
                action("Cancelled Rotation Grade Update")
                {
                    Runobject = Page "Rotation Grade Updation";
                    ApplicationArea = All;
                }
                Action("Roster Ledger R-Grade Report")
                {
                    RunObject = Report "Roster Ledger R Grade Report";
                    ApplicationArea = All;
                }

            }
            group("Admission Master")
            {
                action("Session List")
                {
                    RunObject = Page "Session Detail-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Course Subject Line List")
                {
                    RunObject = Page "Course Sub L Un Editable-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Academic Year List")
                {
                    RunObject = Page "List Academic Year-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Semester List")
                {
                    RunObject = Page "Semester Detail-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Year List")
                {
                    RunObject = Page "Year List College -CS";
                    ApplicationArea = Basic, Suite;
                }


                action("Student Group")
                {
                    RunObject = Page "Group(Student)-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Program List")
                {
                    RunObject = Page "Graduation Detail-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Course List")
                {
                    RunObject = Page "Course Detail-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Section List")
                {
                    RunObject = Page "Sections List-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Withdrawal List")
                {
                    RunObject = Page "Stud. College Withdrawal List";
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Reports)
            {
                action("On Ground Check In Student (AUA)")
                {
                    RunObject = Report "On Ground Students AUA";
                    ApplicationArea = All;
                }
                action("On Ground Check In Student (AICASA)")
                {
                    RunObject = report "On Ground Students AICASA";
                    ApplicationArea = All;
                }

                action("On Ground Check In Student Subject Details (AUA)")
                {
                    RunObject = Report OnGroundCheckInStudSubjAUA;
                    ApplicationArea = All;
                }
                action("On Ground Check In Student Subject Details (AICASA)")
                {
                    RunObject = report "On Ground Stud Subj AICASA";
                    ApplicationArea = All;
                }
                Action("Students That Have Not Registered")
                {
                    RunObject = Report StudentUAT;
                    ApplicationArea = All;
                }
                Action("Student Hold Status Report")
                {
                    RunObject = Report "Student Hold Status";
                    ApplicationArea = All;
                }
                Action("Step 1 Scores")
                {
                    RunObject = Report "Step 1 Scores";
                    ApplicationArea = All;
                }
                action("Step 2 CS Scores")
                {
                    RunObject = Report "Step 2 CS Scores";
                    ApplicationArea = Basic, Suite;
                }
                Action("Step 2 CK Scores")
                {
                    RunObject = Report "Step 2 CK Scores";
                    ApplicationArea = Basic, Suite;
                }
                Action("CCSE Scores")
                {
                    ApplicationArea = All;
                    RunObject = Report CCSEScores;
                }
                Action("Step 1 Score Flattened")
                {
                    ApplicationArea = All;
                    RunObject = Report Step1ScoreFlattened;
                }
                Action("Step 2 CK Score Flattened")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Report Step2CKScoreFlattened;
                }
                Action("Step 2 CS Score Flattened")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Report Step2CSScoreFlattened;
                }
                Action("CCSE Score Flattened")
                {
                    ApplicationArea = All;
                    RunObject = Report "CCSE Scores Flattened ";
                }
                Action("CBSE Score Flattened")
                {
                    ApplicationArea = All;
                    RunObject = Report "CBSE Scores Flattened ";
                }
                Action("All Comprehensive and Step Exam Results")
                {
                    ApplicationArea = All;
                    RunObject = Report AllCompAndStepExamResult;
                }
            }
        }
    }
}
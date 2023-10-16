page 50844 "Academics Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            // part(Part1; RoleCenterHeadLineAcademics)
            // {
            //     ApplicationArea = All;
            // }
            // part(Activities; AcademicsRoleCenterCuepage)
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
            //     ApplicationArea = basic, suite;
            //     Visible = true;
            // }
            // part(ReportInbox; "Report Inbox Part")
            // {
            //     ApplicationArea = Basic, Suite;
            //     visible = true;
            // }
            // part("Students"; "Student Detail ListPart")
            // {
            //     Caption = 'Students';
            //     ApplicationArea = Basic, Suite;
            // }
            // part(EmplyeeList; EmployeeListPart)
            // {
            //     caption = 'Employee List';
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
            group("Academics")
            {
                group("Academics Setup")
                {
                    Visible = false;
                    action("Academic Setup")
                    {
                        RunObject = page "Col Academics Setup-CS";//"50163"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Education Setup")
                    {
                        RunObject = page "Education Setup-CS";//"50223"
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Academic Master")
                {
                    Visible = false;
                    action("Student List")
                    {
                        RunObject = page "Student Details-CS";//"50296"
                        ApplicationArea = basic, suite;
                    }
                    action("Course List")
                    {
                        RunObject = page "Course Detail-CS";//"50291"
                        ApplicationArea = basic, suite;
                    }
                    // action("User Group")
                    // {
                    //     RunObject = page "User Group Detail-CS";//"50267"
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Semester List")
                    {
                        RunObject = page "Semester Detail-CS";//"50166"
                        ApplicationArea = basic, suite;
                    }
                    action("Subject Master List")
                    {
                        RunObject = page "Subject Detail -CS";//"50298"
                        ApplicationArea = basic, suite;
                    }
                    action("Year Master List")
                    {
                        RunObject = page "Year List College -CS";//"50055"
                        ApplicationArea = basic, suite;
                    }
                    action("Event Master")
                    {
                        RunObject = page "Event Detail-CS";//"50119"
                        ApplicationArea = basic, suite;
                    }
                    action("Subject Type")
                    {
                        RunObject = page "Subject Type Detail-CS";//"50002"
                        ApplicationArea = basic, suite;
                    }
                    action("Subject Classification List")
                    {
                        RunObject = page "Subject Detail Clsific-CS";//"50003"
                        ApplicationArea = basic, suite;
                    }
                    action("Education Calendar List")
                    {
                        RunObject = page "Educ. Time Table List-CS";//"50022"
                        ApplicationArea = basic, suite;
                    }
                    action("Academic Year Master")
                    {
                        RunObject = page "List Academic Year-CS";//"50033"
                        ApplicationArea = basic, suite;
                    }
                    action("Room List")
                    {
                        RunObject = page "Room Detail-CS";//"50139"
                        ApplicationArea = basic, suite;
                    }
                    action("Employee List")
                    {
                        RunObject = page "Employee List";
                        ApplicationArea = basic, suite;
                    }
                    action("Graduation List")
                    {
                        RunObject = page "Graduation Detail-CS";//"50293"
                        ApplicationArea = basic, suite;
                    }
                    action("Section Master List")
                    {
                        RunObject = page "Sections List-CS";//"50032"
                        ApplicationArea = basic, suite;
                    }
                    action("Course Subject List")
                    {
                        RunObject = page "Stud. Course Subject List-CS";//"50174"
                        ApplicationArea = basic, suite;
                    }
                    action("Course Wise Faculty")
                    {
                        RunObject = page "Faculty-Course Wise";//"50059"
                        ApplicationArea = basic, suite;
                    }
                    action("Student Subject List")
                    {
                        RunObject = page "Subject Student-CS";//"50001"
                        ApplicationArea = basic, suite;
                    }

                    action("Student Branch Transfer List")
                    {
                        Caption = 'Student Transfer List';
                        RunObject = page "Student Branch Trnsfrd Dtl-CS";//"50270"
                        ApplicationArea = basic, suite;
                    }
                }
                group("Academic Lists")
                {
                    action("Attendance Tracking")
                    {
                        //CSPL-00307 T1-T1518
                        RunObject = Page "Attendance Tracking";//50122
                        ApplicationArea = basic, suite;
                    }
                    action("Student Section & Roll No List")
                    {
                        Visible = false;
                        RunObject = page "Roll No. & Student Section-CS";//"50138"
                        ApplicationArea = basic, suite;
                    }
                    // action("Revaluation List")
                    // {
                    //     RunObject = page "Detail Revaluation-CS";//"50014"
                    //     ApplicationArea = basic, suite;
                    // }

                    // action("Guardian Teacher List")
                    // {
                    //     RunObject = page "50112";
                    //     ApplicationArea = basic, suite;
                    //     Visible = false;
                    // }
                    // action("Student Registration List")
                    // {
                    //     RunObject = page "Registration Student Detail-CS";//"50016"
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Student Registration & Immigration List")
                    {
                        Visible = false;
                        RunObject = page "Sem. Reg. list-CS";//"50034"
                        ApplicationArea = basic, suite;
                    }
                    action("Student Immigration Upload Document List")
                    {
                        Visible = false;
                        RunObject = page "Immigration Document List";//"50535"
                        ApplicationArea = basic, suite;
                    }
                    // action("Portal User list")
                    // {
                    //     RunObject = page "Portal Users-CS";//"50040"
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Attendance Student List")
                    // {
                    //     RunObject = page "Attendance Student-CS";//"50010"
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Event Menu Availability Mapping")
                    // {
                    //     RunObject = page "Event Menu-CS";//"50177"
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Student All Subject Old Data")
                    // {
                    //     RunObject = page "All Sub. Old Data (Student)-CS";//"50080"
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Student Rank List")
                    // {
                    //     RunObject = page "Rank Student List-CS";//"50075"
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Compilation Course Withdrawal List")
                    // {
                    //     RunObject = page "50231";
                    //     ApplicationArea = basic, suite;
                    //     Visible = false;
                    // }
                    // action("Student Withdrawal List")
                    // {
                    //     RunObject = page "Stud. College Withdrawal List";//"50030"
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Achievement/Incident List")
                    // {
                    //     RunObject = page "50035";
                    //     ApplicationArea = basic, suite;
                    //     Visible = false;
                    // }
                    action("Attendance Request List")
                    {
                        Visible = false;
                        RunObject = page "Short List Document-CS";//"50079"
                        ApplicationArea = basic, suite;
                    }
                    action("Student Subject batch Update")
                    {
                        Visible = false;
                        RunObject = page "Sub Batch Student Up List-CS";//"50187"
                        ApplicationArea = basic, suite;
                    }
                    action("Exam Schedule")
                    {
                        Visible = false;
                        RunObject = page "Schedule(Exam) Line-CS";//"50081"
                        ApplicationArea = basic, suite;
                    }
                }
                // group("Application Certificate List")
                // {
                //     action("Application Certificate")
                //     {
                //         RunObject = page "Schedule(Exam) Line-CS";//"50081"
                //         ApplicationArea = basic, suite;
                //     }
                //     action("Application Certificate(Applied) ")
                //     {
                //         RunObject = page "Certificates Application-CS";//"50072"
                //         RunPageLink = Status = filter(Applied);
                //         ApplicationArea = Basic, Suite;
                //     }
                // }
                group("Academics Report")
                {
                    action("AICASA Students") //06-18-20")
                    {
                        RunObject = Report "AICASA Students";//"50182"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Semester 4 Students That Have Not Registered")
                    {
                        RunObject = Report "Sem 4 Student Not Registered";//"50179"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Fall 2020 Registration") // 06-25-20"
                    {
                        RunObject = Report "Fall 2020 Registration";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("View Student Group")
                    // {
                    //     Caption = 'View Student Group';
                    //     RunObject = page "View Students Group New";
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Student Group Deatil")
                    // {
                    //     Caption = 'Student Group Deatil';
                    //     RunObject = page "Student Group Detail";
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Broadcast E-Mail")
                    // {
                    //     Caption = 'Broadcast E-Mail';
                    //     RunObject = page "Broadcast E-Mail";
                    //     ApplicationArea = basic, suite;
                    // }
                    action("E-Mail Notification List")
                    {
                        Caption = 'E-Mail Notification List';
                        RunObject = page "E-Mail Notification List";
                        ApplicationArea = basic, suite;
                    }
                    // action("Student Hold Status")
                    // {
                    //     RunObject = Report "Student Hold Status";//"50166"
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUABasicScienceIDCard.")
                    // {
                    //     RunObject = Report "AUA Basic Science IDCard";//"50168"
                    //     ApplicationArea = Basic, Suite;
                    //     Visible = false;
                    // }
                    // action("AICASAIDCard")
                    // {
                    //     RunObject = Report "AICASA IDCard";//"50169"
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA5thSemesterIDCard")
                    // {
                    //     RunObject = Report "AUA 5th Semester IDCard";//50170
                    //     ApplicationArea = Basic, Suite;
                    //     Visible = false;
                    // }
                    // action("AUA College of Medicine Official Transcript")
                    // {
                    //     RunObject = Report "AUA Coll of MedicineTranscript";//"50190"
                    //     ApplicationArea = Basic, Suite;
                    //     Visible = false;
                    // }
                    // action("AUA College of Medicine Official Transcript (Transfer Credit, Legacy Data)")
                    // {
                    //     //RunObject = Report "";
                    //     Visible = false;
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA College of Medicine KMCIC Official Transcript")
                    // {
                    //     //RunObject = Report "";
                    //     Visible = false;
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA School of Nursing Transcript")
                    // {
                    //     RunObject = Report "AICASA School of Nursing";//50200
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA Transcript")
                    // {
                    //     //RunObject = Report "";
                    //     Visible = false;
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA BHHS Certificate")
                    // {
                    //     RunObject = Report "AUA BHHS Certificate";//"50187"
                    //     ApplicationArea = Basic, Suite;
                    //     Visible = false;
                    // }
                    // action("AUA Master of Health Science Degree")
                    // {
                    //     // RunObject = Report "50206";
                    //     Visible = false;
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA Doctor of Medicine Degree")
                    // {
                    //     RunObject = Report "AUA Doctor of Medicine Degree";//50203
                    //     Visible = false;
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA Associate of Science in Health Science Degree")
                    // {
                    //     RunObject = Report "AICASA ASHS Degree";//50204
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA EMT- Basic Certificate")
                    // {
                    //     RunObject = Report "AICASA EMT-Basic & Advanced";//50205
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA Associate of Science in Nursing Degree")
                    // {
                    //     RunObject = Report "AICASA AS Nursing Degree";//50202
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                //     group("Academic Periodic Activity")
                //     {
                //         action("Student Promtion Process Report")
                //         {
                //             RunObject = report "Student Promotion Process";//"50079"
                //             ApplicationArea = Basic, Suite;
                //         }
                //         action("Student Data Upload")
                //         {
                //             RunObject = xmlport "Student Data Upload-CS";//"50001"
                //             ApplicationArea = basic, suite;
                //         }
                //         action("Student Data Modification")
                //         {
                //             RunObject = xmlport "Student Data Modification";//"50002"
                //             ApplicationArea = basic, suite;
                //         }
                //         action("Course Wise Faculty Upload")
                //         {
                //             RunObject = xmlport "Faculty Course Wise-CS";//"50005"
                //             ApplicationArea = basic, suite;
                //         }
                //         action("Student Optional Subject Upload")
                //         {
                //             RunObject = xmlport "Student Subject OP";//"50007"
                //             ApplicationArea = basic, suite;
                //         }
                //         action("Student Subject Upload")
                //         {
                //             RunObject = xmlport "Student Subject";//"50008"
                //             ApplicationArea = basic, suite;
                //         }
                //         action("Subject Master Upload")
                //         {
                //             RunObject = xmlport "Subject Upload";//"50058"
                //             ApplicationArea = basic, suite;
                //         }
                //         action("Teacher Guardian Upload")
                //         {
                //             RunObject = xmlport "Teacher GuardianCS";//"50051"
                //             ApplicationArea = basic, suite;
                //         }
                //         action("Employee Upload")
                //         {
                //             RunObject = xmlport "EmployeeCS";//"50012"
                //             ApplicationArea = basic, suite;
                //         }
                //     }
                // }
                // group("In-Person Registration")
                // {
                //     action("Pending On-Ground Check-In")
                //     {
                //         RunObject = Page "On-Ground Check-In List"; //(50756, List)
                //         ApplicationArea = Basic, Suite;
                //     }
                //     action("Pending On-Ground Check-In Completed")
                //     {
                //         RunObject = Page "On-Ground Check-Completed List"; //(50757, List)
                //         ApplicationArea = Basic, Suite;
                //     }
                //     action("Pending Registrar Signoff")
                //     {
                //         RunObject = Page "Registrar Sign off List"; //(50758, List)
                //         ApplicationArea = Basic, Suite;
                //     }
            }
            group("Time Table")
            {
                Visible = false;
                group("Time Table Master")
                {
                    action("Time Slot List")
                    {
                        RunObject = Page "Time Slot L-CS";//"50258"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Time Table Template List")
                    {
                        RunObject = page "Template of Time Table-CS";//"50005"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Subject Group List")
                    {
                        RunObject = page "Subject Group Detail-CS";//"50225"
                        ApplicationArea = basic, suite;
                    }
                    action("Time Table Room List")
                    {
                        RunObject = page "Room Detail-CS";//"50139"
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("TimeTable Periodic Activites")
                {
                    Visible = false;
                    action("Time Table Template")
                    {
                        RunObject = page "Time Templt Name-CS";//"50259"
                        ApplicationArea = Basic, suite;
                    }
                    action("Time Table Header List")
                    {
                        RunObject = page "Time Table Hdr List-CS";//"50262"
                        ApplicationArea = Basic, suite;
                    }
                    action("Time Table List")
                    {
                        RunObject = page "Time Tbl Detail-CS";//"50281"
                        ApplicationArea = Basic, Suite;
                    }
                }
                //     group("TimeTabe Report")
                //     {
                //         action("Faculty Workload")
                //         {
                //             //RunObject = Report "";
                //             ApplicationArea = basic, suite;
                //         }
                //         action("Attendance Summary")
                //         {
                //             RunObject = report "Attendance Summary-CS";//"50087"
                //             ApplicationArea = Basic, Suite;
                //         }
                //         action("Attendance Summary(<75)")
                //         {
                //             RunObject = report "Attendance Summary(<75)CS";//"50088"
                //             ApplicationArea = Basic, Suite;
                //         }
                //         action("Attendance Day Wise")
                //         {
                //             RunObject = report "Attendance Day Wise-CS";//"50089"
                //             ApplicationArea = Basic, Suite;
                //         }
                //         action("TimeTable Report")
                //         {
                //             RunObject = report "Time Table Report New";//"50015"
                //             ApplicationArea = Basic, Suite;
                //         }
                //         action("Details of Event")
                //         {
                //             RunObject = page "Detail of Events-CS";//"50405"
                //             ApplicationArea = Basic, Suite;
                //         }
                //     }
                //     group("Student Promotion")
                //     {
                //         action("Student Promotion List")
                //         {
                //             RunObject = page "Promotion Student List-CS";//"50052"
                //             ApplicationArea = Basic, Suite;
                //         }
                //     }
            }

            group("Evaluation")
            {
                Visible = false;
                action("Grade Allocation List")
                {
                    RunObject = page "Allocation Grade List-CS";//"50078"
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Academic Progression")
            {

            }
            // group("Examination")
            // {
            //     group("Internal Periodic Activities")
            //     {
            //         action("Publish Internal Marks")
            //         {
            //             RunObject = report "Publish Internal Mark CS";//"50072"
            //             ApplicationArea = basic, suite;
            //         }
            //         action("Subject Maximum Marks Update Report")
            //         {
            //             RunObject = report "Subject Update Maximum Marks";//"50008"
            //             ApplicationArea = basic, suite;
            //         }
            //         action("Document ReTest Application List")
            //         {
            //             RunObject = page "Doc.Re Test Application-CS";//"50212"
            //             ApplicationArea = basic, suite;
            //         }
            //         action("Employee Open Entry List")
            //         {
            //             RunObject = page "Emp.Open Entry List-CS";//"50020"
            //             ApplicationArea = basic, suite;
            //         }
            //     }
            //     group("External Periodic Activities")
            //     {
            //         action("Invigilator Detail List")
            //         {
            //             RunObject = page "Invigilator Detail List-CS";//"50221"
            //             ApplicationArea = basic, suite;
            //         }
            //         action("Makeup & Special Exam List")
            //         {
            //             RunObject = page "Detail MakeUp Exam-CS";//"50015"
            //             ApplicationArea = basic, suite;
            //         }
            //         action("Revaluation 1 List")
            //         {
            //             RunObject = page "Detail Revaluation-CS";//"50014"
            //             ApplicationArea = basic, suite;
            //         }
            //         action("Revaluation 2 List")
            //         {
            //             RunObject = page "Revaluation List-CS";//"50189"
            //             ApplicationArea = basic, suite;
            //         }
            //         action("Publish External Marks Report")
            //         {
            //             RunObject = report "Publish External  Marks Report";//"50013"
            //             ApplicationArea = basic, suite;
            //         }
            //         action("Malpractice Level List")
            //         {
            //             RunObject = page "Discpl Master-Mal Practic-CS";//"50161"
            //             ApplicationArea = basic, suite;
            //         }
            //     }
            // }
            group("Withdrawal")
            {
                Visible = false;
                // Group("Withdrawal Setups")
                // {
                //     action("Withdrawal Setup")
                //     {
                //         RunObject = Page "Fee Setup List";
                //         ApplicationArea = Basic, Suite;
                //     }
                // }
                // group("Withdrawal Master")
                // {
                //     action("Academic Department List")
                //     {
                //         RunObject = Page "Academic Department List";
                //         ApplicationArea = Basic, Suite;
                //     }
                //     action("WIthdrawal Department List")
                //     {
                //         RunObject = Page "Withdrawal Department List";
                //         RunPageLink = "Document Type" = filter(Withdrawal);
                //         ApplicationArea = Basic, Suite;
                //     }
                //     action("Withdrawal Source List")
                //     {
                //         RunObject = Page "50257";
                //         ApplicationArea = Basic, Suite;
                //     }
                // }

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
                    // action("Pending College Withdrawal Approvals List")
                    // {
                    //     RunObject = Page "Pending College Withdrawal";
                    //     RunPageLink = "Type of Withdrawal" = filter("College-Withdrawal");
                    //     ApplicationArea = Basic, Suite;
                    // }
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
                    }
                    action("Rejected Course Withdrawal List")
                    {
                        RunObject = Page "Approved Course Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Rejected);
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Leave Of Absence")
            {
                Visible = false;
                group("Leave Periodic Activities")
                {
                    // action("Pending SLOA Application List")
                    // {
                    //     RunObject = Page "Pending Leaves Approvals";//"50719"
                    //     RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(SLOA));
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Pending ELOA Application List")
                    // {
                    //     RunObject = Page "Pending Leaves Approvals";//"50719"
                    //     RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(ELOA));
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Pending CLOA Application List")
                    // {
                    //     RunObject = Page "Pending Leaves Approvals";//"50719"
                    //     RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(CLOA));
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                group("Approved/Rejected Leaves")
                {
                    action("Approved SLOA Application Leave List")
                    {
                        RunObject = Page "Approved Rejected Leave List";//"50528"
                        RunPageLink = status = filter(Approved), "Leave Types" = filter(SLOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved ELOA Application Leave List")
                    {
                        RunObject = Page "Approved Rejected Leave List";//"50528"
                        RunPageLink = status = filter(Approved), "Leave Types" = filter(ELOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved CLOA Application Leave List")
                    {
                        RunObject = Page "Approved Rejected Leave List";//"50528"
                        RunPageLink = status = filter(Approved), "Leave Types" = filter(CLOA);
                        ApplicationArea = Basic, Suite;
                    }
                }
            }

            // group("Examination")
            // {
            //     group("Internal Exam")
            //     {
            //         action("Student Assignment list")
            //         {
            //             RunObject = Page "50054";
            //             ApplicationArea = Basic, Suite;
            //         }
            //         group("Internal Exam Lists")
            //         {
            //             action("Student Internal List")
            //             {
            //                 RunObject = Page "50097";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //         }
            //         group("Internal Exam Master")
            //         {

            //             action("Exam Code List")
            //             {
            //                 RunObject = Page "50067";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Exam Group Code")
            //             {
            //                 RunObject = Page "50109";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Reason Master List")
            //             {
            //                 RunObject = Page "50023";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Batch Master List")
            //             {
            //                 RunObject = Page "50012";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //         }
            //         group("Internal Periodic Activity")
            //         {
            //             action("Publish Internal Mark Report")
            //             {
            //                 RunObject = Report "50072";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Subject Maximum Marks Update Report")
            //             {
            //                 RunObject = Report "50008";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Document ReTest Application List")
            //             {
            //                 RunObject = Page "50212";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Employee Open Entry List")
            //             {
            //                 RunObject = Page "50020";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //         }
            //     }
            //     group("External Exam")
            //     {
            //         group("External Exam Master")
            //         {
            //             action("Exam Classification")
            //             {
            //                 RunObject = Page "50160";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Subject Classification")
            //             {
            //                 RunObject = Page "50003";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Exam Room List")
            //             {
            //                 RunObject = Page "50139";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Exam Slot List")
            //             {
            //                 RunObject = Page "50103";
            //                 ApplicationArea = Basic, Suite;
            //             }

            //         }
            //         group("External Exam Lists")
            //         {
            //             action("Exam Schedule List")
            //             {
            //                 RunObject = Page "50083";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Student External Exam Attendance List")
            //             {
            //                 RunObject = Page "50132";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Hall Ticket List")
            //             {
            //                 RunObject = Page "50290";
            //                 ApplicationArea = Basic, Suite;
            //             }

            //             action("External Student List")
            //             {
            //                 RunObject = Page "50100";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("CBSE Score")
            //             {
            //                 RunObject = page "CBSC Scores";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("CCSE Score")
            //             {
            //                 RunObject = page "CCSC Scores";
            //                 ApplicationArea = Basic, Suite;
            //             }

            //         }
            //         group("External Periodic Activity")
            //         {
            //             // action("Invigilator Detail List")
            //             // {
            //             //     RunObject = Page "50221";
            //             //     ApplicationArea = Basic, Suite;
            //             // }
            //             // action("Makeup & Special Exam List")
            //             // {
            //             //     RunObject = Page "50015";
            //             //     ApplicationArea = Basic, Suite;
            //             // }
            //             // action("Revaluation 1 List")
            //             // {
            //             //     RunObject = Page "50014";
            //             //     ApplicationArea = Basic, Suite;
            //             // }
            //             // action("Revaluation 2 List")
            //             // {
            //             //     RunObject = Page "50189";
            //             //     ApplicationArea = Basic, Suite;
            //             // }
            //             action("Publish External  Marks Report")
            //             {
            //                 RunObject = Report "50013";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             // action("MalPractice Level List")
            //             // {
            //             //     RunObject = Page "50161";
            //             //     ApplicationArea = Basic, Suite;
            //             // }
            //         }
            //         group("External Exam Report")
            //         {
            //             action("Detained Student List")
            //             {
            //                 RunObject = Report "50064";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Student Grade Report")
            //             {
            //                 RunObject = Report "50066";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Seating Allocation Report(Regular)")
            //             {
            //                 RunObject = Report "50084";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Seating Allocation Report(Makeup)")
            //             {
            //                 RunObject = Report "50085";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Invigilator Report Makeup")
            //             {
            //                 RunObject = Report "50021";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Invigilator Report Regular")
            //             {
            //                 RunObject = Report "50051";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Subject Wise Exam Strength")
            //             {
            //                 RunObject = Report "50014";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Seat Allocation Section Wise")
            //             {
            //                 RunObject = Report "50017";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Acknowledgement Report")
            //             {
            //                 RunObject = Report "50016";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Seating Allocation Not Done")
            //             {
            //                 RunObject = Report "50001";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Subject Credit CutOff List")
            //             {
            //                 RunObject = Report "50056";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Seat Allot Section Wise <>1st Makeup")
            //             {
            //                 RunObject = Report "50067";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Total Mark Admin Dept with Grade")
            //             {
            //                 RunObject = Report "50070";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //             action("Program Result")
            //             {
            //                 RunObject = Report "50047";
            //                 ApplicationArea = Basic, Suite;
            //             }
            //         }
            //     }
            // }
            // group("Housing")
            // {
            //     group("Housing Periodic Activities")
            //     {
            //         action("Pending Housing Applicaton")
            //         {
            //             RunObject = Page "Housing Application List";//"50421"
            //             ApplicationArea = Basic, Suite;
            //         }
            //         //SD-SB-18-JAN-21 +
            //         action("Pending Housing Waiver Application")
            //         {
            //             RunObject = Page "Pending Housing Wavier List";//"50573"
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Pending Housing Change Request")
            //         {
            //             RunObject = Page "Housing Change Request List";//"50423"
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Pending Housing Vacate Request")
            //         {
            //             RunObject = Page "Housing Vacate Request List";//"50428"
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Pending Housing Re-registration Request")
            //         {
            //             RunObject = Page "Housing Re-Registration List";//"50706"
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Pending Housing Issue List")
            //         {
            //             RunObject = Page "Housing Issue Pending List";//"50468"
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Pending Immigration List")
            //         {
            //             RunObject = Page "Immigration list";//"50693"
            //             RunPageView = sorting("Document No.") where("Document Status" = filter("Pending for Verification"));
            //             ApplicationArea = Basic, Suite;
            //         }
            //         //SD-SB-18-JAN-21 -
            //     }
            //     group("Approved/Rejected Housing List")
            //     {
            //         action("Approved/Rejected Housing Application")
            //         {
            //             RunObject = Page "Posted Housing Application"; //50432
            //             RunPageLink = Status = filter(Approved | Rejected);
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Approved/Rejected Change Request")
            //         {
            //             RunObject = page "Approve Reject Housing Change"; //50426
            //             RunPageLink = type = filter("Change Request");
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Approved/Rejected Vacate Request")
            //         {
            //             RunObject = page "Approve Reject Housing Change"; //50426
            //             RunPageLink = type = filter(Vacate);
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Approved/Rejected Re-Registration Request")
            //         {
            //             RunObject = page "Approve Reject Housing Change"; //50426
            //             RunPageLink = type = filter("Re-Registration");
            //             ApplicationArea = Basic, Suite;
            //         }

            //         action("Approved/Rejected Financial Accountability")
            //         {
            //             RunObject = Page "Approve/Reject Fin Account"; //50701
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Approved/Rejected Housing Waiver List")
            //         {
            //             RunObject = Page "Housing Wavier Approved List";//50571
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Approved/Rejected Immigration List")
            //         {
            //             RunObject = Page "Immigration Approved list"; //50713
            //             ApplicationArea = Basic, Suite;
            //         }
            //         action("Rejected Housing Issue List")
            //         {
            //             RunObject = Page "Closed Housing Issue List";//50470
            //             RunPageLink = Status = filter(Rejected);
            //             ApplicationArea = Basic, Suite;
            //         }
            //     }
            // }

        }
    }
}
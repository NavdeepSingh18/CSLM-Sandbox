
page 50096 RoleCenterName
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
            part(Activities; "RoleCenterCuepage")
            {
                ApplicationArea = Basic, Suite;
            }
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
            group(CourseList)
            {
                Caption = 'Course';
                part(Course; "Course Detail")
                {
                    Caption = 'Course';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(StudentList)
            {
                Caption = 'Students On Roll';
                part("Students"; "Student Detail")
                {
                    Caption = 'Students';
                    ApplicationArea = Basic, Suite;
                }
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
            group(Admission)
            {
                group("Admission Master")
                {
                    // action("Student List")
                    // {
                    //     RunObject = Page "50296";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("Session List")
                    // {
                    //     RunObject = Page "50294";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Course Subject Line List")
                    // {
                    //     RunObject = Page "50235";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Academic Year List")
                    // {
                    //     RunObject = Page "50033";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Semester List")
                    // {
                    //     RunObject = Page "50166";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Year List")
                    // {
                    //     RunObject = Page "50055";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Group Master")
                    // {
                    //     RunObject = Page "50227";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Student Group")
                    // {
                    //     RunObject = Page "50111";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Program List")
                    // {
                    //     RunObject = Page "50293";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("Course List")
                    // {
                    //     RunObject = Page "50291";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Section List")
                    // {
                    //     RunObject = Page "50032";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("Student Transfer List")
                    // {
                    //     RunObject = Page "50269";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("Admission Calendar List")
                    // {
                    //     RunObject = Page "50022";
                    //     ApplicationArea = Basic, Suite;
                    // }

                }
                group("Admission Report")
                {
                    // action("Country Wise Strength")
                    // {
                    //     RunObject = Report "50074";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("New Student WithoutSchoolEmail")
                    {
                        RunObject = Report "New Student WithoutSchoolEmail";
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

                }
                group("Admission Setups")
                {
                    // action("Admission Setup")
                    // {
                    //     RunObject = Page "50241";
                    //     ApplicationArea = Basic, Suite;
                    // }
                }


            }
            group("Fee Management")
            {
                group("Fee Master")
                {

                    action("Scholarship List")
                    {
                        Caption = 'Scholarship List';
                        RunObject = Page "Scholar. Source L-CS";
                        RunPageLink = "Discount Type" = filter(Scholarship);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Grant List")
                    {
                        Caption = 'Grant List';
                        RunObject = Page "Scholar. Source L-CS";
                        RunPageLink = "Discount Type" = filter(Grant);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Waiver List")
                    {
                        Caption = 'Waiver List';
                        RunObject = Page "Scholar. Source L-CS";
                        RunPageLink = "Discount Type" = filter(Waiver);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Fees Classification List")
                    {
                        RunObject = Page "50060";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Fee Component List")
                    {
                        RunObject = Page "50195";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Program Fee List")
                    {
                        RunObject = Page "50071";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Scholarship Details List")
                    {
                        RunObject = Page "50253";
                        ApplicationArea = Basic, Suite;
                    }

                }
                Group("Fees Setups")
                {
                    action("Fee Setup")
                    {
                        RunObject = Page "Fee Setup List";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Fee Report")
                {
                    action("Student Fee Component Details")
                    {
                        RunObject = Report "Finance Fee";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Dues Clearance Certificate")
                    {
                        RunObject = Report "50012";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Ledger")
                    {
                        RunObject = Report "50002";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student fee Due Ledger")
                    {
                        RunObject = Report "50068";
                        ApplicationArea = Basic, Suite;
                    }
                    action("FCR FR List")
                    {
                        RunObject = Report "50062";
                        ApplicationArea = Basic, Suite;
                    }
                    action("FCR FR OutStanding List")
                    {
                        RunObject = Report "50063";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Sub Ledger Details")
                    {
                        RunObject = Report "50029";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Class List")
                    {
                        RunObject = Report "50032";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Due Certificate List")
                    {
                        RunObject = Report "50147";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Demand Dateils")
                    {
                        RunObject = Report "50146";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Demand Dateils 1")
                    {
                        RunObject = Report "50035";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Check List Report")
                    {
                        RunObject = Report "50007";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Check List Report(Unrealized)")
                    {
                        RunObject = Report "50009";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Status")
                    {
                        RunObject = Report "50174";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Daily Bursar Report")
                    {
                        RunObject = Report "50175";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Bursar")
                {
                    action("Fee Generation")
                    {
                        RunObject = Report "50042";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Utilities Expense Bulk Upload")
                    {
                        ApplicationArea = All;
                        RunObject = xmlport "Utilities Expense Bulk Upload";
                        Image = Accounts;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                    }
                    action("Manual Bulk Upload")
                    {
                        ApplicationArea = All;
                        RunObject = xmlport "Manual Voucher Uppload";
                        Image = Accounts;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;

                    }
                    action("Bulk Batch Billing")
                    {
                        RunObject = xmlport "Bulk Batch Billing";
                        ApplicationArea = basic, suite;
                    }
                    action("Bulk Payment Upload")
                    {
                        RunObject = xmlport "Bulk Payment Upload";
                        ApplicationArea = basic, suite;
                    }

                    action("Scholarship Generation")
                    {
                        RunObject = Report "50106";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Student Legacy Ledger")
                    // {
                    //     ApplicationArea = All;
                    //     RunObject = page "Studen Legacy Ledger";
                    //     Image = Accounts;
                    //     Promoted = true;
                    //     PromotedOnly = true;
                    //     PromotedCategory = Process;
                    // }
                    action("Pending Payment Options")
                    {
                        RunObject = Page "Pending Payment Plan List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Wire Transfer List")
                    {
                        RunObject = Page "Details List-RTGS-CS";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Financial Accountability List")
                    {
                        RunObject = Page "Pending Financial Account";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Payment Options")
                    {
                        RunObject = Page "Payment Plan Approved/Rejected";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Approved/Rejected Wire Transfer List")
                    // {
                    //     RunObject = Page "Approved Rejected RTGS List";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("SAP Integration Date Request")
                    // {
                    //     RunObject = page "SAP Integration Date Request";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Student Statement Request")
                    // {
                    //     RunObject = page "Student Statement Request";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Fee Generation Others")
                    {
                        RunObject = Report "50152";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student to Customer")
                    {
                        RunObject = Report "50023";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Intrest Sub. Scho. Generation")
                    {
                        RunObject = Report "50151";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Fee Generation")
                    {
                        RunObject = Page "50017";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Create Portal User")
                    {
                        RunObject = Report "50038";
                        ApplicationArea = Basic, Suite;
                    }


                }
                Group("Financial Aid")
                {
                    action("Pending Financial Aid Applications")
                    {
                        RunObject = Page "Financial AID Pending List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Financial Aid Applications")
                    {
                        RunObject = Page FinancialAIDApprovRejectList;
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Pending Finanical Aid SignOff")
                    // {
                    //     Caption = 'Pending Finanical Aid SignOff';
                    //     RunObject = Page "Pending Financial Aid SignOff";
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                Group("Financial Aid Roster")
                {
                    action("Financial Aid Roster List")
                    {
                        RunObject = Page "Financial Aid Roster";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Financial Aid Roster")
                    {
                        RunObject = Page "Pending Financial Aid Roster";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Financial Aid Roster Approved/Rejected List")
                    {
                        RunObject = Page "FAid Roster Approved/Rejected";
                        ApplicationArea = Basic, Suite;
                    }
                }

                Group("General Journals")
                {
                    action("General Journal")
                    {
                        RunObject = Page "General Journal";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Payment Plan Journal")
                    // {
                    //     RunObject = Page "Payment Plan Journal";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Fee Journal")
                    // {
                    //     RunObject = Page "Fee Journal";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Scholarship/Grant Journal")
                    // {
                    //     RunObject = Page "Scholarship Grant Journal";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Waiver Journal")
                    // {
                    //     RunObject = Page "Waiver Journal";
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                // // group("Living Expenses")
                // // {
                // //     action("Act0001")
                // //     {
                // //         RunObject = Page "Living Expenses Students";
                // //         ApplicationArea = Basic, Suite;
                // //         Caption = 'Living Expenses Creation';
                // //     }
                // //     action("Act0002")
                // //     {
                // //         RunObject = Page "Living Expenses Bulk Posting";
                // //         ApplicationArea = Basic, Suite;
                // //         Caption = 'Living Expenses Bulk Posting';
                // //     }
                // //     action("Act0003")
                // //     {
                // //         RunObject = Page "Living Expenses Checking List";
                // //         ApplicationArea = Basic, Suite;
                // //         Caption = 'Living Expenses Checking';
                // //     }
                // //     action("Act0004")
                // //     {
                // //         RunObject = Page "Posted Living Expenses";
                // //         ApplicationArea = Basic, Suite;
                // //         Caption = 'Posted Living Expenses';
                // //     }
                // }
                Group("Payment Journals")
                {
                    // action("T4 Advance Journal")
                    // {
                    //     RunObject = Page "T4 Advance Journal";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("T4 Stipend Journal")
                    // {
                    //     RunObject = Page "T4 Stipend Journal";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Payment Journal")
                    {
                        RunObject = Page "Payment Journal";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Cash Receipt Journal")
                    {
                        RunObject = Page "Cash Receipt Journal";
                        ApplicationArea = Basic, Suite;
                    }
                    Group("Wire Transfer Details")
                    {
                        action("Pending Wire Transfer Lis")
                        {
                            Caption = 'Pending Wire Transfer List';
                            RunObject = Page "Details List-RTGS-CS";
                            ApplicationArea = Basic, Suite;
                        }
                        // action("Approved/Rejected Wire Transfr List")
                        // {
                        //     Caption = 'Approved/Rejected Wire Transfer List';
                        //     RunObject = Page "Approved Rejected RTGS List";
                        //     ApplicationArea = Basic, Suite;
                        // }
                    }

                }

            }
            Group("Withdrawal")
            {
                Group("Withdrawal Setups")
                {
                    action("Withdrawal Setup")
                    {
                        RunObject = Page "Fee Setup List";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Withdrawal Master")
                {
                    action("Academic Department List")
                    {
                        RunObject = Page "Academic Department List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("WIthdrawal Department List")
                    {
                        RunObject = Page "Withdrawal Department List";
                        RunPageLink = "Document Type" = filter(Withdrawal);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Withdrawal Source List")
                    {
                        RunObject = Page "50257";
                        ApplicationArea = Basic, Suite;
                    }
                }

                group("Withdrawal Periodic Activities")
                {
                    action("Course Withdrawal Application Form")
                    {
                        RunObject = Page "Stud. Course Withdrawal List";
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }
                    action("College Withdrawal Application Form")
                    {
                        RunObject = Page "Stud. College Withdrawal List";
                        ApplicationArea = Basic, Suite;

                    }
                    action("Pending Course Withdrawal Approvals List")
                    {
                        RunObject = Page "Pending Withdrawal Approvals";
                        //   RunPageLink = "Type of Withdrawal" = filter("Course-Withdrawal"), Status = FILTER("Pending for Approval");
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }
                    // action("Pending College Withdrawal Approvals List")
                    // {
                    //     RunObject = Page "Pending College Withdrawal";
                    //     //  RunPageLink = "Type of Withdrawal" = filter("College-Withdrawal"), Status = FILTER("Pending for Approval" | Rejected);
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                group("Approved Withdrawals")
                {
                    // action("Approved Course Department Withdrawal List")
                    // {
                    //     RunObject = Page "Approved Course Department";
                    //     // RunPageLink = "Type of Withdrawal" = filter("Course-Withdrawal"), Status = FILTER(Approved);
                    //     ApplicationArea = Basic, Suite;
                    //     Visible = False;
                    // }
                    // action("Approved College Department Withdrawal List")
                    // {
                    //     RunObject = Page "Approved College Department";
                    //     // RunPageLink = "Type of Withdrawal" = filter("College-Withdrawal"), Status = FILTER(Approved);
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Approved Course Withdrawal Application Form")
                    {
                        RunObject = Page "Approved Course Withdrawal";
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }
                    action("Approved College Withdrawal Application Form")
                    {
                        RunObject = Page "Approved College Withdrawal";
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Time Table")
            {
                group("Time Table Master")
                {
                    action("Time Slot List")
                    {
                        RunObject = Page "50258";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Time Table Template List")
                    {
                        RunObject = Page "50005";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Subject Group List")
                    {
                        RunObject = Page "50225";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Timetable Room List")
                    {
                        RunObject = Page "50139";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Time Table Periodic Activities")
                {
                    action("Time Table Template")
                    {
                        RunObject = Page "50259";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Time Table Header List")
                    {
                        RunObject = Page "50262";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Time Table List")
                    {
                        RunObject = Page "50281";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("TimeTable Report")
                {
                    action("Faculty Workload")
                    {
                        RunObject = Report "50086";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Attendance Summary")
                    {
                        RunObject = Report "50087";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Attendance Summary(<75)")
                    {
                        RunObject = Report "50088";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Attendance Day Wise")
                    {
                        RunObject = Report "50089";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Time Table Report")
                    {
                        RunObject = Report "50015";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Detail of Events")
                    {
                        RunObject = page "50405";
                        ApplicationArea = Basic, Suite;
                    }
                }

            }
            group("Student Promotion")
            {
                group("Promotion Master")
                {
                    action("Student Promotion Credit Criteria")
                    {
                        RunObject = Page "50168";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Promotion List")
                {
                    action("Student Promotion List")
                    {
                        RunObject = Page "Promotion Student List-CS";
                        ApplicationArea = Basic, Suite;
                    }
                }

            }
            group("Administrator")
            {
                group("Administrator Master")
                {
                    action("Document Category")
                    {
                        RunObject = Page "Doc. Attachment-CS";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Document Sub Category")
                    {
                        RunObject = Page "Cat Attachment & Doc-CS";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Attachment")
                {
                    action("Student Document Attachment")
                    {
                        RunObject = Page "Student Document Attachment";
                        ApplicationArea = Basic, Suite;
                    }
                }

            }
            group("Academics")
            {
                Group("Academics Setup")
                {
                    action("Academic Setup")
                    {
                        RunObject = Page "50163";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Education Setup")
                    {
                        RunObject = Page "50223";
                        ApplicationArea = Basic, Suite;
                    }

                }
                group("Academic Master")
                {
                    action("Course Lists")
                    {
                        RunObject = Page "50291";
                        ApplicationArea = Basic, Suite;
                    }
                    action("User Group")
                    {
                        RunObject = Page "50267";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Semester Lists")
                    {
                        RunObject = Page "50166";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Subject Master List")
                    {
                        RunObject = Page "50298";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Year Master List")
                    {
                        RunObject = Page "50055";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Event Master")
                    {
                        RunObject = Page "50119";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Subject Type")
                    {
                        RunObject = Page "50002";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Subject Classification List")
                    {
                        RunObject = Page "50003";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Educational Celendar List")
                    {
                        RunObject = Page "50022";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Academic Year Master")
                    {
                        RunObject = Page "50033";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Room List")
                    {
                        RunObject = Page "50139";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Employee List")
                    {
                        RunObject = Page "5201";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Graduation List")
                    {
                        RunObject = Page "50293";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Section Master List")
                    {
                        RunObject = Page "50032";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Course Subject List")
                    {
                        RunObject = Page "50174";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Course Wise Faculty")
                    {
                        RunObject = Page "50059";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Subject List")
                    {
                        RunObject = Page "50001";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Optional Subject List")
                    {
                        RunObject = Page "50004";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Students List")
                    {
                        RunObject = Page "50296";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Onroll Students List")
                    {
                        RunObject = Page "50037";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Student Ethnicity List")
                    // {
                    //     RunObject = Page "Student Ethnicity List";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Course Degree List")
                    // {
                    //     RunObject = Page "Course Degree";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Honors")
                    // {
                    //     RunObject = Page "Honors";
                    //     ApplicationArea = Basic, Suite;
                    // }

                }
                group("Academic Lists")
                {
                    action("Student Section & Roll No Allotment List")
                    {
                        RunObject = Page "50138";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Guardian Teacher List")
                    {
                        RunObject = Page "50112";
                        ApplicationArea = Basic, Suite;
                    }

                    // action("Revaluation List")
                    // {
                    //     RunObject = Page "50014";
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("Student Registration List")
                    // {
                    //     RunObject = Page "50016";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Student Registration & Immigration List")
                    {
                        RunObject = Page "50034";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Immigration Upload Document List")
                    {
                        RunObject = Page "50535";
                        ApplicationArea = Basic, Suite;
                    }

                    action("Portal User List")
                    {
                        RunObject = Page "50040";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Attendance Student List")
                    {
                        RunObject = Page "50010";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Compilation Course Withdrawal List")
                    {
                        RunObject = Page "50231";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Event Menu Availability Mapping")
                    {
                        RunObject = Page "50177";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Student All Subject Old Data")
                    // {
                    //     RunObject = Page "50080";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Student Rank List")
                    // {
                    //     RunObject = Page "50075";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Student Withdrawal List")
                    {
                        RunObject = Page "50030";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Achievement/Incident List")
                    {
                        RunObject = Page "50035";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Attendance Request List")
                    {
                        RunObject = Page "50079";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Subject Batch Update")
                    {
                        RunObject = Page "50187";
                        ApplicationArea = Basic, Suite;
                    }
                }


                group("Application Certificate List")
                {
                    action("Application Certificate")
                    {
                        RunObject = Page "50072";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Application Certificate (Applied)")
                    {
                        RunObject = Page "50036";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Academics Report")
                {
                    action("Transcript Report")
                    {
                        RunObject = Report "50053";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Marks Report Faculty")
                    {
                        RunObject = Report "50090";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Marks Report Admin Department")
                    // {
                    //     RunObject = Report "50018";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Clinical Assessment")
                    {
                        RunObject = Page "DocuSign Assessment Scores";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Marks Report Admin Department(Re-Registration)")
                    // {
                    //     RunObject = Report "50019";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Total Marks Report Admin Department")
                    {
                        RunObject = Report "50071";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Provisional Transcript")
                    {
                        RunObject = Report "50073";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Provisional Pass Certificate")
                    {
                        RunObject = Report "50077";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Provisional Transcript Semester Wise")
                    {
                        RunObject = Report "50045";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Transfer Certificate for Nav Only")
                    {
                        RunObject = Report "50037";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Faculty Feedback")
                    {
                        RunObject = Report "50041";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Faculty Mark Att Till Now")
                    {
                        RunObject = Report "50069";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Bonifide Certificate for Nav Only")
                    {
                        RunObject = Report "50115";
                        ApplicationArea = Basic, Suite;
                    }
                    action("First Time Applicants")
                    {
                        RunObject = Report "50164";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Extension of Time Application")
                    {
                        RunObject = Report "50165";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Academic Periodic Activity")
                {
                    action("Student Promotion Process Report")
                    {
                        RunObject = Report "50079";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Data Upload")
                    {
                        RunObject = XmlPort "50001";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Data Modification")
                    {
                        RunObject = XmlPort "50002";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Course Wise Faculty Upload")
                    {
                        RunObject = xmlport "50005";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Optional Subject Upload")
                    {
                        RunObject = XmlPort "50007";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Student Subject Upload")
                    // {
                    //     RunObject = xmlport "50008";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Student Subject Mapping")
                    {
                        RunObject = report "Student Subject Mapping";
                        ApplicationArea = Basic, Suite;
                    }

                    action("Subject Master Upload")
                    {
                        RunObject = XmlPort "50058";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Teacher Guardian Upload")
                    {
                        RunObject = xmlport "50051";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Employee Upload")
                    {
                        RunObject = xmlport "50012";
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Evaluation")
            {
                group("Grade Master")
                {
                    action("Grade List")
                    {
                        RunObject = Page "50184";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("List")
                {
                    action("Grade Allocation List")
                    {
                        RunObject = Page "50078";
                        ApplicationArea = Basic, Suite;
                    }
                }

            }
            //CLERKSHIP

            group("Clinical Rotation")
            {
                ToolTip = 'View or Edit Details Related to Clinical Rotation';
                action("Hospitals")
                {
                    RunObject = page "Hospital List";
                    RunPageMode = View;
                    Image = Vendor;
                    ApplicationArea = All;
                }
                group("FM1/IM1 Clerkship")
                {
                    group("Non-Affilated Hospitals")
                    {
                        action("New Application")
                        {
                            RunObject = page "Non-Affiliated Site Apply List";
                            RunPageMode = View;
                            Image = ServiceItem;
                            ApplicationArea = All;
                        }
                        action("Processed Application")
                        {
                            RunObject = page "Non-Affiliated Site Apprvl LST";
                            RunPageMode = View;
                            Image = ServiceLedger;
                            ApplicationArea = All;
                        }
                    }
                    group("Preferred Site & Dates")
                    {
                        action("Site & Date Selection")
                        {
                            RunObject = page "STDClkshpSite_DateSelectionLST";
                            RunPageMode = View;
                            Image = CalculateCalendar;
                            ApplicationArea = All;
                        }
                        action("Site & Date Approvals")
                        {
                            RunObject = page "UNVClkshpSite_DateApprovalLST";
                            RunPageMode = View;
                            Image = CalculateCalendar;
                            ApplicationArea = All;
                        }
                        action("Approved Site & Date")
                        {
                            RunObject = page "UNVClkshpSite_DateLST+";
                            RunPageMode = View;
                            Image = ApplyEntries;
                            ApplicationArea = All;
                        }
                    }
                }
                group("Core Rotations")
                {
                    group("Core Rotation Transactions")
                    {
                        action("Rotations")
                        {
                            RunObject = page "Roster Scheduling List";
                            RunPageMode = View;
                            Image = EntriesList;
                            ApplicationArea = All;
                        }
                    }
                    group("Core Rotation History")
                    {
                        action("Verified Clinical Documents")
                        {
                            Caption = 'Verified Clinical Documents';
                            RunObject = page "Student Clinical Documents+";
                            RunPageMode = View;
                            Image = LedgerBook;
                            ApplicationArea = All;
                        }
                        action("Confirmed Core Rotations")
                        {
                            RunObject = page "Confirm Roster Schedule List";
                            RunPageMode = View;
                            Image = EntryStatistics;
                            ApplicationArea = All;
                        }
                        action("Core Roster Ledger Entries")
                        {
                            RunObject = page "Roster Ledger Entries";
                            RunPageMode = View;
                            Image = LedgerBook;
                            ApplicationArea = All;
                        }
                    }
                }

                group("Elective Rotation")
                {
                    group("Elective Rotation Transactions")
                    {


                        action("Publish Elective Rotation")
                        {
                            RunObject = page "Publish Elective Rotation STD";
                            RunPageMode = Edit;
                            Image = PostedTimeSheet;
                            ApplicationArea = All;
                        }
                    }
                }


                group(Reports)
                {
                    action("Clerkship Attendance by hospital")
                    {
                        RunObject = report "Clinical Rotation Attendance";
                        RunPageMode = Edit;
                        Image = Report;
                        ApplicationArea = All;
                    }
                    action("Clerkship Attendance Delta Hospital")
                    {
                        RunObject = Report "Clerkship Attendance Delta";
                        RunPageMode = Edit;
                        Image = Report;
                        ApplicationArea = All;
                    }
                    action("Inventory of Available Rotations")
                    {
                        RunObject = Report "Clerkship Attendance Delta";
                        RunPageMode = Edit;
                        Image = Report;
                        ApplicationArea = All;
                    }
                    action("Clerkship Incorrect Scheduled Weeks")
                    {
                        RunObject = Report "Clerkship Attendance Delta";
                        RunPageMode = Edit;
                        Image = Report;
                        ApplicationArea = All;
                    }
                    action("Cancellation Reason Report")
                    {
                        RunObject = Report "Clerkship Attendance Delta";
                        RunPageMode = Edit;
                        Image = Report;
                        ApplicationArea = All;
                    }
                }
                group(Setup)
                {
                    action("Clinical Required Dcouments")
                    {
                        RunObject = page "Clinical Required Documents";
                        RunPageMode = Edit;
                        Image = Setup;
                        ApplicationArea = All;
                    }
                }
            }


            group("Examination")
            {
                group("Internal")
                {
                    action("Student Assignment list")
                    {
                        RunObject = Page "50054";
                        ApplicationArea = Basic, Suite;
                    }
                    group("Internal Exam Lists")
                    {
                        action("Internal Exam-Schedule List")
                        {
                            RunObject = Page "Internal Exam Schedule List";
                            ApplicationArea = All;
                        }
                        action("Internal Examination List")
                        {
                            RunObject = Page "Internal Student List-CS";
                            ApplicationArea = All;
                        }
                    }
                    group("Internal Exam Master")
                    {

                        action("Exam Code List")
                        {
                            RunObject = Page "50067";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Exam Group Code")
                        {
                            RunObject = Page "50109";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Reason Master List")
                        {
                            RunObject = Page "50023";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Batch Master List")
                        {
                            RunObject = Page "50012";
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group("Internal Periodic Activity")
                    {
                        action("Publish Internal Mark Report")
                        {
                            RunObject = Report "50072";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Subject Maximum Marks Update Report")
                        {
                            RunObject = Report "50008";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Document ReTest Application List")
                        {
                            RunObject = Page "50212";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Employee Open Entry List")
                        {
                            RunObject = Page "50020";
                            ApplicationArea = Basic, Suite;
                        }
                    }
                }
                group("External")
                {
                    group("External Exam Master")
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
                        action("Exam Room List")
                        {
                            RunObject = Page "50139";
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
                        action("Recommendation List")
                        {
                            RunObject = Page "Recommendation List";
                            ApplicationArea = all;
                        }
                        action("Grade Calculation")
                        {
                            RunObject = Page "Grade Calculation";
                            ApplicationArea = all;
                        }
                        // action("Grade Books Open")
                        // {
                        //     RunObject = Page GradeBooks;
                        //     ApplicationArea = all;
                        // }
                        // action("Grade Books Pending For Approval")
                        // {
                        //     RunObject = Page GradeBooksPendApp;
                        //     ApplicationArea = all;
                        // }
                        // action("Grade Books Approved")
                        // {
                        //     RunObject = Page GradeBooksApproved;
                        //     ApplicationArea = all;
                        // }


                    }
                    group("External Exam Lists")
                    {
                        // action("Exam Schedule List")
                        // {
                        //     RunObject = Page "50083";
                        //     ApplicationArea = Basic, Suite;
                        // }
                        // action("Student External Exam Attendance List")
                        // {
                        //     RunObject = Page "50132";        
                        //     ApplicationArea = Basic, Suite;
                        // }
                        action("Hall Ticket List")
                        {
                            RunObject = Page "50290";
                            ApplicationArea = Basic, Suite;
                        }

                        action("External Exam List")
                        {
                            RunObject = Page "External Student List-CS";
                            ApplicationArea = Basic, Suite;
                        }
                        // action("External Exam Published List")
                        // {
                        //     RunObject = Page "External Exam Published List";
                        //     ApplicationArea = all;
                        // }
                        action("Grade Book List")
                        {
                            RunObject = Page "Grade Book List";
                            ApplicationArea = all;
                        }

                        // action("CBSE Score")
                        // {
                        //     RunObject = page "CBSE Scores";
                        //     ApplicationArea = Basic, Suite;
                        // }
                        // action("CCSE Score")
                        // {
                        //     RunObject = page "CCSE Scores";
                        //     ApplicationArea = Basic, Suite;
                        // }

                    }
                    group("External Periodic Activity")
                    {
                        action("Invigilator Detail List")
                        {
                            RunObject = Page "50221";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Makeup & Special Exam List")
                        {
                            RunObject = Page "50015";
                            ApplicationArea = Basic, Suite;
                        }
                        // action("Revaluation 1 List")
                        // {
                        //     RunObject = Page "50014";
                        //     ApplicationArea = Basic, Suite;
                        // }
                        // action("Revaluation 2 List")
                        // {
                        //     RunObject = Page "50189";
                        //     ApplicationArea = Basic, Suite;
                        // }
                        action("Publish External  Marks Report")
                        {
                            RunObject = Report "50013";
                            ApplicationArea = Basic, Suite;
                        }
                        action("MalPractice Level List")
                        {
                            RunObject = Page "50161";
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group("External Exam Report")
                    {
                        action("Detained Student List")
                        {
                            RunObject = Report "50064";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Student Grade Report")
                        {
                            RunObject = Report "50066";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Seating Allocation Report(Regular)")
                        {
                            RunObject = Report "50084";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Seating Allocation Report(Makeup)")
                        {
                            RunObject = Report "50085";
                            ApplicationArea = Basic, Suite;
                        }
                        // action("Invigilator Report Makeup")
                        // {
                        //     RunObject = Report "50021";
                        //     ApplicationArea = Basic, Suite;
                        // }
                        action("Invigilator Report Regular")
                        {
                            RunObject = Report "50051";
                            ApplicationArea = Basic, Suite;
                        }
                        // action("Subject Wise Exam Strength")
                        // {
                        //     RunObject = Report "50014";
                        //     ApplicationArea = Basic, Suite;
                        // }
                        action("Seat Allocation Section Wise")
                        {
                            RunObject = Report "50017";
                            ApplicationArea = Basic, Suite;
                        }
                        // action("Acknowledgement Report")
                        // {
                        //     RunObject = Report "50016";
                        //     ApplicationArea = Basic, Suite;
                        // }
                        action("Seating Allocation Not Done")
                        {
                            RunObject = Report "50001";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Subject Credit CutOff List")
                        {
                            RunObject = Report "50056";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Seat Allot Section Wise <>1st Makeup")
                        {
                            RunObject = Report "50067";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Total Mark Admin Dept with Grade")
                        {
                            RunObject = Report "50070";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Program Result")
                        {
                            RunObject = Report "50047";
                            ApplicationArea = Basic, Suite;
                        }
                    }
                }
            }
            group("Placement")
            {
                group("Campus Placement")
                {
                    action("Company List")
                    {
                        RunObject = Page "50148";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Placement Schedule")
                    {
                        RunObject = Page "50142";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Placement Register")
                    {
                        RunObject = Page "50140";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Placement Details")
                    {
                        RunObject = Page "50143";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Placement History")
                    {
                        RunObject = Page "50144";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Other Attachments")
                    {
                        RunObject = Page "50027";
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            Group("Housing")
            {
                group("Housing Master")
                {

                    action("Housing  Group List")
                    {
                        RunObject = Page "Housing Group List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Apartment Category List")
                    {
                        RunObject = Page "Room Category List";
                        ApplicationArea = Basic, Suite;
                    }

                    action("Housing Inventory List")
                    {
                        RunObject = Page "Housing Inventory List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Housing List")
                    {
                        RunObject = Page "Housing Master List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Apartment Category Fee Setup")
                    {

                        RunObject = Page "Room Category Fee Setup";
                        ApplicationArea = Basic, Suite;

                    }
                    action("Financial Accountability Category List")
                    {
                        RunObject = Page "Financial Account Category";
                        ApplicationArea = Basic, Suite;
                    }


                }
                group("Housing Periodic Activities")
                {

                    group("Housing Application")
                    {
                        action("Pending Housing Application List")
                        {
                            RunObject = Page "Housing Application List";
                            ApplicationArea = Basic, Suite;
                        }

                    }

                    group("Housing Change/Vacate/Re-Registration Application")
                    {
                        action("Pending Housing Change List")
                        {
                            RunObject = Page "Housing Change Request List";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Pending Housing Vacate List")
                        {
                            RunObject = Page "Housing Vacate Request List";
                            ApplicationArea = Basic, Suite;
                        }
                        // action("Pending Housing Re-Registration List")
                        // {
                        //     RunObject = Page "Housing Re-Registration List";
                        //     ApplicationArea = Basic, Suite;
                        // }

                    }

                    group("Housing Issues")
                    {
                        action("Pending Housing Issue List")
                        {
                            RunObject = Page "Housing Issue Pending List";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Accepted Housing Issue List")
                        {
                            RunObject = Page "Housing Issue Accepted List";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Resolved Housing Issue List")
                        {
                            RunObject = Page "Closed Housing Issue List";
                            RunPageLink = Status = filter(Resolved);
                            ApplicationArea = Basic, Suite;
                        }

                    }
                    group("Financial Accountability")
                    {
                        action("Financial Accountability List")
                        {
                            RunObject = Page "Financial Accountability List";
                            ApplicationArea = Basic, Suite;
                        }
                        // action("Pending Housing Financial Accountability List")
                        // {
                        //     RunObject = Page "Housing Fin Account List";
                        //     ApplicationArea = Basic, Suite;
                        // }
                    }
                    group("Parking")
                    {
                        action("Pending Parking Sticker Assignment List ")
                        {
                            RunObject = Page "Housing Parking Details List";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Assigned Parking Sticker List")
                        {
                            RunObject = Page "Housing Parking Assigned List";
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group("Housing Waiver")
                    {
                        action("Pending Housing Waiver List")
                        {
                            RunObject = Page "Pending Housing Wavier List";
                            ApplicationArea = Basic, Suite;
                        }

                    }
                    group("Immigration")
                    {
                        action("Pending Immigration List")
                        {
                            RunObject = Page "Immigration list";
                            ApplicationArea = Basic, Suite;
                        }


                    }
                }

                group("Housing Reports")
                {
                    action("Bed Count")
                    {
                        RunObject = Report "Bed Count";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Room Count';
                    }
                    action("Housing Roster")
                    {
                        RunObject = Report "Housing Roster";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Housing Cost")
                    {
                        RunObject = Report "Housing Cost";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Extension of Time App")
                    {
                        Caption = 'Extension of Time Application';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;
                        //Promoted = true;
                        //PromotedCategory = Category7;
                        RunObject = report "Extension of Time Application";
                    }
                    action("First Time of Applicant")
                    {
                        Caption = 'First Time Applicant';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;
                        //Promoted = true;
                        //PromotedCategory = Category7;
                        RunObject = report "First Time Applicants";
                    }

                }
                group("Approved/Rejected Housing List")
                {
                    action("Approved/Rejected Housing Application")
                    {
                        RunObject = Page "Posted Housing Application";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Change Request")
                    {
                        RunObject = page "Approve Reject Housing Change";
                        RunPageLink = type = filter("Change Request");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Vacate Request")
                    {
                        RunObject = page "Approve Reject Housing Change";
                        RunPageLink = type = filter(Vacate), "Mid Sem Break" = const(true);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Vacated Housing Application List")
                    {
                        RunObject = page "Approve Reject Housing Change";
                        RunPageLink = type = filter(Vacate), "Mid Sem Break" = const(False);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Re-Registration Request")
                    {
                        RunObject = page "Approve Reject Housing Change";
                        RunPageLink = type = filter("Re-Registration");
                        ApplicationArea = Basic, Suite;
                    }

                    action("Approved/Rejected Financial Accountability")
                    {
                        RunObject = Page "Approve/Reject Fin Account";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Housing Waiver List")
                    {
                        RunObject = Page "Housing Wavier Approved List";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Approved/Rejected Immigration List")
                    // {
                    //     RunObject = Page "Immigration Approved list";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Rejected Housing Issue List")
                    {
                        RunObject = Page "Closed Housing Issue List";
                        RunPageLink = Status = filter(Rejected);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Housing Ledger")
                    {
                        RunObject = Page "Housing Ledger";
                        ApplicationArea = Basic, Suite;
                    }

                }
            }
            Group("Leave of Absence")
            {
                group("Leave Master")
                {
                    action("Academic Department")
                    {
                        RunObject = Page "Academic Department List";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Academic Department List';
                    }
                    action("Leave Department List")
                    {
                        RunObject = Page "Withdrawal Department List";
                        RunPageLink = "Document Type" = filter(<> Withdrawal);
                        ApplicationArea = Basic, Suite;
                        Caption = 'Leave Department List';
                    }

                }

                group("Leave Periodic Activities")
                {
                    action("SLOA List")
                    {
                        RunObject = Page "SLOA List";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Short Leave Of Absence List';
                    }
                    action("CLOA List")
                    {
                        RunObject = Page "CLOA List";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Clinical Leave Of Absence List';
                    }
                    action("ELOA List")
                    {
                        RunObject = Page "ELOA List";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Extended Leave Of Absence List';
                    }
                    // action("Pending SLOA Leave Approval List")
                    // {
                    //     RunObject = Page "Pending Leaves Approvals";
                    //     RunPageLink = "Type of Leaves" = filter(SLOA);
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Pending SLOA Leave Approval List';
                    // }
                    // action("Pending CLOA Leave Approval List")
                    // {
                    //     RunObject = Page "Pending Leaves Approvals";
                    //     RunPageLink = "Type of Leaves" = filter(CLOA);
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Pending CLOA Leave Approval List';
                    // }
                    // action("Pending ELOA Leave Approval List")
                    // {
                    //     RunObject = Page "Pending Leaves Approvals";
                    //     RunPageLink = "Type of Leaves" = filter(ELOA);
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Pending ELOA Leave Approval List';
                    // }
                }
                group("Approved Rejected Leaves")
                {
                    action("Approved Rejected SLOA Leave")
                    {
                        RunObject = Page "Approved Rejected Leave List";
                        RunPageLink = "Leave Types" = filter(SLOA);
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Rejected SLOA Leave List';
                    }
                    action("Approved Rejected ELOA Leave")
                    {
                        RunObject = Page "Approved Rejected Leave List";
                        RunPageLink = "Leave Types" = filter(ELOA);
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Rejected ELOA Leave List';
                    }
                    action("Approved Rejected CLOA Leave")
                    {
                        RunObject = Page "Approved Rejected Leave List";
                        RunPageLink = "Leave Types" = filter(CLOA);
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Rejected CLOA Leave List';
                    }

                }
            }
            group("Graduation")
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
                    // action("Course Degree")
                    // {
                    //     RunObject = Page "Course Degree";//50783
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                group("Degree Audit")
                {
                    action("Eligible Student List")
                    {
                        RunObject = Page "Student Details-CS";//50296
                        RunPageView = where(status = const('PENDGRAD'));
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Pending Degree Audit List")
                    // {
                    //     RunObject = page "Degree Audit list";//50893
                    //     RunPageView = where("Document Status" = filter("Pending for Verification"));
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Approved/ Rejected Degree Audit List")
                    // {
                    //     RunObject = page "Approved Rejected Degree Audit";//50896
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Student Degree")
                    // {
                    //     RunObject = page "Student Degree";//50782
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Graduated Student List")
                    {
                        RunObject = Page "Student Details-CS";//50296
                        RunPageView = where(status = const('GRAD'));
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Degree/Transcript Printing")
                {
                    action("Pending Transcript Printing Request")
                    {
                        caption = 'Pending Printing Request';
                        RunObject = Page "Certificates Application-CS"; //50072
                        ApplicationArea = Basic, Suite;
                    }
                    action("Completed Transcript Printing Request")
                    {
                        Caption = 'Completed Printing Request';
                        RunObject = Page "Certificates Application -CS"; //50036
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Studnts List")
                {
                    caption = 'Student List';
                    action("Stud. List")
                    {
                        Caption = 'Students List';
                        RunObject = page "Student Details-CS";//50296
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Admissions Master")
                {
                    Caption = 'Admission Master';
                    action("Grup Master")
                    {
                        caption = 'Group Master';
                        RunObject = Page "Group Detail-CS"; //50227
                        ApplicationArea = Basic, Suite;
                    }
                    action("Stdnt Group")
                    {
                        caption = 'Student Group';
                        RunObject = Page "Group(Student)-CS"; //50111
                        ApplicationArea = Basic, Suite;
                    }
                }
            }

            // Group("Graduate Affairs")
            // {
            //     group("Residency Status Master")
            //     {
            //         action("Residency Status List")
            //         {
            //             RunObject = page "Residency Status List";//50840
            //             ApplicationArea = Basic, Suite;
            //         }
            //     }
            //     group("MSPE Application")
            //     {
            //         action("Pending MSPE Application List")
            //         {
            //             RunObject = Page "Pending MSPE Application List";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'Pending MSPE Application List';
            //         }
            //         action("In-Review MSPE Application List")
            //         {
            //             RunObject = Page "In-Review MSPE App List";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'In-Review MSPE Application List';
            //         }

            //         action("Review Required MSPE Application List")
            //         {
            //             RunObject = Page "Review Required MSPE App List";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'Review Required MSPE Application List';
            //         }

            //         action("Completed MSPE Application List")
            //         {
            //             RunObject = Page "Completed MSPE App List";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'Completed MSPE Application List';
            //         }

            //     }
            //     group("NRMP")
            //     {
            //         action("NRMP Match List")
            //         {
            //             RunObject = Page "NRMP Match List";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'NRMP Match List';
            //         }
            //         action("Student Residency Status List")
            //         {
            //             RunObject = Page "Residency List";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'Student Residency Status List';
            //         }
            //         action("Student List2")
            //         {
            //             RunObject = Page "Student List for Residency";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'Student List';
            //         }
            //         action("Residency Ledger")
            //         {
            //             RunObject = Page "Residency Ledger";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'Residency Ledger';
            //         }

            //     }
            //     action("Hospital List")
            //     {
            //         RunObject = Page "Hospital List";
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Hospital List';
            //     }

            //     group("Licensing")
            //     {
            //         Caption = 'Licensing';
            //         action("License Tracking List")
            //         {
            //             RunObject = Page "License Tracking";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'License Tracking List';
            //         }
            //         action("License Tracking Ledger")
            //         {
            //             RunObject = Page "License Tracking Ledger";
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'License Tracking Ledger';
            //         }
            //     }



            // group("Documents Upload")
            // {
            //     // action("Document Upload")
            //     // {
            //     //     // RunObject = page "";
            //     //     ApplicationArea = Basic, Suite;
            //     // }
            // }
            group("ACADEMICS1")
            {
                Caption = 'Academics';
                action("Student List1")
                {
                    RunObject = Page "Student Details-CS";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Student List';
                }
                // action("Student Subject Exam List")
                // {
                //     Caption = 'Student Subject Exam List';

                //     ApplicationArea = Basic, Suite;
                //     // Promoted = true;
                //     // PromotedOnly = true;
                //     // PromotedIsBig = true;
                //     // PromotedCategory = Process;
                //     RunObject = page "Student Subject Exam List";
                //     //RunPageView = where("Score Type" = filter(CCSE));
                // }
                // action("Student Rotation Audit")
                // {
                //     Caption = 'Student Rotation Audit';
                //     ApplicationArea = Basic, Suite;
                //     // Promoted = true;
                //     // PromotedOnly = true;
                //     // PromotedIsBig = true;
                //     // PromotedCategory = Process;
                //     // RunObject = page "Students Rotation Audit";
                //     //RunPageView = where("Score Type" = filter(CCSE));
                // }
                action("Student Promotion List1")
                {
                    Caption = 'Student Promotion List';
                    RunObject = page "Promotion Student List-CS";//50052
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Score Details")
            {
                // action("CCSE Score_1")
                // {
                //     Caption = 'CCSE Score';
                //     ApplicationArea = Basic, Suite;
                //     // Promoted = true;
                //     // PromotedOnly = true;
                //     // PromotedIsBig = true;
                //     // PromotedCategory = Process;
                //     RunObject = page "Student Subject Exam List";
                //     // RunPageLink = "Score Type" = filter(CCSE);

                //     //  ApplicationArea = Basic, Suite;
                // }
                // action("CCSSE Score")
                // {
                //     Caption = 'CCSSE Score';
                //     ApplicationArea = Basic, Suite;
                //     // Promoted = true;
                //     // PromotedOnly = true;
                //     // PromotedIsBig = true;
                //     // PromotedCategory = Process;
                //     // RunObject = page "Student Subject Exam List";
                //     // RunPageLink = "Score Type" = filter(CCSSE);
                //     //ApplicationArea = Basic, Suite;
                // }
                // action("Test")
                // {
                //     Caption = 'CCSSE Score';
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Student Subject Exam List";
                //     RunPageLink = "Score Type" = filter(CCSSE);
                // }
                // action("CBSE Score_1")
                // {
                //     Caption = 'CBSE Score';
                //     ApplicationArea = Basic, Suite;
                //     // Promoted = true;
                //     // PromotedOnly = true;
                //     // PromotedIsBig = true;
                //     //PromotedCategory = Process;
                //     RunObject = page "Student Subject Exam List";
                //     // RunPageView = where("Score Type" = filter('CBSE'));
                //     //ApplicationArea = Basic, Suite;
                // }
                // action("USMLE Score")
                // {
                //     ApplicationArea = Basic, Suite;
                //     // Promoted = true;
                //     // PromotedOnly = true;
                //     // PromotedIsBig = true;
                //     // PromotedCategory = Process;
                //     RunObject = page "Student Subject Exam List";
                //     // RunPageView = where("Score Type" = filter("STEP 1" | "STEP 2 CK" | "STEP 2 CS"));
                // }



            }
            Group(Reports_1)
            {
                Caption = 'Reports';
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
                // action("View Student Group_4")
                // {
                //     Caption = 'View Student Group';
                //     RunObject = page "View Students Group New";
                //     ApplicationArea = basic, suite;
                // }
                // action("Student Group Deatil_1")
                // {
                //     Caption = 'Student Group Deatil';
                //     RunObject = page "Student Group Detail";
                //     ApplicationArea = basic, suite;
                // }
                // action("Broadcast E-Mail_1")
                // {
                //     Caption = 'Broadcast E-Mail';
                //     RunObject = page "Broadcast E-Mail";
                //     ApplicationArea = basic, suite;
                // }
                action("E-Mail Notification List_1")
                {
                    Caption = 'E-Mail Notification List';
                    RunObject = page "E-Mail Notification List";
                    ApplicationArea = basic, suite;
                }
                // action("Batch & Individual Transcript")
                // {
                //     // RunObject = report ;
                //     ApplicationArea = basic, suite;
                // }

            }
            group("Admission Master_1")
            {
                caption = 'Admission Master';
                action("Group Master_1")
                {
                    caption = 'Group Master';
                    RunObject = Page "Group Detail-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Student Group_1")
                {
                    caption = 'Student Group';
                    RunObject = Page "Group(Student)-CS";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
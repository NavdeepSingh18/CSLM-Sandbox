page 50818 "Bursar Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineBursar)
            {
                ApplicationArea = All;
            }
            part(Activities; BursarRoleCenterCuepage)
            {
                ApplicationArea = Basic, Suite;
            }

            part(Chart2; "Student Detail")
            {
                Caption = 'Student Information';
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            part(ChartofAccount; "Chart of Accounts")
            {
                Caption = 'Chart of Account';
                Visible = false;
                ApplicationArea = Basic, Suite;
            }
            part("Student Details-CS LP"; "Student Details-CS LP")
            {
                Caption = 'Student Information';
                visible = true;
                ApplicationArea = Basic, Suite;
            }
            part(Chart3; "Students opted with FA")
            {
                visible = true;
                ApplicationArea = Basic, Suite;
            }
            part(Chart4; "Students opted with PP")
            {
                Caption = 'No. of Students opted with Payment Plan';
                visible = true;
                ApplicationArea = Basic, Suite;
            }
            part(Chart5; "Students opted with SP")
            {
                Caption = 'No. of Students opted with Self Payment';
                visible = true;
                ApplicationArea = Basic, Suite;
            }
            part(Chart6; "Students opt Living Expenses")
            {
                visible = true;
                ApplicationArea = Basic, Suite;
            }
            part(Chart7; "Students Fee Generated Or Not")
            {
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
            group(Bursar)
            {
                group("Fee Master")
                {
                    action("Waiver List")
                    {
                        RunObject = page "Scholar. Source L-CS";//"50257"
                        RunPageLink = "Discount Type" = filter(Waiver);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Grant List")
                    {
                        RunObject = page "Scholar. Source L-CS";//"50257"
                        RunPageLink = "Discount Type" = filter(Grant);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Scholarship List")
                    {
                        RunObject = page "Scholar. Source L-CS";//"50257"
                        RunPageLink = "Discount Type" = filter(Scholarship);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Fee Component List")
                    {
                        RunObject = page "Fee Components Detail-CS";//"50195"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Program Fee List")
                    {
                        RunObject = page "Fee Course Hdr List-CS";//"50071"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Scholarship Detail List")
                    {
                        RunObject = page "Scholarshpt List-CS";//"50253"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Grant Detail List")
                    {
                        RunObject = page "Scholar. Source L-CS";//"50257"
                        RunPageLink = "Discount Type" = filter(Grant);
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                    }
                    action("Waiver Details List")
                    {
                        RunObject = page "Scholar. Source L-CS";//"50257"
                        RunPageLink = "Discount Type" = filter(Waiver);
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Bursar Reports")
                {
                    action("Student Fee Component Detail")
                    {
                        RunObject = report "Finance Fee";//"50167"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Consolidated Student Ledger")
                    {
                        RunObject = report "Consolidated Student Ledger";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Payment Plan Schedule")
                    {
                        Caption = 'Payment Plan Schedule';
                        RunObject = page "Payment Plan";
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
                    action("Student Status")
                    {
                        RunObject = report "Student Status";//"50174"
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    action("Daily Bursar Report")
                    {
                        RunObject = report "Daily Bursar Report";//"50175"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Statement Request")
                    {
                        RunObject = report "Student Statement of Account";//50172
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Insurance Waiver List")
                    {
                        RunObject = Page "Pending Insurance Waiver List";
                        RunPageLink = Status = filter(Approved);
                        ApplicationArea = Basic, Suite;
                        RunPageView = where(Status = filter(Approved));
                    }
                }
                group("Fee Setup")
                {
                    Visible = false;
                    action("Fees Setup")
                    {
                        RunObject = page "Fee Setup List";//"50632"
                        ApplicationArea = Basic, Suite;
                        visible = false;
                    }
                }
                group("Bursar Activities")
                {
                    action("Fee Generation")
                    {
                        RunObject = report "Fee Generation New";//"50042"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Scholarship Generation")
                    {
                        RunObject = report "Scholarship";//"50106"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Payment Plan Application")
                    {
                        RunObject = page "Pending Payment Plan List";//"50656"
                        RunPageLink = Status = filter("Pending for Approval"), Type = filter("Self Payment" | "Payment Plan");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejection Payment Option")
                    {
                        RunObject = page "Payment Plan Approved/Rejected";//"50658"
                        RunPageLink = Status = filter(Approved | Rejected), Type = filter("Payment Plan");
                        ApplicationArea = Basic, Suite;
                    }

                    action("Pending Wire Transfer Lst")
                    {
                        RunObject = Page "Details List-RTGS-CS";//"50285"
                        RunPageLink = Status = filter("Pending for Approval");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Financial Accountability List")
                    {
                        RunObject = Page "Pending Financial Account";//"50538"
                        RunPageLink = Status = filter("Pending for Approval");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejection Wire Transfer")
                    {
                        RunObject = Page "Approved Rejected RTGS List";//"50751"
                        RunPageLink = Status = filter(Approved | Rejected);
                        ApplicationArea = Basic, Suite;
                    }
                    action("SAP Integration Date Request")
                    {
                        RunObject = Page "SAP Integration Date Request";//"50726"
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    action("Fee Generation Others")
                    {
                        RunObject = report "Other FeeGeneration-College CS";//"50152"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Utilities Expense Bulk Upload")
                    {
                        RunObject = xmlport "Utilities Expense Bulk Upload";//"50067"
                        ApplicationArea = Basic, Suite;
                    }

                    action("Manual Bulk Upload")
                    {
                        Visible = false; //CSPL-00307
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Manual Voucher Uppload";

                    }
                    action("Bulk Batch Billing")
                    {
                        RunObject = xmlport "Bulk Batch Billing";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Bulk Payment Upload")
                    {
                        RunObject = xmlport "Bulk Payment Upload";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Legacy Ledger Upload")
                    {
                        ApplicationArea = All;
                        RunObject = xmlport "Legacy Ledger Upload";
                        Image = Accounts;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                    }
                    Action("FA Roster Upload")
                    {
                        ApplicationArea = All;
                        RunObject = xmlport FARosterUpload;
                    }
                    action("Student Legacy Ledger")
                    {
                        RunObject = page "Studen Legacy Ledger";//"50772"
                        RunPageView = order(ascending);
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Living Expenses")
                {
                    action("Living Expenses Creation")
                    {
                        RunObject = page "Living Expenses Students";//"50670"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Living Expenses Bulk Posting")
                    {
                        RunObject = page "Living Expenses Bulk Posting";//"50731"
                        RunPageView = sorting("Student ID");
                        RunPageLink = Status = filter(Open | Posted);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Living Expenses Checking")
                    {
                        RunObject = page "Living Expenses Checking List";//"50674"
                        RunPageLink = Status = filter(Open | Posted);
                        ApplicationArea = Basic, Suite;
                    }
                }
                Group("Withdrawal")
                {
                    action("Withdrawal Setup")
                    {
                        RunObject = Page "Fee Setup List";//"50632"
                        ApplicationArea = Basic, Suite;
                    }
                    group("Withdrawal Master")
                    {
                        action("Academic Department List")
                        {
                            RunObject = Page "Academic Department List";//"50687"
                            ApplicationArea = Basic, Suite;
                        }
                        action("Withdrawal Department List")
                        {
                            RunObject = Page "Withdrawal Department List";//"50591"
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
                            RunPageLink = "Type of Withdrawal" = filter("Course-Withdrawal");
                            ApplicationArea = Basic, Suite;
                            Visible = False;
                        }
                        action("Pending College Withdrawal Approvals List")
                        {
                            RunObject = Page "Pending College Withdrawal";
                            RunPageLink = "Type of Withdrawal" = filter("College-Withdrawal");
                            ApplicationArea = Basic, Suite;
                        }

                    }
                    group("Approved Withdrawal")
                    {
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
            }
            Group("Financials Aid")
            {
                group("Financial Aid")
                {
                    action("Pending Financial Aid Application Form")
                    {
                        RunObject = Page "Financial AID Pending List";//"50652"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Financial Aid Application")
                    {
                        RunObject = Page "FinancialAIDApprovRejectList";//"50653"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Financial Aid Roster List")
                    {
                        RunObject = Page "Financial Aid Roster";//"50640"
                        ApplicationArea = Basic, Suite;
                        RunPageLink = Status = filter(Open | Approved | "Pending for Approval" | Rejected);
                    }

                    action("Pending Financial Aid Roster")
                    {
                        RunObject = Page "Pending Financial Aid Roster";//"50641"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Financial Aid Roster Approved/Rejected List")
                    {
                        RunObject = Page "FAid Roster Approved/Rejected";//"50642"
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group(Finance)
            {
                action("Chart of Account")
                {
                    RunObject = Page "Chart of Accounts";//"16"
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                action("Dimensions")
                {
                    RunObject = Page Dimensions;//"536"
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                group("General Journals")
                {
                    action("General Journal")
                    {
                        RunObject = Page "General Journal";//"39"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Payment Plan Journal")
                    {
                        // RunObject = Page "Pending Payment Plan List";//"50656";//"FinancialAIDApprovRejectList";//"50653"
                        RunObject = page "Payment Plan Journal";//"50680"
                        // RunPageLink = Type = filter("Payment Plan"), Status = filter("Pending for Approval");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Fee Journal")
                    {
                        RunObject = Page "Fee Journal";//"50681"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Bulk Batch Billing1")
                    {
                        Caption = 'Bulk Batch Billing';
                        RunObject = xmlport "Bulk Batch Billing";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Scholarship/Grant Journals")
                    {
                        RunObject = Page "Scholarship Grant Journal";//"50683"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Waiver Journal")
                    {
                        RunObject = Page "Waiver Journal";//"50682"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Utilities Journal")
                    {
                        RunObject = Page "Utilities Journal";//"50806"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Adjustment Journal")
                    {
                        RunObject = Page "Student Adjustment";//"50947"
                        ApplicationArea = Basic, Suite;
                    }
                    action("General Ledger Setup")
                    {
                        RunObject = Page "General Ledger Setup";//"118"
                        ApplicationArea = Basic, Suite;
                    }
                    action("General Journal Templates")
                    {
                        RunObject = Page "General Journal Templates";//"101"
                        ApplicationArea = Basic, Suite;
                    }
                    action("General Journal Batches")
                    {
                        RunObject = Page "General Journal Batches";//"251"
                        ApplicationArea = Basic, Suite;
                    }
                    action("General Ledger Entries")
                    {
                        RunObject = Page "General Ledger Entries";//"20"
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Cash Management")
            {
                action("Bank Accounts")
                {
                    RunObject = Page "Bank Account List";//"371";
                    ApplicationArea = Basic, Suite;
                }
                group("Payments Journal")
                {
                    action("Payment Journal")
                    {
                        RunObject = Page "Payment Journal";//"256"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Cash Reciept Journal")
                    {
                        RunObject = Page "Cash Receipt Journal";//"255"
                        ApplicationArea = Basic, Suite;
                    }
                    action("T4 Advance")
                    {
                        RunObject = Page "T4 Advance Journal";//"50709"
                        ApplicationArea = Basic, Suite;
                    }
                    action("T4 Stipend")
                    {
                        RunObject = Page "T4 Stipend Journal";//"50710"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Bulk Payment Upload1")
                    {
                        Caption = 'Bulk Payment Upload';
                        RunObject = xmlport "Bulk Payment Upload";
                        ApplicationArea = Basic, Suite;
                    }
                    group("RTGS Details")
                    {
                        action("Pending RTGS List")
                        {
                            RunObject = Page "Details List-RTGS-CS";//"50285"
                            RunPageLink = status = filter("Pending for Approval");
                            ApplicationArea = Basic, Suite;
                        }
                        action("Approved/Rejected RTGS List")
                        {
                            RunObject = Page "Approved Rejected RTGS List";//"50751"
                            RunPageLink = status = filter(Approved | Rejected);
                            ApplicationArea = Basic, Suite;
                        }

                    }
                    action("Bank Ledger Entries")
                    {
                        RunObject = Page "Bank Account Ledger Entries";//"372"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Bank Posting Group")
                    {
                        RunObject = Page "Bank Account Posting Groups";//"373"
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Basic Setups")
            {
                action("No. Series")
                {
                    RunObject = Page "No. Series";//"456"
                    ApplicationArea = Basic, Suite;
                }
                action("Currencies List")
                {
                    RunObject = Page Currencies;// "5"
                    ApplicationArea = Basic, Suite;
                }
                action("Country/Region List")
                {
                    RunObject = Page "Countries/Regions";//"10"
                    ApplicationArea = Basic, Suite;
                }
                action("Zip Code")
                {
                    RunObject = Page "Post Codes";//367"
                    ApplicationArea = Basic, Suite;
                }
                action("Accounting Period")
                {
                    RunObject = Page "Accounting Periods";//"100"
                    ApplicationArea = Basic, Suite;
                }
                action("Education Setup")
                {
                    RunObject = Page "Education Setup List";//"50545"
                    ApplicationArea = Basic, Suite;
                }
                action("Admission Setup")
                {
                    RunObject = Page "Academics Master-CS";//"50155"
                    ApplicationArea = Basic, Suite;
                }
                action("Fee Setups")
                {
                    RunObject = Page "Fee Setup List";//"50632"
                    ApplicationArea = Basic, Suite;
                }
                action("Customer Posting Group")
                {
                    RunObject = Page "Customer Posting Groups";//"110"
                    ApplicationArea = Basic, Suite;
                }
                action("Gen. Bus. Posting Group")
                {
                    RunObject = Page "Gen. Business Posting Groups";//"312"
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Student Section")
            {
                action("Student List")
                {
                    RunObject = Page "Student Details-CS";//"50296"
                    ApplicationArea = Basic, Suite;
                }
                action("Academic Year")
                {
                    RunObject = Page "List Academic Year-CS";//"50033"
                    ApplicationArea = Basic, Suite;
                }
                action("Semester List")
                {
                    RunObject = Page "Semester Detail-CS";//"50166"
                    ApplicationArea = Basic, Suite;
                }
                action("Customer List")
                {
                    RunObject = Page "Customer List"; // "22"
                    ApplicationArea = Basic, Suite;
                }
                action("Year")
                {
                    RunObject = Page "Year List College -CS";//"50055"
                    ApplicationArea = Basic, Suite;
                }
                action("Program")
                {
                    RunObject = Page "Graduation Detail-CS";//"50293"
                    ApplicationArea = Basic, Suite;
                }
                action("Customer Ledger Entries")
                {
                    RunObject = Page "Customer Ledger Entries";//"25"
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Clerkship Student Billing")
            {
                Caption = 'Clerkship Student Billing';
                action("Summary of Students Clerkship")
                {
                    RunObject = page "CLN Billing Student Summary";
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                    Caption = 'Summary of Students Clerkship';
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
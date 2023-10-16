page 50510 "Clerkship Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineClinical)
            {
                ApplicationArea = All;
            }
            part(Activities; ClinicalRoleCenterCuepage)
            {
                ApplicationArea = Basic, Suite;
            }
            part(Chart2; "Semester Wise Student Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(Chart3; "Core Rotation Wise Stud Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Hospital Creation")
            {
                RunObject = Page "Hospital List";
                ApplicationArea = All;
            }
            action("LINK0001")
            {
                //RunObject = page "Student Clinical Documents";
                Caption = 'View/Update Notes';
                RunObject = page "Students to Update Notes";
                RunPageMode = View;
                Image = Notes;
                ApplicationArea = All;
            }
            action("LINK0001_1")
            {
                //RunObject = page "Student Clinical Documents";
                Caption = 'View/Upload Documents';
                RunObject = page "Clinical Document Updation";
                RunPageMode = View;
                Image = ShowInventoryPeriods;
                ApplicationArea = All;
            }
            action("LINK0001_2")
            {
                //RunObject = page "Student Clinical Documents";
                Caption = 'Rotation Audit';
                RunObject = page "Students Rotation Audit";
                RunPageMode = View;
                Image = ShowInventoryPeriods;
                ApplicationArea = All;
            }
            group("FMIM0001")
            {
                Caption = 'FM1/IM1 Clerkship';
                action("FMIM0002")
                {
                    Caption = 'FM1/IM1 Preset Date List';
                    RunObject = page "FM1/IM1 Preset Date Entry LST";
                    RunPageMode = View;
                    Image = CalculateCalendar;
                    ApplicationArea = All;
                }
                action("FMIM0003")
                {
                    Caption = 'Site & Date Selection Entry';
                    RunObject = page "STDClkshpSite_DateSelectionLST";
                    RunPageMode = View;
                    Image = CalculateCalendar;
                    ApplicationArea = All;
                }
                action("FMIM0004")
                {
                    Caption = 'Site & Date Approvals';
                    RunObject = page "UNVClkshpSite_DateApprovalLST";
                    RunPageMode = View;
                    Image = CalculateCalendar;
                    ApplicationArea = All;
                }

                action("FMIM0005")
                {
                    Caption = 'FM1/IM1 Rotation Scheduling';
                    RunObject = page "FM1_IM1_RotationScheduling";
                    RunPageMode = View;
                    Image = SwitchCompanies;
                    ApplicationArea = All;
                }

                action("FMIM0006")
                {
                    Caption = 'Publish FM1/IM1 Rotation';
                    RunObject = page "FM1_IM1 Roster Publish LST";
                    RunPageMode = View;
                    Image = CalculateCalendar;
                    ApplicationArea = All;
                }

                action("FMIM0007")
                {
                    Caption = 'Publish FM1/IM1 Rotation Student Wise';
                    RunObject = page "Publish FM1/IM1 Rotation";
                    RunPageMode = View;
                    Image = CalculateCalendar;
                    ApplicationArea = All;
                }
                action("FMIM0008")
                {
                    Caption = 'FM1/IM1 Site Selection Revision Analysis';
                    RunObject = page "FM1/IM1 Revision Analysis";
                    RunPageMode = View;
                    Image = AnalysisViewDimension;
                    ApplicationArea = All;
                }

            }

            group("CORE000")
            {
                Caption = 'Core Rotation';
                action("CORE001")
                {
                    Caption = 'Core Rotation Scheduling';
                    RunObject = page "Roster Scheduling List";
                    RunPageMode = View;
                    Image = SuggestChartOfAccounts;
                    ApplicationArea = All;
                }
                action("CORE002")
                {
                    Caption = 'Publish Core Roster';
                    RunObject = page "Core Roster Publish List";
                    RunPageMode = Edit;
                    Image = MapSetup;
                    ApplicationArea = All;
                }
                action("CORE003")
                {
                    Caption = 'Publish Core Rotation Student Wise';
                    RunObject = page "Publish Core Rotation";
                    RunPageMode = Edit;
                    Image = MapSetup;
                    ApplicationArea = All;
                }
            }
            group("ELECTIVE000")
            {
                Caption = 'Elective Rotation';
                action("ELECTIVE001")
                {
                    Caption = 'Rotation Offers';
                    RunObject = page "Rotation Offer List";
                    RunPageMode = View;
                    Image = AccountingPeriods;
                    ApplicationArea = All;
                }
                action("ELECTIVE002")
                {
                    Caption = 'Apply Elective Rotation';
                    RunObject = page "Rotation Offer Apply List";
                    RunPageMode = View;
                    Image = ApplicationWorksheet;
                    ApplicationArea = All;
                }
                action("ELECTIVE003")
                {
                    Caption = 'Confirm Elective Rotation Application';
                    RunObject = page "Elective Appln Confirmation";
                    RunPageMode = View;
                    Image = Confirm;
                    ApplicationArea = All;
                }
                action("ELECTIVE003_1")
                {
                    Caption = 'Elective Applications Alternate Date Acceptance';
                    RunObject = page "Elec Appl Alternate Acceptance";
                    RunPageMode = View;
                    Image = Confirm;
                    ApplicationArea = All;
                }
                action("ELECTIVE004")
                {
                    Caption = 'Elective Rotation Application Approval';
                    RunObject = page "Rotation Appl Approval List";
                    RunPageMode = View;
                    Image = Approval;
                    ApplicationArea = All;
                }
                action("ELECTIVE005")
                {
                    Caption = 'Rotation Scheduling';
                    RunObject = page "Rotation Application Schduling";
                    RunPageMode = View;
                    Image = EntryStatistics;
                    ApplicationArea = All;
                }
                action("ELECTIVE006")
                {
                    Caption = 'Publish Elective Rotation';
                    RunObject = page "Elective Rotation Publish";
                    RunPageMode = View;
                    Image = EntriesList;
                    ApplicationArea = All;
                }
                action("ELECTIVE007")
                {
                    Caption = 'Publish Elective Rotation Student Wise';
                    RunObject = page "Publish Elective Rotation STD";
                    RunPageMode = View;
                    Image = EntriesList;
                    ApplicationArea = All;
                }
                group(NAH0001)
                {
                    Caption = 'Non-Affilated Hospital Rotation Applications';
                    Image = AdministrationSalesPurchases;
                    action(NAH0002)
                    {
                        Caption = 'Non-Affiliated Site Rotation Application';
                        RunObject = page "Non-Affiliated Site Apply List";
                        RunPageMode = View;
                        Image = ServiceItem;
                        ApplicationArea = All;
                    }
                    action(NAH0003)
                    {
                        Caption = 'Non-Affiliated Site Application Approval';
                        RunObject = page "Non-Affiliated Site Apprvl LST";
                        RunPageMode = View;
                        Image = ServiceLedger;
                        ApplicationArea = All;
                    }
                    action(NAH0004)
                    {
                        Caption = 'Non-Affiliated Application Rotation Scheduling';
                        RunObject = page "Non-Afltd Rotation Scheduling";
                        RunPageMode = View;
                        Image = ServiceLedger;
                        ApplicationArea = All;
                    }
                }
            }
            action("LINK0004")
            {
                RunObject = page "Roster Summary List";
                Caption = 'Summary of Rotations';
                RunPageMode = View;
                Image = Invoice;
                ApplicationArea = All;
            }
            group("History")
            {
                Caption = 'Clerkship History';
                action("HIS0001")
                {
                    RunObject = page "Student Clinical Documents+";
                    Caption = 'Verified Documents';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0001_1")
                {
                    RunObject = page "Roster Summary List";
                    Caption = 'Summary of Rotations';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0002")
                {
                    RunObject = page "Roster Ledger Entries";
                    Caption = 'Roster Ledger Entries';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0003")
                {
                    RunObject = page "FM1_IM1 Date Preset LST+";
                    Caption = 'FM1/IM1 Date Presets';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0004")
                {
                    RunObject = page "FM1_IM1 Date Preset LST+";
                    Caption = 'FM1/IM1 Date Presets';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                    Visible = false;
                }
                action("HIS0005")
                {
                    RunObject = page "UNVClkshpSite_DateLST+";
                    Caption = 'FM1/IM1 Approved Date and Sites';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0006")
                {
                    RunObject = page "FM1_IM1 Roster LST+";
                    Caption = 'FM1/IM1 Rosters';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0007")
                {
                    RunObject = page "Confirm Roster Schedule List";
                    Caption = 'Core Rosters';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0008")
                {
                    RunObject = page "Rotation Offer List+";
                    Caption = 'Elective Rotation Offers';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0009")
                {
                    RunObject = page "Elective Rotation List";
                    Caption = 'Elective Rotations';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0010")
                {
                    RunObject = page "Non-Affiliated Site Aprved LST";
                    Caption = 'Non-Affiliated Sites';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0011")
                {
                    RunObject = page "Clerkship Activity Log Entries";
                    Caption = 'Clerkship Activity Log Entries';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("HIS0012")
                {
                    RunObject = page "Clinical Notification Info";
                    Caption = 'Clinical Notification Information';
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
            }

            action("LINK0003")
            {
                Caption = 'View / Update Hold';
                RunObject = page "Students to Update Hold";
                RunPageMode = Edit;
                Image = OpportunitiesList;
                ApplicationArea = All;
            }
            group(RC0001)
            {
                Caption = 'Rotation Cancellation';
                action("LINK0005")
                {
                    Caption = 'Rotation Cancellation Applications';
                    RunObject = page "Rotation Cancellation Applns";
                    RunPageMode = Edit;
                    Image = CancelAllLines;
                    ApplicationArea = All;
                }
                action("LINK0006")
                {
                    Caption = 'Completed Rotation Cancellation Applications';
                    RunObject = page "Rotation Cancellation Applns+";
                    RunPageMode = Edit;
                    Image = CancelAllLines;
                    ApplicationArea = All;
                }
                action("LINK0007")
                {
                    Caption = 'Clerkship Payment Cancellation Approval Request';
                    RunObject = page "Payment Cancell Appl Request";
                    RunPageMode = Edit;
                    Image = MapAccounts;
                    ApplicationArea = All;
                }
            }
            group("CLP0001")
            {
                Caption = 'Clerkship Payments';
                Visible = false;
                action("CLP0002")
                {
                    RunObject = page "Clerkship Payment Hospitals";
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                    Caption = 'Payment Entry';
                }
                action("CLP0003")
                {
                    RunObject = page "Clincal Rotation Check Update";
                    RunPageMode = View;
                    Image = Check;
                    ApplicationArea = All;
                    Caption = 'Update Rotation Check Details';
                }
                action(CLP0004)
                {
                    RunObject = page "Clerkship Payment Ledger Entry";
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                    Caption = 'Clerkship Payment Ledger Entry';
                }
            }

            group("CLB0001")
            {
                Caption = 'Clerkship Student Billing';
                Visible = false;
                action("CLB0002")
                {
                    RunObject = page "CLN Billing Student Summary";
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                    Caption = 'Summary of Students Clerkship';
                }
            }
        }
        area(Sections)
        {
            group("Setup & Masters")
            {
                ToolTip = 'View or Edit Details Related to Clinical Rotation';
                action("Hospitals")
                {
                    RunObject = page "Hospital List";
                    RunPageMode = View;
                    Image = Vendor;
                    ApplicationArea = All;
                }
                action("Clinical Reasons")
                {
                    RunObject = page "Clinical Reasons";
                    RunPageMode = View;
                    Image = Vendor;
                    ApplicationArea = All;
                }
                action("Clinical Groups")
                {
                    RunObject = page "Clinical Groups";
                    RunPageMode = View;
                    Image = Group;
                    ApplicationArea = All;
                }
                action("Contacts")
                {
                    RunObject = page "Contacts List";
                    RunPageMode = View;
                    Image = ContactPerson;
                    ApplicationArea = All;
                }
                action("Clinical Document Category")
                {
                    RunObject = page "Clinical Required Documents";
                    RunPageMode = Edit;
                    Image = Setup;
                    ApplicationArea = All;
                }
                action("Clinical Team Mapping")
                {
                    Caption = 'Clinical Team Mapping';
                    RunObject = page "CLN Coordinator Planning LST";
                    RunPageMode = View;
                    Image = Vendor;
                    ApplicationArea = All;
                }
                action("Import Subject")
                {
                    RunObject = xmlport "Import Subjects";
                    RunPageMode = Edit;
                    Image = Setup;
                    ApplicationArea = All;
                    Visible = false;
                }
                action("Special Accommodation Categories")
                {
                    RunObject = page "Special Accommodation Category";
                    RunPageMode = Edit;
                    Image = Setup;
                    ApplicationArea = All;
                }
                action("View / Update Hold")
                {
                    RunObject = page "Students to Update Hold";
                    RunPageMode = Edit;
                    Image = OpportunitiesList;
                    ApplicationArea = All;
                }
                action("View / Update Student's Group")
                {
                    RunObject = page "View Students Group";
                    RunPageMode = Edit;
                    Image = OpportunitiesList;
                    ApplicationArea = All;
                    Caption = 'View / Update Student''s Group';
                }
                action("Cancelled Rotation Grade Updation")
                {
                    RunObject = page "Rotation Grade Updation";
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                    Caption = 'Cancelled Rotation Grade Updation';
                }
            }
            group("Clinical Documents")
            {
                action("Verify/Upload Documents")
                {
                    //RunObject = page "Student Clinical Documents";
                    RunObject = page "Clinical Document Updation";
                    RunPageMode = View;
                    Image = ShowInventoryPeriods;
                    ApplicationArea = All;
                }
                action("Verified Documents")
                {
                    Caption = 'Verified Documents';
                    RunObject = page "Student Clinical Documents+";
                    RunPageMode = View;
                    Image = LedgerBook;
                    ApplicationArea = All;
                }
                action("Clinical Documents Analysis")
                {
                    //RunObject = page "Student Clinical Documents";
                    RunObject = page "Clinical Documents Analysis";
                    RunPageMode = View;
                    Image = AnalysisView;
                    ApplicationArea = All;
                }
            }
            group("Special Accommodation Application")
            {
                action("Special Accommodation Application for Approval")
                {
                    RunObject = page "Spl Accommodation Approval";
                    RunPageMode = View;
                    Image = Approval;
                    ApplicationArea = All;
                    Caption = 'Application for Approval';
                }
                action("Special Accommodation Applications")
                {
                    RunObject = page "Spl Accommodation Applications";
                    RunPageMode = View;
                    Image = Approval;
                    ApplicationArea = All;
                    Caption = 'Special Accommodation Applications';
                }
            }
            group("FM1/IM1 Clerkship")
            {
                group("FM1/IM1 Rotation Transaction")
                {
                    action("FM1/IM1 Preset Date List")
                    {
                        RunObject = page "FM1/IM1 Preset Date Entry LST";
                        RunPageMode = View;
                        Image = CalculateCalendar;
                        ApplicationArea = All;
                    }
                    action("Site & Date Selection Entry")
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
                    action("FM1/IM1 Rotation Scheduling")
                    {
                        Caption = 'FM1/IM1 Rotation Scheduling';
                        RunObject = page "FM1_IM1_RotationScheduling";
                        RunPageMode = View;
                        Image = SwitchCompanies;
                        ApplicationArea = All;
                    }
                    action("Publish FM1/IM1 Rotation")
                    {
                        Caption = 'Publish FM1/IM1 Rotation';
                        RunObject = page "FM1_IM1 Roster Publish LST";
                        RunPageMode = View;
                        Image = CalculateCalendar;
                        ApplicationArea = All;
                    }

                    action("Publish FM1/IM1 Rotation Student Wise")
                    {
                        Caption = 'Publish FM1/IM1 Rotation Student Wise';
                        RunObject = page "Publish FM1/IM1 Rotation";
                        RunPageMode = View;
                        Image = CalculateCalendar;
                        ApplicationArea = All;
                    }
                    action("FM1/IM1 Site Selection Revision Analysis")
                    {
                        Caption = 'FM1/IM1 Site Selection Revision Analysis';
                        RunObject = page "FM1/IM1 Revision Analysis";
                        RunPageMode = View;
                        Image = AnalysisViewDimension;
                        ApplicationArea = All;
                    }
                }
                group("FM1/IM1 Rotation History")
                {
                    action("Confirmed FM1/IM1 Date Presets")
                    {
                        RunObject = page "FM1_IM1 Date Preset LST+";
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

                    action("FM1/IM1 Rosters")
                    {
                        RunObject = page "FM1_IM1 Roster LST+";
                        RunPageMode = View;
                        Image = CalculateCalendar;
                        ApplicationArea = All;
                    }

                }
            }
            group("Core Rotations")
            {
                group("Core Rotation Transactions")
                {
                    action("Rotation Scheduling")
                    {
                        RunObject = page "Roster Scheduling List";
                        RunPageMode = View;
                        Image = EntriesList;
                        ApplicationArea = All;
                    }
                    action("Publish Core Roster")
                    {
                        RunObject = page "Core Roster Publish List";
                        RunPageMode = Edit;
                        Image = MapSetup;
                        ApplicationArea = All;
                    }
                    action("Publish Core Rotation Student Wise")
                    {
                        RunObject = page "Publish Core Rotation";
                        RunPageMode = Edit;
                        Image = MapSetup;
                        ApplicationArea = All;
                    }
                }
                group("Core Rotation History")
                {
                    action("Confirmed Core Rotations")
                    {
                        RunObject = page "Confirm Roster Schedule List";
                        RunPageMode = View;
                        Image = EntryStatistics;
                        ApplicationArea = All;
                    }
                }
            }

            group("Elective Rotation")
            {
                group("Elective Rotation Transactions")
                {
                    action("Rotation Offers")
                    {
                        RunObject = page "Rotation Offer List";
                        RunPageMode = View;
                        Image = EntriesList;
                        ApplicationArea = All;
                    }
                    action("Apply Elective Rotation")
                    {
                        RunObject = page "Rotation Offer Apply List";
                        RunPageMode = View;
                        Image = EntryStatistics;
                        ApplicationArea = All;
                    }
                    action("Confirm Elective Rotation Application")
                    {
                        RunObject = page "Elective Appln Confirmation";
                        RunPageMode = View;
                        Image = Confirm;
                        ApplicationArea = All;
                    }
                    action("Elective Applications Alternate Date Acceptance")
                    {
                        RunObject = page "Elec Appl Alternate Acceptance";
                        RunPageMode = View;
                        Image = Confirm;
                        ApplicationArea = All;
                    }
                    action("Rotation Application Approval")
                    {
                        Caption = 'Elective Rotation Application Approval';
                        RunObject = page "Rotation Appl Approval List";
                        RunPageMode = View;
                        Image = EntryStatistics;
                        ApplicationArea = All;
                    }
                    action("Elective Rotation Scheduling")
                    {
                        Caption = 'Elective Rotation Scheduling';
                        RunObject = page "Rotation Application Schduling";
                        RunPageMode = View;
                        Image = EntryStatistics;
                        ApplicationArea = All;
                    }
                    action("Publish Elective Rotation")
                    {
                        Caption = 'Publish Elective Rotation';
                        RunObject = page "Elective Rotation Publish";
                        RunPageMode = View;
                        Image = EntriesList;
                        ApplicationArea = All;
                    }
                    action("Publish Elective Rotation Student Wise")
                    {
                        Caption = 'Publish Elective Rotation Student Wise';
                        RunObject = page "Publish Elective Rotation STD";
                        RunPageMode = View;
                        Image = EntriesList;
                        ApplicationArea = All;
                    }
                    group("Non-Affilated Site Rotation Applications")
                    {
                        action("Non-Affiliated Site Rotation Application")
                        {
                            Caption = 'Non-Affiliated Site Rotation Application';
                            RunObject = page "Non-Affiliated Site Apply List";
                            RunPageMode = View;
                            Image = ServiceItem;
                            ApplicationArea = All;
                        }
                        action("Non-Affiliated Site Application Approval")
                        {
                            Caption = 'Non-Affiliated Site Application Approval';
                            RunObject = page "Non-Affiliated Site Apprvl LST";
                            RunPageMode = View;
                            Image = ServiceLedger;
                            ApplicationArea = All;
                        }
                        action("Non-Affiliated Application Rotation Scheduling")
                        {
                            Caption = 'Non-Affiliated Application Rotation Scheduling';
                            RunObject = page "Non-Afltd Rotation Scheduling";
                            RunPageMode = View;
                            Image = ServiceLedger;
                            ApplicationArea = All;
                        }
                    }

                    // action("Rotation for Approval")
                    // {
                    //     RunObject = page "Elective Roster Approval List+";
                    //     RunPageMode = View;
                    //     Image = EntriesList;
                    //     ApplicationArea = All;
                    // }
                }
                group("Elective Rotation History")
                {
                    action("Rotation Offer")
                    {
                        RunObject = page "Rotation Offer List+";
                        RunPageMode = View;
                        Image = EntryStatistics;
                        ApplicationArea = All;
                    }
                    action("Elective Roster")
                    {
                        RunObject = page "Elective Rotation List";
                        RunPageMode = View;
                        Image = EntryStatistics;
                        ApplicationArea = All;
                    }
                    action("Approved Non-Affiliated Applications")
                    {
                        RunObject = page "Non-Affiliated Site Aprved LST";
                        RunPageMode = View;
                        Image = ServiceLedger;
                        ApplicationArea = All;
                    }
                }
            }
            group("Clerkship Assessment")
            {
                Visible = false;
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
                }
                group(Setup)
                {
                    Visible = false;
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
            group(Reports)
            {
                action("Rotation GAP Analysis")
                {
                    RunObject = page "Rotation GAP Analysis";
                    RunPageMode = Edit;
                    Image = OpportunitiesList;
                    ApplicationArea = All;
                }
                action("TWD Analysis")
                {
                    RunObject = page "TWD Analysis";
                    RunPageMode = Edit;
                    Image = OpportunitiesList;
                    ApplicationArea = All;
                }
                action("Clerkships by Hospital")
                {
                    RunObject = page "Hospital Wise Rotations";
                    RunPageMode = Edit;
                    Image = "8ball";
                    ApplicationArea = All;
                    Caption = 'Clerkships by Hospital';
                }
                action("Missing Core")
                {
                    RunObject = report "Missing Core V3";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Clinical Hospital Roster Delta")
                {
                    RunObject = report "Clinical Hospital Roster Delta";
                    RunPageMode = View;
                    Image = Report;
                    ApplicationArea = All;
                    Caption = 'Clinical Hospital Roster Delta';
                }
                action("All Clinical Rotations Point in Time")
                {
                    RunObject = Report MissingClinicalRotationV2;
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Clerkship Attendance by Hospital")
                {
                    RunObject = report ClerkshipAttendancebyhospital;
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Clerkship Attendance Delta Hospital List")
                {
                    RunObject = Report ClerkshipAttendanceDelta;
                    Image = Report;
                    ApplicationArea = All;
                }

                action("Clinical Students On Registration Hold")
                {
                    RunObject = report ClinicalStudentsOnRegHolds;
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Schedule of Rotation")
                {
                    RunObject = report "Schedule of Rotation";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Clinical Rotation List")
                {
                    RunObject = report "Clinical Roster List";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("First Core Report")
                {
                    RunObject = report "1st Core";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("FIU Core Rotation Passed")
                {
                    RunObject = report "FIU Core Rotation Passed";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Save - LGS Letter")
                {
                    RunObject = report "Save LGS - Letter";
                    Image = Report;
                    ApplicationArea = All;
                    Visible = false;
                }
                action("Current and Future Rotations")
                {
                    RunObject = report CurrentandFutureRotations;
                    Image = Report;
                    ApplicationArea = All;

                }
            }
            group("Clerkship Payments")
            {
                Visible = false;
                action("Payment Entry")
                {
                    RunObject = page "Clerkship Payment Hospitals";
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
                action("Update Rotation Check Details")
                {
                    RunObject = page "Clincal Rotation Check Update";
                    RunPageMode = View;
                    Image = Check;
                    ApplicationArea = All;
                    Caption = 'Update Rotation Check Details';
                }
                action("Clerkship Payment Ledger Entry")
                {
                    RunObject = page "Clerkship Payment Ledger Entry";
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                }
            }

            group("Clerkship Student Billing")
            {
                Caption = 'Clerkship Student Billing';
                Visible = false;
                action("Summary of Students Clerkship")
                {
                    RunObject = page "CLN Billing Student Summary";
                    RunPageMode = View;
                    Image = Invoice;
                    ApplicationArea = All;
                    Caption = 'Summary of Students Clerkship';
                }
            }
        }
    }
}
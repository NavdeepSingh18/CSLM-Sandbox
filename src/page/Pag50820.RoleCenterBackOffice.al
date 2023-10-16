page 50820 "Back Office Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineBackOffice)
            {
                ApplicationArea = All;
            }
            part(Activities; BackOfficeRoleCenterCuepage)
            {
                ApplicationArea = Basic, Suite;
            }
            //SD-SN-04-Dec-2020 +

            part("Vendor List"; "My Vendors")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Item List"; "My Items")
            {
                ApplicationArea = Basic, Suite;
            }

            Part("Hospital wise Rotation Scheduled"; "Roster Ledger Entries")
            {
                Caption = 'Hospital wise Rotation Scheduled';
                ApplicationArea = Basic, Suite;
            }
            Part("Hospital wise Rotation Graded"; "Roster Ledger Entries")
            {
                Caption = ' Hospital wise Rotation Graded';
                ApplicationArea = Basic, Suite;
                SubPageView = where(Grade = Filter(<> ' '));
            }
            Part("Hospital wise Invoice Updated"; "Roster Ledger Entries")
            {
                Caption = 'Hospital wise Invoice Updated';
                ApplicationArea = Basic, Suite;
                SubPageView = where("Invoice No." = filter(<> ''), "Invoice Date" = Filter(<> ''));
            }
            Part("Hospital wise Check No. Updated"; "Roster Ledger Entries")
            {
                Caption = 'Hospital wise Check No. Updated';
                ApplicationArea = Basic, Suite;
                SubPageView = where("Check No." = filter(<> ''), "Check Date" = Filter(<> ''));
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
            group(Purchase)
            {
                group("Purchase Setup")
                {
                    action("Gen. Bus. Posting Group")
                    {
                        RunObject = Page "Gen. Business Posting Groups";    //312
                        ApplicationArea = Basic, Suite;
                    }
                    action("Gen. Product Posting Group")
                    {
                        RunObject = page "Gen. Product Posting Groups";    //313
                        ApplicationArea = Basic, Suite;
                    }
                    action("Vendor Posting Group")
                    {
                        RunObject = page "Vendor Posting Groups";   //111
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase and Payable Setup")
                    {
                        RunObject = page "Purchases & Payables Setup";  //460
                        ApplicationArea = Basic, Suite;
                    }
                    action("Shipment Methods")
                    {
                        RunObject = page "Shipment Methods";    //11
                        ApplicationArea = Basic, Suite;
                    }
                    action("Transport Method")
                    {
                        RunObject = page "Transport Methods";   //309
                        ApplicationArea = Basic, Suite;
                    }
                    action("Unit of Measure")
                    {
                        RunObject = page "Units of Measure";    //209
                        ApplicationArea = Basic, Suite;
                    }
                    action("Configuration Package")
                    {
                        RunObject = page "Config. Packages";    //8615
                        ApplicationArea = Basic, Suite;
                    }
                    action(Workflows)
                    {
                        RunObject = page Workflows;  //1500
                        ApplicationArea = Basic, Suite;
                    }
                    action("Workflows Templates")
                    {
                        RunObject = page "Workflow Templates";  //1505
                        ApplicationArea = Basic, Suite;
                    }
                    action(Locations)
                    {
                        RunObject = page "Location List";   //15
                        ApplicationArea = Basic, Suite;
                    }
                }
                Group("General Journal")
                {
                    Action("General Journals")
                    {
                        RunObject = Page "General Journal";  //39
                        ApplicationArea = Basic, Suite;
                    }
                }
                Group("Requisition")
                {  //CSPL-00307
                    action("Requisition List")
                    {
                        RunObject = page "Requisition List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Send to Store History")
                    {
                        RunObject = page "Send to store History";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Requisition Store List")
                    {
                        RunObject = page "Requisition Store List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Requisition Approval Setups")
                    {
                        RunObject = page "Requisition Approval Setup";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Request Req. Approval Entries")
                    {
                        RunObject = page "Request Req. Approval Entries";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approval Requisition History")
                    {
                        RunObject = page "Approval Requisition History";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Requisition Completed")
                    {
                        RunObject = page "Requisition Completed";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Requisition Minimum Stock Setups")
                    {
                        RunObject = page "Requisition Approval Setups";
                        ApplicationArea = Basic, Suite;
                    }
                }//CSPL-00307
                group("Purchase Activities")
                {
                    action("Vendors Master")
                    {
                        RunObject = page "Vendor List";     //27
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Master")
                    {
                        RunObject = page "Item List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase Quotes")
                    {
                        RunObject = page "Purchase Quotes";     //9306
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase Orders")
                    {
                        RunObject = page "Purchase Order List";     //9307
                        ApplicationArea = Basic, Suite;
                    }
                    action("Blanket Purchase Orders")
                    {
                        Visible = false;
                        RunObject = page "Blanket Purchase Orders";     //9310
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase Return Orders")
                    {
                        Visible = false;
                        RunObject = page "Purchase Return Order List";      //9311
                        ApplicationArea = Basic, Suite;
                    }
                    action("Transfer Orders")
                    {
                        RunObject = page "Transfer Orders";     //5742
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase Invoice")
                    {
                        visible = false;
                        RunObject = page "Purchase Invoices";   //9308
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase Credit Memo")
                    {
                        visible = false;
                        RunObject = page "Purchase Credit Memos";   //9309
                        ApplicationArea = Basic, Suite;
                    }
                    action("Request to Approve")
                    {
                        RunObject = page "Requests to Approve";   //654
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Purchase Reports")
                {
                    // action("Purchase Order Status")
                    // {
                    //     RunObject = report "Purchase Order Status";     //10156
                    //     ApplicationArea = Basic, Suite;
                    // }

                    // action("Budget Vs Actual Report")
                    // {
                    //     RunObject = report BudgetVsActual;     //50285
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Aged Accounts Payable")
                    // {
                    //     RunObject = report "Aged Accounts Payable NA";  //10085
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Vendor Purchase by Item")
                    // {
                    //     RunObject = report "Vendor Purchases by Item";     //10163
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Vendor -Balance at Date")
                    {
                        RunObject = report "Vendor - Balance to Date";      //321
                        ApplicationArea = Basic, Suite;
                    }
                    action("Vendor-Trial Balance")
                    {
                        RunObject = report "Vendor - Trial Balance";    //329
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase Order Tracking")
                    {
                        RunObject = report "Purchase Order Tracking";    //50238
                        ApplicationArea = Basic, Suite;
                    }


                }
                group("Purchase Posted Documents")
                {
                    action("Purchase Quotes Archives")
                    {
                        RunObject = page "Purchase Quote Archives";     //9346
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase Order Archives")
                    {
                        RunObject = page "Purchase Order Archives";     //9347
                        ApplicationArea = Basic, Suite;
                    }
                    action("Posted Purchase Invoices")
                    {
                        Visible = false;
                        RunObject = page "Posted Purchase Invoices";    //146
                        ApplicationArea = Basic, Suite;
                    }
                    action("Posted Purchase Credit Memos")
                    {
                        Visible = false;
                        RunObject = page "Posted Purchase Credit Memos";    //147
                        ApplicationArea = Basic, Suite;
                    }
                    action("Posted Purchase Reciepts")
                    {
                        RunObject = page "Posted Purchase Receipts";    //145
                        ApplicationArea = Basic, Suite;
                    }
                    action("Purchase Return Order Archives")
                    {
                        Visible = false;
                        RunObject = page "Purchase Return List Archive";    //6646
                        ApplicationArea = Basic, Suite;
                    }
                    action("Posted Purchase Return Shipment")
                    {
                        Visible = false;
                        RunObject = page "Posted Return Shipments";     //6652
                        ApplicationArea = Basic, Suite;
                    }
                    action("Vendor Ledger Entries")
                    {
                        RunObject = page "Vendor Ledger Entries";       //29
                        ApplicationArea = Basic, Suite;
                    }
                    action("Value Entries")
                    {
                        RunObject = page "Value Entries";       //5802
                        ApplicationArea = Basic, Suite;
                    }
                    action("Posted Transfer Reciept")
                    {
                        RunObject = page "Posted Transfer Receipts";    //5753
                        ApplicationArea = Basic, Suite;
                    }
                    action("Posted Transfer Shipment")
                    {
                        RunObject = page "Posted Transfer Shipments";       //5752
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group(Finance)
            {
                action("Chart of Account")
                {
                    RunObject = Page "Chart of Accounts";  //16
                    ApplicationArea = Basic, Suite;
                }
                action(Dimensions)
                {
                    RunObject = page Dimensions;     //536
                    ApplicationArea = Basic, Suite;
                }
                action("SAP Integration Date Request")
                {
                    RunObject = page "SAP Integration Date Request";
                    ApplicationArea = Basic, Suite;
                }

            }

            group(Inventory)
            {
                group("Inventory Setup")
                {
                    action("Inventory Setups")
                    {
                        RunObject = Page "Inventory Setup";     //461
                        ApplicationArea = Basic, Suite;
                    }
                    action("Inventory Posting Group")
                    {
                        RunObject = page "Inventory Posting Groups";    //112
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Journal Templates")
                    {
                        RunObject = page "Item Journal Templates";      //102
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Inventory Activies")
                {
                    action(Items)
                    {
                        RunObject = page "Item List";       //31
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Category")
                    {
                        RunObject = page "Item Categories";     //5730
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Journals")
                    {
                        RunObject = page "Item Journal";    //40
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Journal Batches")
                    {
                        RunObject = page "Item Journal Batches";    //262
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Reclassification Journals")
                    {
                        RunObject = page "Item Reclass. Journal";   //393
                        ApplicationArea = Basic, Suite;
                    }
                    action("Physical Inventory Journals")
                    {
                        RunObject = page "Phys. Inventory Journal";     //392
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Revaluation Journals")
                    {
                        RunObject = page "Revaluation Journal";     //5803
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Inventory Reports")
                {
                    action("Inventory Valuation")
                    {
                        RunObject = report "Inventory Valuation";   //10139
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Age Composition-Qty.")
                    {
                        RunObject = report "Item Age Composition - Qty.";   //5807
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Age Composition-Value")
                    {
                        RunObject = report "Item Age Composition - Value";      //5808
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Inventory Posted Documents")
                {
                    action("Item Ledger Entries")
                    {
                        RunObject = page "Item Ledger Entries";     //38
                        ApplicationArea = Basic, Suite;
                    }
                    action("Item Register")
                    {
                        RunObject = page "Item Registers";      //117
                        ApplicationArea = Basic, Suite;
                    }
                    action("Physical Inventory Ledger Entries")
                    {
                        RunObject = page "Phys. Inventory Ledger Entries";      //390
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Taxation")
            {
                group("Taxation Setup")
                {
                    action("Tax Groups")
                    {
                        RunObject = page "Tax Groups";      //464
                        ApplicationArea = Basic, Suite;
                    }
                    action("Tax Areas")
                    {
                        RunObject = page "Tax Area List";       //469
                        ApplicationArea = Basic, Suite;
                    }
                    action("Tax Juridictions")
                    {
                        RunObject = page "Tax Jurisdictions";   //466
                        ApplicationArea = Basic, Suite;
                    }
                    action("Tax Setup")
                    {
                        RunObject = page "Tax Setup";   //485
                        ApplicationArea = Basic, Suite;
                    }
                    action("Vat Posting Setup")
                    {
                        RunObject = page "VAT Posting Setup";   //472
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Taxation Activities")
                {
                    // action("Sales Tax Journal")
                    // {
                    //     RunObject = page "Sales Tax Journal";   //10101
                    //     applicationarea = Basic, Suite;
                    // }
                }
                group("Taxation Posted Document")
                {
                    action("Tax Entries")
                    {
                        RunObject = page "VAT Entries";     //315
                        applicationarea = Basic, Suite;
                    }
                }
            }
            Group("Clinical Vendor Payment Module")
            {
                group("Hospital Master")
                {
                    Action("Hospital List")
                    {
                        RunObject = Page "Hospital List";   //50435
                        ApplicationArea = Basic, Suite;
                    }

                }
                group("Clerkship Payment")
                {
                    action("Payment Entry")
                    {
                        RunObject = Page "Clerkship Payment Hospitals";     //50596
                        ApplicationArea = Basic, Suite;
                    }
                    action("Update Rotation Check No.")
                    {
                        RunObject = Page "Clincal Rotation Check Update";   //50665
                        ApplicationArea = Basic, Suite;
                    }
                    action("Invoice/Payment Cancellation Approval")
                    {
                        RunObject = Page "Payment Cancell Appl Request";   //50657
                        ApplicationArea = Basic, Suite;
                    }
                    Action("Invoice Check Details Upload")
                    {
                        RunObject = page "Invoice Check Details Update";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Clerkship History")
                {
                    action("Clerkship Payment Ledger Entries")
                    {
                        RunObject = Page "Clerkship Payment Ledger Entry";      //50599
                        ApplicationArea = Basic, Suite;
                    }
                    action("Clerkship Payment Cancellation Approval Request")
                    {
                        RunObject = Page "Payment Cancell Appl Request";      //50657
                        ApplicationArea = Basic, Suite;
                    }
                    action("Rotation Ledger Entries")
                    {
                        RunObject = Page "Roster Ledger Entries";       //50664
                        ApplicationArea = Basic, Suite;
                    }
                }

                group(Reports)
                {
                    Action("KK Report")
                    {
                        RunObject = Report "KK Report";       //50221
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
                    action("Student Statement of Accounts")
                    {
                        Caption = 'Student Statement of Accounts';
                        RunObject = Report "Student Statement of Account";
                        ApplicationArea = All;
                    }
                }

            }
            group("Admission Master")
            {
                // action("Group Master")
                // {
                //     RunObject = Page "Group Detail-CS";
                //     ApplicationArea = Basic, Suite;
                // }
                action("Student Group")
                {
                    RunObject = Page "Group(Student)-CS";
                    ApplicationArea = Basic, Suite;
                }
            }

        }

    }
}
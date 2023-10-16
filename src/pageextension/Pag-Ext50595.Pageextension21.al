pageextension 50595 ExtendCustomerCard extends "Customer Card"
{
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Prices and Discounts,Navigate,Customer,Ledger Entries,Legacy Ledger Entries,Aged Accounts Receivable';
    layout
    {
        addafter("Balance (LCY)")
        {
            field("Tuition Balance"; Rec."Tuition Balance")
            {
                ApplicationArea = All;
                Caption = 'Tuition Balance';
                Editable = false;
                Lookup = true;
                Visible = BalanceNew;
                DrillDown = true;

                trigger OnDrillDown()
                var
                    CustomerLedEntries: Record "Cust. Ledger Entry";
                begin
                    CustomerLedEntries.FilterGroup(0);
                    CustomerLedEntries.reset();
                    CustomerLedEntries.SetRange("Customer No.", Rec."No.");
                    CustomerLedEntries.SetRange(Open, true);
                    CustomerLedEntries.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Filter");
                    CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '');
                    if CustomerLedEntries.FindFirst() then begin
                        page.Run(25, CustomerLedEntries);
                        CustomerLedEntries.FilterGroup(2);
                    end;
                end;

            }
            field("Grenville Balance"; Rec."Grenville Balance")
            {
                ApplicationArea = All;
                Caption = 'Grenville Balance';
                Visible = BalanceNew;
                Editable = false;
                Lookup = true;
                DrillDown = true;

                trigger OnDrillDown()
                var
                    CustomerLedEntries: Record "Cust. Ledger Entry";
                begin
                    CustomerLedEntries.FilterGroup(0);
                    CustomerLedEntries.reset();
                    CustomerLedEntries.SetRange("Customer No.", Rec."No.");
                    CustomerLedEntries.SetRange(Open, true);
                    CustomerLedEntries.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Filter");
                    CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9300');
                    if CustomerLedEntries.FindFirst() then begin
                        page.Run(25, CustomerLedEntries);
                        CustomerLedEntries.FilterGroup(2);
                    end;
                end;

            }
            field("AUA Housing Balance"; Rec."AUA Housing Balance")
            {
                ApplicationArea = All;
                Caption = 'AUA Housing Balance';
                Visible = BalanceNew;
                Editable = false;
                Lookup = true;
                DrillDown = true;
                trigger OnDrillDown()
                var
                    CustomerLedEntries: Record "Cust. Ledger Entry";
                begin
                    CustomerLedEntries.FilterGroup(0);
                    CustomerLedEntries.reset();
                    CustomerLedEntries.SetRange("Customer No.", Rec."No.");
                    CustomerLedEntries.SetRange(Open, true);
                    CustomerLedEntries.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Filter");
                    CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9500');
                    if CustomerLedEntries.FindFirst() then begin
                        page.Run(25, CustomerLedEntries);
                        CustomerLedEntries.FilterGroup(2);
                    end;
                end;

            }
        }
        addafter(General)
        {
            group("Student Information")

            {
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field("Scholarship Source"; Rec."Scholarship Source")
                {
                    ApplicationArea = All;
                }
                field("Grant Code 1"; Rec."Grant Code 1")
                {
                    ApplicationArea = All;
                }
                field("Grant Code 2"; Rec."Grant Code 2")
                {
                    ApplicationArea = All;
                }
                field("Grant Code 3"; Rec."Grant Code 3")
                {
                    ApplicationArea = All;
                }
                field("Sibling/Spouse No."; Rec."Sibling/Spouse No.")
                {
                    ApplicationArea = all;
                }
                field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
                {
                    ApplicationArea = all;
                }


                field("Payment Plan Applied"; Rec."Payment Plan Applied")
                {
                    ApplicationArea = all;
                }

                field("Financial Aid Approved"; Rec."Financial Aid Approved")
                {
                    ApplicationArea = all;
                }

                field("Self Payment Applied"; Rec."Self Payment Applied")
                {
                    ApplicationArea = all;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                }
                // field("Fee Generated Amount"; Rec."Fee Generated Amount")
                // {
                //   ApplicationArea = all;
                //}

            }
        }
        addlast(General)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            // field("Parent Customer"; Rec."Parent Customer")
            // {
            //     ApplicationArea = All;
            // }
            // field("Lateral Student"; Rec."Lateral Student")
            // {
            //     ApplicationArea = All;
            // }



        }
        addlast(factboxes)
        {
            // part(EnrollmentwiseStudentFactbox; EnrollmentwiseStudentFactbox)
            // {
            //     ApplicationArea = all;
            //     subpagelink = "Original Student No." = field("No.");
            // }
        }
        modify(SalesHistSelltoFactBox)
        {
            Visible = false;
        }
        modify(CustomerStatisticsFactBox)
        {
            Visible = false;
        }
        modify(Control1905532107)
        {
            Visible = false;
        }

    }

    actions
    {
        modify(NewReminder)
        {
            Visible = false;
        }
        modify(NewSalesCreditMemo)
        {
            Visible = false;
        }
        modify(NewSalesOrder)
        {
            Visible = false;
        }
        modify(NewSalesInvoice)
        {
            Visible = false;
        }
        modify(NewSalesQuote)
        {
            Visible = false;
        }

        addafter("Bank Accounts")
        {
            action("Student Card")
            {
                ApplicationArea = All;
                ToolTip = 'Student';
                RunObject = page "Student Detail Card-CS";
                RunPageLink = "No." = field("No.");
                Image = Accounts;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
            }
        }
        addfirst(processing)
        {
            group("Ledger Entries")
            {
                Visible = BalanceNew;

                action("Customer Ledger Entries")
                {
                    Caption = 'Customer Ledger Entries';
                    Visible = BalanceNew;
                    ApplicationArea = Basic, Suite;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetCurrentKey("Entry No.");
                        CustomerLedEntries.SetRange("Customer No.", Rec."No.");
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;


                }

                action("Tuition Ledger")
                {
                    Caption = 'Tuition Ledger';
                    Visible = BalanceNew;
                    ApplicationArea = Basic, Suite;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                        CustomerLedgerEntry: Page "Customer Ledger Entries";
                    begin
                        Clear(CustomerLedgerEntry);
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."No.");
                        //CustomerLedEntries.SetRange(Open, true);
                        // CustomerLedEntries.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '');
                        //page.Run(25, CustomerLedEntries);
                        CustomerLedgerEntry.SetTableView(CustomerLedEntries);
                        CustomerLedgerEntry.Run();
                        CustomerLedEntries.FilterGroup(2);

                    end;

                }

                action("AUA Housing Ledger")
                {
                    Caption = 'AUA Housing Ledger';
                    Visible = BalanceNew;
                    ApplicationArea = Basic, Suite;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9500');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;

                }
                action("Grenville Ledger")
                {
                    Caption = 'Grenville Ledger';
                    Visible = BalanceNew;
                    ApplicationArea = Basic, Suite;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9300');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;

                }
                Action("Consolidated Student Ledger")
                {
                    ApplicationArea = All;
                    Image = Report;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        Customer_lRec: Record Customer;
                        ConsolidatedStudentLedger: Report "Consolidated Student Ledger";
                    Begin
                        Clear(ConsolidatedStudentLedger);
                        Customer_lRec.Reset();
                        Customer_lRec.SetRange("No.", Rec."No.");
                        Customer_lRec.SetRange("Date Filter", 0D, CALCDATE('<1Y>', Today));//GAURAV//22/07/22//
                        // Customer_lRec.SetRange("Global Dimension 2 Filter", '');
                        // Report.RunModal(Report::"Consolidated Student Ledger", True, False, Customer_lRec);
                        ConsolidatedStudentLedger.SetTableView(Customer_lRec);
                        ConsolidatedStudentLedger.GetDepartmentFilter('''''');
                        ConsolidatedStudentLedger.Run();
                    End;
                }
            }

            group("Legacy Ledger Entries")
            {
                Visible = BalanceNew;

                action("Legacy Ledger")
                {
                    Caption = 'Legacy Ledger';
                    Visible = BalanceNew;
                    ApplicationArea = Basic, Suite;
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    // trigger OnAction()
                    // var
                    //     StudenLegacyLedger: Record "Student Legacy Ledger";
                    //     StudentLegacyLed: Page "Studen Legacy Ledger";

                    // begin
                    //     Clear(StudentLegacyLed);
                    //     StudenLegacyLedger.FilterGroup(0);
                    //     StudenLegacyLedger.reset();
                    //     StudenLegacyLedger.SetCurrentKey("Post Date");
                    //     StudenLegacyLedger.SetAscending("Post Date", false);
                    //     StudenLegacyLedger.SetRange("Student Number", Rec."No.");
                    //     //                        if StudenLegacyLedger.FindFirst() then begin
                    //     // page.Run(50772, StudenLegacyLedger);
                    //     StudentLegacyLed.SetTableView(StudenLegacyLedger);
                    //     StudentLegacyLed.Run();
                    //     StudenLegacyLedger.FilterGroup(2);

                    // end;
                }

                action("Legacy Tuition Ledger")
                {
                    Caption = 'Legacy Tuition Ledger';
                    Visible = BalanceNew;
                    ApplicationArea = Basic, Suite;
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    // RunObject = page "Studen Legacy Ledger";
                    // RunPageLink = "Student Number" = field("No."), "Charge Type" = const(Tuition);
                    // RunPageView = sorting("Student Number", "Enrollment", TN) order(ascending);
                    // trigger OnAction()
                    // var
                    //     StudenLegacyLedger: Record "Student Legacy Ledger";

                    // begin
                    //     StudenLegacyLedger.FilterGroup(0);
                    //     StudenLegacyLedger.reset();
                    //     StudenLegacyLedger.SetCurrentKey("Student Number", Enrollment, TN);
                    //     StudenLegacyLedger.Ascending(true);
                    //     StudenLegacyLedger.SetRange("Student Number", "No.");
                    //     StudenLegacyLedger.SetRange("Charge Type", StudenLegacyLedger."Charge Type"::Tuition);
                    //     if StudenLegacyLedger.FindFirst() then begin
                    //         page.Run(50772, StudenLegacyLedger);
                    //         StudenLegacyLedger.FilterGroup(2);
                    //     end;
                    // end;
                }

                action("Legacy AUA Housing Ledger")
                {
                    Caption = 'Legacy AUA Housing Ledger';
                    Visible = BalanceNew;
                    ApplicationArea = Basic, Suite;
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    // RunObject = page "Studen Legacy Ledger";
                    // RunPageLink = "Student Number" = field("No."), "Charge Type" = const(Housing),
                    //                                                 "Global Dimension 2 Code" = filter(9500);
                    // RunPageView = sorting("Student Number", "Enrollment", TN) order(ascending);
                    // trigger OnAction()
                    // var
                    //     StudenLegacyLedger: Record "Student Legacy Ledger";
                    // begin
                    //     StudenLegacyLedger.FilterGroup(0);
                    //     StudenLegacyLedger.reset();
                    //     //StudenLegacyLedger.SetCurrentKey("Post Date");
                    //     //StudenLegacyLedger.SetAscending("Post Date", false);
                    //     StudenLegacyLedger.SetCurrentKey("Student Number", Enrollment, TN);
                    //     StudenLegacyLedger.Ascending(true);
                    //     StudenLegacyLedger.SetRange("Student Number", "No.");
                    //     StudenLegacyLedger.SetRange("Charge Type", StudenLegacyLedger."Charge Type"::Housing);
                    //     StudenLegacyLedger.SetRange("Global Dimension 2 Code", '9500');
                    //     if StudenLegacyLedger.FindFirst() then begin
                    //         page.Run(50772, StudenLegacyLedger);
                    //     end;
                    //     StudenLegacyLedger.FilterGroup(2);
                    // end;

                }
                action("Legacy Grenville Ledger")
                {
                    Caption = 'Legacy Grenville Ledger';
                    Visible = BalanceNew;
                    ApplicationArea = Basic, Suite;
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    // RunObject = page "Studen Legacy Ledger";
                    // RunPageLink = "Student Number" = field("No."), "Charge Type" = const(Housing),
                    //                                                 "Global Dimension 2 Code" = filter(9300);
                    // RunPageView = sorting("Student Number", "Enrollment", TN) order(ascending);
                    // trigger OnAction()
                    // var
                    //     StudenLegacyLedger: Record "Student Legacy Ledger";

                    // begin
                    //     StudenLegacyLedger.FilterGroup(0);
                    //     StudenLegacyLedger.reset();
                    //     //StudenLegacyLedger.SetCurrentKey("Post Date");
                    //     //StudenLegacyLedger.SetAscending("Post Date", false);
                    //     StudenLegacyLedger.SetCurrentKey("Student Number", Enrollment, TN);
                    //     StudenLegacyLedger.Ascending(true);
                    //     StudenLegacyLedger.SetRange("Student Number", "No.");
                    //     StudenLegacyLedger.SetRange("Charge Type", StudenLegacyLedger."Charge Type"::Housing);
                    //     StudenLegacyLedger.SetRange("global Dimension 2 code", '9300');
                    //     if StudenLegacyLedger.FindFirst() then begin
                    //         page.Run(50772, StudenLegacyLedger);
                    //     end;
                    //     StudenLegacyLedger.FilterGroup(2);
                    // end;

                }
            }
            group("Aged Accounts Receivable1")
            {
                Caption = 'Aged Accounts Receivable';

                action("Aged Accounts Receivable Tuition")
                {
                    Caption = 'Aged Acc. Rec. Tuition';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category12;
                    PromotedIsBig = true;
                    Image = Report;
                    trigger OnAction()
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetFilter("No.", Rec."No.");
                        CustomerRec.SetFilter("Global Dimension 2 Filter", '<>%1&<>%2', '9500', '9300');
                        Report.RunModal(10040, true, false, CustomerRec);
                    end;
                }
                action("Aged Accounts Receivable Grenville")
                {
                    Caption = 'Aged Acc. Rec. Grenville';
                    ApplicationArea = basic, suite;
                    Promoted = true;
                    PromotedCategory = Category12;
                    PromotedIsBig = true;
                    Image = Report;
                    trigger OnAction()
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetFilter("No.", Rec."No.");
                        CustomerRec.SetFilter("Global Dimension 2 Filter", '9300');
                        Report.RunModal(10040, true, false, CustomerRec);
                    end;
                }
                action("Aged Accounts Receivable AUA Housing")
                {
                    Caption = 'Aged Acc. Rec. AUA Housing';
                    ApplicationArea = basic, suite;
                    Promoted = true;
                    PromotedCategory = Category12;
                    PromotedIsBig = true;
                    Image = Report;
                    trigger OnAction()
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetFilter("No.", Rec."No.");
                        CustomerRec.SetFilter("Global Dimension 2 Filter", '9500');
                        Report.RunModal(10040, true, false, CustomerRec);
                    end;
                }
            }

            group("General Journal")
            {
                action("General Journal1")
                {
                    Caption = 'General Journal';
                    RunObject = Page "General Journal";//"39"
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                // action("Payment Plan Journal")
                // {
                //     // RunObject = Page "Pending Payment Plan List";//"50656";//"FinancialAIDApprovRejectList";//"50653"
                //     RunObject = page "Payment Plan Journal";//"50680"
                //                                             // RunPageLink = Type = filter("Payment Plan"), Status = filter("Pending for Approval");
                //     ApplicationArea = Basic, Suite;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                // }
                // action("Fee Journal")
                // {
                //     RunObject = Page "Fee Journal";//"50681"
                //     ApplicationArea = Basic, Suite;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                // }
                // action("Scholarship/Grant Journals")
                // {
                //     RunObject = Page "Scholarship Grant Journal";//"50683"
                //     ApplicationArea = Basic, Suite;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                // }
                // action("Waiver Journal")
                // {
                //     RunObject = Page "Waiver Journal";//"50682"
                //     ApplicationArea = Basic, Suite;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                // }
                // action("Utilities Journal")
                // {
                //     RunObject = Page "Utilities Journal";//"50806"
                //     ApplicationArea = Basic, Suite;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                // }
            }
            group("Payment Journal")
            {
                action("Payment Journal1")
                {
                    Caption = 'Payment Journal';
                    RunObject = Page "Payment Journal";//"256"
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action("Cash Reciept Journal")
                {
                    RunObject = Page "Cash Receipt Journal";//"255"
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                // action("T4 Advance")
                // {
                //     RunObject = Page "T4 Advance Journal";//"50709"
                //     ApplicationArea = Basic, Suite;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                // }
                // action("T4 Stipend")
                // {
                //     RunObject = Page "T4 Stipend Journal";//"50710"
                //     ApplicationArea = Basic, Suite;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                // }
            }
        }
    }

    trigger OnOpenPage()
    begin
        RoleAndPermissionNew();
    end;

    var
        CustomerRec: Record Customer;

        UserSetup: Record "User Setup";

        BalanceNew: Boolean;

    procedure RoleAndPermissionNew()
    var
        usersetupapprover: Record "Document Approver Users";
    begin
        BalanceNew := true;
        if usersetupapprover.get(Userid(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            BalanceNew := true
        else
            if usersetupapprover.get(Userid(), usersetupapprover."Department Approver Type"::" ") then
                BalanceNew := true
            else
                if usersetupapprover.get(Userid(), usersetupapprover."Department Approver Type"::BackOffice) then
                    BalanceNew := true

                else
                    if usersetupapprover.get(Userid(), usersetupapprover."Department Approver Type"::"Bursar Department") then
                        BalanceNew := true
                    else
                        BalanceNew := false;
        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Financial Aid Department") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") or (UserSetup."Department Approver" = UserSetup."Department Approver"::BackOffice) or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::"Bursar Department") then
        //         BalanceNew := true
        //     else
        //         BalanceNew := false;
    end;
}
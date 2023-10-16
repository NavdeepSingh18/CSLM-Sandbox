page 50765 "Bursar Signoff Details"
{
    PageType = Card;
    Caption = 'Bursar Signoff Details';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Student Master-CS";

    layout
    {
        area(Content)
        {
            group("Student Balances")
            {
                field("Current Balance"; Rec."Current Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Current Balance';
                    Lookup = true;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetFilter("Enrollment No.", Rec."Enrollment No.");
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;
                }
                field("Old Dues"; "Old Dues")
                {
                    ApplicationArea = All;
                    Caption = 'Old Dues';
                    Editable = false;
                    Lookup = true;
                    // trigger OnDrillDown()
                    // var
                    //     CustomerLedgerEntry: Record "Cust. Ledger Entry";
                    // begin
                    //     CustomerLedgerEntry.FilterGroup(0);
                    //     CustomerLedgerEntry.reset();
                    //     CustomerLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Customer No.");
                    //     // CustomerLedgerEntry.SetRange("Document Type", CustomerLedgerEntry."Document Type"::Invoice);
                    //     CustomerLedgerEntry.SetRange("Customer No.", Rec."No.");
                    //     CustomerLedgerEntry.SetRange(Reversed, false);
                    //     CustomerLedgerEntry.SetFilter("Remaining Amount", '>%1', 0);
                    //     // CustomerLedgerEntry.SetFilter(Semester, '<>%1', gSem);
                    //     // CustomerLedgerEntry.SetFilter("Academic Year", gaY);
                    //     if CustomerLedgerEntry.FindSet() then;
                    //     Page.Run(25, CustomerLedgerEntry);
                    //     CustomerLedgerEntry.FilterGroup(2);
                    // end;
                }
                field("Tuition Balance"; Rec."Tuition Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Tuition Balance';
                    Lookup = true;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetFilter("Global Dimension 1 Code", '%1', Rec."Global Dimension 1 Code");
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
                    Lookup = true;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetFilter("Global Dimension 1 Code", '%1', Rec."Global Dimension 1 Code");
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
                    Lookup = true;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetFilter("Global Dimension 1 Code", '%1', Rec."Global Dimension 1 Code");
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9500');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;
                }

            }
            group("Current Semester Total Fees")
            {
                field(Fee; Fees)
                {
                    ApplicationArea = All;
                    Caption = 'Tuition Fees';
                    Editable = false;
                    Lookup = true;

                }
                // field(Housing; Rec.Housing1)//GMCSCOM
                // {
                //     ApplicationArea = All;
                //     Caption = 'Housing Fees';
                //     Editable = false;
                //     Lookup = true;
                // }

            }

            group("Financial Aid Details")
            {
                Visible = FincancialAid;
                field("Title-4 Agreement Status"; "Title-4 Agreement Status")
                {
                    ApplicationArea = All;
                    Caption = 'Title-4 Agreement Status';
                    Editable = false;
                }
                field(FincancialAidApplicationExist; FincancialAidApplicationExist)
                {
                    ApplicationArea = All;
                    Caption = 'Financial AID Application Exist';
                    Editable = false;
                    Lookup = true;
                }
                field("Financial AID Approved Amount"; "Financial AID Field & Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Financial AID Approved Amount';
                    Editable = false;

                    Lookup = true;
                }
                field("Type of FA Roster"; Rec."Type of FA Roster")
                {
                    ApplicationArea = All;
                    Caption = 'Type of FA Roster';
                    Editable = false;
                    Lookup = true;
                }

                field("Financial Aid Application No."; FinancialAidAppNo)
                {
                    ApplicationArea = All;
                    Lookup = true;
                    DrillDown = true;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        FinancialAID.FilterGroup(0);
                        FinancialAID.reset();
                        FinancialAID.SetRange("Student No.", gStudentNo);
                        FinancialAID.SetRange(Semester, gSem);
                        FinancialAID.SetRange("Academic Year", gaY);
                        FinancialAID.SetRange(Type, FinancialAID.Type::"Financial Aid");
                        //FinancialAID.SetFilter(Status, '%1|%2', FinancialAID.Status::Approved, FinancialAID.Status::Rejected);
                        if FinancialAID.FindFirst() then begin
                            if FinancialAID.Status = FinancialAID.Status::"Pending for Approval" then begin
                                Page.Run(50652, FinancialAID);
                                FinancialAID.FilterGroup(2);
                            end;
                            if (FinancialAID.Status = FinancialAID.Status::Rejected) or (FinancialAID.Status = FinancialAID.Status::Approved) then begin
                                Page.Run(50653, FinancialAID);
                                FinancialAID.FilterGroup(2);
                            end;
                        end;
                    end;
                }
            }
            group("Housing Application")
            {
                field("Housing Application Exist"; "Housing Application Exist")
                {
                    ApplicationArea = All;
                    Caption = 'Housing Application Exist';
                    Editable = false;
                    Lookup = true;
                    trigger OnDrillDown()
                    var
                        HousingApplication: Record "Housing Application";
                    begin
                        HousingApplication.reset();
                        HousingApplication.setrange("Academic Year", gaY);
                        HousingApplication.setrange(Semester, gSem);
                        HousingApplication.setrange("Student No.", gStudentNo);
                        HousingApplication.setrange(Term, GTerm);
                        if HousingApplication.FindFirst() then;
                        Page.Run(0, HousingApplication);
                    end;
                }
                field("Housing Application Cost"; "Housing Application Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Housing Application Cost';
                    Editable = false;
                    Lookup = true;
                    trigger OnDrillDown()
                    var
                        HousingApplication: Record "Housing Application";
                    begin
                        HousingApplication.reset();
                        HousingApplication.setrange("Academic Year", gaY);
                        HousingApplication.setrange(Semester, gSem);
                        HousingApplication.setrange("Student No.", gStudentNo);
                        HousingApplication.setrange(Term, GTerm);
                        HousingApplication.SetRange(Posted, true);
                        if HousingApplication.FindFirst() then;
                        Page.Run(0, HousingApplication);
                    end;
                }
                field("Housing waiver Application Exist"; HousingwaiverApplicationExist)
                {
                    ApplicationArea = All;
                    Caption = 'Housing waiver Application Exist';
                    Editable = false;
                    Lookup = true;
                    trigger OnDrillDown()
                    var
                        OptOut: Record 50363;
                    //Tye :Page "Pending Housing Wavier List";
                    begin
                        OptOut.reset();
                        OptOut.setrange("Academic Year", gaY);
                        OptOut.setrange(Semester, gSem);
                        OptOut.setrange("Student No.", gStudentNo);
                        OptOut.setrange(Term, GTerm);
                        //OptOut.setrange(Status, OptOut.Status::Approved);
                        OptOut.SetRange("Application Type", OptOut."Application Type"::"Housing Wavier");
                        if OptOut.FindFirst() then;
                        Page.Run(50573, OptOut);
                    end;
                }
                field("Housing waiver Application Posted"; HousingwaiverApplication)
                {
                    ApplicationArea = All;
                    Caption = 'Housing waiver Application Posted';
                    Editable = false;
                    Lookup = true;
                    trigger OnDrillDown()
                    var
                        OptOut: Record 50363;
                    begin
                        OptOut.reset();
                        OptOut.setrange("Academic Year", gaY);
                        OptOut.setrange(Semester, gSem);
                        OptOut.setrange("Student No.", gStudentNo);
                        OptOut.setrange(Term, GTerm);
                        OptOut.setrange(Status, OptOut.Status::Approved);
                        OptOut.SetRange("Application Type", OptOut."Application Type"::"Housing Wavier");
                        if OptOut.FindFirst() then;
                        Page.Run(50571, OptOut);
                    end;
                }

            }
            group("Other Details")
            {

                field("Applied For Insurance"; Rec."Apply For Insurance")
                {
                    Editable = false;

                }

                field("Insurance Carrier"; Rec."Insurance Carrier")
                {
                    ApplicationArea = all;
                    Visible = Not ApplyForInsurance;
                    Editable = false;

                }
                field("Policy Number / Group Number"; Rec."Policy Number / Group Number")
                {
                    Caption = 'Policy No.';
                    ApplicationArea = all;
                    Visible = Not ApplyForInsurance;
                    Editable = false;

                }
                field("Insurance Valid From"; Rec."Insurance Valid From")
                {
                    ApplicationArea = all;
                    Visible = Not ApplyForInsurance;
                    Editable = false;

                }
                field("Insurance Valid To"; Rec."Insurance Valid To")
                {
                    ApplicationArea = all;
                    Visible = Not ApplyForInsurance;
                    Editable = false;

                }
                field("Transport Allot"; Rec."Transport Allot")
                {
                    Editable = false;

                }
                field("Payment Plan or Self Payment"; "Payment Plan OR Self Payment")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Plan or Self Payment';
                    Editable = false;

                }
            }

            part(Lines; BursarSignoffDetailsList)
            {
                ApplicationArea = all;
                Editable = false;
                SubPageLink = "Student No." = FIELD("No.");
                UpdatePropagation = Both;
            }


        }
        area(factboxes)
        {

            part("OLR Stages FactBox"; "OLR Stages FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Student No" = FIELD("No.");
            }
            part("Hold FactBox"; "Hold FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = FIELD("No.");
            }


        }
    }

    actions
    {
        area(Processing)
        {
            //360 start
            group("360 Degree View")
            {
                Image = ViewDetails;
                Caption = '360 Degree View';

                group(Admission)
                {
                    Visible = AdmissionGroup;
                    group("Pre -Admission Details")
                    {
                        action("Enrolment History List")
                        {
                            Caption = 'Enrolment History List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Enrollment History List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Student Buffer List")
                        {
                            Caption = 'Student List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Student Buffer Non API";
                            RunPageLink = "18 Digit ID" = FIELD("18 Digit ID"), Semester = Field(Semester), "Academic Year" = Field("Academic Year");
                        }

                        action("Transaction Sync Buffer List")
                        {
                            Caption = 'Transaction Sync List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Transactions Sync Buffer List";
                            RunPageLink = Account = FIELD("No."), "Void Entry" = filter(false);
                        }
                        action("Student Status Deferred/Declined Buffer List")
                        {
                            Caption = 'Student Status Deferred/Declined List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Deferred/Declined Buffer List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Student Educational Qualification Details")
                        {
                            Caption = 'Student Educational Qualification';
                            image = GanttChart;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                QualifyingDetailsRec: Record "Qualifying Detail Stud-CS";
                                QualifyingDetailsPag: Page "Qualifying Detail Stud List-CS";
                            begin
                                QualifyingDetailsRec.Reset();
                                QualifyingDetailsRec.Setrange("Student No.", Rec."No.");
                                if QualifyingDetailsRec.FindFirst() then begin
                                    Clear(QualifyingDetailsPag);
                                    QualifyingDetailsPag.SetTableView(QualifyingDetailsRec);
                                    if Rec."Entry From Salesforce" then begin
                                        QualifyingDetailsPag.Editable := false;
                                        QualifyingDetailsPag.Run();
                                    end else begin
                                        QualifyingDetailsPag.Editable := true;
                                        QualifyingDetailsPag.Run();
                                    end;
                                end;
                            end;
                        }


                    }
                    group("Admission Details")
                    {
                        action("Pending Housing Application")
                        {
                            Caption = 'Pending Housing Application';
                            image = Home;
                            ApplicationArea = All;
                            RunObject = Page "Housing Application List";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester);
                        }
                        action("Pending Housing Wavier Application Details")
                        {
                            Caption = 'Pending Housing Wavier Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Wavier PendingApproval";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Student Course Subject Buffer List")
                        {
                            Caption = 'Student Course Subject List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Course Subject Buffer List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Approved/Rejected Housing App")
                        {
                            Caption = 'Approved/Rejected Housing Application List';
                            image = List;
                            ApplicationArea = All;
                            RunObject = Page "Posted Housing Application";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);
                        }
                        action("Approved/Rejected Housing Waiver")
                        {
                            Caption = 'Approved/Rejected Housing Waiver List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Wavier Approved List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);

                        }
                    }

                }

                group("Registrar/Academics")
                {
                    Visible = RegistrarGroup;
                    group(OLR)
                    {
                        Caption = 'OLR';
                        action("Student Registration Details")
                        {
                            Caption = 'Student Registration Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Student Registration list";
                            RunPageLink = "Student No" = FIELD("No."), "Academic Year" = field("Academic Year"),
                                   Semester = field(Semester);
                        }
                        action("FERPA Details")
                        {
                            Caption = 'FERPA Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "FERPA Details List";
                            RunPageLink = "Student No." = FIELD("No."), "Academic Year" = field("Academic Year"),
                                   Semester = field(Semester);
                        }
                        action("Agreement List")
                        {
                            Caption = 'Agreement List';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                        }

                        action("Digital Signature List")
                        {
                            Caption = 'Digital Signature List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Digital Signature List";
                        }
                        action("Student Ethnicity List")
                        {
                            Caption = 'Student Ethnicity List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Student Ethnicity List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        Group("ID Card")
                        {
                            action("AICASA ID Card")
                            {
                                Caption = 'AICASA ID Card';
                                image = PostApplication;
                                ApplicationArea = Basic, Suite;

                                trigger OnAction()
                                var
                                    RecStudentMaster: Record "Student Master-CS";
                                begin
                                    RecStudentMaster.Reset();
                                    RecStudentMaster.SetRange("No.", REC."No.");
                                    IF RecStudentMaster.FindFirst() then begin
                                        Report.Run(Report::"AICASA IDCard", true, false, RecStudentMaster);
                                    end;

                                end;
                            }
                            action("AUA Basic Science ID Card")
                            {
                                Caption = 'AUA Basic Science ID Card';
                                image = PostApplication;
                                ApplicationArea = Basic, Suite;
                                trigger OnAction()
                                var
                                    RecStudentMaster: Record "Student Master-CS";
                                begin
                                    RecStudentMaster.Reset();
                                    RecStudentMaster.SetRange("No.", REC."No.");
                                    IF RecStudentMaster.FindFirst() then begin
                                        Report.Run(Report::"AUA Basic Science IDCard", true, false, RecStudentMaster);
                                    end;

                                end;
                            }
                            action("AUA 5th Semester ID Card")
                            {
                                Caption = 'AUA 5th Semester ID Card';
                                image = PostApplication;
                                ApplicationArea = Basic, Suite;
                                trigger OnAction()
                                var
                                    RecStudentMaster: Record "Student Master-CS";
                                begin
                                    RecStudentMaster.Reset();
                                    RecStudentMaster.SetRange("No.", REC."No.");
                                    IF RecStudentMaster.FindFirst() then begin
                                        Report.Run(Report::"AUA 5th Semester IDCard", true, false, RecStudentMaster);
                                    end;

                                end;
                            }
                        }
                        action("Generate QRCode")
                        {
                            Image = BarCode;
                            ApplicationArea = All;
                            trigger OnAction()
                            begin
                                IF Confirm('Do you want to generate QR Code ?', false) then begin
                                    //GenerateBarCode();//GMCSCOM
                                end;

                            end;
                        }
                    }
                    Group("Pending Applications")
                    {
                        action("Pending Housing Applications")
                        {
                            Caption = 'Pending Housing Application';
                            image = Home;

                            ApplicationArea = All;
                            RunObject = Page "Housing Application List";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester);
                        }

                        action("Pending Housing Wavier Application")
                        {
                            Caption = 'Pending Housing Wavier Application';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Wavier PendingApproval";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Pending Withdrawal Application")
                        {
                            Caption = 'Pending Withdrawal Application';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Withdrawal Approvals";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Pending Leave Application")
                        {
                            Caption = 'Pending Leave Application';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Leaves Approvals";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Pending Re-registration Application")
                        {
                            Caption = 'Pending Re-registration Application';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Re-Registration List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                    }
                    Group("Posted Applications")
                    {
                        action("Post Housing Application")
                        {
                            Caption = 'Posted Housing Application';
                            image = PostApplication;

                            ApplicationArea = All;
                            RunObject = Page "Posted Housing Application";
                            RunPageLink = "Student No." = FIELD("No."),
                                          Semester = field(Semester);
                        }
                        action("Posted Housing Waiver Application")
                        {
                            Caption = 'Posted Housing Waiver Application';
                            image = PostApplication;

                            ApplicationArea = All;
                            RunObject = Page "Housing Wavier Approved List";
                            RunPageLink = "Student No." = FIELD("No."),
                                          Semester = field(Semester);
                        }
                        action("Posted Withdrawal Application")
                        {
                            Caption = 'Posted Withdrawal Application';
                            image = PostApplication;

                            ApplicationArea = All;
                            RunObject = Page "Withdrawal Approval Status";
                            RunPageLink = "Student No." = FIELD("No."),
                                          Semester = field(Semester);
                        }
                        action("Posted Re-registration Application")
                        {
                            Caption = 'Posted Re-registration Application';
                            image = PostApplication;

                            ApplicationArea = All;
                            RunObject = Page "Approve Reject Re-Registration";
                            RunPageLink = "Student No." = FIELD("No."),
                                          Semester = field(Semester);
                        }
                    }
                    group("Registrar_1")
                    {
                        Caption = 'Registrar';
                        action("Student Group Code")
                        {
                            Caption = 'Student Group';
                            Image = EntriesList;
                            ApplicationArea = All;

                            RunObject = Page "Student Group";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester), "Academic Year" = Field("Academic Year"),
                                           "Global Dimension 1 Code" = field("Global Dimension 1 Code");

                        }

                        action("Student Group Ledger")
                        {
                            Caption = 'Student Group Ledger';
                            Image = EntriesList;
                            ApplicationArea = All;

                            RunObject = Page "Student Group Ledger";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Change Status")
                        {
                            Image = ChangeStatus;
                            ApplicationArea = All;

                            trigger OnAction()
                            var
                                UserSetup: Record "User Setup";
                                StudentMaster: Record "Student Master-CS";
                                StudentStatus: Page "Student Status Change Manually";
                                usersetupapprover: Record "Document Approver Users";
                            begin
                                usersetupapprover.Reset();
                                usersetupapprover.SetRange("User ID", UserId());
                                usersetupapprover.SetRange("Department Approver Type", usersetupapprover."Department Approver Type"::"Registrar Department");
                                if not usersetupapprover.FindFirst() then
                                    Error('You are not authorized. This functionality can be handled by "Registrar Department"');

                                // UserSetup.get(Userid());
                                // if UserSetup."Department Approver" <> Usersetup."Department Approver"::"Registrar Department" then
                                //     Error('You are not authorized. This functionality can be handled by "Registrar Department"');
                                StudentMaster.Reset();
                                StudentMaster.SetRange("No.", REC."No.");
                                If StudentMaster.FindFirst() then begin
                                    StudentStatus.SetTableView(StudentMaster);
                                    StudentStatus.Run();
                                end;
                            end;
                        }
                        action("Student Residency Detail")
                        {
                            Caption = 'Student Residency Detail';
                            Image = EntriesList;
                            ApplicationArea = All;

                            trigger OnAction()
                            var
                                StudentMaster: Record "Student Master-CS";
                                ResidencyDetails: Page "Residency Details";
                            begin
                                StudentMaster.Reset();
                                StudentMaster.SetRange("No.", REC."No.");
                                If StudentMaster.FindFirst() then begin
                                    ResidencyDetails.SetTableView(StudentMaster);
                                    ResidencyDetails.Run();
                                end;
                            end;
                        }
                        action("Student Immigration List")
                        {
                            Caption = 'Student Immigration List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                ImmigrationHeader: Record "Immigration Header";
                                ImmigrationList: Page "Immigration list";
                            begin
                                ImmigrationHeader.Reset();
                                ImmigrationHeader.SetRange("Student No", Rec."No.");
                                ImmigrationHeader.SetRange(Semester, Rec.Semester);
                                Clear(ImmigrationList);
                                ImmigrationList.SetTableView(ImmigrationHeader);
                                ImmigrationList.Editable := false;
                                ImmigrationList.Run();
                            end;

                        }
                        action("Student Wise Hold")
                        {
                            Caption = 'Student Wise H&old';
                            ApplicationArea = All;
                            Image = Ledger;
                            RunObject = Page "Student Wise Hold List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                            RunPageView = SORTING("Student No.");
                            ShortCutKey = 'Ctrl+F8';
                        }
                        action("Page Cust Ledger Entries")
                        {
                            ApplicationArea = All;
                            Caption = 'Ledger E&ntries';
                            Image = CustomerLedger;
                            RunObject = Page "Customer Ledger Entries";
                            RunPageLink = "Customer No." = FIELD("Original Student No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                            RunPageView = SORTING("Customer No.");
                            ShortCutKey = 'Ctrl+F7';
                        }
                        action("Faculty Feedback Results")
                        {
                            Caption = 'Faculty Feedback Results';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Feedback Detail-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Student timeline")
                        {
                            Caption = 'Student timeline';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Student Time Line";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Status Change Log Entries")
                        {
                            Caption = 'Status Change Log Entries';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Status Change Log Entries";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Transfer Credit Details")
                        {
                            Caption = 'Transfer Credit Details';
                            image = GanttChart;
                            ApplicationArea = All;
                            RunObject = Page "Student Branch Tranfr Dtl-CS";
                            RunPageLink = "No." = FIELD("No."), Semester = Field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Course Degree List")
                        {
                            ApplicationArea = All;
                            Caption = 'Course Degree List';
                            Image = EntriesList;
                            trigger OnAction()
                            var
                                TempCourseDegreeList: Page "Temp Course Degree List";
                            begin
                                TempCourseDegreeList.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                TempCourseDegreeList.RunModal();
                            end;
                        }
                        action("Student Honors1")
                        {
                            ApplicationArea = All;
                            Caption = 'Student Honors';
                            Image = EntriesList;
                            RunObject = Page "Student Honors";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                    }
                    group("Academics_1")
                    {
                        Caption = 'Academics';
                        action("Student Attendance Detail")
                        {
                            Caption = 'Student Attendance Details';
                            Image = EntriesList;
                            ApplicationArea = All;

                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester);

                        }
                        action("&Student Subject")
                        {
                            Caption = '&Student Subject';
                            image = GanttChart;
                            ApplicationArea = All;

                            RunObject = Page 50001;
                            RunPageLink = "Student No." = FIELD("No."),
                                  "Course" = FIELD("Course Code");


                        }
                        action("Student Subject Exams")
                        {
                            Caption = 'Student Subject Exams';
                            Image = List;
                            ApplicationArea = All;
                            RunObject = Page "Student Subject Exam List";
                            RunPageLink = "Student No." = FIELD("No."),
                                  "Course" = FIELD("Course Code");
                        }


                        action("Student Assessment List")
                        {
                            Caption = 'Student Assignment List';
                            Image = GanttChart;
                            RunObject = Page 50039;
                            ApplicationArea = All;

                            RunPageLink = "Student No." = FIELD("No."),
                                  "Semester" = FIELD("Semester");
                        }
                        action("Semester GPA Detail")
                        {
                            ApplicationArea = All;
                            Caption = 'Semester GPA Details';
                            Image = EntriesList;

                            trigger OnAction()
                            var
                                SemesterGPATemp: Page "Semester GPA";
                            begin
                                SemesterGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                SemesterGPATemp.RunModal();
                            end;
                        }
                        action("Year GPA Detail")
                        {
                            Caption = 'Year GPA Detail';
                            Image = EntriesList;
                            ApplicationArea = All;

                            trigger OnAction()
                            var
                                YearGPATemp: Page "Year GPA";
                            begin
                                YearGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                YearGPATemp.RunModal();
                            end;
                        }
                        action("Status History")
                        {
                            Caption = 'Status History';
                            Image = EntriesList;
                            ApplicationArea = All;

                        }

                        action("Student Promotion List4")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }

                    }

                    group("Coordinators")
                    {
                        action("Student Basic Science Coordinator")
                        {
                            Caption = 'Student Basic Science Cordinator';
                            image = GanttChart;
                            ApplicationArea = All;
                            RunObject = Page "Student Clinical Details";
                            RunPageLink = "No." = FIELD("No.");

                        }
                        action("Student Clinical Coordinator")
                        {
                            Image = EntriesList;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentMaster: Record "Student Master-CS";
                                StudentClinical: Page "Student Clinical Details";

                            begin
                                StudentMaster.Reset();
                                StudentMaster.SetRange("No.", REC."No.");
                                If StudentMaster.FindFirst() then begin
                                    StudentClinical.SetTableView(StudentMaster);
                                    StudentClinical.Run();
                                end;
                            end;
                        }
                        action("Student EED Advisor")
                        {
                            Caption = 'Student EED Advisor';
                            image = GanttChart;
                            ApplicationArea = All;

                        }
                        action("Student Faculty Coordinator")
                        {
                            Caption = 'Student Faculty Coordinator';
                            image = GanttChart;

                            ApplicationArea = All;
                            RunObject = Page "Student Clinical Details";
                            RunPageLink = "No." = FIELD("No.");

                        }
                        action("FM1/IM1 Coordinator1")
                        {
                            Caption = 'FM1/IM1 Coordinator';
                            Image = EntriesList;
                            ApplicationArea = All;

                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                        }

                    }
                    group("Clinical ")
                    {
                        Visible = Bool;

                        action("Core Rotations")
                        {
                            Caption = 'Core Rotations';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Core);

                        }
                        action("Elective Rotations")
                        {
                            Caption = 'Elective Rotations';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                        }

                        action("FM1/IM1 Rotation")
                        {
                            Caption = 'FM1/IM1 Rotation';
                            Image = EntriesList;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category6;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                        }

                    }
                    group("Pre-Admission Details")
                    {
                        action("Enrolment History List1")
                        {
                            Caption = 'Enrolment History List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                EnrollmentHistoryRec: Record "Enrollment History";
                                EnrollmentHistoryPag: Page "Enrollment History List";
                            begin
                                EnrollmentHistoryRec.Reset();
                                EnrollmentHistoryRec.Setrange("Student No.", Rec."No.");
                                Clear(EnrollmentHistoryPag);
                                EnrollmentHistoryPag.SetTableView(EnrollmentHistoryRec);
                                if Rec."Entry From Salesforce" then begin
                                    EnrollmentHistoryPag.Editable := false;
                                    EnrollmentHistoryPag.Run();
                                end else begin
                                    EnrollmentHistoryPag.Editable := true;
                                    EnrollmentHistoryPag.Run();
                                end;
                            end;
                        }
                        action("Student Buffer List1")
                        {
                            Caption = 'Student List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Student Buffer Non API";
                            RunPageLink = "18 Digit ID" = FIELD("18 Digit ID"), Semester = Field(Semester), "Academic Year" = Field("Academic Year");
                        }

                        action("Transaction Sync Buffer List1")
                        {
                            Caption = 'Transaction Sync List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Transactions Sync Buffer List";
                            RunPageLink = Account = FIELD("No.");
                        }
                        action("Student Status Deferred/Declined Buffer List1")
                        {
                            Caption = 'Student Status Deferred/Declined List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Deferred/Declined Buffer List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Student Educational Qualification Details1")
                        {
                            Caption = 'Student Educational Qualification';
                            image = GanttChart;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                QualifyingDetailsRec: Record "Qualifying Detail Stud-CS";
                                QualifyingDetailsPag: Page "Qualifying Detail Stud List-CS";
                            begin
                                QualifyingDetailsRec.Reset();
                                QualifyingDetailsRec.Setrange("Student No.", Rec."No.");
                                Clear(QualifyingDetailsPag);
                                QualifyingDetailsPag.SetTableView(QualifyingDetailsRec);
                                if Rec."Entry From Salesforce" then begin
                                    QualifyingDetailsPag.Editable := false;
                                    QualifyingDetailsPag.Run();
                                end else begin
                                    QualifyingDetailsPag.Editable := true;
                                    QualifyingDetailsPag.Run();
                                end;
                            end;
                        }

                    }
                    group("Legacy Data1")
                    {
                        Caption = 'Legacy Data';
                        action("Inter Log Entry")
                        {
                            Caption = 'Inter Log Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }
                }

                group("Clinical Details")
                {
                    Visible = ClinicalDetailsGroup;

                    action("Stud Attendance Details")
                    {
                        Caption = 'Student Attendance Detail';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Attendance Student Line-CS";
                        RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester);

                    }
                    action("Semester GPA Details")
                    {
                        ApplicationArea = All;
                        Caption = 'Semester GPA Details';
                        Image = EntriesList;
                        trigger OnAction()
                        var
                            SemesterGPATemp: Page "Semester GPA";
                        begin
                            SemesterGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                            SemesterGPATemp.RunModal();
                        end;
                    }
                    action("Year GPA Details")
                    {
                        Caption = 'Year GPA Detail';
                        Image = EntriesList;
                        ApplicationArea = All;
                        trigger OnAction()
                        var
                            YearGPATemp: Page "Year GPA";
                        begin
                            YearGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                            YearGPATemp.RunModal();
                        end;
                    }

                    action("Student Promotion List")
                    {
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code");
                    }
                    group(Rotations)
                    {
                        action("Core Rotations ")
                        {
                            Caption = 'Core Rotations';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // Promoted = true;
                            // PromotedCategory = Category6;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Core);

                        }
                        action("Elective Rotations ")
                        {
                            Caption = 'Elective Rotations';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // Promoted = true;
                            // PromotedCategory = Category6;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                        }
                        action("Elective Rotations Application")
                        {
                            Caption = 'Elective Rotations Application';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // Promoted = true;
                            // PromotedCategory = Category6;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                        }
                        action("FM1/IM1 Rotation Application")
                        {
                            Caption = 'FM1/IM1 Rotation Application';
                            Image = EntriesList;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category6;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                        }
                        action("FM1/IM1 Rotation ")
                        {
                            Caption = 'FM1/IM1 Rotation';
                            Image = EntriesList;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category6;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                        }
                    }
                    group("Coordinators ")
                    {

                        action("Student Clinical Coordinator Details")
                        {
                            Image = EntriesList;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category6;
                            trigger OnAction()
                            var
                                StudentMaster: Record "Student Master-CS";
                                StudentClinical: Page "Student Clinical Details";

                            begin
                                StudentMaster.Reset();
                                StudentMaster.SetRange("No.", REC."No.");
                                If StudentMaster.FindFirst() then begin
                                    StudentClinical.SetTableView(StudentMaster);
                                    StudentClinical.Run();
                                end;
                            end;
                        }

                        action("FM1/IM1 Coordinator ")
                        {
                            Caption = 'FM1/IM1 Coordinator';
                            Image = EntriesList;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category6;
                            RunObject = Page "Roster Scheduling Subpage";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                        }
                    }
                    group("Legacy Data4")
                    {
                        Caption = 'Legacy Data';
                        action("Roster Ledger Entry")
                        {
                            Caption = 'Roster Ledger Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Roster Ledger Entries";
                            RunPageLink = "Student ID" = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }
                    group(Clerkship)
                    {
                        action("Clerkship Preferred Site and Date Selection")
                        {
                            Caption = 'Clerkship Preferred Site and Date Selection';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "STDClkshpSite_DateSelectionLST";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                        action("Clerkship Preferred Site And Date Approved/Rejected List")
                        {
                            Caption = 'Clerkship Preferred Site And Date Approved/Rejected List';
                            image = List;
                            ApplicationArea = All;
                            RunObject = page "UNVClkshpSite_DateLST+";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                        action("Clerkship Preferred Site And Date Approved List")
                        {
                            Caption = 'Clerkship Preferred Site And Date Approved List';
                            image = List;
                            ApplicationArea = All;
                            RunObject = page "UNVClkshpSite_DateApprovalLST";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }


                }

                group(Housing)
                {
                    Visible = HousingGroup;
                    action("Housing Sign Off")
                    {
                        Caption = 'Housing SignImmigrat Off';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;

                    }
                    action("Immigration Document List")
                    {
                        Caption = 'Immigration Document List';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Immigration Document List";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);
                        RunPageView = SORTING("Student No.");

                    }
                    action("Student Wise Hold1")
                    {
                        Caption = 'Student Wise H&old';
                        ApplicationArea = All;
                        Image = Ledger;

                        RunObject = Page "Student Wise Hold List";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);
                        RunPageView = SORTING("Student No.");
                        ShortCutKey = 'Ctrl+F8';

                    }

                    action("Housing Ledger")
                    {
                        Caption = 'Housing Ledger';
                        image = LedgerBook;
                        ApplicationArea = Basic, Suite;
                        //Promoted = true;
                        //PromotedCategory = Category8;
                        RunObject = Page "Housing Ledger";
                        RunPageLink = "Student No." = FIELD("No.");

                    }
                    group("Pending Applications ")
                    {
                        action("Pending Housing Wavier Application List1")
                        {
                            Caption = 'Pending Housing Wavier Application List';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Wavier PendingApproval";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Pending Housing Applications List")
                        {
                            Caption = 'Pending Housing Applications List';
                            image = Home;

                            ApplicationArea = All;
                            RunObject = Page "Housing Application List";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester);
                        }


                        action("Pending Housing Change List")
                        {
                            Caption = 'Pending Housing Change List';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Change Request List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Pending Housing Vacate List")
                        {
                            Caption = 'Pending Housing Vacate List';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Vacate Request List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Pending Housing Re-registration List")
                        {
                            Caption = 'Pending Housing Re-registration List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Re-Registration List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Pending Housing Issue List")
                        {
                            Caption = 'Housing Issue Pending List';
                            image = LedgerBook;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Issue Pending List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Pending Immigration List")
                        {
                            Caption = 'Pending Immigration List';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Immigration list";
                            RunPageLink = "Student No" = FIELD("No."), "Academic Year" = field("Academic Year"),
                                   Semester = field(Semester);
                        }
                        action("Pending Housing Financial Accountability List")
                        {
                            Caption = 'Pending Housing Financial Accountability List';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Fin Account List";
                            RunPageLink = "Student No." = FIELD("No."), "Academic Year" = field("Academic Year"),
                                   Semester = field(Semester);
                        }
                        action("Pending Parking Sticker Assignment List")
                        {
                            Caption = 'Pending Parking Sticker Assignment List';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Parking Details List";
                            RunPageLink = "Student No." = FIELD("No."), "Academic Year" = field("Academic Year"),
                                   Semester = field(Semester);
                        }
                    }
                    group("Posted Applications ")
                    {
                        action("Approved/Rejected Housing Application")
                        {
                            Caption = 'Approved/Rejected Housing Application';
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "Posted Housing Application";
                            RunPageLink = "Student No." = FIELD("No."),
                                          Semester = field(Semester);

                        }
                        action("Approved/Rejected Housing Waiver List")
                        {
                            Caption = 'Approved/Rejected Housing Waiver List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Wavier Approved List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Approved/Rejected Change Request")
                        {
                            Caption = 'Approved/Rejected Change Request';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve Reject Housing Change";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Approved/Rejected Vacate Request")
                        {
                            Caption = 'Approved/Rejected Vacate Request';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve Reject Housing Vacate";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Approved/Rejected Re-registration Request")
                        {
                            Caption = 'Approved/Rejected Re-registration Request';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve Reject Re-Registration";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Approved/Rejected Immigration List")
                        {
                            Caption = 'Approved/Rejected Immigration List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Immigration Approved list";
                            RunPageLink = "Student No" = FIELD("No."), "Academic Year" = field("Academic Year"),
                                   Semester = field(Semester);

                        }
                        action("Assigned Parking Sticker List")
                        {
                            Caption = 'Assigned Parking Sticker List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Parking Assigned List";
                            RunPageLink = "Student No." = FIELD("No."), "Academic Year" = field("Academic Year"),
                                   Semester = field(Semester);

                        }
                        action("Approved/Rejected Financial Accountability")
                        {
                            Caption = 'Approved/Rejected Financial Accountability';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve/Reject Fin Account";
                            RunPageLink = "Student No." = FIELD("No."), "Academic Year" = field("Academic Year"),
                                   Semester = field(Semester);

                        }
                        action("Rejected Housing Issue list")
                        {
                            Caption = 'Rejected Housing Issue list';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Closed Housing Issue List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Resolved Housing Issue list")
                        {
                            Caption = 'Resolved Housing Issue list';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Housing Issue Accepted List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                    }

                }
                group("Bursar")
                {
                    Visible = BursarGroup;
                    action("Bursar Signoff Details")
                    {
                        Caption = '&Bursar Signoff Details';
                        Image = ViewDetails;
                        ApplicationArea = All;
                        trigger OnAction()
                        Var
                            BursarSingoffDetails: Page "Bursar Signoff Details";
                        begin
                            BursarSingoffDetails.SetParameter(Rec.Term, Rec.Semester, Rec."Academic Year", Rec."No.");
                            BursarSingoffDetails.Run();
                        end;

                    }
                    action("Customer Card")
                    {
                        Caption = 'Customer Card';
                        image = PostApplication;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Customer Card";
                        RunPageLink = "No." = FIELD("Original Student No.");

                    }
                    action("Ledger Entries")
                    {
                        Caption = 'Ledger Entries';
                        image = PostApplication;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Customer Ledger Entries";
                        RunPageLink = "Customer No." = FIELD("Original Student No."),
                                        "Enrollment No." = field("Enrollment No."),
                                      "Semester" = FIELD("Semester");
                        RunPageView = SORTING("Customer No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Student Legacy Ledger ")
                    {
                        Caption = 'Student Legacy Ledger';
                        Image = Ledger;
                        ApplicationArea = All;
                        //Promoted = true;
                        //PromotedCategory = Category8;
                        RunObject = Page "SFAS Detail-CS";
                        RunPageLink = "Roll No." = FIELD("Enrollment No.");
                    }
                    action("Student Housing Ledger")
                    {
                        Caption = 'Student Housing Ledger';
                        image = PostApplication;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Housing Ledger";
                        RunPageLink = "Student No." = FIELD("No.");

                    }
                    action("OLR Stages")
                    {
                        Caption = 'OLR Stages';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Student Registration list";
                        RunPageLink = "Student No" = FIELD("No.");

                    }
                    group(" Pending Applications")
                    {
                        action("Pending Financial Aid Application")
                        {
                            Caption = 'Pending Financial Aid Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Financial AID Pending List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Pending Financial Aid Roster")
                        {
                            Caption = 'Pending Financial Aid Roster';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Financial Aid Roster";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Pending Payment Option Status")
                        {
                            Caption = 'Pending Payment Option Status';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Payment Plan List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Pending Withdrawal Approval List")
                        {
                            Caption = 'Pending Withdrawal Approval List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Withdrawal Approvals";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Pending Financial Accountability List")
                        {
                            Caption = 'Pending Financial Accountability List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Pending Financial Account";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Pending Wire Transfer List")
                        {
                            RunObject = Page "Details List-RTGS-CS";
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                        }

                    }
                    group(" Posted Applications ")
                    {
                        action("Posted Financial Aid Details")
                        {
                            Caption = 'Posted Financial Aid Details';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "FinancialAIDApprovRejectList";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Financial Aid Roster Approved/Rejected List")
                        {
                            Caption = 'Financial Aid Roster Approved/Rejected List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "FAid Roster Approved/Rejected";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Payment Option Approved/Rejected List")
                        {
                            Caption = 'Payment Option Approved/Rejected List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Payment Plan Approved/Rejected";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Posted Housing Application")
                        {
                            Caption = 'Posted Housing Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Posted Housing Application";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Approved Withdrawal Application Form")
                        {
                            Caption = 'Approved Withdrawal Application Form';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Approved Course Withdrawal";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Posted Housing Waiver Application ")
                        {
                            Caption = 'Posted Housing Waiver Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Housing Wavier Approved List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Approved Financial Accountability List")
                        {
                            Caption = 'Approved Financial Accountability List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve/Reject Fin Account";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Student Holds")
                        {
                            Caption = 'Student Holds';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Student Wise Hold List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Approved/Rejected Wire Transfer List")
                        {
                            RunObject = Page "Approved Rejected RTGS List";
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                        }

                    }

                    group("Discounts")
                    {
                        action("Scholarship Details")
                        {
                            Caption = 'Scholarship Details';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Scholar. Source L-CS";
                            //RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Grant Details")
                        {
                            Caption = 'Grant Details';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Scholar. Source L-CS";
                            // RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Waiver Details")
                        {
                            Caption = 'Waiver Details';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Scholar. Source L-CS";
                            //RunPageLink = "Student No." = FIELD("No.");

                        }

                    }
                    group("Reports")
                    {
                        action("Student Fee Component Details")
                        {
                            Caption = 'Student Fee Component Details';
                            image = GanttChart;
                            //Promoted = true;
                            //PromotedCategory = Category8;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentFeeComp: Report "Finance Fee";
                            begin
                                StudentFeeComp.VariablePassing(Rec."Global Dimension 1 Code", Rec."Academic Year", Rec.Semester, Rec."Enrollment No.");
                                StudentFeeComp.Run();
                            end;
                        }
                        action("Semester Fee Calculation")
                        {
                            Caption = 'Semester Fee Calculation';
                            Image = Calculate;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category8;
                            trigger OnAction()
                            var
                                StudentFeeDetailTemp: Page "Student Fee Details";
                            begin
                                StudentFeeDetailTemp.VariablePassing(Rec."No.");
                                StudentFeeDetailTemp.RunModal();
                            end;
                        }
                    }
                }
                group("Financial Aid")
                {
                    Visible = FinancialAid1;
                    action("Financial Aid Sign off")
                    {
                        Caption = '&Financial Aid Sign Off';
                        Image = SignUp;
                        ApplicationArea = All;
                        //Promoted = true;
                        //PromotedCategory = Category9;
                        trigger OnAction()
                        begin
                            // 12-12-20  //     FinancialAidSignoff("No.", false);
                        end;
                    }
                    group("Academics")
                    {

                        action("Semester GPA Details_")
                        {
                            Caption = 'Semester GPA Details';
                            Image = Calculate;
                            ApplicationArea = All;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                SemesterGPATemp: Page "Semester GPA";
                            begin
                                SemesterGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                SemesterGPATemp.RunModal();
                            end;
                        }
                        action("Year GPA Details_")
                        {
                            Caption = 'Year GPA Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                YearGPATemp: Page "Year GPA";
                            begin
                                YearGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                YearGPATemp.RunModal();
                            end;
                        }
                        action("Stud Attendance Detail")
                        {
                            Caption = 'Student Attendance Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester);

                        }
                        action("Stud Promotion List")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code");
                        }
                    }
                    group("Pending Application")
                    {
                        action("Pending Financial Aid Details")
                        {
                            Caption = 'Pending Financial Aid Details';
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "Financial AID Pending List";
                            RunPageLink = "Student No." = FIELD("No.");


                        }
                        action("Pending Semester Warning Application")
                        {
                            Caption = 'Pending Semester Warning Application';
                            image = PostApplication;
                            ApplicationArea = All;


                        }
                        action("Pending Appeal Application")
                        {
                            Caption = 'Pending Appeal Application';
                            image = PostApplication;
                            ApplicationArea = All;


                        }

                    }
                    group("Posted Application")
                    {
                        action("Posted Financial Aid Details_")
                        {
                            Caption = 'Posted Financial Aid Details';
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "FinancialAIDApprovRejectList";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Posted Semester Warning Application")
                        {
                            Caption = 'Posted Semester Warning Application';
                            image = PostApplication;
                            ApplicationArea = All;


                        }
                        action("Posted Appeal Application")
                        {
                            Caption = 'Posted Appeal Application';
                            image = PostApplication;
                            ApplicationArea = All;


                        }
                    }
                    group("Legacy Data")
                    {
                        action("FA Refund Master")
                        {
                            Caption = 'FA Refund Master';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "FA Refund Master";
                            RunPageLink = "Student No." = FIELD("No."), AdEnrollID = field("Enrollment No.");

                        }
                        action("Inter Log Entry1")
                        {
                            Caption = 'Inter Log Entry';
                            image = Entries;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }

                }
                group("EED Pre-Clinical")
                {
                    Visible = EEDBasicSciGroup;
                    action("Student EED Pre- Clinical Advisor")
                    {
                        Caption = 'Student EED Pre- Clinical Advisor';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    action("Pending Appointment List_")
                    {
                        Caption = 'Pending Appointment List';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    action("Meeting Updates_")
                    {
                        Caption = 'Meeting Updates';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    action("Medical Scholar Program Application")
                    {
                        Caption = 'Medical Scholar Program Application';
                        image = PostApplication;
                        ApplicationArea = All;

                    }

                    group("Academics ")
                    {
                        action("Sem GPA Details")
                        {
                            Caption = 'Semester GPA Details';
                            Image = Calculate;
                            ApplicationArea = All;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                SemesterGPATemp: Page "Semester GPA";
                            begin
                                SemesterGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                SemesterGPATemp.RunModal();
                            end;
                        }
                        action("Year GPA Detail-")
                        {
                            Caption = 'Year GPA Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                YearGPATemp: Page "Year GPA";
                            begin
                                YearGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                YearGPATemp.RunModal();
                            end;
                        }
                        action("Stud Attendance Details_")
                        {
                            Caption = 'Student Attendance Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester);

                        }
                        action("Stud Promotion List_")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code");
                        }
                    }
                    group("Legacy Data3")
                    {
                        Caption = 'Legacy Data';
                        action("Inter Log Entry3")
                        {
                            Caption = 'Inter Log Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }

                }
                group("EED Clinical")
                {
                    Visible = EEDClinicalGroup;
                    action("Student Clinical Advisor")
                    {
                        Caption = 'Student Clinical Advisor';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    action("Pending Appointment List")
                    {
                        Caption = 'Pending Appointment List';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    action("Meeting Updates")
                    {
                        Caption = 'Meeting Updates';
                        image = PostApplication;
                        ApplicationArea = All;


                    }

                    group(" Academics")
                    {
                        action("Sem GPA Details_")
                        {
                            Caption = 'Semester GPA Details';
                            Image = Calculate;
                            ApplicationArea = All;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                SemesterGPATemp: Page "Semester GPA";
                            begin
                                SemesterGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                SemesterGPATemp.RunModal();
                            end;
                        }
                        action("Year GPA Detail_")
                        {
                            Caption = 'Year GPA Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                YearGPATemp: Page "Year GPA";
                            begin
                                YearGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                YearGPATemp.RunModal();
                            end;
                        }
                        action("Studend Attendance Details_")
                        {
                            Caption = 'Student Attendance Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester);

                        }
                        action("Student Promotion List_")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code");
                        }
                    }
                    group("Legacy Data2")
                    {
                        Caption = 'Legacy Data';
                        action("Inter Log Entry2")
                        {
                            Caption = 'Inter Log Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }


                }
                group("Graduate Affairs")
                {
                    Visible = GraduateAffairsGroup;
                    action("Student Residency Details")
                    {
                        Caption = 'Student Residency Details';
                        image = PostApplication;
                        ApplicationArea = All;
                    }
                    action("Pending MSPE Application")
                    {
                        Caption = 'Pending MSPE Application';
                        image = PostApplication;
                        ApplicationArea = All;
                    }
                    action("Match List")
                    {
                        Caption = 'Match List';
                        image = PostApplication;
                        ApplicationArea = All;
                    }
                    action("Licence Details")
                    {
                        Caption = 'Licence Details';
                        Image = Calculate;
                        ApplicationArea = All;

                    }
                    action("Student Promotion List-2")
                    {
                        Caption = 'Student Promotion List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code");
                    }
                    action("Core Rotation")
                    {
                        Caption = 'Core Rotation';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Roster Scheduling Subpage";
                        RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Core);
                    }
                    action("Elective Rotation")
                    {
                        Caption = 'Elective Rotation';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Roster Scheduling Subpage";
                        RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester),
                                  "Clerkship Type" = filter(Elective);

                    }
                }

                group("Examination")
                {
                    Visible = ExaminationGroup;
                    action("Student Promotion List2")
                    {
                        Caption = 'Student Promotion List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code");
                    }
                    action("Student Grade Details")
                    {
                        Caption = 'Student Grade Details';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    action("Internal Exam Schedule")
                    {
                        Caption = 'Internal Exam Schedule';
                        image = PostApplication;
                        ApplicationArea = All;

                    }

                    action("Internal Exam Scores")
                    {
                        Caption = 'Internal Exam Scores';
                        Image = Calculate;
                        ApplicationArea = All;

                    }
                    action("Pending Make-up Application")
                    {
                        Caption = 'Pending Make-up Application';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "MakeUp Pending Approval";
                        RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester);

                    }
                    action("Posted Make-up Application")
                    {
                        Caption = 'Posted Make-up Application';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "MakeUp Approved List";
                        RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester);


                    }
                    action("External Exam Schedule")
                    {
                        Caption = 'External Exam Schedule';
                        Image = EntriesList;
                        ApplicationArea = All;


                    }
                    action("External Exam Scores")
                    {
                        Caption = 'External Exam Scores';
                        Image = EntriesList;
                        ApplicationArea = All;


                    }
                    action("Student Attendance")
                    {
                        Caption = 'Student Attendance Details';
                        Image = EntriesList;
                        ApplicationArea = All;

                        RunObject = Page "Attendance Student Line-CS";
                        RunPageLink = "Student No." = FIELD("No."),
                                  Semester = FIELD(Semester);

                    }
                    action("Admit Card")
                    {
                        Caption = 'Admit Card';
                        Image = EntriesList;
                        ApplicationArea = All;


                    }
                    action("Final Exam Scores")
                    {
                        Caption = 'Final Exam Scores';
                        Image = EntriesList;
                        ApplicationArea = All;


                    }

                }
                group("Graduation ")
                {
                    Visible = GraduationGroup;

                    action("Application for Transcript/Certificate")
                    {
                        Caption = 'Application for Transcript/Certificate';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    action("Degree Audit Document List")
                    {
                        Caption = 'Degree Audit Document List';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    action("Student Promotion List-")
                    {
                        Caption = 'Student Promotion List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code");
                    }

                    group("Graduation Degree")
                    {


                        action("BHHS Certification")
                        {
                            Caption = 'BHHS Certification';
                            Image = Calculate;
                            ApplicationArea = All;
                            RunObject = Report "AUA BHHS Certificate";
                        }
                        action("ASHS Degree")
                        {
                            Caption = 'ASHS Degree';
                            Image = EntriesList;
                            ApplicationArea = All;


                        }
                        action("AICASA EMTC Basic and Advance Certificates")
                        {
                            Caption = 'AICASA EMTC Basic and Advance Certificates';
                            Image = EntriesList;
                            ApplicationArea = All;

                        }
                        action("Transcripts-Official  AICASA PPP Program")
                        {
                            Caption = 'Transcripts-Official  AICASA PPP Program';
                            Image = EntriesList;
                            ApplicationArea = All;


                        }
                        action("MD Certificate")
                        {
                            Caption = 'MD Certificate';
                            Image = EntriesList;
                            ApplicationArea = All;


                        }
                        action("AICASA Transcript")
                        {
                            Caption = 'AICASA Transcript';
                            Image = EntriesList;
                            ApplicationArea = All;



                        }
                        action("AUA Transcript")
                        {
                            Caption = 'AUA Transcript';
                            Image = EntriesList;
                            ApplicationArea = All;


                        }
                        action("Nursing Diploma")
                        {
                            Caption = 'Nursing Diploma';
                            Image = EntriesList;
                            ApplicationArea = All;


                        }
                        action("AICASA Unofficial Transcript")
                        {
                            Caption = 'AICASA Unofficial Transcript';
                            Image = EntriesList;
                            ApplicationArea = All;


                        }
                        action("AUA Unofficial Transcript")
                        {
                            Caption = 'AUA Unofficial Transcript';
                            Image = EntriesList;
                            ApplicationArea = All;


                        }
                        action("Transcripts-Official-AICASA NON DEGREE PROGRAM")
                        {
                            Caption = 'Transcripts-Official-AICASA NON DEGREE PROGRAM';
                            Image = EntriesList;
                            ApplicationArea = All;


                        }
                    }
                    action("Student Honors_3")
                    {
                        Caption = 'Student Honors';
                        image = Account;
                        ApplicationArea = All;
                        RunObject = page "Student Honors";
                        RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                    }

                }
            }
            //360 End
            action("Student Card")
            {
                Caption = 'Student Card';
                RunObject = page "Student Detail Card-CS";
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunPageLink = "No." = field("No.");
            }
            action("Customer Card2")
            {
                Caption = 'Customer Card';
                RunObject = page "Customer Card";
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunPageLink = "No." = field("No.");
            }
            action("Bursar Signoff")
            {
                Caption = '&Bursar Signoff';
                //Visible = False;
                Image = SignUp;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    StudentTimeLineRec: Record "Student Time Line";
                    StudDetCar: Page "Student Detail Card-CS";
                    Text001Lbl: Label 'Do you want to Sign-Off Bursar Hold for Student No. %1?';
                    Text002Lbl: Label 'Bursar Hold Sign-Off has been completed for Student No. %1';
                begin
                    IF CONFIRM(Text001Lbl, FALSE, Rec."No.") THEN BEGIN
                        if Rec.BursarHoldCheck(Rec."No.") = true then begin
                            Rec.BursarSignoff(Rec."No.");
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Bursar Signoff Hold', UserId(), Today());
                            Message(Text002Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            Error('Bursar Hold is not enable for the student %1', Rec."No.");
                    end else
                        exit;
                end;

            }
            group("Bursar Activity")
            {
                action("Payment Plan Self Payment")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        FinancialAID: Record "Financial AID";
                    begin
                        FinancialAID.reset();
                        FinancialAID.SetRange("Student No.", gStudentNo);
                        FinancialAID.SetRange(Semester, gSem);
                        FinancialAID.SetRange("Academic Year", gaY);
                        FinancialAID.SetFilter(Type, '<>%1', FinancialAID.Type::"Financial Aid");
                        //FinancialAID.SetFilter(Status, '%1', FinancialAID.Status::Approved);
                        if FinancialAID.findset() then;
                        Page.Run(Page::"Payment Plan Application", FinancialAID);
                    end;
                }
                action("Payment Plan Self Payment Posted")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        FinancialAID: Record "Financial AID";
                    begin
                        FinancialAID.reset();
                        FinancialAID.SetRange("Student No.", gStudentNo);
                        FinancialAID.SetRange(Semester, gSem);
                        FinancialAID.SetRange("Academic Year", gaY);
                        FinancialAID.SetFilter(Type, '<>%1', FinancialAID.Type::"Financial Aid");
                        FinancialAID.SetFilter(Status, '%1', FinancialAID.Status::Approved);
                        if FinancialAID.findset() then;
                        Page.Run(Page::"Payment Plan Application", FinancialAID);
                    end;
                }

                action("Document Attachment view")
                {
                    Caption = 'Document Attachment view';
                    image = PostApplication;
                    ApplicationArea = Basic, Suite;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // Promotedonly = True;
                    // PromotedIsBig = true;
                    //Promoted = true;
                    //PromotedCategory = Category8;
                    RunObject = Page "Student Document Attachment";
                    RunPageLink = "Student No." = FIELD("No.");
                }
                action("Generated Fees Button - Open fee Journal")
                {
                    ApplicationArea = All;


                    trigger OnAction()
                    var
                        FeeJournalPage: page "Fee Journal";
                        GenJournalLine: Record "Gen. Journal Line";

                    begin
                        Clear(FeeJournalPage);
                        GenJournalLine.reset();
                        GenJournalLine.SetRange("Enrollment No.", rec."Enrollment No.");
                        if GenJournalLine.FindSet() then;

                        FeeJournalPage.SetTableView(GenJournalLine);
                        FeeJournalPage.SETRECORD(GenJournalLine);
                        FeeJournalPage.Run();
                    end;
                }
                action("Generated Fees")
                {
                    ApplicationArea = All;


                    trigger OnAction()
                    var
                        CLE: Record "Cust. Ledger Entry";

                    begin
                        CLE.Reset();
                        CLE.SetRange("Customer No.", gStudentNo);
                        CLE.SetRange("Academic Year", gaY);
                        CLE.SetRange(Semester, gSem);
                        CLE.SetRange(Term, GTerm);
                        Page.Run(0, CLE);
                    end;
                }
                action("Fee Generation")
                {
                    ApplicationArea = All;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // Promotedonly = True;
                    // PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Stud: Record "Student Master-CS";
                        Customer: Record Customer;
                        ReportFeeGenerator: Report "Fee Generation New";
                    begin
                        // Customer.reset();
                        // Customer.SetRange("No.", Rec."Original Student No.");
                        // Customer.SetRange(Customer."Academic Year", Rec."Academic Year");
                        // Customer.SetRange(Customer."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        // if Customer.FindFirst() then begin
                        clear(ReportFeeGenerator);
                        ReportFeeGenerator.SetParameter(Rec."Global Dimension 1 Code", Rec."Academic Year", Rec.Semester, rec."Enrollment No.");
                        // ReportFeeGenerator.SetTableView(Customer);
                        ReportFeeGenerator.Run();
                        // end;
                        //Report.Run(50042, true, false, Customer);
                    end;
                }

                //SD-SN-23-Dec-2020 +
                // action("Payment Plan Or Self Payment.")
                // {
                //     ApplicationArea = All;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Promotedonly = True;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     var
                //         FinancialAID: Record "Financial AID";
                //     begin
                //         FinancialAID.reset();
                //         FinancialAID.SetRange("Student No.", gStudentNo);
                //         FinancialAID.SetRange(Semester, gSem);
                //         FinancialAID.SetRange("Academic Year", gaY);
                //         FinancialAID.SetRange(term, GTerm);
                //         FinancialAID.SetFilter(Type, '%1|%2', FinancialAID.Type::"Payment Plan", FinancialAID.Type::"Self Payment");
                //         if FinancialAID.findset() then;
                //         Page.Run(50655, FinancialAID);
                //     end;
                // }
                //SD-SN-23-Dec-2020 -

            }
            group("Financial Aid ")
            {
                Visible = FincancialAid;
                action("Financial AID2")
                {
                    ApplicationArea = All;
                    //Promoted = true;
                    // PromotedCategory = Process;
                    // Promotedonly = True;
                    // PromotedIsBig = true;
                    Caption = 'Financial Aid';

                    trigger OnAction()
                    var
                        FinancialAID: Record "Financial AID";

                    begin
                        FinancialAID.reset();
                        FinancialAID.SetRange("Student No.", gStudentNo);
                        FinancialAID.SetRange(Semester, gSem);
                        FinancialAID.SetRange("Academic Year", gaY);
                        FinancialAID.SetRange(Type, FinancialAID.Type::"Financial Aid");
                        //FinancialAID.SetFilter(Status, '%1|%2', FinancialAID.Status::Approved, FinancialAID.Status::Rejected);
                        if FinancialAID.findset() then;
                        Page.Run(50652, FinancialAID);
                    end;
                }
                action("Financial AID Posted")
                {
                    ApplicationArea = All;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // Promotedonly = True;
                    // PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FinancialAID: Record "Financial AID";
                    begin
                        FinancialAID.reset();
                        FinancialAID.SetRange("Student No.", gStudentNo);
                        FinancialAID.SetRange(Semester, gSem);
                        FinancialAID.SetRange("Academic Year", gaY);
                        FinancialAID.SetRange(Type, FinancialAID.Type::"Financial Aid");
                        FinancialAID.SetFilter(Status, '%1|%2', FinancialAID.Status::Approved, FinancialAID.Status::Rejected);
                        if FinancialAID.findset() then;
                        Page.Run(Page::"FinancialAIDApprovRejectList", FinancialAID);
                    end;
                }
                action("Financial AID Roster")
                {
                    ApplicationArea = All;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // Promotedonly = True;
                    // PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FinancialAIDrosters: Record "Financial AID roster";

                    begin
                        FinancialAIDrosters.reset();
                        FinancialAIDrosters.SetRange("Student No.", gStudentNo);
                        FinancialAIDrosters.SetRange(Semester, gSem);
                        FinancialAIDrosters.SetRange("Academic Year", gaY);
                        //FinancialAIDrosters.SetRange(Type, FinancialAIDrosters.Type::"Financial Aid");
                        //FinancialAID.SetFilter(Status, '%1|%2', FinancialAID.Status::Approved, FinancialAID.Status::Rejected);
                        if FinancialAIDrosters.findset() then;
                        Page.Run(Page::"Financial Aid Roster", FinancialAIDrosters);
                    end;
                }
                action("Pending Financial AID Roster.")
                {
                    ApplicationArea = All;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // Promotedonly = True;
                    // PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FinancialAIDrosters: Record "Financial AID roster";

                    begin
                        FinancialAIDrosters.reset();
                        FinancialAIDrosters.SetRange("Student No.", gStudentNo);
                        FinancialAIDrosters.SetRange(Semester, gSem);
                        FinancialAIDrosters.SetRange("Academic Year", gaY);
                        //FinancialAIDrosters.SetRange(Type, FinancialAIDrosters.Type::"Financial Aid");
                        FinancialAIDrosters.SetFilter(Status, '%1|%2', FinancialAIDrosters.Status::"Pending for Approval", FinancialAIDrosters.Status::Open);
                        if FinancialAIDrosters.findset() then;
                        Page.Run(Page::"Pending Financial Aid Roster", FinancialAIDrosters);
                    end;
                }
            }
            group("Housing.")
            {
                // action("Housing Application")//GMCSCOM
                // {
                //     ApplicationArea = All;
                //     // Promoted = true;
                //     // PromotedCategory = Process;
                //     // Promotedonly = True;
                //     // PromotedIsBig = true;
                //     trigger OnAction()
                //     var
                //         HousingApplication: Record "Housing Application";
                //     begin
                //         HousingApplication.reset();
                //         HousingApplication.setrange("Academic Year", gaY);
                //         HousingApplication.setrange(Semester, gSem);
                //         HousingApplication.setrange("Student No.", gStudentNo);
                //         HousingApplication.setrange(Term, GTerm);
                //         //HousingApplication.SetRange(Posted, true);
                //         if HousingApplication.FindFirst() then;
                //         Page.Run(0, HousingApplication);
                //     end;

                // }
                action("Housing Application Posted")
                {
                    ApplicationArea = All;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // Promotedonly = True;
                    // PromotedIsBig = true;
                    trigger OnAction()
                    var
                        HousingApplication: Record "Housing Application";
                    begin
                        HousingApplication.reset();
                        HousingApplication.setrange("Academic Year", gaY);
                        HousingApplication.setrange(Semester, gSem);
                        HousingApplication.setrange("Student No.", gStudentNo);
                        HousingApplication.setrange(Term, GTerm);
                        HousingApplication.SetRange(Posted, true);
                        if HousingApplication.FindFirst() then;
                        Page.Run(0, HousingApplication);
                    end;

                }
                action("Housing waiver Application")
                {
                    Caption = 'Housing waiver Application';
                    //RunObject = page "Student Detail Card-CS";
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // Promotedonly = True;
                    // PromotedIsBig = true;
                    //RunPageLink = "No." = field("No.");Pending Housing Wavier List
                    trigger OnAction()

                    var
                        OptOut: Record 50363;
                    //Tye :Page "Pending Housing Wavier List";
                    begin
                        OptOut.reset();
                        OptOut.setrange("Academic Year", gaY);
                        OptOut.setrange(Semester, gSem);
                        OptOut.setrange("Student No.", gStudentNo);
                        OptOut.setrange(Term, GTerm);
                        //OptOut.setrange(Status, OptOut.Status::Approved);
                        OptOut.SetRange("Application Type", OptOut."Application Type"::"Housing Wavier");
                        if OptOut.FindFirst() then;
                        Page.Run(50573, OptOut);
                    end;

                }
                //    // action("Housing waiver Application Posted")//GMCSCOM
                //     {
                //         Caption = 'Housing waiver Application Posted';
                //         //RunObject = page "Student Detail Card-CS";
                //         // Promoted = true;
                //         // PromotedCategory = Process;
                //         // Promotedonly = True;
                //         // PromotedIsBig = true;
                //         //RunPageLink = "No." = field("No.");
                //         trigger OnAction()

                // var
                // OptOut: Record 50363;
                //         begin
                //             OptOut.reset();
                //             OptOut.setrange("Academic Year", gaY);
                //             OptOut.setrange(Semester, gSem);
                //             OptOut.setrange("Student No.", gStudentNo);
                //             OptOut.setrange(Term, GTerm);
                //             OptOut.setrange(Status, OptOut.Status::Approved);
                //             OptOut.SetRange("Application Type", OptOut."Application Type"::"Housing Wavier");
                //             if OptOut.FindFirst() then;
                //             Page.Run(50571, OptOut);

                //         end;
                //     }

                // }
                action("Student Group")
                {
                    Caption = 'Student Group';
                    Image = EntriesList;
                    ApplicationArea = All;

                    RunObject = Page "Student Group";
                    RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                }
                action("Student Document")
                {
                    Caption = 'Student Document';
                    image = Account;
                    ApplicationArea = All;
                    RunObject = page "Student Document Attachment";
                    RunPageLink = "Student No." = FIELD("No."), "Enrolment No." = field("Enrollment No.");

                }
            }
        }
    }

    //Global Var
    var
        [indataset]

        Bool: boolean;
        Balance: Decimal;
        OptOut: Record 50363;
        HousingwaiverApplication: Boolean;
        HousingwaiverApplicationExist: Boolean;
        RecHoldStatusLedger: Record "Hold Status Ledger";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        "Old Dues": Decimal;
        Fees: Decimal;
        Housing1: Decimal;
        "Housing Application Cost": Decimal;
        "Housing Application Exist": boolean;
        "Transport Details": Decimal;
        "Insurance Details": Decimal;
        "Financial AID Field & Amount": Decimal;
        "Payment Plan OR Self Payment": Decimal;
        Cust: Record Customer;
        GenWebJnl: Codeunit "Gen. Web  Journal -CS";
        GTerm: Option;
        gSem: Code[20];
        gaY: code[20];
        gStudentNo: Code[20];
        "Title-4 Agreement Status": Boolean;

        FincancialAidApplicationExist: Boolean;
        PayMentPlanSelfPaymentExist: boolean;
        [InDataSet]
        Transportallot: Boolean;
        [InDataSet]
        ApplyForInsurance: Boolean;
        [InDataSet]
        FincancialAid: Boolean;
        [InDataSet]
        FinancialAid_GBoo: boolean;

        AdmissionGroup: Boolean;
        RegistrarGroup: Boolean;
        ClinicalDetailsGroup: Boolean;
        HousingGroup: Boolean;
        BursarGroup: Boolean;
        EEDBasicSciGroup: Boolean;
        EEDClinicalGroup: Boolean;
        GraduateAffairsGroup: Boolean;
        ExaminationGroup: Boolean;
        GraduationGroup: Boolean;

        FinancialAid1: Boolean;

        UserSetup: Record "User Setup";

        FinancialAidAppNo: code[20];

        FinancialAID: Record "Financial AID";


    procedure SetParameter(PTerm: Option; PSem: Code[20]; PAY: code[20]; pStudentNo: Code[20])
    begin
        gTerm := PTerm;
        gsem := Psem;
        gaY := PAY;
        gStudentNo := pStudentNo;
        Rec.SetRange("No.", gStudentNo);
        Rec.FindFirst();
    end;

    trigger OnOpenPage()
    Var
        UserSetup: Record "User Setup";
        course: Record "Course Master-CS";

    begin

        Clear(FinancialAidAppNo);
        FinancialAID.reset();
        FinancialAID.SetRange("Student No.", gStudentNo);
        FinancialAID.SetRange(Semester, gSem);
        FinancialAID.SetRange("Academic Year", gaY);
        FinancialAID.SetRange(Type, FinancialAID.Type::"Financial Aid");
        FinancialAID.SetFilter(Status, '%1|%2|%3', FinancialAID.Status::Approved, FinancialAID.Status::Rejected, FinancialAID.Status::"Pending for Approval");
        if FinancialAID.FindFirst() then
            FinancialAidAppNo := FinancialAID."Application No.";

        Bool := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            Bool := false;
        UserSetup.Get(UserId());

        RoleAndPermission();

        Rec.SetRange("No.", gStudentNo);
        Rec.FindFirst();
        Bool := true;
        FincancialAid := true;
        if course.get(Rec."Course Code") then
            if Not course."Financial AID Applicable" then
                FincancialAid := False;


        FinancialAid_GBoo := True;
        if course.Get(Rec."Course Code") then
            if Not course."Financial AID Applicable" then
                FinancialAid_GBoo := false;

        GetData();
    end;

    procedure GetData()
    var
        CurrentSemesterFee: Record "Current Semester Fee";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        StudentRegistration: Record "Student Registration-CS";
        HousingApplication: Record "Housing Application";
        Cust: Record Customer;
        FinancialAID: Record "Financial AID";
        FeeGeneration: Report "Fee Generation New";
        totalAmount: Decimal;
        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        typeofFee: Record "Fee Component Master-CS";
        OptOut: Record "Opt Out";


    begin
        ClearAmounts();
        totalAmount := 0;
        ApplyForInsurance := Rec."Apply For Insurance";

        Cust.Reset();
        Cust.SetRange("No.", Rec."Original Student No.");
        if cust.FindFirst() then;
        Cust.CalcFields(Balance);
        Balance := Cust.Balance;


        Cust.get(Rec."Original Student No.");

        GenWebJnl.WebAPICalcOldDues(Rec."Original Student No.", gaY, gSem, GTerm, "Old Dues");
        //
        TotalAmount := FeeGeneration.StudentTotalFee(gStudentNo, '', '', '', false, Fees, Housing1);
        //
        // Fees :=;
        // Housing :=;

        StudentRegistration.reset();
        StudentRegistration.SetRange("Student No", gStudentNo);
        StudentRegistration.SetRange(Term, GTerm);
        StudentRegistration.SetRange("Academic Year", gay);
        StudentRegistration.SetRange(Semester, gsem);
        if StudentRegistration.FindFirst() then
            "Title-4 Agreement Status" := StudentRegistration."Title_IV Agreement";


        //
        HousingApplication.reset();
        HousingApplication.setrange("Academic Year", gaY);
        HousingApplication.setrange(Semester, gSem);
        HousingApplication.setrange("Student No.", gStudentNo);
        HousingApplication.setrange(Term, GTerm);
        HousingApplication.SetRange(Posted, true);
        if HousingApplication.FindFirst() then
            "Housing Application Cost" := HousingApplication."Housing Cost";

        "Housing Application Exist" := false;
        HousingApplication.reset();
        HousingApplication.setrange("Academic Year", gaY);
        HousingApplication.setrange(Semester, gSem);
        HousingApplication.setrange("Student No.", gStudentNo);
        HousingApplication.setrange(Term, GTerm);
        if HousingApplication.FindFirst() then
            "Housing Application Exist" := true;



        HousingwaiverApplicationExist := false;
        OptOut.reset();
        OptOut.setrange("Academic Year", gaY);
        OptOut.setrange(Semester, gSem);
        OptOut.setrange("Student No.", gStudentNo);
        OptOut.setrange(Term, GTerm);
        OptOut.SetRange("Application Type", OptOut."Application Type"::"Housing Wavier");
        if OptOut.FindFirst() then
            HousingwaiverApplicationExist := True;

        HousingwaiverApplication := false;
        OptOut.reset();
        OptOut.setrange("Academic Year", gaY);
        OptOut.setrange(Semester, gSem);
        OptOut.setrange("Student No.", gStudentNo);
        OptOut.setrange(Term, GTerm);
        OptOut.setrange(Status, OptOut.Status::Approved);
        OptOut.SetRange("Application Type", OptOut."Application Type"::"Housing Wavier");
        if OptOut.FindFirst() then
            HousingwaiverApplication := True;

        //
        FincancialAidApplicationExist := false;
        FinancialAID.reset();
        FinancialAID.SetRange("Student No.", gStudentNo);
        FinancialAID.SetRange(Semester, gSem);
        FinancialAID.SetRange("Academic Year", gaY);
        FinancialAID.SetRange(Term, GTerm);
        if FinancialAID.FindFirst() then
            FincancialAidApplicationExist := true;

        FinancialAID.reset();
        FinancialAID.SetRange("Student No.", gStudentNo);
        FinancialAID.SetRange(Semester, gSem);
        FinancialAID.SetRange("Academic Year", gaY);
        FinancialAID.SetRange(Term, GTerm);
        FinancialAID.SetRange(Status, FinancialAID.status::Approved);
        if FinancialAID.FindFirst() then
            "Financial AID Field & Amount" := FinancialAID."Unsubsidized Transation Amount" + FinancialAID."Grad. Plus Transaction Amount";

        FinancialAID.reset();
        FinancialAID.SetRange("Student No.", gStudentNo);
        FinancialAID.SetRange(Semester, gSem);
        FinancialAID.SetRange("Academic Year", gaY);
        FinancialAID.SetRange(Term, GTerm);
        FinancialAID.SetRange(Status, FinancialAID.status::Approved);
        FinancialAID.SetFilter(Type, '%1|%2', FinancialAID.Type::"Payment Plan", FinancialAID.Type::"Self Payment");
        if FinancialAID.FindFirst() then
            "Payment Plan OR Self Payment" := Fees + Housing1 - "Financial AID Field & Amount"
        Else
            "Payment Plan OR Self Payment" := 0;

        Transportallot := Rec."Transport Allot";

        FeeCourseHeadCS.Reset();
        FeeCourseHeadCS.setrange(Semester, gSem);
        FeeCourseHeadCS.setrange("Academic Year", gaY);
        FeeCourseHeadCS.setrange("Course Code", Rec."Course Code");
        if FeeCourseHeadCS.FindFirst() then begin
            FeeCourseLineCS.reset();
            FeeCourseLineCS.setrange("Document No.", FeeCourseHeadCS."No.");
            FeeCourseLineCS.setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            if FeeCourseLineCS.FindSet() then begin
                repeat

                    if typeofFee.Get(FeeCourseLineCS."Fee Code") then begin
                        if typeofFee."Type Of Fee" = typeofFee."Type Of Fee"::"BUS-SEMESTER" then
                            "Transport Details" := "Transport Details" + FeeCourseLineCS.Amount;

                        if Rec."Apply For Insurance" then
                            if typeofFee."Type Of Fee" = typeofFee."Type Of Fee"::HEALTHINS then
                                "insurance Details" := "insurance Details" + FeeCourseLineCS.Amount;

                        if Not Rec."Apply For Insurance" then
                            if typeofFee."Type Of Fee" = typeofFee."Type Of Fee"::REPATINS then
                                "insurance Details" := "insurance Details" + FeeCourseLineCS.Amount;
                    end;

                until FeeCourseLineCS.Next() = 0;
            end;
        end;

        //"Transport Details" := FeeGeneration.StudentTotalFee(gStudentNo, '', '', '', false, Fees, Housing);
        //;
        // "Insurance Details" :=;

        CurrentSemesterFee.VariablePassing(Rec."No.");

    end;

    procedure ClearAmounts()

    begin
        Clear(Balance);
        Clear("Old Dues");
        Clear(Fees);
        Clear(Housing1);
        Clear("Housing Application Cost");
        Clear("Transport Details");
        Clear("Insurance Details");
        Clear("Financial AID Field & Amount");
        Clear("Payment Plan OR Self Payment");
        "Title-4 Agreement Status" := false;
        Transportallot := false;
    end;



    // procedure FinancialAidSignoffPage(StudentNo: Code[20]; WithBursar: Boolean)
    // Var
    //     HoldUserMappingRec: Record "Holds User Mapping";
    //     StudentWiseHoldRec: Record "Student Wise Holds";
    //     ConfirmationTxt: Text;
    //     Text001LclLbl: Label 'Do you want to Disable the Student No. %1 Financial Aid signoff?';
    //     Text002LclLbl: Label 'Student No. %1 Financial Aid signoff has been Disabled.';
    //     Text003Lbl: Label 'This action will also Disable Financial Aid signoff, do you still want to continue?';
    // begin

    //     if WithBursar then
    //         ConfirmationTxt := Text003Lbl
    //     else
    //         ConfirmationTxt := Text001LclLbl;

    //     if HousingHoldCheck("No.") = true then
    //         error('Housing Hold is Enable for Student No. %1', "No.");
    //     // if FERPASignoffCheck("No.") = true then
    //     //     error('FERPA Signoff is Enable for Student No. %1', "No.");

    //     HoldUserMappingRec.Reset();
    //     HoldUserMappingRec.SetRange("User ID", UserId());
    //     if HoldUserMappingRec.FindFirst() then begin
    //         if FinancialAIDHoldCheck("No.") then
    //             IF CONFIRM(ConfirmationTxt, FALSE, "No.") THEN BEGIN
    //                 StudentWiseHoldRec.Reset();
    //                 StudentWiseHoldRec.SetRange("Student No.", "No.");
    //                 StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::"Financial Aid");
    //                 if StudentWiseHoldRec.FINDFIRST() then begin
    //                     StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Disable;
    //                     StudentWiseHoldRec.Modify();
    //                     StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Disable;
    //                     StudentWiseHoldRec.Modify();
    //                     RecCodeUnit50037.HoldStatusLedgerEntryInsert("No.");
    //                     RecHoldStatusLedger.Reset();
    //                     RecHoldStatusLedger.SetRange("Student No.", "No.");
    //                     RecHoldStatusLedger.SetRange("Academic Year", "Academic Year");
    //                     RecHoldStatusLedger.SetRange(Semester, Semester);
    //                     RecHoldStatusLedger.SetRange("Hold Type", RecHoldStatusLedger."Hold Type"::" ");
    //                     IF RecHoldStatusLedger.FindFirst() then begin
    //                         RecHoldStatusLedger."Table Caption" := TableName();
    //                         RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::Bursar;
    //                         RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
    //                         RecHoldStatusLedger.Modify();
    //                     end;
    //                 end;
    //                 "Financial Aid Approved" := true;
    //                 Modify();
    //                 Message(Text002LclLbl);
    //                 CurrPage.Update();
    //             end else
    //                 exit;

    //     end else
    //         Error('You do not have the permission to disable the Financial Aid signoff');
    // end;



    procedure RoleAndPermission()
    var
        userapproversetup: Record "Document Approver Users";
    begin
        FinancialAid1 := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            FinancialAid1 := false;

        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Financial Aid Department") then
            FinancialAid1 := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                FinancialAid1 := true
            else
                FinancialAid1 := false;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Financial Aid Department") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         FinancialAid1 := true
        //     else
        //         FinancialAid1 := false;        

        AdmissionGroup := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::Admissions) then
            AdmissionGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                AdmissionGroup := true
            else
                AdmissionGroup := false;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::Admissions) or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         AdmissionGroup := true
        //     else
        //         AdmissionGroup := false;

        RegistrarGroup := true;

        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Registrar Department") then
            RegistrarGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                RegistrarGroup := true
            else
                RegistrarGroup := false;
        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Registrar Department") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         RegistrarGroup := true
        //     else
        //         RegistrarGroup := false;


        ClinicalDetailsGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            ClinicalDetailsGroup := false;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Clinical Details") then
            ClinicalDetailsGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                ClinicalDetailsGroup := true
            else
                ClinicalDetailsGroup := false;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Clinical Details") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         ClinicalDetailsGroup := true
        //     else
        //         ClinicalDetailsGroup := false;

        HousingGroup := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Residential Services") then
            HousingGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                HousingGroup := true
            else
                HousingGroup := false;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Residential Services") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         HousingGroup := true
        //     else
        //         HousingGroup := false;

        BursarGroup := true;

        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Bursar Department") then
            BursarGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                BursarGroup := true
            else
                BursarGroup := false;
        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Bursar Department") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         BursarGroup := true
        //     else
        //         BursarGroup := false;

        EEDBasicSciGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            EEDBasicSciGroup := false;

        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"EED Pre-Clinical") then
            EEDBasicSciGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                EEDBasicSciGroup := true
            else
                EEDBasicSciGroup := false;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"EED Pre-Clinical") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         EEDBasicSciGroup := true
        //     else
        //         EEDBasicSciGroup := false;

        EEDClinicalGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            EEDClinicalGroup := false;

        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"EED Clinical") then
            EEDClinicalGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                EEDClinicalGroup := true
            else
                EEDClinicalGroup := false;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"EED Clinical") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         EEDClinicalGroup := true
        //     else
        //         EEDClinicalGroup := false;

        GraduateAffairsGroup := true;
        ExaminationGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            GraduateAffairsGroup := false;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Graduate Affairs") then begin
            GraduateAffairsGroup := true;
            ExaminationGroup := true;
        end else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then begin
                GraduateAffairsGroup := true;
                ExaminationGroup := true;
            end else begin
                GraduateAffairsGroup := false;
                ExaminationGroup := false;
            end;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Graduate Affairs") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         GraduateAffairsGroup := true
        //     else
        //         GraduateAffairsGroup := false;

        // ExaminationGroup := true;
        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Graduate Affairs") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         ExaminationGroup := true
        //     else
        //         ExaminationGroup := false;

        GraduationGroup := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::Graduation) then
            GraduationGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                GraduationGroup := true
            else
                GraduationGroup := false;
        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::Graduation) or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::" ") then
        //         GraduationGroup := true
        //     else
        //         GraduationGroup := false;


    end;
}
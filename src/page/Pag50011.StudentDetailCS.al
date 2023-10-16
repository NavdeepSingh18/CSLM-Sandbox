page 50011 "Student Detail-CS"
{
    // version V.001-CS

    // Sr.No    Emp.ID    Date        Trigger                              Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.    CSPL-00174  03-03-19   <Action1102155025> - OnAction()      Code added to run the page.
    // 02.    CSPL-00174  03-03-19   Student Data Upload - OnAction()     Code added for student data Upload.
    // 03.    CSPL-00174  03-03-19   Update Student Details - OnAction()  Code added for student details update.
    // 04.    CSPL-00174  03-03-19   Send Data to Portal - OnAction()     Code added for send data to the portal .

    Caption = 'Student List';
    CardPageID = "Student Detail Card-CS";
    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate,Admissions,Registrar/Academics,Clinical,Student Services,Bursar/Finance,Financial Aid,EED Pre-Clinical,EED Clinical Science,Graduate Affairs,Feedback';
    SourceTable = "Student Master-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);
    RefreshOnActivate = true;
    UsageCategory = None;
    //ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("Original Student No."; Rec."Original Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Student No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment Order"; Rec."Enrollment Order")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Awarded"; Rec."Date Awarded")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Step 2 CK Exam Pass"; Rec."Step 2 CK Exam Pass")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Caption = 'Course Code';
                    ShowMandatory = true;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    Caption = 'Course Name';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    Caption = 'Phone';
                    Visible = Balance;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                    Caption = 'MobileNumber';
                    Visible = Balance;

                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    Caption = 'SexDesc';
                    Visible = Balance;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                    Caption = 'Email';
                    Visible = Balance;
                }
                field("Alternate Email Address"; Rec."Alternate Email Address")
                {
                    ApplicationArea = All;
                    Caption = 'Alternate Email';
                    Visible = Balance;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Caption = 'DOB';
                    ApplicationArea = All;
                    Visible = Balance;
                }

                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    Visible = Balance;
                }
                field("T4 Authorization"; Rec."T4 Authorization")
                {
                    ApplicationArea = All;
                    Caption = 'TIV FORM SIGNED (YES/ NO)';
                    Visible = Balance;
                }
                // field(Health; Rec.Health)//GMCSCOM
                // {
                //     ApplicationArea = All;
                //     Caption = 'Health insurance (AUA/ Have own)';
                //     Visible = Balance;
                // }
                field(Addressee; Rec.Addressee)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Address1';
                    Visible = Balance;
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Address2';
                    Visible = Balance;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Address3';
                    Visible = Balance;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent City';
                    Visible = Balance;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent State';
                    Visible = Balance;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Post Code';
                    Visible = Balance;
                }
                field(Country; Rec."Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Country';
                    Visible = Balance;
                }

                field("Tuition Balance"; Rec."Tuition Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Tuition Balance';
                    Visible = Balance;
                    Lookup = true;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", REC."Original Student No.");
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
                    Visible = Balance;
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
                    Visible = Balance;
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
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;

                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Visible = Balance1;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                    Visible = Balance1;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Visible = Balance1;
                }


                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                    Visible = Balance1;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Parent Student No."; Rec."Parent Student No.")
                {
                    ApplicationArea = All;
                    Visible = Balance1;
                }
                field("Financial Aid Approved"; Rec."Financial Aid Approved")
                {
                    ApplicationArea = All;
                    Visible = Bool;
                }
                field("Payment Plan Applied"; Rec."Payment Plan Applied")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
                {
                    ApplicationArea = All;
                }
                field("Self Payment Applied"; Rec."Self Payment Applied")
                {
                    ApplicationArea = All;
                    Visible = Balance1;
                }
                field("Customer Exists"; Rec."Customer Exists")
                {
                    ApplicationArea = All;
                    Visible = Balance;
                }
                field("Housing Hold"; Rec."Housing Hold")
                {
                    Caption = 'Admissions Hold';
                    ApplicationArea = All;
                    Visible = Balance1;
                }
                // field("Bursar Hold";Rec."Bursar Hold")//GMCSCOM
                // {
                //     ApplicationArea = All;
                // }
                field("Financial Aid Hold"; Rec."Financial Aid Hold")
                {
                    ApplicationArea = All;
                    Visible = Bool;
                }
                field("Registrar Hold"; Rec."Registrar Hold")
                {
                    ApplicationArea = All;
                    Visible = Balance1;
                }
                field("Immigration Hold"; Rec."Immigration Hold")
                {
                    Caption = 'Student Services Hold';
                    ApplicationArea = All;
                    Visible = Balance1;
                }

            }
        }
        area(factboxes)
        {
            part("Student Picture"; "Student Picture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");

            }
            part("Hold FactBox"; "Hold FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = FIELD("No.");

            }
            part("Group FactBox"; "Group FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = FIELD("No.");
            }
            part("Student QRCode1"; "Student QRCode")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }

        }
    }

    actions
    {
        area(Processing)
        {
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
                            trigger OnAction()
                            var
                                EnrollmentHistoryRec: Record "Enrollment History";
                            // EnrollmentHistoryPag: Page "Enrollment History List";
                            begin
                                EnrollmentHistoryRec.Reset();
                                EnrollmentHistoryRec.Setrange("Student No.", Rec."No.");
                                // Clear(EnrollmentHistoryPag);//GMCSCOM
                                // EnrollmentHistoryPag.SetTableView(EnrollmentHistoryRec);
                                // if "Entry From Salesforce" then begin
                                //     EnrollmentHistoryPag.Editable := false;
                                //     EnrollmentHistoryPag.Run();
                                // end else begin
                                //     EnrollmentHistoryPag.Editable := true;
                                //     EnrollmentHistoryPag.Run();
                                // end;
                            end;
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
                            RunPageLink = Account = FIELD("No.");
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
                        action("ID Card")
                        {
                            Caption = 'ID Card';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            trigger OnAction()
                            var
                                RecStudentMaster: Record "Student Master-CS";
                            begin
                                //RunObject = Report "AICASA IDCard";
                                if Rec."Global Dimension 1 Code" = '9100' then begin
                                    RecStudentMaster.Reset();
                                    RecStudentMaster.SetRange("No.", rec."No.");
                                    IF RecStudentMaster.FindFirst() then begin
                                        Report.Run(Report::"AICASA IDCard", true, false, RecStudentMaster);
                                    end;
                                end;
                                // RunObject = Report "AUA Basic Science IDCard";
                                if Rec."Global Dimension 1 Code" = '9000' then begin
                                    if (Rec.Semester = 'MED1') or (Rec.Semester = 'MED2') or (Rec.Semester = 'MED3') or (Rec.Semester = 'MED4') then begin
                                        RecStudentMaster.Reset();
                                        RecStudentMaster.SetRange("No.", rec."No.");
                                        IF RecStudentMaster.FindFirst() then begin
                                            Report.Run(Report::"AUA Basic Science IDCard", true, false, RecStudentMaster);
                                        end;
                                    end;
                                end;
                                //RunObject = Report "AUA 5th Semester IDCard";
                                if Rec."Global Dimension 1 Code" = '9000' then begin
                                    if (Rec.Semester = 'BSIC') or (Rec.Semester = 'CLN5') or (Rec.Semester = 'CLN6') or (Rec.Semester = 'CLN7') or (Rec.Semester = 'CLN8') or (Rec.Semester = 'CLN9') then begin
                                        RecStudentMaster.Reset();
                                        RecStudentMaster.SetRange("No.", Rec."No.");
                                        IF RecStudentMaster.FindFirst() then begin
                                            Report.Run(Report::"AUA 5th Semester IDCard", true, false, RecStudentMaster);
                                        end;
                                    end;
                                end;

                            end;

                        }
                        action("Generate QRCode")
                        {
                            Image = BarCode;
                            ApplicationArea = All;
                            trigger OnAction()
                            begin
                                IF Confirm('Do you want to generate QR Code ?', false) then begin
                                    //GenerateBarCodeNew(Rec);//GMCSCOM
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
                                           //Semester = field(Semester), "Academic Year" = Field("Academic Year"),
                                           Blocked = filter(False),
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
                            begin
                                usersetupapprover.Reset();
                                usersetupapprover.setrange("User ID", UserId());
                                usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Registrar Department");
                                IF not usersetupapprover.FindFirst() then
                                    Error('You are not authorized. This functionality can be handled by "Registrar Department"');
                                // StudentMaster.Reset();
                                // StudentMaster.SetRange("No.", "No.");
                                // If StudentMaster.FindFirst() then begin
                                //     StudentStatus.SetTableView(StudentMaster);
                                //     StudentStatus.Run();

                                // end;
                                StudentStatus.GetStudent(Rec."No.");
                                StudentStatus.Run();
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
                                StudentMaster.SetRange("No.", Rec."No.");
                                If StudentMaster.FindFirst() then begin
                                    ResidencyDetails.SetTableView(StudentMaster);
                                    ResidencyDetails.Run();
                                end;
                            end;
                        }
                        action("Student Subject Mapping")
                        {
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentMasterRec: Record "Student Master-CS";
                            begin
                                StudentMasterRec.Reset();
                                StudentMasterRec.SetRange("No.", Rec."No.");
                                If StudentMasterRec.FindFirst() then
                                    Report.Run(Report::"Student Subject Mapping", True, False, StudentMasterRec);

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
                            Caption = 'Student Holds';
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
                            Visible = Balance;
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
                        action("Student Exam Change Log")
                        {
                            Caption = 'Student Exam Change Log';
                            Image = Log;
                            RunObject = page "Student Exam Change Log";
                            RunPageLink = "Student No." = field("No.");
                        }
                        action("Student Subject Change Log")
                        {
                            Caption = 'Student Subject Change Log';
                            Image = Log;
                            RunObject = page "Student Subject Change Log";
                            RunPageLink = "Student No." = field("No.");
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

                            RunObject = Page "Subject Student-CS";
                            RunPageLink = "Original student No." = field("Original Student No.");


                        }
                        action("Student Subject Exams")
                        {
                            Caption = 'Student Subject Exams';
                            Image = List;
                            ApplicationArea = All;
                            RunObject = Page "Student Subject Exam List";
                            RunPageLink = "Student No." = FIELD("No.");

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
                    /*
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
                                StudentMaster.SetRange("No.", "No.");
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
                */
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
                            RunPageView = where("Void Entry" = Filter(false));
                        }
                        action("Student Status Deferred/Declined Buffer List1")
                        {
                            Caption = 'Student Status Deferred/Declined List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Deferred/Declined Buffer List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Student Educational Qualification Detail")
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

                    group("Student TranscriptsR1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official Transcripts")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsR")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsR1Print2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official TranscriptsPrint2")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsRPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsR1Print3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official TranscriptsPrint3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsRPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsR1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsRPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsR1Print5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official TranscriptsPrint5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts4(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsRPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsR1Print6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official TranscriptsPrint6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsRPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
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

                group("Clinical")
                {
                    Visible = ClinicalDetailsGroup;
                    Caption = 'Clinical';
                    action("Rotation Audit")
                    {
                        Image = EntriesList;
                        ApplicationArea = All;
                        Caption = 'Rotation Audit';
                        trigger OnAction()
                        var
                            StudentMaster: Record "Student Master-CS";
                            StudentsRotationAudit: Page "Students Rotation Audit";
                        begin
                            StudentMaster.Reset();
                            StudentMaster.FilterGroup(2);
                            StudentMaster.SetRange("No.", Rec."No.");
                            StudentMaster.FilterGroup(0);
                            StudentsRotationAudit.Setvariables(true);
                            StudentsRotationAudit.SetTableView(StudentMaster);
                            StudentsRotationAudit.RunModal();
                        end;
                    }
                    action("Clincal Documents")
                    {
                        ApplicationArea = All;
                        Caption = 'Clincal Documents';
                        Image = Documents;
                        trigger OnAction()
                        var
                            StudentDocumentAttachment: Record "Student Document Attachment";
                        begin
                            StudentDocumentAttachment.Reset();
                            StudentDocumentAttachment.FilterGroup(2);
                            StudentDocumentAttachment.SetRange("Student No.", Rec."No.");
                            StudentDocumentAttachment.FilterGroup(0);
                            Page.RunModal(Page::"Audit Clinical Documents", StudentDocumentAttachment);
                        end;
                    }
                    action("Clerkship Preferred Site and Date Selection")
                    {
                        Caption = 'Preferred Site and Date Selection';
                        image = Account;
                        ApplicationArea = All;
                        RunObject = page "STDClkshpSite_DateSelectionLST";
                        RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");
                    }
                    action("Clerkship Preferred Site And Date Approved/Rejected List")
                    {
                        Caption = 'Preferred Site And Date List';
                        image = List;
                        ApplicationArea = All;
                        RunObject = page "UNVClkshpSite_DateLST+";
                        RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");
                    }
                    action("List of Rotations")
                    {
                        Caption = 'List of Rotation(s)';
                        Image = EntriesList;
                        ApplicationArea = All;
                        trigger OnAction()
                        var
                            RSL: Record "Roster Scheduling Line";
                        begin
                            RSL.Reset();
                            RSL.SetCurrentKey("Student No.", "Start Date");
                            RSL.FilterGroup(2);
                            RSL.SetRange("Student No.", Rec."No.");
                            //RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Core);
                            RSL.FilterGroup(2);
                            Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        end;
                    }
                    action("Elective Rotations")
                    {
                        Caption = 'Elective Rotations';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Visible = false;
                        trigger OnAction()
                        var
                            RSL: Record "Roster Scheduling Line";
                        begin
                            RSL.Reset();
                            RSL.SetCurrentKey("Student No.", "Start Date");
                            RSL.FilterGroup(2);
                            RSL.SetRange("Student No.", Rec."No.");
                            RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Elective);
                            RSL.FilterGroup(2);
                            Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        end;
                    }

                    action("FM1/IM1 Rotation")
                    {
                        Caption = 'FM1/IM1 Rotation';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Visible = false;
                        trigger OnAction()
                        var
                            RSL: Record "Roster Scheduling Line";
                        begin
                            RSL.Reset();
                            RSL.SetCurrentKey("Student No.", "Start Date");
                            RSL.FilterGroup(2);
                            RSL.SetRange("Student No.", Rec."No.");
                            RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::"FM1/IM1");
                            RSL.FilterGroup(2);
                            Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        end;
                    }
                    action("Roster Ledger Entries")
                    {
                        Caption = 'Roster Ledger Entries';
                        Image = LedgerEntries;
                        ApplicationArea = All;
                        trigger OnAction()
                        var
                            RLE: Record "Roster Ledger Entry";
                        begin
                            RLE.Reset();
                            RLE.SetCurrentKey("Start Date");
                            RLE.Ascending(false);
                            RLE.FilterGroup(2);
                            RLE.SetRange("Student ID", Rec."No.");
                            RLE.FilterGroup(2);
                            Page.RunModal(Page::"Roster Ledger Entries", RLE)
                        end;
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
                        Caption = 'Student Holds';
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
                        Visible = Balance;
                        image = PostApplication;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Customer Card";
                        RunPageLink = "No." = FIELD("Original Student No.");

                    }
                    action("Ledger Entries")
                    {
                        Caption = 'Ledger Entries';
                        image = PostApplication;
                        Visible = Balance;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Customer Ledger Entries";
                        RunPageLink = "Customer No." = FIELD("Original Student No.");
                        RunPageView = SORTING("Customer No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Student Legacy Ledger ")
                    {
                        Caption = 'Student Legacy Ledger';
                        Image = Ledger;
                        Visible = Balance;
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
                    /*
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

		    */
                    group("Student TranscriptsA1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptAs")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsAR")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsA1Print2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official TranscriptAsPrint2")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsA1Print3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official TranscriptAsPrint3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsA1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptAsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsA1Print5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official TranscriptAsPrint5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts4(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsA1Print6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official TranscriptAsPrint6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
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
                    action("USMLE Change Log")
                    {
                        Caption = 'USMLE Change Log';
                        Image = OpportunitiesList;
                        RunObject = page "USMLE Change Log Entry List";
                        RunPageLink = "Student ID" = field("No.");
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
                    action("Student timelne")
                    {
                        Caption = 'Student timeline';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Student Time Line";
                        RunPageLink = "Student No." = FIELD("No.");
                    }

                    action("Student GPA")
                    {
                        Caption = 'Student GPA';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page StudentGPACalculation;
                        RunPageLink = "No." = FIELD("No.");
                    }
                    action("CCSE Score_3")
                    {
                        caption = 'CCSE Score';
                        ApplicationArea = All;
                        Image = List;
                        RunObject = page "Student Subject Exam List";
                        RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CCSE);
                    }
                    action("CCSSE Score_3")
                    {
                        caption = 'CCSSE Score';
                        ApplicationArea = All;
                        Image = List;
                        RunObject = page "Student Subject Exam List";
                        RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CCSSE);
                    }
                    action("CBSE Score_3")
                    {
                        Caption = 'CBSE Score';
                        ApplicationArea = All;
                        Image = List;
                        RunObject = page "Student Subject Exam List";
                        RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CBSE);
                    }
                    Action("USMLE Scores_3")
                    {
                        Caption = 'USMLE Scores';
                        Image = PostApplication;
                        ApplicationArea = All;
                        RunObject = page "Student Subject Exam List";
                        RunPageLink = "Student No." = Field("No."), "Score Type" = filter("STEP 1" | "STEP 2 CK" | "STEP 2 CS");
                    }

                    group("Graduation Degree")
                    {

                        action("Student Degree")
                        {
                            Caption = 'Student Degree';
                            Image = Calculate;
                            ApplicationArea = All;
                            trigger OnAction()
                            Var
                                StudentDegreeRec: Record "Student Degree";
                                StudentDegree: Page "Student Degree";
                            begin
                                StudentDegreeRec.RESET();
                                StudentDegreeRec.SETRANGE("Student No.", Rec."No.");
                                StudentDegreeRec.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                IF StudentDegreeRec.Findfirst() then begin
                                    StudentDegree.Editable := False;
                                    StudentDegree.SETTABLEVIEW(StudentDegreeRec);
                                    StudentDegree.RUNMODAL();
                                end;
                            end;
                        }

                    }
                    action("Students Latest Enrollments")
                    {
                        ApplicationArea = All;
                        Image = Report2;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        RunObject = report "Students Latest Enrollments";
                    }

                    action("Students Detail Report")
                    {
                        ApplicationArea = All;
                        Image = Report2;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        RunObject = report "Student Detail Report";
                    }
                    group("Student TranscriptsB1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptBs")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsB1Print2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official TranscriptBsPrint2")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsB1Print3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official TranscriptBsPrint3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsB1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptBsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsB1Print5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official TranscriptBsPrint5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts4(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsB1Print6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official TranscriptBsPrint6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }
                    action("Student Honors_1")
                    {
                        Caption = 'Student Honors';
                        image = Account;
                        ApplicationArea = All;
                        RunObject = page "Student Honors";
                        RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                    }

                }
            }
            group(Registrar)
            {
                action("Registrar Hold Enable")
                {
                    Image = Close;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = RegistrarHoldVisible;
                    trigger OnAction()
                    Var
                        StudentStatusMangCod: Codeunit "Student Status Mangement";
                        StudentCount: Integer;
                    begin
                        CurrPage.SetSelectionFilter(StudentMasterCS);
                        StudentCount := StudentMasterCS.Count();
                        IF StudentCount > 1 then begin
                            IF CONFIRM(Text0013Lbl, FALSE) THEN BEGIN
                                IF StudentMasterCS.FindFirst() Then
                                    repeat
                                        StudentStatusMangCod.EnableRegistrarHold(StudentMasterCS);
                                    until StudentMasterCS.next() = 0;
                                Message(Text0015Lbl);
                                CurrPage.Update();
                            end else
                                exit;
                        end else
                            IF CONFIRM(Text0014Lbl, FALSE, Rec."No.") THEN BEGIN
                                StudentStatusMangCod.EnableRegistrarHold(Rec);
                                Message(Text0016Lbl, Rec."No.");
                                CurrPage.Update();
                            end else
                                exit;
                    end;
                }
                action("Registrar Hold Disable")
                {
                    Image = Open;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = RegistrarHoldVisible;
                    trigger OnAction()
                    Var
                        StudentStatusMangCod: Codeunit "Student Status Mangement";
                        StudentCount: Integer;
                    begin
                        CurrPage.SetSelectionFilter(StudentMasterCS);
                        StudentCount := StudentMasterCS.Count();
                        IF StudentCount > 1 then begin
                            IF CONFIRM(Text0017Lbl, FALSE) THEN BEGIN
                                IF StudentMasterCS.FindFirst() Then
                                    repeat
                                        StudentStatusMangCod.DisableRegistrarHold(Rec);
                                    until StudentMasterCS.next() = 0;
                                Message(Text0019Lbl);
                                CurrPage.Update();
                            end else
                                exit;
                        end else
                            IF CONFIRM(Text0018Lbl, FALSE, Rec."No.") THEN BEGIN
                                StudentStatusMangCod.DisableRegistrarHold(Rec);
                                Message(Text0020Lbl, Rec."No.");
                                CurrPage.Update();
                            end else
                                exit;
                    end;
                }
            }
            action("Immigration Hold Enable")
            {
                Caption = 'Student Services Hold Enable';
                Image = Closed;
                Visible = ImmigrationHoldVisible;
                ApplicationArea = All;
                PromotedCategory = Category7;
                Promoted = true;
                trigger OnAction()
                Var
                    StudentTimeLineRec: Record "Student Time Line";
                    StudentStatusMangCod: Codeunit "Student Status Mangement";
                    StudentCount: Integer;
                    Text0013Lbl: Label 'Do you want to enable the Student Services Hold for selected Students?';
                    Text0014Lbl: Label 'Do you want to enable the Student Services Hold for Student No. %1';
                    Text0015Lbl: Label 'Student Services Hold enabled for selected students.';
                    Text0016Lbl: Label 'Student Services Hold enabled for Student No. %1';
                begin
                    CurrPage.SetSelectionFilter(StudentMasterCS);
                    StudentCount := StudentMasterCS.Count();
                    IF StudentCount > 1 then begin
                        IF CONFIRM(Text0013Lbl, FALSE) THEN BEGIN
                            IF StudentMasterCS.FindFirst() Then
                                repeat
                                    StudentStatusMangCod.EnableAllHold(StudentMasterCS, HoldType::Immigration);
                                    StudentTimeLineRec.InsertRecordFun(StudentMasterCS."No.", StudentMasterCS."Student Name", 'Student Services Hold Enable', UserId(), Today());
                                until StudentMasterCS.next() = 0;
                            Message(Text0015Lbl);
                            CurrPage.Update();
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text0014Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::Immigration);
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Student Services Hold Enable', UserId(), Today());
                            Message(Text0016Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Immigration Hold Disable")
            {
                Caption = 'Student Services Hold Disable';
                Visible = ImmigrationHoldVisible;
                Image = SignUp;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category7;
                trigger OnAction()
                var
                    StudentMasterRec: record "Student Master-CS";
                    StudentTimeLineRec: Record "Student Time Line";
                    HoldCount: Integer;
                    Text001Lbl: Label 'Do you want to Disable the Student Services Hold for selected students?';
                    Text002Lbl: Label 'Do you want to Disable Student Services Hold for Student No. %1?';
                    Text003Lbl: Label 'Student Services Hold disabled for selected students.';
                    Text004Lbl: Label 'Student Services Hold disabled for Student No. %1?';
                begin
                    CurrPage.SetSelectionFilter(StudentMasterRec);
                    HoldCount := StudentMasterRec.Count();
                    IF HoldCount > 1 then begin
                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            IF StudentMasterRec.FindSet() then
                                repeat
                                    Rec.ImmigrationHoldSignoff(StudentMasterRec);
                                    StudentTimeLineRec.InsertRecordFun(StudentMasterRec."No.", StudentMasterRec."Student Name", 'Student Services Hold Disable', UserId(), Today());
                                until StudentMasterRec.Next() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        end else
                            exit
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."No.") THEN BEGIN
                            //ImmigrationHoldSignoff(Rec);//GMCSCOM
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Student Services Hold Disable', UserId(), Today());
                            Message(Text004Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Bursar Hold")
            {
                Image = Closed;
                Visible = BursarHoldVisible;
                ApplicationArea = All;
                PromotedCategory = Category8;
                Promoted = true;
                trigger OnAction()
                Var
                    StudentTimeLineRec: Record "Student Time Line";
                    StudentStatusMangCod: Codeunit "Student Status Mangement";
                    StudentCount: Integer;
                    Text0013Lbl: Label 'Do you want to enable the Bursar Hold for selected Students?';
                    Text0014Lbl: Label 'Do you want to enable the Bursar Hold for Student No. %1';
                    Text0015Lbl: Label 'Bursar Hold enabled for selected students.';
                    Text0016Lbl: Label 'Bursar Hold enabled for Student No. %1';
                begin
                    CurrPage.SetSelectionFilter(StudentMasterCS);
                    StudentCount := StudentMasterCS.Count();
                    IF StudentCount > 1 then begin
                        IF CONFIRM(Text0013Lbl, FALSE) THEN BEGIN
                            IF StudentMasterCS.FindFirst() Then
                                repeat
                                    StudentStatusMangCod.EnableAllHold(StudentMasterCS, HoldType::Bursar);
                                    StudentTimeLineRec.InsertRecordFun(StudentMasterCS."No.", StudentMasterCS."Student Name", 'Bursar Hold Enable', UserID(), Today());
                                until StudentMasterCS.next() = 0;
                            Message(Text0015Lbl);
                            CurrPage.Update();
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text0014Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::Bursar);
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Bursar Hold Enable', UserId(), Today());
                            Message(Text0016Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Bursar Signof")
            {
                Caption = '&Bursar Signoff';
                Visible = BursarHoldVisible;
                Image = SignUp;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category8;
                trigger OnAction()
                var
                    StudentMasterRec: record "Student Master-CS";
                    StudentTimeLineRec: Record "Student Time Line";
                    HoldCount: Integer;
                    Text001Lbl: Label 'Do you want to Disable the Bursar Hold for selected students?';
                    Text002Lbl: Label 'Do you want to Disable Bursar Hold for Student No. %1?';
                    Text003Lbl: Label 'Bursar Hold disabled for selected students.';
                    Text004Lbl: Label 'Bursar Hold disabled for Student No. %1?';
                begin
                    CurrPage.SetSelectionFilter(StudentMasterRec);
                    HoldCount := StudentMasterRec.Count();
                    IF HoldCount > 1 then begin
                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            IF StudentMasterRec.FindSet() then
                                repeat
                                    if Rec.BursarHoldCheck(StudentMasterRec."No.") = true then begin
                                        BursarSignof(StudentMasterRec);
                                        StudentTimeLineRec.InsertRecordFun(StudentMasterRec."No.", StudentMasterRec."Student Name", 'Bursar Hold Disable', UserId(), Today());
                                    end;
                                until StudentMasterRec.Next() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        end else
                            exit
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."No.") THEN BEGIN
                            if Rec.BursarHoldCheck(Rec."No.") = true then begin
                                BursarSignof(Rec);
                                StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Bursar Hold Disable', UserId(), Today());
                                Message(Text004Lbl, Rec."No.");
                                CurrPage.Update();
                            end;
                        end else
                            exit;
                end;
            }
            action("Financial AID Hold Eanble")
            {
                Image = Close;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = FinCourseHoldVisible;
                trigger OnAction()
                Var
                    StudentTimeLineRec: Record "Student Time Line";
                    StudentStatusMangCod: Codeunit "Student Status Mangement";
                    StudentCount: Integer;
                    Text0013Lbl: Label 'Do you want to enable the Financial AID Hold for selected Students?';
                    Text0014Lbl: Label 'Do you want to enable the Financial AID Hold for Student No. %1';
                    Text0015Lbl: Label 'Financial AID Hold enabled for selected students.';
                    Text0016Lbl: Label 'Financial AID Hold enabled for Student No. %1';
                begin
                    CurrPage.SetSelectionFilter(StudentMasterCS);
                    StudentCount := StudentMasterCS.Count();
                    IF StudentCount > 1 then begin
                        IF CONFIRM(Text0013Lbl, FALSE) THEN BEGIN
                            IF StudentMasterCS.FindFirst() Then
                                repeat
                                    StudentStatusMangCod.EnableAllHold(StudentMasterCS, HoldType::"Financial Aid");
                                    StudentTimeLineRec.InsertRecordFun(StudentMasterCS."No.", StudentMasterCS."Student Name", 'Financial Aid Hold Enable', UserId(), Today());
                                until StudentMasterCS.next() = 0;
                            Message(Text0015Lbl);
                            CurrPage.Update();
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text0014Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::"Financial Aid");
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Financial Aid Hold Enable', UserId(), Today());
                            Message(Text0016Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Financial Aid Hold Disable")
            {
                Caption = '&Financial Aid Hold Disable';
                ApplicationArea = All;
                Image = SignUp;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = FinCourseHoldVisible;
                trigger OnAction()
                var
                    StudentTimeLineRec: Record "Student Time Line";
                    StudentMasterRec: record "Student Master-CS";
                    HoldCount: Integer;
                    Text001Lbl: Label 'Do you want to Disable the Financial Aid Hold for selected students?';
                    Text002Lbl: Label 'Do you want to Disable Financial Aid Hold for Student No. %1?';
                    Text003Lbl: Label 'Financial Aid Hold disabled for selected students.';
                    Text004Lbl: Label 'Financial Aid Hold disabled for Student No. %1?';
                begin
                    CurrPage.SetSelectionFilter(StudentMasterRec);
                    HoldCount := StudentMasterRec.Count();
                    IF HoldCount > 1 then begin
                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            IF StudentMasterRec.FindSet() then
                                repeat
                                    Rec.FinancialAidSignoff(StudentMasterRec);
                                    StudentTimeLineRec.InsertRecordFun(StudentMasterRec."No.", StudentMasterRec."Student Name", 'Financial Aid Hold Disable', UserID(), Today());
                                until StudentMasterRec.Next() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        end else
                            exit
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."No.") THEN BEGIN
                            Rec.FinancialAidSignoff(Rec);
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Financial Aid Hold Disable', UserId(), Today());
                            Message(Text004Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Student Group")
            {
                Caption = 'Student Group';
                Image = EntriesList;
                ApplicationArea = All;

                RunObject = Page "Student Group";
                RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No."), Blocked = Filter(false);

            }
            action("Student Document")
            {
                Caption = 'Student Document';
                image = Account;
                ApplicationArea = All;
                RunObject = page "Student Document Attachment";
                RunPageLink = "Student No." = FIELD("No."), "Enrolment No." = field("Enrollment No.");

            }
            action("View/Update Notes")
            {
                ApplicationArea = All;
                Caption = 'View/Update Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField("No.");
                    TemplateType := TemplateType::Student;
                    GroupType := GroupType::Student;
                    ClinicalBaseAppSubscribe.ViewEditStudentNote(Rec."No.", Rec."No.", TemplateType, GroupType);
                end;
            }

            action("Add Attachment")
            {
                ApplicationArea = All;
                Caption = 'Add Attachment';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.SetRange("No.", Rec."No.");
                    Page.RunModal(Page::"Add Student Attachment", StudentMaster);
                end;
            }
        }
    }



    // area(navigation)
    // {
    //     action("Student Data Upload")
    //     {
    //         ApplicationArea = All;
    //         Caption = 'Student Data Upload';
    //         Promoted = true;
    //         PromotedCategory = Category4;
    //         RunObject = XMLport 50001;
    //     }
    //     action("Update Student Details")
    //     {
    //         ApplicationArea = ALl;
    //         Promoted = true;
    //         PromotedCategory = Category4;
    //         RunObject = XMLport 50002;
    //     }
    //     action("Send Data to Portal")
    //     {
    //         ApplicationArea = ALl;
    //         Promoted = true;
    //         PromotedCategory = Category4;
    //         trigger OnAction()
    //         var
    //             CallWebService: Codeunit WebServicesFunctionsCSL;
    //         begin
    //             //Code added for Call Sql Procedure to Send data to Portal Database::CSPL-00092::29-05-2019: Start
    //             //CSPL-00058 START
    //             CallWebService.Generate_Allocation_Grade_Markeup_Util(Format("Global Dimension 1 Code"));
    //             //CSPL-00058 END
    //             MESSAGE('Done Successfully');
    //             //Code added for Call Sql Procedure to Send data to Portal Database::CSPL-00092::29-05-2019: End
    //         end;
    //     }
    //     action("Page Student Wise Hold")
    //     {
    //         Caption = 'Student Wise H&old';
    //         ApplicationArea = All;
    //         Image = Ledger;
    //         Promoted = true;
    //         PromotedCategory = Category4;
    //         RunObject = Page "Student Wise Hold List";
    //                         RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);
    //                         RunPageView = SORTING("Student No.");
    //                         ShortCutKey = 'Ctrl+F8';
    //     }
    // }
    // area(Processing)
    // {
    //     action("Financial Aid Signoff")
    //     {
    //         Caption = '&Financial Aid Signoff';
    //         ApplicationArea = All;
    //         Promoted = true;
    //         PromotedOnly = true;
    //         PromotedCategory = Process;
    //         trigger OnAction()
    //         var
    //             StudentMasterRec: record "Student Master-CS";
    //             HoldCount: Integer;
    //             multiple: Boolean;
    //             Line: Integer;
    //         begin
    //             Line := 0;
    //             CurrPage.SetSelectionFilter(StudentMasterRec);
    //             IF StudentMasterRec.FindSet() then
    //                 HoldCount := StudentMasterRec.Count();
    //             repeat
    //                 Line += 1;
    //                 if Line > 1 then
    //                     multiple := true
    //                 else
    //                     multiple := false;
    //                 FinancialAidSignoff(StudentMasterRec, false, multiple, HoldCount)
    //             until StudentMasterRec.Next() = 0;
    //         end;
    //     }
    //     action("Bursar Signoff")
    //     {
    //         Caption = '&Bursar Signoff';
    //         ApplicationArea = All;
    //         Promoted = true;
    //         PromotedOnly = true;
    //         PromotedCategory = Process;
    //         trigger OnAction()
    //         var
    //             StudentMasterRec: record "Student Master-CS";
    //         begin
    //             CurrPage.SetSelectionFilter(StudentMasterRec);
    //             BursarSignoff(StudentMasterRec);
    //         end;
    //     }


    //     action("Legacy Ledger")
    //     {
    //         ApplicationArea = All;
    //         Promoted = true;
    //         PromotedOnly = true;
    //         PromotedCategory = Category5;
    //         RunObject = Page 50199;
    //                         RunPageLink = "Roll No." = FIELD("Enrollment No.");
    //     }
    //     action("Student Details Mentors Import")
    //     {
    //         ApplicationArea = All;
    //         Image = ListPage;
    //         Promoted = true;
    //         PromotedOnly = true;
    //         PromotedCategory = Process;
    //         RunObject = Page 50112;
    //     }
    //     action("Course Section")
    //     {
    //         ApplicationArea = All;
    //         Image = ListPage;
    //         Promoted = true;
    //         PromotedOnly = true;
    //         PromotedCategory = Process;
    //         RunObject = Page 50233;
    //     }
    //     action("FERPA Details")
    //     {
    //         ApplicationArea = All;
    //         Image = Card;
    //         Promoted = true;
    //         PromotedIsBig = true;
    //         PromotedCategory = Category4;
    //         RunObject = Page "FERPA Details List";
    //                         RunPageLink = "Student No." = FIELD("No."), "Academic Year" = field("Academic Year"),
    //                            Semester = field(Semester);
    //     }


    //     action("Not Completed Lower Semester(NCL)")
    //     {
    //         ApplicationArea = All;
    //         Image = Change;
    //         Promoted = true;
    //         PromotedOnly = true;
    //         PromotedIsBig = true;
    //         Visible = false;

    //         trigger OnAction()
    //         begin
    //             //Code added for Find and update Disability False for Student Not Completed Lower Semester(NCL) ::CSPL-00092::29-05-2019: Start
    //             IF CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN

    //                 //B.Tech
    //                 StudentMasterCS.Reset();
    //                 StudentMasterCS.SETRANGE(StudentMasterCS."Student Status", StudentMasterCS."Student Status"::Student);
    //                 StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
    //                 StudentMasterCS.SETFILTER(StudentMasterCS."Course Type", 'B.Tech');
    //                 StudentMasterCS.SETFILTER(StudentMasterCS.Semester, 'VIII');
    //                 IF StudentMasterCS.FINDSET() THEN BEGIN
    //                     REPEAT
    //                         StudentMasterCS.Disability := TRUE;
    //                         StudentMasterCS.Modify();
    //                     UNTIL StudentMasterCS.NEXT() = 0;
    //                 END;

    //                 //M.Tech
    //                 StudentMasterCS.Reset();
    //                 StudentMasterCS.SETRANGE(StudentMasterCS."Student Status", StudentMasterCS."Student Status"::Student);
    //                 StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
    //                 StudentMasterCS.SETFILTER(StudentMasterCS."Course Type", 'M.Tech');
    //                 StudentMasterCS.SETFILTER(StudentMasterCS.Semester, 'III & IV');
    //                 IF StudentMasterCS.FINDSET() THEN BEGIN
    //                     REPEAT
    //                         StudentMasterCS.Disability := TRUE;
    //                         StudentMasterCS.Modify();
    //                     UNTIL StudentMasterCS.NEXT() = 0;
    //                 END;

    //                 //MCA
    //                 StudentMasterCS.Reset();

    //                 StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
    //                 StudentMasterCS.SETFILTER(StudentMasterCS."Course Type", 'MCA');
    //                 StudentMasterCS.SETFILTER(StudentMasterCS.Semester, 'IV');
    //                 IF StudentMasterCS.FINDSET() THEN BEGIN
    //                     REPEAT
    //                         StudentMasterCS.Disability := TRUE;
    //                         StudentMasterCS.Modify();
    //                     UNTIL StudentMasterCS.NEXT() = 0;
    //                 END;

    //                 MESSAGE('Student NCL Boolean Updated');
    //             END ELSE BEGIN
    //                 EXIT;
    //             END;
    //             //Code added for Find and update Disability False for Student Not Completed Lower Semester(NCL)::CSPL-00092::29-05-2019: End
    //         end;
    //     }
    // }
    //    }


    trigger OnOpenPage()
    begin
        Bool := true;

        UserSetup.Get(UserId());
        If UserSetup."Global Dimension 1 Code" = '9100' then
            Bool := false;

        RoleAndPermission();
        RoleAndPermissionNew();

        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SetRange("Step 2 CK Exam Pass", true);
        Rec.FilterGroup(0);

        FinancialAid_GBoo := false;
        CourseHoldVisible := false;

        if CourseMaster.Get(Rec."Course Code") then
            if CourseMaster."Financial AID Applicable" then begin
                FinancialAid_GBoo := true;
                CourseHoldVisible := true;
            end;

        RegistrarHoldVisible := false;
        BursarHoldVisible := false;
        FinancialAIDHoldVisible := false;
        ImmigrationHoldVisible := false;
        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                RegistrarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            BursarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                BursarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            FinancialAIDHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                FinancialAIDHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Residential Services") then
            ImmigrationHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                ImmigrationHoldVisible := true;
        // end;
        if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
            FinCourseHoldVisible := true
        else
            FinCourseHoldVisible := false;
    end;

    trigger OnAfterGetRecord();
    begin
        FinancialAid_GBoo := false;
        CourseHoldVisible := false;

        if CourseMaster.Get(Rec."Course Code") then
            if CourseMaster."Financial AID Applicable" then begin
                FinancialAid_GBoo := true;
                CourseHoldVisible := true;
            end;

        RegistrarHoldVisible := false;
        RegistrarHoldVisible := false;
        BursarHoldVisible := false;
        FinancialAIDHoldVisible := false;
        ImmigrationHoldVisible := false;
        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                RegistrarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            BursarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                BursarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            FinancialAIDHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                FinancialAIDHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Residential Services") then
            ImmigrationHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                ImmigrationHoldVisible := true;
        //end;
        if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
            FinCourseHoldVisible := true
        else
            FinCourseHoldVisible := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Clear(Health);
        if Rec."Apply For Insurance" = true then
            Health := 'AUA'
        else
            Health := 'OWN';

        FinancialAid_GBoo := false;
        CourseHoldVisible := false;

        if CourseMaster.Get(Rec."Course Code") then
            if CourseMaster."Financial AID Applicable" then begin
                FinancialAid_GBoo := true;
                CourseHoldVisible := true;
            end;

        RegistrarHoldVisible := false;
        BursarHoldVisible := false;
        FinancialAIDHoldVisible := false;
        ImmigrationHoldVisible := false;
        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                RegistrarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            BursarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                BursarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            FinancialAIDHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                FinancialAIDHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Residential Services") then
            ImmigrationHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                ImmigrationHoldVisible := true;
        //   end;
        if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
            FinCourseHoldVisible := true
        else
            FinCourseHoldVisible := false;
    end;

    var
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentMasterCS: Record "Student Master-CS";
        UserSetup: Record "User Setup";
        CourseMaster: Record "Course Master-CS";
        usersetupapprover: Record "Document Approver Users";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
        StudentCount: Integer;
        Bool: Boolean;
        RegistrarHoldVisible: Boolean;
        BursarHoldVisible: Boolean;
        FinancialAIDHoldVisible: Boolean;
        ImmigrationHoldVisible: Boolean;
        FinCourseHoldVisible: Boolean;
        CourseHoldVisible: Boolean;
        FinancialAid_GBoo: Boolean;
        Text005Lbl: Label 'Do you want to change student group for selected students?';
        Text006Lbl: Label 'Do you want to change student group for Student No. %1?';
        Text007Lbl: Label 'The selected Students, group has been changed.';
        Text008Lbl: Label 'Student No. %1 group has been changed.';
        Text009Lbl: Label 'Do you want to map the course for selected students?';
        Text010Lbl: Label 'Do you want to map the course for Student No. %1?';
        Text011Lbl: Label 'The selected Students, course has been Mapped.';
        Text012Lbl: Label 'Student No. %1 course has been Mapped.';
        Text0013Lbl: Label 'Do you want to enable the Registrar Hold for selected Students?';
        Text0014Lbl: Label 'Do you want to enable the Registrar Hold for Student No. %1';
        Text0015Lbl: Label 'Registrar Hold enabled for selected students.';
        Text0016Lbl: Label 'Registrar Hold enabled for Student No. %1';
        Text0017Lbl: Label 'Do you want to disable the Registrar Hold for selected Students?';
        Text0018Lbl: Label 'Do you want to disable the Registrar Hold for Student No. %1';
        Text0019Lbl: Label 'Registrar Hold disabled for selected students.';
        Text0020Lbl: Label 'Registrar Hold disabled for Student No. %1';
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
        Balance: Boolean;
        Balance1: Boolean;
        Health: text[20];

    procedure BursarSignof(StudentRec: Record "Student Master-CS")
    Var
        HoldUserMappingRec: Record "Holds User Mapping";
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentHoldRec: Record "Student Hold";
        StudentMaster_lRec: Record "Student Master-CS";
        FinancialAIDRec: Record "Financial AID";
        RSL: Record "Roster Scheduling Line";
        HoldCount: Integer;
        Text003Lbl: Label 'Financial AID Application No. %1 is still pending for this student.';

    begin
        HoldUserMappingRec.Reset();
        HoldUserMappingRec.SetRange("User ID", UserId());
        if HoldUserMappingRec.FindFirst() then begin

            // if HousingHoldCheck(StudentRec."No.") = true then
            //     error('Housing Hold is still Enable.');
            // if CheckFeeGeneration(StudentRec."No.") = False then  (Block for Michael Bucher dated 14April2021)
            //     error('Fee is not Generated or all components of fee is not Generated');

            if Rec.FinancialAIDHoldCheck(StudentRec."No.") = true then begin
                FinancialAIDRec.Reset();
                FinancialAIDRec.SetRange("Student No.", StudentRec."No.");
                FinancialAIDRec.SetRange("Academic Year", StudentRec."Academic Year");
                FinancialAIDRec.SetRange(Semester, StudentRec.Semester);
                FinancialAIDRec.SetRange(Term, StudentRec.Term);
                FinancialAIDRec.SetFilter(FinancialAIDRec.Status, '%1', FinancialAIDRec.Status::"Pending for Approval");
                if FinancialAIDRec.FindFirst() then
                    Error(Text003Lbl, FinancialAIDRec."Application No.")
                else
                    Rec.FinancialAidWithBursarSignoff(StudentRec."No.");
            end;

            StudentMaster_lRec.Reset();
            StudentMaster_lRec.SetRange("Original Student No.", StudentRec."Original Student No.");
            If StudentMaster_lRec.FindSet() then begin
                Repeat
                    StudentHoldRec.Reset();
                    StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::Bursar);
                    IF StudentHoldRec.FindFirst() then begin
                        StudentWiseHoldRec.Reset();
                        StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Bursar);
                        if StudentWiseHoldRec.FINDFIRST() then begin
                            StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                            StudentWiseHoldRec."Hold Description" := StudentHoldRec."Signoff Description";
                            StudentWiseHoldRec.Modify();
                            RecCodeUnit50037.HoldStatusLedgerEntryInsert(StudentMaster_lRec."No.", StudentWiseHoldRec."Hold Code",
                        StudentWiseHoldRec."Hold Description", StudentWiseHoldRec."Hold Type"::Bursar, StudentWiseHoldRec.Status);
                            RSL.AutoPublishedRotation_On_CLN_Hold_Removed(StudentMaster_lRec);//CSPL-00307-RTP // As per Ajay 15-03-23
                        end;
                    end;
                until StudentMaster_lRec.Next() = 0;
            end;
            CurrPage.Update();
        end else
            Error('You do not have the permission to disable the Bursar Signoff');
    end;

    procedure RoleAndPermission()
    var
        UserSetupApproval: Record "Document Approver Users";
    begin
        Bool := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            Bool := false;

        FinancialAid1 := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            FinancialAid1 := false;

        if UserSetupApproval.Get(UserId(), UserSetupApproval."Department Approver Type"::"Financial Aid Department") then
            FinancialAid1 := true
        else
            if UserSetupApproval.Get(UserId(), UserSetupApproval."Department Approver Type"::" ") then
                FinancialAid1 := true
            else
                FinancialAid1 := false;

        AdmissionGroup := true;
        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::Admissions) then
            AdmissionGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                AdmissionGroup := true
            else
                AdmissionGroup := false;

        RegistrarGroup := true;
        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::"Registrar Department") then
            RegistrarGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                RegistrarGroup := true
            else
                RegistrarGroup := false;


        ClinicalDetailsGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            ClinicalDetailsGroup := false;

        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::"Clinical Details") then
            ClinicalDetailsGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                ClinicalDetailsGroup := true
            else
                ClinicalDetailsGroup := false;

        HousingGroup := true;
        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::"Residential Services") then
            HousingGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                HousingGroup := true
            else
                HousingGroup := false;

        BursarGroup := true;
        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::"Bursar Department") then
            BursarGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                BursarGroup := true
            else
                BursarGroup := false;

        EEDBasicSciGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            EEDBasicSciGroup := false;

        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::"EED Pre-Clinical") then
            EEDBasicSciGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                EEDBasicSciGroup := true
            else
                EEDBasicSciGroup := false;

        EEDClinicalGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            EEDClinicalGroup := false;

        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::"EED Clinical") then
            EEDClinicalGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                EEDClinicalGroup := true
            else
                EEDClinicalGroup := false;

        GraduateAffairsGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            GraduateAffairsGroup := false;

        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::"Graduate Affairs") then
            GraduateAffairsGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                GraduateAffairsGroup := true
            else
                GraduateAffairsGroup := false;

        ExaminationGroup := true;
        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::"Graduate Affairs") then
            ExaminationGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                ExaminationGroup := true
            else
                ExaminationGroup := false;

        GraduationGroup := true;
        if UserSetupApproval.get(userid(), UserSetupApproval."Department Approver Type"::Graduation) then
            GraduationGroup := true
        else
            if UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::" ") then
                GraduationGroup := true
            else
                GraduationGroup := false;


    end;

    procedure RoleAndPermissionNew()
    var
        UserSetupApprover: Record "Document Approver Users";
    begin
        Balance := true;
        Balance1 := true;
        usersetupapprover.Reset();
        usersetupapprover.setrange("User ID", UserId);
        if usersetupapprover.FindFirst() then begin
            if (usersetupapprover."Department Approver Type" IN [usersetupapprover."Department Approver Type"::"Financial Aid Department", usersetupapprover."Department Approver Type"::" ",
                                                                usersetupapprover."Department Approver Type"::BackOffice, usersetupapprover."Department Approver Type"::"Bursar Department"]) then begin
                Balance := true;
                Balance1 := false;
            end else begin
                Balance := false;
                Balance1 := true;
            end;
        end;
    end;

}


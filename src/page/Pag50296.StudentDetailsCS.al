page 50296 "Student Details-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                             Remarks
    // 1         CSPL-00092    29-05-2019    <Action1102155025> - OnAction                       Page Run
    // 2         CSPL-00092    29-05-2019    Student Data Upload - OnAction                      XMLPort Run
    // 3         CSPL-00092    29-05-2019    Update Student Details - OnAction                   XMLPort Run
    // 4         CSPL-00092    29-05-2019    Send Data to Portal - OnAction                      Call Sql Procedure to Send data to Portal Database
    // 5         CSPL-00092    29-05-2019    Not Completed Lower Semester(NCL) - OnAction        Find and update Disability False for Student Not Completed Lower Semester(NCL)

    Caption = 'Student List';
    CardPageID = "Student Detail Card-CS";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate,Admissions,Registrar/Academics,Clinical,Student Services,Bursar/Finance,Financial Aid,EED Pre-Clinical,EED Clinical Science,Graduate Affairs,Feedback,OLR Finance';
    SourceTable = "Student Master-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

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
                field("OLR Finance Hold"; Rec."OLR Finance Hold")
                {
                    ApplicationArea = all;
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
                // field(Health; Rec.Health)
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
                field("Lease Agreement"; Rec."Lease Agreement")
                {
                    ApplicationArea = all;
                }
                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = all;
                }
                field("OLR Completed Date"; Rec."OLR Completed Date")
                {
                    ApplicationArea = all;
                }
                field("Student On-Ground Group"; Rec."Student Group")
                {
                    ApplicationArea = all;
                    Caption = 'Student On-Ground Group';
                }
                field("On Ground Check-In Complete On"; Rec."On Ground Check-In Complete On")
                {
                    ApplicationArea = all;
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
                    // Visible = Balance;
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
                    //Visible = Balance1;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                    Visible = Balance1;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    //Visible = Balance1;
                }



                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                Field("Institute Name"; Rec."Institute Name")
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
                field("Bursar Holds"; Rec."Bursar Hold")
                {
                    ApplicationArea = All;
                }
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
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                    Visible = Social;
                    Caption = 'Social Security No.';

                }

                field("Social Security No"; SocialSecurity)
                {
                    ApplicationArea = All;
                    Visible = SocialSec;
                    Editable = false;
                    Caption = 'Social Security No.';
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
            // part("Group FactBox"; "Group FactBox")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Student No." = FIELD("No.");
            // }
            // part("Student QRCode1"; "Student QRCode")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "No." = FIELD("No.");
            // }
            systempart(Links; Links)
            {

            }
            systempart(Notes; Notes)
            {

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
                            // trigger OnAction()
                            // var
                            //     EnrollmentHistoryRec: Record "Enrollment History";
                            //     EnrollmentHistoryPag: Page "Enrollment History List";
                            // begin
                            //     EnrollmentHistoryRec.Reset();
                            //     EnrollmentHistoryRec.Setrange("Student No.", Rec."No.");
                            //     Clear(EnrollmentHistoryPag);
                            //     EnrollmentHistoryPag.SetTableView(EnrollmentHistoryRec);
                            //     if Rec."Entry From Salesforce" then begin
                            //         EnrollmentHistoryPag.Editable := false;
                            //         EnrollmentHistoryPag.Run();
                            //     end else begin
                            //         EnrollmentHistoryPag.Editable := true;
                            //         EnrollmentHistoryPag.Run();
                            //     end;
                            // end;
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

                            trigger OnAction()
                            var
                                HousingAppRec: Record "Housing Application";
                                HousingAppPag: Page "Housing Application List";
                            begin
                                HousingAppRec.Reset();
                                HousingAppRec.SetCurrentKey("Created On");
                                HousingAppRec.SetRange("Student No.", Rec."No.");

                                HousingAppPag.SetTableView(HousingAppRec);
                                HousingAppPag.Run();

                            end;
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester);
                        }
                        action("Pending Housing Wavier Application Details")
                        {
                            Caption = 'Pending Housing Wavier Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            trigger OnAction()
                            var
                                OptOutRec: Record "Opt Out";
                                HousingWaiverPag: Page "Housing Wavier PendingApproval";
                            begin
                                OptOutRec.Reset();
                                OptOutRec.SetCurrentKey("Created On");
                                OptOutRec.SetRange("Student No.", Rec."No.");

                                HousingWaiverPag.SetTableView(OptOutRec);
                                HousingWaiverPag.Run();

                            end;
                            // RunObject = Page "Housing Wavier PendingApproval";
                            // RunPageLink = "Student No." = FIELD("No.");
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
                            // RunObject = Page "Posted Housing Application";
                            // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);
                            trigger OnAction()
                            var
                                HousingAppRec: Record "Housing Application";
                                HousingAppPag: Page "Posted Housing Application";
                            begin
                                HousingAppRec.Reset();
                                HousingAppRec.SetCurrentKey("Created On");
                                HousingAppRec.SetRange("Student No.", Rec."No.");

                                HousingAppPag.SetTableView(HousingAppRec);
                                HousingAppPag.Run();

                            end;
                        }
                        action("Approved/Rejected Housing Waiver")
                        {
                            Caption = 'Approved/Rejected Housing Waiver List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            trigger OnAction()
                            var
                                OptOutRec: Record "Opt Out";
                                HousingWaiverPag: Page "Housing Wavier Approved List";
                            begin
                                OptOutRec.Reset();
                                OptOutRec.SetCurrentKey("Created On");
                                OptOutRec.SetRange("Student No.", Rec."No.");

                                HousingWaiverPag.SetTableView(OptOutRec);
                                HousingWaiverPag.Run();

                            end;
                            // RunObject = Page "Housing Wavier Approved List";
                            // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);

                        }
                    }

                }

                group("Registrar/Academics")
                {
                    Visible = RegistrarGroup;
                    group(OLR)
                    {
                        Caption = 'OLR';
                        Action("Send back to Dashboard")
                        {
                            Image = NewCustomer;
                            trigger OnAction()
                            var
                                StatusChangeLog: Record "Status Change Log entry";
                                DepartmentApprover: Record "Document Approver Users";
                                StudentTimeLine: Record "Student time line";
                            Begin

                                DepartmentApprover.Reset();
                                DepartmentApprover.Setrange("User ID", UserId());
                                DepartmentApprover.SetRange("Department Approver Type", DepartmentApprover."Department Approver Type"::"Registrar Department");
                                IF not DepartmentApprover.FindFirst() then
                                    Error('You do not have permission to perform this activity!');

                                IF not confirm('Do you want to show dashboard on Student Portal?', False) then
                                    Exit;

                                StatusChangeLog.Reset();
                                StatusChangeLog.Setrange("Student No.", Rec."No.");
                                StatusChangeLog.Setrange("Status Change to", 'ENR');
                                IF StatusChangeLog.FindLast() then
                                    Rec.Validate(Status, StatusChangeLog."Status change From");

                                Rec."Registrar Signoff" := True;
                                Rec.Modify();

                                StudentTimeLine.InsertRecordFun(Rec."No.", Rec."Student Name", 'Send back to dashboard has been performed by ' + USerID(), UserID(), Today());
                            End;
                        }
                        Action("Send Back to OLR")
                        {
                            Image = NewCustomer;
                            Trigger OnAction()
                            Var

                                HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
                            Begin

                                USerSetupApprover.Reset();
                                USerSetupApprover.Setrange("User ID", USerID());
                                USerSetupApprover.Setrange("Department Approver Type", usersetupapprover."Department Approver Type"::"Registrar Department");
                                USerSetupApprover.Findfirst();

                                Rec.Testfield("Registrar SignOff", False);

                                If not Confirm('Do you want to clear Student OLR Information?', False) then
                                    Exit;
                                Rec.Validate(Status, 'ENR');
                                Rec."OLR Completed" := False;
                                Rec."OLR Completed Date" := 0D;
                                If Rec."Student Group" = Rec."Student Group"::"On-Ground Check-In" then
                                    HoldUpdate_lCU.OnGroundCheckInStudentGroupDisable(Rec."No.");
                                If Rec."Student Group" = Rec."Student Group"::"On-Ground Check-In Completed" then
                                    HoldUpdate_lCU.OnGroundCheckInCompletedGroupDisable(Rec."No.");
                                Rec."Student Group" := Rec."Student Group"::" ";
                                Rec."On Ground Check-In By" := '';
                                Rec."On Ground Check-In On" := 0D;
                                Rec."On Ground Check-In Complete By" := '';
                                Rec."On Ground Check-In Complete On" := 0D;
                                Rec.Modify();
                            End;
                        }
                        action("Student Registration Details")
                        {
                            Caption = 'Student Registration Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            trigger OnAction()
                            var
                                StudentRegistrationRec: Record "Student Registration-CS";
                                StudentRegistrationlistPag: Page "Student Registration list";
                            begin
                                StudentRegistrationRec.Reset();
                                StudentRegistrationRec.SetCurrentKey("Created On");
                                StudentRegistrationRec.SetRange("Student No", Rec."No.");

                                StudentRegistrationlistPag.SetTableView(StudentRegistrationRec);
                                StudentRegistrationlistPag.Run();

                            end;

                            // RunObject = Page "Student Registration list";
                            // RunPageLink = "Student No" = FIELD("No."), "Academic Year" = field("Academic Year"),
                            //        Semester = field(Semester);
                        }
                        action("FERPA Details")
                        {
                            Caption = 'FERPA Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            Visible = HideFerpaDetail;
                            trigger OnAction()
                            var
                                FerpaRec: Record "FERPA Details";
                                FerpaPag: Page "FERPA Details List";
                            begin
                                FerpaRec.Reset();
                                FerpaRec.SetCurrentKey("Created On");
                                FerpaRec.SetRange("Student No.", Rec."No.");
                                //If FerpaRec.FindLast() then begin
                                FerpaPag.SetTableView(FerpaRec);
                                FerpaPag.Run();
                                //end;
                            end;
                            // RunObject = Page "FERPA Details List";
                            // RunPageLink = "Student No." = FIELD("No."), Rec."Academic Year" = field("Academic Year"),
                            //        Semester = field(Semester);
                        }
                        action("FERPA Details_I")
                        {
                            Caption = 'FERPA Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            Visible = ShowFerpaDetail;
                            trigger OnAction()
                            var
                                FerpaRec: Record "FERPA Details";
                                FerpaPag: Page "FERPA Details Lists";
                            begin
                                FerpaRec.Reset();
                                FerpaRec.SetCurrentKey("Created On");
                                FerpaRec.SetRange("Student No.", Rec."No.");
                                FerpaPag.SetTableView(FerpaRec);
                                FerpaPag.Run();
                                // end;
                            end;
                            // RunObject = Page "FERPA Details List";
                            // RunPageLink = "Student No." = FIELD("No."), Rec."Academic Year" = field("Academic Year"),
                            //        Semester = field(Semester);
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
                            RunPageLink = "Signatory/User ID" = Field("No.");
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
                                    RecStudentMaster.SetRange("No.", Rec."No.");
                                    IF RecStudentMaster.FindFirst() then begin
                                        Report.Run(Report::"AICASA IDCard", true, false, RecStudentMaster);
                                    end;
                                end;
                                // RunObject = Report "AUA Basic Science IDCard";
                                if Rec."Global Dimension 1 Code" = '9000' then begin
                                    if (Rec.Semester = 'MED1') or (Rec.Semester = 'MED2') or (Rec.Semester = 'MED3') or (Rec.Semester = 'MED4') then begin
                                        RecStudentMaster.Reset();
                                        RecStudentMaster.SetRange("No.", Rec."No.");
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
                                    Rec.GenerateBarCodeNew(Rec);
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

                            trigger OnAction()
                            var
                                HousingAppRec: Record "Housing Application";
                                HousingAppPag: Page "Housing Application List";
                            begin
                                HousingAppRec.Reset();
                                HousingAppRec.SetCurrentKey("Created On");
                                HousingAppRec.SetRange("Student No.", Rec."No.");
                                If HousingAppRec.FindLast() then begin
                                    HousingAppPag.SetTableView(HousingAppRec);
                                    HousingAppPag.Run();
                                end;
                            end;

                            // RunObject = Page "Housing Application List";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester);
                        }

                        action("Pending Housing Wavier Application")
                        {
                            Caption = 'Pending Housing Wavier Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            trigger OnAction()
                            var
                                OptOutRec: Record "Opt Out";
                                HousingWaiverPag: Page "Housing Wavier PendingApproval";
                            begin
                                OptOutRec.Reset();
                                OptOutRec.SetCurrentKey("Created On");
                                OptOutRec.SetRange("Student No.", Rec."No.");
                                If OptOutRec.FindLast() then begin
                                    HousingWaiverPag.SetTableView(OptOutRec);
                                    HousingWaiverPag.Run();
                                end;
                            end;

                            // RunObject = Page "Housing Wavier PendingApproval";
                            // RunPageLink = "Student No." = FIELD("No.");
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
                            //RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                            RunPageLink = "Student No." = field("No.");
                            RunPageView = SORTING("Student No.");
                            ShortCutKey = 'Ctrl+F8';
                        }

                        action("Student Hold Ledger")
                        {
                            Caption = 'Student Hold Ledger';
                            ApplicationArea = All;
                            Image = Ledger;
                            RunObject = Page "Hold Status Ledger List";
                            RunPageLink = "Student No." = field("No.");
                            // RunPageView = SORTING("Student No.");//GMCSCOM
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

                        action("E-Mail Notification List")
                        {
                            Caption = 'E-Mail Notification List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            Trigger OnAction()
                            var
                                EmailnotificationRec: Record "Email Notification";
                                EmailNotificationPage: Page "E-Mail Notification List";
                            Begin
                                Clear(EmailNotificationPage);
                                EmailnotificationRec.Reset();
                                EmailnotificationRec.Setfilter(ReceiverId, Rec."Original Student No." + '*');
                                EmailNotificationPage.SetTableView(EmailnotificationRec);
                                EmailNotificationPage.Run();
                            End;
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

                        Action("Student Advisor Details")
                        {
                            Caption = 'Student Advisor Details';
                            Image = List;
                            ApplicationArea = All;
                            RunObject = Page "Student Advisor Detail";
                            RunPageLink = "Student No." = field("No.");
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
                                StudentMaster.SetRange("No.", Rec."No.");
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

                    group("Student TranscriptsR1")
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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsPrint2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official Transcripts1")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial Transcripts1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsPrint3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official Transcripts3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial Transcripts2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsPrint5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official Transcripts5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts4(Rec);
                            End;
                        }
                        action("Unofficial Transcripts5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsPrint6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official Transcripts6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }
                    group("Legacy Data1")
                    {
                        Caption = 'Legacy Data';
                        action("Inter Log Entry_")
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
                        RunObject = Page "Group Code(Elective) List-CS";
                        RunPageLink = "Student No." = field("No.");
                        RunPageMode = View;
                        // trigger OnAction()
                        // var
                        //     RSL: Record "Roster Scheduling Line";
                        // begin
                        //     RSL.Reset();
                        //     RSL.SetCurrentKey("Student No.", "Start Date");
                        //     RSL.FilterGroup(2);
                        //     RSL.SetRange("Student No.", "No.");
                        //     //RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Core);
                        //     RSL.FilterGroup(2);
                        //     Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        // end;
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
                    action("Student Hold Leader")
                    { //CSPL-00307 // 18-10-21
                        Caption = 'Student Hold Leader';
                        image = Account;
                        ApplicationArea = All;
                        RunObject = page "Hold Status Ledger List";
                        RunPageLink = "Student No." = FIELD("No.");
                    }
                    action("Put on Clinical Hold")
                    {
                        ApplicationArea = All;
                        Caption = 'Put on Clinical Hold';
                        Image = Holiday;
                        // Promoted = true;
                        // PromotedCategory = Process;
                        // PromotedOnly = true;

                        trigger OnAction()
                        var
                            StudentMaster: Record "Student Master-CS";
                        begin
                            StudentMaster.Reset();
                            StudentMaster.FilterGroup(2);
                            StudentMaster.SetRange("No.", Rec."No.");
                            StudentMaster.FilterGroup(0);
                            Page.RunModal(Page::"Clinical Hold Reason Input", StudentMaster);
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
                    Action("Email Notification List")
                    {
                        ApplicationArea = All;
                        Trigger OnAction()
                        var
                            EmailnotificationRec: Record "Email Notification";
                            EmailNotificationPage: Page "E-Mail Notification List";
                        Begin
                            Clear(EmailNotificationPage);
                            EmailnotificationRec.Reset();
                            EmailnotificationRec.Setfilter(ReceiverId, Rec."Original Student No." + '*');
                            EmailnotificationRec.SetFilter(Subject, '*Housing*');
                            EmailNotificationPage.SetTableView(EmailnotificationRec);
                            EmailNotificationPage.Run();
                        End;
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

                            trigger OnAction()
                            var
                                HousingAppRec: Record "Housing Application";
                                HousingAppPag: Page "Housing Application List";
                            begin
                                HousingAppRec.Reset();
                                HousingAppRec.SetCurrentKey("Created On");
                                HousingAppRec.SetRange("Student No.", Rec."No.");
                                If HousingAppRec.FindLast() then begin
                                    HousingAppPag.SetTableView(HousingAppRec);
                                    HousingAppPag.Run();
                                end;
                            end;
                            // RunObject = Page "Housing Application List";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester);
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
                    Action("Student Legacy Ledger")
                    {
                        Caption = 'Student Legacy Ledger';
                        Image = List;
                        ApplicationArea = All;
                        RunObject = Page "Studen Legacy Ledger";
                        RunPageLink = "Student Number" = Field("Original Student No.");
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
                        trigger OnAction()
                        var
                            StudentRegistrationRec: Record "Student Registration-CS";
                            StudentRegistrationlistPag: Page "Student Registration list";
                        begin
                            StudentRegistrationRec.Reset();
                            StudentRegistrationRec.SetCurrentKey("Created On");
                            StudentRegistrationRec.SetRange("Student No", Rec."No.");
                            If StudentRegistrationRec.FindLast() then begin
                                StudentRegistrationlistPag.SetTableView(StudentRegistrationRec);
                                StudentRegistrationlistPag.Run();
                            end;
                        end;
                        // RunObject = Page "Student Registration list";
                        // RunPageLink = "Student No" = FIELD("No.");

                    }
                    group(" Pending Applications")
                    {
                        action("Pending Financial Aid Application")
                        {
                            Caption = 'Pending Financial Aid Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            trigger OnAction()
                            var
                                FinAIDRec: Record "Financial AID";
                                FinancialAidPag: Page "Financial AID Pending List";
                            begin
                                FinAIDRec.Reset();
                                FinAIDRec.SetCurrentKey("Created On");
                                FinAIDRec.SetRange("Student No.", Rec."No.");
                                If FinAIDRec.FindLast() then begin
                                    FinancialAidPag.SetTableView(FinAIDRec);
                                    FinancialAidPag.Run();
                                end;
                            end;
                            // RunObject = Page "Financial AID Pending List";
                            // RunPageLink = "Student No." = FIELD("No.");

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
                        Visible = FinancialAid_GBoo;
                        //Promoted = true;
                        //PromotedCategory = Category9;
                        trigger OnAction()
                        begin
                            Rec.FinancialAidSignoff(Rec);
                        end;
                    }
                    group("SFP Update")

                    {
                        action("Student Initiation")
                        {
                            Image = Close;
                            ApplicationArea = All;
                            // Promoted = true;
                            // PromotedCategory = Category5;
                            trigger OnAction()
                            Var
                                WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
                                StudentCount: Integer;
                            begin
                                CurrPage.SetSelectionFilter(StudentMasterCS);
                                StudentCount := StudentMasterCS.Count();
                                IF StudentCount > 1 then begin
                                    IF CONFIRM(Text0021Lbl, FALSE) THEN BEGIN
                                        IF StudentMasterCS.FindFirst() Then
                                            repeat
                                                WebServicesFunctionsCod.SAFI_Student_InitiationFunction(StudentMasterCS."No.");
                                            until StudentMasterCS.next() = 0;
                                        Message(Text0023Lbl);
                                        CurrPage.Update();
                                    end else
                                        exit;
                                end else
                                    IF CONFIRM(Text0022Lbl, FALSE, Rec."No.") THEN BEGIN
                                        WebServicesFunctionsCod.SAFI_Student_InitiationFunction(Rec."No.");
                                        Message(Text0024Lbl, Rec."No.");
                                        CurrPage.Update();
                                    end else
                                        exit;
                            end;
                        }
                        action("SAFI Event")
                        {
                            Image = Close;
                            ApplicationArea = All;
                            // Promoted = true;
                            // PromotedCategory = Category5;
                            trigger OnAction()
                            Var
                                WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
                                StudentCount: Integer;
                            begin
                                CurrPage.SetSelectionFilter(StudentMasterCS);
                                StudentCount := StudentMasterCS.Count();
                                IF StudentCount > 1 then begin
                                    IF CONFIRM(Text0025Lbl, FALSE) THEN BEGIN
                                        IF StudentMasterCS.FindFirst() Then
                                            repeat
                                                WebServicesFunctionsCod.SAFI_Student_EventFunction(StudentMasterCS."No.", StudentMasterCS.Semester, StudentMasterCS."Original Student No.");
                                            until StudentMasterCS.next() = 0;
                                        Message(Text0027Lbl);
                                        CurrPage.Update();
                                    end else
                                        exit;
                                end else
                                    IF CONFIRM(Text0026Lbl, FALSE, Rec."No.") THEN BEGIN
                                        WebServicesFunctionsCod.SAFI_Student_EventFunction(Rec."No.", Rec.Semester, Rec."Original Student No.");
                                        Message(Text0028Lbl, Rec."No.");
                                        CurrPage.Update();
                                    end else
                                        exit;
                            end;
                        }
                        action("SAFI Event Live")
                        {
                            Image = Close;
                            ApplicationArea = All;
                            Visible = False;
                            // Promoted = true;
                            // PromotedCategory = Category5;
                            trigger OnAction()
                            Var
                                WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
                                StudentCount: Integer;
                            begin
                                CurrPage.SetSelectionFilter(StudentMasterCS);
                                StudentCount := StudentMasterCS.Count();
                                IF StudentCount > 1 then begin
                                    IF CONFIRM(Text0025Lbl, FALSE) THEN BEGIN
                                        IF StudentMasterCS.FindFirst() Then
                                            repeat
                                            // WebServicesFunctionsCod.SAFI_Student_EventFunctionLive(StudentMasterCS."No.", StudentMasterCS.Semester);
                                            until StudentMasterCS.next() = 0;
                                        Message(Text0027Lbl);
                                        CurrPage.Update();
                                    end else
                                        exit;
                                end else
                                    IF CONFIRM(Text0026Lbl, FALSE, Rec."No.") THEN BEGIN
                                        // WebServicesFunctionsCod.SAFI_Student_EventFunctionLive(Rec."No.", Rec.Semester);
                                        Message(Text0028Lbl, Rec."No.");
                                        CurrPage.Update();
                                    end else
                                        exit;
                            end;
                        }
                    }
                    Action("Student Legacy Ledger 12")
                    {
                        Caption = 'Student Legacy Ledger';
                        Image = List;
                        ApplicationArea = All;
                        RunObject = Page "Studen Legacy Ledger";
                        RunPageLink = "Student Number" = Field("Original Student No.");
                    }
                    Action("Rotation Ledger Entry")
                    {
                        Caption = 'Rotation Ledger Entry';
                        Image = List;
                        ApplicationArea = All;
                        Visible = false;    //Moved to Academics
                        RunObject = Page "Roster Ledger Entries";
                        RunPageLink = "Student ID" = field("Original Student No.");

                    }
                    action("List of Rotations FA")
                    {
                        Caption = 'List of Rotation(s)';
                        Image = EntriesList;
                        ApplicationArea = All;
                        // RunObject = Page "Roster Scheduling Lines";
                        // RunPageLink = "Student No." = field("No.");
                        // RunPageView = sorting("Start Date", Rec."Rotation ID") Order(ascending);
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
                    action("FERPA DetailF")
                    {
                        Caption = 'FERPA Details';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;
                        trigger OnAction()
                        var
                            FerpaRec: Record "FERPA Details";
                            FerpaPag: Page "FERPA Details List";
                        begin
                            FerpaRec.Reset();
                            FerpaRec.SetCurrentKey("Created On");
                            FerpaRec.SetRange("Student No.", Rec."No.");
                            //If FerpaRec.FindLast() then begin
                            FerpaPag.SetTableView(FerpaRec);
                            FerpaPag.Run();
                            //end;
                        end;

                        // RunObject = Page "FERPA Details List";
                        // RunPageLink = "Student No." = FIELD("No.");
                    }
                    action("&Student Subjet Fi")
                    {
                        Caption = '&Student Subject';
                        image = GanttChart;
                        ApplicationArea = All;
                        Visible = false;    //Moved to Academics
                        RunObject = Page "Subject Student-CS";
                        RunPageLink = "Original student No." = field("Original Student No.");

                    }
                    action("E-Mail Notification ListFA")
                    {
                        Caption = 'E-Mail Notification List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Trigger OnAction()
                        var
                            EmailnotificationRec: Record "Email Notification";
                            EmailNotificationPage: Page "E-Mail Notification List";
                        Begin
                            Clear(EmailNotificationPage);
                            EmailnotificationRec.Reset();
                            EmailnotificationRec.Setfilter(ReceiverId, Rec."Original Student No." + '*');
                            EmailnotificationRec.SetFilter(Subject, '*AUA Login Credentials*');
                            EmailNotificationPage.SetTableView(EmailnotificationRec);
                            EmailNotificationPage.Run();
                        End;
                    }

                    group("Student TranscriptsA1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptAsPrint1")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }

                    group("Academics")
                    {

                        action("Semester GPA Details_")
                        {
                            Caption = 'Semester GPA Details';
                            Image = Calculate;
                            ApplicationArea = All;
                            Visible = false;
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
                            Visible = false;
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
                            Visible = false;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Stud Promotion List")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            Visible = false;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        Action("Rotation Ledger Entry ")
                        {
                            Caption = 'Rotation Ledger Entry';
                            Image = List;
                            ApplicationArea = All;
                            RunObject = Page "Roster Ledger Entries";
                            RunPageLink = "Student ID" = field("Original Student No.");

                        }
                        action("&Student Subjet Fi ")
                        {
                            Caption = '&Student Subject';
                            image = GanttChart;
                            ApplicationArea = All;
                            RunObject = Page "Subject Student-CS";
                            RunPageLink = "Original student No." = field("Original Student No.");

                        }
                        action("Inter Log Entry")
                        {
                            Caption = 'Interaction Log Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                    }
                    group("Pending Application")
                    {
                        action("Pending Financial Aid Details")
                        {
                            Caption = 'Pending Financial Aid Details';
                            Visible = FinancialAid_GBoo;
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "Financial AID Pending List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);


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
                            Visible = FinancialAid_GBoo;
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "FinancialAIDApprovRejectList";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

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
                    action("Student EED Pre-Clinical Advisor")
                    {
                        Caption = 'Student EED Pre-Clinical Advisor';
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
                    // action("Internal Exam Published List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Image = EntriesList;
                    //     RunObject = page "Internal Exam Published List";//50984
                    // }
                    // action("External Exam Published List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Image = EntriesList;
                    //     RunObject = page "External Exam Published List";//50985
                    // }
                    action("Internal Exam List")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = page "Student Subject Exam List";//50956
                        RunPageLink = "Original Student No." = Field("Original Student No."), "Level Description" = filter("Internal Exam Component");
                        RunPageMode = View;

                    }
                    action("External Exam List")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = page "Student Subject Exam List";//50956
                        RunPageLink = "Original Student No." = Field("Original Student No."), "Level Description" = filter("External Examination");
                        RunPageMode = View;
                    }
                    action("Student Subject Exams List EEDBS")
                    {
                        Caption = 'Student Subject Exams';
                        Image = List;
                        ApplicationArea = All;
                        RunObject = Page "Student Subject Exam List";
                        RunPageLink = "ORiginal student No." = field("Original Student No.");

                    }
                    action("Sudent Subject Grade Book List")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = EntriesList;
                        RunObject = Page StudentSubjectGradeBookList;
                        RunPageLink = "Student No." = FIELD("No.");
                    }
                    action("&Student Subjet EEDBS")
                    {
                        Caption = '&Student Subject';
                        image = GanttChart;
                        ApplicationArea = All;

                        RunObject = Page "Subject Student-CS";
                        RunPageLink = "ORiginal student No." = field("Original Student No.");

                    }
                    action("Enrolment History List EEDBS")
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
                    action("Student Educational Qualification details EEDBS")
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
                    Action("Student Notes")
                    {
                        ApplicationArea = all;
                        Image = EntriesList;
                        RunObject = Page "Student Notes List";
                        RunPageLink = "Student No." = FIELD("No.");
                    }

                    group("Student TranscriptsEEDPCPrint1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        // Visible = false;
                        action("Unofficial TranscriptsEEDPC")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        // Visible = false;
                        action("Unofficial TranscriptsEEDPCPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        // Visible = false;
                        action("Unofficial TranscriptsEEDPCPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        // Visible = false;
                        action("Unofficial TranscriptsEEDPCPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        // Visible = false;
                        action("Unofficial TranscriptsEEDPCPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        // Visible = false;
                        action("Unofficial TranscriptsEEDPCPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }


                    group("Academics ")
                    {
                        Visible = false;
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
                        Visible = false;
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
                    action("Pending Advising Request")
                    {
                        Caption = 'Pending Advising Request';
                        image = PostApplication;
                        ApplicationArea = All;
                        RunObject = page "Advising Request List";
                        RunPageLink = "Student No." = field("No.");


                    }
                    action("Approved Advising Request")
                    {
                        Caption = 'Approved Advising Request';
                        image = PostApplication;
                        ApplicationArea = All;
                        RunObject = Page "App. Resch. Advs. Request List";
                        RunPageLink = "Student No." = field("No.");

                    }
                    action("Completed Advising Request")
                    {
                        Caption = 'Completed Advising Request';
                        image = PostApplication;
                        ApplicationArea = All;
                        RunObject = Page "Rejc. Comp. Advis. Req. List";
                        RunPageLink = "Student No." = field("No.");
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

                        action("&Student Subjet EEDC")
                        {
                            Caption = '&Student Subject';
                            image = GanttChart;
                            ApplicationArea = All;

                            RunObject = Page "Subject Student-CS";
                            RunPageLink = "ORiginal student No." = field("Original Student No.");

                        }
                        action("Student Subject Exams List EEDC")
                        {
                            Caption = 'Student Subject Exams';
                            Image = List;
                            ApplicationArea = All;
                            RunObject = Page "Student Subject Exam List";
                            RunPageLink = "ORiginal student No." = field("Original Student No.");

                        }
                        action("FERPA Details EEDC")
                        {
                            Caption = 'FERPA Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            trigger OnAction()
                            var
                                FerpaRec: Record "FERPA Details";
                                FerpaPag: Page "FERPA Details List";
                            begin
                                FerpaRec.Reset();
                                FerpaRec.SetCurrentKey("Created On");
                                FerpaRec.SetRange("Student No.", Rec."No.");
                                FerpaPag.SetTableView(FerpaRec);
                                FerpaPag.Run();
                            end;
                        }

                        action("Roster Ledger Entries EEDC")
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

                        action("List of Rotations EEDC")
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

                        action("Student Residency Status EEDC")
                        {
                            Caption = 'Student Residency Status';
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "Residency List";
                            RunPageLink = "Student No." = field("No.");
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
                    group("Student TranscriptsB1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptBsPrint1")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
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


                    group("Student TranscriptsD1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptDsPrint1")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsDRPrint1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsD1Print2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official TranscriptDsPrint2")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsDRPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsD1Print3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official TranscriptDsPrint3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsDRPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsC1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptCsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsC1Print5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official TranscriptCsPrint5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;

                        }
                    }

                    group("Student TranscriptsC1Print6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official TranscriptCsPrint6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                    action("Synch to Blackboard")//GAURAV//
                    {
                        Caption = 'Synch to Blackboard';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        trigger OnAction()
                        var
                            WebServicesFunctionsCS: codeunit 50034;
                        begin
                            WebServicesFunctionsCS.SynchStudenttoBlackboard(Rec);
                        end;
                    }
                    Action("Export Batch Transcript")
                    {
                        ApplicationArea = All;
                        Image = Export;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        Visible = False;
                        trigger OnAction()
                        var
                            UserSetup_lRec: Record "User Setup";
                            NMIPasswordInput: Page "Input Data";
                            Selection: Integer;
                            InstituteCodeQuest: Label '&Official,U&nofficial';
                            DefaultOption: Integer;
                            FilePath: Text;
                            AcadYear: Code[20];
                        Begin
                            FilePAth := '\\10.2.108.135\BulkTranscript';
                            UserSetup_lRec.Reset();
                            UserSetup_lRec.SetRange("User ID", UserId());
                            If UserSetup_lRec.FindFirst() then
                                If not UserSetup_lRec."Export Batch Transcript" then
                                    Error('You do not have permission to perform this activity.');

                            IF not Confirm('Do you want to export Bulk Transcript?', False) then
                                Exit;

                            Clear(NMIPasswordInput);
                            NMIPasswordInput.SetInputValue(2);
                            IF NMIPasswordInput.RunModal() = Action::OK then begin
                                //FilePath := NMIPasswordInput.GetRequestedPAth();
                                AcadYear := NMIPasswordInput.GetAcadYear();
                            end;
                            If AcadYear = '' then
                                Error('Please select Academic Year');

                            Selection := StrMenu(InstituteCodeQuest, DefaultOption);
                            if Selection > 0 then begin
                                if Selection = 1 then begin
                                    MSPEApplication(Filepath, AcadYear, true, false);
                                end else
                                    if Selection = 2 then begin
                                        MSPEApplication(FilePath, AcadYear, False, True);
                                    end;
                            End;
                        end;
                    }
                    Action("Upload Temporary Housing Details")
                    {
                        ApplicationArea = All;
                        Image = Import;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        RunObject = xmlport "Temporary Housing Update";
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

                    Action("Consolidated Student Ledger")
                    {
                        ApplicationArea = All;
                        Image = Report;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        //Visible = HideDep;
                        trigger OnAction()
                        var
                            Customer_lRec: Record Customer;
                            ConsolidatedStudentLedger: Report "Consolidated Student Ledger";
                        Begin
                            Clear(ConsolidatedStudentLedger);
                            Customer_lRec.Reset();
                            Customer_lRec.SetRange("No.", Rec."Original Student No.");
                            Customer_lRec.SetRange("Date Filter", 0D, CALCDATE('<1Y>', Today));//GAURAV//22/07/22//
                                                                                               // Customer_lRec.SetRange("Global Dimension 2 Filter", '');
                                                                                               // Report.RunModal(Report::"Consolidated Student Ledger", True, False, Customer_lRec);
                            ConsolidatedStudentLedger.SetTableView(Customer_lRec);
                            ConsolidatedStudentLedger.GetDepartmentFilter('''''');
                            ConsolidatedStudentLedger.Run();
                        End;
                    }
                    

                    action("Course Change")
                    {
                        ApplicationArea = All;
                        Image = Report;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        Visible = HideDep;
                        RunObject = Page "Student Course Change";
                        RunPageLink = "No." = field("No.");
                    }
                    Action("Repeat Semester")
                    {
                        ApplicationArea = All;
                        Image = ChangeTo;
                        Visible = HideDep;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        Trigger OnAction()
                        Begin
                            IF Not Confirm('Do you want to repeat a semester.?', False) then
                                Exit;

                            Rec.TestField("Semester Decision", Rec."Semester Decision"::" ");
                            Rec.Testfield("Returning Student");
                            Rec.StudentSemesterDecisionInsert(Rec, Rec."Semester Decision"::"Repeat ");
                            Message('Semester Updated Successfully');
                            Currpage.Update();

                        End;

                    }
                    Action("Restart Semester")
                    {
                        ApplicationArea = All;
                        Caption = 'Restart Year';
                        Image = ChangeTo;
                        Promoted = true;
                        Visible = HideDep;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        Trigger OnAction()
                        Begin
                            IF Not Confirm('Do you want to restart a Year.?', False) then
                                Exit;

                            Rec.TestField("Semester Decision", Rec."Semester Decision"::" ");
                            Rec.Testfield("Returning Student");
                            Rec.StudentSemesterDecisionInsert(Rec, Rec."Semester Decision"::Restart);
                            Message('Semester Updated Successfully');
                            Currpage.Update();

                        End;

                    }
                    Action("Repeat Semester List")
                    {
                        ApplicationArea = All;
                        Image = List;
                        Visible = HideDep;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        RunObject = Page "Student Semester Log Entry";
                        RunPageView = where("Semester Decision" = filter("Repeat "));
                    }
                    Action("Restart Semester List")
                    {
                        ApplicationArea = All;
                        Caption = 'Restart Year List';
                        Image = List;
                        Visible = HideDep;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        RunObject = Page "Student Semester Log Entry";
                        RunPageView = where("Semester Decision" = filter(Restart));
                    }
                    group("Student TranscriptsC1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptCsPrint1")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsC1Print2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official TranscriptCsPrint2")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;

                        }
                    }

                    group("Student TranscriptsC1Print3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official TranscriptCsPrint3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsZ1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptZsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsZRPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsZ1Print5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official TranscriptZsPrint5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsZRPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;

                        }
                    }

                    group("Student TranscriptsM1Print6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official TranscriptMsPrint6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsMRPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

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
                            Rec.ImmigrationHoldSignoff(Rec);
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
                //Visible = false;
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
                //Visible = false;
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

            action("OLR Finance Holds E")//GMCS//02052023
            {
                Caption = 'OLR Finance Hold Enable';
                Image = Closed;
                ApplicationArea = All;
                PromotedCategory = Category14;
                Promoted = true;
                Visible = OLRFinanceVisible;
                Trigger OnAction()
                var
                    StudentTimeLineRec: Record "Student Time Line";
                    StudentMasterRec: Record "Student Master-CS";
                    StudentMaster_lRec: Record "Student Master-CS";
                    StudentStatusMgmt: Codeunit "Student Status Mangement";
                    HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
                    Text001Lbl: Label 'Do you want to Enable the OLR Finance Hold for selected students?';
                    Text002Lbl: Label 'Do you want to Enable OLR Finance Hold for Student No. %1?';
                    Text003Lbl: Label 'OLR Finance enabled for selected students.';
                    Text004Lbl: Label 'OLR Finance enabled for Student No. %1';
                    HoldCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(StudentMasterRec);
                    HoldCount := StudentMasterRec.Count();
                    IF HoldCount > 1 then begin
                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            IF StudentMasterRec.FindSet() then
                                repeat
                                    StudentMaster_lRec.Reset();
                                    StudentMaster_lRec.SetRange("Original Student No.", StudentMasterRec."Original Student No.");
                                    IF StudentMaster_lRec.FindSet() then begin
                                        Repeat
                                            StudentStatusMgmt.EnableAllHoldOLR(StudentMaster_lRec, HoldType::"OLR Finance");
                                            StudentTimeLineRec.InsertRecordFun(StudentMaster_lRec."No.", StudentMasterRec."Student Name", 'OLR Finance Hold Enable', UserId(), Today());
                                        until StudentMaster_lRec.Next() = 0;
                                    end;

                                until StudentMasterRec.Next() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        end else
                            exit
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentMaster_lRec.Reset();
                            StudentMaster_lRec.SetRange("Original Student No.", Rec."Original Student No.");
                            If StudentMaster_lRec.FindSet() then begin
                                repeat
                                    StudentStatusMgmt.EnableAllHoldOLR(StudentMaster_lRec, HoldType::"OLR Finance");
                                    StudentTimeLineRec.InsertRecordFun(StudentMaster_lRec."No.", Rec."Student Name", 'OLR Finance Hold Enable', UserId(), Today());
                                until StudentMaster_lRec.Next() = 0;
                            end;
                            Message(Text004Lbl, Rec."Original Student No.");
                            CurrPage.Update();

                        end else
                            exit;
                end;
            }
            action("OLR Finance Holds D")//GMCS//02052023
            {
                Caption = 'OLR Finance Hold Disable';
                Image = Closed;
                ApplicationArea = All;
                PromotedCategory = Category14;
                Promoted = true;
                Visible = OLRFinanceVisible;
                Trigger OnAction()
                var
                    StudentTimeLineRec: Record "Student Time Line";
                    StudentStatusMgmt: Codeunit "Student Status Mangement";
                    StudentMasterRec: Record "Student Master-CS";
                    StudentMaster_lRec: Record "Student Master-CS";
                    HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
                    Text001Lbl: Label 'Do you want to Disable the OLR Finance Hold for selected students?';
                    Text002Lbl: Label 'Do you want to Disable OLR Finance Hold for Student No. %1?';
                    Text003Lbl: Label 'OLR Finance Disabled for selected students.';
                    Text004Lbl: Label 'OLR Finance Disabled for Student No. %1';
                    HoldCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(StudentMasterRec);
                    HoldCount := StudentMasterRec.Count();
                    IF HoldCount > 1 then begin
                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            IF StudentMasterRec.FindSet() then
                                repeat
                                    StudentMaster_lRec.Reset();
                                    StudentMaster_lRec.SetRange("Original Student No.", StudentMasterRec."Original Student No.");
                                    IF StudentMaster_lRec.FindSet() then begin
                                        repeat
                                            if Rec.HoldChecksOLRFinance(StudentMaster_lRec) = true then begin
                                                StudentStatusMgmt.DisableAllHoldOLR(StudentMaster_lRec, HoldType::"OLR Finance");
                                                StudentTimeLineRec.InsertRecordFun(StudentMaster_lRec."No.", StudentMasterRec."Student Name", 'OLR Finance Hold Disable', UserId(), Today());
                                            end;
                                        until StudentMaster_lRec.Next() = 0;
                                    end;
                                until StudentMasterRec.Next() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        end else
                            exit
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentMaster_lRec.Reset();
                            StudentMaster_lRec.SetRange("Original Student No.", Rec."Original Student No.");
                            If StudentMaster_lRec.FindSet() then begin
                                Repeat
                                    if Rec.HoldChecksOLRFinance(StudentMaster_lRec) = true then begin
                                        StudentStatusMgmt.DisableAllHoldOLR(StudentMaster_lRec, HoldType::"OLR Finance");
                                        StudentTimeLineRec.InsertRecordFun(StudentMaster_lRec."No.", Rec."Student Name", 'OLR Finance Hold Disable', UserId(), Today());
                                    end;
                                until StudentMaster_lRec.Next() = 0;
                            end;
                            Message(Text004Lbl, Rec."No.");
                            CurrPage.Update();

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
                RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

            }
            // action("Student Document")
            // {
            //     Caption = 'Student Document';
            //     image = Account;
            //     ApplicationArea = All;
            //     RunObject = page "Student Document Attachment";
            //     RunPageLink = "Student No." = FIELD("No."), "Enrolment No." = field("Enrollment No.");

            // }
            action(SAFISync)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MoveDown;
                //RunPageMode = View;
                Caption = 'SAFI Sync';
                Visible = HideDep;
                trigger OnAction()
                begin
                    IF Rec."Student SFP Initiation" <> 0 then begin
                        Rec."SAFI Sync" := Rec."SAFI Sync"::Pending;
                        Rec.Modify(True);
                    end;
                end;
            }
            action("Calculate SAP")
            {   //CSPL-00307
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = FinancialAidDepartment;
                Image = Calculate;
                Caption = 'Calculate SAP';
                trigger OnAction()
                var
                    RecStudMaster: Record "Student Master-CS";
                    Window: Dialog;
                begin
                    CurrPage.SetSelectionFilter(RecStudMaster);
                    IF RecStudMaster.FindSet() then begin
                        IF Confirm('Are You Sure You Want To Calculate Satisfactory Academic Progress for Selected Students') then begin
                            Window.Open('Please Wait...');
                            repeat
                                Rec.CalculateSAP(RecStudMaster, '');
                            until RecStudMaster.Next() = 0;
                            Window.Close();
                            Message('Done');
                            CurrPage.Update();
                        end;
                    end else
                        Error('Nothing to Calculate');
                end;
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

            action("Add Attachments")
            {
                ApplicationArea = All;
                Caption = 'View All Attachment';
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
                    Page.RunModal(Page::"Add Student Attachments", StudentMaster);
                end;
            }
            action("Student Holds Upload")
            {
                ApplicationArea = All;
                Caption = 'Student Holds Upload';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport 50079;
            }

            action("Update GPA")
            {
                ApplicationArea = All;
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentStatusMgmt: Codeunit "Student Status Mangement";
                Begin
                    Clear(StudentStatusMgmt);
                    If Confirm('Do you want to Calculate GPA?', true) then
                        StudentStatusMgmt.UpdateGPA(Rec."No.", true)
                    Else
                        Exit;
                End;
            }
            action("CCSE Score_2")
            {
                caption = 'CCSE Score';
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Student Subject Exam List";
                RunPageLink = "Score Type" = filter(CCSE);
            }
            action("CCSSE Score_2 ")
            {
                caption = 'CCSSE Score';
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Student Subject Exam List";
                RunPageLink = "Score Type" = filter(CCSSE);
            }
            action("CBSE Score_2")
            {
                Caption = 'CBSE Score';
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Student Subject Exam List";
                RunPageLink = "Score Type" = filter(CBSE);
            }
            Action("USMLE Scores_1")
            {
                Caption = 'USMLE Scores';
                Image = PostApplication;
                ApplicationArea = All;
                RunObject = page "Student Subject Exam List";
                RunPageLink = "Score Type" = filter("STEP 1" | "STEP 2 CS" | "STEP 2 CK");
            }
            group(ActionGroupCDS)
            {
                Caption = 'Dataverse';
                // Visible = CDSIntegrationEnabled;
                
                action(CDSGotoLabBook)
                {
                    Caption = 'Lab Book';
                    Image = CoupledCustomer;
                    ToolTip = 'Open the coupled Dataverse lab book.';
                    ApplicationArea = All;
                    Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CDSSynchronizeNow)
                {
                    Caption = 'Synchronize';
                    ApplicationArea = All;
                    Visible = true;
                    Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                    Image = Refresh;
                    // Enabled = CDSIsCoupledToRecord;
                    ToolTip = 'Send or get updated data to or from Microsoft Dataverse.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.UpdateOneNow(Rec.RecordId);
                    end;
                }
                action(ShowLog)
                {
                    Caption = 'Synchronization Log';
                    ApplicationArea = All;
                    Visible = true;
                    Image = Log;
                    Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                    ToolTip = 'View integration synchronization jobs for the customer table.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(Rec.RecordId);
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Microsoft Dataverse row.';

                    action(ManageCDSCoupling)
                    {
                        Caption = 'Set Up Coupling';
                        ApplicationArea = All;
                        Visible = true;
                        Image = LinkAccount;
                        Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                        ToolTip = 'Create or modify the coupling to a Microsoft Dataverse lab book.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(Rec.RecordId);
                        end;
                    }
                    action(DeleteCDSCoupling)
                    {
                        Caption = 'Delete Coupling';
                        ApplicationArea = All;
                        Visible = true;
                        Image = UnLinkAccount;
                        Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                        // Enabled = CDSIsCoupledToRecord;
                        ToolTip = 'Delete the coupling to a Microsoft Dataverse lab book.';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                        end;
                    }
                }
            }
        }



        area(navigation)
        {
            action("Student Data Upload")
            {
                ApplicationArea = All;
                Caption = 'Student Data Upload';
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = XMLport 50001;
            }
            action("Update Student Details")
            {
                ApplicationArea = ALl;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = XMLport 50002;
            }
            // action("Send Data to Portal")
            // {
            //     ApplicationArea = ALl;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     trigger OnAction()
            //     var
            //         CallWebService: Codeunit WebServicesFunctionsCSL;
            //     begin
            //         //Code added for Call Sql Procedure to Send data to Portal Database::CSPL-00092::29-05-2019: Start
            //         //CSPL-00058 START
            //         CallWebService.Generate_Allocation_Grade_Markeup_Util(Format(Rec."Global Dimension 1 Code"));
            //         //CSPL-00058 END
            //         MESSAGE('Done Successfully');
            //         //Code added for Call Sql Procedure to Send data to Portal Database::CSPL-00092::29-05-2019: End
            //     end;
            // }
            action("Page Student Wise Hold")
            {
                Caption = 'Student Wise H&old';
                ApplicationArea = All;
                Image = Ledger;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Student Wise Hold List";
                RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);
                RunPageView = SORTING("Student No.");
                ShortCutKey = 'Ctrl+F8';
            }
        }
        area(Creation)
        {
            action("Financial Aid Signoff")
            {
                Caption = '&Financial Aid Signoff';
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentMasterRec: record "Student Master-CS";
                    HoldCount: Integer;
                    multiple: Boolean;
                    Line: Integer;
                begin
                    Line := 0;
                    CurrPage.SetSelectionFilter(StudentMasterRec);
                    IF StudentMasterRec.FindSet() then
                        HoldCount := StudentMasterRec.Count();
                    repeat
                        Line += 1;
                        if Line > 1 then
                            multiple := true
                        else
                            multiple := false;
                    //FinancialAidSignoff(StudentMasterRec, false, multiple, HoldCount)//GMCSCOM
                    until StudentMasterRec.Next() = 0;
                end;
            }
            action("Bursar Signoff")
            {
                Caption = '&Bursar Signoff';
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentMasterRec: record "Student Master-CS";
                begin
                    CurrPage.SetSelectionFilter(StudentMasterRec);
                    // BursarSignoff(StudentMasterRec);
                end;
            }


            action("Legacy Ledger")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category5;
                RunObject = Page 50199;
                RunPageLink = "Roll No." = FIELD("Enrollment No.");
            }
            action("Student Details Mentors Import")
            {
                ApplicationArea = All;
                Image = ListPage;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page 50112;
            }
            action("Course Section")
            {
                ApplicationArea = All;
                Image = ListPage;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page 50233;
            }
        }
    }


    trigger OnInit()
    begin
        Social := false;
        SocialSec := false;
    end;

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

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            Social := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
                Social := true
            else
                if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::Admissions) then
                    Social := true
                else
                    Social := false;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            SocialSec := false
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
                SocialSec := false
            else
                if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::Admissions) then
                    SocialSec := false
                else
                    SocialSec := true;

        if Rec."Social Security No." <> '' then begin
            SocialSecurity := '*******' + COPYSTR(Rec."Social Security No.", 8, 4);
        end;

        OLRFinanceVisible := False;
        If usersetupapprover.Get(USerID(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            OLRFinanceVisible := True;
        IF usersetupapprover.Get(USerID(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            OLRFinanceVisible := True;
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
        OLRFinanceVisible := False;
        If usersetupapprover.Get(USerID(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            OLRFinanceVisible := True;
        IF usersetupapprover.Get(USerID(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            OLRFinanceVisible := True;
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

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then begin
            FinancialAIDHoldVisible := true;
            FinancialAidDepartment := true;//CSPL-00307
        end
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then begin
                FinancialAIDHoldVisible := true;
                FinancialAidDepartment := true;
            end;

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

        ShowFerpaDetail := false;
        HideFerpaDetail := false;
        If UserSetup."Ferpa Insert Allowed" then begin
            ShowFerpaDetail := true;
            HideFerpaDetail := false;
        end Else begin
            ShowFerpaDetail := false;
            HideFerpaDetail := true;
        end;
    end;

    var
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentMasterCS: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
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
        OLRFinanceVisible: Boolean;
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
        Text0021Lbl: Label 'Do you want to process the Student Initiation for selected Students?';
        Text0022Lbl: Label 'Do you want to process the Student Initiation for Student No. %1';
        Text0023Lbl: Label 'Student Initiation process is compeleted for selected students.';
        Text0024Lbl: Label 'Student Initiation process is compeleted for Student No. %1';
        Text0025Lbl: Label 'Do you want to process the SAFI Event for selected Students?';
        Text0026Lbl: Label 'Do you want to process the SAFI Event for Student No. %1';
        Text0027Lbl: Label 'SAFI Event process is compeleted for selected students.';
        Text0028Lbl: Label 'SAFI Event process is compeleted for Student No. %1';

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
        Social: Boolean;
        SocialSec: Boolean;
        SocialSecurity: Text[20];
        ShowFerpaDetail: Boolean;
        HideFerpaDetail: Boolean;
        FinancialAidDepartment: Boolean;
        HideDep: Boolean;

    procedure BursarSignof(StudentRec: Record "Student Master-CS")
    Var
        HoldUserMappingRec: Record "Holds User Mapping";
        StudentMaster_lRec: Record "Student Master-CS";
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentHoldRec: Record "Student Hold";
        FinancialAIDRec: Record "Financial AID";
        RSL: Record "Roster Scheduling Line";
        HoldCount: Integer;
        Text003Lbl: Label 'Financial AID Application No. %1 is still pending for this student.';

    begin
        // HoldUserMappingRec.Reset();
        // HoldUserMappingRec.SetRange("User ID", UserId());
        // if HoldUserMappingRec.FindFirst() then begin

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
        // end else
        //     Error('You do not have the permission to disable the Bursar Signoff');
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



        IF UserSetupApproval.Get(Userid(), UserSetupApproval."Department Approver Type"::"Registrar Department") then
            HideDep := true
        else
            HideDep := false;


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

    procedure OfficialTranscriptsExport(Rec: Record "Student Master-CS"; FilePath: Text)
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report "Standard Tran Cre Transcript";
        MedicineOfficialTranscriptNew: Report "Standard Transcript";
        AICASAEMTTranscript: Report "AICASA EMT Transcript";
        AUAColOfMedicineVeterinary: Report "AUA Col Of Medicine Veterinary";
        AUAMedicineMasterScienceReport: Report "AUA Col Of Medicine MS";
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
        FileName: Text;

    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;

        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // RecMainStudentSubject.Setfilter(Grade, '<>%1', '');
        // RecMainStudentSubject.SetRange("Grade Confirmed", false);
        // IF RecMainStudentSubject.FindFirst() then
        //     Message('Please Confirm all the Grades!');

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                // MedicineOfficialTranscriptNew.RUNMODAL()
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // MedicineOfficialTranscriptNew.SaveAsPdf(FileName);
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                //AICASAEMTTranscript.RUNMODAL()
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // AICASAEMTTranscript.SaveAsPdf(FileName);
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                //AUAColOfMedicineVeterinary.RUNMODAL();
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // AUAColOfMedicineVeterinary.SaveAsPdf(FileName);
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                //StandardTranCreTranscript.RUNMODAL()
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // StandardTranCreTranscript.SaveAsPdf(FileName);
            end;
        end;

        Clear(AUAMedicineMasterScienceReport);
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                //AUAMedicineMasterScienceReport.RUNMODAL()
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // AUAMedicineMasterScienceReport.SaveAsPdf(FileName);
            end;
        end;

    End;

    procedure UnOfficialTranscriptsExport(Rec: Record "Student Master-CS"; FilePath: Text)
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report "Standard Tran Cre Transcript";
        MedicineOfficialTranscriptNew: Report "Standard Transcript";
        AICASAEMTTranscript: Report "AICASA EMT Transcript";
        AUAColOfMedicineVeterinary: Report "AUA Col Of Medicine Veterinary";
        AUAMedicineMasterScienceReport: Report "AUA Col Of Medicine MS";
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
        FileName: Text;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;

        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // RecMainStudentSubject.Setfilter(Grade, '<>%1', '');
        // RecMainStudentSubject.SetRange("Grade Confirmed", false);
        // IF RecMainStudentSubject.FindFirst() then
        //     Message('Please Confirm all the Grades!');

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                //MedicineOfficialTranscriptNew.RUNMODAL()
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // MedicineOfficialTranscriptNew.SaveAsPdf(FileName);

            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                //AICASAEMTTranscript.RUNMODAL()
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // AICASAEMTTranscript.SaveAsPdf(FileName);
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                //AUAColOfMedicineVeterinary.RUNMODAL();
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // AUAColOfMedicineVeterinary.SaveAsPdf(FileName);
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                //StandardTranCreTranscript.RUNMODAL()
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // StandardTranCreTranscript.SaveAsPdf(FileName);
            end;
        end;

        Clear(AUAMedicineMasterScienceReport);
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                //AUAMedicineMasterScienceReport.RUNMODAL()
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No.", '=', '/') + '.pdf';
                // AUAMedicineMasterScienceReport.SaveAsPdf(FileName);
            end;
        end;

    End;

    Procedure MSPEApplication(FilePath: Text; AcadYear: Code[20]; Official: Boolean; Unofficial: Boolean)
    Var
        MSPE_lRec: Record MSPE;
        StudentMaster_lRec: Record "Student Master-CS";
        AcadYearInt: Integer;
        FromDate: Date;
        StudentNoFilter: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Students No.     ############1################\';
        totalcount: Integer;
        Counter: Integer;
    Begin
        Evaluate(AcadYearInt, AcadYear);
        FromDate := DMY2Date(1, 1, AcadYearInt);
        If GuiAllowed then
            WindowDialog.Open('Fetching Data....\' + Text001Lbl);

        MSPE_lRec.Reset();
        MSPE_lRec.SetCurrentKey("Student No", "Application Date");
        MSPE_lRec.SetRange("Application Date", FromDate, Today());
        If MSPE_lRec.FindSet() then begin
            totalcount := MSPE_lRec.Count();
            repeat
                IF StudentNoFilter <> MSPE_lRec."Student No" then begin
                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetRange("No.", MSPE_lRec."Student No");
                    If StudentMaster_lRec.FindFirst() then begin
                        counter += 1;
                        if GuiAllowed then
                            WindowDialog.Update(1, StudentMaster_lRec."No." + ' - ' + format(counter) + ' of ' + format(totalcount));
                        If Official then
                            OfficialTranscriptsExport(StudentMaster_lRec, FilePath);
                        IF Unofficial then
                            UnOfficialTranscriptsExport(StudentMaster_lRec, FilePath);
                    end;
                end;
            until MSPE_lRec.Next() = 0;
        end;
        If Not MSPE_lRec.FindFirst() then
            Error('There is no MSPE Application exist for Academic Year : %1', AcadYear);

        If GuiAllowed then
            WindowDialog.Close();

    End;


}
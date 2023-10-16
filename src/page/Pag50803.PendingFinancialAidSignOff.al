page 50803 "Pending Financial Aid SignOff"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                             Remarks
    // 1         CSPL-00092    29-05-2019    <Action1102155025> - OnAction                       Page Run
    // 2         CSPL-00092    29-05-2019    Student Data Upload - OnAction                      XMLPort Run
    // 3         CSPL-00092    29-05-2019    Update Student Details - OnAction                   XMLPort Run
    // 4         CSPL-00092    29-05-2019    Send Data to Portal - OnAction                      Call Sql Procedure to Send data to Portal Database
    // 5         CSPL-00092    29-05-2019    Not Completed Lower Semester(NCL) - OnAction        Find and update Disability False for Student Not Completed Lower Semester(NCL)

    Caption = 'Pending Financial Aid SignOff';
    CardPageID = "Student Detail Card-CS";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate,Admissions,Registrar/Academics,Clinical,Housing/Immigration,Bursar/Finance,Financial Aid,EED Pre-Clinical,EED Clinical Science,Graduate Affairs,Feedback';
    SourceTable = "Student Master-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending) where("Financial Aid Hold" = filter(true));
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("No."; Rec."No.")
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Parent Student No."; Rec."Parent Student No.")
                {
                    ApplicationArea = All;
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
                }
                field("Customer Exists"; Rec."Customer Exists")
                {
                    ApplicationArea = All;
                }
                field("Housing Hold"; Rec."Housing Hold")
                {
                    ApplicationArea = All;
                }
                field("Bursar Hold"; Rec."Bursar Hold")
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
                }
                field("Immigration Hold"; Rec."Immigration Hold")
                {
                    ApplicationArea = All;
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
                    //Visible = RegistrarGroup;
                    Visible = false;
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
                                    RecStudentMaster.SetRange("No.", Rec."No.");
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
                                    RecStudentMaster.SetRange("No.", Rec."No.");
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
                                    RecStudentMaster.SetRange("No.", Rec."No.");
                                    IF RecStudentMaster.FindFirst() then begin
                                        Report.Run(Report::"AUA 5th Semester IDCard", true, false, RecStudentMaster);
                                    end;

                                end;
                            }
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
                    group("Registrar/Academics Details")
                    {
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
                        action("Generate QRCode")
                        {
                            Image = BarCode;
                            ApplicationArea = All;
                            trigger OnAction()
                            begin
                                IF Confirm('Do you want to generate QR Code ?', false) then begin
                                    // GenerateBarCode();//GMCSCOM
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
                                StudentMaster.SetRange("No.", Rec."No.");
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
                                  "Course" = FIELD("Course Code"),
                                  Semester = FIELD(Semester);

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
                        action("Student Wise Hold")
                        {
                            Caption = 'Student Wise H&old';
                            ApplicationArea = All;
                            Image = Ledger;
                            RunObject = Page "Student Wise Hold List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);
                            RunPageView = SORTING("Student No.");
                            ShortCutKey = 'Ctrl+F8';
                        }
                        action("Page Cust Ledger Entries")
                        {
                            ApplicationArea = All;
                            Caption = 'Ledger E&ntries';
                            Image = CustomerLedger;
                            RunObject = Page "Customer Ledger Entries";
                            RunPageLink = "Customer No." = FIELD("No."),
                                      "Semester" = FIELD("Semester");
                            RunPageView = SORTING("Customer No.");
                            ShortCutKey = 'Ctrl+F7';
                        }
                        action("Status History")
                        {
                            Caption = 'Status History';
                            Image = EntriesList;
                            ApplicationArea = All;

                        }
                        action("Faculty Feedback Results")
                        {
                            Caption = 'Faculty Feedback Results';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Feedback Detail-CS";
                            RunPageLink = "Course" = FIELD("Course Code");
                        }
                        action("Student Promotion List4")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code");
                        }
                        //SN-23-Dec-2020 +
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
                        //SN-23-Dec-2020 -
                        action("Transfer Credit Details")
                        {
                            Caption = 'Transfer Credit Details';
                            image = GanttChart;
                            ApplicationArea = All;
                            RunObject = Page "Student Branch Tranfr Dtl-CS";
                            RunPageLink = "No." = FIELD("No.");
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
                        action("Student Honors")
                        {
                            ApplicationArea = All;
                            Caption = 'Student Honors';
                            Image = EntriesList;
                            RunObject = Page "Student Honors";
                            RunPageLink = "Student No." = FIELD("No.");

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
                    action("Clinical Document List")
                    {
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Student Clinical Documents+";
                        RunPageLink = "Student No." = FIELD("No.");
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
                                StudentMaster.SetRange("No.", Rec."No.");
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
                        RunPageLink = "No." = FIELD("No.");

                    }
                    action("Ledger Entries")
                    {
                        Caption = 'Ledger Entries';
                        image = PostApplication;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Customer Ledger Entries";
                        RunPageLink = "Customer No." = FIELD("No."),
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
                        Visible = FinancialAid_GBoo;
                        //Promoted = true;
                        //PromotedCategory = Category9;
                        trigger OnAction()
                        begin
                            //FinancialAidSignoff(Rec);//GMCSCOM
                        end;
                    }
                    group("SFP Update")

                    {
                        Visible = false;
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
                    }
                    Action("Student Legacy Ledger")
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
                        RunObject = Page "Roster Ledger Entries";
                        RunPageLink = "Student ID" = field("Original Student No.");

                    }
                    action("&Student Subjet Fi")
                    {
                        Caption = '&Student Subject';
                        image = GanttChart;
                        ApplicationArea = All;

                        RunObject = Page 50001;
                        RunPageLink = "Student No." = FIELD("No."),
                                  "Course" = FIELD("Course Code");


                    }

                    group("Student TranscriptsA1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptAs")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatus: Record "Student Status";
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
                        action("Unofficial TranscriptsAR")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatus: Record "Student Status";
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
                                StudentStatus: Record "Student Status";
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
                                StudentStatus: Record "Student Status";
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
                                StudentStatus: Record "Student Status";
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
                        action("Unofficial TranscriptsARPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatus: Record "Student Status";
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
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Stud Promotion List")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
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

                }
            }
            group(Registrar)
            {
                Visible = False;
                action("Registrar Hold Eanble")
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
                Image = Closed;
                Visible = ImmigrationHoldVisible;
                ApplicationArea = All;
                PromotedCategory = Category7;
                Promoted = true;
                trigger OnAction()
                Var
                    StudentStatusMangCod: Codeunit "Student Status Mangement";
                    StudentCount: Integer;
                    Text0013Lbl: Label 'Do you want to enable the Immigration Hold for selected Students?';
                    Text0014Lbl: Label 'Do you want to enable the Immigration Hold for Student No. %1';
                    Text0015Lbl: Label 'Immigration Hold enabled for selected students.';
                    Text0016Lbl: Label 'Immigration Hold enabled for Student No. %1';
                begin
                    CurrPage.SetSelectionFilter(StudentMasterCS);
                    StudentCount := StudentMasterCS.Count();
                    IF StudentCount > 1 then begin
                        IF CONFIRM(Text0013Lbl, FALSE) THEN BEGIN
                            IF StudentMasterCS.FindFirst() Then
                                repeat
                                    StudentStatusMangCod.EnableAllHold(StudentMasterCS, HoldType::Immigration);
                                until StudentMasterCS.next() = 0;
                            Message(Text0015Lbl);
                            CurrPage.Update();
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text0014Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::Immigration);
                            Message(Text0016Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Immigration Hold Signof")
            {
                Caption = '&Immigration Hold Signoff';
                Visible = ImmigrationHoldVisible;
                Image = SignUp;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category7;
                trigger OnAction()
                var
                    StudentMasterRec: record "Student Master-CS";
                    HoldCount: Integer;
                    Text001Lbl: Label 'Do you want to Disable the Immigration Hold for selected students?';
                    Text002Lbl: Label 'Do you want to Disable Immigration Hold for Student No. %1?';
                    Text003Lbl: Label 'Immigration Hold disabled for selected students.';
                    Text004Lbl: Label 'Immigration Hold disabled for Student No. %1?';
                begin
                    CurrPage.SetSelectionFilter(StudentMasterRec);
                    HoldCount := StudentMasterRec.Count();
                    IF HoldCount > 1 then begin
                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            IF StudentMasterRec.FindSet() then
                                repeat
                                    Rec.ImmigrationHoldSignoff(StudentMasterRec);
                                until StudentMasterRec.Next() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        end else
                            exit
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."No.") THEN BEGIN
                            Rec.ImmigrationHoldSignoff(Rec);
                            Message(Text004Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Bursar Hold Enable")
            {
                Image = Closed;
                Visible = BursarHoldVisible;
                ApplicationArea = All;
                PromotedCategory = Category8;
                Promoted = true;
                trigger OnAction()
                Var
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
                                until StudentMasterCS.next() = 0;
                            Message(Text0015Lbl);
                            CurrPage.Update();
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text0014Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::Bursar);
                            Message(Text0016Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Bursar Hold Signof")
            {
                Caption = '&Bursar Hold Signoff';
                Visible = BursarHoldVisible;
                Image = SignUp;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category8;
                trigger OnAction()
                var
                    StudentMasterRec: record "Student Master-CS";
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
                                    BursarSignof(StudentMasterRec);
                                until StudentMasterRec.Next() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        end else
                            exit
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."No.") THEN BEGIN
                            BursarSignof(Rec);
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
                                until StudentMasterCS.next() = 0;
                            Message(Text0015Lbl);
                            CurrPage.Update();
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text0014Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::"Financial Aid");
                            Message(Text0016Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Financial Aid Signof")
            {
                Caption = '&Financial Aid Signoff';
                ApplicationArea = All;
                Image = SignUp;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = FinCourseHoldVisible;
                trigger OnAction()
                var
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
                                until StudentMasterRec.Next() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        end else
                            exit
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."No.") THEN BEGIN
                            Rec.FinancialAidSignoff(Rec);
                            Message(Text004Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
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
        //if UserSetup.Get(UserId()) then begin
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Bursar Department") then
            BursarHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Financial Aid Department") then
            FinancialAIDHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Student Services") then
            ImmigrationHoldVisible := true;
        //end;
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
        BursarHoldVisible := false;
        FinancialAIDHoldVisible := false;
        ImmigrationHoldVisible := false;
        //if UserSetup.Get(UserId()) then begin
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Bursar Department") then
            BursarHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Financial Aid Department") then
            FinancialAIDHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Student Services") then
            ImmigrationHoldVisible := true;

        if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
            FinCourseHoldVisible := true
        else
            FinCourseHoldVisible := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
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
        //if UserSetup.Get(UserId()) then begin
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Bursar Department") then
            BursarHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Financial Aid Department") then
            FinancialAIDHoldVisible := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Student Services") then
            ImmigrationHoldVisible := true;
        //end;
        if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
            FinCourseHoldVisible := true
        else
            FinCourseHoldVisible := false;
    end;

    var
        RecHoldStatusLedger: Record "Hold Status Ledger";
        userapproversetup: Record "Document Approver Users";
        StudentMasterCS: Record "Student Master-CS";
        UserSetup: Record "User Setup";
        CourseMaster: Record "Course Master-CS";
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
    begin
        Bool := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            Bool := false;
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

        AdmissionGroup := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::Admissions) then
            AdmissionGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                AdmissionGroup := true
            else
                AdmissionGroup := false;

        RegistrarGroup := true;

        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Registrar Department") then
            RegistrarGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                RegistrarGroup := true
            else
                RegistrarGroup := false;


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

        HousingGroup := true;
        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Residential Services") then
            HousingGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                HousingGroup := true
            else
                HousingGroup := false;

        BursarGroup := true;

        if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::"Bursar Department") then
            BursarGroup := true
        else
            if userapproversetup.get(userid(), userapproversetup."Department Approver Type"::" ") then
                BursarGroup := true
            else
                BursarGroup := false;

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


    end;

}
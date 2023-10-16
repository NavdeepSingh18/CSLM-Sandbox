page 50996 EEDBscScncRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueEEDBscScnc;
    Caption = 'EED Pre- Clinical Role Center ';

    layout
    {
        area(Content)
        {
            cuegroup("Advising Request Statistics")
            {


                field("Pending Advising Request"; Rec."Pending Advising Request")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Advising Request List";//50846
                    trigger OnDrillDown()
                    var
                        AdvsngReq: Record "Advising Request";
                        PendingAdvisingReq_Page: Page "Advising Request List";
                        IntOption: Integer;
                        NotAuthLbl: Label 'You are not authorized to access this page.';
                    begin
                        clear(PendingAdvisingReq_Page);
                        AdvsngReq.Reset();
                        // AdvsngReq.SetFilter("Request Status", '=%1|=%2|=%3', AdvsngReq."Request Status"::Pending, AdvsngReq."Request Status"::Cancel, AdvsngReq."Request Status"::" ");
                        // AdvsngReq.SetRange("Department Type", AdvsngReq."Department Type"::"EED Basic Science");
                        AdvsngReq.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
                        AdvisingReq.SetRange("Department Type", AdvisingReq."Department Type"::"EED Pre-Clinical");
                        AdvisingReq.Setfilter("Request Status", '%1|%2', AdvisingReq."Request Status"::Pending, AdvisingReq."Request Status"::" ");
                        IntOption := AdvsngReq.ChecDocumentAppDepartment();
                        case IntOption of
                            1:
                                begin
                                    AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Pre-Clinical"));
                                end;
                            2:
                                begin
                                    AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Clinical"));
                                end;
                            3:
                                begin
                                    AdvsngReq.SetFilter("Department Type", '=%1|=%2', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical");
                                end;
                            4:
                                begin
                                    AdvsngReq.Setfilter("Department Type", '=%1|=%2|=%3', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical", AdvsngReq."Department Type"::" ");
                                end;
                            0:
                                begin
                                    Error(NotAuthLbl);
                                end;
                        end;
                        if AdvsngReq.FindSet() then begin
                            PendingAdvisingReq_Page.SetTableView(AdvsngReq);
                            PendingAdvisingReq_Page.SetRecord(AdvsngReq);
                            PendingAdvisingReq_Page.Run();
                        end;
                    end;
                }

                field("Approved Adv. Req."; Rec."Approved Adv. Req.")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "App. Resch. Advs. Request List";//51016
                    trigger OnDrillDown()
                    var
                        AdvsngReq: Record "Advising Request";
                        ApprovedAdvisingReq_Page: Page "App. Resch. Advs. Request List";
                        IntOption: Integer;
                        NotAuthLbl: Label 'You are not authorized to access this page.';
                    begin
                        clear(ApprovedAdvisingReq_Page);
                        AdvsngReq.Reset();
                        AdvsngReq.SetRange("Request Status", AdvsngReq."Request Status"::Approved);
                        // AdvsngReq.SetRange("Department Type", AdvsngReq."Department Type"::"EED Basic Science");
                        IntOption := AdvsngReq.ChecDocumentAppDepartment();
                        case IntOption of
                            1:
                                begin
                                    AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Pre-Clinical"));
                                end;
                            2:
                                begin
                                    AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Clinical"));
                                end;
                            3:
                                begin
                                    AdvsngReq.SetFilter("Department Type", '=%1|=%2', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical");
                                end;
                            4:
                                begin
                                    AdvsngReq.Setfilter("Department Type", '=%1|=%2|=%3', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical", AdvsngReq."Department Type"::" ");
                                end;
                            0:
                                begin
                                    Error(NotAuthLbl);
                                end;
                        end;
                        if AdvsngReq.FindSet() then begin
                            ApprovedAdvisingReq_Page.SetTableView(AdvsngReq);
                            ApprovedAdvisingReq_Page.SetRecord(AdvsngReq);
                            ApprovedAdvisingReq_Page.Run();
                        end;
                    end;
                }
                field("Reje. Comptd. Adv. Req."; Rec."Reje. Comptd. Adv. Req.")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Rejc. Comp. Advis. Req. List";//51017
                    trigger OnDrillDown()
                    var
                        AdvsngReq: Record "Advising Request";
                        RejcOrCompAdvisingReq_Page: Page "Rejc. Comp. Advis. Req. List";
                        IntOption: Integer;
                        NotAuthLbl: Label 'You are not authorized to access this page.';
                    begin
                        clear(RejcOrCompAdvisingReq_Page);
                        AdvsngReq.Reset();
                        // AdvsngReq.SetFilter("Request Status", '=%1|=%2|=%3', AdvsngReq."Request Status"::Rescheduled, AdvsngReq."Request Status"::Rejected, AdvsngReq."Request Status"::Completed);
                        // AdvsngReq.SetRange("Department Type", AdvsngReq."Department Type"::"EED Basic Science");
                        AdvsngReq.Setfilter("Request Status", '%1|%2|%3', AdvsngReq."Request Status"::Completed, AdvsngReq."Request Status"::Rejected, AdvsngReq."Request Status"::Cancel);
                        IntOption := AdvsngReq.ChecDocumentAppDepartment();
                        case IntOption of
                            1:
                                begin
                                    AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Pre-Clinical"));
                                end;
                            2:
                                begin
                                    AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Clinical"));
                                end;
                            3:
                                begin
                                    AdvsngReq.SetFilter("Department Type", '=%1|=%2', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical");
                                end;
                            4:
                                begin
                                    AdvsngReq.Setfilter("Department Type", '=%1|=%2|=%3', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical", AdvsngReq."Department Type"::" ");
                                end;
                            0:
                                begin
                                    Error(NotAuthLbl);
                                end;
                        end;
                        if AdvsngReq.FindSet() then begin
                            RejcOrCompAdvisingReq_Page.SetTableView(AdvsngReq);
                            RejcOrCompAdvisingReq_Page.SetRecord(AdvsngReq);
                            RejcOrCompAdvisingReq_Page.Run();
                        end;
                    end;
                }
                // field("Medical Scholars";Rec."Medical Scholars")
                // {
                //     ApplicationArea = Basic, Suite;
                //     DrillDownPageId = "Medical Scholars List";//51027;
                //     trigger OnDrillDown()
                //     var
                //         MedicalSchlrs_Page: Page "Medical Scholars List";
                //         MedicalSch: Record "Medical Scholars";
                //     begin
                //         clear(MedicalSchlrs_Page);
                //         MedicalSch.Reset();
                //         MedicalSch.SetRange(Status, MedicalSch.Status::"Pending for Approval");
                //         if MedicalSch.FindSet() then begin
                //             MedicalSchlrs_Page.SetTableView(MedicalSch);
                //             MedicalSchlrs_Page.SetRecord(MedicalSch);
                //             MedicalSchlrs_Page.Run();
                //         end;
                //     end;
                // }
            }
            cuegroup("Pending Application Cue")
            {
                field("PENDING WITHDRAWAL"; Rec."PENDING WITHDRAWAL")//GAURAV//07.12/22//
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending College Withdrawal";
                    trigger OnDrillDown()
                    var
                    begin
                        clear(ApprovedWithdrawalApprovals1);
                        WithdrawalApprovals1.Reset();
                        WithdrawalApprovals1.SetFilter(status, '%1', WithdrawalApprovals1.Status::"Pending for Approval");
                        if WithdrawalApprovals1.FindSet() then begin
                            ApprovedWithdrawalApprovals1.SetTableView(WithdrawalApprovals1);
                            ApprovedWithdrawalApprovals1.SetRecord(WithdrawalApprovals1);
                            ApprovedWithdrawalApprovals1.Run();
                        end;
                    end;//GAURAV//END//07.12/22//
                }

                field("TOTAL APPROVED WITHDRAWAL"; Rec."TOTAL APPROVED WITHDRAWAL")//GAURAV//07.12/22//
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Approved College Withdrawal";
                    Caption = 'APPROVED WITHDRAWAL';
                    trigger OnDrillDown()
                    var

                    begin
                        clear(ApprovedCollegeWithdrawal);
                        WithdrawalStudent.Reset();
                        WithdrawalStudent.SetFilter("Withdrawal Status", '%1', WithdrawalStudent."Withdrawal Status"::Approved);
                        if WithdrawalStudent.FindSet() then begin
                            ApprovedCollegeWithdrawal.SetTableView(WithdrawalStudent);
                            ApprovedCollegeWithdrawal.SetRecord(WithdrawalStudent);
                            ApprovedCollegeWithdrawal.Run();
                        end;
                    end;//GAURAV//END//07.12/22//
                }
                field("College Withdrawal Apps"; Rec."College Withdrawal Apps")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Pending College Withdrawal";//50858
                }
                field("Course Withdrawal Apps"; Rec."Course Withdrawal Apps")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Withdrawal Approvals";//50592
                    Visible = false;
                }
                field("ELOA Applications"; Rec."ELOA Applications")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Leaves Approvals";//50719
                }
                field("SLOA Applications"; Rec."SLOA Applications")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    DrillDownPageID = "Pending Leaves Approvals";//50719
                }
            }
            cuegroup("Admission Cue")
            {
                field("FAFSA Applied"; Rec."FAFSA TYPE")//GAURAV//07.12/22//
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";
                    Caption = 'FAFSA Applied';
                    trigger OnDrillDown()
                    var

                    begin
                        clear(StudentMasterCS_lPage);
                        StudentMasterCS.Reset();
                        StudentMasterCS.setrange("FAFSA Applied", true);
                        // StudentMasterCS.SetFilter("FAFSA TYPE", '<>%1', '');
                        if StudentMasterCS.FindSet() then begin
                            StudentMasterCS_lPage.SetTableView(StudentMasterCS);
                            StudentMasterCS_lPage.SetRecord(StudentMasterCS);
                            StudentMasterCS_lPage.Run();
                        end;
                    end;//GAURAV//END//07.12/22//
                }

                field("Total Students"; Rec."Total Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("Total Course"; Rec."Total Course")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Course Detail-CS";//50291
                }
            }
            cuegroup("Status Cue")
            {
                field("Active Students"; Rec."Active Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("Probation Students"; Rec."Probation Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("ELOA Students"; Rec."ELOA Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("CLOA Students"; Rec."CLOA Students")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("SLOA Students"; Rec."SLOA Students")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    DrillDownPageId = "Student Details-CS";//50296
                }
            }
        }

    }

    trigger OnOpenPage();
    var
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        AdvisingRequest: Record "Advising Request";
        // MedicalScholar: Record "Medical Scholars";
        IntOption: Integer;
        NotAuthLbl: Label 'You are not authorized to access this page.';
    begin
        Rec.RESET();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
        UserSetup.Get(UserId());
        //Rec.Reset();
        Rec.setfilter("Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
        if UserSetup."Global Dimension 1 Code" <> '' then
            if Strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
                Rec.SetFilter("Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
                EducationSetup.reset();
                EducationSetup.SetRange(EducationSetup."Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                if EducationSetup.FindFirst() then
                    Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year");
            end else begin
                EducationSetup.reset();
                if EducationSetup.FindFirst() then
                    Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year");
            end Else begin
            EducationSetup.reset();
            if EducationSetup.FindFirst() then
                Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year");
        end;

        if Rec.FindFirst() then;

        UserSetup.Get(UserId());
        if (UserSetup."Global Dimension 1 Code" = '9000') or
        (UserSetup."Global Dimension 1 Code" = '9100|9000') or
        (UserSetup."Global Dimension 1 Code" = '9000|9100') then
            VisibleBool := true
        else
            VisibleBool := false;

        // if (UserSetup."Global Dimension 1 Code" = '9000') then
        //     CueVisible := false
        // else
        //     CueVisible := true;

        //For Cue of Pending Advising Request +
        // if DepartmentIsBasicScience() = true then begin
        AdvisingReq.Reset();
        // AdvisingReq.SetRange("Request Status", AdvisingReq."Request Status"::Pending);
        // AdvisingReq.SetFilter("Request Status", '=%1|=%2|=%3', AdvisingReq."Request Status"::Pending, AdvisingReq."Request Status"::Cancel, AdvisingReq."Request Status"::" ");
        AdvisingReq.SetRange("Department Type", AdvisingReq."Department Type"::"EED Pre-Clinical");
        AdvisingReq.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        AdvisingReq.Setfilter("Request Status", '%1|%2', AdvisingReq."Request Status"::Pending, AdvisingReq."Request Status"::" ");
        IntOption := AdvisingReq.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    AdvisingReq.SetFilter("Department Type", format(AdvisingReq."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    AdvisingReq.SetFilter("Department Type", format(AdvisingReq."Department Type"::"EED Clinical"));
                end;
            3:
                begin
                    AdvisingReq.SetFilter("Department Type", '=%1|=%2', AdvisingReq."Department Type"::"EED Clinical", AdvisingReq."Department Type"::"EED Pre-Clinical");
                end;
            4:
                begin
                    AdvisingReq.Setfilter("Department Type", '=%1|=%2|=%3', AdvisingReq."Department Type"::"EED Clinical", AdvisingReq."Department Type"::"EED Pre-Clinical", AdvisingReq."Department Type"::" ");
                end;
            0:
                begin
                    Error(NotAuthLbl);
                end;
        end;
        if AdvisingReq.FindSet() then
            Rec."Pending Advising Request" := AdvisingReq.Count();
        if not AdvisingReq.FindSet() then
            Rec."Pending Advising Request" := 0;
        // end else
        //     "Pending Advising Request" := 0;
        //Message('%1', AdvisingReq.Count());

        //For Cue of Pending Advising Request -

        //For Cue of Approved Advising Request +
        // if DepartmentIsBasicScience() = true then begin
        AdvisingReq.Reset();
        AdvisingReq.SetRange("Request Status", AdvisingReq."Request Status"::Approved);
        // AdvisingReq.SetFilter("Department Type", format(AdvisingReq."Department Type"::"EED Basic Science"));
        IntOption := AdvisingReq.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    AdvisingReq.SetFilter("Department Type", format(AdvisingReq."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    AdvisingReq.SetFilter("Department Type", format(AdvisingReq."Department Type"::"EED Clinical"));
                end;
            3:
                begin
                    AdvisingReq.SetFilter("Department Type", '=%1|=%2', AdvisingReq."Department Type"::"EED Clinical", AdvisingReq."Department Type"::"EED Pre-Clinical");
                end;
            4:
                begin
                    AdvisingReq.Setfilter("Department Type", '=%1|=%2|=%3', AdvisingReq."Department Type"::"EED Clinical", AdvisingReq."Department Type"::"EED Pre-Clinical", AdvisingReq."Department Type"::" ");
                end;
            0:
                begin
                    Error(NotAuthLbl);
                end;
        end;
        if AdvisingReq.FindSet() then
            Rec."Approved Adv. Req." := AdvisingReq.Count();
        if not AdvisingReq.FindSet() then
            Rec."Approved Adv. Req." := 0;
        // end else
        //     "Approved Adv. Req." := 0;
        //For Cue of Approved Advising Request - 

        //For Cue of Rejected or Completed Advising Request +
        // if DepartmentIsBasicScience() = true then begin
        AdvisingReq.Reset();
        AdvisingReq.SetFilter("Request Status", '=%1|=%2|=%3', AdvisingReq."Request Status"::Completed, AdvisingRequest."Request Status"::Rejected, AdvisingRequest."Request Status"::Rescheduled);
        // AdvisingReq.SetFilter("Department Type", format(AdvisingReq."Department Type"::"EED Basic Science"));
        AdvisingReq.Setfilter("Request Status", '%1|%2|%3', AdvisingReq."Request Status"::Completed, AdvisingReq."Request Status"::Rejected, AdvisingReq."Request Status"::Cancel);
        IntOption := AdvisingReq.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    AdvisingReq.SetFilter("Department Type", format(AdvisingReq."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    AdvisingReq.SetFilter("Department Type", format(AdvisingReq."Department Type"::"EED Clinical"));
                end;
            3:
                begin
                    AdvisingReq.SetFilter("Department Type", '=%1|=%2', AdvisingReq."Department Type"::"EED Clinical", AdvisingReq."Department Type"::"EED Pre-Clinical");
                end;
            4:
                begin
                    AdvisingReq.Setfilter("Department Type", '=%1|=%2|=%3', AdvisingReq."Department Type"::"EED Clinical", AdvisingReq."Department Type"::"EED Pre-Clinical", AdvisingReq."Department Type"::" ");
                end;
            0:
                begin
                    Error(NotAuthLbl);
                end;
        end;
        if AdvisingReq.FindSet() then
            Rec."Reje. Comptd. Adv. Req." := AdvisingReq.Count();
        if not AdvisingReq.FindSet() then
            Rec."Reje. Comptd. Adv. Req." := 0;



        WithdrawalStudent.Reset();//GAURAV//07.12.22//
        WithdrawalStudent.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        WithdrawalStudent.SetFilter("Withdrawal Status", '%1', WithdrawalStudent."Withdrawal Status"::Approved);
        if WithdrawalStudent.FindSet() then
            Rec."TOTAL APPROVED WITHDRAWAL" := WithdrawalStudent.Count();
        if not WithdrawalStudent.FindSet() then
            Rec."TOTAL APPROVED WITHDRAWAL" := 0;//END//


        WithdrawalApprovals1.Reset();//GAURAV//07.12.22//
        WithdrawalApprovals1.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        WithdrawalApprovals1.SetFilter(status, '%1', WithdrawalApprovals1.Status::"Pending for Approval");
        if WithdrawalApprovals1.FindSet() then
            Rec."PENDING WITHDRAWAL" := WithdrawalApprovals1.Count();
        if not WithdrawalApprovals1.FindSet() then
            Rec."PENDING WITHDRAWAL" := 0;//END//


        StudentMasterCS.Reset();//GAURAV//07.12.22//
        StudentMasterCS.SetRange(StudentMasterCS."FAFSA Applied", true);
        if StudentMasterCS.FindSet() then
            Rec."FAFSA TYPE" := StudentMasterCS.Count();
        if not StudentMasterCS.FindSet() then
            Rec."FAFSA TYPE" := 0;//END//


        Rec.Modify();
        CurrPage.Update();
    end;

    var
        DocApproverRec: Record "Document Approver Users";
        AdvisingReq: Record "Advising Request";
        VisibleBool: Boolean;
        CueVisible: Boolean;
        PARCount: Integer;
        AARCount: Integer;
        CRARCount: Integer;
        WithdrawalApprovals: Record "Withdrawal Approvals";//GAURAV//07.12/22//
        WithdrawalApprovals1: Record "Withdrawal Approvals";
        ApprovedWithdrawalApprovals: Page "Approved Withdrawal Approvals";
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;
        ApprovedWithdrawalApprovals1: Page "Pending College Withdrawal";
        StudentMasterCS: Record "Student Master-CS";
        StudentMasterCS_lPage: Page "Student Details-CS";//END//
        ApprovedCollegeWithdrawal: Page "Approved College Withdrawal";
        WithdrawalStudent: Record "Withdrawal Student-CS";

}
page 50685 "Withdrawal Approval Card"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       Approve - OnAction()                      Use for Approve .net function
    // 02    CSPL-00059   07/01/2019       Reject - OnAction()                       Use for Reject.net function

    PageType = Card;
    UsageCategory = None;
    SourceTable = "Withdrawal Approvals";
    caption = 'Pending Withdrawal Approval Card';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            Field("Department Name"; Rec."Department Name")
            {
                ApplicationArea = All;
            }
            group(General)
            {
                Editable = Boolean_gBool;
                field("Withdrawal No."; Rec."Withdrawal No.")
                {
                    ApplicationArea = All;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Date"; Rec."Withdrawal Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Semester Start Date"; Rec."Semester Start Date")
                {
                    ApplicationArea = All;
                }
                field("NSLDS Withdrawal Date"; Rec."NSLDS Withdrawal Date")
                {
                    ApplicationArea = All;
                    // Visible = ProcessBoolean;Rec.//CS_SG 20230805
                    Visible = NSLDSBool;//CS_SG 20230805
                }
                field("Date Of Determination"; Rec."Date Of Determination")
                {
                    ApplicationArea = All;
                    // Visible = ProcessBoolean;Rec.//CS_SG 20230805
                    Visible = DODBool;//CS_SG 20230805
                }
                field("Last Date Of Attendance"; Rec."Last Date Of Attendance")
                {
                    ApplicationArea = All;
                    // Visible = ProcessBoolean;//CS_SG 20230805
                    Visible = LDABool;
                    //CS_SG 20230805
                }
                field("Type of Withdrawal"; Rec."Type of Withdrawal")
                {
                    ApplicationArea = All;
                }

                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Waiver Code"; Rec."Waiver Code")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool3;
                    // Visible = Boolean_gBool1;
                    Visible = false;
                    //CS_SG 20230504 Commented Bollean_gBOol1
                }
                field("Waiver Description"; Rec."Waiver Description")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool3;
                    // Visible = Boolean_gBool1;
                    Visible = false;
                    //CS_SG 20230504 Commented Bollean_gBOol1
                }
                field("Waiver Amount"; Rec."Waiver Amount")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool3;
                    // Visible = Boolean_gBool1;
                    Visible = false;
                    //CS_SG 20230504 Commented Bollean_gBOol1
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool3;
                    // Visible = Boolean_gBool1;
                    Visible = false;
                    //CS_SG 20230504 Commented Bollean_gBOol1
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                }
                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Approved for Department"; Rec."Approved for Department")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Comments; Rec.Comments)
                {// CSPL-00307-T1-T1516-CR
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
            part("Withdrawal Student SubjectCard"; "Withdrawal Student SubjectCard")
            {
                visible = Boolean_gBool2;
                Editable = false;
                SubPageLink = "Withdrawal Request No." = FIELD("Withdrawal No.");
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(Processing)
        {

            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Withdrawal Details")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Withdrawal Details';
                trigger OnAction()
                var
                    WithdrawalRec: Record "Withdrawal Student-CS";
                    StudCollegeWithdrawal: Page "Stud. College Withdrawal-CS";
                    StudCourseWithdrawal: Page "Stud. Withdrawal-CS";
                begin
                    WithdrawalRec.Reset();
                    WithdrawalRec.SetRange("No.", Rec."Withdrawal No.");
                    IF WithdrawalRec.FindFirst() then
                        Case Rec."Type of Withdrawal" of
                            Rec."Type of Withdrawal"::"Course-Withdrawal":
                                begin
                                    StudCourseWithdrawal.SetTableView(WithdrawalRec);
                                    StudCourseWithdrawal.Editable := False;
                                    StudCourseWithdrawal.Run();
                                end;
                            Rec."Type of Withdrawal"::"College-Withdrawal":
                                begin
                                    StudCollegeWithdrawal.SetTableView(WithdrawalRec);
                                    StudCollegeWithdrawal.Editable := false;
                                    StudCollegeWithdrawal.Run();
                                end;
                        end;
                end;
            }
            action("Student Ledger Entries")
            {
                ApplicationArea = All;
                Image = CustomerLedger;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;
                //CS_SG 20230504
                trigger OnAction()
                var
                    CustomerLedEntries: Record "Cust. Ledger Entry";
                    StudentMasterRec: Record "Student Master-CS";
                begin
                    StudentMasterRec.Get(Rec."Student No.");
                    CustomerLedEntries.FilterGroup(0);
                    CustomerLedEntries.reset();
                    CustomerLedEntries.SetRange("Customer No.", StudentMasterRec."Original Student No.");
                    CustomerLedEntries.SetRange(Semester, StudentMasterRec.Semester);
                    CustomerLedEntries.SetFilter("Enrollment No.", StudentMasterRec."Enrollment No.");
                    if CustomerLedEntries.FindFirst() then begin
                        page.Run(25, CustomerLedEntries);
                        CustomerLedEntries.FilterGroup(2);
                    end;
                end;
            }
            action("&Calculate")
            {
                ApplicationArea = All;
                Caption = 'Calculate Waiver';
                Image = Calculate;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                // Visible = Boolean_gBool1;
                Visible = false;
                //CS_SG 20230504
                trigger OnAction()
                begin
                    if Rec."Waiver Calculation Allowed" = true then begin
                        if Rec."Waiver Calculated" then
                            Error('Waiver Calculation is already done');

                        IF CONFIRM(Text005Lbl, FALSE, Rec."Withdrawal No.") THEN BEGIN
                            if Rec."Waiver Code" = '' then
                                Error('Waiver Code must have a value in it for student No. %1', Rec."Withdrawal No.");
                            IF FeeGeneration.CheckFeeGenerated(Rec."Student No.", '', '', '', false) = true Then begin
                                Rec.Validate("Waiver Amount", WithdrawalCreditMemoCreation(Rec."Student No.", Rec.Course, Rec."Academic Year", Rec.Semester));
                                Rec."Waiver Calculated" := true;
                                Rec.Modify();
                            End else
                                Error('Fee is not generated');

                            WithdrawalApprovalRec.Reset();
                            WithdrawalApprovalRec.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                            if WithdrawalApprovalRec.FindSet() then begin
                                repeat
                                    WithdrawalApprovalRec."Waiver Code" := Rec."Waiver Code";
                                    WithdrawalApprovalRec."Waiver Description" := Rec."Waiver Description";
                                    WithdrawalApprovalRec."Waiver Amount" := Rec."Waiver Amount";
                                    WithdrawalApprovalRec."Approved Amount" := Rec."Approved Amount";
                                    WithdrawalApprovalRec.Modify();
                                until WithdrawalApprovalRec.next() = 0;
                            end;
                            Message(Text006Lbl, Rec."Withdrawal No.");
                        end;
                    end else
                        Error('You do not have permission');
                end;
            }
            action("&Approve")
            {
                ApplicationArea = All;//Nitin
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = RejectApproveBoolean;
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    StudentTimelineRec: Record "Student Time Line";
                    CodeUnit50004: Codeunit "Hold Bulk Upload";
                    RecStudent: Record "Student Master-CS";
                    LeavesApprovals: Record "Withdrawal Approvals";
                    WithdrawalDepartment: Record "Withdrawal Department";
                    WithdrawalDepartment1: Record "Withdrawal Department";
                    Int: Integer;
                    Int1: Integer;
                begin

                    // if ("Waiver Calculation Allowed") AND ("Waiver Calculated" = false) then
                    //     if Confirm(Text007Lbl, false, "Withdrawal No.") then begin
                    //     end else
                    //         exit;
                    /* if ("Approved Amount" = 0) AND ("Type of Withdrawal" = "Type of Withdrawal"::"College-Withdrawal") then
                        if Confirm(Text0010Lbl, false, "Withdrawal No.") then begin
                        end else
                            exit;Rec.*/ //CS_SG
                    // if "Waiver Amount" <> "Approved Amount" then
                    //     if Confirm(Text008Lbl, false, "Withdrawal No.") then begin
                    //     end else
                    //         exit;

                    IF CONFIRM(Text001Lbl, FALSE, Rec."Withdrawal No.") THEN BEGIN
                        if Rec."Approved Amount" > 0 then
                            Rec.TestField("Waiver Code");
                        // if "Waiver Code" <> '' then
                        //     TestField("Approved Amount");

                        if Rec.Status = Rec.Status::Approved then
                            Error('Status is already Approved');
                        //Nitin
                        if Rec."Rejection Remark" <> '' then
                            Error('Rejection remark must be blank');

                        IF Rec."Final Approval" then begin
                            WithdrawalApprovalRec.SetRange("Student No.", Rec."Student No.");
                            WithdrawalApprovalRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                            WithdrawalApprovalRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            WithdrawalApprovalRec.SetFilter("Status", '%1', WithdrawalApprovalRec.Status::"Pending for Approval");
                            WithdrawalApprovalRec.SetRange("Final Approval", false);
                            IF WithdrawalApprovalRec.findfirst() then
                                error('Department approval is pending for : %1', WithdrawalApprovalRec."Department Name");

                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved By" := UserId();
                            Rec."Approved On" := WorkDate();
                            Rec."Approved In Days" := Rec."Approved On" - Rec."Application Date";
                            Rec.Modify();
                            //WithdrawalReqAPProvMail();
                            //11.8.2021-->Start
                            Clear(StudentMaster);
                            IF StudentMaster.Get(Rec."Student No.") then begin
                                IF Studentmaster."Student SFP Initiation" <> 0 then begin
                                    StudentMaster.Validate(StudentMaster."SAFI Sync", StudentMaster."SAFI Sync"::Pending);
                                    StudentMaster.Modify(true);
                                end;
                            end;
                            //11.8.2021-->END
                            IF (Rec."Approved Amount" <> 0) then begin
                                CreditMemoGenJournalLineInsert(Rec."Student No.", Rec."Approved Amount", Rec."Waiver Code", Rec."Waiver Description");
                            end;
                            //WithdrawalFinalMail("Student No.", "Global Dimension 1 Code");
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Withdrawal") + ' ' + Rec."Withdrawal No." + ' is Approved by ' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                            WebServices.Hello_Sign_Download_Email_Sent(Rec."Withdrawal No.", Rec."Student No.", UserId, 'WITHDRAWL');//CSPL-00307
                        end else begin
                            //Gourav 11.4.22
                            WithdrawalDepartment.Reset();
                            WithdrawalDepartment.SetRange("Department Code", Rec."Approved for Department");
                            WithdrawalDepartment.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            IF Rec."Type of Withdrawal" IN [Rec."Type of Withdrawal"::"Course-Withdrawal", Rec."Type of Withdrawal"::"College-Withdrawal"] then begin
                                WithdrawalDepartment.SetRange("Document Type", WithdrawalDepartment.GetDocumentType(Rec."Student No."));//CSPL-00307-T1-T1516-CR    
                            end;
                            IF WithdrawalDepartment.FindFirst() then begin
                                rec.sequence := WithdrawalDepartment.Sequence;
                                rec.Modify();
                                IF (WithdrawalDepartment.Sequence > 1) then begin
                                    Int1 := 1;
                                    For Int := WithdrawalDepartment.Sequence Downto Int1 do begin
                                        WithdrawalDepartment1.Reset();
                                        WithdrawalDepartment1.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                        WithdrawalDepartment1.SetRange("Document Type", WithdrawalDepartment."Document Type");
                                        WithdrawalDepartment1.SetRange(Sequence, Int - 1);
                                        IF WithdrawalDepartment1.FindFirst() then begin
                                            LeavesApprovals.Reset();
                                            LeavesApprovals.SetRange("Approved for Department", WithdrawalDepartment1."Department Code");
                                            LeavesApprovals.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                                            LeavesApprovals.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                                            LeavesApprovals.Setfilter(Status, '%1|%2', LeavesApprovals.Status::"Pending for Approval", LeavesApprovals.Status::Rejected);
                                            If LeavesApprovals.FindFirst() then
                                                Error('Department approval has been pending from %1', LeavesApprovals."Department Name");
                                        end;
                                    end;
                                End;
                                //SendForApproval_gFnc(Rec);

                                //End //GMCS//11//4//2022

                            end;
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved By" := UserId();
                            Rec."Approved On" := WorkDate();
                            Rec."Approved In Days" := Rec."Approved On" - Rec."Application Date";
                            Rec.Modify();
                            // WithdrawalApprovalDepartmentMail("Student No.");Rec.// as per stuti departmental approval notification should not go to students
                            // WithdrawalReqAPProvMail();Rec.
                            // WithdrawalSeqenceApproverMail(Rec."Student No.");//GMCSCOM
                            //CSPL-00307-T1-T1516-CR
                            //11.8.2021-->Start
                            Clear(StudentMaster);
                            IF StudentMaster.Get(Rec."Student No.") then begin
                                IF Studentmaster."Student SFP Initiation" <> 0 then begin
                                    StudentMaster.Validate(StudentMaster."SAFI Sync", StudentMaster."SAFI Sync"::Pending);
                                    StudentMaster.Modify(true);
                                end;
                            end;
                            //11.8.2021-->END
                            WithdrawalApprovalRec.Reset();
                            WithdrawalApprovalRec.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                            WithdrawalApprovalRec.SetRange("Final Approval", false);
                            WithdrawalApprovalRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                            WithdrawalApprovalRec.SetFilter(WithdrawalApprovalRec.Status, '<>%1', WithdrawalApprovalRec.Status::Approved);
                            if not WithdrawalApprovalRec.FindFirst() then
                                //WithdrawalRequestMailtoFinalApprover(Rec."Student No.", Rec."Approved for Department", Rec."Global Dimension 1 Code");//GMCSCOM

                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Withdrawal") + ' ' + Rec."Withdrawal No." + ' is Approved by ' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                            WebServices.Hello_Sign_Download_Email_Sent(Rec."Withdrawal No.", Rec."Student No.", UserId, 'WITHDRAWL');//CSPL-00307
                        end;


                        WithdrawalApprovalRec.Reset();
                        WithdrawalApprovalRec.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                        WithdrawalApprovalRec.SetFilter(WithdrawalApprovalRec.Status, '<>%1', WithdrawalApprovalRec.Status::Approved);
                        if not WithdrawalApprovalRec.FindFirst() then begin
                            WithdrawalStudentRec.Reset();
                            WithdrawalStudentRec.SetRange("No.", Rec."Withdrawal No.");
                            if WithdrawalStudentRec.FindFirst() then begin
                                WithdrawalStudentRec."Withdrawal Status" := WithdrawalStudentRec."Withdrawal Status"::Approved;
                                WithdrawalStudentRec.Modify();

                                if WithdrawalStudentRec."Type of Withdrawal" = WithdrawalStudentRec."Type of Withdrawal"::"College-Withdrawal" Then
                                    if StudentMasterRec.Get(Rec."Student No.") then begin
                                        StudentMasterRec."NSLDS Withdrawal Date" := Rec."NSLDS Withdrawal Date";
                                        StudentMasterRec."Date Of Determination" := Rec."Date Of Determination";
                                        StudentMasterRec."Last Date Of Attendance" := Rec."Last Date Of Attendance";
                                        StudentMasterRec.Validate(StudentMasterRec.Status, StudentStatusMangementCod.WithdwaralSignoff(Rec."Student No.", StudentMasterRec.Status, Rec."Global Dimension 1 Code"));
                                        StudentMasterRec."Student Return to Lender" := StudentMasterRec."Student Return to Lender"::Pending;
                                        //CSPL-00307
                                        IF StudentMasterRec.Status = 'WITH' then begin
                                            CodeUnit50004.OnGroundCheckInCompletedGroupDisable(StudentMasterRec."No.");
                                            Codeunit50004.OnGroundCheckInStudentGroupDisable(StudentMasterRec."No.");
                                        end;
                                        //CSPL-00307
                                        StudentMasterRec.Modify();
                                    end;
                            end;
                        end;


                        CurrPage.Update();
                        CurrPage.Close();
                        Message(Text002Lbl, Rec."Withdrawal No.");
                    end else
                        exit;
                end;
            }
            action("&Process")
            {
                ApplicationArea = All;
                Caption = 'Process';
                Image = Process;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = ProcessBoolean;
                trigger OnAction()
                var
                    //RecStudent: Record "Student Master-CS";
                    StudentTimeLineRec: Record "Student Time Line";
                    StudentMaster: Record "Student Master-CS";
                    Codeunit50004: Codeunit "Hold Bulk Upload";
                    DepartmentMasterRec: Record "Withdrawal Department";
                    LeavesApprovals: Record "Withdrawal Approvals";
                    WithdrawalDepartment: Record "Withdrawal Department";
                    WithdrawalDepartment1: Record "Withdrawal Department";
                    Int: Integer;
                    Int1: Integer;
                begin
                    // if ("Waiver Calculation Allowed") AND ("Waiver Calculated" = false) then
                    //     if Confirm(Text007Lbl, false, "Withdrawal No.") then begin
                    //     end else
                    //         exit;
                    // if "Waiver Amount" <> "Approved Amount" then
                    //     if Confirm(Text008Lbl, false, "Withdrawal No.") then begin
                    //     end else
                    //         exit;

                    DepartmentMasterRec.Reset();
                    DepartmentMasterRec.SetFilter("User Name", DepartmentMasterRec.GetUserGroup());
                    DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
                    DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec.GetDocumentType(Rec."Student No."));//CSPL-00307-T1-T1516-CR
                    DepartmentMasterRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                    IF DepartmentMasterRec.FindFirst() then begin
                        if DepartmentMasterRec."Update NSLDS" then
                            Rec.TestField("NSLDS Withdrawal Date");
                        IF DepartmentMasterRec."Update DOD" then
                            Rec.TestField("Date Of Determination");
                        IF DepartmentMasterRec."Update LDA" then
                            Rec.TestField("Last Date Of Attendance");
                    end;
                    IF CONFIRM(Text001Lbl, FALSE, Rec."Withdrawal No.") THEN BEGIN
                        if Rec."Approved Amount" > 0 then
                            Rec.TestField("Waiver Code");
                        // if "Waiver Code" <> '' then
                        //     TestField("Approved Amount");

                        if Rec.Status = Rec.Status::Approved then
                            Error('Status is already Approved');
                        if Rec."Rejection Remark" <> '' then
                            Error('Rejection remark must be blank');

                        IF Rec."Final Approval" then begin
                            WithdrawalApprovalRec.SetRange("Student No.", Rec."Student No.");
                            WithdrawalApprovalRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                            WithdrawalApprovalRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            WithdrawalApprovalRec.SetFilter("Status", '%1', WithdrawalApprovalRec.Status::"Pending for Approval");
                            WithdrawalApprovalRec.SetRange("Final Approval", false);
                            IF WithdrawalApprovalRec.findfirst() then
                                error('Department approval is pending for : %1', WithdrawalApprovalRec."Department Name");

                            Rec.Status := Rec.Status::Approved;

                            Rec."Approved By" := UserId();
                            Rec."Approved On" := WorkDate();
                            Rec."Approved In Days" := Rec."Approved On" - Rec."Application Date";
                            Rec.Modify();
                            //WithdrawalReqAPProvMail();
                            //11.8.2021-->Start
                            Clear(StudentMaster);
                            IF StudentMaster.Get(Rec."Student No.") then begin
                                IF Studentmaster."Student SFP Initiation" <> 0 then begin
                                    StudentMaster.Validate(StudentMaster."SAFI Sync", StudentMaster."SAFI Sync"::Pending);
                                    StudentMaster.Modify(true);
                                end;
                            end;
                            //11.8.2021-->END
                            ChangeExamLinesasWith(Rec."Student No.", Rec."Last Date Of Attendance");

                            IF (Rec."Approved Amount" <> 0) then begin
                                CreditMemoGenJournalLineInsert(Rec."Student No.", Rec."Approved Amount", Rec."Waiver Code", Rec."Waiver Description");
                            end;
                            //WithdrawalFinalMail(Rec."Student No.", Rec."Global Dimension 1 Code");GMCSCOM
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Withdrawal") + ' ' + Rec."Withdrawal No." + ' is Approved by ' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                            WebServices.Hello_Sign_Download_Email_Sent(Rec."Withdrawal No.", Rec."Student No.", UserId, 'WITHDRAWL');//CSPL-00307
                        end else begin
                            //Gourav 11.4.22
                            WithdrawalDepartment.Reset();
                            WithdrawalDepartment.SetRange("Department Code", Rec."Approved for Department");
                            WithdrawalDepartment.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            IF Rec."Type of Withdrawal" IN [Rec."Type of Withdrawal"::"Course-Withdrawal", Rec."Type of Withdrawal"::"College-Withdrawal"] then begin
                                WithdrawalDepartment.SetRange("Document Type", WithdrawalDepartment.GetDocumentType(Rec."Student No."));//CSPL-00307-T1-T1516-CR    
                            end;
                            IF WithdrawalDepartment.FindFirst() then begin
                                rec.sequence := WithdrawalDepartment.Sequence;
                                rec.Modify();
                                IF (WithdrawalDepartment.Sequence > 1) then begin
                                    Int1 := 1;
                                    For Int := WithdrawalDepartment.Sequence Downto Int1 do begin
                                        WithdrawalDepartment1.Reset();
                                        WithdrawalDepartment1.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                        WithdrawalDepartment1.SetRange("Document Type", WithdrawalDepartment."Document Type");
                                        WithdrawalDepartment1.SetRange(Sequence, Int - 1);
                                        IF WithdrawalDepartment1.FindFirst() then begin
                                            LeavesApprovals.Reset();
                                            LeavesApprovals.SetRange("Approved for Department", WithdrawalDepartment1."Department Code");
                                            LeavesApprovals.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                                            LeavesApprovals.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                                            LeavesApprovals.Setfilter(Status, '%1|%2', LeavesApprovals.Status::"Pending for Approval", LeavesApprovals.Status::Rejected);
                                            If LeavesApprovals.FindFirst() then
                                                Error('Department approval has been pending from %1', LeavesApprovals."Department Name");
                                        end;
                                    end;
                                End;
                                //SendForApproval_gFnc(Rec);

                                //End //GMCS//11//4//2022

                            end;
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved By" := UserId();
                            Rec."Approved On" := WorkDate();
                            Rec."Approved In Days" := Rec."Approved On" - Rec."Application Date";
                            Rec.Modify();
                            // WithdrawalReqAPProvMail();//CSPL-00307-T1-T1516-CR //Block Student Mail on Each Department Approval
                            //11.8.2021-->Start
                            Clear(StudentMaster);
                            IF StudentMaster.Get(Rec."Student No.") then begin
                                IF StudentMaster."Student SFP Initiation" <> 0 then begin
                                    StudentMaster.Validate(StudentMaster."SAFI Sync", StudentMaster."SAFI Sync"::Pending);
                                    StudentMaster.Modify(True);
                                end;
                            end;
                            //11.8.2021-->END
                            // WithdrawalApprovalDepartmentMail("Student No.");Rec.//CSPL-00307-T1-T1516-CR // Block Student Mail on Each Department Approval
                            /// WithdrawalSeqenceApproverMail(Rec."Student No.");GMCSCOM
                            WithdrawalApprovalRec.Reset();//CSPL-00307-T1-T1516-CR
                            WithdrawalApprovalRec.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                            WithdrawalApprovalRec.SetRange("Final Approval", false);
                            WithdrawalApprovalRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                            WithdrawalApprovalRec.SetFilter(WithdrawalApprovalRec.Status, '<>%1', WithdrawalApprovalRec.Status::Approved);
                            if not WithdrawalApprovalRec.FindFirst() then
                                // WithdrawalRequestMailtoFinalApprover(Rec."Student No.", Rec."Approved for Department", Rec."Global Dimension 1 Code");GMCSCOM
                                StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Withdrawal") + ' ' + Rec."Withdrawal No." + ' is Approved by ' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                            WebServices.Hello_Sign_Download_Email_Sent(Rec."Withdrawal No.", Rec."Student No.", UserId, 'WITHDRAWL');//CSPL-00307    
                        end;


                        WithdrawalApprovalRec.Reset();
                        WithdrawalApprovalRec.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                        WithdrawalApprovalRec.SetFilter(WithdrawalApprovalRec.Status, '<>%1', WithdrawalApprovalRec.Status::Approved);
                        if not WithdrawalApprovalRec.FindFirst() then begin

                            WithdrawalStudentRec.Reset();
                            WithdrawalStudentRec.SetRange("No.", Rec."Withdrawal No.");
                            if WithdrawalStudentRec.FindFirst() then begin
                                WithdrawalStudentRec."Withdrawal Status" := WithdrawalStudentRec."Withdrawal Status"::Approved;
                                WithdrawalStudentRec."NSLDS Withdrawal Date" := Rec."NSLDS Withdrawal Date";
                                WithdrawalStudentRec."Date Of Determination" := Rec."Date Of Determination";
                                WithdrawalStudentRec."Last Date Of Attendance" := Rec."Last Date Of Attendance";
                                WithdrawalStudentRec."Type of Withdrawal" := Rec."Type of Withdrawal";
                                WithdrawalStudentRec.Modify();//Due to blank issue 09 May 2023
                                if WithdrawalStudentRec."Type of Withdrawal" = WithdrawalStudentRec."Type of Withdrawal"::"College-Withdrawal" Then
                                    if StudentMasterRec.Get(Rec."Student No.") then begin
                                        StudentMasterRec."NSLDS Withdrawal Date" := Rec."NSLDS Withdrawal Date";
                                        StudentMasterRec."Date Of Determination" := Rec."Date Of Determination";
                                        StudentMasterRec."Last Date Of Attendance" := Rec."Last Date Of Attendance";
                                        StudentMasterRec.Validate(StudentMasterRec.Status, StudentStatusMangementCod.WithdwaralSignoff(Rec."Student No.", StudentMasterRec.Status, Rec."Global Dimension 1 Code"));
                                        StudentMasterRec."Student Return to Lender" := StudentMasterRec."Student Return to Lender"::Pending;
                                        //CSPL-00307
                                        IF StudentMasterRec.Status = 'WITH' then begin
                                            StudentMasterRec."OLR Completed" := false;
                                            StudentMasterRec."OLR Completed Date" := 0D;
                                            If StudentMasterRec."Student Group" = StudentMasterRec."Student Group"::"On-Ground Check-In" then
                                                CodeUnit50004.OnGroundCheckInStudentGroupDisable(StudentMasterRec."No.");
                                            IF StudentMasterRec."Student Group" = StudentMasterRec."Student Group"::"On-Ground Check-In Completed" then
                                                CodeUnit50004.OnGroundCheckInCompletedGroupDisable(StudentMasterRec."No.");
                                            StudentMasterRec."Student Group" := StudentMasterRec."Student Group"::" ";
                                            StudentMasterRec."On Ground Check-In By" := '';
                                            StudentMasterRec."On Ground Check-In On" := 0D;
                                            StudentMasterRec."On Ground Check-In Complete By" := '';
                                            StudentMasterRec."On Ground Check-In Complete On" := 0D;
                                            StudentMasterRec."OLR Email Sent" := false;
                                            StudentMaster."OLR Email Sent Date" := 0D;
                                        end;
                                        //CSPL-00307
                                        StudentMasterRec.Modify();
                                    end;
                            end;
                        end;

                        CurrPage.Update();
                        CurrPage.Close();
                        Message(Text009Lbl, Rec."Withdrawal No.");
                    end else
                        exit;
                end;
            }
            action("&Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = RejectApproveBoolean;
                trigger OnAction()
                var
                    StudentTimeLineRec: Record "Student Time Line";
                begin
                    if Rec.Status = Rec.status::Rejected then
                        Error('Status is already rejected');
                    IF CONFIRM(Text003Lbl, FALSE, Rec."Withdrawal No.") THEN BEGIN
                        if Rec.Status = Rec.Status::Approved then
                            Error('Approved Application cannot be Rejected');
                        IF Rec."Final Approval" = true then
                            Error('Final Approval must be false, you cannot reject');
                        IF Rec."Approved Amount" <> 0 then
                            Error('You cannot reject the Application No. %1,Approved amount is already calculated');

                        Rec.TestField("Rejection Remark");

                        //if "Type of Withdrawal" = "Type of Withdrawal"::"College-Withdrawal" then begin
                        // Status := Status::Rejected;
                        // "Rejected On" := WorkDate();
                        // "Rejected By" := UserId();
                        // Modify();

                        //end;Rec.     Due to Reject the whole department documents

                        //if "Type of Withdrawal" = "Type of Withdrawal"::"Course-Withdrawal" then begin
                        WithdrawalApprovalRec.Reset();
                        WithdrawalApprovalRec.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                        if WithdrawalApprovalRec.FindSet() then
                            repeat
                                WithdrawalApprovalRec.Status := WithdrawalApprovalRec.Status::Rejected;
                                WithdrawalApprovalRec."Rejected On" := WorkDate();
                                WithdrawalApprovalRec."Rejected By" := UserId();
                                WithdrawalApprovalRec.Modify();

                            until WithdrawalApprovalRec.next() = 0;

                        WithdrawalStudentRec.Reset();
                        WithdrawalStudentRec.SetRange("No.", Rec."Withdrawal No.");
                        if WithdrawalStudentRec.FindFirst() then begin
                            WithdrawalStudentRec."Withdrawal Status" := WithdrawalStudentRec."Withdrawal Status"::Rejected;
                            WithdrawalStudentRec.Modify();
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Withdrawal") + ' ' + Rec."Withdrawal No." + ' is Rejected by ' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                        end;
                        // end;


                        // WithdrawalRejectionMail(Rec."Student No.");GMCSCOM

                        CurrPage.Update();
                        CurrPage.Close();
                        Message(Text004Lbl, Rec."Withdrawal No.");
                    end else
                        exit;
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Boolean_gBool := true;
        If (Rec.Status = Rec.Status::Approved) then
            Boolean_gBool := false;

        Boolean_gBool1 := true;
        Boolean_gBool2 := false;
        If (Rec.Status = Rec.Status::"Pending for Approval") AND (Rec."Type of Withdrawal" = Rec."Type of Withdrawal"::"Course-Withdrawal") then begin
            Boolean_gBool1 := false;
            Boolean_gBool2 := true;
        end;

        Boolean_gBool3 := false;
        If Rec."Waiver Calculation Allowed" then
            Boolean_gBool3 := true;

        ProcessBoolean := false;
        If CheckEntryFromPortal(Rec."Withdrawal No.") then begin
            if (Rec."Final Approval") AND (Rec.Status = Rec.Status::"Pending for Approval") AND (CheckHelloSignConfirmed(Rec."Withdrawal No.")) then
                ProcessBoolean := true;
        end Else
            if (Rec."Final Approval") AND (Rec.Status = Rec.Status::"Pending for Approval") then
                ProcessBoolean := true;

        RejectApproveBoolean := false;
        If CheckEntryFromPortal(Rec."Withdrawal No.") then begin
            if (Rec."Final Approval" = false) AND (Rec.Status = Rec.Status::"Pending for Approval") AND (CheckHelloSignConfirmed(Rec."Withdrawal No.")) then
                RejectApproveBoolean := true;
        end Else begin
            if (Rec."Final Approval" = false) AND (Rec.Status = Rec.Status::"Pending for Approval") then
                RejectApproveBoolean := true;
        end;
        //CS_SG 20230805
        NSLDSBool := false;
        LDABool := false;
        DODBool := false;
        SemesterMaster.Reset();
        SemesterMaster.SetRange(Code, Rec.Semester);
        if SemesterMaster.FindFirst() then;
        WithdrawlDepartment.Reset();
        WithdrawlDepartment.SetRange("Department Name", Rec."Department Name");
        if SemesterMaster.Sequence > 5 then
            WithdrawlDepartment.SetRange("Document Type", WithdrawlDepartment."Document Type"::"Withdrawal CLN")
        else
            WithdrawlDepartment.SetRange("Document Type", WithdrawlDepartment."Document Type"::Withdrawal);
        if WithdrawlDepartment.FindFirst() then begin
            if WithdrawlDepartment."Update NSLDS" = true then
                NSLDSBool := true;
            if WithdrawlDepartment."Update DOD" = true then
                DODBool := true;
            if WithdrawlDepartment."Update LDA" = true then
                LDABool := true;
        end;
    end;

    trigger OnAfterGetRecord()
    Begin

        Boolean_gBool := true;
        If (Rec.Status = Rec.Status::Approved) then
            Boolean_gBool := false;

        Boolean_gBool1 := true;
        Boolean_gBool2 := false;
        If (Rec.Status = Rec.Status::"Pending for Approval") AND (Rec."Type of Withdrawal" = Rec."Type of Withdrawal"::"Course-Withdrawal") then begin
            Boolean_gBool1 := false;
            Boolean_gBool2 := true;
        end;
        Boolean_gBool3 := false;
        If Rec."Waiver Calculation Allowed" then
            Boolean_gBool3 := true;

        ProcessBoolean := false;
        If CheckEntryFromPortal(Rec."Withdrawal No.") then begin
            if (Rec."Final Approval") AND (CheckHelloSignConfirmed(Rec."Withdrawal No.")) then
                ProcessBoolean := true;
        end Else
            IF Rec."Final Approval" then
                ProcessBoolean := true;

        If CheckEntryFromPortal(Rec."Withdrawal No.") then begin
            if (CheckHelloSignConfirmed(Rec."Withdrawal No.")) then
                RejectApproveBoolean := true;
        end Else
            RejectApproveBoolean := true;

        if Rec."Final Approval" then
            RejectApproveBoolean := false;


    end;

    procedure WithdrawalCreditMemoCreation(StudentNo: Code[20]; CourseCode: Code[20]; AcademicYear: Code[20]; Semester: Code[10]): Decimal
    var
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        RecFeeCourseHdr: Record "Fee Course Head-CS";
        RecFeeCourseLine: Record "Fee Course Line-CS";
        //RecSAPFeeCode: Record "SAP Fee Code";
        FeeComponent: Record "Fee Component Master-CS";
        CourseRec: Record "Course Master-CS";
        recClassAttendanceLine: Record "Class Attendance Line-CS";
        AmountFinalCal: Decimal;
        MultCalenderDayCal: Integer;
        WithdrawalDayCalculation: Integer;
        AttendedPer: Decimal;
        PerFinal: Decimal;
        FinalDay: Integer;
        AmountSum: Decimal;
        SemFee: Decimal;
        GVFee: Decimal;

    begin
        MultCalenderDayCal := 0;
        WithdrawalDayCalculation := 0;
        AttendedPer := 0;
        PerFinal := 0;
        FinalDay := 0;
        StudentRec.get(StudentNo);
        EducationSetupCS.RESET();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        IF EducationSetupCS.FINDFIRST() THEN
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                EducationMultiEventCalCS.RESET();
                EducationMultiEventCalCS.Setfilter("Event Code", '%1', Format(EducationSetupCS."Even/Odd Semester"::SPRING));
                EducationMultiEventCalCS.SETRANGE("Academic Year", StudentRec."Academic Year");
                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                    IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::" " then
                        Error('Withdrawal End Date Calculation must not be blank');
                    EducationSetupCS.TestField(EducationSetupCS."Withdrawal Percentage");
                    IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::"Apply Date" then Begin
                        MultCalenderDayCal := ((EducationMultiEventCalCS."Revised End Date") - (EducationMultiEventCalCS."Start Date") + 1);
                        WithdrawalDayCalculation := (Rec."Application Date") - (EducationMultiEventCalCS."Start Date") + 1;
                    End else
                        IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::"Attendance Date" then begin
                            RecClassAttendanceLine.Reset();
                            RecClassAttendanceLine.SetRange("Student No.", StudentNo);
                            RecClassAttendanceLine.SetRange(Semester, Semester);
                            RecClassAttendanceLine.SetRange("Academic Year", AcademicYear);
                            RecClassAttendanceLine.SetRange("Attendance Type", RecClassAttendanceLine."Attendance Type"::Present);
                            IF recClassAttendanceLine.FindLast() then begin
                                MultCalenderDayCal := (EducationMultiEventCalCS."Revised End Date") - (EducationMultiEventCalCS."Start Date") + 1;
                                WithdrawalDayCalculation := (recClassAttendanceLine.Date) - (EducationMultiEventCalCS."Start Date") + 1;
                            end;
                        end;
                    FinalDay := MultCalenderDayCal - WithdrawalDayCalculation;
                    AttendedPer := (WithdrawalDayCalculation * 100) / MultCalenderDayCal;
                    PerFinal := (FinalDay * 100) / MultCalenderDayCal;
                    IF AttendedPer < EducationSetupCS."Withdrawal Percentage" then begin
                        RecFeeCourseHdr.reset();
                        RecFeeCourseHdr.Setrange("Course Code", CourseCode);
                        RecFeeCourseHdr.SetRange("Academic Year", AcademicYear);
                        RecFeeCourseHdr.SETRANGE("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                        RecFeeCourseHdr.SETRANGE("Other Fees", false);
                        CourseRec.Get(CourseCode);
                        If CourseRec."Admitted Year Wise Fee" then
                            RecFeeCourseHdr.SETRANGE(RecFeeCourseHdr."Admitted Year", StudentRec."Admitted Year");
                        If CourseRec."Semester Wise Fee" then
                            RecFeeCourseHdr.SETRANGE(RecFeeCourseHdr.Semester, Semester);
                        RecFeeCourseHdr.SETRANGE(Year, StudentRec.Year);
                        IF RecFeeCourseHdr.FindFirst() then begin
                            AmountSum := 0;
                            AmountFinalCal := 0;
                            RecFeeCourseLine.Reset();
                            RecFeeCourseLine.SetRange("Document No.", RecFeeCourseHdr."No.");
                            IF RecFeeCourseLine.FindFirst() then begin
                                Repeat
                                    AmounttoPay := FeeGeneration.StudentTotalFee(StudentRec."No.", RecFeeCourseLine."Fee Code", '', '', False, SemFee, GVFee);
                                    if AmounttoPay <> 0 then begin
                                        FeeComponent.Get(RecFeeCourseLine."Fee Code");
                                        if FeeComponent."Fee Group" = FeeComponent."Fee Group"::Institutional then
                                            AmountSum += AmounttoPay;
                                    end;
                                // RecSAPFeeCode.Reset();
                                // RecSAPFeeCode.SetRange("SAP Code", RecFeeCourseLine."Fee Code");
                                // RecSAPFeeCode.SetFilter("Fee Group", '%1', RecSAPFeeCode."Fee Group"::Institutional);
                                // if RecSAPFeeCode.FindFirst() then
                                //     AmountSum += RecFeeCourseLine.Amount;
                                until RecFeeCourseLine.Next() = 0;
                                AmountFinalCal := (AmountSum * PerFinal) / 100;
                                exit(AmountFinalCal);
                            end;
                            // WithdrawalStudentRec.Reset();
                            // WithdrawalStudentRec.SetRange("No.", "Withdrawal No.");
                            // if WithdrawalStudentRec.FindFirst() then;
                            // IF (AmountFinalCal <> 0) AND (Calculation = false) then
                            //     CreditMemoGenJournalLineInsert(StudentNo, AmountFinalCal, WithdrawalStudentRec."Reason for Leaving");
                        end;
                    end;
                END;
            END ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.Setfilter("Event Code", '%1', Format(EducationSetupCS."Even/Odd Semester"::FALL));
                    EducationMultiEventCalCS.SETRANGE("Academic Year", StudentRec."Academic Year");
                    IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                        IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::" " then
                            Error('Withdrawal End Date Calculation must not be blank');
                        EducationSetupCS.TestField(EducationSetupCS."Withdrawal Percentage");
                        IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::"Apply Date" then Begin
                            MultCalenderDayCal := ((EducationMultiEventCalCS."Revised End Date") - (EducationMultiEventCalCS."Start Date") + 1);
                            WithdrawalDayCalculation := (Rec."Application Date") - (EducationMultiEventCalCS."Start Date");
                        End else
                            IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::"Attendance Date" then begin
                                RecClassAttendanceLine.Reset();
                                RecClassAttendanceLine.SetRange("Student No.", StudentNo);
                                RecClassAttendanceLine.SetRange(Semester, Semester);
                                RecClassAttendanceLine.SetRange("Academic Year", AcademicYear);
                                RecClassAttendanceLine.SetRange("Attendance Type", RecClassAttendanceLine."Attendance Type"::Present);
                                IF recClassAttendanceLine.FindLast() then begin
                                    MultCalenderDayCal := (EducationMultiEventCalCS."Revised End Date") - (EducationMultiEventCalCS."Start Date");
                                    WithdrawalDayCalculation := (recClassAttendanceLine.Date) - (EducationMultiEventCalCS."Start Date");
                                end;
                            end;

                        FinalDay := MultCalenderDayCal - WithdrawalDayCalculation;
                        AttendedPer := (WithdrawalDayCalculation * 100) / MultCalenderDayCal;
                        PerFinal := (FinalDay * 100) / MultCalenderDayCal;
                        IF AttendedPer < EducationSetupCS."Withdrawal Percentage" then begin

                            RecFeeCourseHdr.reset();
                            RecFeeCourseHdr.Setrange("Course Code", CourseCode);
                            RecFeeCourseHdr.SetRange("Academic Year", AcademicYear);
                            RecFeeCourseHdr.SETRANGE("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                            RecFeeCourseHdr.SETRANGE("Other Fees", false);
                            CourseRec.Get(CourseCode);
                            If CourseRec."Admitted Year Wise Fee" then
                                RecFeeCourseHdr.SETRANGE(RecFeeCourseHdr."Admitted Year", StudentRec."Admitted Year");
                            If CourseRec."Semester Wise Fee" then
                                RecFeeCourseHdr.SETRANGE(RecFeeCourseHdr.Semester, Semester);
                            RecFeeCourseHdr.SETRANGE(Year, StudentRec.Year);
                            IF RecFeeCourseHdr.FindFirst() then begin
                                AmountSum := 0;
                                AmountFinalCal := 0;
                                RecFeeCourseLine.Reset();
                                RecFeeCourseLine.SetRange("Document No.", RecFeeCourseHdr."No.");
                                IF RecFeeCourseLine.FindFirst() then begin
                                    Repeat
                                        AmounttoPay := FeeGeneration.StudentTotalFee(StudentRec."No.", RecFeeCourseLine."Fee Code", '', '', False, SemFee, GVFee);
                                        if AmounttoPay <> 0 then begin
                                            FeeComponent.Get(RecFeeCourseLine."Fee Code");
                                            if FeeComponent."Fee Group" = FeeComponent."Fee Group"::Institutional then
                                                AmountSum += AmounttoPay;
                                        end;
                                    // RecSAPFeeCode.Reset();
                                    // RecSAPFeeCode.SetRange("SAP Code", RecFeeCourseLine."Fee Code");
                                    // RecSAPFeeCode.SetFilter("Fee Group", '%1', RecSAPFeeCode."Fee Group"::Institutional);
                                    // if RecSAPFeeCode.FindFirst() then

                                    until RecFeeCourseLine.Next() = 0;
                                    AmountFinalCal := (AmountSum * PerFinal) / 100;
                                    exit(AmountFinalCal);
                                end;
                                // WithdrawalStudentRec.Reset();
                                // WithdrawalStudentRec.SetRange("No.", "Withdrawal No.");
                                // if WithdrawalStudentRec.FindFirst() then;
                                // IF (AmountFinalCal <> 0) AND (Calculation = false) then
                                //     CreditMemoGenJournalLineInsert(StudentNo, AmountFinalCal, WithdrawalStudentRec."Reason for Leaving");
                            end;
                        end;
                    end;
                end;
    end;


    procedure CreditMemoGenJournalLineInsert(StudentNo: Code[20]; FinalAmountCal: Decimal; WaiverCode: Code[20];
                                             WaiverDesc: Text[100])
    Var
        GenJournalLine: record "Gen. Journal Line";
        GenJournalLine1: record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        RecFeeSetup: Record "Fee Setup-CS";
        RecStudentMaster: Record "Student Master-CS";
        NoSeries: Codeunit NoSeriesManagement;
        DocumentNo: Code[20];
        LineNo: Integer;
    begin
        RecStudentMaster.Get(StudentNo);
        RecFeeSetup.Reset();
        RecFeeSetup.SetRange("Global Dimension 1 Code", RecStudentMaster."Global Dimension 1 Code");
        IF RecFeeSetup.FindFirst() then;
        RecFeeSetup.TESTFIELD(RecFeeSetup."Withdrawal Template Name");
        RecFeeSetup.TESTFIELD(RecFeeSetup."Withdrawal Batch Name");

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", RecFeeSetup."Withdrawal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", RecFeeSetup."Withdrawal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            DocumentNo := INCSTR(GenJournalLine."Document No.")
        ELSE begin
            GenJournalBatch.RESET();
            GenJournalBatch.SETRANGE("Journal Template Name", RecFeeSetup."Withdrawal Template Name");
            GenJournalBatch.SETRANGE(Name, RecFeeSetup."Withdrawal Batch Name");
            IF GenJournalBatch.FINDFIRST() THEN;
            DocumentNo := NoSeries.GetNextNo(GenJournalBatch."No. Series", 0D, false);
        end;
        // DocumentNo := NoSeries.GetNextNo(RecFeeSetup."Withdrawal Document No.", 0D, TRUE);

        LineNo := 0;
        GenJournalLine1.RESET();
        GenJournalLine1.SETRANGE("Journal Template Name", RecFeeSetup."Withdrawal Template Name");
        GenJournalLine1.SETRANGE("Journal Batch Name", RecFeeSetup."Withdrawal Batch Name");
        IF GenJournalLine1.FINDLAST() THEN
            LineNo := GenJournalLine1."Line No." + 10000
        ELSE
            LineNo := 10000;

        GenJournalLine.reset();
        GenJournalLine.INIT();
        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", RecFeeSetup."Withdrawal Template Name");
        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", RecFeeSetup."Withdrawal Batch Name");
        GenJournalLine.VALIDATE(GenJournalLine."Line No.", LineNo);
        GenJournalLine.VALIDATE(GenJournalLine."Posting Date", WORKDATE());
        GenJournalLine.VALIDATE(GenJournalLine."Document Type", GenJournalLine."Document Type"::"Credit Memo");
        GenJournalLine.VALIDATE(GenJournalLine."Document No.", DocumentNo);
        GenJournalLine.VALIDATE(GenJournalLine."Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE(GenJournalLine."Account No.", RecFeeSetup."Withdrawal G/L Account No.");
        GenJournalLine.VALIDATE(GenJournalLine."Debit Amount", FinalAmountCal);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", RecStudentMaster."Original Student No.");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code", RecStudentMaster."Global Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code", RecStudentMaster."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code", RecStudentMaster."Currency Code");
        GenJournalLine.VALIDATE(GenJournalLine.Year, RecStudentMaster.Year);
        GenJournalLine.VALIDATE(GenJournalLine.Course, RecStudentMaster."Course Code");
        GenJournalLine.Term := RecStudentMaster.Term;
        GenJournalLine."Waiver/Scholar/Grant Code" := WaiverCode;
        GenJournalLine."Waiver/Scholar/Grant Desc" := WaiverDesc;
        GenJournalLine.VALIDATE(GenJournalLine."Academic Year", RecStudentMaster."Academic Year");
        GenJournalLine.VALIDATE(GenJournalLine."Admitted Year", RecStudentMaster."Admitted Year");
        GenJournalLine.Description := WaiverDesc;
        GenJournalLine.Reason := Rec."Reason for Leaving";
        if SourceSchorlarshipRec.Get(WaiverCode) then begin
            SapRec.Reset();
            SapRec.SetRange("SAP Code", SourceSchorlarshipRec."SAP Code");
            if SapRec.FindFirst() then begin
                GenJournalLine."SAP Code" := SapRec."SAP Code";
                GenJournalLine."Fee Code" := SapRec."SAP Code";
                GenJournalLine."SAP G/L Account" := SapRec."SAP G/L Account";
                GenJournalLine."SAP Assignment Code" := SapRec."SAP Assignment Code";
                GenJournalLine."SAP Description" := SapRec."SAP Description";
                GenJournalLine."SAP Cost Centre" := SapRec."SAP Cost Centre";
                GenJournalLine."SAP Profit Centre" := SapRec."SAP Profit Centre";
                GenJournalLine."SAP Company Code" := SapRec."SAP Company Code";
                GenJournalLine."SAP Bus. Area" := SapRec."SAP Bus. Area";
                GenJournalLine."Fee Group" := SapRec."Fee Group";
            end;
        end;
        GenJournalLine.INSERT(TRUE);

        if RecFeeSetup."Waiver Auto Post" then begin
            GenJournalLinePost.Reset();
            GenJournalLinePost.SETRANGE("Journal Template Name", RecFeeSetup."Withdrawal Template Name");
            GenJournalLinePost.SETRANGE("Journal Batch Name", RecFeeSetup."Withdrawal Batch Name");
            IF GenJournalLinePost.Findset() THEN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLinePost);
        end;
    end;

    var
        WithdrawalStudentRec: Record "Withdrawal Student-CS";
        WithdrawalApprovalRec: Record "Withdrawal Approvals";
        SourceSchorlarshipRec: Record "Source Scholarship-CS";
        SapRec: Record "SAP Fee Code";
        GenJournalLinePost: Record "Gen. Journal Line";
        StudentMasterRec: Record "Student Master-CS";
        FeeGeneration: Report "Fee Generation New";
        // RecSemester: Record "Semester Master-CS";
        StudentStatusMangementCod: Codeunit "Student Status Mangement";
        AmounttoPay: Decimal;

        Boolean_gBool: Boolean;
        Boolean_gBool1: Boolean;
        Boolean_gBool2: Boolean;
        Boolean_gBool3: Boolean;
        ProcessBoolean: Boolean;
        RejectApproveBoolean: Boolean;
        Text001Lbl: Label 'Do you want to Approve Application No. %1 ?';
        Text002Lbl: Label 'Application No. %1 has been Approved.';
        Text003Lbl: Label 'Do you want to Rejected Application No. %1 ?';
        Text004Lbl: Label 'Application No. %1 has been Rejected.';
        Text005Lbl: Label 'Do you want to calculate Waiver Amount for Application No. %1 ?';
        Text006Lbl: Label 'Waiver Amount Calculated for Application No. %1 ?';
        Text007Lbl: Label 'Waiver Amount is not Calculated for Application No. %1, Do you still want to continue?';
        Text008Lbl: Label 'Approved Amount is not same to Waiver Amount for Application No. %1, Do you still want to continue?';
        Text009Lbl: Label 'Application No. %1 has been Processed.';
        Text0010Lbl: Label 'Approved Amount is Zero for Application No. %1, Do you still want to continue?';
        WebServices: Codeunit WebServicesFunctionsCSL;
        WithdrawlDepartment: Record "Withdrawal Department";
        SemesterMaster: Record "Semester Master-CS";
        NSLDSBool: Boolean;
        DODBool: Boolean;
        LDABool: Boolean;

    procedure ChangeExamLinesasWith(pStudentNo: Code[20]; pLastDtOfAtt: Date)
    var
        ExtExamLn: Record "External Exam Line-CS";
        IntExamLn: Record "Internal Exam Line-CS";
        GradeBook: Record "Grade Book";
        Stud: Record "Student Master-CS";
    begin
        Stud.Reset();
        Stud.Get(pStudentNo);
        ExtExamLn.Reset();
        ExtExamLn.SetRange("Student No.", pStudentNo);
        ExtExamLn.SetFilter("Exam Date", '>%1', pLastDtOfAtt);
        if ExtExamLn.FindSet() then
            repeat
                ExtExamLn."Attendance Type" := ExtExamLn."Attendance Type"::Withdrawal;
                ExtExamLn.Modify();
                GradeBook.Reset();
                GradeBook.SetRange("Student No.", pStudentNo);
                GradeBook.setrange("Document No.", ExtExamLn."Document No.");
                if GradeBook.FindSet() then
                    repeat
                        GradeBook.Grade := Stud.Status;
                        GradeBook.Modify();
                    until GradeBook.Next() = 0;
            until ExtExamLn.Next() = 0;

        IntExamLn.Reset();
        IntExamLn.SetRange("Student No.", pStudentNo);
        IntExamLn.SetFilter("Exam Date", '>%1', pLastDtOfAtt);
        if IntExamLn.FindSet() then
            repeat
                IntExamLn."Attendance Type" := IntExamLn."Attendance Type"::Withdrawal;
                IntExamLn.Modify();
                GradeBook.Reset();
                GradeBook.SetRange("Student No.", pStudentNo);
                GradeBook.setrange("Document No.", IntExamLn."Document No.");
                if GradeBook.FindSet() then
                    repeat
                        GradeBook.Grade := Stud.Status;
                        GradeBook.Modify();
                    until GradeBook.Next() = 0;
            until IntExamLn.Next() = 0;

    end;

    procedure WithdrawalReqAPProvMail()
    var
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
    begin

        SmtpMailRec.Get();
        Studentmaster.Reset();
        Studentmaster.GET(Rec."Student No.");
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."Withdrawal No." + 'Withdrawal Request Approval';

        // SmtpMail.AppendtoBody('Alert sent to student for Withdrawal Approval from Registrar department from BC');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Subject-' + Studentmaster."Application No." + 'Withdrawal Request Approval ');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM
        SmtpMail.AppendtoBody('Good Day,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Please be informed that ' + Studentmaster."Student Name" + ' - ' + Format(Studentmaster."Original Student No.") + ' has officially withdrawn from the AUA College of Medicine, effective' + Format(Studentmaster."Last Date Of Attendance") + '.');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Reason - ' + Rec."Reason for Leaving");
        // SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Semester ' + Rec.Semester);
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('SLcM Administrator');
        BodyText := SmtpMail.GetBody();
        // Mail_lCU.Send();//GMCSCOM
        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Withdrawal Request Approval', 'MEA', SenderAddress, Studentmaster."Student Name",
        Studentmaster."No.", Subject, BodyText, 'Withdrawal Request Approval', 'Withdrawal Request Approval', '', '', Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;



    VAr
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];


    procedure SendForApproval_gFnc(var WithdrawalApprovals_lRec: Record "Withdrawal Approvals")
    var
        WithdrawalDepartment_lRec: Record "Withdrawal Department";
        WithdrawalApprovals_Rec: Record "Withdrawal Approvals";
    begin

        WithdrawalDepartment_lRec.Reset;
        WithdrawalDepartment_lRec.SetCurrentkey("Document Type", Sequence);
        WithdrawalDepartment_lRec.SetRange("Document Type", WithdrawalDepartment_lRec."Document Type"::Withdrawal);
        WithdrawalDepartment_lRec.SetFilter("User E-Mail", '<>%1', '');
        if WithdrawalDepartment_lRec.IsEmpty then
            Error('Leaves Approvals Approver is not define for User ID %1', UserId);

        //LeavesApprovals_vRec.Status := LeavesApprovals_vRec.Status::"Pending for Approval";
        //LeavesApprovals_vRec.Modify;

        WithdrawalApprovals_Rec.Reset;
        WithdrawalApprovals_Rec.SetRange("Withdrawal No.", WithdrawalApprovals_lRec."Withdrawal No.");
        WithdrawalApprovals_Rec.SetRange(Status, WithdrawalApprovals_lRec.Status::Open);
        if WithdrawalApprovals_Rec.FindFirst then begin
            if ApproveEntry_gFnc(WithdrawalApprovals_Rec, false) then begin
                Message(Text013_gCtx);
                exit;
            end;
        end;

        //SendForApprovalEmail_gFnc(LeavesApprovals_vRec);

        Message(Text003_gCtx);
    end;


    procedure ApproveEntry_gFnc(var UserAppEntry_vRec: Record "Withdrawal Approvals"; ShowConfirm_iBln: Boolean): Boolean
    var
        LR_lRec: Record "Leaves Approvals";
    begin
        // if ShowConfirm_iBln then begin
        //     if not Confirm(Text007_gCtx, false) then
        //         exit;
        // end;
        //  UserAppEntry_vRec.Status := UserAppEntry_vRec.Status::Approved;
        if UserAppEntry_vRec.sequence > 0 then begin
            UserAppEntry_vRec.Status := UserAppEntry_vRec.Status::Approved;
            UserAppEntry_vRec.Modify(true);
        end;
        exit;
    end;
    //CSPL-00307-HelloSign_BUG
    procedure CheckHelloSignConfirmed(ApplicationNo: Code[20]): Boolean;
    var
        WithdrawalApplication: Record "Withdrawal Student-CS";
    begin
        WithdrawalApplication.Reset();
        IF WithdrawalApplication.Get(ApplicationNo) Then
            exit(WithdrawalApplication.HelloSign_Confirmed);
    end;
    //CSPL-00307-HelloSign_BUG

    procedure CheckEntryFromPortal(ApplicationNo: Code[20]): Boolean;
    var
        WithdrawalApplication: Record "Withdrawal Student-CS";
    begin
        WithdrawalApplication.Reset();
        IF WithdrawalApplication.Get(ApplicationNo) Then
            exit(WithdrawalApplication."Entry From Portal");
    end;

    var

        Text000_gCtx: label 'There is nothing to approve.';
        Text003_gCtx: label 'Approval request has been sent.';
        Text004_gCtx: label 'Do you want to send for Approval?';
        Text005_gCtx: label 'Do you want to cancel approval entries?';
        Text006_gCtx: label 'Approval entry cancelled successfully.';
        Text007_gCtx: label 'Do you want to approve request?';
        Text008_gCtx: label 'Do you want to reject request?';
        Text009_gCtx: label 'There is nothing to reject.';
        Text010_gCtx: label 'There is nothing to show.';
        Text011_gCtx: label 'Do you want to re-oepn approval entries?';
        Text012_gCtx: label 'Approval entry opened successfully.';
        Text013_gCtx: label 'Entry is auto-approved.';
        Text016_gCtx: label 'There is nothing to approve.';
        Text017_gCtx: label 'Do you want to approve selected request lines?';
        Text018_gCtx: label 'Do you want to reject selected request lines?';
        Text019_gCtx: label 'There is nothing to reject.';
        //SMTPSetup_gRec: Record "Email Account";
        FixedAsset_gRec: Record "Fixed Asset";
        SalesRecSetup_gRec: Record "Sales & Receivables Setup";
        ApprovalsDelegatedMsg: label 'The selected approval requests have been delegated.';
        DelegateOnlyOpenRequestsErr: label 'You can only delegate open approval requests.';
        ApproverUserIdNotInSetupErr: label 'You must set up an approver for user ID %1 in the Approval User Setup window.', Comment = 'You must set up an approver for user ID NAVUser in the Approval User Setup window.';
}
page 50717 "Leaves Approval Card"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       Approve - OnAction()                      Use for Approve .net function
    // 02    CSPL-00059   07/01/2019       Reject - OnAction()                       Use for Reject.net function

    PageType = Card;
    UsageCategory = None;
    SourceTable = "Leaves Approvals";
    caption = 'Pending Leaves Approval Card';
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
                field("Application No."; Rec."Application No.")
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
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        StudentLeaveAbsenceRec: Record "Student Leave of Absence";
                    begin
                        if Rec."Start Date" <> xRec."Start Date" then begin
                            StudentLeaveAbsenceRec.get(Rec."Application No.");
                            StudentLeaveAbsenceRec.validate("Start Date", Rec."Start Date");
                            StudentLeaveAbsenceRec.Modify();
                        end;
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    //Editable = Registrareditable;

                    trigger OnValidate()
                    var
                        StudentLeaveAbsenceRec: Record "Student Leave of Absence";
                    begin
                        if Rec."End Date" <> xRec."End Date" then begin
                            StudentLeaveAbsenceRec.get(Rec."Application No.");
                            StudentLeaveAbsenceRec.validate("End Date", Rec."End Date");
                            StudentLeaveAbsenceRec.Modify();
                        end;
                    end;
                }
                field("Date Of Determination"; Rec."Date Of Determination")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        StudentLeaveAbsenceRec: Record "Student Leave of Absence";
                    begin
                        if Rec."Date Of Determination" <> xrec."Date Of Determination" then begin
                            StudentLeaveAbsenceRec.get(Rec."Application No.");
                            StudentLeaveAbsenceRec.validate("Date Of Determination", Rec."Date Of Determination");
                            StudentLeaveAbsenceRec.Modify();
                        end;
                    end;
                }
                field("Last Date Of Attendance"; Rec."Last Date Of Attendance")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        StudentLeaveAbsenceRec: Record "Student Leave of Absence";
                    begin
                        if Rec."Last Date Of Attendance" <> xrec."Last Date Of Attendance" then begin
                            StudentLeaveAbsenceRec.get(Rec."Application No.");
                            StudentLeaveAbsenceRec.validate("Last Date Of Attendance", Rec."Last Date Of Attendance");
                            StudentLeaveAbsenceRec.Modify();
                        end;
                    end;
                }
                field("NSLDS Withdrawal Date"; Rec."NSLDS Withdrawal Date")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        StudentLeaveAbsenceRec: Record "Student Leave of Absence";
                    begin
                        if Rec."NSLDS Withdrawal Date" <> xrec."NSLDS Withdrawal Date" then begin
                            StudentLeaveAbsenceRec.get(Rec."Application No.");
                            StudentLeaveAbsenceRec.validate("NSLDS Withdrawal Date", Rec."NSLDS Withdrawal Date");
                            StudentLeaveAbsenceRec.Modify();
                        end;
                    end;
                }
                field("Type of Leaves"; Rec."Type of Leaves")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                Field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                Field("Reason for Leave"; Rec."Reason for Leave")
                {
                    ApplicationArea = All;
                }
                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = RejectButtonVisible Or FinalApproverView;
                }
                field("Cancelled Remarks"; Rec."Cancelled Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Visible = Not (Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA);

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
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                Field(Comments; Rec.Comments)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    Enabled = LDAChangeComments;
                    Visible = Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA;
                }



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
            action("Leave Details")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Leave Details';
                trigger OnAction()
                var
                    StudentLeaveAbsenceRec: Record "Student Leave of Absence";
                    SLOACardPag: Page "SLOA Card";
                    CLOACardPag: Page "CLOA Card";
                    ELOACardPag: Page "ELOA Card";
                begin
                    StudentLeaveAbsenceRec.Reset();
                    StudentLeaveAbsenceRec.SetRange("Application No.", Rec."Application No.");
                    IF StudentLeaveAbsenceRec.FindFirst() then begin
                        Case Rec."Type of Leaves" of
                            Rec."Type of Leaves"::SLOA:
                                begin
                                    SLOACardPag.SetTableView(StudentLeaveAbsenceRec);
                                    SLOACardPag.Editable := False;
                                    SLOACardPag.Run();
                                end;
                            Rec."Type of Leaves"::ELOA:
                                begin
                                    ELOACardPag.SetTableView(StudentLeaveAbsenceRec);
                                    ELOACardPag.Editable := False;
                                    ELOACardPag.Run();
                                end;
                            Rec."Type of Leaves"::CLOA:
                                begin
                                    CLOACardPag.SetTableView(StudentLeaveAbsenceRec);
                                    CLOACardPag.Editable := False;
                                    CLOACardPag.Run();
                                end;
                        end;

                    end;
                end;
            }

            action("&Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = RejectApproveBoolean;
                trigger OnAction()
                var

                    LeavesApprovals: Record "Leaves Approvals";
                    WithdrawalDepartment: Record "Withdrawal Department";
                    WithdrawalDepartment1: Record "Withdrawal Department";
                    DepartmentMasterRec: Record "Withdrawal Department";
                    WebServices: Codeunit WebServicesFunctionsCSL;
                    Int: Integer;
                    Int1: Integer;
                begin
                    //Message('%1', 'Hi');

                    IF CONFIRM(Text001Lbl, FALSE, Rec."Application No.") THEN BEGIN

                        WithdrawalDepartment.Reset();//GAURAV//27.11.22//
                        WithdrawalDepartment.SetRange("Department Code", Rec."Approved for Department");
                        WithdrawalDepartment.setrange("Document Type", Rec."Type of Leaves");
                        IF WithdrawalDepartment.FindFirst() then begin
                            //Message('%1', WithdrawalDepartment.sequence);
                        End; // END GAURAV


                        DepartmentMasterRec.Reset();
                        DepartmentMasterRec.SetFilter("User Name", DepartmentMasterRec.GetUserGroup());
                        DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
                        DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
                            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA)
                        else
                            if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
                                DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA)
                            else
                                if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
                                    DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
                        IF DepartmentMasterRec.FindFirst() then begin
                            if DepartmentMasterRec."Update DOD" then
                                Rec.Testfield("Date Of Determination");
                            if Rec."Type of Leaves" <> Rec."Type of Leaves"::SLOA then
                                if DepartmentMasterRec."Update LDA" then
                                    Rec.TestField("Last Date Of Attendance");
                        end;
                        if Rec.Status = Rec.Status::Approved then
                            Error('Status is already Approved');
                        if Rec."Rejection Remark" <> '' then
                            Error('Rejection remark must be blank');



                        IF Rec."Final Approval" then begin
                            LeavesApprovalRec.SetRange("Student No.", Rec."Student No.");
                            LeavesApprovalRec.SetFilter("Status", '%1', LeavesApprovalRec.Status::"Pending for Approval");
                            LeavesApprovalRec.SetRange("Final Approval", false);
                            IF LeavesApprovalRec.findfirst() then
                                error('Department approval is pending for : %1', LeavesApprovalRec."Department Name");

                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved By" := UserId();
                            Rec."Approved On" := WorkDate();
                            Rec."Approved In Days" := Rec."Approved On" - Rec."Application Date";
                            Rec.Modify();
                            IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
                                SLOAApproval();
                            IF Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
                                ELOAApprovalRequest();
                            IF Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
                                CLOAApprovalRequest();
                            // WithdrawalFinalMail("Student No.");
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Leaves") + ' ' + Rec."Application No." + ' is Approved by' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                            WebServices.Hello_Sign_Download_Email_Sent(Rec."Application No.", Rec."Student No.", UserId, 'LEAVE');//CSPL-00307

                            //Gourav 11.4.22
                            WithdrawalDepartment.Reset();
                            WithdrawalDepartment.SetRange("Department Code", Rec."Approved for Department");
                            WithdrawalDepartment.setrange("Document Type", Rec."Type of Leaves");
                            IF WithdrawalDepartment.FindFirst() then begin
                                rec.sequence := WithdrawalDepartment.Sequence;
                                rec.Modify();
                                //Message('%1', Rec.sequence);
                                IF (WithdrawalDepartment.Sequence > 1) then begin
                                    WithdrawalDepartment1.Reset();
                                    WithdrawalDepartment1.SetRange("Document Type", WithdrawalDepartment."Document Type");
                                    WithdrawalDepartment1.SetRange(Sequence, WithdrawalDepartment.Sequence - 1);
                                    IF WithdrawalDepartment1.FindFirst() then begin
                                        IF (Rec.Status <> Rec.Status::Approved) Then
                                            Error('Department approval has been pending from %1', WithdrawalDepartment1."Department Code");
                                    end;
                                End;
                                // SendForApproval_gFnc(Rec);

                                //End --GAURAV -11.4.2022

                            end;
                        end else begin
                            //Gourav 11.4.22
                            WithdrawalDepartment.Reset();
                            WithdrawalDepartment.SetRange("Department Code", Rec."Approved for Department");
                            WithdrawalDepartment.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            IF Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
                                WithdrawalDepartment.setrange("Document Type", WithdrawalDepartment."Document Type"::CLOA);
                            IF Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
                                WithdrawalDepartment.setrange("Document Type", WithdrawalDepartment."Document Type"::ELOA);
                            IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
                                WithdrawalDepartment.setrange("Document Type", WithdrawalDepartment."Document Type"::SLOA);
                            IF WithdrawalDepartment.FindFirst() then begin

                                rec.sequence := WithdrawalDepartment.Sequence;
                                rec.Modify();
                                //Message('%1', Rec.sequence);
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
                                            LeavesApprovals.SetRange("Type of Leaves", Rec."Type of Leaves");
                                            LeavesApprovals.SetRange("Application No.", Rec."Application No.");
                                            LeavesApprovals.Setfilter(Status, '%1|%2', LeavesApprovals.Status::"Pending for Approval", LeavesApprovals.Status::Rejected);////GAURAV29.11.22//
                                            If LeavesApprovals.FindFirst() then
                                                Error('Department approval has been pending from %1', LeavesApprovals."Department Name");
                                        end;
                                    end;
                                End;
                                //SendForApproval_gFnc(Rec);

                                //End --GAURAV -11.4.2022

                            end;
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved By" := UserId();
                            Rec."Approved On" := WorkDate();
                            Rec."Approved In Days" := Rec."Approved On" - Rec."Application Date";
                            Rec.Modify();
                            // IF "Type of Leaves" = "Type of Leaves"::SLOA then
                            //     SLOAApproval();
                            // IF "Type of Leaves" = "Type of Leaves"::ELOA then
                            //     ELOAApprovalRequest();
                            // IF "Type of Leaves" = "Type of Leaves"::CLOA then
                            //     CLOAApprovalRequest();

                            // LeaveApprovalDepartmentMail("Student No."); //Email Block On 18-11-2022 as per Stuti
                            //LeaveSeqApproverMail("Student No."); //GAURAV//29.11.22//G,CSCOM

                            //CSPL-00307-T1-T1516-CR   Code Comment as this mail non needed asfter LeaveSeqApprovalMail
                            // LeavesApprovalRec.Reset();
                            // LeavesApprovalRec.SetRange("Application No.", "Application No.");
                            // LeavesApprovalRec.SetRange("Final Approval", false);
                            // LeavesApprovalRec.SetFilter(LeavesApprovalRec.Status, '<>%1', LeavesApprovalRec.Status::Approved);
                            // if not LeavesApprovalRec.FindFirst() then Begin
                            //     IF "Type of Leaves" <> "Type of Leaves"::ELOA then
                            //         LeaveFinalApproverMail("Student No.");
                            // END;
                            //CSPL-00307-T1-T1516-CR   Code Comment as this mail non needed asfter LeaveSeqApprovalMail

                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Leaves") + ' ' + Rec."Application No." + ' is Approved by' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                            WebServices.Hello_Sign_Download_Email_Sent(Rec."Application No.", Rec."Student No.", UserId, 'LEAVE');//CSPL-00307

                            //Start 11.4.22 GAURAV
                            WithdrawalDepartment.Reset();
                            WithdrawalDepartment.SetRange("Department Code", Rec."Approved for Department");
                            if rec."Type of Leaves" = Rec."Type of Leaves"::CLOA //GAURAV29.11.22//
                            Then
                                WithdrawalDepartment.setrange("Document Type", WithdrawalDepartment."Document Type"::CLOA);
                            //     if rec."Type of Leaves" = Rec."Type of Leaves"::ELOA
                            //     Then
                            //         WithdrawalDepartment.setrange("Document Type", WithdrawalDepartment."Document Type"::ELOA);
                            //     if rec."Type of Leaves" = Rec."Type of Leaves"::SLOA
                            //    Then
                            //         WithdrawalDepartment.setrange("Document Type", WithdrawalDepartment."Document Type"::SLOA);
                            IF WithdrawalDepartment.FindFirst() then begin
                                rec.sequence := WithdrawalDepartment.Sequence;
                                rec.Modify();
                                IF (WithdrawalDepartment.Sequence > 1) then begin
                                    WithdrawalDepartment1.Reset();
                                    WithdrawalDepartment1.SetRange("Document Type", WithdrawalDepartment."Document Type");
                                    WithdrawalDepartment1.SetRange(Sequence, WithdrawalDepartment.Sequence - 1);
                                    IF WithdrawalDepartment1.FindFirst() then begin
                                        //
                                        IF (Rec.Status <> Rec.Status::Approved) Then
                                            Error('Department approval has been pending from %1', WithdrawalDepartment1."Department Code");
                                    end;
                                End;
                                //    SendForApproval_gFnc(Rec);
                                //End 11.4.22 GAURAV
                            end;
                        end;

                        StudentMasterRec.Get(Rec."Student No.");
                        LeavesApprovalRec.Reset();
                        LeavesApprovalRec.SetRange("Application No.", Rec."Application No.");
                        LeavesApprovalRec.SetFilter(LeavesApprovalRec.Status, '<>%1', LeavesApprovalRec.Status::Approved);
                        if not LeavesApprovalRec.FindFirst() then begin
                            StudentLeaveAbsenceRec.Reset();
                            StudentLeaveAbsenceRec.SetRange("Application No.", Rec."Application No.");
                            if StudentLeaveAbsenceRec.FindFirst() then begin
                                StudentLeaveAbsenceRec."Status" := StudentLeaveAbsenceRec."Status"::Approved;
                                if (StudentLeaveAbsenceRec."Leave Types" = StudentLeaveAbsenceRec."Leave Types"::CLOA) and (StudentLeaveAbsenceRec.Reopen = true) then begin
                                end else begin
                                    //if StudentMasterRec.Get("Student No.") then begin
                                    StudentLeaveAbsenceRec."Last Student Status Updated" := StudentMasterRec.Status;
                                    if NOT (StudentLeaveAbsenceRec."Leave Types" IN [StudentLeaveAbsenceRec."Leave Types"::CLOA, StudentLeaveAbsenceRec."Leave Types"::SLOA]) then begin //Lucky-added SLOA 
                                        StudentMasterRec.Status := StudentStatusMangementCod.SLOAELOACLOASignoff(Rec."Student No.", StudentMasterRec.Status,
                                                                  Rec."Global Dimension 1 Code", Rec."Type of Leaves");
                                        StudentMasterRec.Validate(StudentMasterRec.Status);
                                        StudentMasterRec.Modify();
                                    end;
                                    IF StudentLeaveAbsenceRec."Leave Types" = StudentLeaveAbsenceRec."Leave Types"::SLOA then
                                        SLOABulkMailSend();
                                    //end;
                                end;
                                StudentLeaveAbsenceRec.Modify();
                            end;
                        end;

                        CurrPage.Update();
                        CurrPage.Close();
                        Message(Text002Lbl, Rec."Application No.");
                    end else
                        exit;
                    //19.4.22 GAURAV
                    REC.Status := Rec.Status::Approved;
                    Rec.Modify();
                end;
            }
            action("&Process")
            {
                ApplicationArea = All;
                Caption = 'Process';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = ProcessBoolean;
                trigger OnAction()
                var
                    StudentTimeLineRec: Record "Student Time Line";
                    DepartmentMasterRec: Record "Withdrawal Department";
                    WebServices: Codeunit WebServicesFunctionsCSL;

                begin

                    IF CONFIRM(Text001Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        DepartmentMasterRec.Reset();
                        DepartmentMasterRec.SetFilter("User Name", DepartmentMasterRec.GetUserGroup());
                        DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
                        DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
                            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA)
                        else
                            if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
                                DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA)
                            else
                                if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
                                    DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
                        IF DepartmentMasterRec.FindFirst() then begin
                            if Rec."Type of Leaves" <> Rec."Type of Leaves"::SLOA then
                                if DepartmentMasterRec."Update DOD" then
                                    Rec.Testfield("Date Of Determination");
                            if Rec."Type of Leaves" <> Rec."Type of Leaves"::SLOA then
                                if DepartmentMasterRec."Update LDA" then
                                    Rec.TestField("Last Date Of Attendance");
                        end;
                        if Rec.Status = Rec.Status::Approved then
                            Error('Status is already Approved');
                        if Rec."Rejection Remark" <> '' then
                            Error('Rejection remark must be blank');

                        IF Rec."Final Approval" then begin
                            LeavesApprovalRec.SetRange("Student No.", Rec."Student No.");
                            LeavesApprovalRec.SetRange("Type of Leaves", Rec."Type of Leaves");
                            LeavesApprovalRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            LeavesApprovalRec.SetFilter("Status", '%1', LeavesApprovalRec.Status::"Pending for Approval");
                            LeavesApprovalRec.SetRange("Final Approval", false);
                            IF LeavesApprovalRec.findfirst() then
                                error('Department approval is pending for : %1', LeavesApprovalRec."Department Name");

                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved By" := UserId();
                            Rec."Approved On" := WorkDate();
                            Rec."Approved In Days" := Rec."Approved On" - Rec."Application Date";
                            Rec.Modify();
                            // IF "Type of Leaves" = "Type of Leaves"::SLOA then        //Temparary Disabled as per User Repuest 30 June 2023
                            //     SLOAApproval();
                            IF Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
                                ELOAApprovalRequest();
                            IF Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
                                CLOAApprovalRequest();

                            // WithdrawalFinalMail("Student No.");
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Leaves") + ' ' + Rec."Application No." + ' is Approved by ' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                            WebServices.Hello_Sign_Download_Email_Sent(Rec."Application No.", Rec."Student No.", UserId, 'LEAVE');//CSPL-00307
                        end else begin
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved By" := UserId();
                            Rec."Approved On" := WorkDate();
                            Rec."Approved In Days" := Rec."Approved On" - Rec."Application Date";
                            Rec.Modify();
                            // IF "Type of Leaves" = "Type of Leaves"::SLOA then
                            //     SLOAApproval();
                            // IF "Type of Leaves" = "Type of Leaves"::ELOA then
                            //     ELOAApprovalRequest();
                            // IF "Type of Leaves" = "Type of Leaves"::CLOA then
                            //     CLOAApprovalRequest();
                            // LeaveApprovalDepartmentMail("Student No."); //Email Block On 18-11-2022 as per Stuti

                            LeavesApprovalRec.Reset();
                            LeavesApprovalRec.SetRange("Application No.", Rec."Application No.");
                            LeavesApprovalRec.SetRange("Final Approval", false);
                            LeavesApprovalRec.SetFilter(LeavesApprovalRec.Status, '<>%1', LeavesApprovalRec.Status::Approved);
                            if not LeavesApprovalRec.FindFirst() then begin
                                // LeaveFinalApproverMail("Student No."); //CSPL-00307-T1-T1516-CR

                                // IF (Rec.Sequence = 1) Or (Rec.Sequence = 2) OR (Rec.Sequence = 3) Or (Rec.Sequence = 4) Then//GAURAV//28.11.22 //CSPL-00307-T1-T1516-CR
                                //LeaveSeqApproverMail("Student No.");//GMCSCOM

                            end;//END
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Leaves") + ' ' + Rec."Application No." + ' is Approved by ' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                            WebServices.Hello_Sign_Download_Email_Sent(Rec."Application No.", Rec."Student No.", UserId, 'LEAVE');//CSPL-00307
                        end;

                        StudentMasterRec.Get(Rec."Student No.");
                        LeavesApprovalRec.Reset();
                        LeavesApprovalRec.SetRange("Application No.", Rec."Application No.");
                        LeavesApprovalRec.SetFilter(LeavesApprovalRec.Status, '<>%1', LeavesApprovalRec.Status::Approved);
                        if not LeavesApprovalRec.FindFirst() then begin
                            StudentLeaveAbsenceRec.Reset();
                            StudentLeaveAbsenceRec.SetRange("Application No.", Rec."Application No.");
                            if StudentLeaveAbsenceRec.FindFirst() then begin
                                StudentLeaveAbsenceRec."Status" := StudentLeaveAbsenceRec."Status"::Approved;
                                StudentLeaveAbsenceRec."Approved By" := UserId();
                                StudentLeaveAbsenceRec."Approved On" := Today();
                                //11.10.2021-->Start 
                                StudentLeaveAbsenceRec.Validate("SFP-LOA", StudentLeaveAbsenceRec."SFP-LOA"::Pending);
                                //11.10.2021-->End 
                                if (StudentLeaveAbsenceRec."Leave Types" = StudentLeaveAbsenceRec."Leave Types"::CLOA) and (StudentLeaveAbsenceRec.Reopen = true) then begin
                                end else begin
                                    //if StudentMasterRec.Get("Student No.") then begin

                                    StudentLeaveAbsenceRec."Last Student Status Updated" := StudentMasterRec.Status;
                                    if NOT (StudentLeaveAbsenceRec."Leave Types" IN [StudentLeaveAbsenceRec."Leave Types"::CLOA, StudentLeaveAbsenceRec."Leave Types"::SLOA]) then begin //Lucky-added SLOA
                                        StudentMasterRec.Validate(Status, StudentStatusMangementCod.SLOAELOACLOASignoff(Rec."Student No.", StudentMasterRec.Status,
                                                                   Rec."Global Dimension 1 Code", Rec."Type of Leaves"));
                                        IF StudentMasterRec."Student SFP Initiation" <> 0 then
                                            StudentMasterRec."SFP-LOA" := StudentMasterRec."SFP-LOA"::Pending;
                                        StudentMasterRec.Modify();
                                    end;
                                    IF StudentLeaveAbsenceRec."Leave Types" = StudentLeaveAbsenceRec."Leave Types"::SLOA then
                                        SLOABulkMailSend();
                                    //end;
                                end;
                                StudentLeaveAbsenceRec.Modify();
                            end;
                        end;

                        CurrPage.Update();
                        CurrPage.Close();
                        Message(Text002Lbl, Rec."Application No.");
                    end else
                        exit;
                end;
            }
            action("&Cancelled")
            {
                ApplicationArea = All;
                Caption = 'Cancelled';
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()

                begin
                    if Rec.Status = Rec.status::Cancelled then
                        Error('Status is already Cancelled');

                    if Rec."Rejection Remark" <> '' then
                        Error('Rejection Remarks must be blank.');

                    IF CONFIRM(Text003Lbl, FALSE, Rec."Application No.") THEN BEGIN

                        IF Rec."Final Approval" = true then
                            Error('Final Approval must be false, you cannot reject');

                        Rec.TestField("Cancelled Remarks");

                        LeavesApprovalRec.SetRange("Application No.", Rec."Application No.");
                        IF LeavesApprovalRec.FindSet() then begin
                            repeat
                                LeavesApprovalRec.Status := LeavesApprovalRec.Status::Cancelled;
                                LeavesApprovalRec."Cancelled On" := WorkDate();
                                LeavesApprovalRec."Cancelled By" := UserId();
                                LeavesApprovalRec."Cancelled In Days" := Today() - Rec."Application Date";
                                LeavesApprovalRec.Modify();
                            until LeavesApprovalRec.next() = 0;

                            StudentLeaveAbsenceRec.Reset();
                            StudentLeaveAbsenceRec.SetRange("Application No.", Rec."Application No.");
                            if StudentLeaveAbsenceRec.FindFirst() then begin
                                StudentLeaveAbsenceRec."Status" := StudentLeaveAbsenceRec."Status"::Cancelled;
                                StudentLeaveAbsenceRec.Modify();
                            end;
                        end;

                        Rec.Status := Rec.Status::Cancelled;
                        Rec."Cancelled On" := WorkDate();
                        Rec."Cancelled By" := UserId();
                        Rec."Cancelled In Days" := Today() - Rec."Application Date";
                        Rec.Modify();
                        //LeaveRejectionMail("Student No.");GNCSCOM
                        StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Leaves") + ' ' + Rec."Application No." + ' is Cancelled', USerID(), Today());//CSPL00307-12-10-21
                        CurrPage.Update();
                        CurrPage.Close();
                        Message(Text004Lbl, Rec."Application No.");
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
                Visible = RejectButtonVisible Or FinalApproverView;
                trigger OnAction()
                begin
                    if Rec.Status = Rec.status::Rejected then
                        Error('Status is already on Rejected');

                    if Rec."Cancelled Remarks" <> '' then
                        Error('Cancelled Remarks must be blank.');

                    IF CONFIRM(Text005Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        IF (Rec."Final Approval" = true) AND (Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA) then
                            Error('Final Approval can not Rejected.');

                        Rec.TestField("Rejection Remark");
                        Rec.Status := Rec.Status::Rejected;
                        Rec."Rejected On" := WorkDate();
                        Rec."Rejected By" := UserId();
                        Rec."Rejected In Days" := Today() - Rec."Application Date";
                        Rec.Modify();
                        // IF "Type of Leaves" = "Type of Leaves"::SLOA then
                        //     SLOAReject();
                        // IF "Type of Leaves" = "Type of Leaves"::ELOA then
                        //     ELOARejectmail();

                        //LeaveHoldMail("Student No.");//GMCSCOM
                        StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Leaves") + ' ' + Rec."Application No." + ' is Rejected by ' + Rec."Department Name", USerID(), Today());//CSPL00307-12-10-21
                        CurrPage.Update();
                        CurrPage.Close();
                        Message(Text006Lbl, Rec."Application No.");
                    end else
                        exit;
                end;
            }
            action("Uploaded Document")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Uploaded Document';
                Runobject = page "Student Document Attachment";
                RunPageLink = "SLcM Document No" = FIELD("Application No.");
            }

        }
    }
    trigger OnInit()
    begin
        Registrareditable := false;
    end;

    trigger OnOpenPage()
    begin
        Boolean_gBool := false;
        if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
            Boolean_gBool := true;


        ProcessBoolean := false;
        FinalApproverView := false;

        IF (Rec."Type of Leaves" IN [Rec."Type of Leaves"::CLOA, Rec."Type of Leaves"::SLOA]) AND Rec.CheckHelloSignConfirmed(Rec."Application No.") then //CSPL-00307-HelloSign_BUG
            FinalApproverView := true;

        if Rec."Final Approval" AND Rec.CheckHelloSignConfirmed(Rec."Application No.") then begin //CSPL-00307-HelloSign_BUG
            ProcessBoolean := true;
        end;


        IF Rec.CheckHelloSignConfirmed(Rec."Application No.") then //CSPL-00307-HelloSign_BUG
            RejectApproveBoolean := true;
        if Rec."Final Approval" then
            RejectApproveBoolean := false;

        if (Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA) and (Rec."Approved for Department" = '8006') then
            Registrareditable := true
        else
            Registrareditable := false;

        LDAChangeComments := false;
        DepartmentMasterRec.Reset();
        DepartmentMasterRec.Setfilter("User Name", DepartmentMasterRec.GetUserGroup());
        DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
        DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA);
        //CSPL-00307-T1-T1516-CR
        if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
        if Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA);
        //CSPL-00307-T1-T1516-CR
        IF DepartmentMasterRec.FindFirst() then begin
            if DepartmentMasterRec."Update LDA" then
                LDAChangeComments := true;
        End;

        RejectButtonVisible := false;
        DepartmentMasterRec.Reset();
        DepartmentMasterRec.Setfilter("User Name", DepartmentMasterRec.GetUserGroup());
        DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
        DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA);
        //CSPL-00307-T1-T1516-CR
        if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
        if Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA);
        //CSPL-00307-T1-T1516-CR
        IF DepartmentMasterRec.FindFirst() then begin
            if DepartmentMasterRec."Reject Permission" AND Rec.CheckHelloSignConfirmed(Rec."Application No.") then //CSPL-00307-HelloSign_BUG
                RejectButtonVisible := true;
        End;


    end;

    trigger OnAfterGetRecord()
    Begin
        ProcessBoolean := false;
        FinalApproverView := false;
        IF (Rec."Type of Leaves" IN [Rec."Type of Leaves"::CLOA, Rec."Type of Leaves"::SLOA]) AND Rec.CheckHelloSignConfirmed(Rec."Application No.") then //CSPL-00307-HelloSign_BUG
            FinalApproverView := true;
        if Rec."Final Approval" AND Rec.CheckHelloSignConfirmed(Rec."Application No.") then begin //CSPL-00307-HelloSign_BUG
            ProcessBoolean := true;

        end;

        IF Rec.CheckHelloSignConfirmed(Rec."Application No.") then //CSPL-00307-HelloSign_BUG
            RejectApproveBoolean := true;
        if Rec."Final Approval" then
            RejectApproveBoolean := false;

        LDAChangeComments := false;
        DepartmentMasterRec.Reset();
        DepartmentMasterRec.Setfilter("User Name", DepartmentMasterRec.GetUserGroup());
        DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
        DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA);
        //CSPL-00307-T1-T1516-CR
        if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
        if Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA);
        //CSPL-00307-T1-T1516-CR
        IF DepartmentMasterRec.FindFirst() then begin
            if DepartmentMasterRec."Update LDA" then
                LDAChangeComments := true;
        End;

        RejectButtonVisible := false;
        DepartmentMasterRec.Reset();
        DepartmentMasterRec.Setfilter("User Name", DepartmentMasterRec.GetUserGroup());
        DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
        DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA);
        //CSPL-00307-T1-T1516-CR
        if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
        if Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA);
        //CSPL-00307-T1-T1516-CR
        IF DepartmentMasterRec.FindFirst() then begin
            if DepartmentMasterRec."Reject Permission" AND Rec.CheckHelloSignConfirmed(Rec."Application No.") then //CSPL-00307-HelloSign_BUG
                RejectButtonVisible := true;
        End;
    end;

    var
        StudentLeaveAbsenceRec: Record "Student Leave of Absence";
        LeavesApprovalRec: Record "Leaves Approvals";
        StudentMasterRec: Record "Student Master-CS";
        DepartmentMasterRec: Record "Withdrawal Department";
        StudentTimeLineRec: Record "Student Time Line";
        StudentStatusMangementCod: Codeunit "Student Status Mangement";
        Boolean_gBool: Boolean;
        ProcessBoolean: Boolean;
        RejectApproveBoolean: Boolean;
        Registrareditable: Boolean;
        FinalApproverView: Boolean;
        LDAChangeComments: Boolean;
        RejectButtonVisible: Boolean;

        Text001Lbl: Label 'Do you want to Approve Application No. %1 ?';
        Text002Lbl: Label 'Application No. %1 has been Approved.';
        Text003Lbl: Label 'Do you want to Rejected Application No. %1 ?';
        Text004Lbl: Label 'Application No. %1 has been Rejected.';
        Text005Lbl: Label 'Do you want to Reject Application No. %1 ?';
        Text006Lbl: Label 'Application No. %1 has been Rejected.';





    procedure SLOARequest()
    var
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCSL";
        BodyText: text[2048];
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
    begin
        SmtpMailRec.Get();
        Studentmaster.GET(Rec."Student No.");
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."Application No." + ' # SLOA: ' + Rec.Semester;

        //SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM
        SmtpMail.AppendtoBody('Dear Student ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Thank you for your submission. Your request has been received and recorded on ' + Format(Rec."Application Date") + ' and is under final review.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Please schedule an appointment to discuss your SLOA request by using this link: https://tinyurl.com/auabookosa');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('You will receive the final notification after approval within 3-5 business days. If you have any questions, please feel free to contact our office.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Office Of Student Affairs');

        BodyText := SmtpMail.GetBody();
        //Mail_lCU.Send();//GMCSCOM
        WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('SLOA Request', 'MEA', SenderAddress, Studentmaster."Student Name",
    Studentmaster."No.", Subject, BodyText, 'SLOA Request', 'SLOA Request', '', '',
    Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;


    procedure SLOAApproval()
    var
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        Semster_lRec: Record "Semester Master-CS";
        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCSL";
        BodyText: text[2048];
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
    begin
        SmtpMailRec.Get();
        Studentmaster.GET(Rec."Student No.");
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."Application No." + ' # SLOA Approval: ' + Rec.Semester;
        //SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM
        SmtpMail.AppendtoBody('Dear Student, ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Please be advised that your request for SLOA has been  Approved .');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Dates: ' + Format(Rec."Start Date") + ' - ' + Format(Rec."End Date"));
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Reason: ' + Rec."Reason for Leave");
        // SmtpMail.AppendtoBody('<br><br>');
        Semster_lRec.Reset();
        Semster_lRec.SetRange(Code, Rec.Semester);
        IF Semster_lRec.FindFirst() then
            SmtpMail.AppendtoBody('Enrolled Semester: ' + Format(Semster_lRec.Sequence));
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Office Of Registrar');
        BodyText := SmtpMail.GetBody();
        // Mail_lCU.Send();//GMCSCOM
        WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('SLOA Approval', 'MEA', SenderAddress, Studentmaster."Student Name",
    Studentmaster."No.", Subject, BodyText, 'SLOA Approval', 'SLOA Approval', '', '',
    Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;

    procedure SLOAReject()
    var
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCSL";
        BodyText: text[2048];
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
    begin
        SmtpMailRec.Get();
        Studentmaster.GET(Rec."Student No.");
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."Application No." + ' # SLOA Rejection: ' + Rec.Semester;

        //SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM
        SmtpMail.AppendtoBody('Dear Student,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Please be advised that your request for SLOA has been  Rejected .  The reason for the rejection is: ' + Rec."Reason for Leave");
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('For further clarifications, please contact Dean of student.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards, ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Office Of Registrar');
        BodyText := SmtpMail.GetBody();
        //Mail_lCU.Send();//GMCSCOM
        WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('SLOA Rejection', 'MEA', SenderAddress, Studentmaster."Student Name",
    Studentmaster."No.", Subject, BodyText, 'SLOA Rejection', 'SLOA Rejection', '', '',
    Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;


    procedure ELOARequestSend(Rec: Record "Student Leave of Absence")
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
        Studentmaster.GET(Rec."Student No.");
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."Application No." + ' # ELOA: ' + Rec.Semester;
        // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM
        SmtpMail.AppendtoBody('Dear Student, ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Thank you for your submission. Your request has been received and recorded on ' + Format(Rec."Application Date") + ' and is under review by the concerned departments.');
        SmtpMail.AppendtoBody('<br><br>');

        SmtpMail.AppendtoBody('You will receive the final approval notification within 3-5 business days. If you have any questions, please feel free to contact our office.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Office Of Registrar');
        BodyText := SmtpMail.GetBody();
        // Mail_lCU.Send();//GMCSCOM
        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('ELOA Request', 'MEA', SenderAddress, Studentmaster."Student Name",
    Studentmaster."No.", Subject, BodyText, 'ELOA Request', 'ELOA Request', '', '',
    Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;


    procedure ELOAApprovalRequest()
    var
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        SemesterMaster_lRec: Record "Semester Master-CS";
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
        Studentmaster.GET(Rec."Student No.");
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."Application No." + ' # ELOA Approval: ' + Rec.Semester;
        // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM
        SmtpMail.AppendtoBody('Dear Student,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Please be advised that your request for ELOA has been Approved.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Dates: ' + Format(Rec."Start Date") + ' - ' + Format(Rec."End Date"));
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Reason: ' + Rec."Reason for Leave");
        // SmtpMail.AppendtoBody('<br><br>');
        SemesterMaster_lRec.Reset();
        SemesterMaster_lRec.SetRange(Code, Rec.Semester);
        IF SemesterMaster_lRec.Findfirst() then
            SmtpMail.AppendtoBody('Enrolled Semester: ' + Format(SemesterMaster_lRec.Sequence));
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards, ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Office Of Registrar ');
        BodyText := SmtpMail.GetBody();
        // Mail_lCU.Send();//GMCSCOM
        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('ELOA Approval', 'MEA', SenderAddress, Studentmaster."Student Name",
    Studentmaster."No.", Subject, BodyText, 'ELOA Approval', 'ELOA Approval', '', '',
    Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;

    procedure ELOARejectmail()
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
        IF Rec.Semester <> 'MED3' Then Begin
            SmtpMailRec.Get();
            Studentmaster.GET(Rec."Student No.");
            Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
            Recipient := Studentmaster."E-Mail Address";
            Recipients := Recipient.Split(';');
            SenderName := 'MEA';
            SenderAddress := SmtpMailRec."Email Address";
            Subject := Rec."Application No." + ' # ELOA Rejection: ' + Rec.Semester;

            // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM
            SmtpMail.AppendtoBody('Dear Student, ');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('Please be advised that your request for ELOA has been Rejected due to the following reason: ' + Rec."Reason for Leave");
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('For further clarifications, please email the Office of Student Affairs at studentaffairs@auamed.net');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('Regards, ');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('Office Of Registrar');
            BodyText := SmtpMail.GetBody();
            //Mail_lCU.Send();//GMCSCOM
            WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('ELOA Rejected', 'MEA', SenderAddress, Studentmaster."Student Name",
        Studentmaster."No.", Subject, BodyText, 'ELOA Rejected', 'ELOA Rejected', '', '',
        Recipient, 1, Studentmaster."Mobile Number", '', 1);
        End;
    end;

    procedure CLOAApprovalRequest()
    var
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        SemesterMaster_lRec: Record "Semester Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
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
        Studentmaster.GET(Rec."Student No.");
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetCurrentKey("Student ID", "Start Date");
        RosterLedgerEntry.SetRange("Student ID", Rec."Student No.");
        RosterLedgerEntry.SetFilter("Start Date", '>%1', Rec."End Date");
        RosterLedgerEntry.SetAscending("Start Date", true);
        RosterLedgerEntry.SetFilter(Status, '%1|%2', RosterLedgerEntry.Status::Published, RosterLedgerEntry.Status::Scheduled);
        IF RosterLedgerEntry.FindFirst() then;

        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."Application No." + ' CLOA : ' + Rec."Student Name" + ', ' + Rec."Student No." + ' ' + Rec.Semester;
        //GMCSCOMSmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
        SmtpMail.AppendtoBody('Dear ' + Studentmaster."First Name" + ', ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('This email is to inform you that your Clinical Leave of Absence (CLOA) application is approved for the following dates: Last Date of Full-Time Attendance:' + Format(Rec."Last Date Of Attendance") + ' through ' + Format(RosterLedgerEntry."Start Date") + ': Clinical Rotation Start Date. You are required to notify the Office of the Registrar if you cancel your Clinical Rotation Start Date, adjust your clinical rotation schedule, or return early from your CLOA. <br><br>');
        SmtpMail.AppendtoBody('Failure to notify the Office of the Registrar of any changes in your clinical rotation schedule may subject you to an Administrative Withdrawal for unapproved absences. Please be sure to review the Student Handbook, which includes the full CLOA policy, <a href ="http://auamed.org/student-life/guides/student-handbook/">http://auamed.org/student-life/guides/student-handbook/</a><br><br>');
        SmtpMail.AppendtoBody('If you have any questions, please feel free to contact our office.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Sincerely,<br>');
        SmtpMail.AppendtoBody('Office Of Registrar ');
        BodyText := SmtpMail.GetBody();
        //Mail_lCU.Send();//GMCSCOM
        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('CLOA Approval', 'MEA', SenderAddress, Studentmaster."Student Name",
    Studentmaster."No.", Subject, BodyText, 'CLOA Approval', 'CLOA Approval', '', '',
    Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;

    procedure SendForApproval_gFnc(var LeavesApprovals_vRec: Record "Leaves Approvals")
    var
        WithdrawalDepartment_lRec: Record "Withdrawal Department";
        LeavesApprovals_lRec: Record "Leaves Approvals";
    begin
        if not Confirm(Text004_gCtx, true) then
            exit;

        WithdrawalDepartment_lRec.Reset;
        WithdrawalDepartment_lRec.SetCurrentkey("Document Type", Sequence);
        WithdrawalDepartment_lRec.SetRange("Document Type", LeavesApprovals_vRec."Type of Leaves");
        WithdrawalDepartment_lRec.SetFilter("User E-Mail", '<>%1', '');
        if WithdrawalDepartment_lRec.IsEmpty then
            Error('Leaves Approvals Approver is not define for User ID %1', UserId);

        //LeavesApprovals_vRec.Status := LeavesApprovals_vRec.Status::"Pending for Approval";
        //LeavesApprovals_vRec.Modify;

        LeavesApprovals_lRec.Reset;
        LeavesApprovals_lRec.SetRange(LeavesApprovals_lRec."Type of Leaves", LeavesApprovals_vRec."Type of Leaves");
        LeavesApprovals_lRec.SetRange("Application No.", LeavesApprovals_vRec."Application No.");
        LeavesApprovals_lRec.SetRange(Status, LeavesApprovals_vRec.Status::Open);
        if LeavesApprovals_lRec.FindFirst then begin
            if ApproveEntry_gFnc(LeavesApprovals_lRec, false) then begin
                Message(Text013_gCtx);
                exit;
            end;
        end;

        //SendForApprovalEmail_gFnc(LeavesApprovals_vRec);

        Message(Text003_gCtx);
    end;


    procedure ApproveEntry_gFnc(var UserAppEntry_vRec: Record "Leaves Approvals"; ShowConfirm_iBln: Boolean): Boolean
    var
        LR_lRec: Record "Leaves Approvals";
    begin
        // if ShowConfirm_iBln then begin
        //     if not Confirm(Text007_gCtx, false) then
        //         exit;
        // end;
        //  UserAppEntry_vRec.Status := UserAppEntry_vRec.Status::Approved;
        If UserAppEntry_vRec.sequence > 0 then begin
            UserAppEntry_vRec.Status := UserAppEntry_vRec.Status::Approved;
            UserAppEntry_vRec.Modify(true);
        end;
        exit;
    end;

    procedure SLOABulkMailSend()//Nitin
    var
        SMTPMailSetup: Record "Email Account";
        RecStudent: Record "Student Master-CS";
        EduSetup: Record "Education Setup-CS";
        SMTPMail: codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        Recipients: List of [Text];
        Recipient: Text;
        SenderAddress: Text[250];
        Subject: Text;
        BodyText: Text;
        SenderName: Text;


    begin
        //CSPL-00307-SLOA_Change

        EduSetup.SetRange("Global Dimension 1 Code", '9000');
        IF EduSetup.FindFirst() then;
        EduSetup.TestField("Bulk EMail-Id");
        SMTPMailSetup.GET();
        Recipient := EduSetup."Bulk EMail-Id";
        Recipients := Recipient.Split(';');
        SenderName := '';
        SenderAddress := SmtpMailSetup."Email Address";



        CLEAR(SMTPMail);
        // SMTPMail.Create(SenderName, SenderAddress, Recipients, '' + 'SLOA Leave', '');//GMCSCOM
        Smtpmail.AppendtoBody('Good Day,');
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('<br/>');
        SMTPMail.AppendtoBody('Please be advised that ' + Rec."Student Name" + ' (' + Rec."Student No." + ') has been approved for a short term leave of absence on the dates mentioned below.');
        SMTPMail.AppendtoBody('<br/>');
        SMTPMail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('Dates: ' + Format(Rec."Start Date") + ' - ' + Format(Rec."End Date"));
        SMTPMail.AppendtoBody('<br/>');
        // Smtpmail.AppendtoBody('Reason: ' + Rec."Reason for Leave");
        // SMTPMail.AppendtoBody('<br/>');
        SMTPMail.AppendtoBody('Enrolled Semester: ' + Rec.Semester);
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('Regards,');
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('Office of the Registrar');
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('_____________________');
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('Office of the Registrar - Campus');
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('p: (268) 484-8900');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('registrar@auamed.net');
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('American University of Antigua College of Medicine');
        Smtpmail.AppendtoBody('<br/>');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('University Park');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('Jabberwock Beach Road');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('P.O. Box  1451');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('Coolidge, Antigua');
        Smtpmail.AppendtoBody('<br/>');
        smtpmail.AppendtoBody('www.auamed.org');

        BodyText := SmtpMail.GetBody();
        BodyText := ReplaceString(BodyText, '<br/>', ' ');
        // Mail_lCU.Send();//GMCSCOM
        InsertNote(Rec."Student No.", BodyText);        //Insert Notes 21Feb2023
        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('SLOA', 'MEA', SenderAddress, RecStudent."Student Name",
        Format(RecStudent."No."), Subject, BodyText, 'SLOA', 'SLOA', rec."Approved for Department", Format(rec."Application Date"),
        Recipient, 1, RecStudent."Mobile Number", '', 1);
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

    Procedure InsertNote(StudentNo: Code[20]; CommText: Text)
    var
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        UserSetup: Record "User Setup";
        StudentMaster: Record "Student Master-CS";
        usersetupapprover: record "Document Approver Users";
        EntryNo: Integer;
    Begin
        InterLogEntryCommentLine.Reset();
        if InterLogEntryCommentLine.FindLast() then
            EntryNo := InterLogEntryCommentLine."Entry No."
        else
            EntryNo := 0;

        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        usersetupapprover.Reset();
        usersetupapprover.SetRange("User ID", userid());
        if usersetupapprover.FindFirst() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then begin

            InterLogEntryCommentLine.Init();
            InterLogEntryCommentLine."Entry No." := EntryNo + 1;
            InterLogEntryCommentLine."Source No." := StudentNo;
            InterLogEntryCommentLine.Validate("Interaction Template Code", 'REGSLOA');
            InterLogEntryCommentLine.Validate("Interaction Group Code", 'REGSLOA');
            InterLogEntryCommentLine.Validate("Student No.", StudentNo);
            InterLogEntryCommentLine."Original Student No." := StudentMaster."Original Student No.";
            InterLogEntryCommentLine.Validate("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            InterLogEntryCommentLine.Department := InterLogEntryCommentLine.Department::"Registrar Department";
            InterLogEntryCommentLine."Created By" := UserId();
            InterLogEntryCommentLine."Created On" := Today();
            InterLogEntryCommentLine.Notes := CommText;
            InterLogEntryCommentLine.Insert(true);
        end;
    End;

    Procedure ReplaceString(String: Text; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text
    var
    Begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
        exit(NewString);
    end;
}
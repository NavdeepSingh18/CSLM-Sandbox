page 50702 "Financial Accountability"
{

    PageType = Card;
    SourceTable = "Financial Accountability";
    Caption = 'Pending Financial Accountability Card';
    RefreshOnActivate = true;
    DeleteAllowed = false;
    UsageCategory = None;
    InsertAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Fine Application No."; Rec."Fine Application No.")
                {
                    ApplicationArea = All;
                    Editable = ShowButton;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                Field("Fine Date"; Rec."Fine Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = ShowButton;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Fine Category Code"; Rec."Fine Category Code")
                {
                    ApplicationArea = All;
                    Editable = ShowButton;
                }
                field("Fine Category Description"; Rec."Fine Category Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Applicable Amount"; Rec."Applicable Amount")
                {
                    ApplicationArea = All;
                    Editable = ShowButton;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    visible = Boolean_gBool1;
                }
                field("Fee Component Code"; Rec."Fee Component Code")
                {
                    ApplicationArea = All;
                    visible = Boolean_gBool1;
                }
                field("Fee Component Description"; Rec."Fee Component Description")
                {
                    ApplicationArea = All;
                    visible = Boolean_gBool1;
                }

                field("Rejection Remarks"; Rec."Rejection Remarks")
                {
                    ApplicationArea = All;
                    visible = Boolean_gBool1;
                    MultiLine = true;
                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                    visible = Boolean_gBool;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
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
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Visible = ShowButtoninHousing;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction()
                var
                    usersetupapprover: Record "Document Approver Users";
                begin
                    usersetupapprover.Reset();
                    usersetupapprover.setrange("User ID", UserId());
                    usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Bursar Department");
                    IF not usersetupapprover.FindFirst() then
                        Error('You can not Approve');
                    // if UserSetup.Get(UserId()) then
                    //     if UserSetup."Department Approver" <> UserSetup."Department Approver"::"Bursar Department" then
                    //         Error('You can not Approve');

                    if Rec."Rejection Remarks" <> '' then
                        Error('Rejection remark must be blank');

                    if Rec."Applicable Amount" <> Rec."Approved Amount" then
                        If Confirm(Text008Lbl, false, Rec."Fine Application No.") then begin
                        end else
                            exit;
                    If Confirm(Text003Lbl, false, Rec."Fine Application No.") then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec."Approved By" := UserId();
                        Rec."Approved On" := WorkDate();
                        Rec."Approved In Days" := Rec."Approved On" - Rec."Fine Date";
                        Rec.Modify();
                        InvoiceGeneration();
                        //MailForApproved(Rec."Student No.", Rec."Fine Category Description", Rec."Approved Amount");//GMCSCOM
                        Message(Text006Lbl, Rec."Fine Application No.");
                        CurrPage.Close();
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Visible = ShowButtoninHousing;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                var
                    usersetupapprover: Record "Document Approver Users";
                begin
                    usersetupapprover.Reset();
                    usersetupapprover.setrange("User ID", UserId());
                    usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Financial Aid Department");
                    IF not usersetupapprover.FindFirst() then
                        Error('You can not Reject');

                    // if UserSetup.Get(UserId()) then
                    //     if UserSetup."Department Approver" <> UserSetup."Department Approver"::"Financial Aid Department" then
                    //         Error('You can not Reject');

                    Rec.TestField("Rejection Remarks");
                    If Confirm(Text004Lbl, false, Rec."Fine Application No.") then begin
                        Rec.Status := Rec.Status::Rejected;
                        Rec."Rejected By" := UserId();
                        Rec."Rejected On" := WorkDate();
                        Rec.Modify();
                        //MailForRejection(Rec."Student No.", Rec."Fine Category Description", Rec."Applicable Amount");//GMCSCOM
                        Message(Text007Lbl, Rec."Fine Application No.");
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
    var
        UserSetup: Record "User Setup";
        ShowButton: Boolean;
        MailShowButton: Boolean;
        ShowButtoninHousing: Boolean;
        HousingRoleCenterNotShowing: Boolean;
        Boolean_gBool: Boolean;
        Boolean_gBool1: Boolean;
        Text003Lbl: Label 'Do you want to approve Application No. %1 ?';
        Text004Lbl: Label 'Do you want to reject Application No. %1 ?';
        Text006Lbl: Label 'Application No. %1 has been approved.';
        Text007Lbl: Label 'Application No. %1 has been rejected.';
        Text008Lbl: Label 'There is difference in Applicable Amount & Approved Amount for Application No. %1, Do you still want to continue?';


    trigger OnAfterGetRecord()
    var
        UserSetup_lRec: Record "User Setup";
        usersetupapprover: Record "Document Approver Users";
    begin
        Boolean_gBool := true;
        Boolean_gBool1 := true;
        if Rec.Status = Rec.Status::Open then begin
            ShowButton := true;
            MailShowButton := false;
            Boolean_gBool := false;
            Boolean_gBool1 := false;
        End else begin
            ShowButton := false;
            MailShowButton := true;
        end;

        HousingRoleCenterNotShowing := true;
        if usersetupapprover.get(userid(), usersetupapprover."Department Approver Type"::"Residential Services") then
            HousingRoleCenterNotShowing := false;
        // UserSetup_lRec.Reset();
        // UserSetup_lRec.SetRange("User ID", UserId());
        // If UserSetup_lRec.FindFirst() then
        //     If UserSetup_lRec."Department Approver" = UserSetup_lRec."Department Approver"::"Residential Services" then
        //         HousingRoleCenterNotShowing := false;


        If (MailShowButton = false) and (HousingRoleCenterNotShowing = false) then
            ShowButtoninHousing := false;
        if (MailShowButton = true) and (HousingRoleCenterNotShowing = false) then
            ShowButtoninHousing := false;
        If (MailShowButton = false) and (HousingRoleCenterNotShowing = True) then
            ShowButtoninHousing := false;
        IF (MailShowButton = true) and (HousingRoleCenterNotShowing = True) then
            ShowButtoninHousing := true;

    end;

    trigger OnOpenPage()
    var
        UserSetup_lRec: Record "User Setup";
        usersetupapprover: Record "Document Approver Users";
    begin
        Boolean_gBool := true;
        Boolean_gBool1 := true;
        if Rec.Status = Rec.Status::Open then begin
            ShowButton := true;
            MailShowButton := false;
            Boolean_gBool := false;
            Boolean_gBool1 := false;
        End else begin
            ShowButton := false;
            MailShowButton := true;
        end;

        HousingRoleCenterNotShowing := true;
        if usersetupapprover.get(userid(), usersetupapprover."Department Approver Type"::"Residential Services") then
            HousingRoleCenterNotShowing := false;
        /* UserSetup_lRec.Reset();
        UserSetup_lRec.SetRange("User ID", UserId());
        If UserSetup_lRec.FindFirst() then
            If UserSetup_lRec."Department Approver" = UserSetup_lRec."Department Approver"::"Residential Services" then
                HousingRoleCenterNotShowing := false;
 */

        If (MailShowButton = false) and (HousingRoleCenterNotShowing = false) then
            ShowButtoninHousing := false;
        if (MailShowButton = true) and (HousingRoleCenterNotShowing = false) then
            ShowButtoninHousing := false;
        If (MailShowButton = false) and (HousingRoleCenterNotShowing = True) then
            ShowButtoninHousing := false;
        IF (MailShowButton = true) and (HousingRoleCenterNotShowing = True) then
            ShowButtoninHousing := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Boolean_gBool := true;
        Boolean_gBool1 := true;
        if Rec.Status = Rec.Status::Open then begin
            ShowButton := true;
            MailShowButton := false;
            Boolean_gBool := false;
            Boolean_gBool1 := false;
        End else begin
            ShowButton := false;
            MailShowButton := true;
        end;

    end;

    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if Rec."Approved On" = 0D then begin
            PendingDays := Today() - Rec."Fine Date";
            Exit(PendingDays);
        end else
            Exit(0);
    end;

    procedure InvoiceGeneration()
    Var
        GenJournalLine: record "Gen. Journal Line";
        GenJournalLine1: record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        RecFeeSetup: Record "Fee Setup-CS";
        RecStudentMaster: Record "Student Master-CS";
        GenJournalLinePost: Record "Gen. Journal Line";
        FeeComponentRec: Record "Fee Component Master-CS";
        SapRec: Record "SAP Fee Code";
        NoSeries: Codeunit NoSeriesManagement;
        DocumentNo: Code[20];
        LineNo: Integer;
    begin
        RecStudentMaster.Get(Rec."Student No.");
        RecFeeSetup.Reset();
        RecFeeSetup.SetRange("Global Dimension 1 Code", RecStudentMaster."Global Dimension 1 Code");
        IF RecFeeSetup.FindFirst() then;
        RecFeeSetup.TESTFIELD(RecFeeSetup."Fin Account Template Name");
        RecFeeSetup.TESTFIELD(RecFeeSetup."Fin Acc Batch Name");
        RecFeeSetup.TESTFIELD(RecFeeSetup."Fin Acc Due Date");

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", RecFeeSetup."Fin Account Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", RecFeeSetup."Fin Acc Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            DocumentNo := INCSTR(GenJournalLine."Document No.")
        ELSE begin
            GenJournalBatch.RESET();
            GenJournalBatch.SETRANGE("Journal Template Name", RecFeeSetup."Fin Account Template Name");
            GenJournalBatch.SETRANGE(Name, RecFeeSetup."Fin Acc Batch Name");
            IF GenJournalBatch.FINDFIRST() THEN;
            DocumentNo := NoSeries.GetNextNo(GenJournalBatch."No. Series", 0D, false);
        end;

        LineNo := 0;
        GenJournalLine1.RESET();
        GenJournalLine1.SETRANGE("Journal Template Name", RecFeeSetup."Fin Account Template Name");
        GenJournalLine1.SETRANGE("Journal Batch Name", RecFeeSetup."Fin Acc Batch Name");
        IF GenJournalLine1.FINDLAST() THEN
            LineNo := GenJournalLine1."Line No." + 10000
        ELSE
            LineNo := 10000;

        GenJournalLine.reset();
        GenJournalLine.INIT();
        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", RecFeeSetup."Fin Account Template Name");
        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", RecFeeSetup."Fin Acc Batch Name");
        GenJournalLine.VALIDATE(GenJournalLine."Line No.", LineNo);
        GenJournalLine.VALIDATE(GenJournalLine."Posting Date", WORKDATE());
        GenJournalLine.VALIDATE(GenJournalLine."Document Type", GenJournalLine."Document Type"::Invoice);
        GenJournalLine.VALIDATE(GenJournalLine."Document No.", DocumentNo);
        GenJournalLine.VALIDATE(GenJournalLine."Account Type", GenJournalLine."Account Type"::"G/L Account");
        if FeeComponentRec.Get(Rec."Fee Component Code") then begin
            GenJournalLine.VALIDATE(GenJournalLine."Account No.", FeeComponentRec."G/L Account");
            SapRec.Reset();
            SapRec.SetRange("SAP Code", FeeComponentRec."SAP Code");
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
                GenJournalLine."Fee Description" := FeeComponentRec.Description;
            end;
            //  GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code", FeeComponentRec."Global Dimension 1 Code");
            //  GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code", FeeComponentRec."Global Dimension 2 Code");
        end;

        GenJournalLine.VALIDATE(GenJournalLine."Debit Amount", (-1 * Rec."Approved Amount"));
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", RecStudentMaster."Original Student No.");
        GenJournalLine.VALIDATE(GenJournalLine."External Document No.", Rec."Fine Application No.");
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code", RecStudentMaster."Currency Code");
        //  GenJournalLine.Validate(GenJournalLine.Description, 'Financial Accountability');
        GenJournalLine.VALIDATE(GenJournalLine.Year, RecStudentMaster.Year);
        GenJournalLine.VALIDATE("Enrollment No.", RecStudentMaster."Enrollment No.");
        GenJournalLine.VALIDATE(Semester, Rec.Semester);
        GenJournalLine.VALIDATE(GenJournalLine.Course, RecStudentMaster."Course Code");
        GenJournalLine.VALIDATE(GenJournalLine."Academic Year", RecStudentMaster."Academic Year");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code", Rec."Global Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code", Rec."Global Dimension 2 Code");
        GenJournalLine.Description := 'Financial Accountability';
        GenJournalLine."Due Date" := CalcDate(RecFeeSetup."Fin Acc Due Date", WorkDate());
        GenJournalLine.INSERT(TRUE);

        // if RecFeeSetup."Waiver Auto Post" then begin
        GenJournalLinePost.Reset();
        GenJournalLinePost.SETRANGE("Journal Template Name", RecFeeSetup."Fin Account Template Name");
        GenJournalLinePost.SETRANGE("Journal Batch Name", RecFeeSetup."Fin Acc Batch Name");
        GenJournalLinePost.SetRange("Document No.", DocumentNo);
        IF GenJournalLinePost.Findset() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLinePost);
        // end;
    end;


}
page 50832 FinancialAidRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueFinancialAid;
    Caption = 'Financial Aid Role Center';

    layout
    {
        area(Content)
        {
            cuegroup("Pending Application Cue")
            {
                field("Financial Aid Apps"; Rec."Pending Financial Aid Apps")
                {
                    caption = 'Financial Aid Application';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Financial AID Pending List";
                }

                field("Semester Warning Apps"; Rec."Pending Semester Warning Apps")
                {
                    Caption = 'Semester Warning Application';
                    ApplicationArea = Basic, Suite;
                    //DrillDownPageID = "";
                }
                field("Appeal Applications"; Rec."Pending Appeal Applications")
                {
                    caption = 'Appeal Applications';
                    ApplicationArea = Basic, Suite;
                    //DrillDownPageID = "";
                }
                field("ELOA Application"; Rec."Pending ELOA Application")
                {
                    Caption = 'ELOA Application';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Leaves Approvals";//50719
                    trigger OnDrillDown()
                    var
                        PendingLeavesApprovals: Page "Pending Leaves Approvals";
                        LeavesApprovals_Rec: Record "Leaves Approvals";
                    begin
                        LeavesApprovals_Rec.reset();
                        LeavesApprovals_Rec.SetRange(LeavesApprovals_Rec."Type of Leaves", LeavesApprovals_Rec."Type of Leaves"::ELOA);
                        LeavesApprovals_Rec.SetFilter("Approved for Department", '%1', 'FINANCIALAID');
                        if LeavesApprovals_Rec.findset then begin
                            PendingLeavesApprovals.SETTABLEVIEW(LeavesApprovals_Rec);
                            PendingLeavesApprovals.SETRECORD(LeavesApprovals_Rec);
                            PendingLeavesApprovals.RUN;
                        end
                    end;
                }
                field("Pending CLOA Application"; Rec."Pending CLOA Application")
                {
                    Caption = 'CLOA Application';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Leaves Approvals";//50719
                    trigger OnDrillDown()
                    var
                        PendingLeavesApprovals: Page "Pending Leaves Approvals";
                        LeavesApprovals_Rec: Record "Leaves Approvals";
                    begin
                        LeavesApprovals_Rec.reset();
                        LeavesApprovals_Rec.SetRange(LeavesApprovals_Rec."Type of Leaves", LeavesApprovals_Rec."Type of Leaves"::CLOA);
                        LeavesApprovals_Rec.SetFilter("Approved for Department", '%1', 'FINANCIALAID');
                        if LeavesApprovals_Rec.findset then begin
                            PendingLeavesApprovals.SETTABLEVIEW(LeavesApprovals_Rec);
                            PendingLeavesApprovals.SETRECORD(LeavesApprovals_Rec);
                            PendingLeavesApprovals.RUN;
                        end
                    end;
                }
                field("Withdrawal Application"; Rec."Pending Withdrawal Application")
                {
                    Caption = 'Withdrawal Application';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Pending College Withdrawal";//50858
                    trigger OnDrillDown()
                    var
                        pendgWithdwlApprvls: Page "Pending College Withdrawal";
                        WithdrawalApproval: Record "Withdrawal Approvals";
                        Usersetup: Record "User Setup";
                    begin
                        WithdrawalApproval.reset();
                        if UserSetup."Global Dimension 1 Code" <> '' then
                            WithdrawalApproval.SetFilter("Global Dimension 1 Code", Format(Usersetup."Global Dimension 1 Code"));
                        // WithdrawalApproval.SetRange(Status, WithdrawalApproval.Status::"Pending for Approval");
                        WithdrawalApproval.SetRange("Type of Withdrawal", WithdrawalApproval."Type of Withdrawal"::"College-Withdrawal");
                        WithdrawalApproval.SetFilter("Approved for Department", '%1', 'FINANCIALAID');
                        if WithdrawalApproval.findset then begin
                            pendgWithdwlApprvls.SETTABLEVIEW(WithdrawalApproval);
                            pendgWithdwlApprvls.SETRECORD(WithdrawalApproval);
                            pendgWithdwlApprvls.RUN;
                        end
                    end;
                }
                field("Financial Aid Sign-Off"; Rec."Financial Aid Sign-Off")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Pending Financial Aid SignOff";//50803
                }
            }
        }
    }
    trigger OnOpenPage();
    var
        RoleCenterCueFinancialAid: Record RoleCenterCueFinancialAid;
        FinancialAID: Record "Financial AID";
        WithdrawalApproval: Record "Withdrawal Approvals";
        StudentMasterRec: Record "Student Master-CS";
        LeavesApprovals_Rec: Record "Leaves Approvals";
        UserSetup: Record "User Setup";
    begin

        Rec.RESET();
        Rec.Deleteall();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;


        UserSetup.Get(UserId());
        //Rec.Reset();
        // Rec.setfilter("Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
        // if UserSetup."Global Dimension 1 Code" <> '' then;
        // if Strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
        //     SetFilter("Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
        //     if FindFirst() then;
        // end;
        FinancialAID.reset();
        if UserSetup."Global Dimension 1 Code" <> '' then
            //if Strlen(UserSetup."Global Dimension 1 Code") < 6 then
                FinancialAID.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
        FinancialAID.SetRange(Status, FinancialAID.Status::"Pending for Approval");
        FinancialAID.SetRange(Type, FinancialAID.Type::"Financial Aid");
        if FinancialAID.FindSet() then
            Rec."Pending Financial Aid Apps" := FinancialAID.Count();

        //for withdrawalApproval
        WithdrawalApproval.reset();
        if UserSetup."Global Dimension 1 Code" <> '' then
            WithdrawalApproval.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
        // WithdrawalApproval.SetRange(Status, WithdrawalApproval.Status::"Pending for Approval");
        WithdrawalApproval.SetRange("Type of Withdrawal", WithdrawalApproval."Type of Withdrawal"::"College-Withdrawal");
        WithdrawalApproval.SetFilter("Approved for Department", '%1', 'FINANCIALAID');
        if WithdrawalApproval.FindSet() then
            Rec."Pending Withdrawal Application" := WithdrawalApproval.Count();

        //For ELOA
        LeavesApprovals_Rec.reset();
        LeavesApprovals_Rec.SetRange(Status, LeavesApprovals_Rec.Status::"Pending for Approval");
        LeavesApprovals_Rec.SetRange("Type of Leaves", LeavesApprovals_Rec."Type of Leaves"::ELOA);
        LeavesApprovals_Rec.SetFilter("Approved for Department", '%1', 'FINANCIALAID');
        if LeavesApprovals_Rec.FindSet() then
            Rec."Pending ELOA Application" := LeavesApprovals_Rec.Count();

        //For CLOA
        LeavesApprovals_Rec.reset();
        LeavesApprovals_Rec.SetRange(Status, LeavesApprovals_Rec.Status::"Pending for Approval");
        LeavesApprovals_Rec.SetRange("Type of Leaves", LeavesApprovals_Rec."Type of Leaves"::CLOA);
        LeavesApprovals_Rec.SetFilter("Approved for Department", '%1', 'FINANCIALAID');
        if LeavesApprovals_Rec.FindSet() then
            Rec."Pending CLOA Application" := LeavesApprovals_Rec.Count();

        StudentMasterRec.Reset();
        if UserSetup."Global Dimension 1 Code" <> '' then
            StudentMasterRec.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
        StudentMasterRec.SetFilter("Global Dimension 1 Code", '<>%1', '9100');
        StudentMasterRec.SetRange("Financial Aid Hold", true);
        if StudentMasterRec.FindSet() then
            Rec."Financial Aid Sign-Off" := StudentMasterRec.Count();
        Rec.Modify();
    end;
}
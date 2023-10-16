page 50740 "Clerkship Check Details Change"
{
    PageType = Card;
    UsageCategory = None;
    Caption = 'Clerkship Check Details Change';

    layout
    {
        area(Content)
        {
            group("Change Details")
            {
                field(OldCheckNo; OldCheckNo)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Caption = 'Old Check No.';
                    Editable = false;
                }
                field(OldCheckDate; OldCheckDate)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Caption = 'Old Check Date';
                    Editable = false;
                }
                field(CheckNo; CheckNo)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Caption = 'Check No.';
                }
                field(CheckDate; CheckDate)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Caption = 'Check Date';
                }
                field(ReasonCode; ReasonCode)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Caption = 'Reason Code';
                    TableRelation = "Reason Code".Code;

                    trigger OnValidate()
                    var
                        RecReasonCode: Record "Reason Code";
                    begin
                        ReasonDescription := '';
                        RecReasonCode.Reset();
                        if RecReasonCode.Get(ReasonCode) then
                            ReasonDescription := RecReasonCode.Description;
                    end;
                }
                field(ReasonDescription; ReasonDescription)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Caption = 'Reason Description';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Save")
            {
                ApplicationArea = All;
                Caption = 'Save';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ChangeDate;

                trigger OnAction()
                var
                    ClerkshipPaymentLedgerEntry: Record "Clerkship Payment Ledger Entry";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    I: Integer;
                begin
                    if CheckNo = '' then
                        Error('Check No. must not be Blank.');
                    if CheckDate = 0D then
                        Error('Check Date must not be Blank.');
                    if ReasonDescription = '' then
                        Error('Reason Description must not be Blank.');

                    if not Confirm('Do you want to change the Check Details?\Old Check No. %1\Old Check Date %2\New Check No. %3\New Check Date %4\Due to the Reason %5', true, OldCheckNo, OldCheckDate, CheckNo, CheckDate, ReasonDescription) then
                        exit;

                    for I := 1 to ArrayLen(RotationNos) do
                        if RotationNos[I] <> 0 then begin
                            ClerkshipPaymentLedgerEntry.Reset();
                            if ClerkshipPaymentLedgerEntry.Get(RotationNos[i]) then begin
                                RosterLedgerEntry.Reset();
                                if RosterLedgerEntry.Get(ClerkshipPaymentLedgerEntry."Rotation Entry No.") then begin
                                    RosterLedgerEntry."Check No." := CheckNo;
                                    RosterLedgerEntry."Check Date" := CheckDate;
                                    RosterLedgerEntry.Modify();
                                end;

                                ClerkshipPaymentLedgerEntry."Check No." := CheckNo;
                                ClerkshipPaymentLedgerEntry."Check Date" := CheckDate;
                                ClerkshipPaymentLedgerEntry."Changed Reason Code" := ReasonCode;
                                ClerkshipPaymentLedgerEntry."Changed Reason Description" := ReasonDescription;
                                ClerkshipPaymentLedgerEntry."Changed By" := UserId;
                                ClerkshipPaymentLedgerEntry."Changed On" := Today;
                                ClerkshipPaymentLedgerEntry.Modify();
                            end;
                        end;
                    Message('Check Details Updated Successfully.');
                    CurrPage.Close();
                end;
            }
        }
    }
    procedure SetRotationNos(LRotationNos: array[500] of Integer; LOldCheckNo: Code[20]; LOldCheckDate: Date)
    Var
    begin
        CopyArray(RotationNos, LRotationNos, 1, 500);
        OldCheckNo := LOldCheckNo;
        OldCheckDate := LOldCheckDate;
    end;

    var
        OldCheckNo: Code[20];
        OldCheckDate: Date;
        CheckNo: Code[20];
        CheckDate: Date;
        ReasonCode: Code[20];
        ReasonDescription: Text[50];
        RotationNos: array[500] of Integer;
}
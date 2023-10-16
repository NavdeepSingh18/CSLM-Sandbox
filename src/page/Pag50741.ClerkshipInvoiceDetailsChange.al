page 50741 "Clerkship INV Details Change"
{
    PageType = Card;
    UsageCategory = None;
    Caption = 'Clerkship Invoice Details Change';

    layout
    {
        area(Content)
        {
            group("Change Details")
            {
                field(OldInvoiceNo; OldInvoiceNo)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Caption = 'Old Invoice No.';
                    Editable = false;
                }
                field(OldInvoiceDate; OldInvoiceDate)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Caption = 'Old Invoice Date';
                    Editable = false;
                }
                field(InvoiceNo; InvoiceNo)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Caption = 'Invoice No.';
                }
                field(InvoiceDate; InvoiceDate)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Caption = 'Invoice Date';
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
                    if InvoiceNo = '' then
                        Error('Invoice No. must not be Blank.');
                    if InvoiceDate = 0D then
                        Error('Invoice Date must not be Blank.');
                    if ReasonDescription = '' then
                        Error('Reason Description must not be Blank.');

                    if not Confirm('Do you want to change the Invoice Details?\Old Invoice No. %1\Old Invoice Date %2\New Invoice No. %3\New Invoice Date %4\Due to the Reason %5', true, OldInvoiceNo, OldInvoiceDate, InvoiceNo, InvoiceDate, ReasonDescription) then
                        exit;

                    for I := 1 to ArrayLen(RotationNos) do
                        if RotationNos[I] <> 0 then begin
                            ClerkshipPaymentLedgerEntry.Reset();
                            if ClerkshipPaymentLedgerEntry.Get(RotationNos[i]) then begin
                                RosterLedgerEntry.Reset();
                                if RosterLedgerEntry.Get(ClerkshipPaymentLedgerEntry."Rotation Entry No.") then begin
                                    RosterLedgerEntry."Invoice No." := InvoiceNo;
                                    RosterLedgerEntry."Invoice Date" := InvoiceDate;
                                    RosterLedgerEntry.Modify();
                                end;

                                ClerkshipPaymentLedgerEntry."Invoice No." := InvoiceNo;
                                ClerkshipPaymentLedgerEntry."Invoice Date" := InvoiceDate;
                                ClerkshipPaymentLedgerEntry."Changed Reason Code" := ReasonCode;
                                ClerkshipPaymentLedgerEntry."Changed Reason Description" := ReasonDescription;
                                ClerkshipPaymentLedgerEntry."Changed By" := UserId;
                                ClerkshipPaymentLedgerEntry."Changed On" := Today;
                                ClerkshipPaymentLedgerEntry.Modify();
                            end;
                        end;
                    Message('Invoice Details Updated Successfully.');
                    CurrPage.Close();
                end;
            }
        }
    }
    procedure SetRotationNos(LRotationNos: array[500] of Integer; LOldInvoiceNo: Code[100]; LOldInvoiceDate: Date)
    Var
    begin
        CopyArray(RotationNos, LRotationNos, 1, 500);
        OldInvoiceNo := LOldInvoiceNo;
        OldInvoiceDate := LOldInvoiceDate;
    end;

    var
        OldInvoiceNo: Code[100];
        OldInvoiceDate: Date;
        InvoiceNo: Code[100];
        InvoiceDate: Date;
        ReasonCode: Code[20];
        ReasonDescription: Text[50];
        RotationNos: array[500] of Integer;
}
page 50745 "Clerkship INV/CHK Cancel"
{
    PageType = List;
    UsageCategory = None;
    Caption = 'Clerkship Invoices/Payments Cancellation Request';
    SourceTable = "Clerkship Payment Ledger Entry";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            group("Reason of Cancellation")
            {
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
            repeater("Cancallation Details")
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Check No."; Rec."Check No.")
                {
                    ApplicationArea = All;
                }
                field("Check Date"; Rec."Check Date")
                {
                    ApplicationArea = All;
                }
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }

                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                }
                field("Course Type"; Rec."Course Type")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Total No. of Weeks"; Rec."Total No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field("Actual Rotation Cost"; Rec."Actual Rotation Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Actual Rotation Cost"; Rec."Total Actual Rotation Cost")
                {
                    ApplicationArea = All;
                }
                field("Estimated Rotation Cost"; Rec."Estimated Rotation Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Estd. Rotation Cost"; Rec."Total Estd. Rotation Cost")
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
            action("Send for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    ClerkshipPaymentLedgerEntry: Record "Clerkship Payment Ledger Entry";
                    I: Integer;
                begin
                    if ReasonCode = '' then
                        Error('Reason Code must not be Blank.');

                    if ReasonDescription = '' then
                        Error('Reason Description must not be Blank.');

                    if not Confirm('Do you want to Send Cancellation Request for the following Records:\%1\due to the Reason: %2?\', true, MSG, ReasonDescription) then
                        exit;

                    for I := 1 to ArrayLen(RotationNos) do
                        if RotationNos[I] <> 0 then begin
                            ClerkshipPaymentLedgerEntry.Reset();
                            if ClerkshipPaymentLedgerEntry.Get(RotationNos[i]) then begin
                                ClerkshipPaymentLedgerEntry."Request of Cancellation" := ClerkshipPaymentLedgerEntry."Request of Cancellation"::"Cancellation Request Raised";
                                ClerkshipPaymentLedgerEntry."Cancel Request Reason Code" := ReasonCode;
                                ClerkshipPaymentLedgerEntry."Cancel Request Reason Desc" := ReasonDescription;
                                ClerkshipPaymentLedgerEntry."Cancellation Request Raised By" := UserId;
                                ClerkshipPaymentLedgerEntry."Cancellation Request Raised On" := Today;
                                ClerkshipPaymentLedgerEntry.Modify(true);
                            end;
                        end;
                    Message('Cancellation Request Sent for Approval Successfully.');
                    CurrPage.Close();
                end;
            }
        }
    }
    procedure SetRotationNos(LRotationNos: array[500] of Integer; LMSG: Text)
    Var
    begin
        CopyArray(RotationNos, LRotationNos, 1, 500);
        MSG := LMSG;
    end;

    var
        MSG: Text;
        ReasonCode: Code[20];
        ReasonDescription: Text[100];
        RotationNos: array[500] of Integer;
}
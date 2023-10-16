page 50659 "Clinical Clerkship Payments"
{
    Caption = 'Clinical Clerkship Payment Ledger Entry';
    PageType = List;
    UsageCategory = None;
    SourceTable = "Clerkship Payment Ledger Entry";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Entries)
            {
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
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = All;
                }
                field("Changed On"; Rec."Changed On")
                {
                    ApplicationArea = All;
                }
                field("Changed Reason Description"; Rec."Changed Reason Description")
                {
                    ApplicationArea = All;
                }
                field("Request of Cancellation"; Rec."Request of Cancellation")
                {
                    ApplicationArea = All;
                }
                field("Cancel Request Reason Desc"; Rec."Cancel Request Reason Desc")
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
            action("Raise Cancellation Request")
            {
                ApplicationArea = All;
                Caption = 'Raise Cancellation Request';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendApprovalRequest;
                //     trigger OnAction()
                //     var
                //         ClerkshipPaymentLedgerEntry: Record "Clerkship Payment Ledger Entry";
                //         ClerkshipINVCHKCancel: Page "Clerkship INV/CHK Cancel";
                //         SelectedRosterEntries: array[500] of Integer;
                //         MSG: Text;
                //         I: Integer;
                //         TestingInvoiceNo: Code[20];
                //         Char10: Char;
                //         Char13: Char;
                //         NewLine: Text[10];
                //         ExtDocNo: Code[20];
                //         ExtDocDate: Date;
                //     begin
                //         Char10 := 10;
                //         Char13 := 13;
                //         NewLine := format(Char10) + format(Char13);

                //         Clear(SelectedRosterEntries);
                //         Clear(ClerkshipINVCHKCancel);

                //         I := 0;
                //         MSG := '';

                //         ClerkshipPaymentLedgerEntry.Reset();
                //         CurrPage.SetSelectionFilter(ClerkshipPaymentLedgerEntry);
                //         ClerkshipPaymentLedgerEntry.SetFilter("Request of Cancellation", '%1|%2', ClerkshipPaymentLedgerEntry."Request of Cancellation"::" ",
                //         ClerkshipPaymentLedgerEntry."Request of Cancellation"::"Cancellation Request Rejected");
                //         if ClerkshipPaymentLedgerEntry.FindSet() then
                //             repeat
                //                 I += 1;
                //                 ExtDocNo := '';
                //                 ExtDocDate := 0D;
                //                 if I = 1 then
                //                     TestingInvoiceNo := ClerkshipPaymentLedgerEntry."Invoice No.";

                //                 if TestingInvoiceNo <> ClerkshipPaymentLedgerEntry."Invoice No." then
                //                     Error('You must Select Entries of the Same Invoice/Check No.');

                //                 if ClerkshipPaymentLedgerEntry."Entry Type" = ClerkshipPaymentLedgerEntry."Entry Type"::Invoice then begin
                //                     ExtDocNo := ClerkshipPaymentLedgerEntry."Invoice No.";
                //                     ExtDocDate := ClerkshipPaymentLedgerEntry."Invoice Date";
                //                 end;

                //                 if ClerkshipPaymentLedgerEntry."Entry Type" = ClerkshipPaymentLedgerEntry."Entry Type"::Payment then begin
                //                     ExtDocNo := ClerkshipPaymentLedgerEntry."Check No.";
                //                     ExtDocDate := ClerkshipPaymentLedgerEntry."Check Date";
                //                 end;

                //                 if MSG = '' then
                //                     MSG := Format(I) + '. ' + ClerkshipPaymentLedgerEntry."Rotation ID" + '||' + ClerkshipPaymentLedgerEntry."Student ID" + '||' + ClerkshipPaymentLedgerEntry."Enrollment No." + '||' + ClerkshipPaymentLedgerEntry."Student Name" + '||' + ExtDocNo + '||' + Format(ExtDocDate)
                //                 else
                //                     MSG := MSG + NewLine + Format(I) + '. ' + ClerkshipPaymentLedgerEntry."Rotation ID" + '||' + ClerkshipPaymentLedgerEntry."Student ID" + '||' + ClerkshipPaymentLedgerEntry."Enrollment No." + '||' + ClerkshipPaymentLedgerEntry."Student Name" + '||' + ExtDocNo + '||' + Format(ExtDocDate);

                //                 SelectedRosterEntries[i] := ClerkshipPaymentLedgerEntry."Entry No.";
                //             until ClerkshipPaymentLedgerEntry.Next() = 0;
                //         ClerkshipINVCHKCancel.SetRotationNos(SelectedRosterEntries, MSG);
                //         ClerkshipINVCHKCancel.SetTableView(ClerkshipPaymentLedgerEntry);
                //         ClerkshipINVCHKCancel.Run();
                //     end;
            }
        }
    }
}
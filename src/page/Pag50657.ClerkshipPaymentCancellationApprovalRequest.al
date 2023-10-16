page 50657 "Payment Cancell Appl Request"
{
    Caption = 'Clerkship Payment Cancellation Approval Request';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Clerkship Payment Ledger Entry";
    SourceTableView = where("Request of Cancellation" = filter("Cancellation Request Raised"));
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
                field("Rotation Description"; Rec."Rotation Description")
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
                field("Request of Cancellation"; Rec."Request of Cancellation")
                {
                    ApplicationArea = All;
                }
                field("Cancel Request Reason Desc"; Rec."Cancel Request Reason Desc")
                {
                    ApplicationArea = All;
                }
                field("Cancellation Request Raised By"; Rec."Cancellation Request Raised By")
                {
                    ApplicationArea = All;
                }
                field("Cancellation Request Raised On"; Rec."Cancellation Request Raised On")
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
            action("Accept Request")
            {
                ApplicationArea = All;
                Caption = 'Accept Request';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction()
                begin
                    if not Confirm('Do you want to Accept Cancellation Request of %1 for the Student No. %1 (%2)?', true, Rec."Entry Type", Rec."Student ID", Rec."Student Name") then
                        exit;

                    if Rec."Entry Type" = Rec."Entry Type"::Invoice then
                        ReverseInvoice();

                    if Rec."Entry Type" = Rec."Entry Type"::Payment then
                        ReversePayment();

                    Message('%1 Cancellation Request Accepted.', Rec."Entry Type");
                end;
            }
            action("Reject Request")
            {
                ApplicationArea = All;
                Caption = 'Reject Request';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction()
                begin
                    if not Confirm('Do you want to Reject Cancellation Request of %1 for the Student No. %1 (%2)?', true, Rec."Entry Type", Rec."Student ID", Rec."Student Name") then
                        exit;

                    Rec."Request of Cancellation" := Rec."Request of Cancellation"::"Cancellation Request Rejected";
                    Rec.Modify();
                    Message('%1 Cancellation Request Rejected.', Rec."Entry Type");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
    end;

    procedure ReverseInvoice()
    var
        CheckCPLE: Record "Clerkship Payment Ledger Entry";
        InsCPLE: Record "Clerkship Payment Ledger Entry";
        RLE: Record "Roster Ledger Entry";
        EntryNo: Integer;
    begin
        CheckCPLE.Reset();
        if CheckCPLE.FindLast() then
            EntryNo := CheckCPLE."Entry No.";

        EntryNo := EntryNo + 1;

        InsCPLE.Init();
        InsCPLE.TransferFields(Rec);
        InsCPLE."Entry No." := EntryNo;
        InsCPLE."Entry Type" := InsCPLE."Entry Type"::"Invoice Reversal";
        InsCPLE."Total No. of Weeks" := -1 * Rec."Total No. of Weeks";
        InsCPLE."Weeks Invoiced" := -1 * InsCPLE."Weeks Invoiced";
        InsCPLE."Estimated Rotation Cost" := -1 * Rec."Estimated Rotation Cost";
        InsCPLE."Total Estd. Rotation Cost" := -1 * Rec."Total Estd. Rotation Cost";
        InsCPLE."Actual Rotation Cost" := -1 * Rec."Actual Rotation Cost";
        InsCPLE."Total Actual Rotation Cost" := -1 * Rec."Total Actual Rotation Cost";
        InsCPLE.Reversed := true;
        InsCPLE."Request of Cancellation" := InsCPLE."Request of Cancellation"::"Cancellation Request Approved";
        InsCPLE.Insert();

        RLE.Reset();
        if RLE.Get(Rec."Rotation Entry No.") then begin
            RLE."Weeks Invoiced" := RLE."Weeks Invoiced" - Rec."Weeks Invoiced";

            if RLE."Weeks Invoiced" < 0 then
                RLE."Weeks Invoiced" := 0;

            RLE."Invoice No." := '';
            RLE."Invoice Date" := 0D;
            RLE."Invoice No. Updated" := false;
            RLE.Modify();
        end;

        Rec.Reversed := true;
        Rec."Request of Cancellation" := Rec."Request of Cancellation"::"Cancellation Request Approved";
        Rec.Modify();

        CheckCPLE.Reset();
        CheckCPLE.SetRange("Rotation Entry No.", Rec."Rotation Entry No.");
        CheckCPLE.SetRange("Invoice No.", Rec."Invoice No.");
        CheckCPLE.SetRange("Entry Type", CheckCPLE."Entry Type"::Payment);
        CheckCPLE.SetRange(Reversed, false);
        if CheckCPLE.FindLast() then begin
            EntryNo := EntryNo + 1;
            InsCPLE.Init();
            InsCPLE.TransferFields(CheckCPLE);
            InsCPLE."Entry No." := EntryNo;
            InsCPLE."Entry Type" := InsCPLE."Entry Type"::"Payment Reversal";
            InsCPLE."Total No. of Weeks" := -1 * CheckCPLE."Total No. of Weeks";
            InsCPLE."Weeks Paid" := -1 * InsCPLE."Weeks Paid";
            InsCPLE."Estimated Rotation Cost" := -1 * CheckCPLE."Estimated Rotation Cost";
            InsCPLE."Total Estd. Rotation Cost" := -1 * CheckCPLE."Total Estd. Rotation Cost";
            InsCPLE."Actual Rotation Cost" := -1 * CheckCPLE."Actual Rotation Cost";
            InsCPLE."Total Actual Rotation Cost" := -1 * CheckCPLE."Total Actual Rotation Cost";
            InsCPLE.Reversed := true;
            InsCPLE."Request of Cancellation" := InsCPLE."Request of Cancellation"::"Cancellation Request Approved";
            InsCPLE.Insert();

            RLE.Reset();
            if RLE.Get(CheckCPLE."Rotation Entry No.") then begin
                RLE."Weeks Paid" := RLE."Weeks Paid" - CheckCPLE."Weeks Paid";

                if RLE."Weeks Paid" < 0 then
                    RLE."Weeks Paid" := 0;

                RLE."Check No." := '';
                RLE."Check Date" := 0D;
                RLE."Check No. Updated" := false;
                RLE.Modify();
            end;

            CheckCPLE.Reversed := true;
            CheckCPLE."Request of Cancellation" := CheckCPLE."Request of Cancellation"::"Cancellation Request Approved";
            CheckCPLE.Modify();
        end;
    end;

    procedure ReversePayment()
    var
        CheckCPLE: Record "Clerkship Payment Ledger Entry";
        InsCPLE: Record "Clerkship Payment Ledger Entry";
        RLE: Record "Roster Ledger Entry";
        EntryNo: Integer;
    begin
        CheckCPLE.Reset();
        if CheckCPLE.FindLast() then
            EntryNo := CheckCPLE."Entry No.";

        EntryNo := EntryNo + 1;

        InsCPLE.Init();
        InsCPLE.TransferFields(Rec);
        InsCPLE."Entry No." := EntryNo;
        InsCPLE."Entry Type" := InsCPLE."Entry Type"::"Payment Reversal";
        InsCPLE."Total No. of Weeks" := -1 * Rec."Total No. of Weeks";
        InsCPLE."Weeks Paid" := -1 * InsCPLE."Weeks Paid";
        InsCPLE."Estimated Rotation Cost" := -1 * Rec."Estimated Rotation Cost";
        InsCPLE."Total Estd. Rotation Cost" := -1 * Rec."Total Estd. Rotation Cost";
        InsCPLE."Actual Rotation Cost" := -1 * Rec."Actual Rotation Cost";
        InsCPLE."Total Actual Rotation Cost" := -1 * Rec."Total Actual Rotation Cost";
        InsCPLE.Reversed := true;
        InsCPLE."Request of Cancellation" := InsCPLE."Request of Cancellation"::"Cancellation Request Approved";
        InsCPLE.Insert();

        RLE.Reset();
        if RLE.Get(Rec."Rotation Entry No.") then begin
            RLE."Weeks Paid" := RLE."Weeks Paid" - Rec."Weeks Paid";

            if RLE."Weeks Paid" < 0 then
                RLE."Weeks Paid" := 0;

            RLE."Check No." := '';
            RLE."Check Date" := 0D;
            RLE."Check No. Updated" := false;
            RLE.Modify();
        end;

        Rec.Reversed := true;
        Rec."Request of Cancellation" := Rec."Request of Cancellation"::"Cancellation Request Approved";
        Rec.Modify();
    end;
}
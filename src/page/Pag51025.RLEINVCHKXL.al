page 51025 "Invoice Check Details Update"
{
    Caption = 'Invoice Check Details Update';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RLE INV CHK Update XL";
    SourceTableView = where(Updated = filter(false));
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Visible = false;
                }
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Style = Unfavorable;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Style = Unfavorable;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Style = Unfavorable;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Style = Unfavorable;
                }
                field("Weeks to Invoice"; Rec."Weeks to Invoice")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Cost per Week Override"; Rec."Cost per Week Override")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Check No."; Rec."Check No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Style = Unfavorable;
                }
                field("Check Date"; Rec."Check Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Style = Unfavorable;
                }
                field("Weeks to Pay"; Rec."Weeks to Pay")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(Import)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = AnalysisView;
                RunObject = xmlport "INV CHK Record Upload";

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
            action(Save)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = UpdateUnitCost;

                trigger OnAction()
                var
                    RLEINVCHKXL: Record "RLE INV CHK Update XL";
                    CPLE: Record "Clerkship Payment Ledger Entry";
                    CPLECHK: Record "Clerkship Payment Ledger Entry";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    EntryNo: Integer;
                    Balance: Integer;
                begin
                    if not Confirm('Do you want to Save the Details') then
                        exit;

                    CPLE.Reset();
                    if CPLE.FindLast() then
                        EntryNo := CPLE."Entry No.";

                    RLEINVCHKXL.Reset();
                    RLEINVCHKXL.SetRange(Updated, false);
                    if RLEINVCHKXL.FindSET() then
                        repeat
                            if (RLEINVCHKXL."Invoice No." <> '') and (RLEINVCHKXL."Weeks to Invoice" > 0) then begin
                                if RLEINVCHKXL."Invoice Date" = 0D then
                                    Error('You must specify Invoice Date for the Invoice No. %1.', RLEINVCHKXL."Invoice No.");

                                RosterLedgerEntry.Reset();
                                if RosterLedgerEntry.Get(RLEINVCHKXL."Rotation Entry No.") then begin
                                    Balance := RosterLedgerEntry."Total No. of Weeks" - RosterLedgerEntry."Weeks Invoiced";

                                    if Balance = 0 then
                                        Error('Rotation ID %1 for the Student ID %2 (%3) has been completely Invoiced.', RLEINVCHKXL."Rotation ID", RLEINVCHKXL."Student ID", RLEINVCHKXL."Student Name");
                                    if RLEINVCHKXL."Weeks to Invoice" > Balance then
                                        Error('Only %1 Week(s) are balance to Invoice for the Rotation ID %2 Student ID %3 (%4).', Balance, RLEINVCHKXL."Rotation ID", RLEINVCHKXL."Student ID", RLEINVCHKXL."Student Name");

                                    CPLECHK.Reset();
                                    CPLECHK.SetRange("Rotation Entry No.", RLEINVCHKXL."Rotation Entry No.");
                                    CPLECHK.SetRange("Invoice No.", RLEINVCHKXL."Invoice No.");
                                    if CPLECHK.FindFirst() then
                                        Error('Invoice No. %1 already exist for the Rotation ID %2 Student ID %3 (%4).', RLEINVCHKXL."Invoice No.", RLEINVCHKXL."Rotation ID", RLEINVCHKXL."Student ID", RLEINVCHKXL."Student Name");

                                    if RLEINVCHKXL."Cost per Week Override" <> 0 then begin
                                        RosterLedgerEntry."Cost Per week Override" := RLEINVCHKXL."Cost per Week Override";
                                        RosterLedgerEntry."Actual Rotation Cost" := RLEINVCHKXL."Cost per Week Override";
                                        RosterLedgerEntry."Total Actual Rotation Cost" := RLEINVCHKXL."Cost per Week Override" * RosterLedgerEntry."Total No. of Weeks";
                                        if RosterLedgerEntry."Estimated Rotation Cost" = 0 then
                                            RosterLedgerEntry.Validate("Estimated Rotation Cost", RLEINVCHKXL."Cost per Week Override");
                                    end;

                                    EntryNo := EntryNo + 1;
                                    CPLE.Init();
                                    CPLE."Entry No." := EntryNo;
                                    CPLE."Entry Type" := CPLE."Entry Type"::Invoice;
                                    CPLE."Rotation Entry No." := RosterLedgerEntry."Entry No.";
                                    CPLE."Rotation ID" := RosterLedgerEntry."Rotation ID";
                                    CPLE."Hospital ID" := RosterLedgerEntry."Hospital ID";
                                    CPLE."Hospital Name" := RosterLedgerEntry."Hospital Name";
                                    CPLE."Student ID" := RosterLedgerEntry."Student ID";
                                    CPLE."Student Name" := RosterLedgerEntry."Student Name";
                                    CPLE."First Name" := RosterLedgerEntry."First Name";
                                    CPLE."Middle Name" := RosterLedgerEntry."Middle Name";
                                    CPLE."Last Name" := RosterLedgerEntry."Last Name";
                                    CPLE."Enrollment No." := RosterLedgerEntry."Enrollment No.";
                                    CPLE."Clerkship Type" := RosterLedgerEntry."Clerkship Type";
                                    CPLE."Student Course Code" := RosterLedgerEntry."Course Code";
                                    CPLE."Student Course Description" := RosterLedgerEntry."Course Description";
                                    CPLE."Course Code" := RosterLedgerEntry."Course Code";
                                    CPLE."Course Description" := RosterLedgerEntry."Course Description";
                                    CPLE."Elective Course Code" := RosterLedgerEntry."Elective Course Code";
                                    CPLE."Rotation Description" := RosterLedgerEntry."Rotation Description";
                                    CPLE."Course Type" := RosterLedgerEntry."Course Type";
                                    CPLE."Academic Year" := RosterLedgerEntry."Academic Year";
                                    CPLE.Semester := RosterLedgerEntry.Semester;
                                    CPLE."Start Date" := RosterLedgerEntry."Start Date";
                                    CPLE."End Date" := RosterLedgerEntry."End Date";

                                    CPLE."Total No. of Weeks" := RosterLedgerEntry."Total No. of Weeks";
                                    CPLE."Weeks Invoiced" := RLEINVCHKXL."Weeks to Invoice";

                                    CPLE."Estimated Rotation Cost" := RosterLedgerEntry."Estimated Rotation Cost";
                                    CPLE."Total Estd. Rotation Cost" := CPLE."Estimated Rotation Cost" * CPLE."Weeks Invoiced";
                                    CPLE."Actual Rotation Cost" := RosterLedgerEntry."Actual Rotation Cost";
                                    CPLE."Total Actual Rotation Cost" := CPLE."Actual Rotation Cost" * CPLE."Weeks Invoiced";
                                    CPLE."Invoice No." := RLEINVCHKXL."Invoice No.";
                                    CPLE."Invoice Date" := RLEINVCHKXL."Invoice Date";
                                    CPLE.Insert();

                                    RosterLedgerEntry."Weeks to Invoice" := 0;
                                    RosterLedgerEntry."Weeks Invoiced" := RosterLedgerEntry."Weeks Invoiced" + CPLE."Weeks Invoiced";
                                    if RosterLedgerEntry."Invoice No." = '' then
                                        RosterLedgerEntry."Invoice No." := RLEINVCHKXL."Invoice No."
                                    else
                                        RosterLedgerEntry."Invoice No." := RosterLedgerEntry."Invoice No." + '|' + RLEINVCHKXL."Invoice No.";
                                    RosterLedgerEntry."Invoice Date" := RLEINVCHKXL."Invoice Date";
                                    IF RosterLedgerEntry."Total No. of Weeks" <= RosterLedgerEntry."Weeks Invoiced" then
                                        RosterLedgerEntry."Invoice No. Updated" := true;
                                    RosterLedgerEntry.Modify();
                                end;
                            end;

                            if (RLEINVCHKXL."Check No." <> '') and (RLEINVCHKXL."Weeks to Pay" > 0) then begin
                                if RLEINVCHKXL."Check Date" = 0D then
                                    Error('You must specify Check Date for the Check No. %1.', RLEINVCHKXL."Check No.");

                                if RLEINVCHKXL."Invoice No." = '' then
                                    Error('You must specify Invoice No. for the Check No. %1.', RLEINVCHKXL."Check No.");

                                CPLECHK.Reset();
                                CPLECHK.SetRange("Rotation Entry No.", RLEINVCHKXL."Rotation Entry No.");
                                CPLECHK.SetRange("Check No.", RLEINVCHKXL."Check No.");
                                if CPLECHK.FindFirst() then
                                    Error('Check No. %1 already exist for the Rotation ID %2 Student ID %3 (%4).', RLEINVCHKXL."Check No.", RLEINVCHKXL."Rotation ID", RLEINVCHKXL."Student ID", RLEINVCHKXL."Student Name");

                                CPLECHK.Reset();
                                CPLECHK.SetRange("Rotation Entry No.", RLEINVCHKXL."Rotation Entry No.");
                                CPLECHK.SetRange("Invoice No.", RLEINVCHKXL."Invoice No.");
                                if not CPLECHK.FindFirst() then
                                    Error('There is no Invoice No. %1 exist for the Rotation ID %2.', RLEINVCHKXL."Invoice No.", RLEINVCHKXL."Rotation ID");

                                RosterLedgerEntry.Reset();
                                if RosterLedgerEntry.Get(RLEINVCHKXL."Rotation Entry No.") then begin
                                    Balance := RosterLedgerEntry."Total No. of Weeks" - RosterLedgerEntry."Weeks Paid";

                                    if Balance = 0 then
                                        Error('Rotation ID %1 for the Student ID %2 (%3) has been completely Paid.', RLEINVCHKXL."Rotation ID", RLEINVCHKXL."Student ID", RLEINVCHKXL."Student Name");
                                    if RLEINVCHKXL."Weeks to Invoice" > Balance then
                                        Error('Only %1 Week(s) are balance to Pay for the Rotation ID %2 Student ID %3 (%4).', Balance, RLEINVCHKXL."Rotation ID", RLEINVCHKXL."Student ID", RLEINVCHKXL."Student Name");
                                end;

                                EntryNo := EntryNo + 1;
                                CPLE.Init();
                                CPLE."Entry No." := EntryNo;
                                CPLE."Entry Type" := CPLE."Entry Type"::Payment;
                                CPLE."Rotation Entry No." := RosterLedgerEntry."Entry No.";
                                CPLE."Rotation ID" := RosterLedgerEntry."Rotation ID";
                                CPLE."Hospital ID" := RosterLedgerEntry."Hospital ID";
                                CPLE."Hospital Name" := RosterLedgerEntry."Hospital Name";
                                CPLE."Student ID" := RosterLedgerEntry."Student ID";
                                CPLE."Student Name" := RosterLedgerEntry."Student Name";
                                CPLE."First Name" := RosterLedgerEntry."First Name";
                                CPLE."Middle Name" := RosterLedgerEntry."Middle Name";
                                CPLE."Last Name" := RosterLedgerEntry."Last Name";
                                CPLE."Enrollment No." := RosterLedgerEntry."Enrollment No.";
                                CPLE."Clerkship Type" := RosterLedgerEntry."Clerkship Type";
                                CPLE."Student Course Code" := RosterLedgerEntry."Student Course Code";
                                CPLE."Student Course Description" := RosterLedgerEntry."Student Course Description";
                                CPLE."Course Code" := RosterLedgerEntry."Course Code";
                                CPLE."Course Description" := RosterLedgerEntry."Course Description";
                                CPLE."Elective Course Code" := RosterLedgerEntry."Elective Course Code";
                                CPLE."Rotation Description" := RosterLedgerEntry."Rotation Description";
                                CPLE."Course Type" := RosterLedgerEntry."Course Type";
                                CPLE."Academic Year" := RosterLedgerEntry."Academic Year";
                                CPLE.Semester := RosterLedgerEntry.Semester;
                                CPLE."Start Date" := RosterLedgerEntry."Start Date";
                                CPLE."End Date" := RosterLedgerEntry."End Date";
                                CPLE."Total No. of Weeks" := -1 * RosterLedgerEntry."Total No. of Weeks";
                                CPLE."Weeks Paid" := RLEINVCHKXL."Weeks to Pay";
                                CPLE."Estimated Rotation Cost" := -1 * CPLECHK."Estimated Rotation Cost";
                                CPLE."Total Estd. Rotation Cost" := CPLECHK."Estimated Rotation Cost" * CPLE."Weeks Paid";
                                CPLE."Actual Rotation Cost" := -1 * CPLECHK."Actual Rotation Cost";
                                CPLE."Total Actual Rotation Cost" := CPLE."Actual Rotation Cost" * CPLE."Weeks Paid";
                                CPLE."Invoice No." := RLEINVCHKXL."Invoice No.";
                                CPLE."Invoice Date" := RLEINVCHKXL."Invoice Date";
                                CPLE."Check No." := RLEINVCHKXL."Check No.";
                                CPLE."Check Date" := RLEINVCHKXL."Check Date";
                                CPLE.Insert();

                                RosterLedgerEntry."Weeks Paid" := RosterLedgerEntry."Weeks Paid" + Abs(CPLE."Weeks Paid");
                                if RosterLedgerEntry."Check No." = '' then
                                    RosterLedgerEntry."Check No." := RLEINVCHKXL."Check No."
                                else
                                    RosterLedgerEntry."Check No." := RosterLedgerEntry."Check No." + '|' + RLEINVCHKXL."Check No.";
                                RosterLedgerEntry."Check Date" := RLEINVCHKXL."Check Date";

                                if RosterLedgerEntry."Total No. of Weeks" <= RosterLedgerEntry."Weeks Paid" then
                                    RosterLedgerEntry."Check No. Updated" := true;
                                RosterLedgerEntry.Modify();

                                CPLECHK."Weeks Paid" := CPLECHK."Weeks Paid" + CPLE."Weeks Paid";

                                if CPLECHK."Weeks Invoiced" <= CPLECHK."Weeks Paid" then
                                    CPLECHK."Check No. Updated" := true;

                                CPLECHK.Modify();
                            end;

                            RLEINVCHKXL."Updated By" := UserId;
                            RLEINVCHKXL."Updated On" := Today;
                            RLEINVCHKXL.Updated := true;
                            RLEINVCHKXL.Modify();
                        until RLEINVCHKXL.Next() = 0;

                    Message(('Details updated successfully.'));
                end;
            }
        }
    }
}
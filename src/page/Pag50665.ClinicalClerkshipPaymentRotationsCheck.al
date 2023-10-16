page 50665 "Clincal Rotation Check Update"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Clerkship Payment Ledger Entry";
    SourceTableView = where("Entry Type" = filter(Invoice), "Weeks Invoiced" = filter(> 0), "Check No. Updated" = filter(false));
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Clincal Rotation Check Details Update';
    layout
    {
        area(Content)
        {
            group("Invoice No. Filtering & Check Inputs")
            {
                field(InvoiceNo; InvoiceNo)
                {
                    Caption = 'Invoice No.';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        CPLE: Record "Clerkship Payment Ledger Entry";
                    begin
                        InvoiceDate := 0D;
                        HospitalID := '';
                        HospitalName := '';
                        CPLE.Reset();
                        CPLE.SetCurrentKey("Invoice No.");
                        CPLE.SetRange("Invoice No.", InvoiceNo);
                        if CPLE.FindSet() then begin
                            InvoiceDate := CPLE."Invoice Date";
                            HospitalID := CPLE."Hospital ID";
                            HospitalName := CPLE."Hospital Name";
                            repeat
                                if InvoiceDate <> CPLE."Invoice Date" then begin
                                    InvoiceDate := 0D;
                                    HospitalID := '';
                                    HospitalName := '';
                                end;
                            until CPLE.Next() = 0;
                        end;
                        CallFilterRotations();
                    end;
                }
                field(InvoiceDate; InvoiceDate)
                {
                    Caption = 'Invoice Date';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        CallFilterRotations();
                    end;
                }
                field(HospitalID; HospitalID)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    ShowMandatory = true;
                    Caption = 'Hospital ID';
                    TableRelation = Vendor."No." where("Vendor Sub Type" = filter(Hospital));
                    trigger OnValidate()
                    var
                        Vendor: Record Vendor;
                    begin
                        HospitalName := '';
                        Vendor.Reset();
                        if Vendor.Get(HospitalID) then
                            HospitalName := Vendor.Name;

                        CallFilterRotations();
                    end;
                }
                field(HospitalName; HospitalName)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    ShowMandatory = true;
                    Caption = 'Hospital Name';
                    Editable = false;
                }
                field(CheckNo; CheckNo)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Caption = 'Check No.';
                    trigger OnValidate()
                    begin
                        UpdatePaymentWeeks();
                        CurrPage.Update(false);
                    end;
                }
                field(CheckDate; CheckDate)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Caption = 'Check Date';
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
            }
            repeater(Entries)
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Caption = 'Student ID';
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total No. of Weeks"; Rec."Total No. of Weeks")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Weeks Invoiced"; Rec."Weeks Invoiced")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Balance to Pay"; Rec."Weeks Invoiced" - Rec."Weeks Paid")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    Caption = 'Balance Weeks to Pay';
                }
                field("Weeks to Pay"; Rec."Weeks to Pay")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    trigger OnValidate()
                    begin
                        if Rec."Weeks to Pay" > Rec."Weeks Invoiced" - Rec."Weeks Paid" then
                            Error('Weeks to can not be more than %1.', Rec."Weeks Invoiced" - Rec."Weeks Paid");
                    end;
                }
                field("Weeks Paid"; Rec."Weeks Paid")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                ShortcutKey = 'Ctrl+S';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Properties;
                trigger OnAction()
                var
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    CPLE: Record "Clerkship Payment Ledger Entry";
                    CPLECHK: Record "Clerkship Payment Ledger Entry";
                    CountedRotations: Integer;
                    SelectedRotation: Integer;
                    EntryNo: Integer;
                    I: Integer;
                begin
                    if HospitalID = '' then
                        Error('You must specify Hospital ID');
                    if CheckNo = '' then
                        Error('You must specify Check No.');
                    if CheckDate = 0D then
                        Error('You must specify Check Date');

                    CountedRotations := 0;
                    CPLECHK.Reset();
                    CPLECHK.SetCurrentKey("Invoice No.");
                    CurrPage.SetSelectionFilter(CPLECHK);
                    CPLECHK.SetRange("Entry Type", CPLECHK."Entry Type"::Invoice);
                    if InvoiceNo <> '' then
                        CPLECHK.SetFilter("Invoice No.", InvoiceNo);
                    if InvoiceDate <> 0D then
                        CPLECHK.SetFilter("Invoice Date", '%1', InvoiceDate);
                    CPLECHK.SetRange("Hospital ID", HospitalID);
                    CPLECHK.SetFilter("Weeks to Pay", '>%1', 0);
                    if CPLECHK.FindSet() then
                        repeat
                            if CPLECHK."Weeks Paid" < CPLECHK."Weeks Invoiced" then begin
                                CountedRotations := CountedRotations + 1;
                                if Rec.Get(CPLECHK."Entry No.") then
                                    Rec.Mark(true);
                            end;
                        until CPLECHK.Next() = 0;

                    CPLECHK.Reset();
                    CurrPage.SetSelectionFilter(CPLECHK);
                    CPLECHK.SetRange("Entry Type", CPLECHK."Entry Type"::Invoice);
                    CPLECHK.SetFilter("Weeks to Pay", '>%1', 0);
                    SelectedRotation := CPLECHK.Count;

                    if not Confirm('Do you want to Update Check No. %1 in %2 Entries Out of %3.', true, CheckNo, SelectedRotation, CountedRotations) then
                        exit;

                    I := 0;

                    CPLE.Reset();
                    if CPLE.FindLast() then
                        EntryNo := CPLE."Entry No.";

                    if CPLECHK.FindFirst() then
                        repeat
                            I += 1;
                            EntryNo += 1;
                            RosterLedgerEntry.Reset();
                            if RosterLedgerEntry.Get(CPLECHK."Rotation Entry No.") then;

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
                            CPLE."Total No. of Weeks" := -1 * CPLECHK."Total No. of Weeks";
                            CPLE."Weeks Paid" := CPLECHK."Weeks to Pay";
                            CPLE."Estimated Rotation Cost" := -1 * CPLECHK."Estimated Rotation Cost";
                            CPLE."Total Estd. Rotation Cost" := CPLECHK."Estimated Rotation Cost" * CPLE."Weeks Paid";
                            CPLE."Actual Rotation Cost" := -1 * CPLECHK."Actual Rotation Cost";
                            CPLE."Total Actual Rotation Cost" := CPLE."Actual Rotation Cost" * CPLE."Weeks Paid";
                            CPLE."Invoice No." := CPLECHK."Invoice No.";
                            CPLE."Invoice Date" := CPLECHK."Invoice Date";
                            CPLE."Check No." := CheckNo;
                            CPLE."Check Date" := CheckDate;
                            CPLE.Insert();

                            RosterLedgerEntry."Weeks Paid" := RosterLedgerEntry."Weeks Paid" + Abs(CPLE."Weeks Paid");
                            if RosterLedgerEntry."Check No." = '' then
                                RosterLedgerEntry."Check No." := CheckNo
                            else
                                RosterLedgerEntry."Check No." := RosterLedgerEntry."Check No." + '|' + CheckNo;
                            RosterLedgerEntry."Check Date" := CheckDate;

                            if RosterLedgerEntry."Total No. of Weeks" <= RosterLedgerEntry."Weeks Paid" then
                                RosterLedgerEntry."Check No. Updated" := true;
                            RosterLedgerEntry.Modify();

                            CPLECHK."Weeks Paid" := CPLECHK."Weeks Paid" + CPLECHK."Weeks to Pay";

                            if CPLECHK."Weeks Invoiced" <= CPLECHK."Weeks Paid" then
                                CPLECHK."Check No. Updated" := true;

                            CPLECHK."Weeks to Pay" := 0;
                            CPLECHK.Modify();
                        until CPLECHK.Next() = 0;

                    CurrPage.Close();
                    Message('Check No. %1 have Updated in %2 Rotation(s) Successfully.', CheckNo, I);
                end;
            }
        }
    }
    var
        HospitalID: Code[20];
        HospitalName: Text[100];
        InvoiceNo: Code[20];
        InvoiceDate: Date;
        CheckNo: Code[20];
        CheckDate: Date;

    trigger OnOpenPage()
    begin
        CallFilterRotations();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.SetFilter("Weeks to Pay", '<>%1', 0);
        if Rec.FindSet() then
            repeat
                Rec."Weeks to Pay" := 0;
                Rec.Modify();
            until Rec.Next() = 0;
    end;

    procedure SetVariables(LHospitalID: Code[20]; LHospitalName: Text[100])
    begin
        HospitalID := LHospitalID;
        HospitalName := LHospitalName;
    end;

    procedure UpdatePaymentWeeks()
    begin
        if Rec.FindSet() then
            repeat
                if CheckNo = '' then
                    Rec."Weeks to Pay" := 0
                else
                    Rec."Weeks to Pay" := Rec."Weeks Invoiced" - Rec."Weeks Paid";
                Rec.Modify();
            until Rec.Next() = 0;
    end;

    procedure CallFilterRotations()
    begin
        Rec.Reset();
        Rec.SetRange("Entry Type", Rec."Entry Type"::Invoice);
        Rec.SetCurrentKey("Invoice No.");
        //FilterGroup(2);
        Rec.SetRange("Check No. Updated", false);
        if InvoiceNo <> '' then
            Rec.SetRange("Invoice No.", InvoiceNo);
        if InvoiceDate <> 0D then
            Rec.SetRange("Invoice Date", InvoiceDate);
        if HospitalID <> '' then
            Rec.SetRange("Hospital ID", HospitalID);
        //FilterGroup(0);
        CurrPage.Update(false);
    end;
}
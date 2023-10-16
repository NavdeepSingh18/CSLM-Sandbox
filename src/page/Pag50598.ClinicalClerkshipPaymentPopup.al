page 50598 "Payment Popup"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "Roster Ledger Entry";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                group("Hospital Details")
                {
                    field(HospitalID; HospitalID)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Caption = 'Hospital ID';
                        Editable = false;

                        // trigger OnDrillDown()
                        // var
                        //     Vendor: Record Vendor;
                        //     HospitalCard: Page "Hospital Card";
                        // begin
                        //     Vendor.Reset();
                        //     Vendor.FilterGroup(2);
                        //     Vendor.SetRange("No.", HospitalID);
                        //     Vendor.FilterGroup(0);
                        //     Clear(HospitalCard);
                        //     HospitalCard.Editable := false;
                        //     HospitalCard.SetRecord(Vendor);
                        //     HospitalCard.SetTableView(Vendor);
                        //     HospitalCard.RunModal();
                        // end;
                    }
                    field(HospitalName; HospitalName)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Caption = 'Hospital Name';
                        Editable = false;
                    }
                }
                group("Invoice Details")
                {
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

                        trigger OnValidate()
                        begin
                            if InvoiceDate > WorkDate() then
                                Error('Invoice Date (%1) must not be more than (%2).', InvoiceDate, WorkDate());
                        end;
                    }
                    field(CostPerWeekOverride; CostPerWeekOverride)
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        ShowMandatory = true;
                        Caption = 'Cost Per Week Override';
                    }
                }
            }
            repeater(List)
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rotation No."; Rec."Rotation No.")
                {
                    ApplicationArea = All;
                    Caption = 'Rotation No.';
                    Editable = false;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Style = Strong;
                }
                field("Balance Weeks to Invoice"; Rec."Total No. of Weeks" - Rec."Weeks Invoiced")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    Caption = 'Balance Weeks to Invoice';
                }
                field("Weeks to Invoice"; Rec."Weeks to Invoice")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;

                    trigger OnValidate()
                    begin
                        if Rec."Weeks to Invoice" + Rec."Weeks Invoiced" > Rec."Total No. of Weeks" then
                            Error('Weeks to Invoice can not be more than %1.', Rec."Total No. of Weeks" - Rec."Weeks Invoiced");
                    end;
                }
                field("Weeks Invoiced"; Rec."Weeks Invoiced")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Weeks Paid"; Rec."Weeks Paid")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Rotation Grade"; Rec."Rotation Grade")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Estimated Rotation Cost"; Rec."Estimated Rotation Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Estd. Rotation Cost"; Rec."Total Estd. Rotation Cost")
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
            action(Save)
            {
                ApplicationArea = All;
                Caption = 'Save';
                ShortcutKey = 'Ctrl+S';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Save;

                trigger OnAction()
                var
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    MSG: Text[50000];
                    SelectedRotation: Integer;
                    I: Integer;
                    Char10: Char;
                    Char13: Char;
                    NewLine: Text[10];
                begin
                    Char10 := 10;
                    Char13 := 13;
                    NewLine := format(Char10) + format(Char13);

                    SelectedRotation := 0;

                    for I := 1 to ArrayLen(RotationNos) do
                        if RotationNos[I] <> 0 then begin
                            SelectedRotation := SelectedRotation + 1;
                            RosterLedgerEntry.Reset();
                            if RosterLedgerEntry.Get(RotationNos[i]) then
                                MSG := MSG + NewLine + format(SelectedRotation) + '. ' + RosterLedgerEntry."Rotation ID" + ' || ' + RosterLedgerEntry."Student ID" + ' || ' + RosterLedgerEntry."Student Name" + ' || ' + RosterLedgerEntry."Rotation Description" + ' || Period: ' + Format(RosterLedgerEntry."Start Date") + ' to ' + format(RosterLedgerEntry."End Date");
                        end;
                    if not Confirm('You have Selected %1 Rotations.\Do you want to update Invoice No. %2 in Below Rotations?\ %3', true, SelectedRotation, InvoiceNo, MSG) then
                        exit;
                    InsertLedgerEntries();
                end;
            }
        }
    }

    var
        HospitalID: Code[20];
        HospitalName: Text[100];
        InvoiceNo: Code[20];
        InvoiceDate: Date;
        CostPerWeekOverride: Decimal;
        RotationNos: array[500] of Integer;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        repeat
            Rec."Weeks to Invoice" := 0;
            Rec.Modify();
        until Rec.Next() = 0;
    end;

    procedure SetRotationNos(LRotationNos: array[500] of Integer; LHospitalID: Code[20]; LHospitalName: Text[100])
    Var
    begin
        CopyArray(RotationNos, LRotationNos, 1, 500);
        HospitalID := LHospitalID;
        HospitalName := LHospitalName;
    end;

    procedure InsertLedgerEntries()
    var
        CPLE: Record "Clerkship Payment Ledger Entry";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        //rosterledgerdocuments: record "Roster Ledger Documents";
        I: Integer;
        EntryNo: Integer;
    begin
        if InvoiceNo = '' then
            Error('You must specify Invoice No.');

        if InvoiceDate = 0D then
            Error('You must specify Invoice Date.');

        CPLE.Reset();
        if CPLE.FindLast() then
            EntryNo := CPLE."Entry No.";

        for I := 1 to ArrayLen(RotationNos) do
            if RotationNos[I] <> 0 then begin
                RosterLedgerEntry.Reset();
                if RosterLedgerEntry.Get(RotationNos[i]) then begin
                    if CostPerWeekOverride <> 0 then begin        //30112022 Navdeep
                    RosterLedgerEntry."Cost Per week Override" := CostPerWeekOverride;
                    RosterLedgerEntry."Actual Rotation Cost" := CostPerWeekOverride;
                    RosterLedgerEntry."Total Actual Rotation Cost" := CostPerWeekOverride * RosterLedgerEntry."Total No. of Weeks";
                    if RosterLedgerEntry."Estimated Rotation Cost" = 0 then
                        RosterLedgerEntry.Validate("Estimated Rotation Cost", CostPerWeekOverride);
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
                    CPLE."Weeks Invoiced" := RosterLedgerEntry."Weeks to Invoice";

                    CPLE."Estimated Rotation Cost" := RosterLedgerEntry."Estimated Rotation Cost";
                    CPLE."Total Estd. Rotation Cost" := CPLE."Estimated Rotation Cost" * CPLE."Weeks Invoiced";
                    CPLE."Actual Rotation Cost" := RosterLedgerEntry."Actual Rotation Cost";
                    CPLE."Total Actual Rotation Cost" := CPLE."Actual Rotation Cost" * CPLE."Weeks Invoiced";
                    CPLE."Invoice No." := InvoiceNo;
                    CPLE."Invoice Date" := InvoiceDate;
                    CPLE.Insert();

                    // rosterledgerdocuments.Reset();
                    // rosterledgerdocuments.SetRange("Entry No.", CPLE."Rotation Entry No.");
                    // rosterledgerdocuments.SetRange("Document Type", rosterledgerdocuments."Document Type"::Invoice);
                    // if rosterledgerdocuments.FindFirst() then begin
                    //     if rosterledgerdocuments."Invoice Nos." <> '' then
                    //         rosterledgerdocuments."Invoice Nos." := '|' + CPLE."Invoice No."
                    //     else
                    //         rosterledgerdocuments."Invoice Nos." := CPLE."Invoice No.";
                    //     rosterledgerdocuments.Modify();
                    // end else begin
                    //     rosterledgerdocuments.Init();
                    //     rosterledgerdocuments."Entry No." := CPLE."Rotation Entry No.";
                    //     rosterledgerdocuments."Document Type" := rosterledgerdocuments."Document Type"::Invoice;
                    //     rosterledgerdocuments."invoice Nos." := CPLE."Invoice No.";
                    //     rosterledgerdocuments.Insert();
                    // end;

                    RosterLedgerEntry."Weeks to Invoice" := 0;
                    RosterLedgerEntry."Weeks Invoiced" := RosterLedgerEntry."Weeks Invoiced" + CPLE."Weeks Invoiced";
                    if RosterLedgerEntry."Invoice No." = '' then
                        RosterLedgerEntry."Invoice No." := InvoiceNo
                    else
                        RosterLedgerEntry."Invoice No." := RosterLedgerEntry."Invoice No." + '|' + InvoiceNo;
                    RosterLedgerEntry."Invoice Date" := InvoiceDate;
                    IF RosterLedgerEntry."Total No. of Weeks" <= RosterLedgerEntry."Weeks Invoiced" then
                        RosterLedgerEntry."Invoice No. Updated" := true;
                    RosterLedgerEntry.Modify();
                end;
            end;
        Message('Invoice No. Updated successfully.');
        CurrPage.Close();
    end;
}
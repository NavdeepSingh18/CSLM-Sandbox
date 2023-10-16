page 50743 "ADV Payment Popup"
{
    PageType = Card;
    UsageCategory = None;
    Caption = 'Advance - Payment Popup';
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

                        trigger OnDrillDown()
                        var
                            Vendor: Record Vendor;
                            HospitalCard: Page "Hospital Card";
                        begin
                            Vendor.Reset();
                            Vendor.FilterGroup(2);
                            Vendor.SetRange("No.", HospitalID);
                            Vendor.FilterGroup(0);
                            Clear(HospitalCard);
                            HospitalCard.Editable := false;
                            HospitalCard.SetRecord(Vendor);
                            HospitalCard.SetTableView(Vendor);
                            HospitalCard.RunModal();
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
                }
                group("Check Details")
                {
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
                    if not Confirm('You have Selected %1 Rotations.\Do you want to update Check No. %2 in Below Rotations?\ %3', true, SelectedRotation, CheckNo, MSG) then
                        exit;
                    InsertLedgerEntries();
                end;
            }
        }
    }

    var
        HospitalID: Code[20];
        HospitalName: Text[100];
        CheckNo: Code[20];
        CheckDate: Date;
        RotationNos: array[500] of Integer;

    procedure SetRotationNos(LRotationNos: array[500] of Integer; LHospitalID: Code[20]; LHospitalName: Text[100])
    Var
    begin
        CopyArray(RotationNos, LRotationNos, 1, 500);
        HospitalID := LHospitalID;
        HospitalName := LHospitalName;
    end;

    procedure InsertLedgerEntries()
    var
        ClerkshipPaymentLedgerEntry: Record "Clerkship Payment Ledger Entry";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        I: Integer;
        EntryNo: Integer;
    //rosterledgerdocuments: Record "Roster Ledger Documents";
    begin
        if CheckNo = '' then
            Error('You must specify Check No.');

        if CheckDate = 0D then
            Error('You must specify Check Date.');

        ClerkshipPaymentLedgerEntry.Reset();
        if ClerkshipPaymentLedgerEntry.FindLast() then
            EntryNo := ClerkshipPaymentLedgerEntry."Entry No.";

        for I := 1 to ArrayLen(RotationNos) do
            if RotationNos[I] <> 0 then begin
                RosterLedgerEntry.Reset();
                if RosterLedgerEntry.Get(RotationNos[i]) then begin
                    EntryNo := EntryNo + 1;
                    ClerkshipPaymentLedgerEntry.Init();
                    ClerkshipPaymentLedgerEntry."Entry No." := EntryNo;
                    ClerkshipPaymentLedgerEntry."Entry Type" := ClerkshipPaymentLedgerEntry."Entry Type"::Payment;
                    ClerkshipPaymentLedgerEntry."Rotation Entry No." := RosterLedgerEntry."Entry No.";
                    ClerkshipPaymentLedgerEntry."Rotation ID" := RosterLedgerEntry."Rotation ID";
                    ClerkshipPaymentLedgerEntry."Hospital ID" := RosterLedgerEntry."Hospital ID";
                    ClerkshipPaymentLedgerEntry."Hospital Name" := RosterLedgerEntry."Hospital Name";
                    ClerkshipPaymentLedgerEntry."Student ID" := RosterLedgerEntry."Student ID";
                    ClerkshipPaymentLedgerEntry."Student Name" := RosterLedgerEntry."Student Name";
                    ClerkshipPaymentLedgerEntry."First Name" := RosterLedgerEntry."First Name";
                    ClerkshipPaymentLedgerEntry."Middle Name" := RosterLedgerEntry."Middle Name";
                    ClerkshipPaymentLedgerEntry."Last Name" := RosterLedgerEntry."Last Name";
                    ClerkshipPaymentLedgerEntry."Enrollment No." := RosterLedgerEntry."Enrollment No.";
                    ClerkshipPaymentLedgerEntry."Clerkship Type" := RosterLedgerEntry."Clerkship Type";
                    ClerkshipPaymentLedgerEntry."Student Course Code" := RosterLedgerEntry."Student Course Code";
                    ClerkshipPaymentLedgerEntry."Student Course Description" := RosterLedgerEntry."Student Course Description";
                    ClerkshipPaymentLedgerEntry."Course Code" := RosterLedgerEntry."Course Code";
                    ClerkshipPaymentLedgerEntry."Course Description" := RosterLedgerEntry."Course Description";
                    ClerkshipPaymentLedgerEntry."Elective Course Code" := RosterLedgerEntry."Elective Course Code";
                    ClerkshipPaymentLedgerEntry."Rotation Description" := RosterLedgerEntry."Rotation Description";
                    ClerkshipPaymentLedgerEntry."Course Type" := RosterLedgerEntry."Course Type";
                    ClerkshipPaymentLedgerEntry."Academic Year" := RosterLedgerEntry."Academic Year";
                    ClerkshipPaymentLedgerEntry.Semester := RosterLedgerEntry.Semester;
                    ClerkshipPaymentLedgerEntry."Start Date" := RosterLedgerEntry."Start Date";
                    ClerkshipPaymentLedgerEntry."End Date" := RosterLedgerEntry."End Date";
                    ClerkshipPaymentLedgerEntry."Total No. of Weeks" := -1 * RosterLedgerEntry."Total No. of Weeks";
                    ClerkshipPaymentLedgerEntry."Estimated Rotation Cost" := -1 * RosterLedgerEntry."Estimated Rotation Cost";
                    ClerkshipPaymentLedgerEntry."Total Estd. Rotation Cost" := -1 * RosterLedgerEntry."Total Estd. Rotation Cost";
                    ClerkshipPaymentLedgerEntry."Actual Rotation Cost" := -1 * RosterLedgerEntry."Actual Rotation Cost";
                    ClerkshipPaymentLedgerEntry."Total Actual Rotation Cost" := -1 * RosterLedgerEntry."Total Actual Rotation Cost";
                    ClerkshipPaymentLedgerEntry."Check No." := CheckNo;
                    ClerkshipPaymentLedgerEntry."Check Date" := CheckDate;
                    ClerkshipPaymentLedgerEntry.Insert();

                    // rosterledgerdocuments.Reset();
                    // rosterledgerdocuments.SetRange("Entry No.", ClerkshipPaymentLedgerEntry."Rotation Entry No.");
                    // rosterledgerdocuments.SetRange("Document Type", rosterledgerdocuments."Document Type"::Payment);
                    // if rosterledgerdocuments.FindFirst() then begin
                    //     if rosterledgerdocuments."Cheque Nos." <> '' then
                    //         rosterledgerdocuments."Cheque Nos." := '|' + ClerkshipPaymentLedgerEntry."Check No."
                    //     else
                    //         rosterledgerdocuments."Cheque Nos." := ClerkshipPaymentLedgerEntry."Check No.";

                    //     if rosterledgerdocuments."Cheque Dates" <> '' then
                    //         rosterledgerdocuments."Cheque Dates" := '|' + format(ClerkshipPaymentLedgerEntry."Check Date")
                    //     else
                    //         rosterledgerdocuments."Cheque Dates" := format(ClerkshipPaymentLedgerEntry."Check Date");

                    //     rosterledgerdocuments.Modify();
                    // end else begin
                    //     rosterledgerdocuments.Init();
                    //     rosterledgerdocuments."Entry No." := ClerkshipPaymentLedgerEntry."Rotation Entry No.";
                    //     rosterledgerdocuments."Document Type" := rosterledgerdocuments."Document Type"::Payment;
                    //     rosterledgerdocuments."Cheque Dates" := format(ClerkshipPaymentLedgerEntry."Check Date");
                    //     rosterledgerdocuments."Cheque Nos." := ClerkshipPaymentLedgerEntry."Check No.";
                    //     rosterledgerdocuments.Insert();
                    // end;

                    RosterLedgerEntry."Check No." := CheckNo;
                    RosterLedgerEntry."Check Date" := CheckDate;
                    RosterLedgerEntry."Check No. Updated" := true;
                    RosterLedgerEntry.Modify();
                end;
            end;

        CurrPage.Close();
    end;
}
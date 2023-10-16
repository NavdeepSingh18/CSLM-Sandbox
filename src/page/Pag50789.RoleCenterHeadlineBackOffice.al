page 50789 RoleCenterHeadlineBackOffice
{
    PageType = HeadlinePart;
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            field(GreetingText; RCHeadlinesPageCommon.GetGreetingText())
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Greeting headline';
                Editable = false;
                Visible = true;
            }
            field(headline11; hdl11Txt)
            {

            }
            field(Headline21; hdl2Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    PurchaseHeader_gRec.Reset();
                    PurchaseHeader_gRec.SetRange("Document Type", PurchaseHeader_gRec."Document Type"::Quote);
                    PurchaseHeader_gRec.SetRange("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    PurchaseHeader_gRec.SetRange(Status, PurchaseHeader_gRec.Status::"Pending Approval");
                    If PurchaseHeader_gRec.FindSet() then begin
                        Page.RunModal(9306, PurchaseHeader_gRec);
                    end;
                end;
            }
            field(Headline31; hdl3Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    PurchaseHeader_gRec.Reset();
                    PurchaseHeader_gRec.SetRange("Document Type", PurchaseHeader_gRec."Document Type"::Order);
                    PurchaseHeader_gRec.SetRange("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    PurchaseHeader_gRec.SetRange(Status, PurchaseHeader_gRec.Status::"Pending Approval");
                    If PurchaseHeader_gRec.FindSet() then begin
                        Page.RunModal(9307, PurchaseHeader_gRec);
                    end;
                end;

            }
            field(Headline41; hdl4Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    PurchaseHeader_gRec.Reset();
                    PurchaseHeader_gRec.SetRange("Document Type", PurchaseHeader_gRec."Document Type"::Invoice);
                    PurchaseHeader_gRec.SetRange("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    PurchaseHeader_gRec.SetRange(Status, PurchaseHeader_gRec.Status::"Pending Approval");
                    If PurchaseHeader_gRec.FindSet() then begin
                        Page.RunModal(9308, PurchaseHeader_gRec);
                    end;
                end;
            }
            field(Headline51; hdl5Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    PurchaseHeader_gRec.Reset();
                    PurchaseHeader_gRec.SetRange("Document Type", PurchaseHeader_gRec."Document Type"::"Credit Memo");
                    PurchaseHeader_gRec.SetRange("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    PurchaseHeader_gRec.SetRange(Status, PurchaseHeader_gRec.Status::"Pending Approval");
                    If PurchaseHeader_gRec.FindSet() then begin
                        Page.RunModal(9309, PurchaseHeader_gRec);
                    end;
                end;
            }
            field(Headline61; hdl6Txt)
            {
                DrillDown = true;

                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    ApprovalEntry_gRec.Reset();
                    ApprovalEntry_gRec.SetRange("Table ID", 38);
                    ApprovalEntry_gRec.SetRange("Approver ID", UserId());
                    ApprovalEntry_gRec.SetRange(Status, ApprovalEntry_gRec.Status::Open);
                    If ApprovalEntry_gRec.FindFirst() then begin
                        Page.RunModal(654, ApprovalEntry_gRec);
                    end;
                end;
            }
            field(Headline71; hdl7Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    TransferHeader_gRec.Reset();
                    TransferHeader_gRec.SetFilter("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    TransferHeader_gRec.SetRange("Completely Shipped", true);
                    TransferHeader_gRec.SetRange("Completely Received", False);
                    IF TransferHeader_gRec.FindFirst() then begin
                        Page.RunModal(5742, TransferHeader_gRec);
                    end;

                end;
            }
            field(Headline81; hdl8Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    RosterLedgerEntries_gRec.Reset();
                    RosterLedgerEntries_gRec.SetRange("Invoice No.", '');
                    RosterLedgerEntries_gRec.SetRange("Invoice Date", 0D);
                    IF RosterLedgerEntries_gRec.FindFirst() then begin
                        Page.RunModal(50664, RosterLedgerEntries_gRec);
                    end;
                end;
            }
            field(Headline91; hdl9Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    RosterLedgerEntries_gRec.Reset();
                    RosterLedgerEntries_gRec.SetRange("Check No.", '');
                    RosterLedgerEntries_gRec.SetRange("Check Date", 0D);
                    IF RosterLedgerEntries_gRec.FindFirst() then begin
                        Page.RunModal(50664, RosterLedgerEntries_gRec);
                    end;
                end;
            }
        }
    }

    var
        PurchaseHeader_gRec: Record "Purchase Header";
        Usersetup1: Record "User Setup";
        PortalUser: Record "Portal User Login-CS";
        EducationSetup: Record "Education Setup-CS";
        ApprovalEntry_gRec: Record "Approval Entry";
        TransferHeader_gRec: Record "Transfer Header";
        RosterLedgerEntries_gRec: Record "Roster Ledger Entry";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";

        hdl11Txt: Text[100];
        hdl2Txt: Text[100];
        hdl3Txt: Text[100];
        hdl4Txt: Text[100];
        hdl5Txt: Text[100];
        hdl6Txt: Text[100];
        hdl7Txt: Text[100];
        hdl8Txt: Text[100];
        hdl9Txt: Text[100];

    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountRequesttoApprove: Integer;
        CountPendingPurchaseQuotes: Integer;
        CountPendingPurchaseOrder: Integer;
        CountPendingPurchaseInvoice: Integer;
        CountPendingPurchaseCreditMemo: Integer;
        CountTransferShipNotReceived: Integer;
        CountRosterInvoiceBlank: Integer;
        CountRosterCheckBlank: Integer;
        DateV: Text;
        Monthv: Text;
        YearV: text;
    begin
        //Greeting Start
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Team Member");
        // DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        // UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
        //Greeting End
        //1 start
        Usersetup1.get(UserId);
        EducationSetup.reset();
        //SD-SB-09-MAR-21 +
        // EducationSetup.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        // if Usersetup1."Global Dimension 1 Code" = '' then begin
        //     EducationSetup.reset();
        //     if EducationSetup.FindFirst() then;
        // end;
        //SD-SB-09-MAR-21 -

        EduCalendar.reset();
        EduCalendar.SetRange("Academic Year", EducationSetup."Academic Year");
        //SD-SB-09-MAR-21 +
        // EduCalendar.setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        EduCalendar.SetRange("Global Dimension 1 Code", '9000');
        //SD-SB-09-MAR-21 -
        if EduCalendar.FindFirst() then begin
            EduCalendarLines.Reset();
            EduCalendarLines.SetRange(Code, EduCalendar.Code);
            EduCalendarLines.SetRange(Date, Today());
            EduCalendarLines.SetRange(Holiday, true);
            if EduCalendarLines.FindFirst() then begin
                if EduCalendarLines.Holiday then
                    hdl11Txt := 'Today is ' + EduCalendarLines.Description + '.';
            end
        end;
        if hdl11Txt = '' then begin
            Usersetup1.get(UserId);
            EducationSetup.reset();
            //SD-SB-09-MAR-21 +
            // EducationSetup.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
            EducationSetup.SetRange("Global Dimension 1 Code", '9000');
            //SD-SB-09-MAR-21 -
            if EducationSetup.FindFirst() then;
            // //SD-SB-09-MAR-21 +
            // if Usersetup1."Global Dimension 1 Code" = '' then begin
            //     EducationSetup.reset();
            //     if EducationSetup.FindFirst() then;
            // end;
            //SD-SB-09-MAR-21 -
            EduCalendar.reset();
            EduCalendar.SetRange("Academic Year", EducationSetup."Academic Year");
            //SD-SB-09-MAR-21 +
            // EduCalendar.setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
            EduCalendar.SetRange("Global Dimension 1 Code", '9000');
            //SD-SB-09-MAR-21 -
            if EduCalendar.FindFirst() then begin
                EduCalendarLines.Reset();
                EduCalendarLines.SetRange(Code, EduCalendar.Code);
                EduCalendarLines.SetFilter(Date, '%1..', Today);
                EduCalendarLines.SetRange(Holiday, true);
                if EduCalendarLines.FindFirst() then begin
                    // if EduCalendarLines.Holiday then
                    //hdl1Txt := 'Next Holiday At ' + Format(EduCalendarLines.Date, 0, '<Month,2>/<Day,2>/<Year4>') + ' For ' + EduCalendarLines.Description + '.';
                    DateV := Format(DATE2DMY(EduCalendarLines.Date, 1));
                    Monthv := Format(DATE2DMY(EduCalendarLines.Date, 2));
                    YearV := Format(DATE2DMY(EduCalendarLines.Date, 3));
                    hdl11Txt := 'Next Holiday At ' + Monthv + '/' + DateV + '/' + YearV + ' For ' + EduCalendarLines.Description + '.';
                end
            end;
        end;
        //1 end
        //2 start
        Usersetup1.get(UserId);
        PurchaseHeader_gRec.Reset();
        PurchaseHeader_gRec.SetRange("Document Type", PurchaseHeader_gRec."Document Type"::Quote);
        PurchaseHeader_gRec.SetRange("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        PurchaseHeader_gRec.SetRange(Status, PurchaseHeader_gRec.Status::"Pending Approval");
        If PurchaseHeader_gRec.FindSet() then begin
            CountPendingPurchaseQuotes := PurchaseHeader_gRec.Count();
            hdl2Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPendingPurchaseQuotes)) + ' Pending Purchase Quotes.';
        End Else begin
            hdl2Txt := 'There are No Pending Purchase Quotes.';
        end;
        //2 end
        //3 start
        Usersetup1.get(UserId);
        PurchaseHeader_gRec.Reset();
        PurchaseHeader_gRec.SetRange("Document Type", PurchaseHeader_gRec."Document Type"::Order);
        PurchaseHeader_gRec.SetRange("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        PurchaseHeader_gRec.SetRange(Status, PurchaseHeader_gRec.Status::"Pending Approval");
        If PurchaseHeader_gRec.FindSet() then begin
            CountPendingPurchaseOrder := PurchaseHeader_gRec.Count();
            hdl3Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPendingPurchaseOrder)) + ' Pending Purchase Orders.';
        End Else begin
            hdl3Txt := 'There are No Pending Purchase Orders.';
        end;
        //3 end
        //4 start
        Usersetup1.get(UserId);
        PurchaseHeader_gRec.Reset();
        PurchaseHeader_gRec.SetRange("Document Type", PurchaseHeader_gRec."Document Type"::Invoice);
        PurchaseHeader_gRec.SetRange("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        PurchaseHeader_gRec.SetRange(Status, PurchaseHeader_gRec.Status::"Pending Approval");
        If PurchaseHeader_gRec.FindSet() then begin
            CountPendingPurchaseInvoice := PurchaseHeader_gRec.Count();
            hdl4Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPendingPurchaseInvoice)) + ' Pending Purchase Invoices.';
        End Else begin
            hdl4Txt := 'There are No Pending Purchase Invoices.';
        end;
        //4 end
        //5 start
        Usersetup1.get(UserId);
        PurchaseHeader_gRec.Reset();
        PurchaseHeader_gRec.SetRange("Document Type", PurchaseHeader_gRec."Document Type"::"Credit Memo");
        PurchaseHeader_gRec.SetRange("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        PurchaseHeader_gRec.SetRange(Status, PurchaseHeader_gRec.Status::"Pending Approval");
        If PurchaseHeader_gRec.FindSet() then begin
            CountPendingPurchaseCreditMemo := PurchaseHeader_gRec.Count();
            hdl4Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPendingPurchaseCreditMemo)) + ' Pending Purchase Credit Memo.';
        End Else begin
            hdl4Txt := 'There are No Pending Purchase Credit Memo.';
        end;
        //5 end
        //6 start
        Usersetup1.Get(UserId);
        ApprovalEntry_gRec.Reset();
        ApprovalEntry_gRec.SetRange("Table ID", 38);
        ApprovalEntry_gRec.SetRange("Approver ID", Usersetup1."User ID");
        ApprovalEntry_gRec.SetRange(Status, ApprovalEntry_gRec.Status::Open);
        If ApprovalEntry_gRec.FindSet() then begin
            CountRequesttoApprove := ApprovalEntry_gRec.Count();
            hdl6Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountRequesttoApprove)) + ' Request to Approve - Purchasing';
        End Else begin
            hdl6Txt := 'There are No Pending Request to Approval';
        end;
        //6 end
        //7 start
        Usersetup1.Get(UserId);
        TransferHeader_gRec.Reset();
        TransferHeader_gRec.SetFilter("Shortcut Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        TransferHeader_gRec.SetRange("Completely Shipped", True);
        TransferHeader_gRec.SetRange("Completely Received", false);
        IF TransferHeader_gRec.FindSet() then begin
            CountTransferShipNotReceived := TransferHeader_gRec.Count();
            hdl7Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountTransferShipNotReceived)) + ' Transfer Order Shipped but not Received';
        End Else begin
            hdl7Txt := 'There are No Pending Transfer Order Shipped but not Received';
        end;
        //7 end
        //8 start
        Usersetup1.Get(UserId);
        RosterLedgerEntries_gRec.Reset();
        RosterLedgerEntries_gRec.SetRange("Invoice No.", '');
        RosterLedgerEntries_gRec.SetRange("Invoice Date", 0D);
        If RosterLedgerEntries_gRec.FindSet() then begin
            CountRosterInvoiceBlank := RosterLedgerEntries_gRec.Count();
            hdl8Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountRosterInvoiceBlank)) + ' Hospital wise Invoice not Updated.';
        End Else begin
            hdl8Txt := 'There are No Pending Hospital wise Invoice not Updated.';
        end;
        //8 end
        //9 start
        Usersetup1.Get(UserId);
        RosterLedgerEntries_gRec.Reset();
        RosterLedgerEntries_gRec.SetRange("Check No.", '');
        RosterLedgerEntries_gRec.SetRange("Check Date", 0D);
        If RosterLedgerEntries_gRec.FindSet() then begin
            CountRosterCheckBlank := RosterLedgerEntries_gRec.Count();
            hdl8Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountRosterCheckBlank)) + ' Hospital wise Check No. not Updated.';
        End Else begin
            hdl8Txt := 'There are No Pending Hospital wise Check No. not Updated.';
        end;
        //9 end
    end;
}
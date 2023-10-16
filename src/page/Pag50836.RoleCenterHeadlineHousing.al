page 50836 RoleCenterHeadlineHousing
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
                visible = true;
            }
            field(headline11; hdl1Txt)
            {

            }
            field(Headline21; hdl2Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingApplication.reset();
                    HousingApplication.SetRange("Academic Year", EducationSetup."Academic Year");
                    // HousingApplication.Setfilter("Global Dimension 1 Code", '%1', Usersetup1."Global Dimension 1 Code");
                    HousingApplication.SetRange(Status, HousingApplication.Status::"Pending for Approval");
                    if HousingApplication.findset() then begin
                        Page.RunModal(Page::"Housing Application List", HousingApplication); //50421
                    end;
                end;
            }
            field(Headline31; hdl3Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingWaiver.reset();
                    HousingWaiver.SetRange("Academic Year", EducationSetup."Academic Year");
                    // HousingWaiver.Setfilter("Global Dimension 1 Code", '%1', Usersetup1."Global Dimension 1 Code");
                    HousingWaiver.SetRange("Application Type", HousingWaiver."Application Type"::"Housing Wavier");
                    if HousingWaiver.findset() then begin
                        Page.RunModal(Page::"Pending Housing Wavier List", HousingWaiver);//50573
                    end;
                end;
            }
            field(Headline41; hdl4Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingChangeRequest.reset();
                    HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
                    HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::"Change Request");
                    if HousingChangeRequest.findset() then begin
                        Page.RunModal(Page::"Housing Change Request List", HousingChangeRequest);//50423
                    end;
                end;
            }
            field(Headline51; hdl5Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingChangeRequest.reset();
                    HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
                    HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    HousingChangeRequest.SetRange(type, HousingChangeRequest.Type::Vacate);
                    if HousingChangeRequest.findset() then begin
                        Page.RunModal(Page::"Housing Vacate Request List", HousingChangeRequest);//50428
                    end;
                end;
            }
            field(Headline61; hdl6Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingChangeRequest.reset();
                    HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
                    HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    HousingChangeRequest.SetRange("Type", HousingChangeRequest."Type"::"Re-Registration");
                    if HousingChangeRequest.findset() then begin
                        // Page.RunModal(Page::"Housing Re-Registration List", HousingChangeRequest);//50706
                    end;
                end;
            }
            field(Headline71; hdl7Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    ImmigrationHeader.reset();
                    ImmigrationHeader.SetRange("Academic Year", EducationSetup."Academic Year");
                    ImmigrationHeader.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    ImmigrationHeader.SetFilter("Document Status", '%1|%2', ImmigrationHeader."Document Status"::Verified, ImmigrationHeader."Document Status"::Rejected);
                    if ImmigrationHeader.findset() then begin
                        // Page.RunModal(page::"Immigration Approved list", ImmigrationHeader);//50713
                    end;
                end;
            }
            field(Headline81; hdl8Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    FinancialAccountibility.reset();
                    FinancialAccountibility.SetRange("Academic Year", EducationSetup."Academic Year");
                    FinancialAccountibility.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    FinancialAccountibility.SetFilter(Status, '%1|%2', FinancialAccountibility.Status::Approved, FinancialAccountibility.Status::Rejected);
                    if FinancialAccountibility.findset() then begin
                        Page.RunModal(page::"Approve/Reject Fin Account", FinancialAccountibility);//50701
                    end;
                end;
            }
            field(Headline91; hdl9Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingApplication.reset();
                    HousingApplication.SetRange("Academic Year", EducationSetup."Academic Year");
                    HousingApplication.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    HousingApplication.SetFilter(Status, '%1|%2', HousingApplication.Status::Approved, HousingApplication.Status::Rejected);
                    if HousingApplication.findset() then begin
                        Page.RunModal(page::"Posted Housing Application", HousingApplication);//50432
                    end;
                end;
            }
            field(Headline101; hdl10Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    PendinHousongWaiver.reset();
                    PendinHousongWaiver.SetRange("Academic Year", EducationSetup."Academic Year");
                    PendinHousongWaiver.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    PendinHousongWaiver.SetFilter(Status, '%1|%2', PendinHousongWaiver.Status::Approved, PendinHousongWaiver.Status::Rejected);
                    PendinHousongWaiver.SetRange("Application Type", PendinHousongWaiver."Application Type"::"Housing Wavier");
                    if PendinHousongWaiver.findset() then begin
                        Page.RunModal(page::"Housing Wavier Approved List", PendinHousongWaiver);//50571
                    end;
                end;
            }
            field(Headline111; hdl11Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingChangeRequest.reset();
                    HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
                    HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    HousingChangeRequest.SetFilter(Status, '%1|%2', HousingChangeRequest.Status::Approved, HousingChangeRequest.Status::Rejected);
                    HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::"Change Request");
                    if HousingChangeRequest.findset() then begin
                        Page.RunModal(page::"Approve Reject Housing Change", HousingChangeRequest);//50426
                    end;
                end;
            }

            field(Headline121; hdl12Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingChangeRequest.reset();
                    HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
                    HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    HousingChangeRequest.SetFilter(Status, '%1|%2', HousingChangeRequest.Status::Approved, HousingChangeRequest.Status::Rejected);
                    HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::Vacate);
                    if HousingChangeRequest.findset() then begin
                        Page.RunModal(page::"Approve Reject Housing Change", HousingChangeRequest);//50426
                    end;
                end;
            }
            field(Headline131; hdl13Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingChangeRequest.reset();
                    HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
                    HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    HousingChangeRequest.SetFilter(Status, '%1|%2', HousingChangeRequest.Status::Approved, HousingChangeRequest.Status::Rejected);
                    HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::"Re-Registration");
                    if HousingChangeRequest.findset() then begin
                        Page.RunModal(page::"Approve Reject Housing Change", HousingChangeRequest);//50426
                    end;
                end;
            }
        }
    }

    var
        hdl1Txt: Text[100];
        hdl2Txt: Text[100];
        hdl3Txt: Text[100];
        hdl4Txt: Text[100];
        hdl5Txt: Text[100];
        hdl6Txt: Text[100];
        hdl7Txt: Text[100];
        hdl8Txt: Text[100];
        hdl9Txt: Text[100];
        hdl10Txt: Text[100];
        hdl11Txt: Text[100];
        hdl12Txt: Text[100];
        hdl13Txt: Text[100];
        FinAid: Record "Financial AID";
        FinancialAccountibility: Record "Financial Accountability";
        WithdrwalStudent: Record "Withdrawal Student-CS";
        WithdrawalApprovals: Record "Withdrawal Approvals";
        HousingApplication: Record "Housing Application";
        HousingChangeRequest: Record "Housing Change Request";
        PendinHousongWaiver: Record "Opt Out";
        ImmigrationHeader: Record "Immigration Header";
        HousingWaiver: Record "Opt Out";
        Usersetup1: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        UserGreetingVisible: Boolean;
        DefaultFieldsVisible: Boolean;
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";


    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountofPending: Integer;
        CountPendingHouseApp: Integer;
        CountHousingWaiver: Integer;
        CountHouseChange: Integer;
        CountHouseVacate: Integer;
        CountHouseReRegisration: Integer;
        CountApprovedWithApprovls: Integer;
        CountApRjHousingApplication: Integer;
        CountApRjHousingWaiver: Integer;
        CountApRjHousingChangeReq: Integer;
        CountApRjHousingVacateReq: Integer;
        CountApRjHousingReRegistrReq: Integer;
        CountApRjFinAccountibility: Integer;
        CountApRjImmigration: Integer;
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
                    hdl1Txt := 'Today is ' + EduCalendarLines.Description + '.';
            end
        end;
        if hdl1Txt = '' then begin
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
                    hdl1Txt := 'Next Holiday At ' + Monthv + '/' + DateV + '/' + YearV + ' For ' + EduCalendarLines.Description + '.';
                end
            end;
        end;
        //1 end
        //2 start
        Usersetup1.get(UserId);
        HousingApplication.reset();
        HousingApplication.SetRange("Academic Year", EducationSetup."Academic Year");
        // HousingApplication.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingApplication.SetRange(Status, HousingApplication.Status::"Pending for Approval");
        if HousingApplication.findset() then begin
            CountPendingHouseApp := HousingApplication.Count();
            hdl2Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPendingHouseApp)) + ' Pending Housing Applications.';
        End Else begin
            hdl2Txt := 'There are No Pending Housing Applications.';
        end;
        //2 end
        //3 start
        Usersetup1.get(UserId);
        HousingWaiver.reset();
        HousingWaiver.SetRange("Academic Year", EducationSetup."Academic Year");
        // HousingWaiver.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingWaiver.SetRange("Application Type", HousingWaiver."Application Type"::"Housing Wavier");
        HousingWaiver.setrange(HousingWaiver.Status, HousingWaiver.Status::"Pending for Approval");
        if HousingWaiver.findset() then begin
            CountHousingWaiver := HousingWaiver.Count();
            hdl3Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountHousingWaiver)) + ' Pending Housing Waiver.';
        End Else begin
            hdl3Txt := 'There are No Pending Housing Waiver.';
        end;
        //3 end
        //4 start
        Usersetup1.get(UserId);
        HousingChangeRequest.reset();
        HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
        HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::"Change Request");
        HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingChangeRequest.SetRange(Status, HousingChangeRequest.Status::"Pending for Approval");
        if HousingChangeRequest.findset() then begin
            CountHouseChange := HousingChangeRequest.Count();
            hdl4Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountHouseChange)) + ' Pending Housing Change Applications.';
        End Else begin
            hdl4Txt := 'There are No  Pending Housing Change Applications.';
        end;
        //4 end
        //5 start
        Usersetup1.get(UserId);
        HousingChangeRequest.reset();
        HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
        HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::Vacate);
        HousingChangeRequest.SetRange(Status, HousingChangeRequest.Status::"Pending for Approval");
        if HousingChangeRequest.findset() then begin
            CountHouseVacate := HousingChangeRequest.Count();
            hdl5Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountHouseVacate)) + ' Pending Vacate Applications.';
        End Else begin
            hdl5Txt := 'There are No  Pending Vacate Application.';
        end;
        //5 end
        //6 start
        Usersetup1.Get(UserId);
        HousingChangeRequest.Reset();
        HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
        HousingChangeRequest.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::"Re-Registration");
        HousingChangeRequest.SetRange(Status, HousingChangeRequest.Status::"Pending for Approval");
        if HousingChangeRequest.FindSet() then begin
            CountHouseReRegisration := HousingChangeRequest.Count();
            hdl6Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountHouseReRegisration)) + ' Pending Re-Registration Applications.';
        End Else begin
            hdl6Txt := 'There are No  Pending Re-Registration Applicaitons.';
        end;
        //6 end
        //7 start
        Usersetup1.Get(UserId);
        ImmigrationHeader.Reset();
        ImmigrationHeader.SetRange("Academic Year", EducationSetup."Academic Year");
        ImmigrationHeader.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        ImmigrationHeader.SetFilter("Document Status", '%1|%2', ImmigrationHeader."Document Status"::Verified, ImmigrationHeader."Document Status"::Rejected);
        if ImmigrationHeader.FindSet() then begin
            CountApRjImmigration := ImmigrationHeader.Count();
            hdl7Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRjImmigration)) + ' Approved or Rejected Immigrations.';
        End Else begin
            hdl7Txt := 'There are No Approved or Rejected Immigration.';
        end;
        //7 end
        //8 start
        Usersetup1.Get(UserId);
        FinancialAccountibility.Reset();
        FinancialAccountibility.SetRange("Academic Year", EducationSetup."Academic Year");
        FinancialAccountibility.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        FinancialAccountibility.SetFilter(Status, '%1|%2', FinancialAccountibility.Status::Approved, FinancialAccountibility.Status::Rejected);
        if FinancialAccountibility.FindSet() then begin
            CountApRjFinAccountibility := FinancialAccountibility.Count();
            hdl8Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRjFinAccountibility)) + ' Approved or Rejected Financial Accountibility.';
        End Else begin
            hdl8Txt := 'There are No Approved or Rejected Financial Accountibility.';
        end;
        //8 end
        //9 start
        Usersetup1.get(UserId);
        HousingApplication.reset();
        HousingApplication.SetRange("Academic Year", EducationSetup."Academic Year");
        HousingApplication.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingApplication.SetFilter(Status, '%1|%2', HousingApplication.Status::Approved, HousingApplication.Status::Rejected);
        if HousingApplication.findset() then begin
            CountApRjHousingApplication := HousingApplication.Count();
            hdl9Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRjHousingApplication)) + ' Approved or Rejected Housing Applications.';
        End Else begin
            hdl9Txt := 'There are No Approved or Rejected Housing Applications.';
        end;
        //9 end
        //10 start
        Usersetup1.get(UserId);
        PendinHousongWaiver.reset();
        PendinHousongWaiver.SetRange("Academic Year", EducationSetup."Academic Year");
        PendinHousongWaiver.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        PendinHousongWaiver.SetRange("Application Type", PendinHousongWaiver."Application Type"::"Housing Wavier");
        PendinHousongWaiver.SetFilter(Status, '%1|%2', PendinHousongWaiver.Status::Approved, PendinHousongWaiver.Status::Rejected);
        if PendinHousongWaiver.findset() then begin
            CountApRjHousingWaiver := PendinHousongWaiver.Count();
            hdl10Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRjHousingWaiver)) + ' Approved or Rejected Waiver.';
        End Else begin
            hdl10Txt := 'There are No Approved or Rejected Waiver.';
        end;
        //10 end
        //11 start
        Usersetup1.get(UserId);
        HousingChangeRequest.reset();
        HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
        HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingChangeRequest.SetFilter(Status, '%1|%2', HousingChangeRequest.Status::Approved, HousingChangeRequest.Status::Rejected);
        HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::"Change Request");
        if HousingChangeRequest.findset() then begin
            CountApRjHousingChangeReq := HousingChangeRequest.Count();
            hdl11Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRjHousingChangeReq)) + ' Approved or Rejected Change Requests.';
        End Else begin
            hdl11Txt := 'There are No Approved or Rejected Change Requests.';
        end;
        //11 end
        //12 start
        Usersetup1.get(UserId);
        HousingChangeRequest.reset();
        HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
        HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingChangeRequest.SetFilter(Status, '%1|%2', HousingChangeRequest.Status::Approved, HousingChangeRequest.Status::Rejected);
        HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::Vacate);
        if HousingChangeRequest.findset() then begin
            CountApRjHousingVacateReq := HousingChangeRequest.Count();
            hdl12Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRjHousingVacateReq)) + ' Approved or Rejected Vacate Requests.';
        End Else begin
            hdl12Txt := 'There are No Approved or Rejected Vacate Requests.';
        end;
        //12 end
        //13 start
        Usersetup1.get(UserId);
        HousingChangeRequest.reset();
        HousingChangeRequest.SetRange("Academic Year", EducationSetup."Academic Year");
        HousingChangeRequest.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        HousingChangeRequest.SetFilter(Status, '%1|%2', HousingChangeRequest.Status::Approved, HousingChangeRequest.Status::Rejected);
        HousingChangeRequest.SetRange(Type, HousingChangeRequest.Type::"Re-Registration");
        if HousingChangeRequest.findset() then begin
            CountApRjHousingReRegistrReq := HousingChangeRequest.Count();
            hdl13Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRjHousingReRegistrReq)) + ' Approved or Rejected Re-Registration Requests.';
        End Else begin
            hdl13Txt := 'There are No Approved or Rejected Re-Registration Requests.';
        end;
        //13 end
    end;
}
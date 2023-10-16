Page 50000 UinversityHCHeadline
{//CSPL-00307 - Insurance Waiver
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
            field(headline11; hdl1Txt)
            {

            }
            field(Headline51; hdl5Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                Var
                    InsuranceWaiver: Record "Student Rank-CS";
                    InsuranceWaiverList: Page "Pending Insurance Waiver List";
                begin
                    Usersetup1.get(UserId);
                    Clear(InsuranceWaiverList);
                    InsuranceWaiver.Reset();
                    InsuranceWaiver.SetFilter(Status, '%1|%2', InsuranceWaiver.Status::" ", InsuranceWaiver.Status::Pending);
                    InsuranceWaiver.Setrange("Created On", Today());
                    InsuranceWaiverList.SetTableView(InsuranceWaiver);
                    InsuranceWaiverList.Run();

                end;
            }
            field(Headline21; hdl2Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                Var
                    InsuranceWaiver: Record "Student Rank-CS";
                    InsuranceWaiverList: Page "Pending Insurance Waiver List";
                begin
                    Usersetup1.get(UserId);
                    Clear(InsuranceWaiverList);
                    InsuranceWaiver.Reset();
                    InsuranceWaiver.SetFilter(Status, '%1|%2', InsuranceWaiver.Status::" ", InsuranceWaiver.Status::Pending);
                    InsuranceWaiverList.SetTableView(InsuranceWaiver);
                    InsuranceWaiverList.Run();

                end;

            }
            field(Headline31; hdl3Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                Var
                    InsuranceWaiver: Record "Student Rank-CS";
                    InsuranceWaiverList: Page "Pending Insurance Waiver List";
                begin
                    Usersetup1.get(UserId);
                    Clear(InsuranceWaiverList);
                    InsuranceWaiver.Reset();
                    InsuranceWaiver.SetRange(Status, InsuranceWaiver.Status::Approved);
                    InsuranceWaiverList.SetTableView(InsuranceWaiver);
                    InsuranceWaiverList.Run();

                end;
            }
            field(Headline41; hdl4Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                Var
                    InsuranceWaiver: Record "Student Rank-CS";
                    InsuranceWaiverList: Page "Pending Insurance Waiver List";
                begin
                    Usersetup1.get(UserId);
                    Clear(InsuranceWaiverList);
                    InsuranceWaiver.Reset();
                    InsuranceWaiver.SetRange(Status, InsuranceWaiver.Status::Rejected);
                    InsuranceWaiverList.SetTableView(InsuranceWaiver);
                    InsuranceWaiverList.Run();

                end;
            }

        }
    }

    var

        InsuranceWaiver: Record "Student Rank-CS";
        Usersetup1: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";
        UserGreetingVisible: Boolean;
        DefaultFieldsVisible: Boolean;
        hdl1Txt: Text[100];
        hdl2Txt: Text[100];
        hdl3Txt: Text[100];
        hdl4Txt: Text[100];
        hdl5Txt: Text[100];
        hdl6Txt: Text[100];


    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountNewStdCrToday: Integer;
        CountOLRCompleted: Integer;
        CountPengWithdlStudents: Integer;
        CountPngSLOAApps: Integer;
        CountPngELOAApps: Integer;
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
        Usersetup1.Get(UserId);
        InsuranceWaiver.Reset();
        InsuranceWaiver.SetFilter(Status, '%1|%2', InsuranceWaiver.Status::" ", InsuranceWaiver.Status::Pending);
        IF InsuranceWaiver.FindFirst() then begin
            CountNewStdCrToday := InsuranceWaiver.Count();
            hdl2Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountNewStdCrToday)) + ' Pending Insurance Waiver.';
        End Else begin
            hdl2Txt := 'There are No Total Pending Insurance Waiver.';
        end;
        //2 end
        //3 start
        Usersetup1.Get(UserId);
        InsuranceWaiver.Reset();
        InsuranceWaiver.SetRange(Status, InsuranceWaiver.Status::Approved);
        IF InsuranceWaiver.FindFirst() then begin
            CountOLRCompleted := InsuranceWaiver.Count();
            hdl3Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountOLRCompleted)) + ' Approved Insurance Waiver.';
        End Else begin
            hdl3Txt := 'There are No Total Approved Insurance Waiver.';
        end;
        // 3 end
        //4 start
        Usersetup1.Get(UserId);
        InsuranceWaiver.Reset();
        InsuranceWaiver.SetRange(Status, InsuranceWaiver.Status::Rejected);
        IF InsuranceWaiver.FindFirst() then begin
            CountPengWithdlStudents := InsuranceWaiver.Count();
            hdl4Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPengWithdlStudents)) + ' Rejected Insurance Waiver.';
        End Else begin
            hdl4Txt := 'There are No Total Rejected Insurance Waiver.';
        end;
        //4 end
        //5 start
        Usersetup1.Get(UserId);
        InsuranceWaiver.Reset();
        InsuranceWaiver.SetRange("Created On", Today());
        IF InsuranceWaiver.FindFirst() then begin
            CountPngSLOAApps := InsuranceWaiver.Count();
            hdl5Txt := 'There are Total ' + Headlinesmgnt.Emphasize(Format(CountPngSLOAApps)) + ' Insurance Waiver created today.';
        End Else begin
            hdl5Txt := 'There are No Insurance Waiver created today.';
        end;
        //5 end
    end;
}
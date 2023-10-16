page 50948 RoleCenterHeadlineFinancialAid
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

            field(headline11; hdl1Txt)
            {

            }
            field(Headline21; hdl2Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    StudentMaster.reset();
                    //StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
                    StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    StudentMaster.SetRange("Creation Date", Today);
                    StudentMaster.SetFilter(Status, '<>%1', ' ');
                    StudentMaster.SetFilter("Course Code", '<>%1', ' ');
                    if StudentMaster.findset() then begin
                        Page.RunModal(Page::"Student Details-CS", StudentMaster);//50296
                    end;
                end;
            }
            field(Headline31; hdl3Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.Get(UserId);
                    FinancialAID.reset();
                    //FinancialAID.SetRange("Academic Year", EducationSetup."Academic Year");
                    FinancialAID.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    FinancialAID.SetRange(Status, FinancialAID.Status::"Pending for Approval");
                    FinancialAID.SetRange(Type, FinancialAID.Type::"Financial Aid");
                    if FinancialAID.findset() then begin
                        Page.RunModal(Page::"Financial AID Pending List", FinancialAID);//50652
                    end;
                end;
            }
        }
    }

    var
        hdl1Txt: Text[100];
        hdl2Txt: Text[100];
        hdl3Txt: Text[100];
        Usersetup1: Record "User Setup";
        StudentMaster: Record "Student Master-CS";
        FinancialAID: Record "Financial AID";
        EducationSetup: Record "Education Setup-CS";
        UserGreetingVisible: Boolean;
        DefaultFieldsVisible: Boolean;
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";


    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountNewStdCrToday: Integer;
        CountTtlPendgFindAidApps: integer;
        DateV: Text;
        Monthv: Text;
        YearV: text;
    begin
        //Greeting Start
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Team Member");
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
        StudentMaster.Reset();
        //StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentMaster.SetRange("Creation Date", Today);
        StudentMaster.SetFilter(Status, '<>%1', ' ');
        StudentMaster.SetFilter("Course Code", '<>%1', ' ');
        if StudentMaster.FindSet() then begin
            CountNewStdCrToday := StudentMaster.Count();
            hdl2Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountNewStdCrToday)) + ' New Students Created Today.';
        End Else begin
            hdl2Txt := 'There are No New Students Created Today.';
        end;
        //2 end
        //3 start
        Usersetup1.get(UserId);
        FinancialAID.reset();
        // FinancialAID.SetRange("Academic Year", EducationSetup."Academic Year");
        FinancialAID.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        FinancialAID.SetRange(Status, FinancialAID.Status::"Pending for Approval");
        FinancialAID.SetRange(Type, FinancialAID.Type::"Financial Aid");
        if FinancialAID.FindSet() then begin
            CountTtlPendgFindAidApps := FinancialAID.Count();
            hdl3Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountTtlPendgFindAidApps)) + ' Financial Aid Application Pending.';
        End Else begin
            hdl3Txt := 'There are No Financial Aid Application Pending.';
        end;
        //3 end
    end;
}
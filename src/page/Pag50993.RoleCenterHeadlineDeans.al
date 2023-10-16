page 50993 RoleCenterHeadlineDeans
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
                    WithrawalStudent.reset();
                    WithrawalStudent.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    WithrawalStudent.SetRange("Withdrawal Status", WithrawalStudent."Withdrawal Status"::"Pending for Approval");
                    WithrawalStudent.setrange("Type of Withdrawal", WithrawalStudent."Type of Withdrawal"::"Course-Withdrawal");
                    if WithrawalStudent.findset() then begin
                        Page.RunModal(Page::"Stud. Course Withdrawal List", WithrawalStudent);//50231
                    end;
                end;
            }
            field(Headline31; hdl3Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    LeavesApvls.reset();
                    // LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
                    // LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
                    LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::SLOA);
                    if LeavesApvls.findset() then begin
                        Page.RunModal(Page::"Pending Leaves Approvals", LeavesApvls);//50719
                    end;
                end;
            }
            field(Headline41; hdl4Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    LeavesApvls.reset();
                    // LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
                    // LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
                    LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::ELOA);
                    if LeavesApvls.findset() then begin
                        Page.RunModal(Page::"Pending Leaves Approvals", LeavesApvls);//50719
                    end;
                end;
            }
            field(Headline51; hdl5Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    LeavesApvls.reset();
                    // LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
                    // LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
                    LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::CLOA);
                    if LeavesApvls.findset() then begin
                        Page.RunModal(Page::"Pending Leaves Approvals", LeavesApvls);//50719
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
        Usersetup1: Record "User Setup";
        WithrawalStudent: Record "Withdrawal Student-CS";
        LeavesApvls: Record "Leaves Approvals";
        EducationSetup: Record "Education Setup-CS";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";


    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountPngELOAApps: integer;
        CountPngSLOAApps: integer;
        CountPngCLOAApps: integer;
        CountPngWithdstudents: integer;
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
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        EduCalendar.reset();
        EduCalendar.SetRange("Academic Year", EducationSetup."Academic Year");
        EduCalendar.SetRange("Global Dimension 1 Code", '9000');
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
            EducationSetup.SetRange("Global Dimension 1 Code", '9000');
            if EducationSetup.FindFirst() then;
            // //SD-SB-09-MAR-21 +
            // if Usersetup1."Global Dimension 1 Code" = '' then begin
            //     EducationSetup.reset();
            //     if EducationSetup.FindFirst() then;
            // end;
            //SD-SB-09-MAR-21 -
            EduCalendar.reset();
            EduCalendar.SetRange("Academic Year", EducationSetup."Academic Year");
            EduCalendar.SetRange("Global Dimension 1 Code", '9000');
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
        WithrawalStudent.reset();
        WithrawalStudent.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        WithrawalStudent.SetRange("Withdrawal Status", WithrawalStudent."Withdrawal Status"::"Pending for Approval");
        WithrawalStudent.setrange("Type of Withdrawal", WithrawalStudent."Type of Withdrawal"::"Course-Withdrawal");
        if WithrawalStudent.findset() then begin
            CountPngWithdstudents := LeavesApvls.Count();
            hdl2Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPngWithdstudents)) + ' Pending Withdrawal Students.';
        End Else begin
            hdl2Txt := 'There are No Pending Withdrawal Students.';
        end;
        //2 end
        //3 start
        Usersetup1.Get(UserId);
        LeavesApvls.Reset();
        // LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
        // LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
        LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::SLOA);
        if LeavesApvls.FindSet() then begin
            CountPngSLOAApps := LeavesApvls.Count();
            hdl3Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPngSLOAApps)) + ' Pending SLOA Applications.';
        End Else begin
            hdl3Txt := 'There are No Pending SLOA Applications.';
        end;
        //3 end
        //4 Start
        Usersetup1.Get(UserId);
        LeavesApvls.Reset();
        // LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
        // LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
        LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::ELOA);
        if LeavesApvls.FindSet() then begin
            CountPngELOAApps := LeavesApvls.Count();
            hdl4Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPngELOAApps)) + ' Pending EOA Applications.';
        End Else begin
            hdl4Txt := 'There are No Pending ELOA Applications.';
        end;
        //4 end
        //5 start
        Usersetup1.Get(UserId);
        LeavesApvls.Reset();
        // LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
        // LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
        LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::CLOA);
        if LeavesApvls.FindSet() then begin
            CountPngCLOAApps := LeavesApvls.Count();
            hdl5Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPngCLOAApps)) + ' Pending CLOA Applications.';
        End Else begin
            hdl5Txt := 'There are No Pending CLOA Applications.';
        end;
        //5 end
    end;
}
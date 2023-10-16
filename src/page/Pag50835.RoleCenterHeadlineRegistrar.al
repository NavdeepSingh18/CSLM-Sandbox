page 50835 RoleCenterHeadlineRegistrar
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
                    StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
                    StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    StudentMaster.SetRange("Creation Date", Today);
                    if StudentMaster.findset() then begin
                        Page.RunModal(50296, StudentMaster);
                    end;
                end;
            }
            field(Headline31; hdl3Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    StudentMaster.reset();
                    StudentMaster.Setfilter("Academic Year", '%1|%2', EducationSetup."Academic Year", EducationSetup."Returning OLR Academic Year");
                    StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    StudentMaster.Setfilter(Term, '%1|%2', EducationSetup."Even/Odd Semester", EducationSetup."Returning OLR Term");
                    StudentMaster.SetRange("OLR Completed", true);
                    if StudentMaster.findset() then begin
                        Page.RunModal(50296, StudentMaster);
                    end;
                end;
            }
            field(Headline41; hdl4Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    WithdrwalStudent.reset();
                    WithdrwalStudent.SetRange("Academic Year", EducationSetup."Academic Year");
                    WithdrwalStudent.Setfilter(Status, '%1|%2', WithdrwalStudent.Status::"Pending for Approval", WithdrwalStudent.Status::Rejected);
                    // WithdrwalStudent.SetRange("Type of Withdrawal", WithdrwalStudent."Type of Withdrawal"::"Course-Withdrawal");
                    WithdrwalStudent.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    if WithdrwalStudent.findset() then begin
                        Page.RunModal(50858, WithdrwalStudent);
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
                    LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
                    LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
                    LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::SLOA);
                    if LeavesApvls.findset() then begin
                        Page.RunModal(50719, LeavesApvls);
                    end;
                end;
            }
            field(Headline61; hdl6Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    LeavesApvls.reset();
                    LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
                    LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
                    LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::ELOA);
                    if LeavesApvls.findset() then begin
                        Page.RunModal(50719, LeavesApvls);
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
        StudentMaster: Record "Student Master-CS";
        WithdrwalStudent: Record "Withdrawal Approvals";
        LeavesApvls: Record "Leaves Approvals";
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
        StudentMaster.Reset();
        StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentMaster.SetRange("Creation Date", Today);
        if StudentMaster.FindSet() then begin
            CountNewStdCrToday := StudentMaster.Count();
            hdl2Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountNewStdCrToday)) + ' New students created today.';
        End Else begin
            hdl2Txt := 'There are No New Students created today.';
        end;
        //2 end
        //3 start
        Usersetup1.Get(UserId);
        StudentMaster.Reset();
        StudentMaster.Setfilter("Academic Year", '%1|%2', EducationSetup."Academic Year", EducationSetup."Returning OLR Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentMaster.Setfilter(Term, '%1|%2', EducationSetup."Even/Odd Semester", EducationSetup."Returning OLR Term");
        StudentMaster.SetRange("OLR Completed", true);
        if StudentMaster.FindSet() then begin
            CountOLRCompleted := StudentMaster.Count();
            hdl3Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountOLRCompleted)) + ' OLR completed.';
        End Else begin
            hdl3Txt := 'There are No Total OLR completed.';
        end;
        // 3 end
        //4 start
        Usersetup1.Get(UserId);
        WithdrwalStudent.Reset();
        WithdrwalStudent.SetRange("Academic Year", EducationSetup."Academic Year");
        WithdrwalStudent.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        WithdrwalStudent.Setfilter(Status, '%1|%2', WithdrwalStudent.Status::"Pending for Approval", WithdrwalStudent.Status::Rejected);
        // WithdrwalStudent.SetRange("Type of Withdrawal", WithdrwalStudent."Type of Withdrawal"::"Course-Withdrawal");
        if WithdrwalStudent.FindSet() then begin
            CountPengWithdlStudents := WithdrwalStudent.Count();
            hdl4Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPengWithdlStudents)) + ' Pending Withdrawal Students.';
        End Else begin
            hdl4Txt := 'There are No Pending Withdrawal Students.';
        end;
        //4 end
        //5 start
        Usersetup1.Get(UserId);
        LeavesApvls.Reset();
        LeavesApvls.reset();
        LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
        LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
        LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::SLOA);
        if LeavesApvls.FindSet() then begin
            CountPngSLOAApps := LeavesApvls.Count();
            hdl5Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPngSLOAApps)) + ' Pending SLOA Applications.';
        End Else begin
            hdl5Txt := 'There are No Pending SLOA Applications.';
        end;
        //5 end
        //6 start
        Usersetup1.Get(UserId);
        LeavesApvls.Reset();
        LeavesApvls.reset();
        LeavesApvls.SetRange("Academic Year", EducationSetup."Academic Year");
        LeavesApvls.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        LeavesApvls.SetRange("Status", LeavesApvls."Status"::"Pending for Approval");
        LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::ELOA);
        if LeavesApvls.FindSet() then begin
            CountPngELOAApps := LeavesApvls.Count();
            hdl6Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPngELOAApps)) + ' Pending ELOA Applications.';
        End Else begin
            hdl6Txt := 'There are No Pending ELOA Applications.';
        end;

        //6 end
    end;
}
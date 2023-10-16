page 50963 RoleCenterHeadLineAcademics
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
                    StudentMaster.SetRange(Status, 'SLOA');
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
                    StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
                    StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    StudentMaster.SetRange(Status, 'EXTLOA');
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
                    StudentMaster.reset();
                    StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
                    StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    StudentMaster.SetRange(Status, 'CLOA');
                    if StudentMaster.findset() then begin
                        Page.RunModal(50296, StudentMaster);
                    end;
                end;
            }

        }
    }

    var
        StudentMaster: Record "Student Master-CS";
        WithdrwalStudent: Record "Withdrawal Student-CS";
        LeavesApvls: Record "Leaves Approvals";
        Usersetup1: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";
        hdl1Txt: Text[100];
        hdl2Txt: Text[100];
        hdl3Txt: Text[100];
        hdl4Txt: Text[100];
        hdl5Txt: Text[100];
        hdl6Txt: Text[100];
        hdl7Txt: Text[100];
        hdl8Txt: Text[100];
    // UserGreetingVisible: Boolean;
    // DefaultFieldsVisible: Boolean;



    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountSLOA: Integer;
        CountELOA: Integer;
        CountCLOA: Integer;
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
        StudentMaster.SetRange(Status, 'SLOA');
        if StudentMaster.FindSet() then begin
            CountSLOA := StudentMaster.Count();
            hdl2Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountSLOA)) + ' Students are on SLOA.';
        End Else begin
            hdl2Txt := 'There are No Students on SLOA.';
        end;
        //2 end
        //3 start
        Usersetup1.Get(UserId);
        StudentMaster.Reset();
        StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentMaster.SetRange(Status, 'EXTLOA');
        if StudentMaster.FindSet() then begin
            CountELOA := StudentMaster.Count();
            hdl3Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountELOA)) + ' Students are on ELOA.';
        End Else begin
            hdl3Txt := 'There are No Students on ELOA.';
        end;
        // 3 end
        //4 start
        Usersetup1.Get(UserId);
        StudentMaster.Reset();
        StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentMaster.SetRange(Status, 'CLOA');
        if StudentMaster.FindSet() then begin
            CountCLOA := StudentMaster.Count();
            hdl4Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountCLOA)) + ' Students are on CLOA.';
        End Else begin
            hdl4Txt := 'There are No Students on CLOA.';
        end;
        //4 end



    end;
}
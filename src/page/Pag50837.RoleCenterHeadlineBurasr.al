page 50837 RoleCenterHeadlineBursar
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
                    WithdrwlStd.Reset();
                    WithdrwlStd.SetRange("Withdrawal Status", WithdrwlStd."Withdrawal Status"::Open);
                    //WithdrwlStd.SetRange("Academic Year", EducationSetup."Academic Year");
                    WithdrwlStd.SetRange("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    if WithdrwlStd.FindSet() then begin
                        Page.RunModal(page::"Stud. Withdrawal-CS", WithdrwlStd);//50171
                    end;
                end;
            }
            field(Headline41; hdl4Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    StudentWiseHold.reset();
                    //StudentWiseHold.SetRange("Academic Year", EducationSetup."Academic Year");
                    StudentWiseHold.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    StudentWiseHold.SetRange(StudentWiseHold.Status, StudentWiseHold.Status::Enable);
                    StudentWiseHold.SetRange("Hold Type", StudentWiseHold."Hold Type"::Bursar);
                    if StudentWiseHold.findset() then begin
                        Page.RunModal(Page::"Student Wise Hold List", StudentWiseHold);//50296
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
        Usersetup1: Record "User Setup";
        StudentMaster: Record "Student Master-CS";
        WithdrwlStd: Record "Withdrawal Student-CS";
        StudentWiseHold: Record "Student Wise Holds";
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
        CountWithdrwlAppForm: integer;
        CountBursarHold: integer;
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
        //StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentMaster.SetRange("Creation Date", Today);
        StudentMaster.SetFilter(Status, '<>%1', ' ');
        StudentMaster.SetFilter("Course Code", '<>%1', ' ');
        if StudentMaster.FindSet() then begin
            CountNewStdCrToday := StudentMaster.Count();
            hdl2Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountNewStdCrToday)) + ' New students created today.';
        End Else begin
            hdl2Txt := 'There are No New Students created today.';
        end;
        //2 end
        //3 start
        Usersetup1.get(UserId);
        WithdrwlStd.reset();
        //WithdrwlStd.SetRange("Academic Year", EducationSetup."Academic Year");
        WithdrwlStd.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        WithdrwlStd.SetRange("Withdrawal Status", WithdrwlStd."Withdrawal Status"::Open);
        if WithdrwlStd.findset() then begin
            CountWithdrwlAppForm := WithdrwlStd.Count();
            hdl3Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountWithdrwlAppForm)) + ' withdrawal application form.';
        End Else begin
            hdl3Txt := 'There are No withdrawal application form.';
        end;
        //3 end
        //4 start
        Usersetup1.get(UserId);
        StudentWiseHold.reset();
        //StudentWiseHold.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentWiseHold.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentWiseHold.SetRange(Status, StudentWiseHold.Status::Enable);
        StudentWiseHold.SetRange("Hold Type", StudentWiseHold."Hold Type"::Bursar);
        if StudentWiseHold.findset() then begin
            CountBursarHold := StudentWiseHold.Count();
            hdl4Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountBursarHold)) + ' no of bursar hold.';
        End Else begin
            hdl4Txt := 'There are No bursar hold.';
        end;
    end;
    //4 end
}
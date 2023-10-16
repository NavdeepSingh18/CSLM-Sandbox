page 50834 RoleCenterHeadlineAdmission
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
                Visible = false;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingApplication.reset();
                    HousingApplication.SetRange("Academic Year", EducationSetup."Academic Year");
                    //HousingApplication.SetFilter("Global Dimension 1 Code", '%1', Usersetup1."Global Dimension 1 Code");
                    HousingApplication.SetRange(Status, HousingApplication.Status::"Pending for Approval");
                    if HousingApplication.findset() then begin
                        Page.RunModal(50421, HousingApplication);
                    end;
                end;
            }
            field(Headline31; hdl3Txt)
            {
                DrillDown = true;
                Visible = false;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    PendinHousongWaiver.reset();
                    PendinHousongWaiver.SetRange("Academic Year", EducationSetup."Academic Year");
                    //PendinHousongWaiver.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    PendinHousongWaiver.SetRange(Status, PendinHousongWaiver.Status::"Pending for Approval");
                    PendinHousongWaiver.SetRange("Application Type", PendinHousongWaiver."Application Type"::"Housing Wavier");
                    if PendinHousongWaiver.findset() then begin
                        Page.RunModal(50573, PendinHousongWaiver);
                    end;
                end;

            }
            field(Headline41; hdl4Txt)
            {
                DrillDown = true;
                Visible = false;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    HousingApplication.reset();
                    HousingApplication.SetRange("Academic Year", EducationSetup."Academic Year");
                    //HousingApplication.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    HousingApplication.SetFilter(Status, '%1|%2', HousingApplication.Status::Approved, HousingApplication.Status::Rejected);
                    if HousingApplication.findset() then begin
                        Page.RunModal(50432, HousingApplication);
                    end;
                end;
            }
            field(Headline51; hdl5Txt)
            {
                DrillDown = true;
                Visible = false;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    PendinHousongWaiver.reset();
                    PendinHousongWaiver.SetRange("Academic Year", EducationSetup."Academic Year");
                    //PendinHousongWaiver.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    PendinHousongWaiver.SetFilter(Status, '%1|%2', PendinHousongWaiver.Status::Approved, PendinHousongWaiver.Status::Rejected);
                    PendinHousongWaiver.SetRange("Application Type", PendinHousongWaiver."Application Type"::"Housing Wavier");
                    if PendinHousongWaiver.findset() then begin
                        Page.RunModal(50571, PendinHousongWaiver);
                    end;
                end;
            }
            field(Headline61; hdl6Txt)
            {
                DrillDown = true;
                Visible = False;

                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    GraduationMaster.reset();
                    GraduationMaster.SetRange("Academic Year", EducationSetup."Academic Year");
                    GraduationMaster.SetFilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    if GraduationMaster.findset() then begin
                        Page.RunModal(50293, GraduationMaster);
                    end;
                end;
            }
            field(Headline71; hdl7Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    CourseMaster.reset();
                    //CourseMaster.SetRange("Academic Year", EducationSetup."Academic Year");
                    CourseMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    if CourseMaster.findset() then begin
                        Page.RunModal(50291, CourseMaster);
                    end;
                end;
            }
            field(Headline81; hdl8Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    StudentMaster.reset();
                    StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
                    StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    if StudentMaster.findset() then begin
                        Page.RunModal(50296, StudentMaster);
                    end;
                end;
            }
            field(Headline91; hdl9Txt)
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
            field(Headline101; hdl10Txt)
            {
                Visible = false;
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    PortalUser.reset();
                    PortalUser.SetRange("Created On", Today);
                    PortalUser.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    if PortalUser.findset() then begin
                        Page.RunModal(50040, PortalUser);
                    end;
                end;
            }
        }
    }

    var
        hdl11Txt: Text[100];
        hdl2Txt: Text[100];
        hdl3Txt: Text[100];
        hdl4Txt: Text[100];
        hdl5Txt: Text[100];
        hdl6Txt: Text[100];
        hdl7Txt: Text[100];
        hdl8Txt: Text[100];
        hdl9Txt: Text[100];
        hdl10Txt: Text[100];
        HousingApplication: Record "Housing Application";
        PendinHousongWaiver: Record "Opt Out";
        Usersetup1: Record "User Setup";
        GraduationMaster: Record "Graduation Master-CS";
        CourseMaster: Record "Course Master-CS";
        StudentMaster: Record "Student Master-CS";
        PortalUser: Record "Portal User Login-CS";

        EducationSetup: Record "Education Setup-CS";
        // UserGreetingVisible: Boolean;
        // DefaultFieldsVisible: Boolean;
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";

    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountofPending: Integer;
        CountPendingHouseApp: Integer;
        CountPendingHouseWaiver: Integer;
        CountApRejPendHousApp: Integer;
        CountApRejHouseWaiver: Integer;
        CountProgram: Integer;
        CountCourse: Integer;
        CountStudent: Integer;
        CountStdCrToday: Integer;
        CountPortalUsrCrToday: Integer;
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
        HousingApplication.reset();
        HousingApplication.SetRange("Academic Year", EducationSetup."Academic Year");
        //HousingApplication.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
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
        PendinHousongWaiver.reset();
        PendinHousongWaiver.SetRange("Academic Year", EducationSetup."Academic Year");
        //PendinHousongWaiver.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        PendinHousongWaiver.SetRange(Status, PendinHousongWaiver.Status::"Pending for Approval");
        PendinHousongWaiver.SetRange("Application Type", PendinHousongWaiver."Application Type"::"Housing Wavier");
        if PendinHousongWaiver.findset() then begin
            CountPendingHouseWaiver := PendinHousongWaiver.Count();
            hdl3Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPendingHouseWaiver)) + ' Pending Housing Waiver.';
        End Else begin
            hdl3Txt := 'There are No Pending Housing Waiver.';
        end;
        //3 end
        //4 start
        Usersetup1.get(UserId);
        HousingApplication.reset();
        HousingApplication.SetRange("Academic Year", EducationSetup."Academic Year");
        HousingApplication.SetFilter(Status, '%1|%2', HousingApplication.Status::Approved, HousingApplication.Status::Rejected);
        //HousingApplication.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        if HousingApplication.findset() then begin
            CountApRejPendHousApp := HousingApplication.Count();
            hdl4Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRejPendHousApp)) + ' Approved or Rejected Housing Applications.';
        End Else begin
            hdl4Txt := 'There are No Approved or Rejected Housing Applications.';
        end;
        //4 end
        //5 start
        Usersetup1.get(UserId);
        PendinHousongWaiver.reset();
        PendinHousongWaiver.SetRange("Academic Year", EducationSetup."Academic Year");
        //PendinHousongWaiver.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        PendinHousongWaiver.SetFilter(Status, '%1|%2', PendinHousongWaiver.Status::Approved, PendinHousongWaiver.Status::Rejected);
        PendinHousongWaiver.SetRange("Application Type", PendinHousongWaiver."Application Type"::"Housing Wavier");
        if PendinHousongWaiver.findset() then begin
            CountApRejHouseWaiver := PendinHousongWaiver.Count();
            hdl5Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountApRejHouseWaiver)) + ' Approved or Rejected Waiver.';
        End Else begin
            hdl5Txt := 'There are No Approved or Rejected Waiver.';
        end;
        //5 end
        //6 start
        Usersetup1.Get(UserId);
        GraduationMaster.Reset();
        GraduationMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        GraduationMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        if GraduationMaster.FindSet() then begin
            CountProgram := GraduationMaster.Count();
            hdl6Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountProgram)) + ' Programs.';
        End Else begin
            hdl6Txt := 'There are No Programs.';
        end;
        //6 end
        //7 start
        Usersetup1.Get(UserId);
        CourseMaster.Reset();
        //CourseMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        CourseMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        if CourseMaster.FindSet() then begin
            CountCourse := CourseMaster.Count();
            hdl7Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountCourse)) + ' Courses.';
        End Else begin
            hdl7Txt := 'There are No Courses.';
        end;
        //7 end
        //8 start
        Usersetup1.Get(UserId);
        StudentMaster.Reset();
        StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        if StudentMaster.FindSet() then begin
            CountStudent := StudentMaster.Count();
            hdl8Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountStudent)) + ' Students.';
        End Else begin
            hdl8Txt := 'There are No Students.';
        end;
        //8 end
        //9 start
        Usersetup1.Get(UserId);
        StudentMaster.Reset();
        StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentMaster.SetRange("Creation Date", Today);
        if StudentMaster.FindSet() then begin
            CountStdCrToday := StudentMaster.Count();
            hdl9Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountStdCrToday)) + ' Students created today.';
        End Else begin
            hdl9Txt := 'There are No Students created today.';
        end;
        //9 end
        //10 start
        Usersetup1.Get(UserId);
        PortalUser.Reset();
        PortalUser.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        PortalUser.SetRange("Created On", Today);
        if PortalUser.FindSet() then begin
            CountPortalUsrCrToday := PortalUser.Count();
            hdl10Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountPortalUsrCrToday)) + ' Portal users created today.';
        End Else begin
            hdl10Txt := 'There are No Portal users created today.';
        end;
        //10 end
    end;
}
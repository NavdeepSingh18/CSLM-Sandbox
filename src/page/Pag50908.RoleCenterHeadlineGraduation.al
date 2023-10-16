page 50908 RoleCenterHeadlineGraduation
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
                    DegreeAudit.reset();
                    DegreeAudit.SetRange("Document Status", DegreeAudit."Document Status"::"Pending for Verification");
                    if DegreeAudit.findset() then begin
                        Page.RunModal(page::"Degree Audit list", DegreeAudit);//50893
                    end;
                end;
            }
            field(Headline31; hdl3Txt) // for Assigned Task List
            {
                DrillDown = false;
                Visible = false;
                // trigger OnDrillDown()
                // begin
                //     DegreeAudit.reset();
                //     DegreeAudit.SetRange("Document Status", DegreeAudit."Document Status"::"Pending for Verification");
                //     if DegreeAudit.findset() then begin
                //         Page.RunModal(page::"Degree Audit list", DegreeAudit);//50893
                //     end;
                // end;
            }
            field(Headline41; hdl4Txt) // for eligible student list
            {
                DrillDown = true;

                trigger OnDrillDown()
                begin
                    Usersetup1.get(UserId);
                    StudentMaster.reset();
                    // StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
                    StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                    StudentMaster.SetFilter(Status, '%1', 'PENDGRAD');
                    if StudentMaster.findset() then begin
                        Page.RunModal(Page::"Student Details-CS", StudentMaster);//50296
                    end;
                end;
            }
            field(Headline51; hdl5Txt) // for Pending Degree/Transcript Printing Request
            {
                DrillDown = false;
                Visible = false;
                // trigger OnDrillDown()
                // begin
                //     Usersetup1.Get(UserId);
                //     WithdrwlStd.Reset();
                //     WithdrwlStd.SetRange("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
                //     if WithdrwlStd.FindSet() then begin
                //         Page.RunModal(page::"Stud. Withdrawal-CS", WithdrwlStd);//50171
                //     end;
                // end;
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
        StudentMaster: Record "Student Master-CS";
        // WithdrwlStd: Record "Withdrawal Student-CS";
        // StudentWiseHold: Record "Student Wise Holds";
        EducationSetup: Record "Education Setup-CS";
        DegreeAudit: Record "Degree Audit";
        UserGreetingVisible: Boolean;
        DefaultFieldsVisible: Boolean;
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";


    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountPendgDegreeAudit: Integer;
        CountAssigndtask: integer;
        CountEligibleStuds: integer;
        CountPendgDegreeTranscriptPrinting: Integer;
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
        DegreeAudit.Reset();
        DegreeAudit.SetRange("Document Status", DegreeAudit."Document Status"::"Pending for Verification");
        if DegreeAudit.FindSet() then begin
            CountPendgDegreeAudit := DegreeAudit.Count();
            hdl2Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountPendgDegreeAudit)) + ' Pending Degree Audits.';
        End Else begin
            hdl2Txt := 'There are No Pending Degree Audit.';
        end;
        //2 end
        //3 start // for Assigned Task List
        // Usersetup1.get(UserId);
        // WithdrwlStd.reset();
        // WithdrwlStd.SetRange("Academic Year", EducationSetup."Academic Year");
        // if WithdrwlStd.findset() then begin
        //     CountAssigndtask := WithdrwlStd.Count();
        //     hdl3Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountAssigndtask)) + ' no of Assigned Tasks.';
        // End Else begin
        //     hdl3Txt := 'There are No Assigned Tasks.';
        // end;
        //3 end
        //4 start
        Usersetup1.get(UserId);
        StudentMaster.reset();
        // StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        StudentMaster.SetFilter(Status, '%1', 'PENDGRAD');
        if StudentMaster.findset() then begin
            CountEligibleStuds := StudentMaster.Count();
            hdl4Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountEligibleStuds)) + ' no of Eligible Students.';
        End Else begin
            hdl4Txt := 'There are No Eligible Students.';
        end;
        //4 end
        //5 start //For pending Degree/Transcript Printing Request
        // Usersetup1.get(UserId);
        // StudentMaster.reset();
        // StudentMaster.SetRange("Academic Year", EducationSetup."Academic Year");
        // StudentMaster.Setfilter("Global Dimension 1 Code", Usersetup1."Global Dimension 1 Code");
        // StudentMaster.SetFilter(Status, '%1', 'Pending Graduate');
        // if StudentMaster.findset() then begin
        // CountPendgDegreeTranscriptPrinting := StudentMaster.Count();
        //     hdl5Txt := 'There are total ' + Headlinesmgnt.Emphasize(Format(CountPendgDegreeTranscriptPrinting)) + ' no of Eligible Students.';
        // End Else begin
        //     hdl5Txt := 'There are No Eligible Students.';
        // end;
        //5 end

    end;
}
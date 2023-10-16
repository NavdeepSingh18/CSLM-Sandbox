page 50994 RoleCenterHdlnEEDBasicScience
{
    Caption = 'Role Center Headline EED Pre- Clinical';
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
                    LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::ELOA);
                    if LeavesApvls.findset() then begin
                        Page.RunModal(Page::"Pending Leaves Approvals", LeavesApvls);//50719
                    end;
                end;
            }
            field("Pending Advising Request List"; hdl4Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                var
                    AdvsngReq: Record "Advising Request";
                    PendingAdvisingReq_Page: Page "Advising Request List";//50846
                    IntOption: Integer;
                    NotAuthLbl: Label 'You are not authorized to access this page.';
                begin
                    Clear(PendingAdvisingReq_Page);
                    // if AdvsngReq.DepartmentIsBasicScience() = true then begin
                    AdvsngReq.Reset();
                    AdvsngReq.SetFilter("Request Status", '%1|%2|%3', AdvsngReq."Request Status"::" ", AdvsngReq."Request Status"::Cancel, AdvsngReq."Request Status"::Pending);
                    // AdvisingRequest.SetRange("Department Type", AdvisingRequest."Department Type"::"EED Basic Science");
                    IntOption := AdvsngReq.ChecDocumentAppDepartment();
                    case IntOption of
                        1:
                            begin
                                AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Pre-Clinical"));
                            end;
                        2:
                            begin
                                AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Clinical"));
                            end;
                        3:
                            begin
                                AdvsngReq.SetFilter("Department Type", '%1|%2', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical");
                            end;
                        4:
                            begin
                                AdvsngReq.Setfilter("Department Type", '%1|%2|%3', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical", AdvsngReq."Department Type"::" ");
                            end;
                        0:
                            begin
                                Error(NotAuthLbl);
                            end;
                    end;
                    if AdvsngReq.FindSet() then begin
                        PendingAdvisingReq_Page.SetTableView(AdvsngReq);
                        PendingAdvisingReq_Page.SetRecord(AdvsngReq);
                        PendingAdvisingReq_Page.RunModal();
                    end;
                    // end;
                end;
            }
            field("Approved Advising Request List"; hdl5Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                var
                    AdvsngReq: Record "Advising Request";
                    ApprovedAdvisingReq_Page: Page "App. Resch. Advs. Request List";//51016
                    IntOption: Integer;
                    NotAuthLbl: Label 'You are not authorized to access this page.';
                begin
                    Clear(ApprovedAdvisingReq_Page);
                    // if AdvsngReq.DepartmentIsBasicScience() = true then begin
                    AdvsngReq.Reset();
                    AdvsngReq.SetRange("Request Status", AdvsngReq."Request Status"::Approved);
                    // AdvisingRequest.SetFilter("Department Type", format(AdvisingRequest."Department Type"::"EED Basic Science"));
                    IntOption := AdvsngReq.ChecDocumentAppDepartment();
                    case IntOption of
                        1:
                            begin
                                AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Pre-Clinical"));
                            end;
                        2:
                            begin
                                AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Clinical"));
                            end;
                        3:
                            begin
                                AdvsngReq.SetFilter("Department Type", '%1|%2', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical");
                            end;
                        4:
                            begin
                                AdvsngReq.Setfilter("Department Type", '%1|%2|%3', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical", AdvsngReq."Department Type"::" ");
                            end;
                        0:
                            begin
                                Error(NotAuthLbl);
                            end;
                    end;
                    if AdvsngReq.FindSet() then begin
                        ApprovedAdvisingReq_Page.SetTableView(AdvsngReq);
                        ApprovedAdvisingReq_Page.SetRecord(AdvsngReq);
                        ApprovedAdvisingReq_Page.Runmodal();
                    end;
                    // end;
                end;
            }
            field("Rejected/Completed Advising Request List"; hdl6Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                var
                    AdvsngReq: Record "Advising Request";
                    RejCompAdvisingReq_Page: Page "Rejc. Comp. Advis. Req. List";//51017
                    IntOption: Integer;
                    NotAuthLbl: Label 'You are not authorized to access this page.';
                begin
                    Clear(RejCompAdvisingReq_Page);
                    // if AdvsngReq.DepartmentIsBasicScience() = true then begin
                    AdvsngReq.Reset();
                    AdvsngReq.SetFilter("Request Status", '%1|%2|%3', AdvsngReq."Request Status"::Rejected, AdvsngReq."Request Status"::Rescheduled, AdvsngReq."Request Status"::Completed);
                    // AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Basic Science"));
                    IntOption := AdvsngReq.ChecDocumentAppDepartment();
                    case IntOption of
                        1:
                            begin
                                AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Pre-Clinical"));
                            end;
                        2:
                            begin
                                AdvsngReq.SetFilter("Department Type", format(AdvsngReq."Department Type"::"EED Clinical"));
                            end;
                        3:
                            begin
                                AdvsngReq.SetFilter("Department Type", '%1|%2', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical");
                            end;
                        4:
                            begin
                                AdvsngReq.Setfilter("Department Type", '%1|%2|%3', AdvsngReq."Department Type"::"EED Clinical", AdvsngReq."Department Type"::"EED Pre-Clinical", AdvsngReq."Department Type"::" ");
                            end;
                        0:
                            begin
                                Error(NotAuthLbl);
                            end;
                    end;
                    if AdvsngReq.FindSet() then begin
                        RejCompAdvisingReq_Page.SetTableView(AdvsngReq);
                        RejCompAdvisingReq_Page.SetRecord(AdvsngReq);
                        RejCompAdvisingReq_Page.RunModal();
                    end;
                    // end;
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
        Usersetup1: Record "User Setup";
        LeavesApvls: Record "Leaves Approvals";
        EducationSetup: Record "Education Setup-CS";
        WithrawalStudent: Record "Withdrawal Student-CS";
        AdvisingRequest: Record "Advising Request";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";


    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        Headlinesmgnt: Codeunit Headlines;
        CountPngELOAApps: integer;
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
        LeavesApvls.SetRange("Type of Leaves", LeavesApvls."Type of Leaves"::ELOA);
        if LeavesApvls.FindSet() then begin
            CountPngELOAApps := LeavesApvls.Count();
            hdl3Txt := 'There are ' + Headlinesmgnt.Emphasize(Format(CountPngELOAApps)) + ' Pending ELOA Applications.';
        End Else begin
            hdl3Txt := 'There are No Pending ELOA Applications.';
        end;
        //3 end
    end;
}
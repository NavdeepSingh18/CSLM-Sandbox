page 50960 RoleCenterHeadlineClinical
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
                Style = Favorable;
            }

            field(headline11; hdl1Txt)
            {

            }
            field(Headline21; hdl2Txt)
            {
                DrillDown = true;
                Style = Favorable;
                Visible = false;
                // trigger OnDrillDown()
                // begin
                //     UserSetup.get(UserId);
                //     StudentMaster.reset();
                //     StudentMaster.Setfilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                //     StudentMaster.Setfilter("Clinical Documents to Validate", '>%1', 0);
                //     if StudentMaster.findset() then
                //         Page.RunModal(Page::"Clinical Document Updation", StudentMaster);//50867
                // end;
            }
            field(Headline31; hdl3Txt)
            {
                DrillDown = true;
                Style = Favorable;
                trigger OnDrillDown()
                var
                    //DrillDownPageId = "UNVClkshpSite_DateApprovalLST";//50482
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                begin
                    ClerkshipSiteAndDateSelection.Reset();
                    ClerkshipSiteAndDateSelection.FilterGroup(2);
                    ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::"Pending for Approval");
                    ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                    ClerkshipSiteAndDateSelection.FilterGroup(2);
                    Page.RunModal(Page::"UNVClkshpSite_DateApprovalLST", ClerkshipSiteAndDateSelection);
                end;
            }
            field(Headline41; hdl4Txt)
            {
                DrillDown = true;
                Style = Favorable;
                trigger OnDrillDown()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.FilterGroup(2);
                    RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Open);
                    RotationOfferApplication.FilterGroup(0);
                    Page.RunModal(Page::"Elective Appln Confirmation", RotationOfferApplication);//50456
                end;
            }
            field(Headline51; hdl5Txt)
            {
                DrillDown = true;
                Style = Favorable;
                trigger OnDrillDown()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.FilterGroup(2);
                    RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Confirmed);
                    RotationOfferApplication.SetRange("Approval Status", RotationOfferApplication."Approval Status"::"Pending for Approval");
                    RotationOfferApplication.FilterGroup(0);
                    Page.RunModal(Page::"Rotation Appl Approval List", RotationOfferApplication);//50456
                end;
            }
            field(Headline61; hdl6Txt)
            {
                DrillDown = true;
                Visible = false;
                trigger OnDrillDown()
                begin
                    UserSetup.get(UserId);
                    StudentMaster.reset();
                    StudentMaster.Setfilter("Global Dimension 1 Code", '9000');
                    if StudentMaster.findset() then
                        Page.RunModal(Page::"Rotation GAP Analysis", StudentMaster);//50925
                end;
            }
            field(Headline91; hdl9Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    UserSetup.get(UserId);
                    SpclAccommodationApplication.reset();
                    SpclAccommodationApplication.SetRange("Send for Approval", true);
                    SpclAccommodationApplication.SetRange("Approval Status", SpclAccommodationApplication."Approval Status"::"Pending for Approval");
                    if SpclAccommodationApplication.findset() then
                        Page.RunModal(Page::"Spl Accommodation Approval", SpclAccommodationApplication);//50547
                end;
            }
            field(FMIMRotation; hdl7Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                var
                    RSH: Record "Roster Scheduling Header";
                    RotationPage: Page "FM1_IM1 Roster Publish LST";
                begin
                    RSH.Reset();
                    RSH.FilterGroup(2);
                    RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::"FM1/IM1");
                    RSH.SetRange(Status, RSH.Status::Scheduled);
                    RSH.SetFilter("Start Date", '%1..%2', 0D, EndDate);
                    RSH.FilterGroup(0);
                    RotationPage.SetTableView(RSH);
                    RotationPage.RunModal();
                end;
            }
            field(CoreRotation; hdl8Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                var
                    RSH: Record "Roster Scheduling Header";
                    RotationPage: Page "Core Roster Publish List";
                begin
                    RSH.Reset();
                    RSH.FilterGroup(2);
                    RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Core);
                    RSH.SetRange(Status, RSH.Status::Scheduled);
                    RSH.SetRange("Rotation Confirmed", true);
                    RSH.SetFilter("Start Date", '%1..%2', 0D, EndDate);
                    RSH.FilterGroup(0);
                    RotationPage.SetTableView(RSH);
                    RotationPage.RunModal();
                end;
            }
            field(ElectiveRotation; hd28Txt)
            {
                DrillDown = true;
                trigger OnDrillDown()
                var
                    RSH: Record "Roster Scheduling Header";
                    RotationPage: Page "Elective Rotation Publish";
                begin
                    RSH.Reset();
                    RSH.FilterGroup(2);
                    RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Elective);
                    RSH.SetRange(Status, RSH.Status::Scheduled);
                    RSH.SetFilter("Start Date", '%1..%2', 0D, EndDate);
                    RSH.FilterGroup(0);
                    RotationPage.SetTableView(RSH);
                    RotationPage.RunModal();
                end;
            }
        }
    }

    var
        StudentMaster: Record "Student Master-CS";
        SpclAccommodationApplication: Record "Spcl Accommodation Application";
        EducationSetup: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";
        hdl1Txt: Text[200];
        hdl2Txt: Text[200];
        hdl3Txt: Text[200];
        hdl4Txt: Text[200];
        hdl5Txt: Text[200];
        hdl6Txt: Text[200];
        hdl7Txt: Text[200];
        hdl8Txt: Text[200];
        hdl9Txt: Text[200];
        hd28Txt: Text[200];
        EndDate: Date;

    trigger OnOpenPage()
    var
        EduCalendar: Record "Education Calendar-CS";
        EduCalendarLines: Record "Education Calendar Entry-CS";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        RotationOfferApplication: Record "Rotation Offer Application";
        RSH: Record "Roster Scheduling Header";
        Headlinesmgnt: Codeunit Headlines;
        DocforReviewCount: integer;
        EleRotAppCount: Integer;
        FMIMCount: Integer;
        CoreCount: Integer;
        ElectiveCount: Integer;
        DateV: Text;
        Monthv: Text;
        YearV: text;
    begin
        EndDate := WorkDate() + 45;

        //Greeting Start
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Team Member");
        UserSetup.Reset();
        Usersetup.get(UserId);
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
            if EduCalendarLines.FindFirst() then
                if EduCalendarLines.Holiday then
                    hdl1Txt := 'Today is ' + EduCalendarLines.Description + '.';
        end;
        if hdl1Txt = '' then begin
            Usersetup.get(UserId);
            EduCalendarLines.Reset();
            EduCalendarLines.SetRange(Code, EduCalendar.Code);
            EduCalendarLines.SetFilter(Date, '%1..', Today);
            EduCalendarLines.SetRange(Holiday, true);
            if EduCalendarLines.FindFirst() then begin
                DateV := Format(DATE2DMY(EduCalendarLines.Date, 1));
                Monthv := Format(DATE2DMY(EduCalendarLines.Date, 2));
                YearV := Format(DATE2DMY(EduCalendarLines.Date, 3));
                hdl1Txt := 'Next Holiday At ' + Monthv + '/' + DateV + '/' + YearV + ' For ' + EduCalendarLines.Description + '.';
            end
        end;

        // UserSetup.Get(UserId);
        // StudentMaster.Reset();
        // if UserSetup."Global Dimension 1 Code" <> '' then
        //     StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
        // StudentMaster.SetFilter("Clinical Documents to Validate", '>%1', 0);
        // if StudentMaster.FindSet() then begin
        //     DocApprovalCount := StudentMaster.Count();
        //     hdl2Txt := 'You have ' + Headlinesmgnt.Emphasize(Format(DocApprovalCount)) + ' new documents for approval.';
        // End Else
        //     hdl2Txt := 'There are no new document for approvals.';

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey(Status, Confirmed);
        ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::"Pending for Approval");
        ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
        if ClerkshipSiteAndDateSelection.FindSet() then begin
            DocforReviewCount := ClerkshipSiteAndDateSelection.Count();
            hdl3Txt := 'You have ' + Headlinesmgnt.Emphasize(Format(DocforReviewCount)) + ' FM1/IM1 application for approval.';
        End Else
            hdl3Txt := 'There are no FM1/IM1 application for approval.';

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Open);
        if RotationOfferApplication.FindSet() then begin
            EleRotAppCount := RotationOfferApplication.Count();
            hdl4Txt := 'You have ' + Headlinesmgnt.Emphasize(Format(EleRotAppCount)) + ' new Elective Rotation applications to confirm.';
        End Else
            hdl4Txt := 'There are no new Elective Rotation applications.';

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Confirmed);
        RotationOfferApplication.SetRange("Approval Status", RotationOfferApplication."Approval Status"::"Pending for Approval");
        if RotationOfferApplication.FindSet() then begin
            EleRotAppCount := RotationOfferApplication.Count();
            hdl5Txt := 'You have ' + Headlinesmgnt.Emphasize(Format(EleRotAppCount)) + ' pending Elective Rotation Applications for approval.';
        End Else
            hdl5Txt := 'There are no pending Elective Rotation Applications for approval.';

        SpclAccommodationApplication.Reset();
        SpclAccommodationApplication.SetRange("Send for Approval", true);
        SpclAccommodationApplication.SetRange("Approval Status", SpclAccommodationApplication."Approval Status"::"Pending for Approval");
        if SpclAccommodationApplication.FindSet() then begin
            EleRotAppCount := SpclAccommodationApplication.Count();
            hdl9Txt := 'You have ' + Headlinesmgnt.Emphasize(Format(EleRotAppCount)) + ' Special Accommodation Applications for review.';
        End Else
            hdl9Txt := 'There are no Special Accommodation Applications for review.';
        //9 end

        RSH.Reset();
        RSH.SetCurrentKey("Clerkship Type", "Start Date", Status);
        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::"FM1/IM1");
        RSH.SetRange(Status, RSH.Status::Scheduled);
        RSH.SetFilter("Start Date", '%1..%2', 0D, EndDate);
        FMIMCount := RSH.Count();
        if FMIMCount > 0 then
            hdl7Txt := 'You have ' + Headlinesmgnt.Emphasize(Format(FMIMCount)) + ' FM1/IM1 Rotation(s) to schedule in next 45 days.'
        else
            hdl7Txt := 'No FM1/IM1 Rotation pending to schedule in next 45 days.';

        RSH.Reset();
        RSH.SetCurrentKey("Clerkship Type", "Start Date", Status);
        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Core);
        RSH.SetRange(Status, RSH.Status::Scheduled);
        RSH.SetRange("Rotation Confirmed", true);
        RSH.SetFilter("Start Date", '%1..%2', 0D, EndDate);
        CoreCount := RSH.Count();
        if CoreCount > 0 then
            hdl8Txt := 'You have ' + Headlinesmgnt.Emphasize(Format(CoreCount)) + ' Core Rotation(s) to schedule in next 45 days.'
        else
            hdl8Txt := 'No Core Rotation pending to schedule in next 45 days.';

        RSH.Reset();
        RSH.SetCurrentKey("Clerkship Type", "Start Date", Status);
        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Elective);
        RSH.SetRange(Status, RSH.Status::Scheduled);
        RSH.SetFilter("Start Date", '%1..%2', 0D, EndDate);
        ElectiveCount := RSH.Count();
        if ElectiveCount > 0 then
            hd28Txt := 'You have ' + Headlinesmgnt.Emphasize(Format(ElectiveCount)) + ' Elective Rotation(s) to schedule in next 45 days.'
        else
            hd28Txt := 'No Elective Rotation pending to schedule in next 45 days.';
    end;
}
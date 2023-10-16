page 50939 "Rotation Audit Factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Student Master-CS";
    Caption = 'Rotation Audit';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group("Curriculum Weeks Overview")
            {
                field(LProgram; LProgram)
                {
                    ApplicationArea = All;
                    Caption = 'Program';
                    Style = Favorable;
                }
                field(WeeksScheduled; WeeksScheduled)
                {
                    ApplicationArea = All;
                    Caption = 'Weeks Scheduled';
                    Style = Favorable;
                }
                field(WeeksPublished; WeeksPublished)
                {
                    ApplicationArea = All;
                    Caption = 'Weeks Published';
                    Style = Favorable;
                }
                field(WeeksFailed; WeeksFailed)
                {
                    ApplicationArea = All;
                    Caption = 'Weeks Failed';
                    Style = Favorable;
                }
                field(CoreWeeksCompleted; CoreWeeksCompleted)
                {
                    ApplicationArea = All;
                    Caption = 'Core Weeks Completed';
                    Style = Favorable;
                }
                field(ElectiveWeekCompleted; ElectiveWeekCompleted)
                {
                    ApplicationArea = All;
                    Caption = 'Elective Week Completed';
                    Style = Favorable;
                }
                field(CredentialDate; CredentialDate)
                {
                    ApplicationArea = All;
                    Caption = 'Credential Date';
                    Style = Favorable;
                }
                field(LSemester; LSemester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                    Style = Favorable;
                }
                field(ClinicalCordinator; ClinicalCordinator)
                {
                    ApplicationArea = All;
                    Caption = 'Clinical Cordinator';
                    Style = Favorable;
                }
                field(FMIMDueDate; FMIMDueDate)
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Caption = 'FM1/IM1 Document Due Date';
                }
                field(FMIMStartDate; FMIMStartDate)
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Caption = 'FM1/IM1 Start Date';
                }
            }
            label("Seperator")
            {
                Caption = '================================';
                ApplicationArea = all;
            }
            group("Student Profile")
            {
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field(ClnWeekRequired; ClnWeekRequired)
                {
                    ApplicationArea = all;
                    Caption = 'Clinical Weeks Required';
                    Style = Unfavorable;
                }
                field(TotalCoreWeek; TotalCoreWeek)
                {
                    ApplicationArea = all;
                    Caption = 'Total Core Weeks';
                    Style = Unfavorable;
                }
                field(TotalElectiveWeek; TotalElectiveWeek)
                {
                    ApplicationArea = all;
                    Caption = 'Total Elective Week';
                    Style = Unfavorable;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field("Alternate Email Address"; Rec."Alternate Email Address")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field(CLNHold; CLNHold)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    Caption = 'Clinical Hold';
                }
            }
        }
    }

    var
        LProgram: Text[100];
        WeeksScheduled: Integer;
        WeeksPublished: Integer;
        WeeksFailed: Integer;
        CredentialDate: Date;
        LSemester: Code[20];
        ClinicalCordinator: Text[100];
        CoreWeeksCompleted: Integer;
        ElectiveWeekCompleted: Integer;
        ClnWeekRequired: Integer;
        TotalCoreWeek: Integer;
        TotalElectiveWeek: Integer;
        CLNHold: Text[5];
        FMIMDueDate: Date;
        FMIMStartDate: Date;

    trigger OnAfterGetRecord()
    var
        CourseMaster: Record "Course Master-CS";
        User: Record User;
        RosterSchedulingLine: Record "Roster Scheduling Line";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        FMIMWeeks: Integer;
    begin
        LProgram := '';
        LSemester := Rec.Semester;
        ClinicalCordinator := '';
        WeeksScheduled := 0;
        WeeksPublished := 0;
        WeeksFailed := 0;
        ClnWeekRequired := 0;
        CoreWeeksCompleted := 0;
        ElectiveWeekCompleted := 0;

        CredentialDate := 0D;
        FMIMDueDate := 0D;
        CLNHold := 'No';

        CredentialDate := Rec."Creation Date";
        Rec.CalcFields("Clinical Hold Exist");

        if Rec."Clinical Hold Exist" then
            CLNHold := 'Yes';

        if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"75" then
            ClnWeekRequired := 75;
        if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"78" then
            ClnWeekRequired := 78;
        if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"84" then
            ClnWeekRequired := 84;
        if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"88" then
            ClnWeekRequired := 88;
        if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"90" then
            ClnWeekRequired := 90;
        if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"94" then
            ClnWeekRequired := 94;

        FMIMWeeks := 0;
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Student No.", Rec."No.");
        RosterSchedulingLine.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type"::"FM1/IM1");
        if RosterSchedulingLine.FindFirst() then
            FMIMWeeks := RosterSchedulingLine."No. of Weeks"
        else
            FMIMWeeks := 8;

        TotalCoreWeek := 44 + FMIMWeeks;
        TotalElectiveWeek := ClnWeekRequired - TotalCoreWeek;

        CourseMaster.Reset();
        if CourseMaster.Get(Rec."Course Code") then
            LProgram := CourseMaster.Description;

        User.Reset();
        User.SetRange("User Name", Rec."Clinical Coordinator");
        if User.FindFirst() then
            ClinicalCordinator := User."Full Name";

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
        ClerkshipSiteAndDateSelection.SetRange("Student No.", Rec."No.");
        if ClerkshipSiteAndDateSelection.FindFirst() then
            FMIMDueDate := ClerkshipSiteAndDateSelection."Document Due Date";

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.");
        RosterSchedulingLine.SetRange("Student No.", Rec."No.");
        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
        if RosterSchedulingLine.FindSet() then
            repeat
                WeeksScheduled += RosterSchedulingLine."No. of Weeks";
            until RosterSchedulingLine.Next() = 0;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.");
        RosterSchedulingLine.SetRange("Student No.", Rec."No.");
        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
        if RosterSchedulingLine.FindSet() then
            repeat
                WeeksPublished += RosterSchedulingLine."No. of Weeks";
            until RosterSchedulingLine.Next() = 0;

        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetCurrentKey("Student ID");
        RosterLedgerEntry.SetRange("Student ID", Rec."No.");
        RosterLedgerEntry.SetFilter("Rotation Grade", '%1|%2', 'F', 'R');
        if RosterLedgerEntry.FindSet() then
            repeat
                WeeksFailed += RosterLedgerEntry."Total No. of Weeks";
            until RosterLedgerEntry.Next() = 0;

        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetCurrentKey("Student ID");
        RosterLedgerEntry.SetRange("Student ID", Rec."No.");
        RosterLedgerEntry.Setfilter("Clerkship Type", '%1|%2', RosterLedgerEntry."Clerkship Type"::"FM1/IM1", RosterLedgerEntry."Clerkship Type"::Core);
        RosterLedgerEntry.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', '', 'F', 'R', 'X', 'UC', 'TC', 'SC');
        if RosterLedgerEntry.FindSet() then
            repeat
                CoreWeeksCompleted += RosterLedgerEntry."Total No. of Weeks";
            until RosterLedgerEntry.Next() = 0;

        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetCurrentKey("Student ID");
        RosterLedgerEntry.SetRange("Student ID", Rec."No.");
        RosterLedgerEntry.SetRange("Clerkship Type", RosterLedgerEntry."Clerkship Type"::Elective);
        RosterLedgerEntry.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', '', 'F', 'R', 'X', 'UC', 'TC', 'SC');
        if RosterLedgerEntry.FindSet() then
            repeat
                ElectiveWeekCompleted += RosterLedgerEntry."Total No. of Weeks";
            until RosterLedgerEntry.Next() = 0;

        FMIMStartDate := 0D;
        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetCurrentKey("Student ID");
        RosterLedgerEntry.SetRange("Student ID", Rec."No.");
        RosterLedgerEntry.Setfilter("Clerkship Type", '%1', RosterLedgerEntry."Clerkship Type"::"FM1/IM1");
        RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
        if RosterLedgerEntry.FindFirst() then
            FMIMStartDate := RosterLedgerEntry."Start Date";
    end;
}
report 50223 "Missing Core V3"
{
    Caption = 'Missing Core V3';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Missing Core V3.rdl';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") where(Status = filter('ATT' | 'PROB' | 'REENTRY' | 'RADM' | 'TEMP' | 'SUS'));

            RequestFilterFields = "No.", Semester, "Academic Year";

            column(Student_Number; "Student Master-CS"."No.")
            {

            }
            column(Last_Name; "Student Master-CS"."Last Name")
            {

            }
            column(First_Name; "Student Master-CS"."First Name")
            {

            }
            column(Student_Mail; "Student Master-CS"."E-Mail Address")
            {

            }
            column(School_Status; "Student Master-CS".Status)
            {

            }
            column(FM1_IM1_End_Date; FM1_IM1_End_Date)
            {

            }
            column(Semester; "Student Master-CS".Semester)
            {

            }
            column(Completed_Weeks; Completed_Weeks)
            {

            }
            column(Current_Rotation; Current_Rotation)
            {

            }
            column(Future_Confirmed; Future_Confirmed)
            {

            }
            column(Total_Core_Weeks; Total_Core_Weeks)
            {

            }
            column(CompName; EducationSetup."Institute Name")
            {

            }
            column(LogImag; EducationSetup."Clinical Science Logo")
            {

            }
            column(Filters; Filters)
            {

            }

            trigger OnPreDataItem()
            var
            // myInt: Integer;
            begin
                Filters := "Student Master-CS".GetFilters;

                if CompInf.Get() then;

                SetRange("Global Dimension 1 Code", '9000');

                // SetFilter(Status, '<>%1|<>%2|<>%3|<>%4', 'GRAD', 'WITH', 'PENDGRAD', 'DIS');

                UserSetup.Reset();
                if UserSetup.Get(UserId) then;

                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                if EducationSetup.FindFirst() then;
                EducationSetup.CalcFields("Clinical Science Logo");
                if EducationSetup."FM1/IM1 Semester Filter" <> '' then
                    ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

                if EducationSetup."Clerkship Semester Filter" <> '' then
                    ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

                IF GetFilter(Semester) = '' then
                    SetFilter(Semester, ClinicalSemester);
                Clear(NotFound);
            end;

            trigger OnAfterGetRecord()
            var
            begin
                NotFound += 1;

                FM1_IM1_End_Date := 0D;

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "Student Master-CS"."No.");
                RosterLedgerEntry.SetRange("Clerkship Type", RosterLedgerEntry."Clerkship Type"::"FM1/IM1");
                RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                if RosterLedgerEntry.FindSet() then
                    FM1_IM1_End_Date := RosterLedgerEntry."End Date";

                Completed_Weeks := 0;
                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "Student Master-CS"."No.");
                RosterLedgerEntry.SetRange("Clerkship Type", RosterLedgerEntry."Clerkship Type"::Core);
                RosterLedgerEntry.SetFilter(Status, '%1|%2|%3', RosterLedgerEntry.Status::Scheduled, RosterLedgerEntry.Status::Published, RosterLedgerEntry.Status::Completed);
                RosterLedgerEntry.SetFilter("End Date", '<%1', WorkDate());
                RosterLedgerEntry.CalcSums("Total No. of Weeks");
                Completed_Weeks := RosterLedgerEntry."Total No. of Weeks";

                Current_Rotation := 0;
                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "Student Master-CS"."No.");
                RosterLedgerEntry.SetRange("Clerkship Type", RosterLedgerEntry."Clerkship Type"::Core);
                RosterLedgerEntry.SetFilter(Status, '%1|%2', RosterLedgerEntry.Status::Scheduled, RosterLedgerEntry.Status::Published);
                RosterLedgerEntry.SetFilter("Start Date", '<=%1', WorkDate());
                RosterLedgerEntry.SetFilter("End Date", '>=%1', WorkDate());
                RosterLedgerEntry.CalcSums("Total No. of Weeks");
                Current_Rotation := RosterLedgerEntry."Total No. of Weeks";

                Future_Confirmed := 0;
                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "Student Master-CS"."No.");
                RosterLedgerEntry.SetRange("Clerkship Type", RosterLedgerEntry."Clerkship Type"::Core);
                RosterLedgerEntry.SetFilter("Start date", '>%1', WorkDate());
                RosterLedgerEntry.SetFilter(Status, '%1|%2', RosterLedgerEntry.Status::Scheduled, RosterLedgerEntry.Status::Published);
                RosterLedgerEntry.CalcSums("Total No. of Weeks");
                Future_Confirmed := RosterLedgerEntry."Total No. of Weeks";

                Total_Core_Weeks := Completed_Weeks + Current_Rotation + Future_Confirmed;
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

    }
    trigger OnPostReport()
    begin
        if NotFound = 0 then
            Message('There is no record with in the given filter(s).');
    end;

    var
        RosterLedgerEntry: Record "Roster Ledger Entry";
        EducationSetup: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        CompInf: Record "Company Information";
        FM1_IM1_End_Date: Date;
        Completed_Weeks: Decimal;
        Future_Confirmed: Decimal;
        Current_Rotation: Decimal;
        Total_Core_Weeks: Decimal;
        ClinicalSemester: Code[1024];
        Filters: Text;
        NotFound: Integer;
}
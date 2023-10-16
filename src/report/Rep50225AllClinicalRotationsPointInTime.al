report 50225 "All Clinical Rotations Point"
{
    Caption = 'All Clinical Rotations Point In Time';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/All Clinical Rotations Point In Time.rdl';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") where("Semester" = filter('CLN5' | 'CLN6' | 'CLN7' | 'CLN8'));
            RequestFilterFields = "No.", Semester, "Course Code", Status;
            column(Student_Number; "Student Master-CS"."No.")
            {

            }

            column(Last_Name; "Student Master-CS"."Last Name")
            {

            }

            column(First_Name; "Student Master-CS"."First Name")
            {

            }
            column(School_Status; "Student Master-CS".Status)
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
            column(Future_Weeks; Future_Weeks)
            {

            }
            column(CRM_Curriculum; Format("Student Master-CS"."Clinical Curriculum"))
            {

            }
            column(Start_Date; CurrStart_Date)
            {

            }
            column(End_Date; CurrEnd_Date)
            {

            }
            column(InstName; EducationSetup."Institute Name")
            {

            }
            column(LogoImage; EducationSetup."Clinical Science Logo")
            {

            }
            column(HospitalName; HospitalName)
            {

            }
            column(TotalClinicalWeeks; TotalClinicalWeeks)
            {

            }
            column(WeeksLessThanCurriculum; WeeksLessThanCurriculum)
            {

            }
            column(Start_DateTo; Start_Date)
            {

            }
            column(End_DateFrom; End_Date)
            {

            }


            trigger OnPreDataItem()
            begin
                UserSetup.Reset();
                if UserSetup.Get(UserId) then;

                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup.FindFirst() then;

                SetFilter(Status, EducationSetup."Active Statuses");

                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                if EducationSetup.FindFirst() then;
                EducationSetup.CalcFields("Clinical Science Logo");




                if EducationSetup."FM1/IM1 Semester Filter" <> '' then
                    ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

                if EducationSetup."Clerkship Semester Filter" <> '' then
                    ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

                // Reset();
                // FilterGroup(2);
                SetFilter(Semester, ClinicalSemester);
                if UserSetup."Clinical Administrator" = false then
                    SetRange("Clinical Coordinator", UserId);
                // FilterGroup(0);

                window.Open('Total Count ##1##########\\' + 'Line Count ###2############');
                Window.Update(1, "Student Master-CS".Count);
            end;

            trigger OnAfterGetRecord()
            begin

                LineCount += 1;
                Window.Update(2, LineCount);

                Completed_Weeks := 0;
                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetRange("Student No.", "Student Master-CS"."No.");
                RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Completed);
                if RosterSchedulingLine.FindSet() then
                    repeat
                        Completed_Weeks += RosterSchedulingLine."No. of Weeks";
                    until RosterSchedulingLine.Next() = 0;


                Current_Rotation := 0;
                CurrStart_Date := 0D;
                CurrEnd_Date := 0D;
                Future_Weeks_2 := 0;
                HospitalName := '';
                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "Student Master-CS"."No.");
                RosterLedgerEntry.SetFilter("Start Date", '<=%1', WorkDate());
                RosterLedgerEntry.SetFilter("end Date", '>=%1', WorkDate());
                if RosterLedgerEntry.FindSet() then
                    repeat
                        HospitalName := RosterLedgerEntry."Hospital Name";
                        CurrStart_Date := RosterLedgerEntry."Start Date";
                        CurrEnd_Date := RosterLedgerEntry."End Date";
                        Current_Rotation += RosterLedgerEntry."Total No. of Weeks";
                        if WorkDate() < RosterLedgerEntry."End Date" then
                            Future_Weeks_2 += Round((RosterLedgerEntry."End Date" - WorkDate()) / 7, 1, '=');
                    until RosterLedgerEntry.Next() = 0;




                Future_Weeks := 0;
                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetRange("Student No.", "Student Master-CS"."No.");
                RosterSchedulingLine.SetFilter("start date", '>%1', WorkDate());
                RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Published, RosterSchedulingLine.Status::Scheduled);
                if RosterSchedulingLine.FindSet() then
                    repeat
                        Future_Weeks += RosterSchedulingLine."No. of Weeks";
                    until RosterSchedulingLine.Next() = 0;
                Future_Weeks := Future_Weeks + Future_Weeks_2;

                TotalClinicalWeeks := 0;
                TotalClinicalWeeks := Completed_Weeks + Current_Rotation + Future_Weeks;
            end;
        }
    }

    // requestpage
    // {

    //     SaveValues = true;
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group("Option")
    //             {
    //                 field("Start Date"; Start_Date)
    //                 {
    //                     ApplicationArea = All;
    //                     Caption = 'Start Date';

    //                 }
    //                 field("End Date"; End_Date)
    //                 {
    //                     ApplicationArea = All;
    //                     Caption = 'End Date';
    //                 }
    //                 field(WeeksLessThan_Curriculum; WeeksLessThanCurriculum)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Weeks Less Than Curriculum';
    //                 }
    //             }
    //         }
    //     }

    // }
    var
        RosterLedgerEntry: Record "Roster Ledger Entry";
        RosterSchedulingLine: Record "Roster Scheduling Line";
        EducationSetup: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        Window: Dialog;
        Completed_Weeks: Decimal;
        Current_Rotation: Decimal;
        Future_Weeks: Decimal;
        Future_Weeks_2: Decimal;
        Start_Date: Date;
        End_Date: Date;
        CurrStart_Date: Date;
        CurrEnd_Date: Date;
        TotalClinicalWeeks: Decimal;
        ClinicalSemester: Code[1024];
        HospitalName: text;
        WeeksLessThanCurriculum: Boolean;
        LineCount: Integer;
}
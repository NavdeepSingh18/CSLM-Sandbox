report 50281 MissingClinicalRotationV2
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'MissingClinicalRotationV2';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = where(semester = filter('BSIC|CLN5|CLN6|CLN7|CLN8|CLN9|CLN10|CLN11'));
            RequestFilterFields = "Global Dimension 1 Code", "Academic Year", Semester;
            trigger OnPreDataItem()
            var
            begin
                IF (MissingClinical = false) and (AllClinicalRotation = false) and (TotalWeekLessThen = false) then
                    error('Please Select One Option To View the Report');

                TempExcelBuffer.AddColumn('Student Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('LastName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FirstName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('School Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                IF MissingClinical then
                    TempExcelBuffer.AddColumn('CRM Semester', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('Semester', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('SIS Semester', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                IF AllClinicalRotation = False then begin
                    TempExcelBuffer.AddColumn('Residency', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                end;
                TempExcelBuffer.AddColumn('Completed Weeks', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Current Rotations', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Hospital', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                IF MissingClinical = true then begin
                    TempExcelBuffer.AddColumn('Rotation Start Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Rotation End Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                end else
                    if AllClinicalRotation = true then begin
                        TempExcelBuffer.AddColumn('Start Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('End Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    end;
                TempExcelBuffer.AddColumn('Future Weeks', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                IF AllClinicalRotation = false then
                    TempExcelBuffer.AddColumn('Total Clinical Weeks', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CRM Curriculum', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            End;

            trigger OnAfterGetRecord()
            var
            // myInt: Integer;
            begin
                Clear(CurrentRotations);
                Clear(CompletedWeeks);
                Clear(FutureWeeks);
                Clear(TotalWeeks);
                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "No.");
                RosterLedgerEntry.SetFilter(Status, '%1|%2', RosterLedgerEntry.Status::Completed, RosterLedgerEntry.Status::Published);
                IF NOT RosterLedgerEntry.FindFirst() then
                    CurrReport.Skip();

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetCurrentKey("Student ID", Status);
                RosterLedgerEntry.SetRange("Student ID", "No.");
                RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Completed);
                IF RosterLedgerEntry.FindSet() then
                    repeat
                        // RosterLedgerEntry.CalcSums("Total No. of Weeks");
                        CompletedWeeks += RosterLedgerEntry."Total No. of Weeks";
                    until RosterLedgerEntry.Next() = 0;
                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetCurrentKey("Student ID", Status, "Start Date", "End Date");
                RosterLedgerEntry.SetRange("Student ID", "No.");
                RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Published);
                RosterLedgerEntry.SetFilter("Start Date", '<=%1', Today);
                RosterLedgerEntry.SetFilter("End Date", '>=%1', Today);
                IF RosterLedgerEntry.FindSet() then
                    repeat
                        CurrentRotations += RosterLedgerEntry."Total No. of Weeks";
                    until RosterLedgerEntry.Next() = 0;

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetCurrentKey("Student ID", Status, "Start Date", "End Date");
                RosterLedgerEntry.SetRange("Student ID", "No.");
                RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Published);
                RosterLedgerEntry.SetFilter("Start Date", '>%1', Today);
                IF RosterLedgerEntry.FindSet() then
                    repeat
                        // RosterLedgerEntry.CalcSums("Total No. of Weeks");
                        FutureWeeks += RosterLedgerEntry."Total No. of Weeks";
                    until RosterLedgerEntry.Next() = 0;

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetCurrentKey("Student ID", Status, "Start Date", "End Date");
                RosterLedgerEntry.SetRange("Student ID", "No.");
                RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Published);
                RosterLedgerEntry.SetFilter("Start Date", '<=%1', Today);
                RosterLedgerEntry.SetFilter("End Date", '>=%1', Today);
                RosterLedgerEntry.SetAscending("Start Date", true);
                IF RosterLedgerEntry.FindLast() then;

                Residency.Reset();
                Residency.SetRange("Student No.", "No.");
                IF Residency.FindFirst() then;

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Semester, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                IF AllClinicalRotation = False then begin
                    TempExcelBuffer.AddColumn(Residency."Residency Year", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Residency."Residency Status", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                end;
                TempExcelBuffer.AddColumn(CompletedWeeks, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CurrentRotations, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                IF CurrentRotations > 0 then
                    TempExcelBuffer.AddColumn(RosterLedgerEntry."Hospital Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                IF TotalWeekLessThen = false then begin
                    IF CurrentRotations > 0 then begin
                        TempExcelBuffer.AddColumn(RosterLedgerEntry."Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(RosterLedgerEntry."End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    end
                    else begin
                        TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    end;
                end;
                TempExcelBuffer.AddColumn(FutureWeeks, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                IF AllClinicalRotation = False then begin
                    RosterLedgerEntry.Reset();
                    RosterLedgerEntry.SetCurrentKey("Student ID", Status);
                    RosterLedgerEntry.SetRange("Student ID", "No.");
                    RosterLedgerEntry.SetFilter(Status, '%1|%2', RosterLedgerEntry.Status::Published, RosterLedgerEntry.Status::Completed);
                    IF RosterLedgerEntry.FindSet() then
                        repeat
                            // RosterLedgerEntry.CalcSums("Total No. of Weeks");
                            TotalWeeks += RosterLedgerEntry."Total No. of Weeks";
                        until RosterLedgerEntry.Next() = 0;
                    TempExcelBuffer.AddColumn(TotalWeeks, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                end;
                TempExcelBuffer.AddColumn("Clinical Curriculum", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
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
                    field("Missing Clinical Rotation V2"; MissingClinical)
                    {
                        ApplicationArea = All;

                    }
                    field("All Clinical Rotations Point in Time"; AllClinicalRotation)
                    {
                        ApplicationArea = All;

                    }
                    field("Total Weeks Less Than Curriculum"; TotalWeekLessThen)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        IF MissingClinical then begin
            TempExcelBuffer.CreateNewBook('Missing Clinical Rotation V2');
            TempExcelBuffer.WriteSheet('Missing Clinical Rotation V2', CompanyName, UserId);
            TempExcelBuffer.CloseBook();
            TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Missing Clinical Rotation V2_%1_%2', CurrentDateTime, UserId));
            TempExcelBuffer.OpenExcel();
        end else
            if AllClinicalRotation then begin
                TempExcelBuffer.CreateNewBook('All Clinical Rotations Point in Time');
                TempExcelBuffer.WriteSheet('All Clinical Rotations Point in Time', CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo('All Clinical Rotations Point in Time_%1_%2', CurrentDateTime, UserId));
                TempExcelBuffer.OpenExcel();
            end else
                if TotalWeekLessThen then begin
                    TempExcelBuffer.CreateNewBook('Total Weeks Less Than Curriculum');
                    TempExcelBuffer.WriteSheet('Total Weeks Less Than Curriculum', CompanyName, UserId);
                    TempExcelBuffer.CloseBook();
                    TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Total Weeks Less Than Curriculum_%1_%2', CurrentDateTime, UserId));
                    TempExcelBuffer.OpenExcel();
                end;
    end;

    var
        StudentMaster: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Residency: Record Residency;
        AllClinicalRotation: Boolean;
        TotalWeekLessThen: Boolean;
        MissingClinical: Boolean;
        CompletedWeeks: Integer;
        CurrentRotations: Integer;
        FutureWeeks: Integer;
        TotalWeeks: Integer;
    // StudentList: Label 'Missing Clinical Rotation V2';
    // ExcelFileName: Label 'Missing Clinical Rotation V2_%1_%2';
}
report 50278 "Roster Ledger R Grade Report"
{
    ApplicationArea = all;
    UsageCategory = Administration;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")
        {
            DataItemTableView = WHERE("Rotation Grade" = FILTER('R'), "Clerkship Type" = const(Core));
            trigger OnPreDataItem()
            var
            begin
                TempExcelBuffer.Reset();
                TempExcelBuffer.DeleteAll();
                TempExcelBuffer.NewRow();

                TempExcelBuffer.AddColumn('Rotation ID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Student ID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Student Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Hospital ID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Hospital Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Course Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Course Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnAfterGetRecord()
            var
                RosterLedgerEntry: Record "Roster Ledger Entry";
            begin

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "Roster Ledger Entry"."Student ID");
                RosterLedgerEntry.SetRange("Course Code", "Roster Ledger Entry"."Course Code");
                RosterLedgerEntry.SetFilter("Rotation Grade", '%1|%2|%3|%4|%5|%6', 'A', 'B', 'C', 'P', 'H', 'HP');
                if NOT RosterLedgerEntry.FindFirst() then begin
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn("Roster Ledger Entry"."Rotation ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Roster Ledger Entry"."Student ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Roster Ledger Entry"."Student Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Roster Ledger Entry"."Hospital ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Roster Ledger Entry"."Hospital Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Roster Ledger Entry"."Course Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Roster Ledger Entry"."Course Description", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                end else
                    CurrReport.Skip();
            end;
        }

    }
    trigger OnPostReport()
    var
    //myInt: Integer;
    begin
        TempExcelBuffer.CreateNewBook(StudentList);
        TempExcelBuffer.WriteSheet(StudentList, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StudentList: Label 'RosterLedger';
        ExcelFileName: Label 'RosterLedgerList';
}
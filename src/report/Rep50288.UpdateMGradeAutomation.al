// report 50288 "Update M Grade Rotations"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     ProcessingOnly = True;
//     Caption = 'M_Grade_Automation';
//     dataset
//     {
//         dataitem("Roster Ledger Entry"; "Roster Ledger Entry")
//         {
//             DataItemTableView = where(Status = filter(<> Cancelled), "Rotation Grade" = filter(''));
//             trigger OnPreDataItem()
//             var

//                 Day: integer;
//                 Week: integer;
//                 year: integer;
//             begin
//                 Day := Date2DWY(Today, 1);
//                 week := Date2DWY(Today, 2);
//                 year := Date2DWY(Today, 3);

//                 IF Day < 5 then
//                     FilterEndDate := DWY2Date(5, week - 1, year)
//                 else
//                     FilterEndDate := DWY2Date(5, week, year);

//                 "Roster Ledger Entry".SetFilter("End Date", '%1..%2', 0D, FilterEndDate);
//                 // TempExcelBuffer.Reset();
//                 // TempExcelBuffer.DeleteAll();
//                 // TempExcelBuffer.AddColumn('Entry No.', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Rotation ID', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Rotation No', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Hospital ID', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Hospital Name', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Student ID', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Student Name', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Enrollment No.', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Clerkship Type', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Course Code', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Course Description', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Start Date', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('End Date', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Status', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('FilterEndDate', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Current Rotaion Grade', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('Upcomming Rotation Grade', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
//             end;

//             trigger OnAfterGetRecord()
//             var
//             begin
//                 "Roster Ledger Entry"."Rotation Grade" := 'M';
//                 "Roster Ledger Entry".Modify();

//                 // TempExcelBuffer.NewRow();
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Entry No.", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Rotation ID", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Rotation No.", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Hospital ID", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Hospital Name", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Student ID", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Student Name", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Enrollment No.", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Clerkship Type", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Course Code", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Course Description", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Start Date", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."End Date", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry".Status, false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn(FilterEndDate, false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn("Roster Ledger Entry"."Rotation Grade", false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);
//                 // TempExcelBuffer.AddColumn('M', false, '', False, false, False, '', TempExcelBuffer."Cell Type"::Text);

//             end;

//             trigger OnPostDataItem()
//             begin
//                 // TempExcelBuffer.CreateNewBook('Update M Grade Rotation');
//                 // TempExcelBuffer.WriteSheet('Update M Grade Rotation', CompanyName, UserId);
//                 // TempExcelBuffer.CloseBook();
//                 // TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Update M Grade Rotation', CurrentDateTime, UserId));
//                 // TempExcelBuffer.OpenExcel();
//             end;
//         }
//     }

//     var
//         // TempExcelBuffer: Record "Excel Buffer" temporary;
//         FilterEndDate: Date;
// }
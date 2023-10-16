report 50196 CurrentandFutureRotations
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Current and Future Rotations';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")
        {
            DataItemTableView = where(Status = filter(Published));
            trigger OnPreDataItem()
            var
            begin
                SetCurrentKey("Student ID", "Start Date");
                SetFilter("End Date", '>=%1', Today);
                TempExcelBuffer.AddColumn('Student Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('LastName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FirstName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('School Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('nID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Start Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('End Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('tName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            End;

            trigger OnAfterGetRecord()
            var
            // myInt: Integer;
            begin
                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then;
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("Student ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StudentMaster.Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Rotation No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn("End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn("Hospital Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            end;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }
    trigger OnPreReport()
    begin
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin

        TempExcelBuffer.CreateNewBook(StudentList);
        TempExcelBuffer.WriteSheet(StudentList, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;

    var
        StudentMaster: Record "Student Master-CS";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StudentList: Label 'Current and Future Rotations';
        ExcelFileName: Label 'Current and Future Rotations_%1_%2';
}
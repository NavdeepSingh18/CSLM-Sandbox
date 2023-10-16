report 50269 "MSPE Weekly Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(MSPE; MSPE)
        {
            trigger OnPreDataItem()
            begin
                TempExcelBuffer.Reset();
                TempExcelBuffer.DeleteAll();
                TempExcelBuffer.AddColumn('Date Filter :', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Format(StartDate) + ' .. ' + Format(EndDate), false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn('Application #', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Application Type', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Last Name', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('First Name', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Student ID#', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Date Received', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Email Address', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FIU Program', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);

                MSPE.SetCurrentKey("Student No");
                MSPE.SetRange("Application Date", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            var
                StudentMaster: REcord "Student Master-CS";
            Begin
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", MSPE."Student No");
                IF StudentMaster.FindFirst() then begin
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn(MSPE."Application No", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(MSPE."Application Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(MSPE."Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(MSPE."First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(StudentMaster."Original Student No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(MSPE."Application Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(MSPE."AUA Email Address", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    IF StudentMaster."Course Code" In ['AUA-GHT', 'FIU - AUA CLINICAL', 'FIUGLOBAL'] then
                        TempExcelBuffer.AddColumn('Yes', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    Else
                        TempExcelBuffer.AddColumn('No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                end;
            End;

            trigger OnPostDataItem()
            begin
                TempExcelBuffer.CreateNewBook('MSPE Weekly Report');
                TempExcelBuffer.WriteSheet('MSPE Weekly Report', CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo('MSPE Weekly Report', CurrentDateTime, UserId));
                TempExcelBuffer.OpenExcel();
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
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    Field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }

    }

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StartDate: Date;
        EndDate: Date;

    Trigger OnPreReport()
    begin
        If StartDate = 0D then
            Error('Please enter Start Date');

        If EndDate = 0D then
            Error('Please enter End Date');
    end;
}
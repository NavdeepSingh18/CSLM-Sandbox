report 50214 ExportSchedule
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Exam Time Table Line-CS"; "Exam Time Table Line-CS")
        {
            trigger OnPreDataItem()
            begin
                TempExcelBuffer.Reset();
                TempExcelBuffer.DeleteAll();
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn('Document No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Line No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Subject Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Student Group', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Exam Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Exam Slot', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


            end;

            trigger OnAfterGetRecord()
            var
            begin

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("Exam Time Table Line-CS"."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Exam Time Table Line-CS"."Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Exam Time Table Line-CS"."Subject Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Exam Time Table Line-CS"."Student Group", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Exam Time Table Line-CS"."Exam Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Exam Time Table Line-CS"."Exam Slot New", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnPostDataItem()
            begin
                TempExcelBuffer.CreateNewBook(ExamList);
                TempExcelBuffer.WriteSheet(ExamList, CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, "Document No."));
                TempExcelBuffer.OpenExcel();
            end;

        }
    }
    var

        TempExcelBuffer: Record "Excel Buffer" temporary;

        AcademicYear: code[20];
        ExamList: Label 'ExamList';
        ExcelFileName: Label 'Exam Schedule %1 - %2';
        Terms: Code[20];

}
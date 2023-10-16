report 50184 "Exam Schedule SLcM To NBME"
{
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("External Exam Line-CS"; "External Exam Line-CS")
        {
            RequestFilterFields = "Exam Schedule No.";
            trigger OnPreDataItem()
            begin
                MakeExcelDataHeader();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelInfo();
            end;
        }
    }

    var
        ExcelBuffer: Record "Excel Buffer";
        CompanyInformation: Record "Company Information";
        ExamScheduleLine: Record "Exam Time Table Line-CS";

    trigger OnPreReport()
    begin
        CompanyInformation.GET();
        ExcelBuffer.DELETEALL();
    end;

    trigger OnPostReport()
    begin
        CreateExcelbook();
    end;


    procedure MakeExcelDataHeader()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Institute Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Subject Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Subject Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Subject Class', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Academic Year', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Exam Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Exam Slot', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Exam Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Start Time', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('End Time', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Student No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Enrollment No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Student Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelInfo()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn("External Exam Line-CS"."Global Dimension 1 Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Subject Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Subject Type", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Subject Class", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Academic Year", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Program", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS".Semester, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Exam Type", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Exam Slot", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Exam Date", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExamScheduleLine.Reset();
        ExamScheduleLine.Setrange("Document No.", "External Exam Line-CS"."Exam Schedule No.");
        ExamScheduleLine.Setrange("Subject Code", "External Exam Line-CS"."Subject Code");
        ExamScheduleLine.Setrange("Exam Date", "External Exam Line-CS"."Exam Date");
        ExamScheduleLine.Setrange("Exam Slot", "External Exam Line-CS"."Exam Slot");
        ExamScheduleLine.Setrange(Batch, "External Exam Line-CS".Batch);
        IF ExamScheduleLine.FindFirst() then begin
            ExcelBuffer.AddColumn(ExamScheduleLine."Start Time", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Time);
            ExcelBuffer.AddColumn(ExamScheduleLine."End Time", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Time);
        end;
        ExcelBuffer.AddColumn("External Exam Line-CS"."Student No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Enrollment No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("External Exam Line-CS"."Student Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        //ExcelBuffer.CreateBook('', CompanyInformation.Name);
        ExcelBuffer.WriteSheet(CompanyInformation.Name, COMPANYNAME, USERID);
        ExcelBuffer.CloseBook();
        ExcelBuffer.OpenExcel();
    end;

}
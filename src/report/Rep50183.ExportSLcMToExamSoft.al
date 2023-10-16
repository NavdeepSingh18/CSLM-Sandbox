report 50183 "Exam Schedule SLcM To ExamSoft"
{
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Internal Exam Line-CS"; "Internal Exam Line-CS")
        {
            DataItemTableView = WHERE("Exam Date" = FILTER(<> 0D));
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
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Global Dimension 1 Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Subject Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Subject Type", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Subject Class", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Academic Year", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Program", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS".Semester, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Exam Type", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Exam Slot", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Exam Date", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExamScheduleLine.Reset();
        ExamScheduleLine.Setrange("Document No.", "Internal Exam Line-CS"."Exam Schedule No.");
        ExamScheduleLine.Setrange("Subject Code", "Internal Exam Line-CS"."Subject Code");
        ExamScheduleLine.Setrange("Exam Date", "Internal Exam Line-CS"."Exam Date");
        ExamScheduleLine.Setrange("Exam Slot", "Internal Exam Line-CS"."Exam Slot");
        ExamScheduleLine.Setrange(Batch, "Internal Exam Line-CS".Batch);
        IF ExamScheduleLine.FindFirst() then begin
            ExcelBuffer.AddColumn(ExamScheduleLine."Start Time", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Time);
            ExcelBuffer.AddColumn(ExamScheduleLine."End Time", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Time);
        end;
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Student No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Enrollment No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Internal Exam Line-CS"."Student Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        //ExcelBuffer.CreateBook('', CompanyInformation.Name + ' - ' + USERID);
        ExcelBuffer.WriteSheet(CompanyInformation.Name, COMPANYNAME, USERID);
        ExcelBuffer.CloseBook();
        ExcelBuffer.OpenExcel();
    end;

}
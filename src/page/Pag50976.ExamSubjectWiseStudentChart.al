
page 50976 "Exam Sub. Wise student"
{
    Caption = 'Exam Subject Wise Student';
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Status Text';
                Visible = false;
                ShowCaption = false;
                ToolTip = 'Specifies the status of the chart.';
            }
            // usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            // {
            //     ApplicationArea = Basic, Suite;

            //     trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
            //     var
            //         studentSubExamList: Record "Student Subject Exam";
            //     begin
            //         StudentSubexamlist.setfilter("Subject Code", '%1|%2|%3|%4|%5|%6|%7|%|8|%9|%10|%11|%12|%13|%14',
            //         '5116ICM1',
            //         '51156OSCE',
            //         '5116CSL',
            //         '5216ICM2',
            //         '5216CLS',
            //         '5216OSCE',
            //         '6326ICM3',
            //         '6326CSL',
            //         '6326OSCE',
            //         '6326WRITE-UP',
            //         '6426ICM4',
            //         '6426CSL',
            //         '6426HARVEY',
            //         '6426OSCEWU');
            //         StudentSubexamlist.SetRange(studentSubExamList."Subject Code", point.XValueString());
            //         if not studentsubexamlist.findset() then
            //             exit;

            //         Page.RunModal(page::"Student Subject Exam List", StudentSubexamlist);
            //         CurrPage.Update();
            //     end;

            //     trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
            //     begin
            //     end;

            //     trigger AddInReady()
            //     begin
            //         if IsChartDataReady then
            //             UpdateChart();
            //     end;

            //     trigger Refresh()
            //     begin
            //         if IsChartDataReady then
            //             UpdateChart();
            //     end;
            // }
        }
    }

    actions
    {
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        UpdateChart();
        IsChartDataReady := true;
    end;

    var
        StatusText: Text[250];
        IsChartDataReady: Boolean;
        SubjectCodeTxt: Label 'Subject';
        StudentCountTxt: Label 'Student No. Count ';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        ExamSubwiseStudent_Q: Query "Exam Sub. wise Student";
        ColumnNumber: Integer;
        studentSubExamList: Record "Student Subject Exam";
    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(StudentCountTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);

        // Define X-Axis
        Rec.SetXAxis(SubjectCodeTxt, Rec."Data Type"::String);
        if not ExamSubwiseStudent_Q.Open() then
            exit;

        while ExamSubwiseStudent_Q.Read() do begin
            Rec.AddColumn(Format(ExamSubwiseStudent_Q.Subject_Code));

            // Y-Axis data            
            Rec.SetValue(StudentCountTxt, ColumnNumber, ExamSubwiseStudent_Q.NoofStudents);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;
}

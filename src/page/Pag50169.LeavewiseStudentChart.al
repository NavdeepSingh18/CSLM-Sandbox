page 50169 "Leave Wise Student Chart"
{
    Caption = 'Leave Wise Student Chart';
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
            //         Student: Record "Student Master-CS";
            //         UserSetup: Record "User Setup";
            //         EducationSetup: Record "Education Setup-CS";
            //     begin
            //         UserSetup.get(UserId());
            //         EducationSetup.reset();
            //         EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            //         if EducationSetup.FindLast() then;
            //         Student.SetRange(Student.Status, point.XValueString());
            //         if not Student.FindSet() then
            //             exit;
            //         PAGE.RunModal(PAGE::"Student Details-CS", Student);
            //         CurrPage.Update();
            //     end;

            //     // trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
            //     // begin
            //     // end;

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
        NoofStudentTxt: Label 'No. of Students';
        StudentStatusTxt: Label 'Student Status';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        LeaveswiseStudent: Query "Leaves wise Student";
        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        StudentCount: Record "Student Master-CS";

    begin
    //     Initialize(); // Initialize .NET variables for the chart

    //     // Define Y-Axis
    //     AddMeasure(NoofStudentTxt, 1, "Data Type"::Integer, "Chart Type"::Column);

    //     // Define X-Axis
    //     SetXAxis(StudentStatusTxt, "Data Type"::String);
    //     UserSetup.get(UserId());
    //     EducationSetup.reset();
    //     EducationSetup.SetCurrentKey("Global Dimension 1 Code");
    //     EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
    //     if EducationSetup.FindLast() then
    //         if UserSetup."Global Dimension 1 Code" <> '' then
    //             if strlen(UserSetup."Global Dimension 1 Code") < 6 then
    //                 LeaveswiseStudent.SetFilter(LeaveswiseStudent.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));
    //     if not LeaveswiseStudent.Open() then
    //         exit;

    //     while LeaveswiseStudent.Read() do begin
    //         // Add data to the chart
    //         AddColumn(Format(LeaveswiseStudent.Status));

    //         // Y-Axis data
    //         SetValue(NoofStudentTxt, ColumnNumber, LeaveswiseStudent.NumberOfStudent);
    //         ColumnNumber += 1;
    //     end;
    //     IsChartDataReady := true;
    end;
}


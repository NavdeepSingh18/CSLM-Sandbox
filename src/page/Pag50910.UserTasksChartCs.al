page 50910 "User Tasks Chart"
{
    Caption = 'User Tasks';
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
            //         UTask: Record "User Task";
            //     begin
            //         if not UTask.FindSet() then
            //             exit;
            //         Page.RunModal(page::"User Task List", UTask);
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
        PercentageCompText: Label '% Complete';
        SubjectCountTxt: Label 'Count of Subject';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        UserTaskQuery: Query "User Tasks";
        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        UserTask: Record "User Task";
    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(SubjectCountTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);

        // Define X-Axis
        Rec.SetXAxis(PercentageCompText, Rec."Data Type"::String);
        UserSetup.get(UserId());

        if not UserTaskQuery.open() then
            exit;

        while UserTaskQuery.Read() do begin
            Rec.AddColumn(Format(UserTaskQuery.Percent_Complete));
            //Y-Axis data
            Rec.SetValue(SubjectCountTxt, ColumnNumber, UserTaskQuery.CountofSubject);
            ColumnNumber += 1;
        end;

        IsChartDataReady := true;
    end;
}


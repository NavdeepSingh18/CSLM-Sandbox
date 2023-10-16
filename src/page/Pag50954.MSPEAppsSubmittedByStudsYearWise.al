page 50954 "MSPE Apps. by Std. year wise"
{
    Caption = 'MSPE Applications submitted by students year wise';
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
            //         MSPERec: Record MSPE;
            //     begin

            //         //if point.XValueString() = '' then
            //         //MSPERec.SetRange(MSPERec."Processing Status", MSPERec."Processing Status"::Pending);

            //         MSPERec.SetRange(MSPERec."Academic Year", point.XValueString());
            //         if not MSPERec.FindSet() then
            //             exit;
            //         Page.RunModal(page::"Pending MSPE Application List", MSPERec);
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
        CountofStudentText: Label 'Count';
        YearTxt: Label 'Year';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        MSPEQuery: Query "MSPE Apps. year wise";
        ColumnNumber: Integer;
        // UserSetup: Record "User Setup";
        MSPE_Rec: Record MSPE;
        UserTask: Record "User Task";
    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(YearTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);

        // Define X-Axis
        Rec.SetXAxis(CountofStudentText, Rec."Data Type"::String);
        // UserSetup.get(UserId());
        //MSPEQuery.setrange(MSPEQuery.Processing_Status);
        //MSPEQuery.SetRange(MSPEQuery.Processing_Status, MSPEQuery.Processing_Status::Pending);
        if not MSPEQuery.open() then
            exit;

        while MSPEQuery.Read() do begin
            Rec.AddColumn(Format(MSPEQuery.Academic_Year));
            //Y-Axis data
            Rec.SetValue(YearTxt, ColumnNumber, MSPEQuery.Countofyear);
            ColumnNumber += 1;
        end;

        IsChartDataReady := true;
    end;
}


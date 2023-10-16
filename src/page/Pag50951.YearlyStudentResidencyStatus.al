page 50951 "Yearly Stud. Residency Status"
{
    Caption = 'Yearly Students Residency Status';
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
            //             usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            //             {
            //                 ApplicationArea = Basic, Suite;

            //                 trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
            //                 var
            //                     StudResidencyStatusList: Record Residency;
            //                     ResidencyStatus: Record "Residency Status";

            //                 begin
            //                     /*
            //                     if point.XValueString() = '' then
            //                         StudResidencyStatusList.SetRange(StudResidencyStatusList."Residency Status", StudResidencyStatusList."Residency Status"::" ");
            //                     if point.XValueString() = 'Pending' then
            //                         StudResidencyStatusList.SetRange(StudResidencyStatusList."Residency Status", StudResidencyStatusList."Residency Status"::Pending);

            //                     if point.xvalueString() = 'No Match' then
            //                         StudResidencyStatusList.SetRange(StudResidencyStatusList."Residency Status", StudResidencyStatusList."Residency Status"::"No Match");

            //                     if point.xvalueString() = 'Match' then
            //                         StudResidencyStatusList.SetRange(StudResidencyStatusList."Residency Status", StudResidencyStatusList."Residency Status"::Match);

            //                     if point.xvalueString() = 'Opted-Out' then
            //                         StudResidencyStatusList.SetRange(StudResidencyStatusList."Residency Status", StudResidencyStatusList."Residency Status"::"Opted-Out");

            //                     if point.xvalueString() = 'Withdrawn' then
            //                         StudResidencyStatusList.SetRange(StudResidencyStatusList."Residency Status", StudResidencyStatusList."Residency Status"::Withdrawn);


            //   */
            //                     ResidencyStatus.reset();
            //                     ResidencyStatus.SetRange("Chart Code", point.XValueString());
            //                     if ResidencyStatus.FindFirst() then
            //                         StudResidencyStatusList.SetRange(StudResidencyStatusList."Residency Status", ResidencyStatus.Code);

            //                     if not StudResidencyStatusList.FindSet() then
            //                         exit;
            //                     Page.RunModal(Page::"Residency List", StudResidencyStatusList);
            //                     CurrPage.Update();

            //                 end;

            //                 trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
            //                 begin
            //                 end;

            //                 trigger AddInReady()
            //                 begin
            //                     if IsChartDataReady then
            //                         UpdateChart();
            //                 end;

            //                 trigger Refresh()
            //                 begin
            //                     if IsChartDataReady then
            //                         UpdateChart();
            //                 end;
            //             }
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
        NRMPResidencyStatus: Label 'NRMP Residency Status';
        NoofResidencyStatusCount: Label 'No of Residency Status Count';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        YearlyStudResiStatus: Query "Yearly Studs. Residency Status";
        ColumnNumber: Integer;
        ResidencyStatus: Record "Residency Status";
    begin

        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(NoofResidencyStatusCount, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);


        // Define X-Axis
        Rec.SetXAxis(NRMPResidencyStatus, Rec."Data Type"::String);

        if not YearlyStudResiStatus.Open() then
            exit;

        //repeat
        //Clear(YearlyStudResiStatus);
        while YearlyStudResiStatus.Read() do begin
            //if ResidencyStatus.Code = YearlyStudResiStatus.Residency_Status then begin
            ResidencyStatus.reset();
            ResidencyStatus.SetRange(Code, YearlyStudResiStatus.Residency_Status);
            if ResidencyStatus.FindFirst() then begin
                Rec.AddColumn(Format(ResidencyStatus."Chart Code"));
                Rec.SetValue(NoofResidencyStatusCount, ColumnNumber, YearlyStudResiStatus.NoofYears);
                ColumnNumber += 1;
            end;
        end;
        // until ResidencyStatus.Next() = 0;
        //SetAscending("Drill-Down X Index");
        //end;
        IsChartDataReady := true;
    end;
}
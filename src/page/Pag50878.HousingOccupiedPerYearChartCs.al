page 50878 "Housing Occupy Per Year"
{
    Caption = 'Housing Occupied per year Chart';
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

            //         HousingAppln: Record "Housing Application";
            //         UserSetup: Record "User Setup";
            //         EducationSetup: Record "Education Setup-CS";
            //     begin
            //         UserSetup.get(UserId());
            //         EducationSetup.reset();
            //         EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            //         if EducationSetup.FindLast() then;

            //         // HousingAppln.SetFilter(HousingAppln."Academic Year", '%1', EducationSetup."Academic Year");
            //         HousingAppln.SetRange(HousingAppln.Status, HousingAppln.Status::Approved);
            //         HousingAppln.SetRange(HousingAppln."Academic Year", point.XValueString());
            //         if not HousingAppln.FindSet() then
            //             exit;
            //         Page.RunModal(Page::"Posted Housing Application", HousingAppln);
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
        HousingOccupanyTxt: Label ' Housing Occupied';
        YearTxt: Label 'Academic Years';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        // CourseinStudent: Query "Course in Student";
        housingOccpancy: Query "Housing Occupancy per year";

        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        // StudentCount: Record "Student Master-CS";
        HousingApp: Record "Housing Application";

    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(HousingOccupanyTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);

        // Define X-Axis
        Rec.SetXAxis(YearTxt, Rec."Data Type"::String);
        UserSetup.get(UserId());
        EducationSetup.reset();
        EducationSetup.SetCurrentKey("Global Dimension 1 Code");
        EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if EducationSetup.FindLast() then
            if UserSetup."Global Dimension 1 Code" <> '' then
                if strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
                    housingOccpancy.SetFilter(housingOccpancy.Academic_Year, '%1', EducationSetup."Academic Year");
                end;

        housingOccpancy.setrange(housingOccpancy.Status, HousingApp.Status::Approved);

        if not housingOccpancy.Open() then
            exit;

        while housingOccpancy.Read() do begin
            Rec.AddColumn(Format(housingOccpancy.Academic_Year));
            Rec.SetValue(HousingOccupanyTxt, ColumnNumber, housingOccpancy.NumberOfHousingOccupancy);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;
}


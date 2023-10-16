page 50906 "Students Fee Generated Or Not"
{
    Caption = 'No. of Students with Fee Generated vs. Fee Not Generated';
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

            //         StudentMasterCS: Record "Student Master-CS";
            //         UserSetup: Record "User Setup";
            //         EducationSetup: Record "Education Setup-CS";
            //     begin
            //         //UpdateGenderinHousingApp();
            //         UserSetup.get(UserId());
            //         EducationSetup.reset();
            //         EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            //         if EducationSetup.FindLast() then;

            //         StudentMasterCS.SetFilter(StudentMasterCS."Academic Year", '%1', EducationSetup."Academic Year");
            //         if point.XValueString() = 'Yes' then
            //             StudentMasterCS.SetRange(StudentMasterCS."Fee Generated", true);

            //         if point.XValueString() = 'No' then
            //             StudentMasterCS.SetRange(StudentMasterCS."Fee Generated", false);


            //         if not StudentMasterCS.FindSet() then
            //             exit;
            //         Page.RunModal(Page::"Student Detail", StudentMasterCS);
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
        HousingOccupanyTxt: Label 'No. of Students with Fee Generated vs. Fee Not Generated';
        GenderTxt: Label 'Fee Generated';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        // CourseinStudent: Query "Course in Student";
        FeeGeneratedORnot: Query "Student With Or Without Fee";

        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
    // StudentCount: Record "Student Master-CS";


    begin

        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(HousingOccupanyTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);


        // Define X-Axis
        Rec.SetXAxis(GenderTxt, Rec."Data Type"::String);
        UserSetup.get(UserId());
        EducationSetup.reset();
        EducationSetup.SetCurrentKey("Global Dimension 1 Code");
        EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if EducationSetup.FindLast() then
            if UserSetup."Global Dimension 1 Code" <> '' then
                if strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
                    FeeGeneratedORnot.SetFilter(FeeGeneratedORnot.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));
                    FeeGeneratedORnot.SetFilter(FeeGeneratedORnot.Academic_Year, '%1', EducationSetup."Academic Year");
                end;


        if not FeeGeneratedORnot.Open() then
            exit;
        while FeeGeneratedORnot.Read() do begin
            Rec.AddColumn(Format(FeeGeneratedORnot.Fee_Generated));

            Rec.SetValue(HousingOccupanyTxt, ColumnNumber, FeeGeneratedORnot.NumberOfHousingOccupancy);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;


}


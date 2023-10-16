page 50909 "Total Degree/Certi Awarded"
{
    Caption = 'Total Degree/Certificate Awarded';
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
            //         StudentDegree: Record "Student Degree";
            //     begin
            //         StudentDegree.SetFilter(DateAwarded, '<>%1', 0D);
            //         // StudentDegree.SetRange("Degree Code", StudentDegree."Degree Code");
            //         StudentDegree.SetRange(StudentDegree."Degree Code", point.XValueString());
            //         if not StudentDegree.FindSet() then
            //             exit;
            //         Page.RunModal(page::"Student Degree", StudentDegree);
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
        DegreeCodeTxt: Label 'Degree';
        StudentCountTxt: Label 'Student No. Count ';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        DegreeOrCertiQuery: Query "Degree or Certi Awarded";
        ColumnNumber: Integer;
        studDegree: Record "Student Degree";
        UserSetup: Record "User Setup";
    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(StudentCountTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);

        // Define X-Axis
        Rec.SetXAxis(DegreeCodeTxt, Rec."Data Type"::String);
        UserSetup.get(UserId());
        // DegreeOrCertiQuery.SetFilter(DegreeOrCertiQuery.DateAwarded, Format(studDegree.DateAwarded));//'<>%1', 0D);//change
        DegreeOrCertiQuery.SetFilter(DegreeOrCertiQuery.DateAwarded, '<>%1', 0D);
        // DegreeOrCertiQuery.SetRange(DegreeOrCertiQuery.Degree_CodeFilter, studDegree."Degree Code");
        if not DegreeOrCertiQuery.Open() then
            exit;

        while DegreeOrCertiQuery.Read() do begin
            Rec.AddColumn(Format(DegreeOrCertiQuery.Degree_Code));

            // Y-Axis data            
            Rec.SetValue(StudentCountTxt, ColumnNumber, DegreeOrCertiQuery.NoofStudents);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;
}


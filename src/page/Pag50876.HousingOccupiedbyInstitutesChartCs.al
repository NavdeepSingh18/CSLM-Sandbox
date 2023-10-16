page 50876 "Housing Occupy by Insti. Code"
{
    Caption = 'Housing Occupied by AUA & AICASA Chart';
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

            //         HousingAppln.SetFilter(HousingAppln."Academic Year", '%1', EducationSetup."Academic Year");
            //         HousingAppln.SetRange(HousingAppln.Status, HousingAppln.Status::Approved);
            //         HousingAppln.SetRange(HousingAppln."Global Dimension 1 Code", point.XValueString());
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
        InstitituteCodeTxt: Label 'Institute Code';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        // CourseinStudent: Query "Course in Student";
        housingOccpancy: Query "Housing Occupancy by Ins.";

        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        // StudentCount: Record "Student Master-CS";
        HousingApp: Record "Housing Application";

    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(HousingOccupanyTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);
        // AddMeasure('<Blank>', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Not Specified', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Male', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Female', 1, "Data Type"::Integer, "Chart Type"::Column);

        //AddMeasure(StudentTxt, 1, "Data Type"::Integer, "Chart Type"::Column);

        // Define X-Axis
        Rec.SetXAxis(InstitituteCodeTxt, Rec."Data Type"::String);
        UserSetup.get(UserId());
        EducationSetup.reset();
        EducationSetup.SetCurrentKey("Global Dimension 1 Code");
        EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if EducationSetup.FindLast() then
            if UserSetup."Global Dimension 1 Code" <> '' then
                if strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
                    // CourseinStudent.SetFilter(CourseinStudent.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));
                    housingOccpancy.SetFilter(housingOccpancy.Academic_Year, '%1', EducationSetup."Academic Year");
                    //housingOccpancy.SetRange(housingOccpancy.Status, HousingApp.Status::Approved);
                end;

        housingOccpancy.setrange(housingOccpancy.Status, HousingApp.Status::Approved);
        //housingOccpancy.SetFilter(housingOccpancy.Academic_Year, '%1', EducationSetup."Academic Year");
        if not housingOccpancy.Open() then
            exit;
        // CourseinStudent.SetFilter(CourseinStudent.Term, '%1', EducationSetup."Even/Odd Semester");
        // CourseinStudent.SetFilter(CourseinStudent.Academic_Year, '%1', EducationSetup."Academic Year");
        // if not CourseinStudent.Open() then
        //     exit;
        while housingOccpancy.Read() do begin
            Rec.AddColumn(Format(housingOccpancy.Global_Dimension_1_Code));
            // while CourseinStudent.Read() do begin
            //     // Add data to the chart
            //     AddColumn(Format(CourseinStudent.Course_Code));

            // Y-Axis data
            // StudentCount.reset();
            // StudentCount.SetRange(StudentCount."Academic Year", EducationSetup."Academic Year");
            // StudentCount.SetRange(Term, EducationSetup."Even/Odd Semester");
            // StudentCount.SetFilter(StudentCount."Global Dimension 1 Code", '%1', UserSetup."Global Dimension 1 Code");
            // StudentCount.SetRange(Gender, StudentCount.Gender::" ");
            // StudentCount.SetRange(StudentCount."Course Code", CourseinStudent.Course_Code);
            // if StudentCount.FindSet() then;
            // SetValue('<Blank>', ColumnNumber, StudentCount.Count);

            // StudentCount.reset();
            // StudentCount.SetRange(StudentCount."Academic Year", EducationSetup."Academic Year");
            // StudentCount.SetRange(Term, EducationSetup."Even/Odd Semester");
            // StudentCount.SetFilter(StudentCount."Global Dimension 1 Code", '%1', UserSetup."Global Dimension 1 Code");
            // StudentCount.SetRange(Gender, StudentCount.Gender::"Not Specified");
            // StudentCount.SetRange(StudentCount."Course Code", CourseinStudent.Course_Code);
            // if StudentCount.FindSet() then;
            // SetValue('Not Specified', ColumnNumber, StudentCount.Count);
            // StudentCount.reset();
            // StudentCount.SetRange(StudentCount."Academic Year", EducationSetup."Academic Year");
            // StudentCount.SetRange(Term, EducationSetup."Even/Odd Semester");
            // StudentCount.SetFilter(StudentCount."Global Dimension 1 Code", '%1', UserSetup."Global Dimension 1 Code");
            // StudentCount.SetRange(Gender, StudentCount.Gender::male);
            // StudentCount.SetRange(StudentCount."Course Code", CourseinStudent.Course_Code);
            // if StudentCount.FindSet() then;
            // SetValue('Male', ColumnNumber, StudentCount.Count); // Y-Axis data

            // StudentCount.reset();
            // StudentCount.SetRange(StudentCount."Academic Year", EducationSetup."Academic Year");
            // StudentCount.SetRange(Term, EducationSetup."Even/Odd Semester");
            // StudentCount.SetFilter(StudentCount."Global Dimension 1 Code", '%1', UserSetup."Global Dimension 1 Code");
            // StudentCount.SetRange(Gender, StudentCount.Gender::Female);
            // StudentCount.SetRange(StudentCount."Course Code", CourseinStudent.Course_Code);
            // if StudentCount.FindSet() then;
            // SetValue('Female', ColumnNumber, StudentCount.Count);
            Rec.SetValue(HousingOccupanyTxt, ColumnNumber, housingOccpancy.NumberOfHousingOccupancy);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;
}


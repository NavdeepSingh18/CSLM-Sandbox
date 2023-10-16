page 50905 "Students opt Living Expenses"
{
    Caption = 'No. of Students opted with Living Expenses';
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

            //         FinancialAID: Record "Financial AID";
            //         UserSetup: Record "User Setup";
            //         EducationSetup: Record "Education Setup-CS";
            //     begin
            //         //UpdateGenderinHousingApp();
            //         UserSetup.get(UserId);
            //         EducationSetup.reset();
            //         EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            //         if EducationSetup.FindLast() then;

            //         // FinancialAID.SetFilter(FinancialAID."Academic Year", '%1', EducationSetup."Academic Year");
            //         FinancialAID.SetRange(FinancialAID.Status, FinancialAID.Status::Approved);
            //         FinancialAID.SetRange(FinancialAID."Living expenses", FinancialAID."Living expenses"::YES);
            //         FinancialAID.SetRange(FinancialAID.Semester, point.XValueString());
            //         if not FinancialAID.FindSet() then
            //             exit;
            //         Page.RunModal(page::FinancialAIDApprovRejectList, FinancialAID);
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
        HousingOccupanyTxt: Label 'No. of Students opted with Living Expenses';
        SemesterTxt: Label 'Semester';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        // CourseinStudent: Query "Course in Student";
        //NoofStudentsoptedwithFA: Query "Student Opted with FA";

        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        Semester: Record "Semester Master-CS";
        FinancialAIDq: Query "Student Opted with Living Exp";

    begin

        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(HousingOccupanyTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);


        // Define X-Axis
        Rec.SetXAxis(SemesterTxt, Rec."Data Type"::String);

        Semester.reset;
        Semester.SetCurrentKey(Sequence);
        if Semester.FindSet() then begin
            repeat

                UserSetup.get(UserId);
                EducationSetup.reset();
                EducationSetup.SetCurrentKey("Global Dimension 1 Code");
                EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                if EducationSetup.FindLast() then
                    if UserSetup."Global Dimension 1 Code" <> '' then
                        if strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
                            FinancialAIDq.SetFilter(FinancialAIDq.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));
                            // FinancialAIDq.SetFilter(FinancialAIDq.Academic_Year, '%1', EducationSetup."Academic Year");
                            //housingOccpancy.SetRange(housingOccpancy.Status, HousingApp.Status::Approved);
                        end;
                FinancialAIDq.SetRange(FinancialAIDq.Status, FinancialAIDq.Status::Approved);
                FinancialAIDq.SetRange(FinancialAIDq.Living_expenses, FinancialAIDq.Living_expenses::YES);
                //housingOccpancy.SetFilter(housingOccpancy.Academic_Year, '%1', EducationSetup."Academic Year");
                if not FinancialAIDq.Open() then
                    exit;
                while FinancialAIDq.Read() do begin
                    if FinancialAIDq.Semester = Semester.Code then begin
                        Rec.AddColumn(Format(FinancialAIDq.Semester));

                        Rec.SetValue(HousingOccupanyTxt, ColumnNumber, FinancialAIDq.NumberOfHousingOccupancy);
                        ColumnNumber += 1;
                    end;
                end;
            until Semester.Next() = 0;
        end;
        IsChartDataReady := true;
    end;
}


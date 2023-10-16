page 50900 "Students opted with FA"
{
    Caption = 'No. of Students opted with FA';
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
            //         StudentMasterCS.SetRange(StudentMasterCS."Financial Aid Approved", true);
            //         StudentMasterCS.SetRange(StudentMasterCS.Semester, point.XValueString());
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
        HousingOccupanyTxt: Label 'Opted with FA';
        SemesterTxt: Label 'Semester Code';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        // CourseinStudent: Query "Course in Student";
        NoofStudentsoptedwithFA: Query "Student Opted with FA";

        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        Semester: Record "Semester Master-CS";


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
                            NoofStudentsoptedwithFA.SetFilter(NoofStudentsoptedwithFA.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));
                            NoofStudentsoptedwithFA.SetFilter(NoofStudentsoptedwithFA.Academic_Year, '%1', EducationSetup."Academic Year");
                            //housingOccpancy.SetRange(housingOccpancy.Status, HousingApp.Status::Approved);
                        end;
                NoofStudentsoptedwithFA.setrange(NoofStudentsoptedwithFA.Financial_Aid_Approved, true);
                //housingOccpancy.SetFilter(housingOccpancy.Academic_Year, '%1', EducationSetup."Academic Year");
                if not NoofStudentsoptedwithFA.Open() then
                    exit;
                while NoofStudentsoptedwithFA.Read() do begin
                    if NoofStudentsoptedwithFA.Semester = Semester.Code then begin
                        Rec.AddColumn(Format(NoofStudentsoptedwithFA.Semester));

                        Rec.SetValue(HousingOccupanyTxt, ColumnNumber, NoofStudentsoptedwithFA.NumberOfHousingOccupancy);
                        ColumnNumber += 1;
                    end;
                end;
            until Semester.Next() = 0;
        end;
        IsChartDataReady := true;
    end;


}


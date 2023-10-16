page 50950 "Students by FA Roster"
{
    Caption = 'No. of Students by FA Roster';
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

            //         if point.XValueString() = ' ' then
            //             StudentMasterCS.SetRange(StudentMasterCS."Type of FA Roster", StudentMasterCS."Type of FA Roster"::" ");

            //         if point.XValueString() = 'COD' then
            //             StudentMasterCS.SetRange(StudentMasterCS."Type of FA Roster", StudentMasterCS."Type of FA Roster"::COD);

            //         if point.XValueString() = 'SFP' then
            //             StudentMasterCS.SetRange(StudentMasterCS."Type of FA Roster", StudentMasterCS."Type of FA Roster"::SFP);
            //         // StudentMasterCS.SetRange(StudentMasterCS."Type of FA Roster", point.XValueString());
            //         if not StudentMasterCS.FindSet() then
            //             exit;
            //         Page.RunModal(Page::"Student Details-CS", StudentMasterCS);
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
        NoofStudentsTxt: Label 'No. of Students';
        TypeofFARosterTxt: Label 'Type of FA Roster';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        NoofStudentsByFARoster: Query "Student by FA Roster";

        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
    // StudentCount: Record "Student Master-CS";
    begin

        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(NoofStudentsTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);


        // Define X-Axis
        Rec.SetXAxis(TypeofFARosterTxt, Rec."Data Type"::String);
        UserSetup.get(UserId());
        EducationSetup.reset();
        EducationSetup.SetCurrentKey("Global Dimension 1 Code");
        EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if EducationSetup.FindLast() then
            if UserSetup."Global Dimension 1 Code" <> '' then
                if strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
                    NoofStudentsByFARoster.SetFilter(NoofStudentsByFARoster.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));
                    // NoofStudentsByFARoster.SetFilter(NoofStudentsByFARoster.Global_Dimension_1_Code, '%1', EducationSetup."Global Dimension 1 Code");
                    // NoofStudentsByFARoster.SetFilter(NoofStudentsByFARoster.Academic_Year, '%1', EducationSetup."Academic Year");
                end;
        // NoofStudentsByFARoster.setrange(NoofStudentsByFARoster.Global_Dimension_1_Code); //sid
        if not NoofStudentsByFARoster.Open() then
            exit;
        while NoofStudentsByFARoster.Read() do begin
            Rec.AddColumn(Format(NoofStudentsByFARoster.Type_of_FA_Roster));

            Rec.SetValue(NoofStudentsTxt, ColumnNumber, NoofStudentsByFARoster.NumberofCountforTypesofFARoster);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;
}


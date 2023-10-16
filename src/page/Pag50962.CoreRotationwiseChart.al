
page 50962 "Core Rotation Wise Stud Chart"
{
    Caption = 'Core Rotation Wise Student Chart';
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Status Text';
                ShowCaption = false;
                ToolTip = 'Specifies the status of the chart.';
            }
            // usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            // {
            //     ApplicationArea = Basic, Suite;

            //     trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
            //     var
            //         RosterSchedulingLine: Record "Roster Scheduling Line";
            //     begin
            //         RosterSchedulingLine.SetFilter(RosterSchedulingLine."Start Date", '<=%1', WorkDate());
            //         RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
            //         RosterSchedulingLine.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type"::Core);
            //         RosterSchedulingLine.SetRange(RosterSchedulingLine."Rotation Confirmed", true);
            //         RosterSchedulingLine.SetRange(RosterSchedulingLine."Course Prefix Code", point.XValueString());
            //         if not RosterSchedulingLine.FindSet() then
            //             exit;
            //         PAGE.RunModal(PAGE::"Confirm Roster Scheduling SP", RosterSchedulingLine);
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
        CoursePrefixCodeTxt: Label 'Course Prefix Code';
        CountofRotationIdTxt: Label 'Count';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Update(CurrPage.BusinessChart);
    end;


    local procedure UpdateData()
    var
        Corerotwisestudent_Q: Query "Core Rot. wise Student";

        ColumnNumber: Integer;
        RosterSchedulingLine_rec: Record "Roster Scheduling Line";
    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(CountofRotationIdTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);
        // Define X-Axis
        Rec.SetXAxis(CoursePrefixCodeTxt, Rec."Data Type"::String);

        //UserSetup.get(UserId());
        // DegreeOrCertiQuery.SetFilter(DegreeOrCertiQuery.DateAwarded, Format(studDegree.DateAwarded));//'<>%1', 0D);//change
        //DegreeOrCertiQuery.SetFilter(DegreeOrCertiQuery.DateAwarded, '<>%1', 0D);
        // DegreeOrCertiQuery.SetRange(DegreeOrCertiQuery.Degree_CodeFilter, studDegree."Degree Code");
        Corerotwisestudent_Q.SetFilter(Corerotwisestudent_Q.Start_Date, '<=%1', WorkDate());
        //Corerotwisestudent_Q.SetFilter(Corerotwisestudent_Q.End_Date, '<=%1', WorkDate());
        Corerotwisestudent_Q.SetRange(Corerotwisestudent_Q.Clerkship_Type, Corerotwisestudent_Q.Clerkship_Type::Core);
        Corerotwisestudent_Q.SetRange(Corerotwisestudent_Q.Status, Corerotwisestudent_Q.Status::Published);
        Corerotwisestudent_Q.SetRange(Corerotwisestudent_Q.Rotation_Confirmed, true);
        if not Corerotwisestudent_Q.Open() then
            exit;

        while Corerotwisestudent_Q.Read() do begin
            Rec.AddColumn(Format(Corerotwisestudent_Q.Course_Prefix_Code));

            // Y-Axis data            
            Rec.SetValue(CountofRotationIdTxt, ColumnNumber, Corerotwisestudent_Q.NoofRotationID);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;
}


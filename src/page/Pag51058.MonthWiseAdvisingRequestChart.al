page 51058 "Compd. Rej. Monnth wise"
{
    Caption = 'Completed or Rejected Advising Request';
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
            //         advisingReq: Record "Advising Request";
            //         StartDate: Date;
            //         EndDate: Date;
            //         IntOption: Integer;
            //         NotAuthLbl: Label 'You are not authorized to access this page.';
            //     begin
            //         StartDate := CalcDate('-CY', WorkDate());
            //         EndDate := CalcDate('CY', workdate());

            //         advisingReq.Reset();
            //         // advisingReq.SetRange("Department Type", advisingReq."Department Type"::"EED Pre-Clinical");
            //         //
            //         IntOption := advisingReq.ChecDocumentAppDepartment();
            //         case IntOption of
            //             1:
            //                 begin
            //                     advisingReq.SetFilter("Department Type", format(advisingReq."Department Type"::"EED Pre-Clinical"));
            //                 end;
            //             2:
            //                 begin
            //                     advisingReq.SetFilter("Department Type", format(advisingReq."Department Type"::"EED Clinical"));
            //                 end;
            //             3:
            //                 begin
            //                     advisingReq.SetFilter("Department Type", '%1|%2', advisingReq."Department Type"::"EED Clinical", advisingReq."Department Type"::"EED Pre-Clinical");
            //                 end;
            //             4:
            //                 begin
            //                     advisingReq.Setfilter("Department Type", '%1|%2|%3', advisingReq."Department Type"::"EED Clinical", advisingReq."Department Type"::"EED Pre-Clinical", advisingReq."Department Type"::" ");
            //                 end;
            //             0:
            //                 begin
            //                     Error(NotAuthLbl);
            //                 end;
            //         end;
            //         //
            //         advisingReq.SetFilter("Request Status", '%1|%2', advisingReq."Request Status"::Completed, advisingReq."Request Status"::Rejected);
            //         advisingReq.SetRange("Meeting Date", StartDate, EndDate);
            //         advisingReq.SetRange("Meeting Month", point.XValueString());
            //         if not advisingReq.FindSet() then
            //             exit;
            //         Page.RunModal(page::"Rejc. Comp. Advis. Req. List", advisingReq);
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
        MonthwiseTxt: Label 'Month';
        ComprejCountTxt: Label 'Completed or Rejected Advising Request';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        monthwiseQuery: Query "Month Wise Advising Request";
        ColumnNumber: Integer;
        StartDate: Date;
        EndDate: Date;
        advisingReq: Record "Advising Request";
        IntOption: Integer;
        NotAuthLbl: Label 'You are not authorized to access this page.';
    begin
        Rec.Initialize(); // Initialize .NET variables for the chart
        StartDate := 0D;
        enddate := 0D;

        // Define Y-Axis
        Rec.AddMeasure(ComprejCountTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);

        StartDate := CalcDate('-CY', WorkDate());
        EndDate := CalcDate('CY', workdate());

        // Define X-Axis
        Rec.SetXAxis(MonthwiseTxt, Rec."Data Type"::String);
        //
        advisingReq.Reset();
        IntOption := advisingReq.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    monthwiseQuery.SetFilter(Department_Type, format(advisingReq."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    monthwiseQuery.SetFilter(Department_Type, format(advisingReq."Department Type"::"EED Clinical"));
                end;
            3:
                begin
                    monthwiseQuery.SetFilter(Department_Type, '%1|%2', advisingReq."Department Type"::"EED Clinical", advisingReq."Department Type"::"EED Pre-Clinical");
                end;
            4:
                begin
                    monthwiseQuery.Setfilter(Department_Type, '%1|%2|%3', advisingReq."Department Type"::"EED Clinical", advisingReq."Department Type"::"EED Pre-Clinical", advisingReq."Department Type"::" ");
                end;
            0:
                begin
                    Error(NotAuthLbl);
                end;
        end;
        //
        monthwiseQuery.SetRange(monthwiseQuery.Meeting_Date, StartDate, enddate);
        monthwiseQuery.SetFilter(monthwiseQuery.Request_Status, '%1|%2', monthwiseQuery.Request_Status::Completed, monthwiseQuery.Request_Status::Rejected);
        // monthwiseQuery.SetRange(monthwiseQuery.Department_Type, monthwiseQuery.Department_Type::"EED Pre-Clinical");

        if not monthwiseQuery.Open() then
            exit;

        while monthwiseQuery.Read() do begin
            // X-Axis data
            Rec.AddColumn(Format(monthwiseQuery.Meeting_Month));

            // Y-Axis data            
            Rec.SetValue(ComprejCountTxt, ColumnNumber, monthwiseQuery.NoofAdvisingRequest);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;

    trigger OnOpenPage()
    var
        advisingReq: Record "Advising Request";
    begin
        advisingReq.Reset();
        if advisingReq.FindSet() then begin
            if advisingReq."Meeting Month" = '' then begin
                repeat
                    if Date2DMY(advisingReq."Meeting Date", 2) = 1 then begin
                        advisingReq."Meeting Month" := 'JANUARY';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 2 then begin
                        advisingReq."Meeting Month" := 'FEBRUARY';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 3 then begin
                        advisingReq."Meeting Month" := 'MARCH';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 4 then begin
                        advisingReq."Meeting Month" := 'APRIL';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 5 then begin
                        advisingReq."Meeting Month" := 'MAY';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 6 then begin
                        advisingReq."Meeting Month" := 'JUNE';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 7 then begin
                        advisingReq."Meeting Month" := 'JULY';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 8 then begin
                        advisingReq."Meeting Month" := 'AUGUST';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 9 then begin
                        advisingReq."Meeting Month" := 'SEPTEMBER';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 10 then begin
                        advisingReq."Meeting Month" := 'OCTOBER';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 11 then begin
                        advisingReq."Meeting Month" := 'NOVEMBER';
                    end;
                    if Date2DMY(advisingReq."Meeting Date", 2) = 12 then begin
                        advisingReq."Meeting Month" := 'DECEMBER';
                    end;
                    advisingReq."Meeting year" := Format(Date2DMY(advisingReq."Meeting Date", 3));
                    advisingReq."Meeting Date text" := Format(advisingReq."Meeting Date");
                    advisingReq.Modify();
                until advisingReq.Next() = 0;
            end;
        end;
    end;
}
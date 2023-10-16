// dotnet//GMCSCOM
// {
//     assembly("Microsoft.Dynamics.Nav.Client.BusinessChart")

//     {
//         // Version = '15.0.0.0';
//         // Culture = 'neutral';
//         // PublicKeyToken = '';
//         type("Microsoft.Dynamics.Nav.Client.BusinessChart.BusinessChartAddIn"; "BusinessChartAddIn")
//         {

//         }
//         type("Microsoft.Dynamics.Nav.Client.BusinessChart.BusinessChartAddIn"; "Microsoft.Dynamics.Nav.Client.BusinessChart")
//         {
//             IsControlAddIn = true;
//         }
//     }
//     assembly(mscorlib)
//     {
//         type(System.DateTime; MyDateTime) { }
//         type(System.IO.File; IoFile)
//         { }
//         type(System.IO.Directory; Directory)
//         { }
//         type(System.IO.Path; IOPath)
//         { }

//     }
// }
page 50761 "Course Wise Student Chart"
{
    Caption = 'Course Wise Student Chart';
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
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = Basic, Suite;

                // trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
                // var

                //     //Course: Record "Course Master-CS";
                //     Student: Record "Student Master-CS";
                //     UserSetup: Record "User Setup";
                //     EducationSetup: Record "Education Setup-CS";
                // begin
                //     UserSetup.get(UserId());
                //     EducationSetup.reset();
                //     EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                //     if EducationSetup.FindLast() then;


                //     Student.SetFilter(Term, '%1', EducationSetup."Even/Odd Semester");
                //     Student.SetFilter(student."Academic Year", '%1', EducationSetup."Academic Year");
                //     Student.SetRange(Student."Course Code", point.XValueString());
                //     if not Student.FindSet() then
                //         exit;
                //     PAGE.RunModal(PAGE::"Student Details-CS", Student);
                //     CurrPage.Update();
                // end;

                // trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
                // begin
                // end;

                trigger AddInReady()
                begin
                    if IsChartDataReady then
                        UpdateChart();
                end;

                trigger Refresh()
                begin
                    if IsChartDataReady then
                        UpdateChart();
                end;
            }
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
        StudentTxt: Label 'Student';
        CourseCodeTxt: Label 'Course Code';

    local procedure UpdateChart()
    begin
        UpdateData();
        Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        CourseinStudent: Query "Course in Student";

        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        StudentCount: Record "Student Master-CS";

    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis
        Rec.AddMeasure(StudentTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);
        // AddMeasure('<Blank>', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Not Specified', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Male', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Female', 1, "Data Type"::Integer, "Chart Type"::Column);

        //AddMeasure(StudentTxt, 1, "Data Type"::Integer, "Chart Type"::Column);

        // Define X-Axis
        Rec.SetXAxis(CourseCodeTxt, Rec."Data Type"::String);
        UserSetup.get(UserId());
        EducationSetup.reset();
        EducationSetup.SetCurrentKey("Global Dimension 1 Code");
        EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if EducationSetup.FindLast() then
            if UserSetup."Global Dimension 1 Code" <> '' then
                if strlen(UserSetup."Global Dimension 1 Code") < 6 then
                    CourseinStudent.SetFilter(CourseinStudent.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));

        CourseinStudent.SetFilter(CourseinStudent.Term, '%1', EducationSetup."Even/Odd Semester");
        CourseinStudent.SetFilter(CourseinStudent.Academic_Year, '%1', EducationSetup."Academic Year");
        if not CourseinStudent.Open() then
            exit;

        while CourseinStudent.Read() do begin
            // Add data to the chart
            Rec.AddColumn(Format(CourseinStudent.Course_Code));

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

            Rec.SetValue(studentTxt, ColumnNumber, CourseinStudent.NumberOfStudent);
            ColumnNumber += 1;
        end;
        IsChartDataReady := true;
    end;
}


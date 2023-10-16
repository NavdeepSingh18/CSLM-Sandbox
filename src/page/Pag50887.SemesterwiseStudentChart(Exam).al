
page 50887 "Sem. Wise Stud.Chart(Exam)"
{
    Caption = 'Sem. Wise Stud. Chart (Exam)';
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

            //         Student: Record "Student Master-CS";
            //         UserSetup: Record "User Setup";
            //         EducationSetup: Record "Education Setup-CS";
            //     begin
            //         UserSetup.get(UserId);
            //         EducationSetup.reset();
            //         EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            //         if EducationSetup.FindLast() then;


            //         //Message(Format(point.Measures));

            //         Student.SetFilter(Term, '%1', EducationSetup."Even/Odd Semester");
            //         Student.SetFilter(student."Academic Year", '%1', EducationSetup."Academic Year");
            //         Student.SetRange(Student.Semester, point.XValueString);
            //         if not Student.FindSet() then
            //             exit;
            //         PAGE.RunModal(PAGE::"Student Details-CS", Student);
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
        StudentTxt: Label 'Student';
        SemesterTxt: Label 'Semester';

    local procedure UpdateChart()
    begin
        UpdateData();
        // Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        Semester: Record "Semester Master-CS";
        StudentCount: Record "Student Master-CS";
        SemesterinStudent: Query "Semester in Student";
        ColumnNumber: Integer;
    begin
        Rec.Initialize(); // Initialize .NET variables for the chart

        // Define Y-Axis

        // AddMeasure('<Blank>', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Not Specified', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Male', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Female', 1, "Data Type"::Integer, "Chart Type"::Column);
        Rec.AddMeasure(StudentTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);
        // Define X-Axis
        Rec.SetXAxis(SemesterTxt, Rec."Data Type"::String);
        UserSetup.get(UserId);
        Semester.reset();
        Semester.SetCurrentKey(Sequence);
        Semester.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Semester.SetRange("Show Cue in Exam RoleCenter ", true);
        if Semester.FindSet() then begin
            repeat
                EducationSetup.reset();
                EducationSetup.SetCurrentKey("Global Dimension 1 Code");
                EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                if EducationSetup.FindLast() then
                    if UserSetup."Global Dimension 1 Code" <> '' then
                        if strlen(UserSetup."Global Dimension 1 Code") < 6 then
                            SemesterinStudent.SetFilter(SemesterinStudent.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));

                //SemesterinStudent.SetFilter(SemesterinStudent.Term, '%1', EducationSetup."Even/Odd Semester");
                //SemesterinStudent.SetFilter(SemesterinStudent.Academic_Year, '%1', EducationSetup."Academic Year");
                if not SemesterinStudent.Open() then
                    exit;

                while SemesterinStudent.Read() do begin
                    //Add data to the chart
                    if SemesterinStudent.Semester = Semester.Code then begin
                        Rec.AddColumn(Format(SemesterinStudent.Semester)); // X-Axis data
                                                                           //SetValue(StudentTxt, ColumnNumber, 0);

                        Rec.SetValue(StudentTxt, ColumnNumber, SemesterinStudent.NumberOfStudent);

                        // StudentCount.reset();
                        // StudentCount.SetRange(StudentCount."Academic Year", EducationSetup."Academic Year");
                        // StudentCount.SetRange(Term, EducationSetup."Even/Odd Semester");
                        // StudentCount.SetFilter(StudentCount."Global Dimension 1 Code", '%1', UserSetup."Global Dimension 1 Code");
                        // StudentCount.SetRange(Gender, StudentCount.Gender::" ");
                        // StudentCount.SetRange(Semester, Semester.Code);
                        // if StudentCount.FindSet() then;
                        // SetValue('<Blank>', ColumnNumber, StudentCount.Count);

                        // StudentCount.reset();
                        // StudentCount.SetRange(StudentCount."Academic Year", EducationSetup."Academic Year");
                        // StudentCount.SetRange(Term, EducationSetup."Even/Odd Semester");
                        // StudentCount.SetFilter(StudentCount."Global Dimension 1 Code", '%1', UserSetup."Global Dimension 1 Code");
                        // StudentCount.SetRange(Gender, StudentCount.Gender::"Not Specified");
                        // StudentCount.SetRange(Semester, Semester.Code);
                        // if StudentCount.FindSet() then;
                        // SetValue('Not Specified', ColumnNumber, StudentCount.Count);

                        // StudentCount.reset();
                        // StudentCount.SetRange(StudentCount."Academic Year", EducationSetup."Academic Year");
                        // StudentCount.SetRange(Term, EducationSetup."Even/Odd Semester");
                        // StudentCount.SetFilter(StudentCount."Global Dimension 1 Code", '%1', UserSetup."Global Dimension 1 Code");
                        // StudentCount.SetRange(Gender, StudentCount.Gender::male);
                        // StudentCount.SetRange(Semester, Semester.Code);
                        // if StudentCount.FindSet() then;
                        // SetValue('Male', ColumnNumber, StudentCount.Count); // Y-Axis data

                        // StudentCount.reset();
                        // StudentCount.SetRange(StudentCount."Academic Year", EducationSetup."Academic Year");
                        // StudentCount.SetRange(Term, EducationSetup."Even/Odd Semester");
                        // StudentCount.SetFilter(StudentCount."Global Dimension 1 Code", '%1', UserSetup."Global Dimension 1 Code");
                        // StudentCount.SetRange(Gender, StudentCount.Gender::Female);
                        // StudentCount.SetRange(Semester, Semester.Code);
                        // if StudentCount.FindSet() then;
                        // SetValue('Female', ColumnNumber, StudentCount.Count);
                        ColumnNumber += 1;
                    end;
                end;
            until Semester.Next() = 0;
        end;
        IsChartDataReady := true;
    end;
}


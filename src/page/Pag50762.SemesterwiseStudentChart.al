
page 50762 "Semester Wise Student Chart"
{
    Caption = 'Semester Wise Student Chart';
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
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = Basic, Suite;

                // trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
                // var

                //     Student: Record "Student Master-CS";
                //     // UserSetup: Record "User Setup";
                //     EducationSetup: Record "Education Setup-CS";
                // begin
                //     // UserSetup.get(UserId);
                //     EducationSetup.reset();
                //     // EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                //     if EducationSetup.FindFirst() then;


                //     //Message(Format(point.Measures));

                //     Student.SetRange(Term, EducationSetup."Even/Odd Semester");
                //     Student.SetRange(student."Academic Year", EducationSetup."Academic Year");
                //     Student.SetRange(Student.Semester, point.XValueString);
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
        SemesterTxt: Label 'Semester';

    local procedure UpdateChart()
    begin
        UpdateData();
        Rec.Update(CurrPage.BusinessChart);
    end;

    local procedure UpdateData()
    var
        //SemesterinStudent: Query "Semester in Student";
        SemesterinStudent: Record "Course Sem. Master-CS";
        ColumnNumber: Integer;
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        Semester: Record "Semester Master-CS";
        SemesterCourse: Record "Course Sem. Master-CS";
        StudentCount: Record "Student Master-CS";
        SemesterRec: Record "Course Sem. Master-CS";
        EduSetup: Record "Education Setup-CS";

        StudentList: Record "Student Master-CS";
    begin
        SemesterRec.Reset();
        if SemesterRec.FindSet() then begin
            Repeat
                if SemesterRec."Student No. Count" <> 0 then begin
                    SemesterRec."Student No. Count" := 0;
                    SemesterRec.Modify();
                end;
            until SemesterRec.next() = 0;
        end;

        EduSetup.Reset();
        if EduSetup.FindFirst() then begin
            SemesterRec.Reset();
            SemesterRec.SetRange(Term, EduSetup."Even/Odd Semester");
            SemesterRec.SetRange("Academic Year", EduSetup."Academic Year");
            //SemesterRec.SetRange("Global Dimension 1 Code", EduSetup."Global Dimension 1 Code");
            if SemesterRec.FindSet() then begin
                Repeat
                    StudentList.reset();
                    SemesterRec.SetRange(Term, EduSetup."Even/Odd Semester");
                    StudentList.SetRange("Academic Year", EduSetup."Academic Year");
                    StudentList.SetRange(Semester, SemesterRec."Semester Code");
                    if StudentList.findset() then begin
                        SemesterRec."Student No. Count" := StudentList.Count();
                        SemesterRec.Modify();
                    end;
                until SemesterRec.next() = 0;
            end;
        end;

        Rec.Initialize(); // Initialize .NET variables for the chart
        // Define Y-Axis
        // AddMeasure('<Blank>', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Not Specified', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Male', 1, "Data Type"::Integer, "Chart Type"::Column);
        // AddMeasure('Female', 1, "Data Type"::Integer, "Chart Type"::Column);
        Rec.AddMeasure(StudentTxt, 1, Rec."Data Type"::Integer, Rec."Chart Type"::Column);
        // Define X-Axis
        Rec.SetXAxis(SemesterTxt, Rec."Data Type"::String);

        // SemesterCourse.Reset();
        // SemesterCourse.SetCurrentKey("Course Code", "Semester Code", "Sequence No");
        // SemesterCourse.SetAscending("Sequence No");
        // SemesterCourse.SetRange();
        // Semester.reset();
        // Semester.SetCurrentKey("Global Dimension 1 Code", Sequence);
        // Semester.SetAscending("Global Dimension 1 Code", false);
        // if Semester.FindSet() then begin
        //     repeat
        // UserSetup.get(UserId);
        // EducationSetup.reset();
        // EducationSetup.SetCurrentKey("Global Dimension 1 Code");
        // EducationSetup.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        // if EducationSetup.FindLast() then
        //     if UserSetup."Global Dimension 1 Code" <> '' then
        //         if strlen(UserSetup."Global Dimension 1 Code") < 6 then
        //             SemesterinStudent.SetFilter(SemesterinStudent.Global_Dimension_1_Code, '%1', Format(UserSetup."Global Dimension 1 Code"));

        //SemesterinStudent.SetFilter(SemesterinStudent.Term, '%1', EducationSetup."Even/Odd Semester");
        //SemesterinStudent.SetFilter(SemesterinStudent.Academic_Year, '%1', EducationSetup."Academic Year");
        //if not SemesterinStudent.Open() then
        //    exit;

        SemesterinStudent.Reset();
        SemesterinStudent.SetCurrentKey("Course Code", "Sequence No");
        SemesterinStudent.SetFilter("Student No. Count", '<>%1', 0);
        if SemesterinStudent.FindSet() then begin
            repeat
                //Add data to the chart
                //if SemesterinStudent.Semester = Semester.Code then begin
                Rec.AddColumn(Format(SemesterinStudent."Semester Code")); // X-Axis data
                                                                          //SetValue(StudentTxt, ColumnNumber, 0);

                Rec.SetValue(StudentTxt, ColumnNumber, SemesterinStudent."Student No. Count");

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
            until SemesterinStudent.Next() = 0;
        end;

        //until semester.Next() = 0;
        //end;
        IsChartDataReady := true;
    end;
}

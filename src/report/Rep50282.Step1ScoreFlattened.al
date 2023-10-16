report 50282 Step1ScoreFlattened
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Step1 Scores Flattened';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            // DataItemTableView = where(semester = filter('BSIC|CLN5|CLN6|CLN7|CLN8|CLN9|CLN10|CLN11'));
            RequestFilterFields = "Global Dimension 1 Code", "Academic Year", Semester;
            trigger OnPreDataItem()
            var
            begin
                TempExcelBuffer.AddColumn('Student Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('LastName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FirstName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('End Sem 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Opt Out Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('End BSIC', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Test Date 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Score 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Pass / Fail 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 1 Test Date 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Score 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Pass / Fail 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 1 Test Date 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Score 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Pass / Fail 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 1 Test Date 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Score 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Pass / Fail 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 1 Test Date 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Score 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Pass / Fail 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 1 Test Date 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Score 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 1 Pass / Fail 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

            End;

            trigger OnAfterGetRecord()
            var
                StudentSubExam: Record "Student Subject Exam";
                StudentSubject: Record "Main Student Subject-CS";
                CheckCount: Integer;
            begin
                StudentSubExam.Reset();
                StudentSubExam.SetRange("Student No.", "No.");
                StudentSubExam.SetRange("Score Type", StudentSubExam."Score Type"::"STEP 1");
                IF NOT StudentSubExam.FindFirst() then
                    CurrReport.Skip();
                StudentSubject.Reset();
                StudentSubject.SetRange("Student No.", "No.");
                StudentSubject.SetRange(Semester, 'MED4');
                StudentSubExam.SetFilter("End Date", '<>0D');
                IF StudentSubject.FindFirst() then;

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                IF StudentSubject."End Date" <> 0D then
                    TempExcelBuffer.AddColumn(StudentSubject."End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                StudentSubject.Reset();
                StudentSubject.SetRange("Student No.", "No.");
                StudentSubject.SetRange(Semester, 'BSIC');
                StudentSubExam.SetFilter("End Date", '<>0D');
                IF StudentSubject.FindFirst() then
                    TempExcelBuffer.AddColumn(StudentSubject."End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                CheckCount := 0;
                StudentSubExam.Reset();
                StudentSubExam.SetCurrentKey("Student No.", "Exam Sequence", "Score Type");
                StudentSubExam.SetRange("Student No.", "No.");
                StudentSubExam.SetRange("Score Type", StudentSubExam."Score Type"::"STEP 1");
                StudentSubExam.SetAscending("Exam Sequence", true);
                IF StudentSubExam.FindFirst() then
                    repeat
                        CheckCount += 1;
                        TempExcelBuffer.AddColumn(StudentSubExam."Sitting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(StudentSubExam.Total, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(StudentSubExam.Result, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    Until StudentSubExam.Next() = 0;
                IF (CheckCount < 6) then begin
                    repeat
                        CheckCount += 1;
                        TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    until CheckCount = 6;
                end;
            end;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 // field("Missing Clinical Rotation V2"; MissingClinical)
    //                 // {
    //                 //     ApplicationArea = All;

    //                 // }

    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }
    trigger OnPreReport()
    begin
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin

        TempExcelBuffer.CreateNewBook('Step 1 Score Flattened');
        TempExcelBuffer.WriteSheet('Step 1 Score Flattened', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Step 1 Score Flattened_%1_%2', CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();

    end;

    var
        StudentMaster: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Residency: Record Residency;
        AllClinicalRotation: Boolean;
        TotalWeekLessThen: Boolean;
        MissingClinical: Boolean;
        CompletedWeeks: Integer;
        CurrentRotations: Integer;
        FutureWeeks: Integer;
}
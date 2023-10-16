report 50283 Step2CKScoreFlattened
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Step2  CK Scores Flattened';
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
                // TempExcelBuffer.AddColumn('End Sem 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Opt Out Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('End BSIC', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Test Date 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Score 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Pass / Fail 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 2 CK Test Date 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Score 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Pass / Fail 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 2 CK Test Date 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Score 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Pass / Fail 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 2 CK Test Date 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Score 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Pass / Fail 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 2 CK Test Date 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Score 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Pass / Fail 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Step 2 CK Test Date 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Score 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Step 2 CK Pass / Fail 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                WindowDialog.Open('Fetching Students\' + Text001Lbl);
            End;

            trigger OnAfterGetRecord()
            var
                StudentSubExam: Record "Student Subject Exam";
                StudentSubject: Record "Main Student Subject-CS";
                CourseMaster: Record "Course Master-CS";
                StudentMAster: Record "Student Master-CS";
                CourseFilter: Text;
                CheckCount: Integer;
            begin
                StudentSubExam.Reset();
                StudentSubExam.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                StudentSubExam.SetRange("Score Type", StudentSubExam."Score Type"::"Step 2 CK");
                IF NOT StudentSubExam.FindFirst() then
                    CurrReport.Skip();

                CourseFilter := '';
                If "Student Master-CS".GetFilter("Global Dimension 1 Code") = '9000' then begin
                    CourseMaster.Reset();
                    CourseMaster.SetRange("Global Dimension 1 Code", "Student Master-CS".GetFilter("Global Dimension 1 Code"));
                    CourseMaster.SetRange("Transcript Data Filter", true);
                    IF CourseMaster.Findset() then begin
                        repeat
                            IF CourseFilter = '' then
                                CourseFilter := CourseMaster.Code
                            Else
                                CourseFilter += '|' + CourseMaster.Code;
                        until CourseMaster.Next() = 0;
                    End;
                    StudentMaster.Reset();
                    StudentMaster.SetCurrentKey("Enrollment Order");
                    StudentMAster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    StudentMaster.SetFilter("Course Code", CourseFilter);
                    IF StudentMaster.FindLast() then;
                end;
                If "Student Master-CS".GetFilter("Global Dimension 1 Code") = '9100' then begin
                    StudentMaster.Reset();
                    StudentMaster.SetCurrentKey("Enrollment Order");
                    StudentMAster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    StudentMAster.SetRange("Course Code", "Student Master-CS"."Course Code");
                    IF StudentMaster.FindLast() then;
                end;

                CheckCount := 0;
                StudentSubExam.Reset();
                StudentSubExam.SetCurrentKey("Student No.", "Exam Sequence");
                StudentSubExam.SetAscending("Exam Sequence", false);
                StudentSubExam.SetRange("Original Student No.", StudentMAster."Original Student No.");
                StudentSubExam.SetRange("Score Type", StudentSubExam."Score Type"::"Step 2 CK");
                IF StudentSubExam.findset() then
                    repeat
                        If (StudentSubExam.Total <> 0) Or (StudentSubExam.Result <> StudentSubExam.Result::" ") then begin

                            CheckCount += 1;
                            IF CheckCount = 1 then begin
                                TempExcelBuffer.NewRow();
                                TempExcelBuffer.AddColumn(StudentMAster."Original Student No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(StudentMAster."Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(StudentMAster."First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            end;
                            TempExcelBuffer.AddColumn(StudentSubExam."Sitting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                            TempExcelBuffer.AddColumn(StudentSubExam.Total, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn(StudentSubExam.Result, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        end;
                    Until StudentSubExam.Next() = 0;

                IF CheckCount = 0 then
                    CurrReport.Skip();

                IF (CheckCount = 6) then begin
                    repeat
                        CheckCount -= 1;
                        TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    until CheckCount = 0;
                end;

                Ctr += 1;
                WindowDialog.Update(1, StudentMAster."Original Student No." + ' - ' + format(Ctr));
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

        TempExcelBuffer.CreateNewBook('Step 2 CK Score Flattened');
        TempExcelBuffer.WriteSheet('Step 2 CK Score Flattened', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Step 2 CK Score Flattened_%1_%2', CurrentDateTime, UserId));
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
        Text001Lbl: Label 'Students No.     ############1################\';
        WindowDialog: Dialog;
        Ctr: Integer;
        CtrTot: Integer;
}
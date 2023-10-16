report 50234 "CCSE Scores Flattened "
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'CCSE Scores Flattened ';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") order(ascending);
            trigger OnPreDataItem()
            var
            begin
                "Student Master-CS".SetCurrentKey("Enrollment Order");
                "Student Master-CS".SetAscending("Enrollment Order", False);
                TempExcelBuffer.AddColumn('Student Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Last Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('First Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Student Email', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Student Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Student Program/Course', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 7', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 7', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 8', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 8', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 9', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 9', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 10', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 10', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 11', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 11', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 12', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 12', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 13', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 13', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 14', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 14', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 15', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 15', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 16', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 16', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 17', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 17', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 18', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 18', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 19', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 19', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Test Date 20', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CCSE Score 20', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnAfterGetRecord()
            var
                StudentSubjectExam: Record "Student Subject Exam";
                StudentSubjectExam1: array[30] of Record "Student Subject Exam";
                RecCustPostGroup: Record "Customer Posting Group";
                CourseMasterCs: Record "Course Master-CS";
                OriginalStudentID: Code[20];
                PreValue1: Integer;
                SourceCode1: array[30] of Decimal;
                SittingDate: array[30] of date;
            begin
                StudentSubjectExam.Reset();
                StudentSubjectExam.SetRange(StudentSubjectExam."Student No.", "No.");
                StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSE);
                IF Not StudentSubjectExam.FindFirst() Then
                    CurrReport.Skip();

                IF OriginalStudentID <> "Student Master-CS"."Original Student No." then begin
                    OriginalStudentID := "Student Master-CS"."Original Student No.";

                    StudentSubjectExam.Reset();
                    StudentSubjectExam.SetRange(StudentSubjectExam."Student No.", "No.");
                    StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSE);
                    StudentSubjectExam.SetRange("Sitting Date", StartDate, EndDate);
                    IF Not StudentSubjectExam.FindFirst() Then
                        CurrReport.Skip();

                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn("Student Master-CS"."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."E-Mail Address", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."Course Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    Clear(SourceCode1);
                    StudentSubjectExam1[1].Reset();
                    StudentSubjectExam1[1].SetRange(StudentSubjectExam1[1]."Student No.", "No.");
                    StudentSubjectExam1[1].SetFilter(StudentSubjectExam1[1]."Subject Code", 'CCSE1');
                    StudentSubjectExam1[1].SetFilter("Sitting Date", '<=%1', EndDate);
                    //StudentSubjectExam1[1].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[1].SetRange(StudentSubjectExam1[1]."Score Type", StudentSubjectExam1[1]."Score Type"::CCSE);
                    IF StudentSubjectExam1[1].FindFirst() then
                        repeat
                            SourceCode1[1] := StudentSubjectExam1[1].Total;
                            SittingDate[1] := StudentSubjectExam1[1]."Sitting Date";
                        until StudentSubjectExam1[1].Next() = 0;

                    IF SittingDate[1] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[1], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                    IF SourceCode1[1] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[1], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                    StudentSubjectExam1[2].Reset();
                    StudentSubjectExam1[2].SetRange(StudentSubjectExam1[2]."Student No.", "No.");
                    StudentSubjectExam1[2].SetRange(StudentSubjectExam1[2]."Subject Code", 'CCSE2');
                    //StudentSubjectExam1[2].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[2].SetRange(StudentSubjectExam1[2]."Score Type", StudentSubjectExam1[2]."Score Type"::CCSE);
                    StudentSubjectExam1[2].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[2].FindFirst() then
                        repeat
                            SourceCode1[2] := StudentSubjectExam1[2].Total;
                            SittingDate[2] := StudentSubjectExam1[2]."Sitting Date";
                        until StudentSubjectExam1[2].Next() = 0;

                    IF SittingDate[2] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[2], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[2] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[2], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[3].Reset();
                    StudentSubjectExam1[3].SetRange(StudentSubjectExam1[3]."Student No.", "No.");
                    StudentSubjectExam1[3].SetRange(StudentSubjectExam1[3]."Subject Code", 'CCSE3');
                    //StudentSubjectExam1[3].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[3].SetFilter("Sitting Date", '<=%1', EndDate);
                    StudentSubjectExam1[3].SetRange(StudentSubjectExam1[3]."Score Type", StudentSubjectExam1[3]."Score Type"::CCSE);
                    IF StudentSubjectExam1[3].FindFirst() then
                        repeat
                            SourceCode1[3] := StudentSubjectExam1[3].total;
                            SittingDate[3] := StudentSubjectExam1[3]."Sitting Date";
                        until StudentSubjectExam1[3].Next() = 0;

                    IF SittingDate[3] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[3], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);



                    IF SourceCode1[3] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[3], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[4].Reset();
                    StudentSubjectExam1[4].SetRange(StudentSubjectExam1[4]."Student No.", "No.");
                    StudentSubjectExam1[4].SetRange(StudentSubjectExam1[4]."Subject Code", 'CCSE4');
                    //StudentSubjectExam1[4].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[4].SetRange(StudentSubjectExam1[4]."Score Type", StudentSubjectExam1[4]."Score Type"::CCSE);
                    StudentSubjectExam1[4].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[4].FindFirst() then
                        repeat
                            SourceCode1[4] := StudentSubjectExam1[4].total;
                            SittingDate[4] := StudentSubjectExam1[4]."Sitting Date";
                        until StudentSubjectExam1[4].Next() = 0;

                    IF SittingDate[4] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[4], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[4] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[4], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                    StudentSubjectExam1[5].Reset();
                    StudentSubjectExam1[5].SetRange(StudentSubjectExam1[5]."Student No.", "No.");
                    StudentSubjectExam1[5].SetRange(StudentSubjectExam1[5]."Subject Code", 'CCSE5');
                    //StudentSubjectExam1[5].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[5].SetRange(StudentSubjectExam1[5]."Score Type", StudentSubjectExam1[5]."Score Type"::CCSE);
                    StudentSubjectExam1[5].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[5].FindFirst() then
                        repeat
                            SourceCode1[5] := StudentSubjectExam1[5].total;
                            SittingDate[5] := StudentSubjectExam1[5]."Sitting Date";
                        until StudentSubjectExam1[5].Next() = 0;

                    IF SittingDate[5] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[5], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[5] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[5], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                    StudentSubjectExam1[6].Reset();
                    StudentSubjectExam1[6].SetRange(StudentSubjectExam1[6]."Student No.", "No.");
                    StudentSubjectExam1[6].SetRange(StudentSubjectExam1[6]."Subject Code", 'CCSE6');
                    //StudentSubjectExam1[6].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[6].SetRange(StudentSubjectExam1[6]."Score Type", StudentSubjectExam1[6]."Score Type"::CCSE);
                    StudentSubjectExam1[6].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[6].FindFirst() then
                        repeat
                            SourceCode1[6] := StudentSubjectExam1[6].total;
                            SittingDate[6] := StudentSubjectExam1[6]."Sitting Date";
                        until StudentSubjectExam1[6].Next() = 0;

                    IF SittingDate[6] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[6], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[6] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[6], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                    StudentSubjectExam1[7].Reset();
                    StudentSubjectExam1[7].SetRange(StudentSubjectExam1[7]."Student No.", "No.");
                    StudentSubjectExam1[7].SetRange(StudentSubjectExam1[7]."Subject Code", 'CCSE7');
                    //StudentSubjectExam1[7].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[7].SetRange(StudentSubjectExam1[7]."Score Type", StudentSubjectExam1[7]."Score Type"::CCSE);
                    StudentSubjectExam1[7].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[7].FindFirst() then
                        repeat
                            SourceCode1[7] := StudentSubjectExam1[7].total;
                            SittingDate[7] := StudentSubjectExam1[7]."Sitting Date";
                        until StudentSubjectExam1[7].Next() = 0;

                    IF SittingDate[7] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[7], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[7] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[7], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                    StudentSubjectExam1[8].Reset();
                    StudentSubjectExam1[8].SetRange(StudentSubjectExam1[8]."Student No.", "No.");
                    StudentSubjectExam1[8].SetRange(StudentSubjectExam1[8]."Subject Code", 'CCSE8');
                    //StudentSubjectExam1[8].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[8].SetRange(StudentSubjectExam1[8]."Score Type", StudentSubjectExam1[8]."Score Type"::CCSE);
                    StudentSubjectExam1[8].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[8].FindFirst() then
                        repeat
                            SourceCode1[8] := StudentSubjectExam1[8].total;
                            SittingDate[8] := StudentSubjectExam1[8]."Sitting Date";
                        until StudentSubjectExam1[8].Next() = 0;

                    IF SittingDate[8] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[8], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[8] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[8], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                    StudentSubjectExam1[9].Reset();
                    StudentSubjectExam1[9].SetRange(StudentSubjectExam1[9]."Student No.", "No.");
                    StudentSubjectExam1[9].SetRange(StudentSubjectExam1[9]."Subject Code", 'CCSE9');
                    //StudentSubjectExam1[9].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[9].SetRange(StudentSubjectExam1[9]."Score Type", StudentSubjectExam1[9]."Score Type"::CCSE);
                    StudentSubjectExam1[9].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[9].FindFirst() then
                        repeat
                            SourceCode1[9] := StudentSubjectExam1[9].total;
                            SittingDate[9] := StudentSubjectExam1[9]."Sitting Date";
                        until StudentSubjectExam1[9].Next() = 0;

                    IF SittingDate[9] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[9], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[9] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[9], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[10].Reset();
                    StudentSubjectExam1[10].SetRange(StudentSubjectExam1[10]."Student No.", "No.");
                    StudentSubjectExam1[10].SetRange(StudentSubjectExam1[10]."Subject Code", 'CCSE10');
                    //StudentSubjectExam1[10].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[10].SetRange(StudentSubjectExam1[10]."Score Type", StudentSubjectExam1[10]."Score Type"::CCSE);
                    StudentSubjectExam1[10].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[10].FindFirst() then
                        repeat
                            SourceCode1[10] := StudentSubjectExam1[10].total;
                            SittingDate[10] := StudentSubjectExam1[10]."Sitting Date";
                        until StudentSubjectExam1[10].Next() = 0;

                    IF SittingDate[10] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[10], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[10] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[10], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[11].Reset();
                    StudentSubjectExam1[11].SetRange(StudentSubjectExam1[11]."Student No.", "No.");
                    StudentSubjectExam1[11].SetRange(StudentSubjectExam1[11]."Subject Code", 'CCSE11');
                    //StudentSubjectExam1[11].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[11].SetRange(StudentSubjectExam1[11]."Score Type", StudentSubjectExam1[11]."Score Type"::CCSE);
                    StudentSubjectExam1[11].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[11].FindFirst() then
                        repeat
                            SourceCode1[11] := StudentSubjectExam1[11].total;
                            SittingDate[11] := StudentSubjectExam1[11]."Sitting Date";
                        until StudentSubjectExam1[2].Next() = 0;

                    IF SittingDate[11] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[11], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[11] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[11], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[12].Reset();
                    StudentSubjectExam1[12].SetRange(StudentSubjectExam1[12]."Student No.", "No.");
                    StudentSubjectExam1[12].SetRange(StudentSubjectExam1[12]."Subject Code", 'CCSE12');
                    //StudentSubjectExam1[12].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[12].SetRange(StudentSubjectExam1[12]."Score Type", StudentSubjectExam1[12]."Score Type"::CCSE);
                    StudentSubjectExam1[12].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[12].FindFirst() then
                        repeat
                            SourceCode1[12] := StudentSubjectExam1[12]."total";
                            SittingDate[12] := StudentSubjectExam1[12]."Sitting Date";
                        until StudentSubjectExam1[12].Next() = 0;

                    IF SittingDate[12] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[12], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[12] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[12], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[13].Reset();
                    StudentSubjectExam1[13].SetRange(StudentSubjectExam1[13]."Student No.", "No.");
                    StudentSubjectExam1[13].SetRange(StudentSubjectExam1[13]."Subject Code", 'CCSE13');
                    //StudentSubjectExam1[13].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[13].SetRange(StudentSubjectExam1[13]."Score Type", StudentSubjectExam1[13]."Score Type"::CCSE);
                    StudentSubjectExam1[13].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[13].FindFirst() then
                        repeat
                            SourceCode1[13] := StudentSubjectExam1[13].total;
                            SittingDate[13] := StudentSubjectExam1[13]."Sitting Date";
                        until StudentSubjectExam1[13].Next() = 0;

                    IF SittingDate[13] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[13], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[13] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[13], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[14].Reset();
                    StudentSubjectExam1[14].SetRange(StudentSubjectExam1[14]."Student No.", "No.");
                    StudentSubjectExam1[14].SetRange(StudentSubjectExam1[14]."Subject Code", 'CCSE14');
                    //StudentSubjectExam1[14].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[14].SetRange(StudentSubjectExam1[14]."Score Type", StudentSubjectExam1[14]."Score Type"::CCSE);
                    StudentSubjectExam1[14].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[14].FindFirst() then
                        repeat
                            SourceCode1[14] := StudentSubjectExam1[14].total;
                            SittingDate[14] := StudentSubjectExam1[14]."Sitting Date";
                        until StudentSubjectExam1[14].Next() = 0;

                    IF SittingDate[14] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[14], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[14] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[14], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[15].Reset();
                    StudentSubjectExam1[15].SetRange(StudentSubjectExam1[15]."Student No.", "No.");
                    StudentSubjectExam1[15].SetRange(StudentSubjectExam1[15]."Subject Code", 'CCSE15');
                    //StudentSubjectExam1[15].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[15].SetRange(StudentSubjectExam1[15]."Score Type", StudentSubjectExam1[15]."Score Type"::CCSE);
                    StudentSubjectExam1[15].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[15].FindFirst() then
                        repeat
                            SourceCode1[15] := StudentSubjectExam1[15].total;
                            SittingDate[15] := StudentSubjectExam1[15]."Sitting Date";
                        until StudentSubjectExam1[15].Next() = 0;

                    IF SittingDate[15] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[15], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                    IF SourceCode1[15] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[15], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[16].Reset();
                    StudentSubjectExam1[16].SetRange(StudentSubjectExam1[16]."Student No.", "No.");
                    StudentSubjectExam1[16].SetRange(StudentSubjectExam1[16]."Subject Code", 'CCSE16');
                    //StudentSubjectExam1[16].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[16].SetRange(StudentSubjectExam1[16]."Score Type", StudentSubjectExam1[16]."Score Type"::CCSE);
                    StudentSubjectExam1[16].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[16].FindFirst() then
                        repeat
                            SourceCode1[16] := StudentSubjectExam1[16].total;
                            SittingDate[16] := StudentSubjectExam1[16]."Sitting Date";
                        until StudentSubjectExam1[16].Next() = 0;

                    IF SittingDate[16] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[16], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                    IF SourceCode1[16] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[16], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[17].Reset();
                    StudentSubjectExam1[17].SetRange(StudentSubjectExam1[17]."Student No.", "No.");
                    StudentSubjectExam1[17].SetRange(StudentSubjectExam1[17]."Subject Code", 'CCSE17');
                    //StudentSubjectExam1[17].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[17].SetRange(StudentSubjectExam1[17]."Score Type", StudentSubjectExam1[17]."Score Type"::CCSE);
                    StudentSubjectExam1[17].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[17].FindFirst() then
                        repeat
                            SourceCode1[17] := StudentSubjectExam1[17].total;
                            SittingDate[17] := StudentSubjectExam1[17]."Sitting Date";
                        until StudentSubjectExam1[17].Next() = 0;

                    IF SittingDate[17] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[17], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                    IF SourceCode1[17] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[17], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                    StudentSubjectExam1[18].Reset();
                    StudentSubjectExam1[18].SetRange(StudentSubjectExam1[18]."Student No.", "No.");
                    StudentSubjectExam1[18].SetRange(StudentSubjectExam1[18]."Subject Code", 'CCSE18');
                    //StudentSubjectExam1[18].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[18].SetRange(StudentSubjectExam1[18]."Score Type", StudentSubjectExam1[18]."Score Type"::CCSE);
                    StudentSubjectExam1[18].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[18].FindFirst() then
                        repeat
                            SourceCode1[18] := StudentSubjectExam1[18].total;
                            SittingDate[18] := StudentSubjectExam1[18]."Sitting Date";
                        until StudentSubjectExam1[18].Next() = 0;

                    IF SittingDate[18] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[18], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                    IF SourceCode1[18] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[18], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    StudentSubjectExam1[19].Reset();
                    StudentSubjectExam1[19].SetRange(StudentSubjectExam1[19]."Student No.", "No.");
                    StudentSubjectExam1[19].SetRange(StudentSubjectExam1[19]."Subject Code", 'CCSE19');
                    //StudentSubjectExam1[19].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[19].SetRange(StudentSubjectExam1[19]."Score Type", StudentSubjectExam1[19]."Score Type"::CCSE);
                    StudentSubjectExam1[19].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[19].FindFirst() then
                        repeat
                            SourceCode1[19] := StudentSubjectExam1[19].total;
                            SittingDate[19] := StudentSubjectExam1[19]."Sitting Date";
                        until StudentSubjectExam1[19].Next() = 0;

                    IF SittingDate[19] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[19], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[19] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[19], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    StudentSubjectExam1[20].Reset();
                    StudentSubjectExam1[20].SetRange(StudentSubjectExam1[20]."Student No.", "No.");
                    StudentSubjectExam1[20].SetRange(StudentSubjectExam1[20]."Subject Code", 'CCSE20');
                    //StudentSubjectExam1[20].SetRange("Academic Year", "Academic Year");
                    StudentSubjectExam1[20].SetRange(StudentSubjectExam1[20]."Score Type", StudentSubjectExam1[20]."Score Type"::CCSE);
                    StudentSubjectExam1[20].SetFilter("Sitting Date", '<=%1', EndDate);
                    IF StudentSubjectExam1[20].FindFirst() then
                        repeat
                            SourceCode1[20] := StudentSubjectExam1[20].total;
                            SittingDate[20] := StudentSubjectExam1[20]."Sitting Date";
                        until StudentSubjectExam1[20].Next() = 0;

                    IF SittingDate[20] <> 0D then
                        TempExcelBuffer.AddColumn(SittingDate[20], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                    IF SourceCode1[20] <> 0 then
                        TempExcelBuffer.AddColumn(SourceCode1[20], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    else
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    IF (SourceCode1[1] = 0) AND (SourceCode1[2] = 0) AND (SourceCode1[3] = 0) AND (SourceCode1[4] = 0) AND (SourceCode1[5] = 0)
                    AND (SourceCode1[6] = 0) AND (SourceCode1[7] = 0) AND (SourceCode1[8] = 0) AND (SourceCode1[9] = 0) AND (SourceCode1[10] = 0)
                    AND (SourceCode1[11] = 0) AND (SourceCode1[12] = 0) AND (SourceCode1[13] = 0) AND (SourceCode1[14] = 0) AND (SourceCode1[15] = 0)
                    AND (SourceCode1[16] = 0) AND (SourceCode1[17] = 0) AND (SourceCode1[18] = 0) AND (SourceCode1[19] = 0) AND (SourceCode1[20] = 0) THEN
                        CurrReport.Skip();





                end;
            end;

            trigger OnPostDataItem()
            begin
                TempExcelBuffer.CreateNewBook(StudentList);
                TempExcelBuffer.WriteSheet(StudentList, CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
                TempExcelBuffer.OpenExcel();
            end;
        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Option")
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';

                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';

                    }
                }
            }
        }

    }


    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        if StartDate = 0D then
            ERROR('Start Date must have a value');
        if EndDate = 0D then
            ERROR('End Date must have a value');
    end;


    var
        TempExcelBuffer: Record "Excel Buffer" temporary;

        StudentList: Label 'CCSE Scores Flattened';
        ExcelFileName: Label 'CCSE Scores Flattened_%1_%2';
        StartDate: Date;
        EndDate: Date;
}
report 50236 "CBSE Scores Flattened "
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'CBSE Score  Flattened';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            trigger OnPreDataItem()
            var
            begin

                "Student Master-CS".SetCurrentKey("Enrollment Order");
                "Student Master-CS".SetAscending("Enrollment Order", False);

                TempExcelBuffer.AddColumn('Student Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('LastName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FirstName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('End Sem 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Bsic', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('End Bsic', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 7', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 7', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 8', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 8', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 9', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 9', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 10', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 10', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 11', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 11', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 12', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 12', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 13', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 13', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Test Date 14 ', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CBSE Score 14', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);








            end;

            trigger OnAfterGetRecord()
            var
                MainStudentSubject: Record "Main Student Subject-CS";
                StudentSubjectExam: Record "Student Subject Exam";
                StudentSubjectExam1: array[30] of Record "Student Subject Exam";
                RecCustPostGroup: Record "Customer Posting Group";
                CourseMasterCs: Record "Course Master-CS";
                OriginalStudentID: Code[20];
                PreValue1: Integer;
                SourceCode1: array[30] of Decimal;
                SittingDate: array[30] of date;
                AndDate: array[30] of Date;
            begin


                StudentSubjectExam.Reset();
                StudentSubjectExam.SetRange(StudentSubjectExam."Student No.", "No.");
                StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CBSE);
                IF Not StudentSubjectExam.FindFirst() Then
                    CurrReport.Skip();

                IF OriginalStudentID <> "Student Master-CS"."Original Student No." then begin
                    OriginalStudentID := "Student Master-CS"."Original Student No.";

                    // Mainstudentsubject.Reset();
                    // Mainstudentsubject.SetRange("Student No.", "Student Master-CS"."No.");
                    // Mainstudentsubject.SetRange(Semester, "Student Master-CS".Semester);
                    // Mainstudentsubject.SetRange("Academic Year", "Student Master-CS"."Academic Year");
                    // Mainstudentsubject.SetRange(Mainstudentsubject.cli, "Student Master-CS".Section);
                    // if Mainstudentsubject.FindFirst then begin
                    //     FirstCourse := Mainstudentsubject.Course;
                    //     EnteringDiv := Mainstudentsubject.Semester;

                end;

                StudentSubjectExam.Reset();
                StudentSubjectExam.SetRange(StudentSubjectExam."Student No.", "No.");
                IF Not StudentSubjectExam.FindFirst() Then
                    CurrReport.Skip();

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("Student Master-CS"."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Student Master-CS"."Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Student Master-CS"."First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn(StudentSubjectExam."End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                IF "Student Master-CS"."Clinical Curriculum" = "Student Master-CS"."Clinical Curriculum"::"94" then
                    TempExcelBuffer.AddColumn('Opted out', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('Null', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                Clear(SourceCode1);
                StudentSubjectExam1[1].Reset();
                StudentSubjectExam1[1].SetRange(StudentSubjectExam1[1]."Student No.", "No.");
                StudentSubjectExam1[1].SetRange(StudentSubjectExam1[1]."Subject Code", 'CBSE1');
                //StudentSubjectExam1[1].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[1].SetRange(StudentSubjectExam1[1]."Score Type", StudentSubjectExam1[1]."Score Type"::CBSE);
                IF StudentSubjectExam1[1].FindFirst() then
                    repeat
                        SourceCode1[1] := StudentSubjectExam1[1]."total";
                        SittingDate[1] := StudentSubjectExam1[1]."Sitting Date";
                    until StudentSubjectExam1[1].Next() = 0;

                IF SittingDate[1] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[1], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);
                IF SourceCode1[1] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[1], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                StudentSubjectExam1[2].Reset();
                StudentSubjectExam1[2].SetRange(StudentSubjectExam1[2]."Student No.", "No.");
                StudentSubjectExam1[2].SetRange(StudentSubjectExam1[2]."Subject Code", 'CBSE2');
                //StudentSubjectExam1[2].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[2].SetRange(StudentSubjectExam1[2]."Score Type", StudentSubjectExam1[2]."Score Type"::CBSE);
                IF StudentSubjectExam1[2].FindFirst() then
                    repeat
                        SourceCode1[2] := StudentSubjectExam1[2].total;
                        SittingDate[2] := StudentSubjectExam1[2]."Sitting Date";
                    until StudentSubjectExam1[2].Next() = 0;

                IF SittingDate[2] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[2], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[2] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[2], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



                StudentSubjectExam1[3].Reset();
                StudentSubjectExam1[3].SetRange(StudentSubjectExam1[3]."Student No.", "No.");
                StudentSubjectExam1[3].SetRange(StudentSubjectExam1[3]."Subject Code", 'CBSE3');
                //StudentSubjectExam1[3].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[3].SetRange(StudentSubjectExam1[3]."Score Type", StudentSubjectExam1[3]."Score Type"::CBSE);
                IF StudentSubjectExam1[3].FindFirst() then
                    repeat
                        SourceCode1[3] := StudentSubjectExam1[3].total;
                        SittingDate[3] := StudentSubjectExam1[3]."Sitting Date";
                    until StudentSubjectExam1[3].Next() = 0;

                IF SittingDate[3] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[3], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);
                IF SourceCode1[3] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[3], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[4].Reset();
                StudentSubjectExam1[4].SetRange(StudentSubjectExam1[4]."Student No.", "No.");
                StudentSubjectExam1[4].SetRange(StudentSubjectExam1[4]."Subject Code", 'CBSE4');
                //StudentSubjectExam1[4].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[4].SetRange(StudentSubjectExam1[4]."Score Type", StudentSubjectExam1[4]."Score Type"::CBSE);
                IF StudentSubjectExam1[4].FindFirst() then
                    repeat
                        SourceCode1[4] := StudentSubjectExam1[4].total;
                        SittingDate[4] := StudentSubjectExam1[4]."Sitting Date";
                    until StudentSubjectExam1[4].Next() = 0;

                IF SittingDate[4] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[4], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[4] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[4], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[5].Reset();
                StudentSubjectExam1[5].SetRange(StudentSubjectExam1[5]."Student No.", "No.");
                StudentSubjectExam1[5].SetRange(StudentSubjectExam1[5]."Subject Code", 'CBSE5');
                //StudentSubjectExam1[5].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[5].SetRange(StudentSubjectExam1[5]."Score Type", StudentSubjectExam1[5]."Score Type"::CBSE);
                IF StudentSubjectExam1[5].FindFirst() then
                    repeat
                        SourceCode1[5] := StudentSubjectExam1[5].total;
                        SittingDate[5] := StudentSubjectExam1[5]."Sitting Date";
                    until StudentSubjectExam1[5].Next() = 0;

                IF SittingDate[5] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[5], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[5] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[5], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[6].Reset();
                StudentSubjectExam1[6].SetRange(StudentSubjectExam1[6]."Student No.", "No.");
                StudentSubjectExam1[6].SetRange(StudentSubjectExam1[6]."Subject Code", 'CBSE6');
                // StudentSubjectExam1[6].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[6].SetRange(StudentSubjectExam1[6]."Score Type", StudentSubjectExam1[6]."Score Type"::CBSE);
                IF StudentSubjectExam1[6].FindFirst() then
                    repeat
                        SourceCode1[6] := StudentSubjectExam1[6].total;
                        SittingDate[6] := StudentSubjectExam1[6]."Sitting Date";
                    until StudentSubjectExam1[6].Next() = 0;

                IF SittingDate[6] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[6], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[6] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[6], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[7].Reset();
                StudentSubjectExam1[7].SetRange(StudentSubjectExam1[7]."Student No.", "No.");
                StudentSubjectExam1[7].SetRange(StudentSubjectExam1[7]."Subject Code", 'CBSE7');
                //StudentSubjectExam1[7].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[7].SetRange(StudentSubjectExam1[7]."Score Type", StudentSubjectExam1[7]."Score Type"::CBSE);
                IF StudentSubjectExam1[7].FindFirst() then
                    repeat
                        SourceCode1[7] := StudentSubjectExam1[7].total;
                        SittingDate[7] := StudentSubjectExam1[7]."Sitting Date";
                    until StudentSubjectExam1[7].Next() = 0;

                IF SittingDate[7] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[7], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[7] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[7], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[8].Reset();
                StudentSubjectExam1[8].SetRange(StudentSubjectExam1[8]."Student No.", "No.");
                StudentSubjectExam1[8].SetRange(StudentSubjectExam1[8]."Subject Code", 'CBSE8');
                //StudentSubjectExam1[8].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[8].SetRange(StudentSubjectExam1[8]."Score Type", StudentSubjectExam1[8]."Score Type"::CBSE);
                IF StudentSubjectExam1[8].FindFirst() then
                    repeat
                        SourceCode1[8] := StudentSubjectExam1[8].total;
                        SittingDate[8] := StudentSubjectExam1[8]."Sitting Date";
                    until StudentSubjectExam1[8].Next() = 0;

                IF SittingDate[8] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[8], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[8] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[8], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[9].Reset();
                StudentSubjectExam1[9].SetRange(StudentSubjectExam1[9]."Student No.", "No.");
                StudentSubjectExam1[9].SetRange(StudentSubjectExam1[9]."Subject Code", 'CBSE9');
                //StudentSubjectExam1[9].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[9].SetRange(StudentSubjectExam1[9]."Score Type", StudentSubjectExam1[9]."Score Type"::CBSE);
                IF StudentSubjectExam1[9].FindFirst() then
                    repeat
                        SourceCode1[9] := StudentSubjectExam1[9].total;
                        SittingDate[9] := StudentSubjectExam1[9]."Sitting Date";
                    until StudentSubjectExam1[9].Next() = 0;

                IF SittingDate[9] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[9], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[9] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[9], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[10].Reset();
                StudentSubjectExam1[10].SetRange(StudentSubjectExam1[10]."Student No.", "No.");
                StudentSubjectExam1[10].SetRange(StudentSubjectExam1[10]."Subject Code", 'CBSE10');
                //StudentSubjectExam1[10].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[10].SetRange(StudentSubjectExam1[10]."Score Type", StudentSubjectExam1[10]."Score Type"::CBSE);
                IF StudentSubjectExam1[10].FindFirst() then
                    repeat
                        SourceCode1[10] := StudentSubjectExam1[10].total;
                        SittingDate[10] := StudentSubjectExam1[10]."Sitting Date";
                    until StudentSubjectExam1[10].Next() = 0;

                IF SittingDate[10] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[1], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[10] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[10], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[11].Reset();
                StudentSubjectExam1[11].SetRange(StudentSubjectExam1[11]."Student No.", "No.");
                StudentSubjectExam1[11].SetRange(StudentSubjectExam1[11]."Subject Code", 'CBSE11');
                //StudentSubjectExam1[11].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[11].SetRange(StudentSubjectExam1[11]."Score Type", StudentSubjectExam1[11]."Score Type"::CBSE);
                IF StudentSubjectExam1[11].FindFirst() then
                    repeat
                        SourceCode1[11] := StudentSubjectExam1[11].total;
                        SittingDate[11] := StudentSubjectExam1[11]."Sitting Date";
                    until StudentSubjectExam1[11].Next() = 0;

                IF SittingDate[11] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[11], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[11] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[11], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[12].Reset();
                StudentSubjectExam1[12].SetRange(StudentSubjectExam1[12]."Student No.", "No.");
                StudentSubjectExam1[12].SetRange(StudentSubjectExam1[12]."Subject Code", 'CBSE12');
                //StudentSubjectExam1[12].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[12].SetRange(StudentSubjectExam1[12]."Score Type", StudentSubjectExam1[12]."Score Type"::CBSE);
                IF StudentSubjectExam1[12].FindFirst() then
                    repeat
                        SourceCode1[12] := StudentSubjectExam1[12].total;
                        SittingDate[12] := StudentSubjectExam1[12]."Sitting Date";
                    until StudentSubjectExam1[12].Next() = 0;

                IF SittingDate[12] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[12], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[12] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[12], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[13].Reset();
                StudentSubjectExam1[13].SetRange(StudentSubjectExam1[13]."Student No.", "No.");
                StudentSubjectExam1[13].SetRange(StudentSubjectExam1[13]."Subject Code", 'CBSE13');
                //StudentSubjectExam1[13].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[13].SetRange(StudentSubjectExam1[13]."Score Type", StudentSubjectExam1[13]."Score Type"::CBSE);
                IF StudentSubjectExam1[13].FindFirst() then
                    repeat
                        SourceCode1[13] := StudentSubjectExam1[13].total;
                        SittingDate[13] := StudentSubjectExam1[13]."Sitting Date";
                    until StudentSubjectExam1[13].Next() = 0;

                IF SittingDate[13] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[13], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);

                IF SourceCode1[13] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[13], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                StudentSubjectExam1[14].Reset();
                StudentSubjectExam1[14].SetRange(StudentSubjectExam1[14]."Student No.", "No.");
                StudentSubjectExam1[14].SetRange(StudentSubjectExam1[14]."Subject Code", 'CBSE14');
                //StudentSubjectExam1[14].SetRange("Academic Year", "Academic Year");
                StudentSubjectExam1[14].SetRange(StudentSubjectExam1[14]."Score Type", StudentSubjectExam1[14]."Score Type"::CBSE);
                IF StudentSubjectExam1[14].FindFirst() then
                    repeat
                        SourceCode1[14] := StudentSubjectExam1[14].total;
                        SittingDate[14] := StudentSubjectExam1[14]."Sitting Date";
                    until StudentSubjectExam1[14].Next() = 0;

                IF SittingDate[14] <> 0D then
                    TempExcelBuffer.AddColumn(SittingDate[14], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::TEXT);


                IF SourceCode1[14] <> 0 then
                    TempExcelBuffer.AddColumn(SourceCode1[14], false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn('NULL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                IF (SourceCode1[1] = 0) AND (SourceCode1[2] = 0) AND (SourceCode1[3] = 0) AND (SourceCode1[4] = 0) AND (SourceCode1[5] = 0)
                AND (SourceCode1[6] = 0) AND (SourceCode1[7] = 0) AND (SourceCode1[8] = 0) AND (SourceCode1[9] = 0) AND (SourceCode1[10] = 0)
                AND (SourceCode1[11] = 0) AND (SourceCode1[12] = 0) AND (SourceCode1[13] = 0) AND (SourceCode1[14] = 0) THEN
                    CurrReport.Skip();




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
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Option")
                {
                    // field("StartDate From"; StartDate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Start Date';

                    // }
                    // field("StartDate To"; EndDate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'End Date';

                    // }
                }
            }
        }

    }


    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        // if StartDate = 0D then
        //     ERROR('Start Date must have a value');
        // if EndDate = 0D then
        //     ERROR('End Date must have a value');
    end;


    var
        TempExcelBuffer: Record "Excel Buffer" temporary;

        StudentList: Label 'CBSE Scores Flattenend';
        ExcelFileName: Label 'CBSE Scores Flattenend_%1_%2';

}
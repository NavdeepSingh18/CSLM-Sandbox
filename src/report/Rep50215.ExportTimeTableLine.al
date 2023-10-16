report 50215 TimetableLine
{
    UsageCategory = None;
    ProcessingOnly = true;
    dataset
    {
        // dataitem("Class Time Table Line-CS"; "Class Time Table Line-CS")
        // {
        //     trigger OnPreDataItem()
        //     var
        //         TimeTableTemplateHdr: Record "Time Table Template Head-CS";
        //         ClassTimeTableHdr: Record "Class Time Table Header-CS";
        //     begin
        //         If TimeTableLine then begin
        //             TempExcelBuffer.Reset();
        //             TempExcelBuffer.DeleteAll();
        //             TempExcelBuffer.NewRow();

        //             TempExcelBuffer.AddColumn('Document No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Line No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Time Slot', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Day', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Small Group / Section', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Subject Category', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Subject Group', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Subject Class', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Level 2 Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Level 2 Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             ClassTimeTableHdr.Reset();
        //             ClassTimeTableHdr.SetRange("No.", DocNo);
        //             IF ClassTimeTableHdr.FindFirst() then begin
        //                 TimeTableTemplateHdr.Reset();
        //                 TimeTableTemplateHdr.SetRange("No.", ClassTimeTableHdr."Template Code");
        //                 //TimeTableTemplateHdr.SetRange("With Topic Code", true);
        //                 IF TimeTableTemplateHdr.FindFirst() then begin
        //                     TempExcelBuffer.AddColumn('Topic Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //                     TempExcelBuffer.AddColumn('Topic Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //                 end;
        //             end;

        //             TempExcelBuffer.AddColumn('Lab Group', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Room No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Faculty 1  Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Faculty 2  Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Faculty 3  Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Faculty 4  Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //             TempExcelBuffer.AddColumn('Start Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         end;
        //     end;

        //     trigger OnAfterGetRecord()
        //     begin
        //         IF not TimeTableLine then
        //             CurrReport.Skip();
        //         TempExcelBuffer.NewRow();
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Time Slot", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS".Day, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS".Section, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Subject Category", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Subject Group", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Subject Class", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Subject Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Subject Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Topic Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Topic Description", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS".Batch, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Room No", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Faculty 1 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Faculty 2 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Faculty 3 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Faculty 4 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //         TempExcelBuffer.AddColumn("Class Time Table Line-CS"."Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //     end;

        //     trigger OnPostDataItem()
        //     begin
        //         If TimeTableLine then begin
        //             TempExcelBuffer.CreateNewBook(ExamList);
        //             TempExcelBuffer.WriteSheet(ExamList, CompanyName, UserId);
        //             TempExcelBuffer.CloseBook();
        //             TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, "Document No."));
        //             TempExcelBuffer.OpenExcel();
        //         end;
        //     end;
        // }
        dataitem("Student Subject GradeBook"; "Student Subject GradeBook")
        {
            trigger OnPreDataItem()
            begin
                If SSGradeBook then begin
                    TempExcelBuffer.Reset();
                    TempExcelBuffer.DeleteAll();
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn('Grade Book No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Student No', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('Communication', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    IF DocNo <> '' then
                        SetFilter("Grade Book No.", DocNo);
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                IF not SSGradeBook then
                    CurrReport.Skip();

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("Student Subject GradeBook"."Grade Book No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Student Subject GradeBook"."Student No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Student Subject GradeBook".Communications, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnPostDataItem()
            Begin
                IF SSGradeBook then begin
                    TempExcelBuffer.CreateNewBook('Student Subject Grade Book');
                    TempExcelBuffer.WriteSheet('Student Subject Grade Book', CompanyName, UserId);
                    TempExcelBuffer.CloseBook();
                    TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Student Subject Grade Book ', "Grade Book No."));
                    TempExcelBuffer.OpenExcel();
                end;
            End;
        }
    }




    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ExamList: Label 'TimeTableLine';
        ExcelFileName: Label 'Time Table Line %1';
        DocNo: Code[20];

        TimeTableLine: Boolean;

        SSGradeBook: Boolean;

    Procedure DocumentNoFilter(_DocNo: Code[20])
    begin
        DocNo := _DocNo;

    end;

    Procedure TimeTableLineFilter(_Bool: Boolean)
    begin
        TimeTableLine := _Bool;
    end;

    procedure SSGradeBookFilter(_Bool: Boolean)
    Begin
        SSGradeBook := _Bool;

    End;

}
report 50069 "Faculty Mark Att Till Now CS"
{
    // version V.001-CS
    Caption = 'Faculty Mark Att Till Now';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Faculty Mark Att Till Now CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Final Class Time Table-CS"; "Final Class Time Table-CS")
        {
            DataItemTableView = WHERE("Subject Code" = FILTER('<>'''));
            RequestFilterFields = "Faculty 1Code";
            column(Semester_TimeTable; "Final Class Time Table-CS".Semester)
            {
            }
            column(SubjectCode_TimeTable; "Final Class Time Table-CS"."Subject Code")
            {
            }
            column(SubjectName_TimeTable; "Final Class Time Table-CS"."Subject Name")
            {
            }
            column(Section_TimeTable; "Final Class Time Table-CS".Section)
            {
            }
            column(Faculty1Code_TimeTable; "Final Class Time Table-CS"."Faculty 1Code")
            {
            }
            column(Cancelled_TimeTable; "Final Class Time Table-CS".Cancelled)
            {
            }
            column(Attendance_TimeTable; "Final Class Time Table-CS".Attendance)
            {
            }
            column(TotalAtt; TotalAtt)
            {
            }
            column(TotalCancel; TotalCancel)
            {
            }
            column(TotalMark; TotalMark)
            {
            }
            column(TotalUnMark; TotalUnMark)
            {
            }
            column(Coursecode_TimeTable; "Final Class Time Table-CS"."Course code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo := SNo + 1;

                IF (Sub <> "Final Class Time Table-CS"."Subject Code") OR (Sec <> "Final Class Time Table-CS".Section) OR (FacultyCode <> "Final Class Time Table-CS"."Faculty 1Code") THEN BEGIN
                    IF SNo <> 1 THEN BEGIN
                        RowNum += 1;
                        ColumnNum := 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', Sem);
                        ColumnNum += 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', Sub);
                        ColumnNum += 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', Sec);
                        ColumnNum += 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', FacultyCode);
                        ColumnNum += 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', Course);
                        ColumnNum += 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', FORMAT(TotalAtt));
                        ColumnNum += 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', FORMAT(TotalCancel));
                        ColumnNum += 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', FORMAT(TotalMark));
                        ColumnNum += 1;
                        EnterCell(RowNum, ColumnNum, FALSE, '', FORMAT(TotalUnMark - TotalCancel));
                        ColumnNum += 1
                    END;

                    TotalAtt := 0;
                    TotalMark := 0;
                    TotalUnMark := 0;
                    TotalCancel := 0;
                END;
                Sub := "Final Class Time Table-CS"."Subject Code";
                Sec := "Final Class Time Table-CS".Section;
                FacultyCode := "Final Class Time Table-CS"."Faculty 1Code";
                Sem := "Final Class Time Table-CS".Semester;
                Course := "Final Class Time Table-CS"."Course code";

                TotalAtt := TotalAtt + 1;

                IF "Final Class Time Table-CS".Cancelled = TRUE THEN
                    TotalCancel := TotalCancel + 1;

                IF "Final Class Time Table-CS".Attendance = "Final Class Time Table-CS".Attendance::Marked THEN
                    TotalMark := TotalMark + 1
                ELSE
                    TotalUnMark := TotalUnMark + 1;
            end;

            trigger OnPostDataItem()
            begin
                RowNum += 1;
                ColumnNum := 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', Sem);
                ColumnNum += 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', Sub);
                ColumnNum += 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', Sec);
                ColumnNum += 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', FacultyCode);
                ColumnNum += 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', Course);
                ColumnNum += 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', FORMAT(TotalAtt));
                ColumnNum += 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', FORMAT(TotalCancel));
                ColumnNum += 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', FORMAT(TotalMark));
                ColumnNum += 1;
                EnterCell(RowNum, ColumnNum, FALSE, '', FORMAT(TotalUnMark - TotalCancel));
                ColumnNum += 1
            end;

            trigger OnPreDataItem()
            begin

                EducationSetupCS.Reset();
                IF EducationSetupCS.findfirst() THEN
                    IF Session1 = Session1::"Even Semester" THEN BEGIN
                        EducationMultiEventCalCS.Reset();
                        EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                        EducationMultiEventCalCS.SETRANGE("Event Code", 'EVENSEMCLASSSTART');
                        EducationMultiEventCalCS.SETCURRENTKEY(EducationMultiEventCalCS."Start Date");
                        IF EducationMultiEventCalCS.findfirst() THEN BEGIN
                            StartDate := EducationMultiEventCalCS."Start Date";
                            EndDate := Today();
                        END;
                    END ELSE
                        IF Session1 = Session1::"Odd Semester" THEN BEGIN
                            EducationMultiEventCalCS.Reset();
                            EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                            EducationMultiEventCalCS.SETRANGE("Event Code", 'ODD SEM CLASS START');
                            EducationMultiEventCalCS.SETCURRENTKEY(EducationMultiEventCalCS."Start Date");
                            IF EducationMultiEventCalCS.findfirst() THEN BEGIN
                                StartDate := EducationMultiEventCalCS."Start Date";
                                EndDate := Today();
                            END;
                        END;


                EducationSetupCS.Reset();
                IF EducationSetupCS.findfirst() then
                    IF Session1 = Session1::"Even Semester" THEN BEGIN
                        SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
                        SETFILTER("Academic Code", EducationSetupCS."Academic Year");
                        SETFILTER(Date, '>=%1', StartDate);
                        SETFILTER(Date, '<=%1', EndDate);
                    END ELSE
                        IF Session1 = Session1::"Odd Semester" THEN BEGIN
                            SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
                            SETFILTER("Academic Code", EducationSetupCS."Academic Year");
                            SETFILTER(Date, '>=%1', StartDate);
                            SETFILTER(Date, '<=%1', EndDate);
                        END;

                "Final Class Time Table-CS".SETCURRENTKEY(Semester, "Subject Code", Section, "Faculty 1Code");
                SNo := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Session; Session1)
                {
                    Visible = true;
                    ApplicationArea = All;
                    Caption = 'Session';
                    ToolTip = 'Session may have a value';
                    OptionCaption = ' ,Even Semester,Odd Semester';

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        ExcelBuf.WriteSheet('Faculty Attendance Record', COMPANYNAME(), UserId());
        ExcelBuf.SetFriendlyFilename('Faculty Attendance Record');
        //ExcelBuf.CloseBook;
        ExcelBuf.OpenExcel();

    end;

    trigger OnPreReport()
    begin
        //Create Header-->
        ExcelBuf.deleteall();
        RowNum := 1;
        ColumnNum := 1;

        EnterCell(RowNum, ColumnNum, TRUE, '', 'Semester');
        ColumnNum += 1;
        EnterCell(RowNum, ColumnNum, TRUE, '', 'Subject Code');
        ColumnNum += 1;
        EnterCell(RowNum, ColumnNum, TRUE, '', 'Section');
        ColumnNum += 1;
        EnterCell(RowNum, ColumnNum, TRUE, '', 'Faculty Code');
        ColumnNum += 1;
        EnterCell(RowNum, ColumnNum, TRUE, '', 'Course Code');
        ColumnNum += 1;
        EnterCell(RowNum, ColumnNum, TRUE, '', 'Total Class');
        ColumnNum += 1;
        EnterCell(RowNum, ColumnNum, TRUE, '', 'Cancel');
        ColumnNum += 1;
        EnterCell(RowNum, ColumnNum, TRUE, '', 'Mark Attendance');
        ColumnNum += 1;
        EnterCell(RowNum, ColumnNum, TRUE, '', 'Not Mark Attendance');
        ColumnNum += 1;
    end;

    var
        ExcelBuf: Record "Excel Buffer";
        EducationSetupCS: Record "Education Setup-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        Session1: Option " ","Even Semester","Odd Semester";
        StartDate: Date;
        EndDate: Date;
        TotalAtt: Integer;
        TotalCancel: Integer;
        TotalMark: Integer;
        TotalUnMark: Integer;
        Sub: Code[20];
        Sec: Code[20];
        FacultyCode: Code[20];
        RowNum: Integer;
        ColumnNum: Integer;

        Sem: Code[20];
        SNo: Integer;
        Course: Code[20];

    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; isBold: Boolean; NumFormat: Text[20]; CellValue: Text[250])
    begin
        ExcelBuf.init();
        ExcelBuf.VALIDATE("Row No.", RowNo);
        ExcelBuf.VALIDATE("Column No.", ColumnNo);
        ExcelBuf.Bold := isBold;
        ExcelBuf.NumberFormat := NumFormat;
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Insert();
    end;
}


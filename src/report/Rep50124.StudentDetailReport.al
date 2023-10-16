report 50124 "Student Detail Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            RequestFilterFields = "Academic Year", Semester, "Course Code", Status;
            trigger OnPreDataItem()
            begin
                RowNo := 0;
                RowNo := 1;
                ExcelBuffer_gRec.Reset();
                ExcelBuffer_gRec.DeleteAll();
                EnterCell(RowNo, 1, 'Student Number', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                //EnterCell(RowNo, 2, 'SyStudentID', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 2, 'Last Name', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 3, 'First Name', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 4, 'Citizenship', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                Entercell(RowNo, 5, 'Nationality', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 6, 'Semester', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 7, 'School Status', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 8, 'Estimated Grad Date', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 9, 'Entering Semester', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 10, 'Last Date of Attendance', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 11, 'Separation Date', True, True, '', ExcelBuffer_gRec."Cell Type"::Text);
            end;

            trigger OnAfterGetRecord()
            var
                SemesterMaster_lRec: Record "Semester Master-CS";
                CourseSemesterMaster_lRec: Record "Course Sem. Master-CS";
                SemesterMaster_lRec1: Record "Semester Master-CS";
                CourseSemesterMaster_lRec1: Record "Course Sem. Master-CS";
                NextSemesterCode: Code[10];
            begin
                RowNo += 1;
                NextSemesterCode := '';
                CourseSemesterMaster_lRec.Reset();
                CourseSemesterMaster_lRec.SetRange("Course Code", "Student Master-CS"."Course Code");
                CourseSemesterMaster_lRec.SetRange("Semester Code", "Student Master-CS".Semester);
                CourseSemesterMaster_lRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                IF CourseSemesterMaster_lRec.FindFirst() then begin
                    SemesterMaster_lRec.Reset();
                    SemesterMaster_lRec.SetRange(Code, CourseSemesterMaster_lRec."Semester Code");
                    SemesterMaster_lRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    IF SemesterMaster_lRec.FindFirst() then begin
                        SemesterMaster_lRec1.Reset();
                        SemesterMaster_lRec1.SetRange(Sequence, SemesterMaster_lRec.Sequence + 1);
                        SemesterMaster_lRec1.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                        IF SemesterMaster_lRec1.FindFirst() then begin
                            CourseSemesterMaster_lRec1.Reset();
                            CourseSemesterMaster_lRec1.SetRange("Semester Code", SemesterMaster_lRec1.Code);
                            CourseSemesterMaster_lRec1.SetRange("Course Code", "Student Master-CS"."Course Code");
                            CourseSemesterMaster_lRec1.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            IF CourseSemesterMaster_lRec1.FindFirst() then
                                NextSemesterCode := CourseSemesterMaster_lRec1."Semester Code";
                        end;
                    end;
                end;


                EnterCell(RowNo, 1, "Student Master-CS"."Original Student No.", false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                //EnterCell(RowNo, 2, "Student Master-CS"."External SIS ID", false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                Entercell(RowNo, 2, "Student Master-CS"."Last Name", false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 3, "Student Master-CS"."First Name", false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 4, Format("Student Master-CS".Citizenship), false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 5, "Student Master-CS".Nationality, false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 6, "Student Master-CS".Semester, false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 7, "Student Master-CS".Status, false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 8, Format("Student Master-CS"."Estimated Graduation Date"), False, False, 'MM-dd-yyyy', ExcelBuffer_gRec."Cell Type"::Date);
                EnterCell(RowNo, 9, NextSemesterCode, false, False, '', ExcelBuffer_gRec."Cell Type"::Text);
                EnterCell(RowNo, 10, Format("Student Master-CS".LDA), false, False, 'MM-dd-yyyy', ExcelBuffer_gRec."Cell Type"::Date);
                EnterCell(RowNo, 11, Format("Student Master-CS"."Separation Date"), false, False, 'MM-dd-yyyy', ExcelBuffer_gRec."Cell Type"::Date);
            end;

        }

    }

    Trigger OnPostReport()
    Begin
        //ExcelBuffer_gRec.CreateBookAndOpenExcel('', 'STUDENT DETAIL REPORT', 'STUDENT DETAIL REPORT', CompanyName, UserID());
    End;

    procedure EnterCell(_RowNo: Integer; _ColumnNo: Integer; Value: Text; Bold: Boolean; UnderLine: Boolean; Value_Format: Text; Cell_Type: Option)
    Begin
        ExcelBuffer_gRec.INIT;
        ExcelBuffer_gRec.VALIDATE("Row No.", _RowNo);
        ExcelBuffer_gRec.VALIDATE("Column No.", _ColumnNo);
        ExcelBuffer_gRec."Cell Value as Text" := Value;
        ExcelBuffer_gRec.Bold := Bold;
        ExcelBuffer_gRec.Underline := UnderLine;
        ExcelBuffer_gRec.NumberFormat := Value_Format;
        ExcelBuffer_gRec."Cell Type" := Cell_Type;
        ExcelBuffer_gRec.INSERT(TRUE);
    end;


    var
        ExcelBuffer_gRec: Record "Excel Buffer" temporary;
        RowNo: Integer;
}
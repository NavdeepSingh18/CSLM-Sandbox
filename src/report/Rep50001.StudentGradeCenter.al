report 50001 "Student Grade Center"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/StudentGradeCenter.rdl';
    Caption = 'Student Grade Center';

    dataset
    {
        dataitem("Grade Book"; "Grade Book")
        {
            DataItemTableView = sorting("Entry No.", "Student No.") order(ascending);
            column(InstituteCodeFilter; InstituteCodeFilter)
            { }
            column(AcademicYearFilter; AcademicYearFilter)
            { }
            column(TermFilter; TermFilter)
            { }
            column(SemesterFilter; SemesterFilter)
            { }
            column(StudentID; StudentID)
            { }
            column(First_Name; "First Name")
            { }
            column(Last_Name; "Last Name")
            { }
            column(Exam_Code; "Exam Code")
            { }
            column(Earned_Points; "Earned Points")
            { }
            column(Available_Points; "Available Points")
            { }
            column(Grade; Grade)
            { }

            trigger OnPreDataItem()
            begin
                IF InstituteCodeFilter = '' then
                    Error('Please select Institute Code Filter');
                IF AcademicYearFilter = '' then
                    Error('Please select Academic Year Filter');
                If TermFilter = TermFilter::" " then
                    Error('Please select Term Filter');
                if SemesterFilter = '' then
                    Error('Please select Semester Filter');
            end;

            trigger OnAfterGetRecord()
            begin
                StudentID := '';
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Grade Book"."Student No.");
                If StudentMaster.FindFirst() then
                    StudentID := StudentMaster."Original Student No.";
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Request Filter")
                {
                    field(InstituteCodeFilter; InstituteCodeFilter)
                    {
                        Caption = 'Institute Code Filter';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field(AcademicYearFilter; AcademicYearFilter)
                    {
                        Caption = 'Academic Year Filter';
                        TableRelation = "Academic Year Master-CS";
                    }
                    field(TermFilter; TermFilter)
                    {
                        Caption = 'Term Filter';
                    }
                    field(SemesterFilter; SemesterFilter)
                    {
                        Caption = 'Semester Filter';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Semester_lRec: Record "Semester Master-CS";
                        Begin
                            If InstituteCodeFilter = '' then
                                Error('Please select Institute Code Filter');
                            Semester_lRec.Reset();
                            Semester_lRec.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                            If Page.RunModal(0, Semester_lRec) = Action::LookupOK then
                                SemesterFilter := Semester_lRec.Code;
                        End;
                    }
                }
            }
        }
    }
    var
        StudentMaster: Record "Student Master-CS";
        AcademicYearFilter: Code[20];
        TermFilter: Option " ",FALL,SPRING,SUMMER;
        SemesterFilter: Code[20];
        InstituteCodeFilter: Code[20];
        StudentID: Code[20];
        FirstName: Text[50];
        LastName: Text[50];
}
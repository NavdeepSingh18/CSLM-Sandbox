codeunit 50039 "Registrar Academics Mangement"
{
    trigger OnRun()
    begin
    end;

    procedure DivideClassinTwoGroups(CourseCode: Code[20]; Semester: Code[10]; GlobalDimension1: Code[20]; AcademicYear: Code[20]; Year: Code[10])
    var
        StudentMasterRec: Record "Student Master-CS";
        CourseSection: Record "Course Section Master-CS";
        A: Integer;
        TotalCount: Integer;
    begin
        CourseSection.RESET();
        CourseSection.SETRANGE("Course Code", CourseCode);
        CourseSection.SETRANGE(Year, Year);
        CourseSection.SETRANGE("Academic Year", AcademicYear);
        CourseSection.SETRANGE(Semester, Semester);
        IF CourseSection.FINDSET() THEN
            TotalCount := CourseSection.COUNT();

        StudentMasterRec.RESET();
        StudentMasterRec.SETCURRENTKEY("First Name");
        StudentMasterRec.SETRANGE("Academic Year", AcademicYear);
        StudentMasterRec.SETRANGE("Course Code", CourseCode);
        StudentMasterRec.SETRANGE(Semester, Semester);
        StudentMasterRec.SETRANGE("Global Dimension 1 Code", GlobalDimension1);
        IF StudentMasterRec.FINDFIRST() THEN
            REPEAT
                IF A = 0 THEN
                    A := 1
                ELSE
                    A := A + 1;

                IF A > TotalCount THEN
                    A := 1;

                CourseSection.RESET();
                CourseSection.SETRANGE("Course Code", StudentMasterRec."Course Code");
                CourseSection.SETRANGE(Year, StudentMasterRec.Year);
                CourseSection.SETRANGE("Academic Year", StudentMasterRec."Academic Year");
                CourseSection.SETRANGE(Semester, StudentMasterRec.Semester);
                CourseSection.SETRANGE("Sequence No", A);
                IF CourseSection.FINDFIRST() THEN BEGIN
                    // StudentSubject.reset;
                    // StudentSubject.SETRANGE("Course Code",StudentCOLLEGE."Course Code");
                    StudentMasterRec.Section := CourseSection."Section Code";
                    StudentMasterRec.MODIFY();
                END;
            UNTIL StudentMasterRec.NEXT() = 0;

        MESSAGE('Done');
    end;
}
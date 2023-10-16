report 50041 "Faculty FeedbackCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Faculty FeedbackCS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Faculty Feedback';
    dataset
    {
        dataitem("Faculty Feedback-CS"; "Faculty Feedback-CS")
        {
            DataItemTableView = SORTING("Subject Code", Section, "Faculty Code", "Student No.")
                                ORDER(Ascending)
                                WHERE("Question Id" = FILTER('<11'));
            RequestFilterFields = "Academic Year", Semester, Course, "Global Dimension 2 Code", "Faculty Code", Section;
            column(SubjectCode_Feedback; "Faculty Feedback-CS"."Subject Code")
            {
            }
            column(FacultyCode_Feedback; "Faculty Feedback-CS"."Faculty Code")
            {
            }
            column(Section_Feedback; "Faculty Feedback-CS".Section)
            {
            }
            column(Semester_Feedback; "Faculty Feedback-CS".Semester)
            {
            }
            column(AcademicYear_Feedback; "Faculty Feedback-CS"."Academic Year")
            {
            }
            column(GlobalDimension2Code_Feedback; "Faculty Feedback-CS"."Global Dimension 2 Code")
            {
            }
            column(Course_Feedback; "Faculty Feedback-CS".Course)
            {
            }
            column(Desc; Desc)
            {
            }
            column(FeedbackFor_Feedback; "Faculty Feedback-CS".FeedbackFor)
            {
            }
            column(FacultyName; FacultyName)
            {
            }
            column(FacultyIN; FacultyIN)
            {
            }
            column(GETFILTERS; "Faculty Feedback-CS".GETFILTERS())
            {
            }
            column(CourseDesc; CourseDesc)
            {
            }
            column(StudentCount; StudentCount)
            {
            }
            column(XYZ; XYZ)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "Faculty Feedback-CS"."Subject Code");
                IF SubjectMasterCS.findfirst() THEN
                    Desc := SubjectMasterCS.Description;

                Employee.Reset();
                Employee.SETRANGE(Employee."No.", "Faculty Feedback-CS"."Faculty Code");
                IF Employee.findfirst() THEN BEGIN
                    FacultyName := Employee."First Name";
                    FacultyIN := Employee.Initials;
                END;

                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "Faculty Feedback-CS".Course);
                IF CourseMasterCS.findfirst() THEN
                    CourseDesc := CourseMasterCS.Description;

                IF (SubCode <> "Faculty Feedback-CS"."Subject Code") OR (FCode <> "Faculty Feedback-CS"."Faculty Code") OR (Sec <> "Faculty Feedback-CS".Section) THEN BEGIN
                    B := 0;
                    XYZ := 0;
                    IF StudentNum <> "Faculty Feedback-CS"."Student No." THEN
                        StudentCount := 0;
                END;
                FCode := "Faculty Feedback-CS"."Faculty Code";
                SubCode := "Faculty Feedback-CS"."Subject Code";
                Sec := "Faculty Feedback-CS".Section;

                IF StudentNum <> "Faculty Feedback-CS"."Student No." THEN
                    StudentCount := StudentCount + 1;

                StudentNum := "Faculty Feedback-CS"."Student No.";

                B := "Faculty Feedback-CS".Rate + B;

                XYZ := ROUND(B / (StudentCount * 10));
            end;

            trigger OnPreDataItem()
            begin
                StudentCount := 0;
                StudentNum := '';
                B := 0;
                XYZ := 0;
                SubCode := '';
                FCode := '';
                Sec := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SubjectMasterCS: Record "Subject Master-CS";
        Employee: Record "Employee";
        CourseMasterCS: Record "Course Master-CS";
        Desc: Text[100];

        FacultyName: Text[100];
        FacultyIN: Text[30];

        CourseDesc: Text[100];
        StudentCount: Integer;

        StudentNum: Code[20];
        B: Integer;
        XYZ: Decimal;
        FCode: Code[20];
        SubCode: Code[20];
        Sec: Code[10];
}


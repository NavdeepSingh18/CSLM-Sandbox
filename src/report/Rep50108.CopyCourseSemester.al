report 50108 "Copy Course Semester"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Course Sem. Master-CS"; "Course Sem. Master-CS")
        {

            trigger OnPreDataItem()
            begin
                // if CourseCode = '' then
                //     Error('Course Code must have value in it.');

                // if CurrentAcademicYear = '' then
                //     Error('Current Academic Year must have value in it.');

                if NextAcademicYear = '' then
                    Error('Next Academic Year must have value in it.');

                if StartDate = 0D then
                    Error('Start Date must have value in it.');

                if EndDate = 0D then
                    Error('End Date must have value in it.');

                if Term = Term::" " then
                    Error('Term can not be blank');

                //  "Course Sem. Master-CS".SETRANGE("Course Sem. Master-CS"."Course Code", CourseCode);
                //  "Course Sem. Master-CS".SETRANGE("Course Sem. Master-CS"."Academic Year", CurrentAcademicYear);
            end;

            trigger OnAfterGetRecord()
            begin
                CourseSemesterRec.Reset();
                CourseSemesterRec.SetRange("Course Code", "Course Sem. Master-CS"."Course Code");
                CourseSemesterRec.SetRange("Academic Year", "Course Sem. Master-CS"."Academic Year");
                CourseSemesterRec.SetRange("Semester Code", "Course Sem. Master-CS"."Semester Code");
                if CourseSemesterRec.FindFirst() then
                    repeat
                        CourseSemesterRec1.Init();
                        CourseSemesterRec1.TransferFields(CourseSemesterRec);
                        CourseSemesterRec1.Validate("Academic Year", NextAcademicYear);
                        CourseSemesterRec1.Validate("Start Date", StartDate);
                        CourseSemesterRec1.Validate("End Date", EndDate);
                        CourseSemesterRec1.Validate(Term, Term);
                        CourseSemesterRec1.Insert(true);
                    until CourseSemesterRec.Next() = 0;


                // CourseSemesterRec.INIT();
                // CourseSemesterRec.TRANSFERFIELDS("Course Sem. Master-CS");
                // CourseSemesterRec.VALIDATE("Academic Year", NextAcademicYear);
                // CourseSemesterRec.INSERT(TRUE);

                // CourseSubjectLineRec.RESET();
                // CourseSubjectLineRec.SETRANGE("Course Code", "Course Wise Subject Head-CS".Course);
                // CourseSubjectLineRec.SETRANGE(Semester, "Course Wise Subject Head-CS".Semester);
                // CourseSubjectLineRec.SETRANGE("Academic Year", "Course Wise Subject Head-CS"."Academic Year");
                // IF CourseSubjectLineRec.FINDFIRST() THEN
                //     REPEAT
                //         CourseSubjectLnRec.INIT();
                //         CourseSubjectLnRec.TRANSFERFIELDS(CourseSubjectLineRec);
                //         CourseSubjectLnRec.VALIDATE("Academic Year", NextAcademicYear);
                //         CourseSubjectLnRec.INSERT(TRUE);
                //    UNTIL CourseSubjectLineRec.NEXT() = 0;

            end;

        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                // field("Course Code"; CourseCode)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Course Code';
                //     ToolTip = 'Course Code must have a value';
                //     TableRelation = "Course Master-CS";
                // }
                // field("Current Academic Year"; CurrentAcademicYear)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Current Academic Year';
                //     ToolTip = 'Current Academic Year must have a value';
                //     TableRelation = "Academic Year Master-CS";

                // }
                field("Next Academic Year"; NextAcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Next Academic Year';
                    ToolTip = 'Next Academic Year must have a value';
                    TableRelation = "Academic Year Master-CS";

                }
                field("Start Date"; StartDate)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Start Date must have a value';
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'End Date must have a value';
                }
                field(Term; Term)
                {
                    ApplicationArea = All;
                    ToolTip = 'Term must have a value';
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
        MESSAGE('Document Copied Successfully');
    end;

    var

        CourseSemesterRec: Record "Course Sem. Master-CS";
        CourseSemesterRec1: Record "Course Sem. Master-CS";
        CourseSubjectLineRec: Record "Course Wise Subject Line-CS";
        CourseSubjectLnRec: Record "Course Wise Subject Line-CS";
        SemesterCode: Code[20];
        CurrentAcademicYear: Code[20];
        NextAcademicYear: Code[20];
        CourseCode: Code[20];
        StartDate: Date;
        EndDate: Date;
        Term: Option FALL,SPRING,SUMMER," ";
}


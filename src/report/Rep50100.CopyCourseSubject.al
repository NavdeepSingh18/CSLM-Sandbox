report 50100 "Copy Course Subject"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Course Wise Subject Head-CS"; "Course Wise Subject Head-CS")
        {

            trigger OnPreDataItem()
            begin
                if CourseCode = '' then
                    Error('Course Code must have value in it.');

                if CurrentAcademicYear = '' then
                    Error('Current Academic Year must have value in it.');

                if NextAcademicYear = '' then
                    Error('Next Academic Year must have value in it.');

                "Course Wise Subject Head-CS".SETRANGE("Course Wise Subject Head-CS".Course, CourseCode);
                "Course Wise Subject Head-CS".SETRANGE("Course Wise Subject Head-CS"."Academic Year", CurrentAcademicYear);
                IF SemesterCode <> '' THEN
                    "Course Wise Subject Head-CS".SetFilter("Course Wise Subject Head-CS".Semester, SemesterCode);
            end;

            trigger OnAfterGetRecord()
            begin
                CourseSubjectHeaderRec.INIT();
                CourseSubjectHeaderRec.TRANSFERFIELDS("Course Wise Subject Head-CS");
                CourseSubjectHeaderRec.VALIDATE("Academic Year", NextAcademicYear);
                CourseSubjectHeaderRec.INSERT(TRUE);

                CourseSubjectLineRec.RESET();
                CourseSubjectLineRec.SETRANGE("Course Code", "Course Wise Subject Head-CS".Course);
                CourseSubjectLineRec.SETRANGE(Semester, "Course Wise Subject Head-CS".Semester);
                CourseSubjectLineRec.SETRANGE("Academic Year", "Course Wise Subject Head-CS"."Academic Year");
                IF CourseSubjectLineRec.FINDFIRST() THEN
                    REPEAT
                        CourseSubjectLnRec.INIT();
                        CourseSubjectLnRec.TRANSFERFIELDS(CourseSubjectLineRec);
                        CourseSubjectLnRec.VALIDATE("Academic Year", NextAcademicYear);
                        CourseSubjectLnRec.INSERT(TRUE);
                    UNTIL CourseSubjectLineRec.NEXT() = 0;
            end;

        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Course Code"; CourseCode)
                {
                    ApplicationArea = All;
                    Caption = 'Course Code';
                    ToolTip = 'Course Code must have a value';
                    TableRelation = "Course Wise Subject Head-CS";
                }
                field("Current Academic Year"; CurrentAcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Current Academic Year';
                    ToolTip = 'Current Academic Year must have a value';
                    TableRelation = "Academic Year Master-CS";

                }
                field("Next Academic Year"; NextAcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Next Academic Year';
                    ToolTip = 'Next Academic Year must have a value';
                    TableRelation = "Academic Year Master-CS";

                }
                field("Semester Code"; SemesterCode)
                {
                    ApplicationArea = ALL;
                    TableRelation = "Semester Master-CS".code;
                    Caption = 'Semester';
                    ToolTip = 'Semester should have a value';
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

        CourseSubjectHeaderRec: Record "Course Wise Subject Head-CS";
        CourseSubjectLineRec: Record "Course Wise Subject Line-CS";
        CourseSubjectLnRec: Record "Course Wise Subject Line-CS";
        SemesterCode: Code[20];
        CurrentAcademicYear: Code[20];
        NextAcademicYear: Code[20];
        CourseCode: Code[20];
}


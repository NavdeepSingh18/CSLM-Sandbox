report 50121 "Course Subject Line dupCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Course Wise Subject Line-CS")
        {
            RequestFilterFields = "Course Code";

            trigger OnAfterGetRecord()
            begin
                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                CourseWiseSubjectLineCS.SETRANGE("Subject Code", "Subject Code");
                IF CourseWiseSubjectLineCS."Student Group" <> '' THEN
                    CourseWiseSubjectLineCS.SETRANGE("Student Group", "Student Group");
                IF CourseWiseSubjectLineCS.findset() THEN
                    IF CourseWiseSubjectLineCS.COUNT() >= 2 THEN BEGIN
                        CourseWiseSubjLCopyCS.init();
                        CourseWiseSubjLCopyCS."Course Code" := CourseWiseSubjectLineCS."Course Code";
                        CourseWiseSubjLCopyCS."Line No." += 10000;
                        CourseWiseSubjLCopyCS."Academic Year" := CourseWiseSubjectLineCS."Academic Year";
                        CourseWiseSubjLCopyCS.Semester := CourseWiseSubjectLineCS.Semester;
                        CourseWiseSubjLCopyCS."Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                        CourseWiseSubjLCopyCS.Insert();
                    END;
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

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CourseWiseSubjLCopyCS: Record "Course Wise Subj L-Copy-CS";
}


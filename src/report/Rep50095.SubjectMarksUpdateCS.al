report 50095 "Subject Marks UpdateCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Subject Master-CS"; "Subject Master-CS")
        {

            trigger OnAfterGetRecord()
            begin
                "Subject Master-CS".Credit := 8;
                "Subject Master-CS"."Internal Maximum" := 50;
                "Subject Master-CS"."External Maximum" := 100;
                "Subject Master-CS"."Total Maximum" := 150;
                "Subject Master-CS"."External Pass" := 40;
                "Subject Master-CS"."Total Pass" := 60;
                "Subject Master-CS".Modify();

                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Subject Code", "Subject Master-CS".Code);
                IF CourseWiseSubjectLineCS.findfirst() THEN
                    REPEAT
                        CourseWiseSubjectLineCS.Credit := 8;
                        CourseWiseSubjectLineCS."Internal Maximum" := 50;
                        CourseWiseSubjectLineCS."External Maximum" := 100;
                        CourseWiseSubjectLineCS."Total Maximum" := 150;
                        CourseWiseSubjectLineCS."External Pass" := 40;
                        CourseWiseSubjectLineCS."Total Pass" := 60;
                        CourseWiseSubjectLineCS.Modify();
                    UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
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
}


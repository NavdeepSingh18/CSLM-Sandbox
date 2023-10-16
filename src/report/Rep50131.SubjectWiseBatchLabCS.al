report 50131 "Subject Wise Batch & LabCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Batch&Lab Subject Wise-CS")
        {

            trigger OnAfterGetRecord()
            begin
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "Subject Code");
                SubjectMasterCS.SETRANGE("Subject Classification", 'LAB');
                IF SubjectMasterCS.findset() THEN
                    REPEAT
                        SubjectMasterCS."Applicable Batch" := Batch;
                        SubjectMasterCS."Number of Lab Component" := "Number of Lab";
                        SubjectMasterCS.Modify();
                    UNTIL SubjectMasterCS.NEXT() = 0;

                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Subject Code", "Subject Code");
                CourseWiseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", '2017-2018');
                IF CourseWiseSubjectLineCS.findset() THEN
                    REPEAT
                        CourseWiseSubjectLineCS."Applicable Batch" := Batch;
                        CourseWiseSubjectLineCS."Number of Lab Component" := "Number of Lab";
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
        SubjectMasterCS: Record "Subject Master-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
}


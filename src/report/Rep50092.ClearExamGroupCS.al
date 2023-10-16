report 50092 "Clear Exam GroupCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Course Wise Subject Head-CS"; "Course Wise Subject Head-CS")
        {
            dataitem("Course Wise Subject Line-CS"; "Course Wise Subject Line-CS")
            {
                DataItemLink = "Course Code" = FIELD(Course),
                               Semester = FIELD(Semester),
                               "Academic Year" = FIELD("Academic Year");

                trigger OnAfterGetRecord()
                begin
                    "Course Wise Subject Line-CS"."Int. Exam Group Generated" := FALSE;
                    "Course Wise Subject Line-CS"."Int. Exam Generated" := FALSE;
                    "Course Wise Subject Line-CS"."Assignment Generated" := FALSE;
                    "Course Wise Subject Line-CS"."Course Faculty Generated" := FALSE;
                    "Course Wise Subject Line-CS"."Exam Schedule Created" := FALSE;
                    "Course Wise Subject Line-CS".Modify();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Course Wise Subject Head-CS"."Int. Exam Group Generated" := FALSE;
                "Course Wise Subject Head-CS".Promoted := FALSE;
                "Course Wise Subject Head-CS".Modify();

                Counter := Counter + 1;
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                PROGRESS.close();
            end;

            trigger OnPreDataItem()
            begin
                TotalCount := COUNT();
                PROGRESS.OPEN(Text_10002Lbl);
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
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10002Lbl: Label ' PROCESSING....   @2 .', Comment = '@2 = Process Count';
}


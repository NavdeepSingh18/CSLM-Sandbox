report 50091 "Sitting Plan SY 2CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
        {
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                ExaminationLogDetailsCS.Reset();
                ExaminationLogDetailsCS.SETRANGE("Academic Year", "External Attendance Line-CS"."Academic Year");
                ExaminationLogDetailsCS.SETRANGE("Exam Date", "External Attendance Line-CS"."Exam Date");
                ExaminationLogDetailsCS.SETRANGE("Time Slot", "External Attendance Line-CS"."Exam Slot");
                IF NOT ExaminationLogDetailsCS.findfirst() THEN BEGIN
                    ExaminationLogDetailsCS.init();
                    ExaminationLogDetailsCS."Academic Year" := "External Attendance Line-CS"."Academic Year";
                    ExaminationLogDetailsCS."Exam Date" := "External Attendance Line-CS"."Exam Date";
                    ExaminationLogDetailsCS."Time Slot" := "External Attendance Line-CS"."Exam Slot";
                    ExaminationLogDetailsCS.Insert();
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
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";

}


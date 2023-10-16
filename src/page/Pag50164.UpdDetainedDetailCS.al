page 50164 "Upd Detained Detail-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    18-05-2019    Exam Schedule No. - OnLookup        Select and update fields.
    // 2         CSPL-00092    18-05-2019    Schedule No. - OnLookup             Select and update field
    // 3         CSPL-00092    18-05-2019    Update detained List - OnAction     Update Student Detained List
    // 4         CSPL-00092    18-05-2019    Released - OnAction                 Release Document
    // 5         CSPL-00092    18-05-2019    Re- Open - OnAction                 Reopen Document
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Exam Schedule No."; ExamSchedule)
                {
                    Caption = 'Exam Schedule No.';
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for Select and update fields::CSPL-00092::18-05-2019: Start
                        ExamTimeTableHeadCS.Reset();
                        IF PAGE.RUNMODAL(0, ExamTimeTableHeadCS) = ACTION::LookupOK THEN
                            ExamSchedule := ExamTimeTableHeadCS."No.";

                        SetupExaminationCS.GET();
                        ActualAttendacePer := SetupExaminationCS."Min. External Exam Attd. Per.";
                        //Code added for Select and update fields::CSPL-00092::18-05-2019: End
                    end;
                }
                field("Actual Attendance %"; ActualAttendacePer)
                {
                    Caption = 'Actual Attendance %';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New Attendance Per %"; UpdateDetained)
                {
                    Caption = 'New Attendance Per %';
                    ApplicationArea = All;
                }
            }
            group("Attendance Update")
            {
                Visible = false;
                field("Schedule No."; ExamSchedule1)
                {
                    ApplicationArea = All;
                    Caption = 'Schedule No.';
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for Select and update field::CSPL-00092::18-05-2019: Start
                        ExamTimeTableHeadCS.Reset();
                        IF PAGE.RUNMODAL(0, ExamTimeTableHeadCS) = ACTION::LookupOK THEN
                            ExamSchedule1 := ExamTimeTableHeadCS."No.";
                        //Code added for Select and update field::CSPL-00092::18-05-2019: End
                    end;
                }
                field("Academic Year"; AcademicYear)
                {
                    Caption = 'Academic Year';
                    ApplicationArea = All;
                    TableRelation = "Academic Year Master-CS";
                    Visible = false;
                }
                field("Subject Code"; SubjectCode)
                {
                    Caption = 'Subject Code';
                    ApplicationArea = All;
                    TableRelation = "Subject Master-CS".Code;
                }
                field("Student No."; "StudentNo.")
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update detained List")
            {
                Caption = 'Update';
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Update Student Detained List::CSPL-00092::18-05-2019: Start
                    ScheduleExamGenCS.UpdateDetainedListCS(ExamSchedule, UpdateDetained);
                    //Code added for Update Student Detained List::CSPL-00092::18-05-2019: End
                end;
            }
            action(Released)
            {
                Caption = 'Released';
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Release Document::CSPL-00092::18-05-2019: Start
                    IF ExamSchedule = '' THEN
                        ERROR('Please select the Schedule No.!!');
                    IF NOT CONFIRM(Text0001Lbl) THEN
                        EXIT
                    ELSE
                        ScheduleExamGenCS.ReleaseCS(ExamSchedule);
                    //Code added for Release Document::CSPL-00092::18-05-2019: End
                end;
            }
            action("Re- Open")
            {
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Reopen Document::CSPL-00092::18-05-2019: Start
                    IF ExamSchedule = '' THEN
                        ERROR('Please select the Schedule No.!!');
                    IF NOT CONFIRM(Text0002Lbl) THEN
                        EXIT
                    ELSE
                        ScheduleExamGenCS.ReopenCS(ExamSchedule);
                    //Code added for Reopen Document::CSPL-00092::18-05-2019: End
                end;
            }
        }
    }

    var

        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        SetupExaminationCS: Record "Setup Examination -CS";
        ScheduleExamGenCS: Codeunit "Schedule Exam Gen-CS";
        ActualAttendacePer: Decimal;
        ExamSchedule: Code[20];
        UpdateDetained: Decimal;
        ExamSchedule1: Code[20];
        "StudentNo.": Code[20];
        SubjectCode: Code[20];
        AcademicYear: Code[10];
        Text0001Lbl: Label 'Do you want to Released ?';
        Text0002Lbl: Label 'Do you want to Re-Open ?';

}


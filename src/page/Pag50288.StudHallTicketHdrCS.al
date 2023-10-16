page 50288 "Stud Hall Ticket Hdr-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                                                   Remarks
    // 1         CSPL-00092    18-05-2019    Get Subject - OnAction                                                    Generate document wise hall ticket.
    // 2         CSPL-00092    18-05-2019    Update the Attendance Per - OnAction                                      Update Student Attendance
    // 3         CSPL-00092    18-05-2019    Hall Ticket Generated Boolean Tick After Hall Ticket Print - OnAction     Hall Ticket Generated Boolean Tick After Hall Ticket Print

    Caption = 'Stud Hall Ticket Hdr';
    PageType = Document;
    SourceTable = "Admit Card Header-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Student No.';

                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Student Name';
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ToolTip = 'Enrollment No.';
                    ApplicationArea = All;

                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Course Code';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Semester';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                }
                field("No.Series"; Rec."No.Series")
                {
                    ToolTip = 'No.Series';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ToolTip = 'Section';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Exam Fee Total Amount"; Rec."Exam Fee Total Amount")
                {
                    ToolTip = 'Exam Fee Total Amount';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Receipt No.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                }
                field("Exam Schedule No."; Rec."Exam Schedule No.")
                {
                    ToolTip = 'Exam Schedule No.';
                    ApplicationArea = All;
                }
                field("Result Generated"; Rec."Result Generated")
                {
                    ToolTip = 'Result Generated';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            part("Stud Hall Ticket Hdr-CS"; 50289)
            {
                ToolTip = 'Stud Hall Ticket Hdr-CS';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Action")
            {
                action("Hall Ticket")
                {
                    ToolTip = 'Hall Ticket';
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(AdmitCardHeaderCS);
                        REPORT.RUN(50005, TRUE, FALSE, AdmitCardHeaderCS);
                    end;
                }
                action("Hall Ticket With Due ")
                {
                    ToolTip = 'Hall Ticket With Due';
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(AdmitCardHeaderCS);
                        REPORT.RUN(50006, TRUE, FALSE, AdmitCardHeaderCS);
                    end;
                }
                action("Get Subject")
                {
                    ToolTip = 'Get Subject';
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
                    begin
                        //Code added for Generate document wise hall ticket ::CSPL-00092::18-05-2019: Start
                        InformationOfStudentCS.DocumentWiseHallTicketCreationCS(Rec);
                        //Code added for Generate document wise hall ticket ::CSPL-00092::18-05-2019: End
                    end;
                }
                action("Update the Attendance Per")
                {
                    ToolTip = 'Update the Attendance Per';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Update Student Attendance::CSPL-00092::18-05-2019: Start
                        IF NOT CONFIRM(Text0001Msg) THEN
                            EXIT
                        ELSE
                            ScheduleExamGenCS.UpdateAttendancePerCS(Rec."No.");
                        //Code added for Update Student Attendance::CSPL-00092::18-05-2019: End
                    end;
                }
                action("Hall Ticket Generated Boolean Tick After Hall Ticket Print")
                {
                    ToolTip = 'Hall Ticket Generated Boolean Tick After Hall Ticket Print';
                    Caption = 'Hall Ticket Generated Boolean Tick After Hall Ticket Print';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Hall Ticket Generated Boolean Tick After Hall Ticket Print::CSPL-00092::18-05-2019: Start
                        IF CONFIRM(Text0003Msg) THEN BEGIN
                            AdmitCardHeaderCS1.RESET();
                            AdmitCardHeaderCS1.SETRANGE(AdmitCardHeaderCS1."Exam Schedule No.", Rec."Exam Schedule No.");
                            AdmitCardHeaderCS1.SETRANGE(AdmitCardHeaderCS1."Result Generated", FALSE);
                            IF AdmitCardHeaderCS1.FINDSET() THEN
                                REPEAT
                                    AdmitCardHeaderCS1."Result Generated" := TRUE;
                                    AdmitCardHeaderCS1.MODIFY();
                                UNTIL AdmitCardHeaderCS1.NEXT() = 0;
                            MESSAGE('%1 %2', AdmitCardHeaderCS1."Exam Schedule No.", Text0002Msg)
                        END ELSE
                            EXIT;

                        //Code added for Hall Ticket Generated Boolean Tick After Hall Ticket Print::CSPL-00092::18-05-2019:End
                    end;
                }
            }
        }
    }

    var
        AdmitCardHeaderCS1: Record "Admit Card Header-CS";
        AdmitCardHeaderCS: Record "Admit Card Header-CS";
        ScheduleExamGenCS: Codeunit "Schedule Exam Gen-CS";
        Text0001Msg: Label 'Do you want to Update the Attendance Per ?';
        Text0002Msg: Label 'Schedule No. Result Generated Successfully Update.';
        Text0003Msg: Label 'Do you want to Update  Result Generated Boolean ?';
}
page 50281 "Time Tbl Detail-CS"
{
    // version V.001-CS
    Caption = 'Time Table Summary/Final Time Table list';
    PageType = List;
    SourceTable = "Final Class Time Table-CS";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = sorting("Time Table  Document No.") order(descending);
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Time Table  Document No."; Rec."Time Table  Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Time Slot Code"; Rec."Time Slot Code")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field(Interval; Rec.Interval)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Interval Type"; Rec."Interval Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ApplicationArea = All;
                }
                Field("Topic Code"; Rec."Topic Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Topic Description"; Rec."Topic Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Course code"; Rec."Course code")
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Code"; Rec."Academic Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                }
                field("Atttendance By"; Rec."Atttendance By")
                {
                    ApplicationArea = All;
                }
                field(Attendance; Rec.Attendance)
                {
                    ApplicationArea = All;
                }
                field("Absent Reascon Code"; Rec."Absent Reascon Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty 1Code"; Rec."Faculty 1Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty 2 Code"; Rec."Faculty 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty 3 Code"; Rec."Faculty 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty 4 Code"; Rec."Faculty 4 Code")
                {
                    ApplicationArea = All;
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field("S.No."; Rec."S.No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                Field("Time Table Line No."; Rec."Time Table Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("S.No. Grouping"; Rec."S.No. Grouping")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            // action("Topic Covered")
            // {
            //     Caption = '&Topic Covered';
            //     PromotedOnly = true;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Image = SetupList;
            //     Visible = false;
            //     ApplicationArea = All;
            //     RunObject = Page "Time Table Topic List";
            //     RunPageLink = "S.No." = FIELD("S.No.");

            // }
            action("Show Attendance Document")
            {
                ApplicationArea = All;
                Image = Document;
                PromotedCategory = Process;
                Promoted = True;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnACtion()
                var
                    StudentAttendanceHdr: Record "Class Attendance Header-CS";
                    SubjectClassification: Record "Subject Classification-CS";
                    AttandanceStudentHdr: Page "Attendance Student Hdr-CS";
                Begin
                    SubjectClassification.Reset();
                    SubjectClassification.SetRange(Code, Rec."Subject Class");
                    IF SubjectClassification.FindFirst() then
                        If SubjectClassification."Attendance Not Applicable" then
                            Error('Attendance not applicable for %1', Rec."Subject Class");

                    StudentAttendanceHdr.Reset();
                    StudentAttendanceHdr.SetRange("Time Table No", Rec."S.No.");
                    AttandanceStudentHdr.SetTableView(StudentAttendanceHdr);
                    AttandanceStudentHdr.Run();
                End;
            }
        }
    }



}


page 50120 "Time Table Buffer List"
{
    Caption = 'Time Table Buffer List';
    PageType = ListPart;
    SourceTable = "Time Table Buffer";
    //ApplicationArea = All;
    UsageCategory = none;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Time Table Document No."; Rec."Time Table Document No.")
                {
                    ApplicationArea = All;
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
                // field(Interval; Rec.Interval)
                // {
                //     ApplicationArea = All;
                // }
                // field("Interval Type"; Rec."Interval Type")
                // {
                //     ApplicationArea = All;
                // }
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
                Field("Subject Group"; Rec."Subject Group")
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
                // field("Attendance Date"; Rec."Attendance Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Atttendance By"; Rec."Atttendance By")
                // {
                //     ApplicationArea = All;
                // }
                // field(Attendance; Rec.Attendance)
                // {
                //     ApplicationArea = All;
                // }
                // field("Absent Reascon Code"; Rec."Absent Reascon Code")
                // {
                //     ApplicationArea = All;
                // }
                Field("Faculty Category"; Rec."Faculty Category")
                {
                    ApplicationArea = All;
                }
                field("Faculty 1Code"; Rec."Faculty 1Code")
                {
                    ApplicationArea = All;
                }
                Field("Faculty Name 1"; Rec."Faculty Name 1")
                {
                    ApplicationArea = All;
                }
                field("Faculty 2 Code"; Rec."Faculty 2 Code")
                {
                    ApplicationArea = All;
                }
                Field("Faculty Name 2"; Rec."Faculty Name 2")
                {
                    ApplicationArea = All;
                }
                field("Faculty 3 Code"; Rec."Faculty 3 Code")
                {
                    ApplicationArea = All;
                }
                Field("Faculty Name 3"; Rec."Faculty Name 3")
                {
                    ApplicationArea = All;
                }
                field("Faculty 4 Code"; Rec."Faculty 4 Code")
                {
                    ApplicationArea = All;
                }
                Field("Faculty Name 4"; Rec."Faculty Name 4")
                {
                    ApplicationArea = All;
                }
                // field(Cancelled; Rec.Cancelled)
                // {
                //     ApplicationArea = All;
                // }
                // field(Updated; Rec.Updated)
                // {
                //     ApplicationArea = All;
                // }
                field("S.No."; Rec."S.No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                // field("Extra Class"; Rec."Extra Class")
                // {
                //     ApplicationArea = All;
                // }
                // field("Open Elective"; Rec."Open Elective")
                // {
                //     ApplicationArea = All;
                // }
                Field("Final TimeTable Generated"; Rec."Final TimeTable Generated")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Time Table Upload")
            {
                ApplicationArea = All;
                Visible = false;
                Image = UpdateXML;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Final Time Table Upload';
                Runobject = XmlPort "Final Time Table Upload";
            }
            action("Select All")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                //Enabled = ApproveButtonEnable;
                Trigger OnAction()
                var
                    TimeTableBuffer: Record "Time Table Buffer";
                Begin
                    TimeTableBuffer.Reset();
                    TimeTableBuffer.SetRange("Time Table Document No.", Rec."Time Table Document No.");
                    If TimeTableBuffer.FindFirst() then
                        TimeTableBuffer.ModifyAll(Select, true);



                End;

            }
            action("Approve")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Approve';
                //Enabled = ApproveButtonEnable;
                trigger OnAction()
                var
                    FinalClassTimeTable_lRec: Record "Final Class Time Table-CS";
                    ClassTimeTableHdr: Record "Class Time Table Header-CS";
                    AlreadyCreated: Boolean;
                begin

                    IF NOT CONFIRM('Do you want to Approve the Time Table?', FALSE) THEN
                        EXIT;

                    AlreadyCreated := false;
                    TimeTableBufferRec.Reset();
                    TimeTableBufferRec.SetRange(Select, true);
                    TimeTableBufferRec.SetRange("Time Table Document No.", Rec."Time Table Document No.");
                    TimeTableBufferRec.SetRange("Final TimeTable Generated", false);
                    if TimeTableBufferRec.FindFirst() then
                        AlreadyCreated := true;

                    If AlreadyCreated then begin
                        TimeTableBufferRec.Reset();
                        TimeTableBufferRec.SetRange(Select, true);
                        TimeTableBufferRec.SetRange("Time Table Document No.", Rec."Time Table Document No.");
                        TimeTableBufferRec.SetRange("Final TimeTable Generated", false);
                        if TimeTableBufferRec.FindSet() then begin
                            repeat
                                // CopyTableData();
                                FinalClassTimeTableRec.RESET();
                                FinalClassTimeTableRec.SetRange("Time Table  Document No.", TimeTableBufferRec."Time Table Document No.");
                                FinalClassTimeTableRec.SetRange("Time Slot Code", TimeTableBufferRec."Time Slot Code");
                                FinalClassTimeTableRec.SetRange("Room No", TimeTableBufferRec."Room No");
                                FinalClassTimeTableRec.SetRange(Batch, TimeTableBufferRec.Batch);
                                FinalClassTimeTableRec.SetRange("Subject Code", Rec."Subject Code");
                                FinalClassTimeTableRec.SetRange(Date, TimeTableBufferRec.Date);
                                FinalClassTimeTableRec.SetRange(Section, TimeTableBufferRec.Section);
                                IF Not FinalClassTimeTableRec.FINDFIRST() THEN begin

                                    FinalClassTimeTable_lRec.Reset();
                                    FinalClassTimeTable_lRec.SetRange("Time Slot Code", TimeTableBufferRec."Time Slot Code");
                                    FinalClassTimeTable_lRec.SetRange("Room No", TimeTableBufferRec."Room No");
                                    FinalClassTimeTable_lRec.SetRange(Date, TimeTableBufferRec.Date);
                                    IF TimeTableBufferRec."Faculty 1Code" <> '' then
                                        FinalClassTimeTable_lRec.SetRange("Faculty 1Code", TimeTableBufferRec."Faculty 1Code");
                                    IF FinalClassTimeTable_lRec.FindFirst() then
                                        Error('Room No : %1 , Time Slot : %2 , Date : %3 , Faculty ID : %4 is already exist.', FinalClassTimeTable_lRec."Room No", FinalClassTimeTable_lRec."Time Slot Code", FinalClassTimeTable_lRec.Date, FinalClassTimeTable_lRec."Faculty 1Code");

                                    FinalClassTimeTable_lRec.Reset();
                                    If FinalClassTimeTable_lRec.FindLast() then;
                                    FinalClassTimeTableRec.INIT();
                                    FinalClassTimeTableRec."S.No." := FinalClassTimeTable_lRec."S.No." + 1;
                                    //FinalClassTimeTableRec.TRANSFERFIELDS(TimeTableBufferRec);
                                    FinalClassTimeTableRec.Date := TimeTableBufferRec.Date;
                                    FinalClassTimeTableRec."Time Slot Code" := TimeTableBufferRec."Time Slot Code";
                                    FinalClassTimeTableRec."Start Time" := TimeTableBufferRec."Start Time";
                                    FinalClassTimeTableRec."End Time" := TimeTableBufferRec."End Time";
                                    FinalClassTimeTableRec."Room No" := TimeTableBufferRec."Room No";
                                    FinalClassTimeTableRec.Batch := TimeTableBufferRec.Batch;
                                    FinalClassTimeTableRec.Section := TimeTableBufferRec.Section;
                                    FinalClassTimeTableRec."Subject Group" := TimeTableBufferRec."Subject Group";
                                    FinalClassTimeTableRec."Subject Class" := TimeTableBufferRec."Subject Class";
                                    FinalClassTimeTableRec."Subject Code" := TimeTableBufferRec."Subject Code";
                                    FinalClassTimeTableRec."Subject Name" := TimeTableBufferRec."Subject Name";
                                    FinalClassTimeTableRec."Course code" := TimeTableBufferRec."Course code";
                                    FinalClassTimeTableRec."Course Name" := TimeTableBufferRec."Course Name";
                                    FinalClassTimeTableRec.Semester := TimeTableBufferRec.Semester;
                                    FinalClassTimeTableRec."Academic Code" := TimeTableBufferRec."Academic Code";
                                    FinalClassTimeTableRec.Term := TimeTableBufferRec.Term;
                                    FinalClassTimeTableRec."Global Dimension 1 Code" := TimeTableBufferRec."Global Dimension 1 Code";
                                    FinalClassTimeTableRec."Faculty 1Code" := TimeTableBufferRec."Faculty 1Code";
                                    FinalClassTimeTableRec."Faculty 2 Code" := TimeTableBufferRec."Faculty 2 Code";
                                    FinalClassTimeTableRec."Faculty 3 Code" := TimeTableBufferRec."Faculty 3 Code";
                                    FinalClassTimeTableRec."Faculty 4 Code" := TimeTableBufferRec."Faculty 4 Code";
                                    FinalClassTimeTableRec."Time Table  Document No." := TimeTableBufferRec."Time Table Document No.";
                                    FinalClassTimeTableRec.Year := TimeTableBufferRec.Year;
                                    FinalClassTimeTableRec.INSERT();
                                end;
                                TimeTableBufferRec."Final TimeTable Generated" := true;
                                TimeTableBufferRec.Modify();
                            until TimeTableBufferRec.Next() = 0;
                            InsertClassAttendanceLine();
                            MESSAGE('The Time Table has been Generated for Document No. %1', Rec."Time Table Document No.");

                        end;

                        If Confirm('Do you want to generate Student Attendance.?', true) then begin
                            FinalClassTimeTableRec.Reset();
                            FinalClassTimeTableRec.SetRange("Time Table  Document No.", Rec."Time Table Document No.");
                            IF FinalClassTimeTableRec.FindSet() then begin
                                repeat
                                    SubjectDetail.Reset();
                                    SubjectDetail.SetRange(Code, FinalClassTimeTableRec."Subject Class");
                                    IF SubjectDetail.FindFirst() then
                                        If not SubjectDetail."Attendance Not Applicable" then
                                            ClassTimeTableHdr.AttendanceGeneratedforStudents(FinalClassTimeTableRec);
                                until FinalClassTimeTableRec.Next() = 0;

                                Message('Student Attendance has been generated.');

                                ClassTimeTableHdr.Reset();
                                ClassTimeTableHdr.SetRange("No.", Rec."Time Table Document No.");
                                IF ClassTimeTableHdr.FindFirst() then begin
                                    ClassTimeTableHdr."Time Table Status" := ClassTimeTableHdr."Time Table Status"::Generated;
                                    ClassTimeTableHdr."Using TTBuffer" := true;
                                    ClassTimeTableHdr.Modify();
                                end;

                                TimeTableBufferRec.Reset();
                                TimeTableBufferRec.SetRange("Time Table Document No.", Rec."Time Table Document No.");
                                IF TimeTableBufferRec.FindFirst() then
                                    TimeTableBufferRec.DeleteAll();




                            end;

                        end;
                    end Else
                        Error('Final Time Table already generated for this Document : %1', Rec."Time Table Document No.");
                end;

            }
        }
    }
    // procedure CopyTableData()
    // Var
    //     TimeTableBufferRec: Record "Time Table Buffer";
    //     FinalClassTimeTableRec: Record "Final Class Time Table-CS";
    // begin
    //     FinalClassTimeTableRec.RESET();
    //     FinalClassTimeTableRec.SetRange("Time Table  Document No.", "Time Table Document No.");
    //     FinalClassTimeTableRec.SetRange("Time Slot Code", "Time Slot Code");
    //     FinalClassTimeTableRec.SetRange("Room No", "Room No");
    //     FinalClassTimeTableRec.SetRange(Batch, Batch);
    //     FinalClassTimeTableRec.SetRange("Subject Code", "Subject Code");
    //     FinalClassTimeTableRec.SetRange(Date, Date);
    //     FinalClassTimeTableRec.SetRange("Faculty 1Code", "Faculty 1Code");
    //     IF Not FinalClassTimeTableRec.FINDFIRST() THEN begin
    //         // TimeTableBufferRec.RESET();
    //         // IF TimeTableBufferRec.FINDFIRST() THEN
    //         //     REPEAT
    //         FinalClassTimeTableRec.INIT();
    //         FinalClassTimeTableRec.TRANSFERFIELDS(TimeTableBufferRec);
    //         FinalClassTimeTableRec.INSERT();
    //         //    UNTIL TimeTableBufferRec.NEXT() = 0;
    //     end;
    // end;

    var
        TimeTableBufferRec: Record "Time Table Buffer";
        FinalClassTimeTableRec: Record "Final Class Time Table-CS";
        SubjectDetail: Record "Subject Classification-CS";
        ClassTimeTableHdr: Record "Class Time Table Header-CS";
        ApproveButtonEnable: Boolean;


    trigger OnAfterGetRecord()
    begin
        ApproveButtonEnable := false;
        TimeTableBufferRec.Reset();
        TimeTableBufferRec.SetRange("Time Table Document No.", Rec."Time Table Document No.");
        TimeTableBufferRec.SetRange(Select, true);
        TimeTableBufferRec.SetRange("Final TimeTable Generated", false);
        IF TimeTableBufferRec.FindFirst() then
            ApproveButtonEnable := true;
    end;

    trigger OnOpenPage()
    begin
        ApproveButtonEnable := false;
        TimeTableBufferRec.Reset();
        TimeTableBufferRec.SetRange("Time Table Document No.", Rec."Time Table Document No.");
        TimeTableBufferRec.SetRange(Select, true);
        TimeTableBufferRec.SetRange("Final TimeTable Generated", false);
        IF TimeTableBufferRec.FindFirst() then
            ApproveButtonEnable := true;
    end;

    procedure InsertClassAttendanceLine()
    Var
        FinalTimeTable: Record "Final Class Time Table-CS";
        ClassAttendanceline: Record "Class Time Table Line-CS";
        ClassAttendanceline1: Record "Class Time Table Line-CS";
        Date_lRec: Record Date;
        LineNo: Integer;
    Begin
        FinalTimeTable.Reset();
        FinalTimeTable.SetRange("Time Table  Document No.", Rec."Time Table Document No.");
        IF FinalTimeTable.FindSet() then begin
            repeat
                ClassAttendanceline1.Reset();
                ClassAttendanceline1.SetRange("Document No.", FinalTimeTable."Time Table  Document No.");
                IF ClassAttendanceline1.FindLast() then
                    LineNo := ClassAttendanceline1."Line No." + 10000
                Else
                    LineNo := 10000;

                ClassAttendanceline.INIT();
                ClassAttendanceline."Document No." := FinalTimeTable."Time Table  Document No.";
                ClassAttendanceline."Line No." := LineNo;
                Date_lRec.Reset();
                Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
                Date_lRec.SetRange("Period Start", FinalTimeTable.Date);
                IF Date_lRec.FindFirst() then
                    Evaluate(ClassAttendanceline.Day, Date_lRec."Period Name");
                ClassAttendanceline."Start Date" := FinalTimeTable.Date;
                ClassAttendanceline."Time Slot" := FinalTimeTable."Time Slot Code";
                ClassAttendanceline."Room No" := FinalTimeTable."Room No";
                ClassAttendanceline.Batch := FinalTimeTable.Batch;
                ClassAttendanceline.Section := FinalTimeTable.Section;
                ClassAttendanceline."Subject Group" := FinalTimeTable."Subject Group";
                ClassAttendanceline."Subject Class" := FinalTimeTable."Subject Class";
                ClassAttendanceline."Subject Code" := FinalTimeTable."Subject Code";
                ClassAttendanceline."Subject Name" := FinalTimeTable."Subject Name";
                ClassAttendanceline.Term := FinalTimeTable.Term;
                ClassAttendanceline."Global Dimension 1 Code" := FinalTimeTable."Global Dimension 1 Code";
                ClassAttendanceline."Faculty 1 Code" := FinalTimeTable."Faculty 1Code";
                ClassAttendanceline.Validate("Faculty 1 Code");
                ClassAttendanceline."Faculty 2 Code" := FinalTimeTable."Faculty 2 Code";
                ClassAttendanceline.Validate("Faculty 2 Code");
                ClassAttendanceline."Faculty 3 Code" := FinalTimeTable."Faculty 3 Code";
                ClassAttendanceline.Validate("Faculty 3 Code");
                ClassAttendanceline."Faculty 4 Code" := FinalTimeTable."Faculty 4 Code";
                ClassAttendanceline.Validate("Faculty 4 Code");
                ClassAttendanceline.INSERT();
            until FinalTimeTable.Next() = 0;
        end;
    End;

}


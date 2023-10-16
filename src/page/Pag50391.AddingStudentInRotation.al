page 50391 AddingStudentInRotation
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Header";
    SourceTableView = where(Status = filter(<> cancelled));
    Caption = 'Adding Student(s) in Rotation';
    DataCaptionExpression = SubjectGroup + ' - ' + GroupDescription;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group("Course Details Input")
            {
                field(StudentNo; StudentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(StudentName; StudentName)
                {
                    ApplicationArea = All;
                    Caption = 'Student Name';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(EnrollmentNo; EnrollmentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(AcademicYear; AcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(GSemester; GSemester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                    Style = Unfavorable;
                    Editable = false;
                }
                field(WeekScheduled; WeekScheduled)
                {
                    ApplicationArea = All;
                    Caption = 'Scheduled Week(s)';
                    Style = Strong;
                    Editable = false;
                }
                field(PendingWeeks; PendingWeeks)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Week(s)';
                    Style = Strong;
                    Editable = false;
                }
            }
            repeater("Rotation's List")
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = true;
                    LookupPageId = "Hospital Inventory Lookup";
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Umbrella Rotation"; Rec."Umbrella Rotation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Umbrella Rotation field.';
                }
                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(AvblSeats; AvblSeats)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    Caption = 'Available Seats in Rotation';
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Add in Rotation")
            {
                ApplicationArea = All;
                Caption = 'Add in Rotation';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    RLE: Record "Roster Ledger Entry";
                    LastEntryNo: Integer;
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if PendingWeeks - Rec."No. of Weeks" < 0 then
                        Error('It is not allowed to Add Student No. %1 (%2) in %3 week(s) rotation as only %4 week(s) are remaining.', StudentNo, StudentName, Rec."No. of Weeks", PendingWeeks);

                    Rec.CalcFields("No. of Students");

                    // if AvblSeats <= 0 then  //CSPL-00307-RTP - as per ajay
                    //     Error('Seat is not available in Rotation No. %1.', "Rotation ID")
                    // else begin
                    if not Confirm('Do you want to add the Student in Rotation No. %1 with Hospital (%2 - %3) which is stating from %4 to %5?', true, Rec."Rotation ID", Rec."Hospital ID", Rec."Hospital Name", Rec."Start Date", Rec."End Date") then
                        exit;

                    StudentMaster.Reset();
                    IF StudentMaster.Get(StudentNo) THEN;

                    RosterSchedulingLine.Init();
                    RosterSchedulingLine."Rotation ID" := Rec."Rotation ID";
                    RosterSchedulingLine."Clerkship Type" := Rec."Clerkship Type";
                    RosterSchedulingLine."Academic Year" := Rec."Academic Year";
                    RosterSchedulingLine.Validate("Student No.", StudentNo);
                    RosterSchedulingLine."Course Code" := Rec."Course Code";
                    RosterSchedulingLine."Course Description" := Rec."Course Description";
                    RosterSchedulingLine.Validate("Course Prefix Code", Rec."Course Prefix");
                    RosterSchedulingLine."Course Type" := Rec."Course Type";
                    RosterSchedulingLine."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    RosterSchedulingLine."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    RosterSchedulingLine."Start Date" := Rec."Start Date";
                    RosterSchedulingLine."End Date" := Rec."End Date";
                    RosterSchedulingLine."No. of Weeks" := Rec."No. of Weeks";
                    RosterSchedulingLine.Validate("Hospital ID", Rec."Hospital ID");
                    RosterSchedulingLine."Coordinator ID" := StudentMaster."Clinical Coordinator";
                    RosterSchedulingLine."Document Specialist ID" := StudentMaster."Document Specialist";
                    RosterSchedulingLine."Student Status" := RosterSchedulingLine."Student Status"::" ";
                    RosterSchedulingLine.Status := RosterSchedulingLine.Status::Scheduled;//CSPL-00307-RTP
                    RosterSchedulingLine."Rotation Confirmed" := Rec."Rotation Confirmed";//CSPL-00307-RTP
                    RosterSchedulingLine.AutoPublishHoldRemoval := true;
                    if Rec."No. of Students" + 1 > Rec."No. of Seats" then begin
                        RosterSchedulingLine.Status := RosterSchedulingLine.Status::Unconfirmed;
                        RosterSchedulingLine.Waitlisted := true;
                    end;

                    RosterSchedulingLine."Scheduled By" := UserId;
                    RosterSchedulingLine."Scheduled On" := Today;

                    if Rec.Status = Rec.Status::Published then begin
                        RosterSchedulingLine."Published By" := UserId;
                        RosterSchedulingLine."Published On" := Today;
                    end;
                    If SetStatusOnHOLD(RosterSchedulingLine) Then
                        RosterSchedulingLine.Status := RosterSchedulingLine.Status::"On Hold";
                    if RosterSchedulingLine.Insert(true) then;
                    IF RosterSchedulingLine.Status = RosterSchedulingLine.Status::"On Hold" then begin
                        StudentMaster.Reset();
                        if StudentMaster.Get(RosterSchedulingLine."Student No.") then begin
                            StudentMaster.CalcFields("Clinical Hold Exist");
                            //     if StudentMaster."Clinical Hold Exist" then begin
                            //         ClinicalNotification.HOLDRotationNotificationCore(RosterSchedulingLine);
                            // end;
                        end;
                    end;
                    // if Status = Status::Published then begin
                    //     RLE.Reset();
                    //     if RLE.FindLast() then
                    //         LastEntryNo := RLE."Entry No.";

                    //     LastEntryNo += 1;
                    // RosterSchedulingLine.PublishRotation(RosterSchedulingLine, LastEntryNo);
                    // end;
                    Message('Student No. %1 (%2) is added to Rotation No. %3.', StudentNo, StudentName, Rec."Rotation ID");
                    CurrPage.Close();
                    // end;//CSPL-00307-RTP
                end;
            }
        }
    }

    var
        SubjectGroup: Code[20];
        GroupDescription: Text[100];
        StudentNo: Code[20];
        StudentName: Text[100];
        EnrollmentNo: Code[20];
        AcademicYear: Code[20];
        GSemester: Code[20];
        AvblSeats: Integer;
        WeekScheduled: Integer;
        PendingWeeks: Integer;

    procedure SetVariables(
        LSubjectGroup: Code[20];
        LGroupDescription: Text[100];
        LStudentNo: Code[20];
        LStudentName: Text[100];
        LEnrollmentNo: Code[20];
        LAcademicYear: Code[20];
        LSemester: Code[20];
        LWeekScheduled: Integer;
        LPendingWeeks: Integer)
    begin
        SubjectGroup := LSubjectGroup;
        GroupDescription := LGroupDescription;
        StudentNo := LStudentNo;
        StudentName := LStudentName;
        EnrollmentNo := LEnrollmentNo;
        AcademicYear := LAcademicYear;
        GSemester := LSemester;
        WeekScheduled := LWeekScheduled;
        PendingWeeks := LPendingWeeks;
    end;

    procedure SetStatusOnHOLD(Var RosterSchedulingLine: record "Roster Scheduling Line"): Boolean
    var
        StudentMaster: Record "Student Master-CS";
        RemediateGroupCodes: text;
        StudentGroup: record "Student Group";
    begin
        //CSPL-00307-RTP
        StudentMaster.Reset();
        if StudentMaster.Get(RosterSchedulingLine."Student No.") then begin
            StudentMaster.CalcFields("Clinical Hold Exist", "Bursar Hold");
            if StudentMaster."Clinical Hold Exist" OR StudentMaster."Bursar Hold" then begin
                if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Core then
                    exit(true);
            end;
        end;

        RemediateGroupCodes := 'REMER|REMFM|REMFM1|REMIM|REMOBGYN|REMPED|REMPSY|REMSUR';
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", RosterSchedulingLine."Student No.");
        StudentGroup.SetFilter("Groups Code", RemediateGroupCodes);
        StudentGroup.SetRange(Blocked, false);
        if StudentGroup.FindFirst() then begin
            exit(true);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        AvblSeats := Rec."No. of Seats" - Rec."No. of Students";
    end;
}
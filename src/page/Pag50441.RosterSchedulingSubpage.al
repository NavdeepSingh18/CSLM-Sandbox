page 50441 "Roster Scheduling Subpage"
{
    PageType = Listpart;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Line";
    Caption = 'Roster Scheduling Lines';
    SourceTableView = sorting("Rotation No.");

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Rotation No."; Rec."Rotation No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(StudentStatus; StudentStatus)
                {
                    Caption = 'Student Status';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ScheduledRotationWeeks; ScheduledRotationWeeks)
                {
                    Caption = 'Scheduled Rotation Weeks';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(PublishedRotationWeeks; PublishedRotationWeeks)
                {
                    Caption = 'Published Rotation Weeks';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(PendingRotationWeeks; PendingRotationWeeks)
                {
                    Caption = 'Pending Rotation Weeks';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    OptionCaption = 'Scheduled,,,Unconfirmed,,,';
                    trigger OnValidate()
                    var
                        RosterSchedulingHeader: Record "Roster Scheduling Header";
                        RosterSchedulingLine: Record "Roster Scheduling Line";
                        TotalScheduled: Integer;
                        TotalAllowed: Integer;
                    begin
                        RosterSchedulingHeader.Reset();
                        if RosterSchedulingHeader.Get(Rec."Rotation ID") then;
                        TotalAllowed := RosterSchedulingHeader."No. of Seats";
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                        TotalScheduled := RosterSchedulingLine.Count;

                        if Rec.Status = Rec.Status::Scheduled then begin
                            TotalScheduled := TotalScheduled + 1;
                            if TotalScheduled > TotalAllowed then
                                Error('Scheduled Students can not be more than %1 in the Rotation ID %2.\\\Allowed Students for the Rotation are %3.', TotalAllowed, Rec."Rotation ID", TotalAllowed);
                        end;

                        if Rec.Status = Rec.Status::Unconfirmed then
                            Rec.Validate("Rotation Confirmed", false);

                        IF xRec.Status = xRec.Status::Published then
                            Error('You Can Not Change a Published Rotation');
                    end;
                }
                field(Waitlisted; Rec.Waitlisted)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Rotation Confirmed"; Rec."Rotation Confirmed")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Coordinator ID"; Rec."Coordinator ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Future Rotation List")
            {
                ApplicationArea = All;
                Caption = 'Future Rotation List';
                ShortcutKey = 'Ctrl+R';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromJob;

                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                begin
                    RSL.Reset();
                    RSL.SetRange("Student No.", Rec."Student No.");
                    RSL.SetFilter("Start Date", '>%1', Rec."End Date");
                    Page.RunModal(Page::"Roster Scheduling Lines", RSL);
                end;
            }
        }
    }


    var
        StudentStatus: Text[100];
        ScheduledRotationWeeks: Integer;
        PublishedRotationWeeks: Integer;
        PendingRotationWeeks: Integer;

    trigger OnAfterGetRecord()
    Var
        StudentMaster: Record "Student Master-CS";
        RecStudentStatus: Record "Student Status";
        RosterSchedulingLine: Record "Roster Scheduling Line";
    begin
        StudentMaster.Reset();
        if StudentMaster.Get(Rec."Student No.") then;

        StudentStatus := '';
        ScheduledRotationWeeks := 0;
        PublishedRotationWeeks := 0;
        PendingRotationWeeks := 0;
        RecStudentStatus.Reset();
        if RecStudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then
            StudentStatus := RecStudentStatus.Description;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.", "Clerkship Type", Status, "Rotation Confirmed");
        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
        RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
        RosterSchedulingLine.SetRange("Rotation Confirmed", true);
        RosterSchedulingLine.CalcSums("No. of Weeks");
        ScheduledRotationWeeks := RosterSchedulingLine."No. of Weeks";

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.", "Clerkship Type", Status, "Rotation Confirmed");
        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
        RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
        RosterSchedulingLine.SetRange("Rotation Confirmed", true);
        RosterSchedulingLine.CalcSums("No. of Weeks");
        PublishedRotationWeeks := RosterSchedulingLine."No. of Weeks";

        PendingRotationWeeks := 84 - PublishedRotationWeeks;
        //CSPL-00307-RTP
    end;

}
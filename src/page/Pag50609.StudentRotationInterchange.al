page 50609 "Student Rotation Interchange"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Line";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group("Interchange")
            {
                group("Existing Rotation Information")
                {
                    field("Rotation ID"; Rec."Rotation ID")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Hospital ID"; Rec."Hospital ID")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Hospital Name"; Rec."Hospital Name")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Student No."; Rec."Student No.")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Student Name"; Rec."Student Name")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course Code"; Rec."Course Code")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course Description"; Rec."Course Description")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Start Date"; Rec."Start Date")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("No. of Weeks"; Rec."No. of Weeks")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("End Date"; Rec."End Date")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                }
                group("New Rotation Values")
                {
                    field(NewRotationID; NewRotationID)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Caption = 'Rotation ID';
                        ShowMandatory = true;
                        Editable = false;

                        trigger OnDrillDown()
                        var
                            RosterSchedulingHeader: Record "Roster Scheduling Header";
                            AvblSeats: Integer;
                        begin
                            RosterSchedulingHeader.Reset();
                            RosterSchedulingHeader.FilterGroup(2);
                            RosterSchedulingHeader.SetRange("Course Code", Rec."Course Code");
                            RosterSchedulingHeader.SetFilter("Start Date", '>=%1', Rec."Start Date");
                            if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
                                RosterSchedulingHeader.SetRange("Elective Course Code", Rec."Elective Course Code");
                            RosterSchedulingHeader.FilterGroup(0);
                            // IF Page.RUNMODAL(Page::"Roster List", RosterSchedulingHeader) = ACTION::LookupOK THEN begin
                            //     NewRotationID := RosterSchedulingHeader."Rotation ID";

                            //     if NewRotationID = Rec."Rotation ID" then
                            //         Error('You can not Select %1 Rotation ID for Rotation Interchange.', NewRotationID);

                            //     RosterSchedulingHeader.CalcFields("No. of Students");
                            //     AvblSeats := RosterSchedulingHeader."No. of Seats" - RosterSchedulingHeader."No. of Students";
                            //     if AvblSeats <= 0 then
                            //         Error('Seat is not available in Rotation No. %1.', Rec."Rotation ID");

                            //     NewHospitalID := '';
                            //     NewHospitalName := '';
                            //     NewRotationStatus := NewRotationStatus::Scheduled;
                            //     NewStartDate := 0D;
                            //     NewWeeks := 0;
                            //     NewEndDate := 0D;
                            //     NewNoOfStudents := 0;

                            //     NewHospitalID := RosterSchedulingHeader."Hospital ID";
                            //     NewHospitalName := RosterSchedulingHeader."Hospital Name";
                            //     NewRotationStatus := RosterSchedulingHeader.Status;
                            //     NewStartDate := RosterSchedulingHeader."Start Date";
                            //     NewWeeks := RosterSchedulingHeader."No. of Weeks";
                            //     NewEndDate := RosterSchedulingHeader."End Date";
                            //     NewNoOfStudents := RosterSchedulingHeader."No. of Students";
                            // end;
                        end;
                    }

                    field(NewHospitalID; NewHospitalID)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Caption = 'Hospital ID';
                        Editable = false;
                    }
                    field(NewHospitalName; NewHospitalName)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Caption = 'Hospital Name';
                        Editable = false;
                    }
                    field(NewStartDate; NewStartDate)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Caption = 'Start Date';
                        Editable = false;
                    }
                    field(NewWeeks; NewWeeks)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Caption = 'No. of Weeks';
                        Editable = false;
                    }
                    field(NewEndDate; NewEndDate)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Caption = 'End Date';
                        Editable = false;
                    }
                    field(NewRotationStatus; NewRotationStatus)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = 'Scheduled,Published,Cancelled';
                        Caption = 'Rotation Status';
                        Editable = false;
                    }
                    field(NewNoOfStudents; NewNoOfStudents)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Caption = 'Students in Rotation';
                        Editable = false;
                        DecimalPlaces = 0;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Confirm)
            {
                ApplicationArea = All;
                Caption = 'Confirm';
                ShortcutKey = 'F9';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;

                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    RosterLedgerEntry_1: Record "Roster Ledger Entry";
                    //HospitalInventory: Record "Hospital Inventory";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    RosterSchedulingHeader.Reset();
                    if RosterSchedulingHeader.Get(NewRotationID) then
                        RosterSchedulingHeader.CalcFields("No. of Students");

                    if RosterSchedulingHeader."No. of Students" + 1 > RosterSchedulingHeader."No. of Seats" then
                        Error('Seat is not available in Rotation No. %1.', RosterSchedulingHeader."Rotation ID");

                    RosterLedgerEntry_1.Reset();
                    if RosterLedgerEntry_1.FindLast() then;

                    RosterSchedulingLine.Init();
                    RosterSchedulingLine."Rotation ID" := NewRotationID;
                    RosterSchedulingLine."Academic Year" := RosterSchedulingHeader."Academic Year";
                    RosterSchedulingLine."Clerkship Type" := Rec."Clerkship Type";
                    RosterSchedulingLine.Validate("Student No.", Rec."Student No.");
                    RosterSchedulingLine."Course Code" := Rec."Course Code";
                    RosterSchedulingLine."Course Description" := Rec."Course Description";
                    RosterSchedulingLine."Course Type" := Rec."Course Type";
                    RosterSchedulingLine."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    RosterSchedulingLine."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    RosterSchedulingLine."Start Date" := NewStartDate;//CSPL-00307-RTP
                    RosterSchedulingLine."End Date" := NewEndDate;//CSPL-00307-RTP
                    RosterSchedulingLine."No. of Weeks" := NewWeeks;//CSPL-00307-RTP
                    RosterSchedulingLine.Validate("Hospital ID", NewHospitalID);
                    RosterSchedulingLine."Coordinator ID" := Rec."Coordinator ID";
                    RosterSchedulingLine."Document Specialist ID" := Rec."Document Specialist ID";
                    RosterSchedulingLine."Student Status" := Rec."Student Status"::" ";
                    RosterSchedulingLine.Status := RosterSchedulingHeader.Status;
                    RosterSchedulingLine.Interchange := true;
                    if RosterSchedulingLine.Insert(true) then;

                    if RosterSchedulingLine."Rotation Confirmed" then begin
                        RosterSchedulingLine."Rotation Confirmed By" := UserId;
                        RosterSchedulingLine."Rotation Confirmed On" := Today;
                    end;

                    if RosterSchedulingLine.Status = RosterSchedulingLine.Status::Scheduled then begin
                        RosterSchedulingLine."Scheduled On" := Today;
                        RosterSchedulingLine."Scheduled By" := UserId;
                    end;

                    if RosterSchedulingLine.Status = RosterSchedulingLine.Status::Published then begin
                        RosterSchedulingLine."Scheduled On" := Today;
                        RosterSchedulingLine."Scheduled By" := UserId;
                        RosterSchedulingLine."Published On" := Today;
                        RosterSchedulingLine."Published By" := UserId;
                        RosterSchedulingLine.PublishRotation(RosterSchedulingLine, RosterLedgerEntry_1."Entry No." + 1);
                    end;

                    // if HospitalInventory."Available Seats" - NewNoOfStudents - 1 <= 0 then begin
                    //     if RosterSchedulingLine."Rotation Confirmed" then
                    //         Error('Inventory not Available in the Hospital %1 (%2).\It is not allowed to Add a Waitlisted Student in Scheduled Confirmed Rotation.', NewHospitalID, NewHospitalName);
                    //     RosterSchedulingLine.Status := RosterSchedulingLine.Status::Unconfirmed;
                    //     RosterSchedulingLine.Waitlisted := true;
                    // end;


                    //CSPL-307-RTP
                    // if RosterSchedulingLine.Status = RosterSchedulingLine.Status::Published then
                    //     RosterSchedulingLine.PublishRotation(RosterSchedulingLine, RosterLedgerEntry_1."Entry No." + 1); Rec.
                    //CSPL-307-RTP
                    RosterSchedulingLine.Modify();//CSPL-307-RTP
                    RosterLedgerEntry_1.Reset();
                    if RosterLedgerEntry_1.Get(Rec."Ledger Entry No.") then
                        RosterLedgerEntry_1.Delete();

                    Rec.Delete();
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
                        CALE.InsertLogEntry(4, 13, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", '7015', 'Family Medicine I/Internal Medicine I');
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
                        CALE.InsertLogEntry(5, 13, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Course Code", Rec."Course Description");
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
                        CALE.InsertLogEntry(8, 13, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Elective Course Code", Rec."Rotation Description");

                    Message('Transfer of student has been completed successfully.');
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        NewRotationID := 'Click to select Rotation';
    end;

    var
        NewRotationID: Code[25];
        NewHospitalID: Code[20];
        NewHospitalName: Text[50];
        NewRotationStatus: Option "Scheduled","Published","Cancelled";
        NewStartDate: Date;
        NewWeeks: Integer;
        NewEndDate: Date;
        NewNoOfStudents: Decimal;
}
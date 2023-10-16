page 50475 "Room Master List Temp"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Room Master";
    Caption = 'Apartment List (Filtered)';
    DelayedInsert = true;
    SourceTableTemporary = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;

                }
                field("Floor No."; Rec."Floor No.")
                {
                    ApplicationArea = All;

                }
                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;

                }
                field("Maximum No. of Bed"; Rec."Maximum No. of Bed")
                {
                    ApplicationArea = All;

                }
                field("Available Beds"; Rec."Available Beds")
                {
                    ApplicationArea = all;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                }
                field("Gender Allowed"; Rec."Gender Allowed")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Room Fee"; Rec."Room Fee")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Bill Code"; Rec."Bill Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Room Wise Bed")
            {
                Caption = '&Apartment Wise Room';
                ApplicationArea = All;
                RunObject = Page "Room Wise Bed List";
                RunPageLink = "Housing ID" = FIELD("Housing ID"), "Room No." = field("Room No.");

            }

        }
    }

    var

    procedure addedvaluetoTempRec(RoomMaster: Record "Room Master")
    var
        Ctr: Integer;
    begin
        Ctr := 0;
        Rec.Reset();
        Rec.SetRange("Room No.", RoomMaster."Room No.");
        if Rec.FindFirst() then
            Ctr := 1;

        if Ctr = 0 then begin
            Rec.Reset();
            Rec.Init();
            Rec.TransferFields(RoomMaster);
            Rec.Insert();
        end;
    end;

    procedure CheckEligibleRoom(RoomMaster: Record "Room Master"; WithSpouse: Boolean; Student: Record "Student Master-CS"): Boolean
    var
        RoomWiseBed: Record "Room Wise Bed";
        HostelLedger: Record "Housing Ledger";
        StudentInLedger: Record "Student Master-CS";
        DontTakeCtr: Integer;
    begin
        if not WithSpouse then begin
            if RoomMaster."Maximum No. of Bed" = 1 then
                exit(true)
            else
                if RoomMaster."Maximum No. of Bed" > 1 then
                    if RoomMaster."Maximum No. of Bed" <> RoomMaster."Available Beds" then begin
                        DontTakeCtr := 0;
                        RoomWiseBed.Reset();
                        RoomWiseBed.SetRange("Housing ID", RoomMaster."Housing ID");
                        RoomWiseBed.SetRange("Room No.", RoomMaster."Room No.");
                        if RoomWiseBed.FindSet() then begin
                            repeat
                                RoomWiseBed.CalcFields(Consumption);
                                if RoomWiseBed.Consumption = 1 then begin
                                    HostelLedger.Reset();
                                    HostelLedger.SetRange("Housing ID", RoomWiseBed."Housing ID");
                                    HostelLedger.SetRange("Room No.", RoomWiseBed."Room No.");
                                    HostelLedger.SetRange("Bed No.", RoomWiseBed."Bed No.");
                                    if HostelLedger.FindLast() then begin
                                        StudentInLedger.Get(HostelLedger."Student No.");
                                        if Student.Gender <> StudentInLedger.Gender then
                                            DontTakeCtr += 1;
                                    end;
                                end;

                            until RoomWiseBed.Next() = 0;
                            if DontTakeCtr = 0 then
                                exit(true)
                            else
                                exit(false);
                        end;
                    end
                    else
                        Exit(true);

        end
        else begin
            RoomMaster.CalcFields("Available Beds");
            //if RoomMaster."Maximum No. of Bed" = 2 then begin
            if (RoomMaster."Maximum No. of Bed" >= 1) then begin
                if RoomMaster."Maximum No. of Bed" = RoomMaster."Available Beds" then
                    exit(true)
                else
                    exit(false);
            end
            else
                exit(false);
        end;


    end;

}
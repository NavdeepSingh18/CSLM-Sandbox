page 50696 RoomCategoryFeeFactBox
{
    PageType = CardPart;
    Caption = 'Availability';
    SourceTable = "Room Category Fee Setup";

    layout
    {
        area(Content)
        {
            field("Housing ID"; Rec."Housing ID")
            {
                ApplicationArea = All;
                Caption = 'Housing ID';
                Editable = false;
                trigger OnDrillDown()
                var
                    RecHousingMaster: Record "Housing Master";
                    HousingMasterCard_Page: Page "Housing Master Card";
                begin
                    RecHousingMaster.Reset();
                    RecHousingMaster.SetRange("Housing ID", Rec."Housing ID");
                    HousingMasterCard_Page.SetTableView(RecHousingMaster);
                    HousingMasterCard_Page.Editable := False;
                    HousingMasterCard_Page.Run();
                end;

            }
            field("Housing Name"; HousingMaster."Housing Name")
            {
                ApplicationArea = All;
                Caption = 'Housing Name';
                Editable = false;
                ToolTip = 'It contains a Housing ID';
                trigger OnDrillDown()
                var
                    RecHousingMaster: Record "Housing Master";
                    HousingMasterCard_Page: Page "Housing Master Card";
                begin
                    RecHousingMaster.Reset();
                    RecHousingMaster.SetRange("Housing ID", Rec."Housing ID");
                    HousingMasterCard_Page.SetTableView(RecHousingMaster);
                    HousingMasterCard_Page.Editable := False;
                    HousingMasterCard_Page.Run();
                end;

            }
            field("Room Category"; Rec."Room Category Code")
            {
                ApplicationArea = All;
                Caption = 'Room Category';
                Editable = False;
                trigger OnDrillDown()
                var
                    RoomCategoryMaster: Record "Room Category Master";
                    RoomCategoryPage: Page "Room Category List";
                begin
                    RoomCategoryMaster.Reset();
                    RoomCategoryMaster.SetFilter("Room Category Code", Rec."Room Category Code");
                    RoomCategoryPage.SetTableView(RoomCategoryMaster);
                    RoomCategoryPage.Editable := False;
                    RoomCategoryPage.Run();

                end;
            }
            field("No. of Rooms"; RoomCount_Gint)
            {
                ApplicationArea = All;
                Caption = 'No. of Rooms';
                Editable = False;
                trigger OnDrillDown()
                var
                    RoomMaster_lRec: Record "Room Master";
                    RoomMasterList_lPage: Page "Room Master List";
                begin
                    RoomMaster_lRec.Reset();
                    RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
                    RoomMasterList_lPage.SetTableView(RoomMaster_lRec);
                    RoomMasterList_lPage.Editable := False;
                    RoomMasterList_lPage.Run();
                end;
            }

            field("Total Beds"; TotalBedCount_lInt)
            {
                ApplicationArea = All;
                Caption = 'Total No. of Rooms';
                Editable = false;
                ToolTip = 'It shows Total no. of Rooms Available';
                trigger OnDrillDown()
                var
                    RoomWiseBed: Record "Room Wise Bed";
                    RoomMaster_lRec: Record "Room Master";
                    TempRoomMaster: Record "Room Master" temporary;
                    RoomWiseBedList_lPage: Page "Room Wise Bed List";
                    BedNo: Code[2048];
                    RoomNo: Code[2048];
                begin
                    BedNo := '';
                    RoomNo := '';
                    RoomMaster_lRec.Reset();
                    RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
                    IF RoomMaster_lRec.FindSet() then
                        repeat
                            TempRoomMaster.Init();
                            TempRoomMaster.TransferFields(RoomMaster_lRec);
                            TempRoomMaster.Insert();
                        Until RoomMaster_lRec.Next() = 0;

                    TempRoomMaster.Reset();
                    IF TempRoomMaster.FindSet() then
                        Repeat
                            IF RoomNo = '' then
                                RoomNo := TempRoomMaster."Room No."
                            else
                                RoomNo := RoomNo + '|' + TempRoomMaster."Room No.";
                            RoomWiseBed.Reset();
                            RoomWiseBed.SetRange("Housing ID", TempRoomMaster."Housing ID");
                            RoomWiseBed.SetRange("Room No.", TempRoomMaster."Room No.");
                            IF RoomWiseBed.FindSet() then
                                repeat
                                    IF BedNo = '' then
                                        BedNo := RoomWiseBed."Bed No."
                                    else
                                        BedNo := BedNo + '|' + RoomWiseBed."Bed No.";
                                until RoomWiseBed.Next() = 0;
                        Until TempRoomMaster.Next() = 0;

                    RoomWiseBed.Reset();
                    RoomWiseBed.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed.SetFilter("Room No.", RoomNo);
                    RoomWiseBed.SetFilter("Bed No.", BedNo);
                    RoomWiseBedList_lPage.SetTableView(RoomWiseBed);
                    RoomWiseBedList_lPage.Editable := false;
                    RoomWiseBedList_lPage.Run();
                end;

            }
            field("No. of Bed Occupied"; OccupiedBedCount_lInt)
            {
                ApplicationArea = All;
                Caption = 'No. of Rooms Occupied';
                Editable = false;
                ToolTip = 'It shows Total no. of Rooms Available';
                trigger OnDrillDown()
                var
                    RoomWiseBed: Record "Room Wise Bed";
                    RoomMaster_lRec: Record "Room Master";
                    TempRoomMaster: Record "Room Master" temporary;
                    RoomWiseBedList_lPage: Page "Room Wise Bed List";
                    BedNo: Code[2048];
                    RoomNo: Code[2048];
                begin
                    BedNo := '';
                    RoomNo := '';
                    RoomMaster_lRec.Reset();
                    RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
                    IF RoomMaster_lRec.FindSet() then
                        repeat
                            TempRoomMaster.Init();
                            TempRoomMaster.TransferFields(RoomMaster_lRec);
                            TempRoomMaster.Insert();
                        Until RoomMaster_lRec.Next() = 0;

                    TempRoomMaster.Reset();
                    IF TempRoomMaster.FindSet() then
                        Repeat
                            IF RoomNo = '' then
                                RoomNo := TempRoomMaster."Room No."
                            else
                                RoomNo := RoomNo + '|' + TempRoomMaster."Room No.";
                            RoomWiseBed.Reset();
                            RoomWiseBed.SetRange("Housing ID", TempRoomMaster."Housing ID");
                            RoomWiseBed.SetRange("Room No.", TempRoomMaster."Room No.");
                            RoomWiseBed.SetRange(Blocked, False);
                            RoomWiseBed.SetRange(Available, false);
                            IF RoomWiseBed.FindSet() then
                                repeat
                                    IF BedNo = '' then
                                        BedNo := RoomWiseBed."Bed No."
                                    else
                                        BedNo := BedNo + '|' + RoomWiseBed."Bed No.";
                                until RoomWiseBed.Next() = 0;
                        Until TempRoomMaster.Next() = 0;

                    RoomWiseBed.Reset();
                    RoomWiseBed.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed.SetFilter("Room No.", RoomNo);
                    RoomWiseBed.SetFilter("Bed No.", BedNo);
                    RoomWiseBedList_lPage.SetTableView(RoomWiseBed);
                    RoomWiseBedList_lPage.Editable := false;
                    RoomWiseBedList_lPage.Run();
                end;

            }
            field("No. of Bed Available"; AvailableBedCount_lInt)
            {
                ApplicationArea = All;
                Caption = 'No. of Rooms Available';
                Editable = false;
                ToolTip = 'It shows Total no. of Rooms Available';
                trigger OnDrillDown()
                var
                    RoomWiseBed: Record "Room Wise Bed";
                    RoomMaster_lRec: Record "Room Master";
                    TempRoomMaster: Record "Room Master" temporary;
                    RoomWiseBedList_lPage: Page "Room Wise Bed List";
                    BedNo: Code[2048];
                    RoomNo: Code[2048];
                begin
                    BedNo := '';
                    RoomNo := '';
                    RoomMaster_lRec.Reset();
                    RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
                    IF RoomMaster_lRec.FindSet() then
                        repeat
                            TempRoomMaster.Init();
                            TempRoomMaster.TransferFields(RoomMaster_lRec);
                            TempRoomMaster.Insert();
                        Until RoomMaster_lRec.Next() = 0;

                    TempRoomMaster.Reset();
                    IF TempRoomMaster.FindSet() then
                        Repeat
                            IF RoomNo = '' then
                                RoomNo := TempRoomMaster."Room No."
                            else
                                RoomNo := RoomNo + '|' + TempRoomMaster."Room No.";
                            RoomWiseBed.Reset();
                            RoomWiseBed.SetRange("Housing ID", TempRoomMaster."Housing ID");
                            RoomWiseBed.SetRange("Room No.", TempRoomMaster."Room No.");
                            RoomWiseBed.SetRange(Blocked, False);
                            RoomWiseBed.SetRange(Available, true);
                            IF RoomWiseBed.FindSet() then
                                repeat
                                    IF BedNo = '' then
                                        BedNo := RoomWiseBed."Bed No."
                                    else
                                        BedNo := BedNo + '|' + RoomWiseBed."Bed No.";
                                until RoomWiseBed.Next() = 0;
                        Until TempRoomMaster.Next() = 0;

                    RoomWiseBed.Reset();
                    RoomWiseBed.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed.SetFilter("Room No.", RoomNo);
                    RoomWiseBed.SetFilter("Bed No.", BedNo);
                    RoomWiseBedList_lPage.SetTableView(RoomWiseBed);
                    RoomWiseBedList_lPage.Editable := false;
                    RoomWiseBedList_lPage.Run();
                end;
            }


            field("No. of Bed Blocked"; BlockedBedCount_lInt)
            {
                ApplicationArea = All;
                Caption = 'No. of Rooms Blocked';
                Editable = false;
                ToolTip = 'It shows Total no. of Rooms Blocked';
                trigger OnDrillDown()
                var
                    RoomWiseBed: Record "Room Wise Bed";
                    RoomMaster_lRec: Record "Room Master";
                    TempRoomMaster: Record "Room Master" temporary;
                    RoomWiseBedList_lPage: Page "Room Wise Bed List";
                    BedNo: Code[2048];
                    RoomNo: Code[2048];
                begin
                    BedNo := '';
                    RoomNo := '';
                    RoomMaster_lRec.Reset();
                    RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
                    IF RoomMaster_lRec.FindSet() then
                        repeat
                            TempRoomMaster.Init();
                            TempRoomMaster.TransferFields(RoomMaster_lRec);
                            TempRoomMaster.Insert();
                        Until RoomMaster_lRec.Next() = 0;

                    TempRoomMaster.Reset();
                    IF TempRoomMaster.FindSet() then
                        Repeat
                            IF RoomNo = '' then
                                RoomNo := TempRoomMaster."Room No."
                            else
                                RoomNo := RoomNo + '|' + TempRoomMaster."Room No.";
                            RoomWiseBed.Reset();
                            RoomWiseBed.SetRange("Housing ID", TempRoomMaster."Housing ID");
                            RoomWiseBed.SetRange("Room No.", TempRoomMaster."Room No.");
                            RoomWiseBed.SetRange(Blocked, true);
                            IF RoomWiseBed.FindSet() then
                                repeat
                                    IF BedNo = '' then
                                        BedNo := RoomWiseBed."Bed No."
                                    else
                                        BedNo := BedNo + '|' + RoomWiseBed."Bed No.";
                                until RoomWiseBed.Next() = 0;
                        Until TempRoomMaster.Next() = 0;

                    RoomWiseBed.Reset();
                    RoomWiseBed.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed.SetFilter("Room No.", RoomNo);
                    RoomWiseBed.SetFilter("Bed No.", BedNo);
                    RoomWiseBedList_lPage.SetTableView(RoomWiseBed);
                    RoomWiseBedList_lPage.Editable := false;
                    RoomWiseBedList_lPage.Run();
                end;
            }

        }

    }


    var
        HousingMaster: Record "Housing Master";
        RoomCount_Gint: Integer;
        TotalBedCount_lInt: integer;
        OccupiedBedCount_lInt: Integer;
        AvailableBedCount_lInt: Integer;
        BlockedBedCount_lInt: Integer;


    trigger OnOpenPage()
    begin
        RoomCount_Gint := 0;
        RoomCount_Gint := RoomCount();

        TotalBedCount_lInt := 0;
        TotalBedCount_lInt := TotalBedCount();

        OccupiedBedCount_lInt := 0;
        OccupiedBedCount_lInt := OccupiedBedCount();

        AvailableBedCount_lInt := 0;
        AvailableBedCount_lInt := AvailableBedCount();

        BlockedBedCount_lInt := 0;
        BlockedBedCount_lInt := BlockedBedCount();
    end;


    trigger OnAfterGetRecord()

    begin
        RoomCount_Gint := 0;
        RoomCount_Gint := RoomCount();

        TotalBedCount_lInt := 0;
        TotalBedCount_lInt := TotalBedCount();

        OccupiedBedCount_lInt := 0;
        OccupiedBedCount_lInt := OccupiedBedCount();

        AvailableBedCount_lInt := 0;
        AvailableBedCount_lInt := AvailableBedCount();

        BlockedBedCount_lInt := 0;
        BlockedBedCount_lInt := BlockedBedCount();

        IF Rec."Housing ID" <> '' then
            HousingMaster.Get(Rec."Housing ID");
    end;

    procedure RoomCount(): Integer
    var
        RoomMaster_lRec: Record "Room Master";
    begin
        RoomMaster_lRec.Reset();
        RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
        RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
        Exit(RoomMaster_lRec.Count());

    end;

    procedure TotalBedCount() MaxBed: Integer;
    var
        RoomMaster_lRec: Record "Room Master";
    begin
        RoomMaster_lRec.Reset();
        RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
        RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
        IF RoomMaster_lRec.FindSet() then
            repeat
                MaxBed += RoomMaster_lRec."Maximum No. of Bed";
            Until RoomMaster_lRec.Next() = 0;
        exit(MaxBed);
    end;

    procedure OccupiedBedCount() OccupiedBed: Integer;
    var
        RoomWiseBed: Record "Room Wise Bed";
        RoomMaster_lRec: Record "Room Master";
    begin
        RoomMaster_lRec.Reset();
        RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
        RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
        IF RoomMaster_lRec.FindSet() then
            repeat
                RoomWiseBed.Reset();
                RoomWiseBed.SetRange("Housing ID", RoomMaster_lRec."Housing ID");
                RoomWiseBed.SetRange("Room No.", RoomMaster_lRec."Room No.");
                RoomWiseBed.SetRange(Blocked, False);
                RoomWiseBed.SetRange(Available, false);
                OccupiedBed += RoomWiseBed.Count();
            Until RoomMaster_lRec.Next() = 0;
        exit(OccupiedBed);
    end;

    procedure AvailableBedCount() Available: Integer;
    var
        RoomWiseBed: Record "Room Wise Bed";
        RoomMaster_lRec: Record "Room Master";
    begin
        RoomMaster_lRec.Reset();
        RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
        RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
        IF RoomMaster_lRec.FindSet() then
            repeat
                RoomWiseBed.Reset();
                RoomWiseBed.SetRange("Housing ID", RoomMaster_lRec."Housing ID");
                RoomWiseBed.SetRange("Room No.", RoomMaster_lRec."Room No.");
                RoomWiseBed.SetRange(Blocked, False);
                RoomWiseBed.SetRange(Available, true);
                Available += RoomWiseBed.Count();
            Until RoomMaster_lRec.Next() = 0;
        exit(Available);
    end;

    procedure BlockedBedCount() Blocked: Integer;
    var
        RoomWiseBed: Record "Room Wise Bed";
        RoomMaster_lRec: Record "Room Master";
    begin
        RoomMaster_lRec.Reset();
        RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
        RoomMaster_lRec.SetRange("Room Category Code", Rec."Room Category Code");
        IF RoomMaster_lRec.FindSet() then
            repeat
                RoomWiseBed.Reset();
                RoomWiseBed.SetRange("Housing ID", RoomMaster_lRec."Housing ID");
                RoomWiseBed.SetRange("Room No.", RoomMaster_lRec."Room No.");
                RoomWiseBed.SetRange(Blocked, true);
                Blocked += RoomWiseBed.Count();
            Until RoomMaster_lRec.Next() = 0;
        exit(Blocked);
    end;
}
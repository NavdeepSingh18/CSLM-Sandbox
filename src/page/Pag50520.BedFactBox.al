page 50520 BedFactBox
{
    PageType = CardPart;
    Caption = 'Availability';
    SourceTable = "Room Wise Bed";

    layout
    {
        area(Content)
        {
            field("Housing ID"; Rec."Housing ID")
            {
                ApplicationArea = All;
                Caption = 'Housing ID';
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
            field("Room Category Code"; RoomMaster."Room Category Code")
            {
                ApplicationArea = All;
                Caption = 'Apartment Category';
                Editable = False;
                trigger OnDrillDown()
                var
                    RoomMaster1: Record "Room Master";
                    RoomCategoryMaster: Record "Room Category Master";
                    RoomCategoryList: Page "Room Category List";
                begin
                    RoomMaster1.Get(Rec."Housing ID", Rec."Room No.");
                    RoomCategoryMaster.Reset();
                    RoomCategoryMaster.SetRange("Room Category Code", RoomMaster1."Room Category Code");
                    RoomCategoryList.SetTableView(RoomCategoryMaster);
                    RoomCategoryList.Editable := False;
                    RoomCategoryList.Run();

                end;
            }
            field("Room No."; Rec."Room No.")
            {
                ApplicationArea = All;
                Caption = 'Apartment No.';
                Editable = false;
                ToolTip = 'It contains a Room No.';
                trigger OnDrillDown()
                var
                    RoomMaster_lRec: Record "Room Master";
                    RoomMasterList_lPage: Page "Room Master List";
                begin
                    RoomMaster_lRec.Reset();
                    RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomMaster_lRec.SetRange("Room No.", Rec."Room No.");
                    RoomMasterList_lPage.SetTableView(RoomMaster_lRec);
                    RoomMasterList_lPage.Editable := False;
                    RoomMasterList_lPage.Run();
                end;
            }

            field("Bed No."; Rec."Bed No.")
            {
                ApplicationArea = All;
                Caption = 'Room No.';
                Editable = false;
                ToolTip = 'It shows Total no. of Rooms';
                trigger OnDrillDown()
                var
                    RoomWiseBed_lRec: Record "Room Wise Bed";
                    RoomWiseBedList_lPage: Page "Room Wise Bed List";
                begin
                    RoomWiseBed_lRec.Reset();
                    RoomWiseBed_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed_lRec.SetRange("Room No.", Rec."Room No.");
                    RoomWiseBed_lRec.SetRange("Bed No.", Rec."Bed No.");
                    RoomWiseBedList_lPage.SetTableView(RoomWiseBed_lRec);
                    RoomWiseBedList_lPage.Editable := false;
                    RoomWiseBedList_lPage.Run();
                end;

            }
            field("No. of Bed Occupied"; OccupiedBedCount_lInt)
            {
                ApplicationArea = All;
                Caption = 'No. of Rooms Occupied';
                Editable = false;
                ToolTip = 'It shows Total no. of Rooms Occupied';
                trigger OnDrillDown()
                var
                    RoomWiseBed_lRec: Record "Room Wise Bed";
                    RoomWiseBedDetailPage: Page "Room Wise Bed Detail";
                begin
                    RoomWiseBed_lRec.Reset();
                    RoomWiseBed_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed_lRec.SetRange("Room No.", Rec."Room No.");
                    RoomWiseBed_lRec.SetRange("Bed No.", Rec."Bed No.");
                    RoomWiseBed_lRec.SetRange(Blocked, false);
                    RoomWiseBed_lRec.SetRange(Available, false);
                    RoomWiseBedDetailPage.SetTableView(RoomWiseBed_lRec);
                    RoomWiseBedDetailPage.Editable := false;
                    RoomWiseBedDetailPage.Run();
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
                    RoomWiseBed_lRec: Record "Room Wise Bed";
                    RoomWiseBedList_lPage: Page "Room Wise Bed List";
                begin
                    RoomWiseBed_lRec.Reset();
                    RoomWiseBed_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed_lRec.SetRange("Room No.", Rec."Room No.");
                    RoomWiseBed_lRec.SetRange("Bed No.", Rec."Bed No.");
                    RoomWiseBed_lRec.SetRange(Blocked, false);
                    RoomWiseBed_lRec.SetRange(Available, true);
                    RoomWiseBedList_lPage.SetTableView(RoomWiseBed_lRec);
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
                    RoomWiseBed_lRec: Record "Room Wise Bed";
                    RoomWiseBedList_lPage: Page "Room Wise Bed List";
                begin
                    RoomWiseBed_lRec.Reset();
                    RoomWiseBed_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed_lRec.SetRange("Room No.", Rec."Room No.");
                    RoomWiseBed_lRec.SetRange("Bed No.", Rec."Bed No.");
                    RoomWiseBed_lRec.SetRange(Blocked, true);
                    RoomWiseBedList_lPage.SetTableView(RoomWiseBed_lRec);
                    RoomWiseBedList_lPage.Editable := false;
                    RoomWiseBedList_lPage.Run();
                end;
            }
        }
    }

    var
        HousingMaster: Record "Housing Master";
        RoomMaster: Record "Room Master";
        OccupiedBedCount_lInt: Integer;
        AvailableBedCount_lInt: Integer;
        BlockedBedCount_lInt: Integer;

    trigger OnOpenPage()
    begin
        OccupiedBedCount_lInt := 0;
        OccupiedBedCount_lInt := OccupiedBedCount();

        AvailableBedCount_lInt := 0;
        AvailableBedCount_lInt := AvailableBedCount();

        BlockedBedCount_lInt := 0;
        BlockedBedCount_lInt := BlockedBedCount();

    end;

    trigger OnAfterGetRecord()
    begin

        OccupiedBedCount_lInt := 0;
        OccupiedBedCount_lInt := OccupiedBedCount();

        AvailableBedCount_lInt := 0;
        AvailableBedCount_lInt := AvailableBedCount();

        BlockedBedCount_lInt := 0;
        BlockedBedCount_lInt := BlockedBedCount();

        IF Rec."Housing ID" <> '' then
            HousingMaster.Get(Rec."Housing ID");

        IF (Rec."Housing ID" <> '') AND (Rec."Room No." <> '') then
            RoomMaster.Get(Rec."Housing ID", Rec."Room No.");

    end;

    procedure OccupiedBedCount() OccupiedBed: Integer;
    var
        RoomWiseBed: Record "Room Wise Bed";
    begin
        RoomWiseBed.Reset();
        RoomWiseBed.SetRange("Housing ID", Rec."Housing ID");
        RoomWiseBed.SetRange("Room No.", Rec."Room No.");
        RoomWiseBed.SetRange("Bed No.", Rec."Bed No.");
        RoomWiseBed.SetRange(Blocked, false);
        RoomWiseBed.SetRange(Available, false);
        OccupiedBed := RoomWiseBed.Count();
        exit(OccupiedBed);
    end;

    procedure AvailableBedCount() Available: Integer;
    var
        RoomWiseBed: Record "Room Wise Bed";
    begin
        RoomWiseBed.Reset();
        RoomWiseBed.SetRange("Housing ID", Rec."Housing ID");
        RoomWiseBed.SetRange("Room No.", Rec."Room No.");
        RoomWiseBed.SetRange("Bed No.", Rec."Bed No.");
        RoomWiseBed.SetRange(Blocked, false);
        RoomWiseBed.SetRange(Available, true);
        Available := RoomWiseBed.Count();
        exit(Available);
    end;

    procedure BlockedBedCount() Blocked: Integer;
    var
        RoomWiseBed: Record "Room Wise Bed";
    begin
        RoomWiseBed.Reset();
        RoomWiseBed.SetRange("Housing ID", Rec."Housing ID");
        RoomWiseBed.SetRange("Room No.", Rec."Room No.");
        RoomWiseBed.SetRange("Bed No.", Rec."Bed No.");
        RoomWiseBed.SetRange(Blocked, true);
        Blocked := RoomWiseBed.Count();
        exit(Blocked);
    end;
}
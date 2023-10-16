page 50590 HousingRoomFactBox
{
    PageType = CardPart;
    Caption = 'Availability';
    SourceTable = "Room Master";

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
            field("Total Room Categories"; RoomCatCount_Gint)
            {
                ApplicationArea = All;
                Caption = 'No. of Categories';
                Editable = False;
                trigger OnDrillDown()
                var
                    RoomCatMaster_lRec: Record "Room Master";
                    RoomCategoryMaster: Record "Room Category Master";
                    RoomCategoryPage: Page "Room Category List";
                    CatCount: Code[20];
                    RoomCategory: Code[2048];
                begin
                    CatCount := '';
                    RoomCategory := '';
                    RoomCatMaster_lRec.Reset();
                    RoomCatMaster_lRec.SetCurrentKey(RoomCatMaster_lRec."Room Category Code");
                    RoomCatMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
                    IF RoomCatMaster_lRec.FindSet() then
                        repeat
                            IF CatCount <> RoomCatMaster_lRec."Room Category Code" then begin
                                IF RoomCategory = '' then
                                    RoomCategory := RoomCatMaster_lRec."Room Category Code"
                                else
                                    RoomCategory := RoomCategory + '|' + RoomCatMaster_lRec."Room Category Code";
                            end;
                            CatCount := RoomCatMaster_lRec."Room Category Code";
                        until RoomCatMaster_lRec.Next() = 0;

                    RoomCategoryMaster.Reset();
                    RoomCategoryMaster.SetFilter("Room Category Code", RoomCategory);
                    RoomCategoryPage.SetTableView(RoomCategoryMaster);
                    RoomCategoryPage.Editable := False;
                    RoomCategoryPage.Run();

                end;
            }
            field("No. of Rooms"; RoomCount_Gint)
            {
                ApplicationArea = All;
                Caption = 'No. of Apartments';
                Editable = False;
                trigger OnDrillDown()
                var
                    RoomMaster_lRec: Record "Room Master";
                    RoomMasterList_lPage: Page "Room Master List";
                begin
                    RoomMaster_lRec.Reset();
                    RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomMaster_lRec.SetRange(Blocked, false);
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
                ToolTip = 'It shows Total no. of Rooms';
                trigger OnDrillDown()
                var
                    RoomWiseBed_lRec: Record "Room Wise Bed";
                    RoomWiseBedList_lPage: Page "Room Wise Bed List";
                begin
                    RoomWiseBed_lRec.Reset();
                    RoomWiseBed_lRec.SetRange("Housing ID", Rec."Housing ID");
                    RoomWiseBed_lRec.SetRange(Blocked, false);
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
        RoomCount_Gint: Integer;
        RoomCatCount_Gint: integer;
        TotalBedCount_lInt: integer;
        OccupiedBedCount_lInt: Integer;
        AvailableBedCount_lInt: Integer;
        BlockedBedCount_lInt: Integer;


    trigger OnOpenPage()
    begin
        RoomCount_Gint := 0;
        RoomCount_Gint := RoomCount();

        RoomCatCount_Gint := 0;
        RoomCatCount_Gint := RoomCatCount();

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

        RoomCatCount_Gint := 0;
        RoomCatCount_Gint := RoomCatCount();

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
        Exit(RoomMaster_lRec.Count());

    end;

    procedure RoomCatCount(): Integer
    var
        RoomCatMaster_lRec: Record "Room Master";
        CatCount: Code[20];
        CatCount1: Integer;
    begin
        CatCount := '';
        RoomCatMaster_lRec.Reset();
        RoomCatMaster_lRec.SetCurrentKey(RoomCatMaster_lRec."Room Category Code");
        RoomCatMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
        IF RoomCatMaster_lRec.FindSet() then
            repeat
                IF CatCount <> RoomCatMaster_lRec."Room Category Code" then begin
                    CatCount1 := CatCount1 + 1;
                end;
                CatCount := RoomCatMaster_lRec."Room Category Code";
            until RoomCatMaster_lRec.Next() = 0;
        exit(CatCount1);
    end;

    procedure TotalBedCount() MaxBed: Integer;
    var
        RoomMaster_lRec: Record "Room Master";
    begin
        RoomMaster_lRec.Reset();
        RoomMaster_lRec.SetRange("Housing ID", Rec."Housing ID");
        IF RoomMaster_lRec.FindSet() then
            repeat
                MaxBed += RoomMaster_lRec."Maximum No. of Bed";
            Until RoomMaster_lRec.Next() = 0;
        exit(MaxBed);
    end;

    procedure OccupiedBedCount() OccupiedBed: Integer;
    var
        RoomWiseBed: Record "Room Wise Bed";
    begin
        RoomWiseBed.Reset();
        RoomWiseBed.SetRange("Housing ID", Rec."Housing ID");
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
        RoomWiseBed.SetRange(Blocked, true);
        Blocked := RoomWiseBed.Count();
        exit(Blocked);
    end;
}
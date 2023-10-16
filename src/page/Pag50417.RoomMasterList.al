page 50417 "Room Master List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Room Master";
    Caption = 'Apartment List';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;
                }
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
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                }
                field("Available Beds"; Rec."Available Beds")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Gender Allowed"; Rec."Gender Allowed")
                {
                    // Caption = 'Gender';
                    ApplicationArea = All;

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
        area(FactBoxes)
        {
            part(Control50521; RoomFactBox)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Availability';
                SubPageLink = "Housing ID" = field("Housing ID"), "Room No." = field("Room No.");
            }
            // part("Notes Fact Box"; "Housing Notes")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Source No." = FIELD("Room No.");
            // }
        }


    }

    actions
    {
        area(Processing)
        {
            action("Room Wise Bed")
            {
                Caption = '&No of Rooms';
                ApplicationArea = All;
                Image = SetupList;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "Room Wise Bed List";
                RunPageLink = "Housing ID" = FIELD("Housing ID"), "Room No." = field("Room No.");
            }
            action("Housing Inventory")
            {
                Caption = '&Housing Inventory';
                ApplicationArea = All;
                Image = SetupList;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Housing Inventory Allocation";
                RunPageLink = "Housing ID" = FIELD("Housing ID"), "Room No." = field("Room No.");

            }

            action("Housing Ledger")
            {
                Caption = '&Housing Ledger';
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Housing Ledger";
                RunPageLink = "Housing ID" = FIELD("Housing ID"), "Room No." = field("Room No.");

            }
            action("Notes")
            {
                ApplicationArea = All;
                Caption = 'Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    InteractionTemplate: Record "Interaction Template";
                    InteractionGroup: Record "Interaction Group";
                    InterLogEntryCommentLine: Record "Interaction Log Entry";
                begin
                    Rec.TestField("Housing ID");
                    InteractionTemplate.Reset();
                    InteractionTemplate.SetRange("Type", InteractionTemplate."Type"::Housing);
                    IF not InteractionTemplate.FindLast() then
                        Error('Interaction Template not found for Type Housing.');

                    InteractionGroup.Reset();
                    InteractionGroup.SetRange("Type", InteractionGroup."Type"::Room);
                    IF not InteractionGroup.FindLast() then
                        Error('Interaction Group not found for Type Room.');

                    InterLogEntryCommentLine.Reset();
                    InterLogEntryCommentLine.SetRange("Source No.", Rec."Room No.");
                    InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                    InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                    // Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine);
                end;
            }
            action("Room Modification History")
            {
                Caption = '&Apartment Modification History';
                ApplicationArea = All;
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    ChangeLogEntries.RESET();
                    ChangeLogEntries.SetRange("Primary Key Field 1 Value", Rec."Housing ID");
                    ChangeLogEntries.SetRange("Primary Key Field 2 Value", Rec."Room No.");
                    IF PAGE.RUNMODAL(Page::"Change Log Entries", ChangeLogEntries) = ACTION::LookupOK THEN;
                end;
            }
            action("&Blocked")
            {
                ApplicationArea = All;
                Caption = '&Blocked';
                Image = Closed;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(RoomMasterRec);
                    RoomCount := RoomMasterRec.Count();
                    IF RoomCount > 1 then begin
                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            IF RoomMasterRec.FindFirst() Then
                                repeat
                                    Rec.TestField(Blocked, false);
                                    RoomWiseBedRec.Reset();
                                    RoomWiseBedRec.SetRange("Housing ID", RoomMasterRec."Housing ID");
                                    RoomWiseBedRec.SetRange("Room No.", RoomMasterRec."Room No.");
                                    IF RoomWiseBedRec.FindSet() then begin
                                        RoomWiseBedRec.ModifyAll(Blocked, true);
                                        RoomWiseBedRec.ModifyAll(Available, false);
                                    end;
                                    RoomMasterRec.Blocked := true;
                                    RoomMasterRec.Modify();
                                until RoomMasterRec.NEXT() = 0;
                            Message(Text003Lbl);
                            CurrPage.Update();
                        END else
                            exit;
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."Room No.") THEN BEGIN
                            Rec.TestField(Blocked, false);
                            Rec.Blocked := true;
                            RoomWiseBedRec.Reset();
                            RoomWiseBedRec.SetRange("Housing ID", Rec."Housing ID");
                            RoomWiseBedRec.SetRange("Room No.", Rec."Room No.");
                            IF RoomWiseBedRec.FindSet() then begin
                                RoomWiseBedRec.ModifyAll(Blocked, true);
                                RoomWiseBedRec.ModifyAll(Available, false);
                            end;
                            Rec.Modify();
                            Message(Text004Lbl, Rec."Room No.");
                        END ELSE
                            exit;



                end;
            }
            action("&UnBlocked")
            {
                ApplicationArea = All;
                Caption = '&UnBlocked';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(RoomMasterRec);
                    RoomCount := RoomMasterRec.Count();
                    IF RoomCount > 1 then begin
                        IF CONFIRM(Text005Lbl, FALSE) THEN BEGIN
                            IF RoomMasterRec.FindSet() Then
                                repeat
                                    Rec.TestField(Blocked, true);
                                    HousingMasterRec.Reset();
                                    HousingMasterRec.SetRange("Housing ID", Rec."Housing ID");
                                    HousingMasterRec.SetRange(Blocked, true);
                                    if HousingMasterRec.FINDFIRST() then
                                        error(Text006Lbl, Rec."Room No.", Rec."Housing ID")
                                    else begin
                                        RoomWiseBedRec.Reset();
                                        RoomWiseBedRec.SetRange("Housing ID", RoomMasterRec."Housing ID");
                                        RoomWiseBedRec.SetRange("Room No.", RoomMasterRec."Room No.");
                                        IF RoomWiseBedRec.FindSet() then begin
                                            RoomWiseBedRec.ModifyAll(Blocked, false);
                                            RoomWiseBedRec.ModifyAll(Available, true);
                                        end;
                                        RoomMasterRec.Blocked := false;
                                        RoomMasterRec.Modify();
                                    end;
                                until RoomMasterRec.NEXT() = 0;
                            Message(Text007Lbl);
                            CurrPage.Update();
                        END ELSE
                            exit;
                    end else
                        IF CONFIRM(Text008Lbl, FALSE, Rec."Room No.") THEN BEGIN
                            Rec.TestField(Blocked, true);
                            HousingMasterRec.Reset();
                            HousingMasterRec.SetRange("Housing ID", Rec."Housing ID");
                            HousingMasterRec.SetRange(Blocked, true);
                            if HousingMasterRec.FINDFIRST() then
                                error(Text006Lbl, Rec."Room No.", Rec."Housing ID")
                            else begin
                                RoomWiseBedRec.Reset();
                                RoomWiseBedRec.SetRange("Housing ID", Rec."Housing ID");
                                RoomWiseBedRec.SetRange("Room No.", Rec."Room No.");
                                IF RoomWiseBedRec.FindSet() then begin
                                    RoomWiseBedRec.ModifyAll(Blocked, false);
                                    RoomWiseBedRec.ModifyAll(Available, true);
                                end;
                                Rec.Blocked := false;
                                Rec.Modify();
                                Message(Text0010Lbl, Rec."Room No.");
                            end;
                        end else
                            exit;


                end;
            }

            Group("Housing Reports")
            {
                action("Bed Count")
                {
                    Caption = 'Room Count';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        HousingMaster: Record "Housing Master";
                    begin
                        HousingMaster.Reset();
                        HousingMaster.SetRange("Housing ID", Rec."Housing ID");
                        If HousingMaster.FindFirst() then
                            Report.Run(Report::"Bed Count", True, False, HousingMaster);

                    end;
                }
                action("Housing Roster")
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        HousingMaster: Record "Housing Master";
                    begin
                        HousingMaster.Reset();
                        HousingMaster.SetRange("Housing ID", Rec."Housing ID");
                        If HousingMaster.FindFirst() then
                            Report.Run(Report::"Housing Roster", True, False, HousingMaster);

                    end;
                }
                action("Housing Cost")
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    Var
                        RoomCategoryFeeSetup: Record "Room Category Fee Setup";
                    begin
                        RoomCategoryFeeSetup.Reset();
                        RoomCategoryFeeSetup.SetRange("Housing ID", Rec."Housing ID");
                        If RoomCategoryFeeSetup.FindFirst() then
                            Report.Run(Report::"Housing Cost", True, False, RoomCategoryFeeSetup);
                    end;
                }

            }

        }


    }

    var
        RoomWiseBedRec: Record "Room Wise Bed";
        RoomMasterRec: Record "Room Master";
        HousingMasterRec: Record "Housing Master";
        ChangeLogEntries: Record "Change Log Entry";
        RoomCount: Integer;
        Text001Lbl: Label 'Do you want to block the selected Apartments ?';
        Text002Lbl: Label 'Do you want to block Apartment No. %1 ?';
        Text003Lbl: Label 'The selected Apartments has been blocked.';
        Text004Lbl: Label 'Apartment No. %1 has been blocked.';
        Text005Lbl: Label 'Do you want to unblock the selected Apartments ?';
        Text006Lbl: Label 'You cannot unblock the Apartment No. %1, as the Housing ID %2 is already blocked';
        Text007Lbl: Label 'The selected Apartments has been unblocked.';
        Text008Lbl: Label 'Do you want to unblock Apartment No. %1 ?';
        Text0010Lbl: Label 'Apartment No. %1 has been unblocked.';


}
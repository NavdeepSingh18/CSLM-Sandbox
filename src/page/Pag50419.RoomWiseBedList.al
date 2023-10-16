page 50419 "Room Wise Bed List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Room Wise Bed";
    Caption = 'No of Rooms List';
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
                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = all;
                    Editable = True;
                }
                field("Bed No."; Rec."Bed No.")
                {
                    ApplicationArea = All;

                }
                field("Bed Size"; Rec."Bed Size")
                {
                    ApplicationArea = All;

                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                }
                field(Available; Rec.Available)
                {
                    ApplicationArea = All;
                }

                field("Maximum No. of Bed"; Rec."Maximum No. of Bed")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
            }
        }
        area(FactBoxes)
        {
            // part(Control50521; Rec.BedFactBox)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Availability';
            //     SubPageLink = "Housing ID" = field("Housing ID"), "Room No." = field("Room No."), "Bed No." = field("Bed No.");
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Bed Modification History")
            {
                Caption = 'Room Modification History';
                ApplicationArea = All;
                Image = History;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    ChangeLogEntries.RESET();
                    ChangeLogEntries.SetRange("Primary Key Field 1 Value", Rec."Bed No.");
                    ChangeLogEntries.SetRange("Primary Key Field 2 Value", Rec."Room No.");
                    ChangeLogEntries.SetRange("Primary Key Field 3 Value", Rec."Housing ID");
                    IF PAGE.RUNMODAL(Page::"Change Log Entries", ChangeLogEntries) = ACTION::LookupOK THEN;
                end;
            }
            action("&Block")
            {
                ApplicationArea = All;
                Caption = '&Block';
                Image = Close;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF Rec.Consumption <> 0 then
                        error('Room %1 is already consumed,so you cannot block', Rec."Bed No.");
                    IF CONFIRM(Text001Lbl, FALSE, Rec."Bed No.") THEN BEGIN
                        Rec.TestField(Blocked, false);
                        Rec.Blocked := true;
                        Rec.Modify();
                        Message(Text003Lbl, Rec."Bed No.");
                    END ELSE
                        exit;
                end;
            }
            action("&UnBlock")
            {
                ApplicationArea = All;
                Caption = '&UnBlock';
                Image = Open;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF CONFIRM(Text002Lbl, FALSE, Rec."Bed No.") THEN BEGIN
                        Rec.TestField(Blocked, true);
                        RoomMasterRec.Reset();
                        RoomMasterRec.SetRange("Housing ID", Rec."Housing ID");
                        RoomMasterRec.SetRange("Room No.", Rec."Room No.");
                        RoomMasterRec.SetRange(Blocked, true);
                        if RoomMasterRec.FINDFIRST() then
                            Error(Text005Lbl, Rec."Room No.")
                        else begin
                            Rec.Blocked := false;
                            Rec.Modify();
                            Message(Text004Lbl, Rec."Bed No.");
                        end;
                    END ELSE
                        exit;
                end;
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
                RunPageLink = "Housing ID" = FIELD("Housing ID"), "Room No." = field("Room No."), "Bed No." = Field("Bed No.");

            }
        }
    }


    var
        RoomMasterRec: Record "Room Master";
        ChangeLogEntries: Record "Change Log Entry";
        Text001Lbl: Label 'Do you want to block Room No. %1 ?';
        Text002Lbl: Label 'Do you want to unblock Room No. %1 ?';
        Text003Lbl: Label 'Room No. %1 has been blocked.';
        Text004Lbl: Label 'Room No. %1 has been unblocked.';
        Text005Lbl: Label 'You cannot unblock the Room as the Apartment No. %1 is already blocked';


}
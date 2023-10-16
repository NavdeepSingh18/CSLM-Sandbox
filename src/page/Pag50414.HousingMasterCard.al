page 50414 "Housing Master Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Housing Master";
    Editable = True;
    DeleteAllowed = True;
    Caption = 'Housing Card';
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;

                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;

                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                }
                field("Housing Group"; Rec."Housing Group")
                {
                    ApplicationArea = All;

                }
                field("Owned By University"; Rec."Owned By University")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF Rec."Owned By University" THEN begin
                            IF CONFIRM(Text005Lbl, FALSE, Rec."Housing ID") THEN BEGIN
                                EditableBTNVfield := false;
                                Rec."Vendor No." := '';
                                Rec."Owner Name" := '';
                                LeaseEndDate := 0D;
                                LeaseStartDate := 0D;
                                ContractNo := '';
                            end else
                                Error('');
                        end
                        else
                            if Confirm(Text006Lbl, false, Rec."Housing ID") then begin
                                EditableBTNVfield := true;
                                Rec."Vendor No." := '';
                                Rec."Owner Name" := '';
                                // ContractDetail("Housing ID", LeaseStartDate, LeaseEndDate, ContractNo);
                            end else
                                Error('');
                    end;


                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = EditableBTNVfield;
                    trigger OnValidate()
                    begin
                        IF Rec."Vendor No." <> '' then begin
                            IF Rec."Owned By University" = false THEN
                                Rec.ContractDetail(Rec."Housing ID", LeaseStartDate, LeaseEndDate, ContractNo);
                        end else begin
                            LeaseEndDate := 0D;
                            LeaseStartDate := 0D;
                            ContractNo := '';
                        end;


                    end;

                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                    Editable = EditableBTNVfield;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;

                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                }
                field("Contact Number"; Rec."Contact Number")
                {
                    ApplicationArea = All;

                }
                field("Contact Person Name"; Rec."Contact Person Name")
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;

                }
                field("Off Campus"; Rec."Off Campus")
                {
                    ApplicationArea = All;
                }
                // field("Contract No."; Rec.ContractNo)
                // {
                //     Caption = 'Contract No.';
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Lease Start Date"; Rec."LeaseStartDate")
                // {
                //     Caption = 'Lease Start Date';
                //     ApplicationArea = All;
                //     Editable = false;

                // }
                // field("Lease End Date"; Rec."LeaseEndDate")
                // {
                //     Caption = 'Lease End Date';
                //     ApplicationArea = All;
                //     Editable = false;

                // }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    //ShowMandatory = True;
                }
                field(MaxCapacity; Rec.MaxCapacity)
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                }
                field(NormalCapacity; Rec.NormalCapacity)
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                    //ShowMandatory = True;
                    Visible = false;
                }

            }
        }
        area(FactBoxes)
        {
            part(Control50590; HousingRoomFactBox)
            {
                ApplicationArea = All;
                Caption = 'Availability';
                SubPageLink = "Housing ID" = Field("Housing ID");
            }
            // part("Notes Fact Box"; "Housing Notes")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Source No." = FIELD("Housing ID");
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Room Master")
            {
                Caption = '&Apartment Master';
                ApplicationArea = All;
                Image = SetupList;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "Room Master List";
                RunPageLink = "Housing ID" = FIELD("Housing ID");

            }
            action("Room Category")
            {
                Caption = '&Apartment Category';
                ApplicationArea = All;
                Image = SetupList;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "Room Category List";

            }

            action("Room Category Fee Setup")
            {
                Caption = '&Apartment Category Fee Setup';
                ApplicationArea = All;
                Image = SetupPayment;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = true;
                PromotedIsBig = true;
                RunObject = Page "Room Category Fee Setup";
                RunPageLink = "Housing ID" = FIELD("Housing ID");

            }

            action("Contract Details")
            {
                Caption = '&Contract Details';
                ApplicationArea = All;
                Image = ContactFilter;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                // RunObject = Page "Housing Contract Details";
                // RunPageLink = "Housing ID" = FIELD("Housing ID");
                trigger OnAction()
                begin
                    //CSPL-00307
                    HousingContract.Reset();
                    HousingContract.SetRange("Housing ID", Rec."Housing ID");
                    IF PAGE.RUNMODAL(50433, HousingContract) = Action::LookupOK THEN begin
                        ContractNo := HousingContract."Contract No.";
                        LeaseStartDate := HousingContract."Start Date";
                        LeaseEndDate := HousingContract."End Date";
                    end;
                    //CSPL-00307
                end;

            }
            // action("Housing Inventory")
            // {
            //     Caption = '&Housing Inventory';
            //     ApplicationArea = All;
            //     Image = SetupList;
            //     Promoted = true;
            //     PromotedOnly = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Housing Inventory Allocation";
            //     RunPageLink = "Housing ID" = FIELD("Housing ID");

            // }
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
                    IF CONFIRM(Text001Lbl, FALSE, Rec."Housing ID") THEN BEGIN
                        Rec.TestField(Blocked, false);
                        Rec.Blocked := true;
                        RoomMasRec.Reset();
                        RoomMasRec.SetRange("Housing ID", Rec."Housing ID");
                        IF RoomMasRec.FindSet() THEN Begin
                            RoomMasRec.ModifyAll(Blocked, true);

                            RoomWiseBedRec.Reset();
                            RoomWiseBedRec.SetRange("Housing ID", RoomMasRec."Housing ID");
                            IF RoomWiseBedRec.FindSet() then
                                RoomWiseBedRec.ModifyAll(Blocked, true);
                        End;
                        Rec.Modify();
                        Message(Text003Lbl, Rec."Housing ID");
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
                    IF CONFIRM(Text002Lbl, FALSE, Rec."Housing ID") THEN BEGIN
                        Rec.TestField(Blocked, true);
                        Rec.Blocked := false;
                        RoomMasRec.Reset();
                        RoomMasRec.SetRange("Housing ID", Rec."Housing ID");
                        IF RoomMasRec.FindSet() THEN Begin
                            RoomMasRec.ModifyAll(Blocked, false);

                            RoomWiseBedRec.Reset();
                            RoomWiseBedRec.SetRange("Housing ID", RoomMasRec."Housing ID");
                            IF RoomWiseBedRec.FindSet() then
                                RoomWiseBedRec.ModifyAll(Blocked, false);
                        End;
                        Rec.Modify();
                        Message(Text004Lbl, Rec."Housing ID");
                    END ELSE
                        exit;
                end;
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
                    InteractionGroup.SetRange("Type", InteractionGroup."Type"::Housing);
                    IF not InteractionGroup.FindLast() then
                        Error('Interaction Group not found for Type Housing.');

                    InterLogEntryCommentLine.Reset();
                    InterLogEntryCommentLine.SetRange("Source No.", Rec."Housing ID");
                    InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                    InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                    // Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine);
                end;
            }
            action("Housing Modification History")
            {
                Caption = '&Housing Modification History';
                ApplicationArea = All;
                Image = History;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    ChangeLogEntries.Reset();
                    ChangeLogEntries.SETFILTER("Primary Key Field 1 Value", Rec."Housing ID");
                    IF PAGE.RUNMODAL(Page::"Change Log Entries", ChangeLogEntries) = ACTION::LookupOK THEN;
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
                        HousingMaster.SetRange("Housing Group", Rec."Housing Group");
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
                        HousingMaster.SetRange("Housing Group", Rec."Housing Group");
                        HousingMaster.SetRange("Housing ID", Rec."Housing ID");
                        If HousingMaster.FindFirst() then
                            Report.Run(Report::"Housing Roster", True, False, HousingMaster);

                    end;
                }
                action("Housing Cost")
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        RoomCategoryFeeSetup: Record "Room Category Fee Setup";
                    begin
                        RoomCategoryFeeSetup.Reset();
                        RoomCategoryFeeSetup.SetRange("Housing Group", Rec."Housing Group");
                        RoomCategoryFeeSetup.SetRange("Housing ID", Rec."Housing ID");
                        If RoomCategoryFeeSetup.FindFirst() then
                            Report.Run(Report::"Housing Cost", True, False, RoomCategoryFeeSetup);
                    end;
                }


            }
        }
    }

    trigger OnOpenPage()
    begin
        EditableBTNVfield := true;
    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Owned By University" THEN
            EditableBTNVfield := false
        // CurrPage.Update();
        else begin
            EditableBTNVfield := true;
            Rec.ContractDetail(Rec."Housing ID", LeaseStartDate, LeaseEndDate, ContractNo);
            //CurrPage.Update();
        end;

        //CSPL-00307
        HousingContract.Reset();
        HousingContract.SetRange("Housing ID", Rec."Housing ID");
        HousingContract.SetFilter("Contract No.", '<>%1', '');
        IF HousingContract.FindFirst() then begin
            ContractNo := HousingContract."Contract No.";
            LeaseStartDate := HousingContract."Start Date";
            LeaseEndDate := HousingContract."End Date";
        end;
        //CSPL-00307
    end;

    var
        RoomMasRec: Record "Room Master";
        ChangeLogEntries: Record "Change Log Entry";
        RoomWiseBedRec: Record "Room Wise Bed";

        HousingContract: Record "Housing Contract";
        EditableBTNVfield: Boolean;
        LeaseStartDate: Date;
        LeaseEndDate: Date;
        ContractNo: code[20];
        Text001Lbl: Label 'Do you want to block Housing ID %1 ?';
        Text002Lbl: Label 'Do you want to unblock Housing ID %1 ?';
        Text003Lbl: Label 'Housing ID %1 has been blocked.';
        Text004Lbl: Label 'Housing ID %1 has been unblocked.';
        Text005Lbl: Label 'Housing ID %1 is on lease, do you want to enable it for university?';
        Text006Lbl: Label 'Housing ID %1 is owned by university, do you want to enable it for on lease?';



}
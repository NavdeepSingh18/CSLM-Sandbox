page 50901 "Housing Listpart"
{

    PageType = listpart;
    UsageCategory = none;
    SourceTable = "Housing Master";
    Editable = false;
    CardPageId = "Housing Master Card";
    Caption = 'Housing List';
    DeleteAllowed = False;


    layout
    {
        area(Content)
        {
            repeater(Group)
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

                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;

                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
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
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Off Campus"; Rec."Off Campus")
                {
                    ApplicationArea = All;
                }
                field("Inserted In SalesForce"; Rec."Inserted In SalesForce")
                {
                    ApplicationArea = All;
                }
                field("Insert Sync"; Rec."Insert Sync")
                {
                    ApplicationArea = All;
                }
                field("Update Sync"; Rec."Update Sync")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
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
                    ShowMandatory = True;
                }
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("Room Master")
            {
                Caption = '&Apartment Master';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
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
                Promotedonly = True;
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
                RunObject = Page "Housing Contract Details";
                RunPageLink = "Housing ID" = FIELD("Housing ID");

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
                RunPageLink = "Housing ID" = FIELD("Housing ID");

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
                    ChangeLogEntries.RESET();
                    ChangeLogEntries.SetRange("Primary Key Field 1 Value", Rec."Housing ID");
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


    var

        ChangeLogEntries: Record "Change Log Entry";
}

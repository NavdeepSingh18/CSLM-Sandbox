page 50418 "Room Category Fee Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Room Category Fee Setup";
    Caption = 'Apartment Category Fee Setup';

    layout
    {
        area(Content)
        {
            repeater(group)
            {

                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;

                }
                field("Room Category Name"; Rec."Room Category Name")
                {
                    ApplicationArea = All;

                }
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;

                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;

                }
                field("Housing Group"; Rec."Housing Group")
                {
                    ApplicationArea = All;

                }
                field("Housing Group Name"; Rec."Housing Group Name")
                {
                    ApplicationArea = all;
                }

                field("Effective From"; Rec."Effective From")
                {
                    ApplicationArea = All;

                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;

                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;

                }
                field("With Spouse Cost"; Rec."With Spouse Cost")
                {
                    ApplicationArea = All;
                }
                field("Off Campus"; Rec."Off Campus")
                {
                    ApplicationArea = All;
                }
                field("Room Category Availbility"; Rec."Room Category Availbility")
                {
                    ApplicationArea = all;
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
            }
        }
        area(FactBoxes)
        {
            // part(Control50521; RoomCategoryFeeFactBox)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Availability';
            //     SubPageLink = "Housing ID" = field("Housing ID"), "Room Category Code" = field("Room Category Code");
            // }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Housing Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Card';
                Runobject = page "Housing Master Card";
                RunPageLink = "Housing ID" = FIELD("Housing ID");
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
        RoomCategoryFeeSetupRec: Record "Room Category Fee Setup";

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        RoomCategoryFeeSetupRec.Reset();
        RoomCategoryFeeSetupRec.SetRange("With Spouse", true);
        If RoomCategoryFeeSetupRec.FindSet() then
            repeat
                if RoomCategoryFeeSetupRec."With Spouse Cost" = 0 then
                    Error('With Spouse cost can not be zero');
            until RoomCategoryFeeSetupRec.next() = 0;
    end;
}
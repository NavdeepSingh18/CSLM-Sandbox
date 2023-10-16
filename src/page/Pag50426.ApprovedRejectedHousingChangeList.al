page 50426 "Approve Reject Housing Change"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = "Approved Rejected Housing Card";
    SourceTable = "Housing Change Request";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = sorting("Application No.")
                      order(descending)
                      where(Status = filter(Approved | Rejected), Posted = filter(true | false));
    Caption = 'Approved/Rejected Housing Change/Vacate/Re-Registration List';

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;

                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;

                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;

                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;

                }
                field("Original Application No."; Rec."Original Application No.")
                {
                    ApplicationArea = All;

                }
                field("New Application No."; Rec."New Application No.")
                {
                    ApplicationArea = All;

                }
                field("Room Keys Returned"; Rec."Room Keys Returned")
                {
                    ApplicationArea = All;

                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }

                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = All;

                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;

                }
                field("Approved In Days"; Rec."Approved In Days")
                {
                    ApplicationArea = All;

                }

                field("Rejected On"; Rec."Rejected On")
                {
                    ApplicationArea = All;

                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;

                }
                field("Rejected In Days"; Rec."Rejected In Days")
                {
                    ApplicationArea = All;

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
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
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
            action("Student Room Wise Inventory")
            {
                Caption = '&Student Apartment Wise Inventory';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                RunObject = Page "Student Room Wise Inventory";
                RunPageLink = "Application No." = field("New Application No.");
                //RunPageLink = "Ledger Entry No." = FIELD("Ledger Entry No.");

            }
            action("Housing Ledger")
            {
                Caption = '&Housing Ledger';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                RunObject = Page "Housing Ledger";
                RunPageLink = "Student No." = FIELD("Student No."), "Application No." = field("Application No.");

            }
            Action("Email Notification List")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "E-Mail Notification List";
                RunPageLink = ReceiverId = Field("Student No."), Subject = filter('*Housing*');

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
                    var
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
}
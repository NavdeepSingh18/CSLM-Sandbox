Page 50431 "Approved Rejected Housing Card"
{
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = False;
    ModifyAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Housing Change Request";
    SourceTableView = sorting("Application No.")
                      order(ascending)
                      where(Status = filter(Approved | Rejected), Posted = filter(true | false));

    layout
    {
        area(Content)
        {
            group(General)
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
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;

                }
                field("Approve/Reject Remarks"; Rec."Approve/Reject Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Housing Pref. 1"; Rec."Housing Pref. 1")
                {
                    ApplicationArea = All;

                }
                field("Housing Pref. 2"; Rec."Housing Pref. 2")
                {
                    ApplicationArea = All;

                }
                field("Housing Pref. 3"; Rec."Housing Pref. 3")
                {
                    ApplicationArea = All;

                }
                field("With Spouse"; Rec."With Spouse")
                {
                    ApplicationArea = All;

                }

                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;

                }
                field("Room Mate Name Pref"; Rec."Room Mate Name Pref")
                {
                    ApplicationArea = All;

                }
                field("Room Mate Email Pref"; Rec."Room Mate Email Pref")
                {
                    ApplicationArea = All;

                }

                field("Original Application No."; Rec."Original Application No.")
                {
                    ApplicationArea = All;

                }
                Field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;

                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;

                }
                // Field("Apartment No."; Rec."Apartment No.")
                // {
                //     ApplicationArea = all;
                // }
                // Field("Room No."; Rec."Room No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Housing Address"; Rec."Housing Address")
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                Field("Housing Address 2"; Rec."Housing Address 2")
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                field("Housing City"; Rec."Housing City")
                {
                    ApplicationArea = All;

                }
                field("Housing Country"; Rec."Housing Country")
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;

                }
                field("Contact Number"; Rec."Contact Number")
                {
                    ApplicationArea = All;

                }
                field("New Application No."; Rec."New Application No.")
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
                    MultiLine = true;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field("Room Keys Returned"; Rec."Room Keys Returned")
                {
                    ApplicationArea = All;

                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;

                }
                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = All;

                }
                field("Approved In Days"; Rec."Approved In Days")
                {
                    ApplicationArea = All;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;

                }
                field("Created On"; Rec."Created On")
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
    trigger OnOpenPage()
    begin
        CurrPage.Caption := 'Approved/Rejected Housing ' + Format(Rec.Type) + ' Card';
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage.Caption := 'Approved/Rejected Housing ' + Format(Rec.Type) + ' Card';
    end;
}
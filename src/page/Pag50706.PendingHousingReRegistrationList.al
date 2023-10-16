page 50706 "Housing Re-Registration List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Pending Housing Re-Registration List';
    UsageCategory = Administration;
    SourceTable = "Housing Change Request";
    CardPageId = "Housing Re-Registration Card";
    SourceTableView = sorting("Created On")
                      order(descending)
                      where(Status = filter("Pending for Approval"), Type = filter("Re-Registration"));
    Editable = false;

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
                Field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                Field("Academic Year"; Rec."Academic Year")
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

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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
        area(Processing)
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
            action("Housing Application Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Application Card';
                trigger OnAction()
                var
                    HousingApplicationRec: Record "Housing Application";
                begin
                    HousingApplicationRec.RESET();
                    HousingApplicationRec.SETRANGE("Application No.", Rec."Original Application No.");
                    IF HousingApplicationRec.FINDFIRST() THEN
                        PAGE.RUN(50422, HousingApplicationRec);
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
    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if Rec."Application Date" <> 0D then begin
            PendingDays := Today() - Rec."Application Date";
            Exit(PendingDays);
        end;
    end;
}
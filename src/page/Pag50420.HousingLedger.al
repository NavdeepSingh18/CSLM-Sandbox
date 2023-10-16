page 50420 "Housing Ledger"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Housing Ledger";
    Editable = false;
    SourceTableView = sorting("Entry No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;

                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                }

                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field("Housing Group"; Rec."Housing Group")
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
                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;

                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;

                }
                field("Bed No."; Rec."Bed No.")
                {
                    ApplicationArea = All;

                }
                field("Bed Size"; Rec."Bed Size")
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                Field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Room Assignment"; Rec."Room Assignment")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Housing Allotted Start Date"; Rec."Housing Allotted Start Date")
                {
                    ApplicationArea = All;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field("Housing Alloted End Date"; Rec."Housing Alloted End Date")
                {
                    ApplicationArea = All;

                }
                field("Inventory Verified"; Rec."Inventory Verified")
                {
                    ApplicationArea = All;

                }
                field("Housing Changed On"; Rec."Housing Changed On")
                {
                    ApplicationArea = All;

                }
                field("Housing Cos"; Rec."Housing Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Housing Cost';

                }
                field("Housing Vacated On"; Rec."Housing Vacated On")
                {
                    ApplicationArea = All;

                }
                field("Original Application No."; Rec."Original Application No.")
                {
                    ApplicationArea = All;

                }
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
                    InteractionGroup.SetRange("Type", InteractionGroup."Type"::"Housing Ledger");
                    IF not InteractionGroup.FindLast() then
                        Error('Interaction Group not found for Type Housing Ledger.');

                    InterLogEntryCommentLine.Reset();
                    InterLogEntryCommentLine.SetRange("Source No.", Rec."Original Application No.");
                    InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                    InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                    InterLogEntryCommentLine.SetRange("Student No.", Rec."Student No.");
                    // Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine)'
                end;
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
                Caption = '&Student Room Wise Inventory';
                ApplicationArea = All;
                Image = Inventory;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;
                RunObject = Page "Student Room Wise Inventory";
                RunPageLink = "Ledger Entry No." = FIELD("Entry No.");

            }
            action("Room Category Fee Setup")
            {
                Caption = '&Room Category Fee Setup';
                ApplicationArea = All;
                Image = SetupPayment;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "Room Category Fee Setup";
                RunPageLink = "Housing ID" = FIELD("Housing ID");

            }

            Group("Housing Reports")
            {
                action("Bed Count")
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


}
page 50051 "Roster Lines View"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Line";
    SourceTableView = sorting("Start Date");
    Caption = 'Rotation Details View';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;

                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Waitlisted; Rec.Waitlisted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New/Returning"; Rec."New/Returning")
                {
                    ApplicationArea = All;
                }
                field("Rotation Grade"; Rec."Rotation Grade")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Credits; Rec.Credits)
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled On"; Rec."Scheduled On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published On"; Rec."Published On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancel Reason Description"; Rec."Cancel Reason Description")
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
            action("Rotation Card")
            {
                ApplicationArea = All;
                Caption = 'Rotation Card';
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+F5';
                Visible = false;

                trigger OnAction()
                begin
                    OpenRotationCard();
                end;
            }
        }
    }

    procedure OpenRotationCard()
    var
        RSH: Record "Roster Scheduling Header";
    begin
        RSH.Reset();
        RSH.FilterGroup(2);
        RSH.SetRange("Rotation ID", Rec."Rotation ID");
        RSH.FilterGroup(0);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
            Page.RunModal(Page::"Confirm Roster Scheduling Card", RSH);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
            Page.RunModal(Page::"FM1/IM1 Roster Card+", RSH);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
            Page.RunModal(Page::"Elective Rotation Card", RSH);
    end;
}
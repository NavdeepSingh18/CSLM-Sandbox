page 50942 "Hospital Wise Rotations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Vendor;
    // SourceTableView = where("Vendor Sub Type" = filter("Hospital"));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenRotations();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenRotations();
                    end;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
            }
        }
        // area(FactBoxes)
        // {
        //     part("Information";Rec."Hospital List FactBox")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Rotation Information';
        //         SubPageLink = "Hospital ID" = field("No.");
        //     }
        // }
    }

    actions
    {
        area(Processing)
        {
            action("List of Rotations")
            {
                ApplicationArea = All;
                Caption = 'List of Rotations';
                ShortcutKey = 'F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromJob;
                trigger OnAction()
                begin
                    OpenRotations();
                end;
            }
        }
    }
    /// <summary> 
    /// Description for OpenRotationEntries.
    /// </summary>
    procedure OpenRotations()
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
    begin
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.FilterGroup(2);
        RosterSchedulingLine.SetRange("Hospital ID", Rec."No.");
        RosterSchedulingLine.FilterGroup(0);
        page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine);
    end;
}
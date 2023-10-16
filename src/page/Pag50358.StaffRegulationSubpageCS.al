page 50358 "Staff Regulation Subpage-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Staff Regulation Subpage-CS';
    PageType = CardPart;
    SourceTable = "Discipline Line Faculty-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Commited"; Rec."Date Commited")
                {
                    ApplicationArea = All;
                }
                field(Severity; Rec.Severity)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Staff Code"; Rec."Staff Code")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = All;
                }
                field("Remedial Measures"; Rec."Remedial Measures")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
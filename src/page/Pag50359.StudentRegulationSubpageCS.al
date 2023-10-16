page 50359 "Student Regulation Subpage-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Student Regulation Subpage-CS';
    PageType = CardPart;
    SourceTable = "Discipline Line Student-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Commited"; Rec."Date Commited")
                {
                    ApplicationArea = all;
                }
                field("Severity Code"; Rec."Severity Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Staff Code"; Rec."Staff Code")
                {
                    ApplicationArea = all;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = all;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = all;
                }
                field("Remedial Measures"; Rec."Remedial Measures")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
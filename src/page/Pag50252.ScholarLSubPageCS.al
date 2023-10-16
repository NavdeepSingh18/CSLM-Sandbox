page 50252 "Scholar. L SubPage-CS"
{
    // version V.001-CS
    Caption = 'Scholar. L SubPage-CS';
    AutoSplitKey = true;
    PageType = CardPart;
    SourceTable = "Scholarship Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Amount To Pay"; Rec."Amount To Pay")
                {
                    ApplicationArea = All;
                }
                field("Percentage To Pay"; Rec."Percentage To Pay")
                {
                    ApplicationArea = All;
                }
                Field("Alternative Percentage to Pay"; Rec."Alternative Percentage to Pay")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var



}


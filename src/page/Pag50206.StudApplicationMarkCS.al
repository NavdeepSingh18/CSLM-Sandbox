page 50206 "Stud. Application Mark-CS"
{
    // version V.001-CS

    Caption = 'Application Mark';
    PageType = CardPart;
    SourceTable = "Mobile API Response";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Url; Rec.Url)
                {
                    ApplicationArea = All;
                }
                field(Operation; Rec.Operation)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Synch Value"; Rec."Synch Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
       // StudentTaskCS: Record "Student Task-CS";
}


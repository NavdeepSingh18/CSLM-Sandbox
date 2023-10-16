page 50202 "Applicant Eval Mark-CS"
{
    // version V.001-CS

    Caption = 'Applicant Evaluation Mark';
    Editable = true;
    PageType = ListPart;
    SourceTable = "Evaluation Applicant-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Evaluation Method Code"; Rec."Evaluation Method Code")
                {
                    ApplicationArea = All;

                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
                field("Attendance Status"; Rec."Attendance Status")
                {
                    ApplicationArea = All;
                }
                field("Mark Obtained"; Rec."Mark Obtained")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}


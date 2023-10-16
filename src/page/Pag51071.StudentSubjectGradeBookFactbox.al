page 51071 StudentSubjectGradeBookFactbox
{
    // PageType = List;
    Caption = 'Student Subject Grade Book Factbox';
    // ApplicationArea = All;
    // UsageCategory = Lists;
    SourceTable = "Student Subject GradeBook";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    LinksAllowed = false;
    PageType = CardPart;
    layout
    {
        area(Content)
        {
            group(StudentDetails)
            {


                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Click here to open the Student Card';
                    trigger OnDrillDown()
                    var
                        Stud: Record "Student Master-CS";
                        StudMasterCard: Page "Student Detail Card-CS";
                    begin
                        Stud.Reset();
                        Stud.SetRange("No.", Rec."Student No.");
                        Stud.FindFirst();
                        // Clear((StudMasterCard));
                        StudMasterCard.SetTableView(Stud);
                        StudMasterCard.Run();

                    end;
                }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = all;
                }

                field("Numeric Grade"; Rec."Numeric Grade")
                {
                    ApplicationArea = all;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = all;
                }
                field("Grade To Be Published"; Rec."Grade To Be Published")
                {
                    ApplicationArea = all;
                }
                Field(GPA; Rec.GPA)
                {
                    ApplicationArea = All;
                }
                field("Credit Earned"; Rec."Credit Earned")
                {
                    ApplicationArea = all;
                    Visible = False;
                }

                field("% Range"; Rec."% Range")
                {
                    ApplicationArea = all;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = all;
                }
            }
        }
    }


}
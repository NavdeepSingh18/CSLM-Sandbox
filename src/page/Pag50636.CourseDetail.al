page 50636 "Course Detail"
{
    UsageCategory = None;
    Caption = 'Course Detail';
    CardPageID = "Course Detail Card-CS";
    Editable = false;
    PageType = ListPart;
    SourceTable = "Course Master-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CourseMaster.Reset();
                        CourseMaster.SetRange(Code, Rec.Code);
                        CDCard.SetTableView(CourseMaster);
                        CDCard.Editable := false;
                        CDCard.Run();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field("Duration of Years"; Rec."Duration of Years")
                {
                    ApplicationArea = All;
                }
                field("Number of Semesters"; Rec."Number of Semesters")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        CourseMaster: Record "Course Master-CS";
        CDCard: Page "Course Detail Card-CS";

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());
        Rec.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
    end;
}
page 51082 "Dummy Student Subject"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Medical Scholars Line";
    Editable = True;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;

                }
                Field("Semster No"; Rec."Semster No")
                {
                    ApplicationArea = All;
                }
                Field(Term; Rec.Term)
                {
                    ApplicationArea = Al;
                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                Field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                Field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                Field("Expected End Date"; Rec."Expected End Date")
                {
                    ApplicationArea = All;
                }
                Field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;

                }
                Field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                Field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                Field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                }
                Field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }
}
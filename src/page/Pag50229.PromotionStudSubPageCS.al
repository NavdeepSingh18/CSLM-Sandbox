page 50229 "Promotion Stud SubPage-CS"
{
    // version V.001-CS

    Caption = 'Promotion Stud SubPage-CS';
    PageType = CardPart;
    SourceTable = "Promotion Line-CS";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    Caption = 'Enrollment No.';
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Caption = 'Student Name';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Graduation Code"; Rec."Graduation Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field("Promoted Year"; Rec."Promoted Year")
                {
                    ApplicationArea = All;
                }
                field("Promoted Semester"; Rec."Promoted Semester")
                {
                    ApplicationArea = All;
                }
                field("Earnd Percentage"; Rec."Earnd Percentage")
                {
                    ApplicationArea = All;
                }
                field("Type Of Repeat"; Rec."Type Of Repeat")
                {
                    ApplicationArea = All;
                }
                field("Repeat Application No"; Rec."Repeat Application No")
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("In Active"; Rec."In Active")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Not Eligible"; Rec."Not Eligible")
                {
                    ApplicationArea = All;
                }
                field("Student Promoted"; Rec."Student Promoted")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}


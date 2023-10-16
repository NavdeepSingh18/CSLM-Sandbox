page 50697 "FERPA Module Allowed List"
{

    PageType = ListPart;
    SourceTable = "FERPA Module Allowed";
    Caption = 'FERPA Module Allowed List';
    ApplicationArea = All;
    UsageCategory = Lists;
    DelayedInsert = True;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Module Code"; Rec."Module Code")
                {
                    ApplicationArea = All;
                }
                field("Module Name"; Rec."Module Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}

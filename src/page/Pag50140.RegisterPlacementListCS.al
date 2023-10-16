page 50140 "Register(Placement) List-CS"
{
    // version V.001-CS

    //CardPageID = "Register(Placement) Card-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Student Placement Reg-CS";
    Caption = 'Register(Placement) List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                Enabled = true;
                field("Register No."; Rec."Register No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Academic year"; Rec."Academic year")
                {
                    ApplicationArea = All;
                }
                field(Placed; Rec.Placed)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Placement Register")
            {
                Caption = '&Placement Register';
                // action("Placement &Card")
                // {
                //     Caption = 'Placement &Card';
                //     RunObject = Page 50122;
                //     RunPageLink = "Register No." = FIELD("Register No.");
                //     RunPageView = SORTING("Register No.");
                //     ShortCutKey = 'Shift+F7';
                //     ApplicationArea = All;
                // }
            }
        }
    }
}
page 50134 "Exam Atdn Stud Ext. Line-CS"
{

    Caption = 'SAFI LP Date Elements';
    PageType = ListPart;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "SAFI LP Date Elements";
    DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("LP Start"; Rec."LP Start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LP Start field.';
                }
                field("LP End"; Rec."LP End")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LP End field.';
                }
                field("EST Disbursement"; Rec."EST Disbursement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EST Disbursement field.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Term field.';
                }
            }
        }
    }
    var
        RoomsCS: Record "Rooms-CS";

}


page 50204 "Stud Prequalify Subject-CS"
{
    // version V.001-CS

    // ---------------------------------------------------------------------------------------
    // SlNo.   Date       Sign         Description
    // ---------------------------------------------------------------------------------------
    // FSS01   18.05.07    TR&ABK      New form is Created
    // 02      30/10/09    Vandhana   Edit-OnPush()    To make the form editable.
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Prequalification Subjects -COL';
    Editable = true;
    PageType = List;
    SourceTable = "Class Assignment Header-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
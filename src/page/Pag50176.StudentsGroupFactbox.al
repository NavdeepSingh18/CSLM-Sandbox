page 50176 "Student Clinical Group Facbox"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Group";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Groups Code"; Rec."Groups Code")
                {
                    ApplicationArea = All;
                    Caption = 'Group Code';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
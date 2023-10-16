page 50788 "Student Time Line"
{
    Caption = 'Student Timeline';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Time Line";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = False;
    SourceTableView = where("Hidden Entry" = filter(False));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
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
                field("Activity performed"; Rec."Activity performed")
                {
                    ApplicationArea = All;
                }

                field("Created By"; rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created on"; Rec."Created on")
                {
                    ApplicationArea = All;
                }


            }
        }

    }


}
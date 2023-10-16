page 50464 "Student Clinical Group List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Group";
    SourceTableView = where(Blocked = Filter(false));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Student Detail")
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Editable = false;
                }
                field("Student Name"; StudentName)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Editable = false;
                    Caption = 'Student Name';
                }
            }
            repeater(General)
            {
                field("Groups Code"; Rec."Groups Code")
                {
                    ApplicationArea = All;
                    Caption = 'Group Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
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

    actions
    {
        area(Processing)
        {
            action("Remove Group")
            {
                ApplicationArea = All;
                Caption = 'Remove Group';
                Image = DeleteRow;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    if Confirm('Do you want to remove Student No. - %1 (%2) form the Group - %3 (%4)?', true, Rec."Student No.", StudentName, Rec."Groups Code", Rec.Description) then
                        Rec.Delete();
                end;
            }
        }
    }


    var
        StudentMaster: Record "Student Master-CS";
        StudentName: Text[150];

    trigger OnAfterGetRecord()
    begin
        StudentMaster.Reset();
        if StudentMaster.Get(Rec."Student No.") then
            StudentName := StudentMaster."Student Name";
    end;
}
page 51011 "Return Payment Entry List_P"
{

    ApplicationArea = All;
    Caption = 'Reversed Entry Processed List';
    PageType = List;
    SourceTable = "SLcM Reversal Entry";

    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            field(Status; Status)
            {
                ApplicationArea = All;
                Editable = false;
            }
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    editable = false;
                }
                field("Processed Date"; Rec."Processed Date")
                {
                    ApplicationArea = All;
                    editable = false;
                }
                field("Processed Time"; Rec."Processed Time")
                {
                    ApplicationArea = All;
                    editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Document No."; Rec."Payment Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Document Select"; Rec."Payment Document Select")
                {
                    ToolTip = 'Specifies the value of the Document Select field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaning Amount"; Rec."Remaning Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reverse Applicable"; Rec."Reverse Applicable")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange(Reversed, true);
        Rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    var

    begin
        JobQueueGlobal.Setrange("Object Type to Run", JobQueueGlobal."Object Type to Run"::Report);
        JobQueueGlobal.Setrange("Object ID to Run", 50200);
        if JobQueueGlobal.FindFirst() then
            Status := JobQueueGlobal.Status;
    end;

    var
        RevCount: Integer;
        Status: Option Ready,"In Process",Error,"On Hold",Finished,"On Hold with Inactivity Timeout";
        JobQueueGlobal: Record "Job Queue Entry";
}

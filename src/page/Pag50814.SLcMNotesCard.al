page 50814 "SLcM Notes Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'SLcM Notes';
    SourceTable = "Interaction Log Entry";
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Editable = EditDept;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = EditPage;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Interaction Status code"; Rec."Interaction Status code")
                {
                    ApplicationArea = All;
                    Editable = EditPage;
                }
                field("Interaction Status Description"; Rec."Interaction Status Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
        DimValue: Record "Dimension Value";
        usersetupapprover: record "Document Approver Users";
    begin
        UserSetup.Reset();
        IF UserSetup.Get(UserId()) then;

        usersetupapprover.Reset();
        usersetupapprover.SetRange("User ID", userid());
        if usersetupapprover.FindFirst() then;
        Rec.Department := usersetupapprover."Department Approver Type";


        Rec."Department Name" := '';
        if DimValue.Get('DEPARTMENT', Rec."Global Dimension 2 Code") then
            Rec."Department Name" := DimValue.Name;
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        DimValue: Record "Dimension Value";
    begin


        EditDept := true;
        if Rec.Department <> Rec.Department::" " then
            EditDept := false;

        EditPage := true;
        PosStr := StrPos(Rec."Interaction Status Description", 'Close');
        if PosStr <> 0 then
            EditPage := false;
    end;

    trigger OnAfterGetRecord()
    begin
        EditDept := true;
        if Rec.Department <> Rec.Department::" " then
            EditDept := false;

        EditPage := true;
        //PosStr := StrPos("Interaction Status Description", 'Close');
        PosStr := StrPos(Rec."Interaction Status Description", 'NOT REQUIRED');
        if PosStr <> 0 then
            EditPage := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec.Notes = '') and (Rec."Entry No." <> 0) then
            if Rec.Delete() then;
    end;

    var
        EditDept: Boolean;
        PosStr: Integer;
        EditPage: Boolean;
        StudentNo: Code[20];
}
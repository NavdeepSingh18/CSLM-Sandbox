page 50020 "Degree SLcM Notes List"
{
    Caption = 'Degree SLcM Notes List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Interaction Log Entry";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenNotes();
                    end;
                }


                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                }
                field("Interaction Status"; Rec."Interaction Status code")
                {
                    ApplicationArea = All;
                }
                field("Interaction Status Description"; Rec."Interaction Status Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
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
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        OpenNotes();
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Add New Note")
            {
                ApplicationArea = Comments;
                Caption = 'Add New Note';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    InterLogEntryCommentLine: Record "Interaction Log Entry";
                    UserSetup: Record "User Setup";
                    StudentMaster: Record "Student Master-CS";
                    usersetupapprover: record "Document Approver Users";
                    SLcMNotes: Page "Degree SLcM Notes";
                    InteractionTemplateCode: Code[10];
                    InteractionGroupCode: Code[10];

                    EntryNo: Integer;
                begin
                    InteractionTemplateCode := REc.GetFilter("Interaction Template Code");
                    InteractionGroupCode := Rec.GetFilter("Interaction Group Code");
                    SourceNo := Rec.GetFilter("Source No.");
                    StudentNo := REc.GetFilter("Student No. Filter");
                    InterLogEntryCommentLine.Reset();
                    if InterLogEntryCommentLine.FindLast() then
                        EntryNo := InterLogEntryCommentLine."Entry No."
                    else
                        EntryNo := 0;

                    UserSetup.Reset();
                    if UserSetup.Get(UserId) then;

                    usersetupapprover.Reset();
                    usersetupapprover.SetRange("User ID", userid());
                    if usersetupapprover.FindFirst() then;

                    StudentMaster.Reset();
                    if StudentMaster.Get(StudentNo) then;

                    InterLogEntryCommentLine.Init();
                    InterLogEntryCommentLine."Entry No." := EntryNo + 1;
                    InterLogEntryCommentLine."Source No." := SourceNo;
                    InterLogEntryCommentLine.Validate("Interaction Template Code", InteractionTemplateCode);
                    InterLogEntryCommentLine.Validate("Interaction Group Code", InteractionGroupCode);
                    InterLogEntryCommentLine.Validate("Student No.", StudentNo);
                    InterLogEntryCommentLine."Original Student No." := StudentMaster."Original Student No.";
                    InterLogEntryCommentLine.Validate("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    InterLogEntryCommentLine.Department := usersetupapprover."Department Approver Type";
                    InterLogEntryCommentLine."Created By" := UserId;
                    InterLogEntryCommentLine."Created On" := Today;
                    InterLogEntryCommentLine.Insert(true);
                    Commit();
                    Clear(SLcMNotes);
                    SLcMNotes.SetRecord(InterLogEntryCommentLine);
                    SLcMNotes.SetTableView(InterLogEntryCommentLine);
                    SLcMNotes.RunModal();
                end;
            }
            action("Edit")
            {
                ApplicationArea = Comments;
                Caption = 'Edit Note';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    OpenNotes();
                end;
            }
        }
    }

    var
        SourceNo: Code[20];
        StudentNo: Code[20];

    procedure SetVariables(LSourceNo: Code[20]; LStudentNo: Code[20])
    begin
        SourceNo := LSourceNo;
        StudentNo := LStudentNo;
    end;

    procedure OpenNotes()
    var
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        SLcMNotes: Page "Degree SLcM Notes";
    begin
        InterLogEntryCommentLine.Reset();
        InterLogEntryCommentLine.SetRange("Entry No.", Rec."Entry No.");

        Clear(SLcMNotes);
        SLcMNotes.SetRecord(InterLogEntryCommentLine);
        SLcMNotes.SetTableView(InterLogEntryCommentLine);
        SLcMNotes.RunModal();
    end;
}
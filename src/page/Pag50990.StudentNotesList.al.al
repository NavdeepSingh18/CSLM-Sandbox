page 50990 "Student Notes List"
{
    Caption = 'Student Notes';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Interaction Log Entry";
    InsertAllowed = false;
    // ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenNotes();
                    end;
                }
                field(Notes; Note)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        If OldNote <> Note then
                            Error('Please click on Edit Note');
                    end;


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
                Field("User Name"; Rec."User Name")
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
                field("Interaction Template Desc"; Rec."Interaction Template Desc")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Template Description';
                }
                field("Attachment Exists"; Rec."Attachment Exists")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        OpenNotes();
                    end;
                }
                field(Correction; Rec.Correction)
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
                    SLcMNotes: Page "Student Notes Card";
                    InteractionTemplateCode: Code[10];
                    InteractionGroupCode: Code[10];

                    EntryNo: Integer;
                begin
                    InteractionTemplateCode := Rec.GetFilter("Interaction Template Code");
                    InteractionGroupCode := Rec.GetFilter("Interaction Group Code");
                    SourceNo := Rec.GetFilter("Source No.");
                    StudentNo := Rec.GetFilter("Student No. Filter");
                    InterLogEntryCommentLine.Reset();
                    if InterLogEntryCommentLine.FindLast() then
                        EntryNo := InterLogEntryCommentLine."Entry No."
                    else
                        EntryNo := 0;

                    StudentMaster.Reset();
                    if StudentMaster.Get(StudentNo) then;

                    UserSetup.Reset();
                    if UserSetup.Get(UserId) then;

                    InterLogEntryCommentLine.Init();
                    InterLogEntryCommentLine."Entry No." := EntryNo + 1;
                    InterLogEntryCommentLine."Source No." := SourceNo;
                    InterLogEntryCommentLine.Validate("Interaction Template Code", InteractionTemplateCode);
                    InterLogEntryCommentLine.Validate("Interaction Group Code", InteractionGroupCode);
                    InterLogEntryCommentLine.Validate("Original Student No.", StudentMaster."Original Student No.");
                    InterLogEntryCommentLine.Validate("Student No.", StudentNo);
                    InterLogEntryCommentLine.Validate("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    InterLogEntryCommentLine.Department := UserSetup."Department Approver";
                    InterLogEntryCommentLine."Student Notes" := true;
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
            action("View Expanded Notes")
            {
                ApplicationArea = All;
                Caption = 'View Expanded Notes';
                Image = ExportMessage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = 'Ctrl+Shift+D';

                trigger OnAction()
                begin
                    Message('%1', Rec.Notes);
                end;
            }
        }
    }

    var
        SourceNo: Code[20];
        StudentNo: Code[20];
        Note: Text[20];
        OldNote: Text[20];

    trigger OnOpenPage()
    Begin

        Note := '';
        Note := CopyStr(Rec.Notes, 1, 20);
        OldNote := Note;
    End;

    trigger OnAfterGetRecord()
    Begin

        Note := '';
        Note := CopyStr(Rec.Notes, 1, 20);
        OldNote := Note;
    End;


    trigger OnModifyRecord(): Boolean
    begin
        If Rec."Student No." <> xRec."Student No." then
            Error('Please click on Edit Note');
        If Rec.Notes <> xRec.Notes then
            Error('Please click on Edit Note');
        IF Rec.Department <> xRec.Department then
            Error('Please click on Edit Note');
        If Rec."Interaction Status code" <> xRec."Interaction Status code" then
            Error('Please click on Edit Note');
        If Rec."Created By" <> xRec."Created By" then
            Error('Please click on Edit Note');
        If Rec."Created On" <> xRec."Created On" then
            Error('Please click on Edit Note');
        If Rec."Template Type" <> xRec."Template Type" then
            Error('Please click on Edit Note');
        IF Rec."Interaction Template Desc" <> xRec."Interaction Template Desc" then
            Error('Please click on Edit Note');
        IF Rec."Attachment Exists" <> xRec."Attachment Exists" then
            Error('Please click on Edit Note');
        If Rec."Entry No." <> xRec."Entry No." then
            Error('Please click on Edit Note');
        If Rec.Correction <> xRec.Correction then
            Error('Please click on Edit Note');
    end;

    procedure SetVariables(LSourceNo: Code[20]; LStudentNo: Code[20])
    begin
        SourceNo := LSourceNo;
        StudentNo := LStudentNo;
    end;

    procedure OpenNotes()
    var
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        SLcMNotes: Page "Student Notes Card";
    begin
        InterLogEntryCommentLine.Reset();
        InterLogEntryCommentLine.SetRange("Entry No.", Rec."Entry No.");

        Clear(SLcMNotes);
        SLcMNotes.SetRecord(InterLogEntryCommentLine);
        SLcMNotes.SetTableView(InterLogEntryCommentLine);
        SLcMNotes.RunModal();
    end;


}
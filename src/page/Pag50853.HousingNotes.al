page 50853 "Housing Notes"
{

    PageType = CardPart;
    SourceTable = "Interaction Log Entry";
    Caption = 'Notes';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group("Housing Note")
            {
                Caption = 'Notes';
                field(NoteCount2; NoteCount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Note Count';
                    Style = Strong;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        InteractionLogEntry.Reset();
                        InteractionLogEntry.SetRange("Source No.", Rec."Source No.");
                        // InteractionLogEntry.SetRange("Student No.", "Student No.");
                        InteractionLogEntryList.SetTableView(InteractionLogEntry);
                        InteractionLogEntryList.Editable := false;
                        InteractionLogEntryList.Run();
                    end;
                }


                repeater(Housing)
                {

                    field(Notes; Rec.Notes)
                    {
                        ApplicationArea = All;
                        Caption = 'Notes';
                        Style = Strong;
                        Editable = false;
                    }
                    // field("Student Name"; "Student Name")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Student Name';
                    //     Editable = false;
                    // }

                }

            }
        }
    }

    var
        InteractionLogEntry: Record "Interaction Log Entry";
        InteractionLogEntryList: Page "SLcM Notes List";

        NoteCount: Integer;

    trigger OnAfterGetCurrRecord()
    begin
        NoteCount := 0;
        if Rec."Source No." <> '' then begin
            NoteCount := 0;
            InteractionLogEntry.Reset();
            InteractionLogEntry.SetRange("Source No.", Rec."Source No.");
            //  InteractionLogEntry.SetRange("Student No.", "Student No.");
            IF InteractionLogEntry.FindSet() then
                NoteCount := InteractionLogEntry.Count();
        end;
    end;

}

page 50926 "Residency Note"
{
    PageType = CardPart;
    Caption = 'Residency Note';
    SourceTable = "Interaction Log Entry";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    // SourceTableView = where("Sign-off" = Filter(false), "Hold Type" = FILTER(<> Registrar));


    layout
    {
        area(Content)
        {
            group("Residency Note")
            {
                Caption = 'Residency Note';
                field(HoldCount2; HoldCount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Note Count';
                    Style = Strong;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        InteractionLogEntry.Reset();
                        InteractionLogEntry.SetRange("Source No.", Rec."Source No.");
                        InteractionLogEntry.SetRange("Student No.", Rec."Student No.");
                        InteractionLogEntryList.SetTableView(InteractionLogEntry);
                        InteractionLogEntryList.Editable := false;
                        InteractionLogEntryList.Run();
                    end;
                }


                repeater(Residency)
                {

                    field(Notes; Rec.Notes)
                    {
                        ApplicationArea = All;
                        Caption = 'Notes';
                        Style = Strong;
                        Editable = false;
                    }
                    field("Student Name"; Rec."Student Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Student Name';
                        Editable = false;
                    }

                }

            }
        }
    }

    var
        InteractionLogEntry: Record "Interaction Log Entry";
        InteractionLogEntryList: Page "SLcM Notes List";

        HoldCount: Integer;

    trigger OnAfterGetRecord()
    begin
        InteractionLogEntry.Reset();
        InteractionLogEntry.SetRange("Source No.", Rec."Source No.");
        InteractionLogEntry.SetRange("Student No.", Rec."Student No.");
        IF InteractionLogEntry.FindSet() then
            HoldCount := InteractionLogEntry.Count();


    end;


}
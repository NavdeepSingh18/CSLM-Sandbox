pageextension 50060 ExtendsInteractionGroups extends "Interaction Groups"
{
    layout
    {
        addafter("Code")
        {
            field("Type"; Rec."Type")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Type");
    end;
}
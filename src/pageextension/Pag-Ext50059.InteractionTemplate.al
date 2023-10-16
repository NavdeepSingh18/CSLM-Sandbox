pageextension 50059 ExtendsInteractionTemplates extends "Interaction Templates"
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
        modify("Interaction Group Code")
        {
            Visible = false;
        }
        modify("Wizard Action")
        {
            Visible = false;
        }
        modify("Language Code (Default)")
        {
            Visible = false;
        }
        modify(Attachment)
        {
            Visible = false;
        }
        modify("Ignore Contact Corres. Type")
        {
            Visible = false;
        }
        modify("Correspondence Type (Default)")
        {
            Visible = false;
        }
        modify("Unit Cost (LCY)")
        {
            Visible = false;
        }
        modify("Unit Duration (Min.)")
        {
            Visible = false;
        }
        modify("Initiated By")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Campaign Target")
        {
            Visible = false;
        }
        modify("Campaign Response")
        {
            Visible = false;
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Type");
    end;
}
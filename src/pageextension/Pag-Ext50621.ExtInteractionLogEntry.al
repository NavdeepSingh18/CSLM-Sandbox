pageextension 50621 ExtInteractionLogEntry extends "Interaction Log Entries"
{
    layout
    {
        addafter("Interaction Template Code")
        {
            field("Student No."; Rec."Student No.")
            {
                ApplicationArea = All;
            }
            field("Student Name"; Rec."Student Name")
            {
                ApplicationArea = All;
            }
            field("Enrollment No."; Rec."Enrollment No.")
            {
                ApplicationArea = All;
            }
            field("Interaction Subject"; Rec."Interaction Subject")
            {
                ApplicationArea = All;
            }

            field(Notes; Rec.Notes)
            {
                ApplicationArea = All;
            }

            field("Interaction Status code"; Rec."Interaction Status code")
            {
                ApplicationArea = all;
            }
            field("Interaction Status Description"; Rec."Interaction Status Description")
            {
                ApplicationArea = all;
            }
            field("Interaction Result"; Rec."Interaction Result")
            {
                ApplicationArea = All;
            }
            field("Interaction Result Description"; Rec."Interaction Result Description")
            {
                ApplicationArea = All;
            }
        }

        modify(Canceled)
        {
            Visible = false;
        }
        modify("Attempt Failed")
        {
            Visible = false;
        }
        modify(Date)
        {
            Visible = false;
        }
        modify(Description)
        {
            Visible = false;
        }
        modify(Attachment)
        {
            Visible = false;
        }
        modify("Contact No.")
        {
            Visible = false;
        }
        modify("Contact Name")
        {
            Visible = false;
        }
        modify("Contact Company No.")
        {
            Visible = false;
        }
        modify("Contact Company Name")
        {
            Visible = false;
        }
        modify(Evaluation)
        {
            Visible = false;
        }
        modify("Cost (LCY)")
        {
            Visible = false;
        }
        modify("Duration (Min.)")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Information Flow")
        {
            Visible = false;
        }
        modify("Initiated By")
        {
            Visible = false;
        }
        modify("Time of Interaction")
        {
            Visible = false;
        }
    }
}
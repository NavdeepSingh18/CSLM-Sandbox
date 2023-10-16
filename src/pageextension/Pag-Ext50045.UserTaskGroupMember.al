pageextension 50045 UserTaskGroupMember extends "User Task Group Members"
{
    layout
    {
        addafter("User Name")
        {
            Field("Per User % Comp."; Rec."Per User % Comp.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
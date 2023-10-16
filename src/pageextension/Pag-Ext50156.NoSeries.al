pageextension 50156 NoSeriesLinesExt extends "No. Series Lines"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }



    Trigger OnModifyRecord(): Boolean
    Var
        UserSetup: Record "User Setup";
    Begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        If UserSetup.FindFirst() then
            If not UserSetup."No. Series Permission" then
                Error('You do not have permission to access this page.');
    End;

    trigger OnDeleteRecord(): Boolean
    Var
        UserSetup: Record "User Setup";
    Begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        If UserSetup.FindFirst() then
            If not UserSetup."No. Series Permission" then
                Error('You do not have permission to access this page.');
    End;
}
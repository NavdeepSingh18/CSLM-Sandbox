pageextension 50596 ExtReasonCode extends "Reason Codes"
{
    layout
    {
        addafter(Description)
        {
            field(Type; Rec.Type)
            {
                ToolTip = 'Type';
                ApplicationArea = all;
            }
            field(Block; Rec.Block)
            {
                ToolTip = 'Block';
                ApplicationArea = all;
            }
            Field("Show Description"; Rec."Show Description")
            {
                ApplicationArea = All;
            }
        }
    }
}
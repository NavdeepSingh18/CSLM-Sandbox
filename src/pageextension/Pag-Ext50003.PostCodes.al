pageextension 50003 ExtPostCodes extends "Post Codes"
{
    layout
    {
        addafter(City)
        {
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = all;
            }
        }
        modify(County)
        {
            Visible = false;
            Editable = false;
        }
    }
}
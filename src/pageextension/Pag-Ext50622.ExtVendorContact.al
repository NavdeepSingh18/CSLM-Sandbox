pageextension 50622 ExtContact extends "Contact Card"
{
    layout
    {
        addafter(Name)
        {
            field("Relationship Manager"; Rec."Relationship Manager")
            {
                ApplicationArea = All;
            }
            field("Department"; Rec."Department")
            {
                Caption = 'Department';
                ApplicationArea = all;
            }
            field("Other Phone"; Rec."Other Phone")
            {
                Caption = 'Other Phone';
                ApplicationArea = all;
            }
        }
    }
}
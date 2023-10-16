page 51062 "Reason Request List"
{

    Caption = 'Request Reason-Advisor Mapping List';
    PageType = List;
    SourceTable = "Reason wise Advisor Setup";

    layout//GMCSCOM
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Advisor Id"; Rec."Advisor Id")
                {
                    ToolTip = 'Specifies the value of the Advisor Id field.';
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
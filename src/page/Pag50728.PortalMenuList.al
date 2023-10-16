page 50728 "Portal Menu List"
{
    Caption = 'Portal Menu List';
    PageType = List;
    SourceTable = "Portal Menu";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {

        area(content)
        {
            repeater(Group)
            {

                field("Menu Code"; Rec."Menu Code")
                {
                    ApplicationArea = All;
                    Caption = 'Menu Code';
                    Tooltip = 'Specifies the Menu Code.';
                }

                field("Menu Name"; Rec."Menu Name")
                {
                    ApplicationArea = All;
                    Caption = 'Menu Name';
                    Tooltip = 'Specifies the Menu Name.';
                }

                field("PRIORITY"; Rec."PRIORITY")
                {
                    ApplicationArea = All;
                    Caption = 'PRIORITY';
                    Tooltip = 'Specifies the PRIORITY.';
                }

                field("Link"; Rec."Link")
                {
                    ApplicationArea = All;
                    Caption = 'Link';
                    Tooltip = 'Specifies the Link.';
                }

                field("Parent ID"; Rec."Parent ID")
                {
                    ApplicationArea = All;
                    Caption = 'Parent ID';
                    Tooltip = 'Specifies the Parent ID.';
                }

                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    Tooltip = 'Specifies the ID.';
                }

                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    Caption = 'Active';
                    Tooltip = 'Specifies the Active.';
                }

                field("Availability"; Rec."Availability")
                {
                    ApplicationArea = All;
                    Caption = 'Availability';
                    Tooltip = 'Specifies the Availability.';
                }

                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                    Caption = 'Event Code';
                    Tooltip = 'Specifies the Event Code.';
                }

            }
        }
    }

}
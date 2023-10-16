page 50149 "Event Master Hdr-CS"
{
    // version V.001-CS

    PageType = Document;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Education Event-CS";
    Caption = 'Event Master Header';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Event Code"; Rec."Event Code")
                {
                    ToolTip = 'Event Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field("Event Day Calculation"; Rec."Event Day Calculation")
                {
                    ToolTip = 'Event Day Calculation';
                    ApplicationArea = All;
                }
                field("Reminder Days"; Rec."Reminder Days")
                {
                    ToolTip = 'Reminder Days';
                    ApplicationArea = All;
                }
            }
            // part("Event Master SubPage-CS"; 50021)
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Document No." = FIELD("Event Code");
            // }
        }
    }

    actions
    {
    }
}


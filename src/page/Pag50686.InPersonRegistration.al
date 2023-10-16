page 50686 "In Person Registration"
{

    PageType = List;
    SourceTable = "In Person Registration";
    Caption = 'In Person Registration';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Last Name First Letter Range"; Rec."Last Name First Letter Range")
                {
                    ApplicationArea = All;
                }
                field("Date of In-Person"; Rec."Date of In-Person")
                {
                    ApplicationArea = All;
                }
                field("Time Slot of In-Person"; Rec."Time Slot of In-Person")
                {
                    ApplicationArea = All;
                }
                field("Place of In-Person"; Rec."Place of In-Person")
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}

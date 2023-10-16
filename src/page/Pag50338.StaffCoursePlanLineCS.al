page 50338 "Staff Course Plan Line-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Staff Course Plan Line';
    PageType = CardPart;
    SourceTable = "Course Plan Line Faculty-CS";

    layout
    {
        area(content)
        {
            repeater(A)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Chapter Code"; Rec."Chapter Code")
                {
                    ApplicationArea = All;
                }
                field("Chapter Name"; Rec."Chapter Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Topics; Rec.Topics)
                {
                    ApplicationArea = All;
                }
                field(Week; Rec.Week)
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("No of Minuites"; Rec."No of Minuites")
                {
                    ApplicationArea = All;
                }
                field("Learning OutCome"; Rec."Learning OutCome")
                {
                    ApplicationArea = All;
                }
                field(Assesment; Rec.Assesment)
                {
                    ApplicationArea = All;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}


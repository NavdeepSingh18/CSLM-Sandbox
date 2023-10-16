page 50340 "Staff Usual Rec Line-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Staff Usual Rec Line-CS';
    PageType = CardPart;
    SourceTable = "Course Plan Line Faculty-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Chapter Code"; Rec."Chapter Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Chapter Name"; Rec."Chapter Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Week; Rec.Week)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No of Minuites"; Rec."No of Minuites")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Learning OutCome"; Rec."Learning OutCome")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Assesment; Rec.Assesment)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Work Status"; Rec."Work Status")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Date"; Rec."Actual Date")
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
page 50146 "Stud Plac. History Card-CS"
{
    // version V.001-CS

    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Student Placement History-CS";
    SourceTableView = WHERE(Closed = CONST(True));
    Caption='Stud Plac. History Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Placement ID"; Rec."Placement ID")
                {
                    ApplicationArea = All;
                }
                field("Schedule ID"; Rec."Schedule ID")
                {
                    ApplicationArea = All;
                }
                field("Registration ID"; Rec."Registration ID")
                {
                    ApplicationArea = All;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Company Id"; Rec."Company Id")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Campus Date"; Rec."Campus Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Clear"; Rec."Exam Clear")
                {
                    ApplicationArea = All;
                }
                field("Technical Clear"; Rec."Technical Clear")
                {
                    ApplicationArea = All;
                }
                field("HR Clear"; Rec."HR Clear")
                {
                    ApplicationArea = All;
                }
                field(Placed; Rec.Placed)
                {
                    ApplicationArea = All;
                }
                field("Offer Letter"; Rec."Offer Letter")
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


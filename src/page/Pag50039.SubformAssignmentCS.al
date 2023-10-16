page 50039 "Subform Assignment-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Subform Assignment-CS';
    DelayedInsert = true;
    UsageCategory = Administration;
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Class Assignment Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Student Assignment Status"; Rec."Student Assignment Status")
                {
                    ApplicationArea = All;
                }
                field("Submited Date"; Rec."Submited Date")
                {
                    ApplicationArea = All;
                }
                field("Marks Obtained"; Rec."Marks Obtained")
                {
                    ApplicationArea = All;
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }
                field("Weightage Obtained"; Rec."Weightage Obtained")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Maximum Weightage"; Rec."Maximum Weightage")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = all;
                }
                field("Date Result"; Rec."Date Result")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}


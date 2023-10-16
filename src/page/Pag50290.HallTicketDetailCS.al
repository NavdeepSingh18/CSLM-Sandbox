page 50290 "Hall Ticket Detail-CS"
{
    // version V.001-CS
    Caption = 'Hall Ticket Detail';
    CardPageID = "Stud Hall Ticket Hdr-CS";
    PageType = List;
    SourceTable = "Admit Card Header-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("No.Series"; Rec."No.Series")
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Exam Fee Total Amount"; Rec."Exam Fee Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Result Generated"; Rec."Result Generated")
                {
                    Caption = 'Hall Ticket Generated';
                    ApplicationArea = All;
                }
                field("Exam Schedule No."; Rec."Exam Schedule No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Action")
            {
                action("Hall Ticket")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    // RunObject = Report "Hall Ticket";
                }


                action("Hall Ticket With Due")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    // RunObject = Report "Hall Ticket With Due";
                }

            }
        }
    }
}
page 50282 "Student Exam Marks Detail-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    11-05-2019    OnInsertRecord                      Assign Value User ID in Marks Entered By Field and Current Work date in Marks Entered On Field
    Caption = 'Student Exam Marks Detail';
    PageType = List;
    SourceTable = "Student Exam Mark-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Exam code"; Rec."Exam code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
                field("Course code"; Rec."Course code")
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(semester; Rec.semester)
                {
                    ApplicationArea = All;
                }
                field(year; Rec.year)
                {
                    ApplicationArea = All;
                }
                field("Academic year"; Rec."Academic year")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ApplicationArea = All;
                }
                field("Suject Type"; Rec."Suject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Classification"; Rec."Subject Classification")
                {
                    ApplicationArea = All;
                }
                field("Max. Marks"; Rec."Max. Marks")
                {
                    ApplicationArea = All;
                }
                field("Marks Optained"; Rec."Marks Optained")
                {
                    ApplicationArea = All;
                }
                field("Revoluation Marks"; Rec."Revoluation Marks")
                {
                    ApplicationArea = All;
                }
                field("Revoluation Grade"; Rec."Revoluation Grade")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Marks Entered By"; Rec."Marks Entered By")
                {
                    ApplicationArea = All;
                }
                field("Marks Entered On"; Rec."Marks Entered On")
                {
                    ApplicationArea = All;
                }
                field("Grace Marks"; Rec."Grace Marks")
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

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Code added for Assign Value User ID in Marks Entered By Field and Current Work date in Marks Entered On Field::CSPL-00092::11-05-2019: Start
        Rec."Marks Entered By" := FORMAT(UserId());
        Rec."Marks Entered On" := WORKDATE();
        //Code added for Assign Value User ID in Marks Entered By Field and Current Work date in Marks Entered On Field::CSPL-00092::11-05-2019: End
    end;
}


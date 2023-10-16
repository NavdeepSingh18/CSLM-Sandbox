page 50212 "Doc.Re Test Application-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    PageType = List;
    SourceTable = "Retest Application Attach-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Document Path"; Rec."Document Path")
                {
                    ApplicationArea = All;
                }
                field("Document Name"; Rec."Document Name")
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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                }
                field("Updated Date"; Rec."Updated Date")
                {
                    ApplicationArea = All;
                }
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
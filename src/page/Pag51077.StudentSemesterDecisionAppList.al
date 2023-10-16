page 51077 StudentSemesterDecisionAppList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = StudentSemesterDecision;
    CardPageId = StudentSemesterDecisionCard;
    SourceTableView = where(Status = Filter(Approved));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Decision No."; Rec."Decision No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }

                ////////////////////////////

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = all;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = all;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = all;
                }

                field("Decision Type"; Rec."Decision Type")
                {
                    ApplicationArea = all;
                }
                field("Decision Date"; Rec."Decision Date")
                {
                    ApplicationArea = all;
                }
                field("Decision Time"; Rec."Decision Time")
                {
                    ApplicationArea = all;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                }

                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = all;
                }

                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = all;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ApplicationArea = all;
                }


                field("Previous SAP"; Rec."Previous SAP")
                {
                    ApplicationArea = all;
                }

                field("Calculated SAP"; Rec."Calculated SAP")
                {
                    ApplicationArea = all;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = all;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}
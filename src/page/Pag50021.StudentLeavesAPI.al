page 50021 StudentLeavesAPI
{
    PageType = API;
    Caption = 'StudentLeavesAPI';
    APIPublisher = 'StudentLeavesAPI';
    APIGroup = 'StudentLeavesAPI';
    EntityName = 'StudentLeavesAPI';
    EntitySetName = 'StudentLeavesAPI';
    SourceTable = "Student Leave of Absence";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(nO_; Rec."Application No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;

                }
                field(sTudentNo_; Rec."Student No.")
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;
                }
                field(insTitutecoDe; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Institute Code';
                    ApplicationArea = All;
                }
                field(reaSonDescripTion; Rec."Reason Description")
                {
                    Caption = 'Reason Description';
                    ApplicationArea = All;
                }
                field(nsLdsdaTe; Rec."NSLDS Withdrawal Date")
                {
                    Caption = 'NSLDS Date';
                    ApplicationArea = All;
                }
                field(lDa; Rec."Last Date Of Attendance")
                {
                    Caption = 'LDA Date';
                    ApplicationArea = All;
                }
                field(dOd; Rec."Date Of Determination")
                {
                    Caption = 'dOd';
                    ApplicationArea = All;
                }
                field(leAveTypes; Rec."Leave Types")
                {
                    Caption = 'Leave Types';
                    ApplicationArea = All;
                }

            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    Begin
        Rec."Application Date" := Today();
        Rec.Status := Rec.Status::Open;
    End;
}
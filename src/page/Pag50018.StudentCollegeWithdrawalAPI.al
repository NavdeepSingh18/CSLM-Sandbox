page 50018 StudentClgWithAPI
{
    PageType = API;
    Caption = 'StudentClgWithAPI';
    APIPublisher = 'StudentClgWithAPI';
    APIGroup = 'StudentClgWithAPI';
    EntityName = 'StudentClgWithAPI';
    EntitySetName = 'StudentClgWithAPI';
    SourceTable = "Withdrawal Student-CS";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(nO_; Rec."No.")
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
                field(reaSonDescripTion; Rec."Reason for Leaving")
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

            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    Begin
        Rec."Withdrawal Date" := Today();
        Rec."Withdrawal Status" := Rec."Withdrawal Status"::Open;
        Rec."Type of Withdrawal" := Rec."Type of Withdrawal"::"College-Withdrawal";
    End;
}
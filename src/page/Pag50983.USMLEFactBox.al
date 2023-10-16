page 50983 "USMLE Fact Box"
{
    PageType = CardPart;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = USMLE;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Transcript Recrd"; Rec."Transcript Recrd")
                {
                    Caption = 'Transcript Recrd';
                    ApplicationArea = All;

                }
                field("USMLE/ECFMG ID"; Rec.UsmleID)
                {
                    Caption = 'USMLE ID';
                    ApplicationArea = All;
                }
                field("USMLE Ref Code"; Rec."USMLE Ref Code")
                {
                    Caption = 'USMLE Ref Code';
                    ApplicationArea = All;
                }
                field("Certification Date"; Rec."Certification Date")
                {
                    ApplicationArea = All;
                }
                field("USMLE Consent Release Date"; Rec."USMLE Consent Release Date")
                {
                    Caption = 'USMLE Consent Release Date';
                    ApplicationArea = All;
                }
                field(AAMCID; Rec.AAMICD)
                {
                    Caption = 'AAMCID';
                    ApplicationArea = All;
                }
            }
        }
    }
    // var
    //     StudentRec: Record "Student Master-CS";

    // trigger OnAfterGetRecord()
    // var
    // begin
    //     StudentRec.Reset();
    //     StudentRec.SetRange("No.", Rec."Student ID");
    //     if StudentRec.FindFirst() then;
    // end;
}
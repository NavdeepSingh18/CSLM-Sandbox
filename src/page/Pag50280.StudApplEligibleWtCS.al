page 50280 "Stud. Appl Eligible Wt-CS"
{
    // version V.001-CS

    Caption = 'Stud. Appl Eligible Wt';
    Editable = false;
    PageType = List;
    SourceTable = "Stage Selection Details1-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Quota; Rec.Quota)
                {
                    ApplicationArea = All;
                }
                field("Eligibility Quota"; Rec."Eligibility Quota")
                {
                    ApplicationArea = All;
                }
                field("Eligibility Percertage"; Rec."Eligibility Percertage")
                {
                    ApplicationArea = All;
                }
                field("Eligibility Quota Rank"; Rec."Eligibility Quota Rank")
                {
                    ApplicationArea = All;
                }
                field("Eligibility Rank"; Rec."Eligibility Rank")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.FILTERGROUP(2);
    end;

    var

}


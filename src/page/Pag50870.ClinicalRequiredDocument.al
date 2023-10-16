page 50870 "Clinical Required Document"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Doc & Cate Attachment-CS";
    SourceTableView = where("Document Type" = filter('CLINICAL'));

    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Expiry Not Applicable"; Rec."Expiry Not Applicable")
                {
                    ApplicationArea = All;
                }
                field("Validity Days"; Rec."Validity Days")
                {
                    ApplicationArea = All;
                }
                field(Responsibility; Rec.Responsibility)
                {
                    ApplicationArea = All;
                }
                field("Titer Flag Applicable"; Rec."Titer Flag Applicable")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := 'CLINICAL';
        Rec.Responsibility := Rec.Responsibility::Student;
    end;
}
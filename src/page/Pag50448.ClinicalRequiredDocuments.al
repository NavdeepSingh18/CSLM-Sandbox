page 50448 "Clinical Required Documents"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Doc & Cate Attachment-CS";
    SourceTableView = where("Document Type" = filter('CLINICAL'), Responsibility = filter(Student | University));
    // CardPageId = "Clinical Required Document";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Rows)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
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
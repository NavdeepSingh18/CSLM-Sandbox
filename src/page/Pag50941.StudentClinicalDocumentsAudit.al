page 50941 "Audit Clinical Documents"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Document Attachment";
    SourceTableView = where("Document Category" = filter('CLINICAL'), "SLcM Document No" = filter('CLINICAL_DOCUMENTS'));
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    Caption = 'Student Clinical Documents';
    layout
    {
        area(Content)
        {
            repeater(Rows)
            {
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Document Due"; Rec."Document Due")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Validity Start Date"; Rec."Validity Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Style = Favorable;
                }
                field("Reject Reason Code"; Rec."Reject Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Update Date"; Rec."Document Update Date")
                {
                    Caption = 'Updated On';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Verified On"; Rec."Verified On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Download Document")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = DocInBrowser;
                trigger OnAction();
                var
                    CompanyInfo: Record "Company Information";
                    StudentMaster: Record "Student Master-CS";
                    StudentNo: Code[20];
                    PostUrl: Text;
                begin
                    CompanyInfo.Reset();
                    if CompanyInfo.Get() then;

                    if Rec."Transaction No." <> '' then begin
                        CompanyInfo.TestField("SchoolDocs Download Url");
                        PostUrl := CompanyInfo."SchoolDocs Download Url";
                        PostUrl := PostUrl + Rec."Transaction No.";
                        Hyperlink(PostUrl);
                    end
                    else begin
                        StudentMaster.Reset();
                        if StudentMaster.Get(Rec."Student No.") then;

                        if StudentMaster."Creation Date" < 20210410D then begin
                            if StudentMaster."Original Student No." <> '' then
                                StudentNo := StudentMaster."Original Student No."
                            else
                                StudentNo := StudentMaster."No.";
                        end
                        else
                            StudentNo := StudentMaster."No.";

                        CompanyInfo.TestField("SchoolDocs Documents Open Url");
                        PostUrl := CompanyInfo."SchoolDocs Documents Open Url";
                        PostUrl := PostUrl + StudentNo;

                        Hyperlink(PostUrl);
                    end;
                end;
            }
        }
    }
}
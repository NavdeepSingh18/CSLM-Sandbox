page 50992 "Student Attachment Line"
{
    PageType = ListPart;
    SourceTable = "Student Document Attachment";
    SourceTableView = where("SLcM Document No" = filter(<> 'CLINICAL_DOCUMENTS'), "Transaction No." = filter(<> ''));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater("Student Attcahment Line")
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Uploaded By"; Rec."Uploaded By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Uploaded On"; Rec."Uploaded On")
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
            action("Download Attachment")
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
                    TransactionNo: Code[50];
                    PostUrl: Text;
                begin
                    CompanyInfo.Reset();
                    if CompanyInfo.Get() then;

                    TransactionNo := Rec."Transaction No.";

                    if TransactionNo <> '' then begin
                        CompanyInfo.TestField("SchoolDocs Download Url");
                        PostUrl := CompanyInfo."SchoolDocs Download Url";
                        PostUrl := PostUrl + TransactionNo;
                        Hyperlink(PostUrl);
                    end
                    else begin
                        StudentNo := Rec."Student No.";
                        StudentMaster.Reset();
                        if StudentMaster.Get(StudentNo) then;

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
            action("Delete Line")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = Delete;
                trigger OnAction();
                begin
                    IF Confirm('Do you want to Delete Attachment Line?') then
                        Rec.Delete(true);
                end;
            }
        }
    }
    var
        StudentNo: Code[20];
}
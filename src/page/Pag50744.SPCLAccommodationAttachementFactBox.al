page 50744 "SPCL Accommodation Attachment"
{
    PageType = ListPart;
    SourceTable = "Student Document Attachment";
    Caption = 'Special Accommodation Attachments';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater("Special Accommodation Attachments")
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document Sub Category"; Rec."Document Sub Category")
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
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
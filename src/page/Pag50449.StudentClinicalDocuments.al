page 50449 "Validate Clinical Documents"
{
    Caption = 'Validate Clinical Documents';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Document Attachment";
    SourceTableView = sorting("Entry No.") order(descending) where("Document Category" = filter('CLINICAL'), "SLcM Document No" = filter('CLINICAL_DOCUMENTS'),
    "Document Status" = filter("Portal Submitted" | Submitted | DRNYC | DROC | RESUBMIT | SENT | UREVIEW | "Under Review" | "Pending for Verification"));
    // CardPageId = "Clinical Document Approval";
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    layout
    {
        area(Content)
        {
            group("Student Details")
            {
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Caption = 'Student Name';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
            }
            repeater(Rows)
            {
                field("Document Description"; Rec."Document Description")
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
                    Editable = true;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Caption = 'Expiry Date';
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    Caption = 'Transaction No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Update Date"; Rec."Document Update Date")
                {
                    Caption = 'Updated On';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
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

            action("All Documents Verified")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+F5';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ApprovalSetup;
                Visible = false;
                trigger OnAction();
                var
                    StudentDocumentAttachment: Record "Student Document Attachment";
                    SelectedRecords: Integer;
                begin
                    SelectedRecords := 0;
                    CurrPage.SetSelectionFilter(StudentDocumentAttachment);
                    SelectedRecords := StudentDocumentAttachment.Count;

                    if Confirm('You have selected %1 Records, You want to varify the documents?', false, SelectedRecords) then begin
                        if StudentDocumentAttachment.Find('-') then
                            repeat
                                StudentDocumentAttachment.Validate("Document Status", StudentDocumentAttachment."Document Status"::"On File");
                                StudentDocumentAttachment.Modify();
                            until StudentDocumentAttachment.Next() = 0;
                        Message('%1 records updated successfully', SelectedRecords);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec."Transaction No." <> '' then
            Error('You have uploaded Document for (%1).', Rec."Document Description");
    end;


    procedure CheckValidStudentForDocumentation(StudentMasterCS: Record "Student Master-CS") StudentValidity: Boolean;
    begin
        StudentValidity := false;
        /*
        Code
        */
        StudentValidity := true;
        exit(StudentValidity);
    end;
}
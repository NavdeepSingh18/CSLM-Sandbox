page 50869 "Clinical Document Approval"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Student Document Attachment";
    Caption = 'Clinical Document Approval';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
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
                field(Semester; Rec.Semester)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Caption = 'Academic Year';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Document Specialist ID"; Rec."Document Specialist ID")
                {
                    Caption = 'Document Specialist ID';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                group("Document Detail")
                {
                    field("Document Description"; Rec."Document Description")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        MultiLine = true;
                        Style = Strong;
                    }
                    field("Submission Date"; Rec."Submission Date")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Document Due"; Rec."Document Due")
                    {
                        ApplicationArea = All;
                        Editable = true;
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
                        trigger OnValidate()
                        begin
                            Rec."Validity Expiry Date" := Rec."Expiry Date";
                        end;
                    }
                    field("Reject Reason Code"; Rec."Reject Reason Code")
                    {
                        ApplicationArea = All;
                        Editable = true;
                        Caption = 'Reject Reason Code';
                    }
                    field("Reject Reason"; Rec."Reject Reason")
                    {
                        ApplicationArea = All;
                        Editable = true;
                        Caption = 'Reject Reason Description';
                    }
                    field("Transaction No."; Rec."Transaction No.")
                    {
                        Caption = 'Transaction No.';
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

            action("Accept")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+F9';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction();
                var
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if Confirm('Do you want to accept the selected Document?', true) then begin
                        Rec.TestField("Transaction No.");

                        Rec."Document Status" := Rec."Document Status"::"On File";
                        Rec."Status Updated By" := UserId;
                        Rec."Status Updated Date" := Today;
                        Rec."Verified By" := UserId;
                        Rec."Verified On" := Today;
                        Rec."Document Status Completed" := false;
                        Rec.Modify();
                        CALE.DocumentationInsertLogEntry(10, 23, Rec."Student No.", Rec."Student Name", Rec."Document Sub Category", '', '', '', '', Rec."Document Status");
                        // ClinicalNotification.AcceptedClinicalDocument(Rec);//GMCSCOM
                        Message('Selected document has been accepted.');
                        CurrPage.Close();
                    end;
                end;
            }
            action("Reject")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+J';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    Rec.TestField("Reject Reason Code");
                    Rec.TestField("Reject Reason");
                    if Confirm('Do you want to reject the selected Document?', true) then begin
                        Rec."Document Status" := Rec."Document Status"::Rejected;
                        Rec."Status Updated By" := UserId;
                        Rec."Status Updated Date" := Today;
                        Rec."Verified By" := UserId;
                        Rec."Verified On" := Today;
                        Rec."Document Status Completed" := false;
                        Rec.Modify();
                        // ClinicalNotification.SendDocRejectMail(Rec);
                        CALE.DocumentationInsertLogEntry(10, 23, Rec."Student No.", Rec."Student Name", Rec."Document Sub Category", '', '', '', '', Rec."Document Status");
                        Message('Selected document has been Rejected.');
                        CurrPage.Close();
                    end;
                end;
            }
            action("Under Review")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = RemoveLine;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if Confirm('Do you want to change the selected Document status to Under Review?', true) then begin
                        Rec."Document Status" := Rec."Document Status"::"Under Review";
                        Rec."Status Updated By" := UserId;
                        Rec."Status Updated Date" := Today;
                        Rec."Verified By" := UserId;
                        Rec."Verified On" := Today;
                        Rec."Document Status Completed" := false;
                        Rec.Modify();
                        // ClinicalNotification.SendDocUnderReviewMail(Rec);
                        CALE.DocumentationInsertLogEntry(10, 23, Rec."Student No.", Rec."Student Name", Rec."Document Sub Category", '', '', '', '', Rec."Document Status");
                        Message('Selected document Status changed to Under Review.');
                        CurrPage.Close();
                    end;
                end;
            }
            action("Pending for Verification")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Absence;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if Confirm('Do you want to change the selected Document status to Pending for Verification?', true) then begin
                        Rec."Document Status" := Rec."Document Status"::"Pending for Verification";
                        Rec."Status Updated By" := UserId;
                        Rec."Status Updated Date" := Today;
                        Rec."Verified By" := UserId;
                        Rec."Verified On" := Today;
                        Rec."Document Status Completed" := false;
                        Rec.Modify();
                        // ClinicalNotification.SendDocPendingForVarificationMail(Rec);
                        CALE.DocumentationInsertLogEntry(10, 23, Rec."Student No.", Rec."Student Name", Rec."Document Sub Category", '', '', '', '', Rec."Document Status");
                        Message('Selected document Status changed to Pending for Verification.');
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
}
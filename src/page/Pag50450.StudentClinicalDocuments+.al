page 50450 "Student Clinical Documents+"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Document Attachment";
    SourceTableView = sorting("Student No.") order(descending) where("Document Category" = filter('CLINICAL'), "SLcM Document No" = filter('CLINICAL_DOCUMENTS'));
    InsertAllowed = false;
    //DeleteAllowed = false;
    Editable = true;
    Caption = 'Verified Student Clinical Documents';
    layout
    {
        area(Content)
        {
            repeater(Rows)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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
                    Editable = true;
                }
                field("Reject Reason Code"; Rec."Reject Reason Code")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Code';
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Description';
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Editable = true;
                    //OptionCaption = '" ",,,Rejected,Requested-Required,,Submitted,,Expired';
                    //OptionCaption = ',,,Rejected,Requested-Required,Portal Submitted,Submitted,On File,Expired,Under Review';
                    OptionCaption = ' ,,,Rejected,Requested-Required,Portal Submitted,Submitted,On File,Expired,Under Review,,,,,No Longer Needed,Not Requested,,,Required,Requested - Not Required,Resubmitted,,Revisions Required - Please Call Advisor,Sent,Under Review,When Needed';
                    Style = Favorable;
                    trigger OnValidate()
                    var
                        CALE: Record "Clerkship Activity Log Entries";
                        ClinicalNotification: Codeunit "Clinical Notification";
                    begin
                        if Rec."Document Status" = Rec."Document Status"::Rejected then begin
                            if Rec."Reject Reason Code" = '' then
                                Error('You must specify Reason Code');
                            if Rec."Reject Reason" = '' then
                                Error('You must specify Reason Description');
                        end;
                        if Rec."Document Status" = Rec."Document Status"::" " then
                            Error('Document Status must not be blank.');

                        if Rec."Document Status" = Rec."Document Status"::Rejected then begin
                            // ClinicalNotification.SendDocRejectMail(Rec);
                            Message('Selected document has been Rejected.');
                        end;

                        CALE.DocumentationInsertLogEntry(10, 23, Rec."Student No.", Rec."Student Name", Rec."Document Sub Category", '', '', '', '', Rec."Document Status");
                    end;
                }
                field("Validity Start Date"; Rec."Validity Start Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                    trigger OnValidate()
                    var
                        CALE: Record "Clerkship Activity Log Entries";
                        ReasonDescription: Text[100];
                    begin
                        ReasonDescription := 'Old Value: ' + Format(xRec."Expiry Date") + ' New Value: ' + format(Rec."Expiry Date");
                        Rec."Validity Expiry Date" := Rec."Expiry Date";
                        CALE.InsertLogEntry(10, 24, Rec."Student No.", Rec."Student Name", Rec."Document Sub Category", '', ReasonDescription, '', '');
                    end;
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
                    SDA: Record "Student Document Attachment";
                    StudentNo: Code[20];
                    PostUrl: Text;
                    TransactionNo: Code[50];
                begin
                    CompanyInfo.Reset();
                    if CompanyInfo.Get() then;

                    TransactionNo := Rec."Transaction No.";

                    if Rec."Transaction No." = '' then begin
                        SDA.Reset();
                        SDA.SetRange("Student No.", Rec."Student No.");
                        SDA.SetRange("Document Category", Rec."Document Category");
                        SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                        SDA.SetRange("Document Sub Category", Rec."Document Sub Category");
                        SDA.SetFilter("Transaction No.", '<>%1', '');
                        IF SDA.FindLast() then
                            TransactionNo := SDA."Transaction No.";
                    end;

                    if TransactionNo <> '' then begin
                        CompanyInfo.TestField("SchoolDocs Download Url");
                        PostUrl := CompanyInfo."SchoolDocs Download Url";
                        PostUrl := PostUrl + TransactionNo;
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

    trigger OnModifyRecord(): Boolean
    begin
        Rec."Document Update Date" := Today;
        Rec."Status Updated Date" := Today;
        Rec."Status Updated By" := UserId;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Message('You must delete the document from SchoolDocs also.');
    end;
}
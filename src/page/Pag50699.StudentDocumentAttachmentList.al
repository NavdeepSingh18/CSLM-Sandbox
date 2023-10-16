page 50699 "Student Document Attachment"
{
    ApplicationArea = All;
    Caption = 'Student Document Attachment List';
    PageType = List;
    SourceTable = "Student Document Attachment";
    UsageCategory = Lists;
    Editable = False;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Document Category"; Rec."Document Category")
                {
                    ApplicationArea = All;
                }
                field("Document Sub Category"; Rec."Document Sub Category")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DocCategoryAttachment: Record "Doc & Cate Attachment-CS";
                    begin
                        DocCategoryAttachment.Reset();
                        DocCategoryAttachment.SetRange("Document Type", Rec."Document Category");
                        DocCategoryAttachment.SetRange(Blocked, false);
                        IF DocumentNoNotReq = true then
                            DocCategoryAttachment.SetRange("Document No. Required", false);
                        DocCategoryAttachment.findset();
                        IF PAGE.RUNMODAL(0, DocCategoryAttachment) = ACTION::LookupOK THEN begin
                            Rec."Document Sub Category" := DocCategoryAttachment.Code;
                            Rec.Description := DocCategoryAttachment.Description;
                        end;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("SLcM Document No"; Rec."SLcM Document No")
                {
                    ApplicationArea = All;
                }
                field("Document Due"; Rec."Document Due")
                {
                    ApplicationArea = All;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                }
                field("Document Update Date"; Rec."Document Update Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                }
                field("Status Updated By"; Rec."Status Updated By")
                {
                    ApplicationArea = All;
                }
                field("Status Updated Date"; Rec."Status Updated Date")
                {
                    ApplicationArea = All;
                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ApplicationArea = All;
                }
                field("Uploaded On"; Rec."Uploaded On")
                {
                    ApplicationArea = All;
                }
                field("Uploaded Time"; Rec."Uploaded Time")
                {
                    ApplicationArea = All;
                }
                field("Uploaded Source"; Rec."Uploaded Source")
                {
                    ApplicationArea = All;
                }

                field("Due Date Days"; Rec."Due Date Days")
                {
                    ApplicationArea = All;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
                field("Doc Schedule ID"; Rec."Doc Schedule ID")
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                }
                field("Doc Status ID"; Rec."Doc Status ID")
                {
                    ApplicationArea = All;
                }
                field(Due; Rec.Due)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Doc Type ID"; Rec."Doc Type ID")
                {
                    ApplicationArea = All;
                }
                field("Date Required"; Rec."Date Required")
                {
                    ApplicationArea = All;
                }
                field("Date recv"; Rec."Date recv")
                {
                    ApplicationArea = All;
                }

                field(ImageNow_Doc_ID0; Rec.ImageNow_Doc_ID0)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
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
            action("Document Upload")
            {
                ApplicationArea = All;
                Caption = 'Document Upload';
                Image = DocInBrowser;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField("Student No.");
                    Rec.TestField("Document Category");
                    Rec.TestField("Document Sub Category");
                    // If (Rec."Transaction No." = '') OR (Rec."Document ID" = '') then
                    //     ImportAttachment(Rec."Student No.", Rec."Document Sub Category", Rec."Document Category", Rec."SLcM Document No", Rec."Subject Code", Rec."Entry No.");
                End;
            }
            action("Upload1")
            {
                ApplicationArea = All;
                Caption = 'Upload Document Attachment';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"Student Document Attah", false, true, Rec);

                end;
            }
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



                        if StudentMaster."Creation Date" < 20210301D then begin

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
    procedure VariablePassing(StudentNo1: Code[20]; DocNoNotRequried: Boolean);
    begin
        StudentNo := StudentNo1;
        DocumentNoNotReq := DocNoNotRequried;
    end;

    var
        StudentNo: Code[20];
        DocumentNoNotReq: Boolean;

    trigger OnOpenPage()
    begin
        IF StudentNo <> '' then
            Rec.SetRange("Student No.", StudentNo);
    end;
}

page 51022 "Site Visit Doc Attachment"
{
    ApplicationArea = All;
    Caption = 'Site Visit Document Attachment List';
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
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                    Editable = false;
                    Visible = Not (Rec."Document Sub Category" = 'USERTASK');
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
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
                    Visible = false;
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
                    Visible = false;
                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ApplicationArea = All;

                }
                field("Uploaded On"; Rec."Uploaded On")
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
            action("Download Document SchoolDocs")

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
            // action("Download Document Verity")
            // {

            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = TRUE;
            //     Image = DocInBrowser;
            //     trigger OnAction()
            //     var
            //         VerityIntegration: Codeunit "Verity Integration";
            //     Begin
            //         Clear(VerityIntegration);
            //         VerityIntegration.DocumentDownloadVerity(Rec."Transaction No.", Rec."Student No.");
            //     End;
            // }
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

        ChangeCaption: Boolean;
        UserTaskCaption: Boolean;

    trigger OnOpenPage()
    begin
        IF StudentNo <> '' then
            Rec.SetRange(Rec."Student No.", StudentNo);

        IF ChangeCaption = true then
            CurrPage.Caption := 'DOCUMENT ATTACHMENT LIST';

        If UserTaskCaption then
            CurrPage.Caption := 'User Task Attachment List';
    end;

    procedure InitPrameter(Change: Boolean);
    var
    // myInt: Integer;
    begin
        ChangeCaption := Change;
    end;

    procedure UserTaskCaptionPermission(UserTaskCap: Boolean);
    var
    // myInt: Integer;
    begin
        UserTaskCaption := UserTaskCap;
    end;
}

page 50376 "Select Faculty-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Faculty Choice";
    SourceTableView = where("Site Visit Entry" = filter(true));
    Caption = 'Site Visit Document Attachment';

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
                        // IF DocumentNoNotReq = true then
                        //     DocCategoryAttachment.SetRange("Document No. Required", false);
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

                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }

                field("Faculty Code"; Rec."Faculty Code")
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


                field("File Name"; Rec."File Name")
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

                    // CompanyInfo.Reset();

                    // if CompanyInfo.Get() then;



                    // if "Transaction No." <> '' then begin

                    //     CompanyInfo.TestField("SchoolDocs Download Url");

                    //     PostUrl := CompanyInfo."SchoolDocs Download Url";

                    //     PostUrl := PostUrl + "Transaction No.";

                    //     Hyperlink(PostUrl);

                    // end

                    // else begin

                    //     StudentMaster.Reset();

                    //     if StudentMaster.Get("Student No.") then;



                    //     if StudentMaster."Creation Date" < 20210301D then begin

                    //         if StudentMaster."Original Student No." <> '' then
                    //             StudentNo := StudentMaster."Original Student No."

                    //         else
                    //             StudentNo := StudentMaster."No.";

                    //     end

                    //     else
                    //         StudentNo := StudentMaster."No.";



                    //     CompanyInfo.TestField("SchoolDocs Documents Open Url");

                    //     PostUrl := CompanyInfo."SchoolDocs Documents Open Url";

                    //     PostUrl := PostUrl + StudentNo;



                    //     Hyperlink(PostUrl);

                    // end;

                end;

            }
        }
    }
}
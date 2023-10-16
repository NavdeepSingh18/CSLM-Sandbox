page 50566 APIStudentDocumentAttachment
{
    PageType = List;
    SourceTable = "Student Document Attachment";
    // EntityName = 'Studentdocumentattachment';
    // EntitySetName = 'Studentdocumentattachment';
    DelayedInsert = true;
    Caption = 'API StudentDocumentAttachment';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(studentnO; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'StudentNo';
                }
                field(documentcategorY; Rec."Document Category")
                {
                    ApplicationArea = All;
                    Caption = 'DocumentCategory';
                }
                field(documentsubcategorY; Rec."Document Sub Category")
                {
                    ApplicationArea = All;
                    Caption = 'DocumentSubCategory';
                }
                field(descriptioN; Rec.Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                }
                field(documentiD; Rec."Document ID")
                {
                    ApplicationArea = All;
                    Caption = 'DocumentID';
                }
                field(transactionnO; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    Caption = 'TransactionNo';
                }
                field(subjectcodE; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    Caption = 'StudentCode';
                }
                field(slcmdocumentnO; Rec."SLcM Document No")
                {
                    ApplicationArea = All;
                    Caption = 'SLCMDocumentNo';
                }
                field(documentduE; Rec."Document Due")
                {
                    ApplicationArea = All;
                    Caption = 'DocumentDue';
                }
                field(documentstatuS; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Caption = 'DocumentStatus';
                }

                field(filenamE; Rec."File Name")
                {
                    ApplicationArea = All;
                    Caption = 'FileName';
                }
                field(filetypE; Rec."File Type")
                {
                    ApplicationArea = All;
                    Caption = 'FileType';
                }
                field(expirydatE; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    Caption = 'ExpiryDate';
                }

            }
        }
    }
    var
        StudetnDocAttach: Record "Student Document Attachment";

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        StudetnDocAttach.Reset();
        StudetnDocAttach.SetCurrentKey("Entry No.");
        if StudetnDocAttach.FindLast() then
            Rec."Entry No." := StudetnDocAttach."Entry No." + 1
        else
            Rec."Entry No." := 1;
    end;

}

table 50406 "Digital Signature Details"
{
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Document ID"; Code[30])
        {
            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                StudentDocumentAttachment: Record "Student Document Attachment";
            begin
                StudentDocumentAttachment.Reset();
                IF StudentDocumentAttachment.FINDSET() THEN
                    IF PAGE.RUNMODAL(0, StudentDocumentAttachment) = ACTION::LookupOK THEN BEGIN
                        "Document ID" := StudentDocumentAttachment."Document ID";
                    end;
            end;

        }
        field(3; "Document Category"; Code[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "File Attachment-CS";
        }
        field(4; "Document Sub Category"; Code[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "Doc & Cate Attachment-CS" where("Document Type" = field("Document Category"));
        }
        field(5; "Hello Sign ID"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Signatory/User ID"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Signature Request Sent Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Signature Status"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Signed Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Verified Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Digital Signature Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Signature Request Sent Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Signed Time"; Time)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;
}
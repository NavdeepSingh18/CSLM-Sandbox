table 50257 "File Attachment-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   07/01/2019       OnInsert()                                Code Add for any record change then Assign Value in Updated Field

    Caption = 'File Attachment';
    LookupPageID = "Doc. Attachment-CS";

    fields
    {
        field(1; "Code"; Code[250])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[500])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "User Group"; Code[20])
        {
            Caption = 'User Group';
            DataClassification = CustomerContent;
            TableRelation = "User Group-CS";

        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(7; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
        }
        field(8; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(9; "Document No. Required"; Boolean)
        {
            Caption = 'Document No. Required';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                DocCateAttachment: Record "Doc & Cate Attachment-CS";
            begin
                DocCateAttachment.Reset();
                DocCateAttachment.SetRange("Document Type", "Code");
                If DocCateAttachment.FindSet() then
                    DocCateAttachment.ModifyAll("Document No. Required", "Document No. Required");
            end;
        }
        field(10; "Type Category No. SchoolDocs"; Integer)
        {
            Caption = 'Type Category No. SchoolDocs';
            DataClassification = CustomerContent;
            InitValue = 0;
        }
        field(11; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(12; "Check Duplicate Entries"; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code Add for any record change then Assign Value in Updated Field::CSPL-00114::07012019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code Add for any record change then Assign Value in Updated Field::CSPL-00114::07012019: End
    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;
}


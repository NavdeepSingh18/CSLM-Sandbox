tableextension 50555 "tableextensionDimValue" extends "Dimension Value"
{
    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019                          Added New Fields.
    fields
    {
        field(50000; "Parent Dimension"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = IF ("Global Dimension No." = FILTER(2)) "Dimension Value".Code WHERE("Global Dimension No." = CONST(1))
            ELSE
            IF ("Global Dimension No." = FILTER(3)) "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Email Address"; Text[30])
        {
            Description = 'CS Field Added 02-05-2019';
            ExtendedDatatype = EMail;
            Caption = 'Email Address';
            DataClassification = CustomerContent;
        }
        field(50003; Updated; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50004; Image; BLOB)
        {
            Description = 'CS Field Added 02-05-2019';
            SubType = Bitmap;
            Caption = 'Image';
            DataClassification = CustomerContent;
        }
        field(50005; "Mobile Insert"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(50006; "Mobile Update"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
        }
        field(50007; "Core Clinical Roster Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            trigger OnValidate()
            begin
                TestField("Global Dimension No.", 1);
            end;
        }
        field(50008; "Elective Clinical Roster Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            trigger OnValidate()
            begin
                TestField("Global Dimension No.", 1);
            end;
        }
        field(50009; "FM1_IM1 Clerkship Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            trigger OnValidate()
            begin
                TestField("Global Dimension No.", 1);
            end;
        }
        field(50010; "Requisition Approver Level 1"; Text[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            ValidateTableRelation = false;

        }
        field(50011; "Requisition Approver Level 2"; Text[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            ValidateTableRelation = false;

        }
        field(50012; "Requisition Approver Level 3"; Text[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            ValidateTableRelation = false;
        }

        field(50013; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    trigger OnInsert()
    begin
        "Mobile Insert" := TRUE;
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;
        Inserted := true;
    end;

    trigger OnModify()
    begin
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

    end;
}


table 50346 "CLN Required Document Buffer"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Type"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Document Code"; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(3; "User ID"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
        }
        field(5; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(8; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(9; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
            Editable = false;
        }
        field(10; "Document Specialist ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Specialist ID';
            TableRelation = "Semester Master-CS".Code;
            Editable = false;
        }
        field(11; "Sorting No."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(12; "Document Due On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Responsibility"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Student,University;
        }
    }

    keys
    {
        key(PK; Type, "Document Code", "User ID", "Student No.")
        {
            Clustered = true;
        }
        key(Sorting_1; "User ID", "Student No.")
        {
            Clustered = false;
        }
    }

    procedure UpdateRecords(StudentMaster: Record "Student Master-CS"; DueUptoDate: Date)
    var
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        ClinicalRequiredDocuments: Record "Doc & Cate Attachment-CS";
        StudentDocumentAttachment: Record "Student Document Attachment";
        CLNBuffer: Record "CLN Required Document Buffer";
        DueDate: Date;
    begin
        DueDate := 0D;
        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
        ClerkshipSiteAndDateSelection.SetRange("Student No.", StudentMaster."No.");
        if ClerkshipSiteAndDateSelection.FindLast() then
            DueDate := ClerkshipSiteAndDateSelection."Document Due Date";

        if DueDate > DueUptoDate then
            exit;

        if DueDate = 0D then
            exit;

        ClinicalRequiredDocuments.Reset();
        ClinicalRequiredDocuments.SetRange("Document Type", 'CLINICAL');
        ClinicalRequiredDocuments.SetRange(Blocked, false);
        IF ClinicalRequiredDocuments.FindSet() then
            repeat
                StudentDocumentAttachment.Reset();
                StudentDocumentAttachment.SetCurrentKey("Student No.");
                StudentDocumentAttachment.SetRange("Student No.", StudentMaster."No.");
                StudentDocumentAttachment.SetRange("Document Category", ClinicalRequiredDocuments."Document Type");
                StudentDocumentAttachment.SetRange("Document Sub Category", ClinicalRequiredDocuments.Code);
                StudentDocumentAttachment.SetFilter("Document Status", '%1|%2', StudentDocumentAttachment."Document Status"::"Portal Submitted", StudentDocumentAttachment."Document Status"::"On File");
                if not StudentDocumentAttachment.FindFirst() then begin
                    CLNBuffer.Init();
                    CLNBuffer.Type := ClinicalRequiredDocuments."Document Type";
                    CLNBuffer."Document Code" := ClinicalRequiredDocuments.Code;
                    CLNBuffer."User ID" := UserID;
                    CLNBuffer."Student No." := StudentMaster."No.";
                    CLNBuffer."Student Name" := StudentMaster."Student Name";
                    CLNBuffer."Academic Year" := StudentMaster."Academic Year";
                    CLNBuffer."Enrollment No." := StudentMaster."Enrollment No.";
                    CLNBuffer.Semester := StudentMaster.Semester;
                    CLNBuffer."Document Specialist ID" := StudentMaster."Document Specialist";
                    CLNBuffer.Description := ClinicalRequiredDocuments.Description;
                    CLNBuffer."Document Due On" := DueDate;
                    CLNBuffer."Sorting No." := ClinicalRequiredDocuments."Sorting No.";
                    CLNBuffer.Responsibility := ClinicalRequiredDocuments.Responsibility;
                    CLNBuffer.Insert();
                end;
            until ClinicalRequiredDocuments.Next() = 0;
    end;

    procedure DeleteRecords()
    var
        CLNBuffer: Record "CLN Required Document Buffer";
    begin
        CLNBuffer.Reset();
        CLNBuffer.SetRange("User ID", UserId);
        if CLNBuffer.FindFirst() then
            repeat
                CLNBuffer.Delete();
            until CLNBuffer.Next() = 0;
    end;
}
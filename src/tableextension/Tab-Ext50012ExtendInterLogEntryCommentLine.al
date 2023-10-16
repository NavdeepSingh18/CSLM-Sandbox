tableextension 50012 ExtendsInterLogEntryCommentLN extends "Inter. Log Entry Comment Line"
{
    fields
    {
        field(50000; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source No.';
        }
        field(50010; Notes; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Notes';

            trigger OnValidate()
            begin
                TestField("Global Dimension 2 Code");
            end;
        }
        field(50011; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(50012; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(50013; "Interaction Template Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Interaction Template Code';
            TableRelation = "Interaction Template".Code;

            trigger OnValidate()
            Var
                InteractionTemplate: Record "Interaction Template";
            begin
                InteractionTemplate.Reset();
                if InteractionTemplate.Get("Interaction Template Code") then
                    "Template Type" := InteractionTemplate.Type;
            end;
        }
        field(50014; "Interaction Group Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Interaction Group Code';
            TableRelation = "Interaction Group".Code;

            trigger OnValidate()
            Var
                InteractionGroup: Record "Interaction Group";
            begin
                InteractionGroup.Reset();
                if InteractionGroup.Get("Interaction Group Code") then
                    "Group Type" := InteractionGroup.Type;
            end;
        }
        field(50015; "Template Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Template Type';
            OptionMembers = " ",Residency,"Clinical Clerkship",Student,Other;
        }
        field(50016; "Group Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Group Type';
            OptionMembers = " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
        }
        field(50017; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50018; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                DimValue: Record "Dimension Value";
            begin
                "Department Name" := '';
                if DimValue.Get('DEPARTMENT', "Global Dimension 2 Code") then
                    "Department Name" := DimValue.Name;
            end;
        }
        field(50019; "Department Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50020; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            var
                StudentMasterCS: Record "Student Master-CS";
            begin
                "Student Name" := '';
                "Enrollment No." := '';
                "Global Dimension 1 Code" := '';
                StudentMasterCS.Reset();
                if StudentMasterCS.Get("Student No.") then begin
                    "Student Name" := StudentMasterCS."Student Name";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                end;
            end;
        }
        field(50021; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(50022; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(50050; "Status"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            TableRelation = "Interaction Status".Code;
            trigger OnValidate()
            var
                InteractionStatus: Record "Interaction Status";
            begin
                "Status Description" := '';
                InteractionStatus.Reset();
                ;
                if InteractionStatus.Get(Status) then
                    "Status Description" := InteractionStatus.Description;
            end;
        }
        field(50051; "Status Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Status Description';
        }
    }

    trigger OnAfterInsert()
    begin
        "Created By" := UserId;
        "Created On" := Today;
        Date := Today;
    end;
}
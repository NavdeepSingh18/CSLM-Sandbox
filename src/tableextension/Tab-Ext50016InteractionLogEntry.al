tableextension 50016 ExtendsInteractionLogEntry extends "Interaction Log Entry"
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
            var
                StudentTimelineRec: Record "Student Time Line";
            begin
                // If Notes <> '' then
                //     If Rec.Notes <> xRec.Notes then
                //         StudentTimelineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", CopyStr(Rec.Notes, 1, 100), UserID(), Today());
            end;
        }
        field(50011; "Interaction Subject"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }

        field(50015; "Template Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Template Type';
            OptionMembers = " ",Residency,"Clinical Clerkship",Student,Other,Housing;
        }
        field(50016; "Group Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Group Type';
            OptionMembers = " ","Residency Note","Residency Employment Note","Clinical Clerkship",Student,Other,Housing,Room,"Housing Ledger";
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
        field(50021; "Parent Student No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50022; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(50023; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(50024; "Original Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Original Student No.';
            Editable = false;
        }
        field(50025; Correction; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50050; "Interaction Status code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            TableRelation = "Interaction Status".Code;
            trigger OnValidate()
            var
                InteractionStatus: Record "Interaction Status";
                StudentTimelineRec: Record "Student Time Line";
            begin
                "Interaction Status Description" := '';
                InteractionStatus.Reset();
                if InteractionStatus.Get("Interaction Status code") then begin
                    "Interaction Status Description" := InteractionStatus.Description;
                    IF Rec."Interaction Status code" <> xRec."Interaction Status code" then
                        StudentTimelineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'Notes ' + Format(Rec."Entry No.") + ' Status has been changed ' + xRec."Interaction Status code" + ' to ' + Rec."Interaction Status code", UserId(), Today());


                end;
            end;
        }
        field(50051; "Interaction Status Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }

        field(50052; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(50053; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(50054; "Department"; Option)
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bursar Department,Financial Aid Department,Residential Services,Immigration Department,Registrar Department,Admissions,Clinical Details,EED Pre-Clinical,EED Clinical,Graduate Affairs,Examination,Graduation';
            OptionMembers = " ","Bursar Department","Financial Aid Department","Residential Services","Immigration Department","Registrar Department","Admissions","Clinical Details","EED Pre-Clinical","EED Clinical","Graduate Affairs","Examination","Graduation";
        }
        field(50055; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
        }
        field(50056; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
        }
        field(50502; "Interaction Result"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Interaction Result".Code;
            trigger OnValidate()
            var
                InteractionResult: Record "Interaction Result";
            begin
                "Interaction Result Description" := '';
                InteractionResult.Reset();
                if InteractionResult.Get("Interaction Result") then
                    "Interaction Result Description" := InteractionResult.Description;
            end;
        }
        field(50503; "Interaction Result Description"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50504; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50505; "End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50506; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50507; "Priority"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50508; "Status Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50509; "Setup By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50510; "Completed By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50511; "Student Notes"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Student Notes';
        }
        Field(50512; "User Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(60000; "Interaction Template Desc"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Interaction Template".Description where(Code = field("Interaction Template Code")));
            Caption = 'Interaction Template Description';
            Editable = false;
        }
        field(60001; "Attachment Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Student Document Attachment" where("Note Entry No" = field("Entry No."), "Document Category" = filter('NOTES'), "Document Sub Category" = filter('STUNDENTNOTES')));
            Caption = '"Attachment Exists';
            Editable = false;
        }
        field(60002; "Student No. Filter"; Code[20])
        {
            Caption = 'Student No. Filter';
            FieldClass = FlowFilter;
            Editable = false;
        }

        modify("Interaction Template Code")
        {
            TableRelation = if ("Student Notes" = filter(true)) "Interaction Template".Code where(Type = filter(Student | Other))
            else
            if ("Student Notes" = filter(false)) "Interaction Template".Code;

            trigger OnAfterValidate()
            Var
                InteractionTemplate: Record "Interaction Template";
                StudentTimelineRec: Record "Student Time Line";
            begin
                InteractionTemplate.Reset();
                if InteractionTemplate.Get("Interaction Template Code") then
                    "Template Type" := InteractionTemplate.Type;

                //CSPL-00307--13-10-21
                Rec.CalcFields("Interaction Template Desc");
                If "Interaction Template Code" <> '' then
                    If Rec."Interaction Template Code" <> xRec."Interaction Template Code" then
                        StudentTimelineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Rec."Interaction Template Desc", UserID(), Today());
                //CSPL00307 ---13-10-21
            end;
        }
        modify("Interaction Group Code")
        {
            TableRelation = if ("Student Notes" = filter(true)) "Interaction Group".Code where(Type = filter(Student | Other))
            else
            if ("Student Notes" = filter(false)) "Interaction Group".Code;

            trigger OnAfterValidate()
            Var
                InteractionGroup: Record "Interaction Group";
            begin
                InteractionGroup.Reset();
                if InteractionGroup.Get("Interaction Group Code") then
                    "Group Type" := InteractionGroup.Type;
            end;
        }
    }

    trigger OnAfterInsert()
    Var
        Users_lRec: Record User;
    begin
        "Created By" := UserId;
        "Created On" := Today;
        Date := Today;
        "Time of Interaction" := Time;
        Users_lRec.Reset();
        Users_lRec.SetRange("User Name", UserId());
        IF Users_lRec.FindFirst() then
            "User Name" := Users_lRec."Full Name";
    end;

    trigger OnAfterModify()
    begin
        "Modified On" := Today;
        "Modified By" := UserID;
    end;
}
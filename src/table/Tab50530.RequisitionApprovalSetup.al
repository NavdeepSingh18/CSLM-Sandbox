table 50530 "Requisition Approval Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Requisition Department Approval Setup';
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), "Dimension Value Type" = filter(Standard));
            DataClassification = CustomerContent;
        }
        field(3; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(5; "Requisition Approver 1"; code[50])
        {
            Caption = 'Approver 1';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetFilter("User ID", '<>%1', UserSetup."User ID");
                // UserSetup.SetFilter("User ID", '<>%1', UserId());
                if PAGE.RunModal(PAGE::"Approval User Setup", UserSetup) = ACTION::LookupOK then
                    Validate("Requisition Approver 1", UserSetup."User ID");
            end;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if "Requisition Approver 1" = UserSetup."User ID" then
                    FieldError("Requisition Approver 1");
            end;
        }
        field(6; "Requisition Approver 2"; code[50])
        {
            Caption = 'Approver 2';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetFilter("User ID", '<>%1', UserSetup."User ID");
                // UserSetup.SetFilter("User ID", '<>%1', UserId());
                if PAGE.RunModal(PAGE::"Approval User Setup", UserSetup) = ACTION::LookupOK then
                    Validate("Requisition Approver 2", UserSetup."User ID");
            end;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if "Requisition Approver 2" = UserSetup."User ID" then
                    FieldError("Requisition Approver 2");
            end;
        }
        field(7; "Requisition Approver 3"; code[50])
        {
            Caption = 'Approver 3';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetFilter("User ID", '<>%1', UserSetup."User ID");
                // UserSetup.SetFilter("User ID", '<>%1', UserId());
                if PAGE.RunModal(PAGE::"Approval User Setup", UserSetup) = ACTION::LookupOK then
                    Validate("Requisition Approver 3", UserSetup."User ID");
            end;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if "Requisition Approver 3" = UserSetup."User ID" then
                    FieldError("Requisition Approver 3");
            end;
        }
        field(8; "Setup Type"; Option)
        {
            OptionCaption = ' ,Purchase,Requisition';
            OptionMembers = " ",Purchase,Requisition;
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        RecReqApproverSetup: Record "Requisition Approval Setup";
    begin
        IF Rec."Primary Key" = '' then begin
            RecReqApproverSetup.Reset();
            RecReqApproverSetup.SetCurrentKey("Primary Key");
            if RecReqApproverSetup.FindLast() then
                Rec."Primary Key" := IncStr(RecReqApproverSetup."Primary Key")
            Else
                Rec."Primary Key" := 'PK-00001';
        end;
    end;

}
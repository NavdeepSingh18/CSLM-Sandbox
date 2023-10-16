table 50543 "Requisition Approval Setups"
{
    Caption = 'Requisiton Minimum Stock Setup';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Global Dimension Code 2"; Code[20])
        {
            Caption = 'Item Code';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(3; "Approval User 1"; Code[50])
        {
            Caption = 'PURCHASE REQUEST APPROVER #1';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetFilter("User ID", '<>%1', UserSetup."User ID");
                // UserSetup.SetFilter("User ID", '<>%1', UserId());
                if PAGE.RunModal(PAGE::"Approval User Setup", UserSetup) = ACTION::LookupOK then
                    Validate("Approval User 1", UserSetup."User ID");
            end;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if "Approval User 1" = UserSetup."User ID" then
                    FieldError("Approval User 1");
            end;
        }
        field(4; "Approval User 2"; Code[50])
        {
            Caption = 'PURCHASE REQUEST APPROVER #2';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetFilter("User ID", '<>%1', UserSetup."User ID");
                if PAGE.RunModal(PAGE::"Approval User Setup", UserSetup) = ACTION::LookupOK then
                    Validate("Approval User 2", UserSetup."User ID");
            end;


            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if "Approval User 2" = UserSetup."User ID" then
                    FieldError("Approval User 1");
            end;
        }
        field(5; "Approval User 3"; Code[50])
        {
            Caption = 'PURCHASE REQUEST APPROVER #3';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetFilter("User ID", '<>%1', UserSetup."User ID");
                if PAGE.RunModal(PAGE::"Approval User Setup", UserSetup) = ACTION::LookupOK then
                    Validate("Approval User 3", UserSetup."User ID");
            end;


            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if "Approval User 3" = UserSetup."User ID" then
                    FieldError("Approval User 1");
            end;
        }
        field(6; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }
        field(7; "Minimum Stock Qty"; DEcimal)
        {
            //CSPL-00307
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Global Dimension Code 2", "Location Code")
        {
            Clustered = true;
        }
    }

}

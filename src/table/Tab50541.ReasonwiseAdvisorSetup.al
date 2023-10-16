table 50541 "Reason wise Advisor Setup"
{
    Caption = 'Reason wise Advisor Setup';
    DataClassification = ToBeClassified;
    // LookupPageId = "Reason Request List";
    // DrillDownPageId = "Reason Request List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Advisor Id"; Code[20])
        {
            Caption = 'Advisor Id';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." where(Department = filter("EED Pre-Clinical"));//CSPL-00307 Added Dept Filter

            trigger OnValidate()
            var
                RecEmp: Record Employee;
            begin
                IF RecEmp.Get(Rec."Advisor Id") then begin
                    Rec."First Name" := RecEmp."First Name";
                    Rec."Last Name" := RecEmp."Last Name";
                end;
            end;
        }
        field(3; "First Name"; Code[20])
        {
            Caption = 'First Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Last Name"; Code[20])
        {
            Caption = 'Last Name';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Code", "Advisor Id")
        {
            Clustered = true;
        }
    }
}

table 50364 "Student Hold"
{
    Caption = 'Student Hold';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Student Hold List";
    LookupPageId = "Student Hold List";
    DataCaptionFields = "Hold Code", "Hold Description", "Hold Type";

    fields
    {
        field(1; "Hold Code"; Code[20])
        {
            Caption = 'Hold Code';
            DataClassification = CustomerContent;
        }
        field(2; "Hold Description"; Text[250])
        {
            Caption = 'Hold Message';
            DataClassification = CustomerContent;
        }
        field(3; "Hold Type"; Option)
        {
            Caption = 'Hold Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Housing,Financial Aid,Bursar,Registrar,Registrar Sign-off,Immigration,Clinical,OLR Finance';
            OptionMembers = " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";

        }
        field(4; "Potal Login Restriction"; Boolean)
        {
            Caption = 'Potal Login Restriction';
            DataClassification = CustomerContent;
        }
        field(5; "Clinical Rotation"; Boolean)
        {
            Caption = 'Clinical Rotation';
            DataClassification = CustomerContent;
        }
        field(6; "Transcript Print"; Boolean)
        {
            Caption = 'Transcript Print';
            DataClassification = CustomerContent;
        }
        field(7; Progression; Boolean)
        {
            Caption = 'Progression';
            DataClassification = CustomerContent;
        }
        field(8; Billing; Boolean)
        {
            Caption = 'Billing';
            DataClassification = CustomerContent;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(11; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert';
            Editable = false;

        }
        field(12; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;

        }
        field(13; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(14; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;

        }
        field(15; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        field(16; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = false;

        }
        field(17; "Signoff Description"; Text[100])
        {
            Caption = 'Signoff Description ';
            DataClassification = CustomerContent;
        }
        field(18; "Sign-off"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sign-off';
        }
        field(19; "Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Group.Code;
        }
    }
    keys
    {
        key(PK; "Hold Code", "Global Dimension 1 Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Hold Code", "Hold Description", "Hold Type")
        {

        }
    }
    var

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        Updated := true;
    end;
}

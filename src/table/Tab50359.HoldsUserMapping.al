table 50359 "Holds User Mapping"
{
    Caption = 'Holds User Mapping';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Hold Code"; Code[20])
        {
            Caption = 'Hold Code';
            DataClassification = CustomerContent;
            TableRelation = "Student Hold";
            trigger OnValidate()
            begin
                if HoldRec.get("Hold Code") then begin
                    "Hold Description" := HoldRec."Hold Description";
                    "Hold Type" := HoldRec."Hold Type";
                end else begin
                    "Hold Description" := '';
                    "Hold Type" := "Hold Type"::" ";
                end;
            end;
        }
        field(2; "Hold Description"; Text[100])
        {
            Caption = 'Hold Description';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(3; "Hold Type"; Option)
        {
            Caption = 'Hold Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Housing,Financial Aid,Bursar,Registrar,Registrar Sign-off,Immigration,Clinical,OLR Finance';
            OptionMembers = " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
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
    }
    keys
    {
        key(key1; "Hold Code", "User ID", "Global Dimension 1 Code")
        {
            Clustered = true;
        }
    }
    var

        HoldRec: Record "Student Hold";

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

table 50443 "Level Wise Description"
{
    DataClassification = CustomerContent;
    // DrillDownPageId = "Level Wise Description List";
    // LookupPageId = "Level Wise Description List";

    fields
    {

        field(1; "Level Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Level Code';
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Level Description"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Level Description';
            OptionMembers = " ","Main Subject","Level 2 Systems","Level 3 Topics","Internal Exam Component","External Examination","Level 2 Clinical Rotation","Clinical Shelf Examination","Prep Examination","Level 2 Elective Rotation","Level 3 Exam","Level 3 Component","Level 3 Clinical Objective","Internal Examination";
        }
        field(4; Level; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Level';
            TableRelation = Level;

        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(12; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

    }

    keys
    {
        key(PK; "Level Code")
        {
            Clustered = true;
        }

    }

    var

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();

        Inserted := True;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        Updated := true;
    end;

}
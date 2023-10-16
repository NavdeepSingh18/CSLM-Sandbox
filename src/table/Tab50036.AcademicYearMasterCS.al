table 50036 "Academic Year Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                User Id Assign in User Id Field.
    // 2         CSPL-00092    03-05-2019    OnModify                Validate Data.

    Caption = 'Academic Year Master-CS';
    DrillDownPageID = "List Academic Year-CS";
    LookupPageID = "List Academic Year-CS";
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = CustomerContent;
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 06-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 06-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50005; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50006; Inserted; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Inserted';
        }
        field(50007; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::03-05-2019: Start
        "User ID" := FORMAT(UserId());

        Inserted := true;
        //Code added for User Id Assign in User Id Field::CSPL-00092::03-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Validate Data::CSPL-00092::03-05-2019: Start
        IF Closed THEN
            ERROR(Text000Lbl);

        If xRec.Updated = Updated then
            Updated := True;
        //Code added for Validate Data::CSPL-00092::03-05-2019: End
    end;

    var
        Text000Lbl: Label 'Cannot be modified';
}


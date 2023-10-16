table 50073 "Subject Type-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    17-03-2019    OnInsert                User Id Assign in User Id Field.
    // 2         CSPL-00092    17-03-2019    OnModify                Assign value in Updated Field.

    Caption = 'Subject Type';
    DrillDownPageID = 50002;
    LookupPageID = 50002;
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(50004; "Type of Subject"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Core,Elective,"Open Elective";
            Caption = 'Type of Subject';
        }
        field(50005; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(33048920; "User ID"; Code[30])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::17-03-2019: Start
        "User ID" := FORMAT(UserId());
        Inserted := true;
        //Code added for User Id Assign in User Id Field::CSPL-00092::17-03-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign value in Updated Field::CSPL-00092::17-03-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign value in Updated Field::CSPL-00092::17-03-2019: End
    end;
}


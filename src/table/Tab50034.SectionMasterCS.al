table 50034 "Section Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    02-05-2019    OnInsert                Assign Value in User Id and Mobile Insert Field.
    // 2         CSPL-00092    02-05-2019    OnModify                Assign Value in Updated and Mobile Update Field
    // 3         CSPL-00092    02-05-2019    Group - OnValidate      Find Sequence No

    Caption = 'Section Master';
    DrillDownPageID = "Sections List-CS";
    LookupPageID = "Sections List-CS";
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
        field(50003; Group; Code[20])
        {
            Description = 'CS Field Added 06-05-2019';
            TableRelation = "Group Master-CS";
            Caption = 'Group';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Find Sequence No::CSPL-00092::02-05-2019: Start
                SectionMasterCS.Reset();
                SectionMasterCS.SETRANGE(Group, Group);
                IF SectionMasterCS.FINDSET() THEN
                    "Sequence No" := SectionMasterCS.COUNT() + 1
                ELSE
                    "Sequence No" := 1;
                //Code added for Find Sequence No::CSPL-00092::02-05-2019: End
            end;
        }
        field(50004; "Sequence No"; Integer)
        {
            Description = 'CS Field Added 06-05-2019';
            Editable = false;
            Caption = 'Sequence No';
            DataClassification = CustomerContent;
        }
        field(50005; Updated; Boolean)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50006; "Time Table Generated"; Boolean)
        {
            Caption = 'Time Table Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
        }
        field(50007; "Template No."; Code[20])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Template No.';
            DataClassification = CustomerContent;
        }
        field(50008; Capacity; Integer)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Capacity';
            DataClassification = CustomerContent;
        }
        field(50009; "Mobile Insert"; Boolean)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(50010; "Mobile Update"; Boolean)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        Field(50011; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50012; Selection; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 06-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 06-05-2019';
            DataClassification = CustomerContent;
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
        //Code added for Assign Value in User Id and Mobile Insert Field::CSPL-00092::02-05-2019: Start
        "User ID" := FORMAT(UserId());
        "Mobile Insert" := TRUE;
        Inserted := true;
        //Code added for Assign Value in User Id and Mobile Insert Field::CSPL-00092::02-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated and Mobile Update Field::CSPL-00092::02-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        //Code added for Assign Value in Updated and Mobile Update Field::CSPL-00092::02-05-2019: End
    end;

    var
        SectionMasterCS: Record "Section Master-CS";
}


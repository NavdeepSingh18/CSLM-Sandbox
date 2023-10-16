table 50078 "Graduation Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger    Remarks
    // 1         CSPL-00092    13-02-2019    OnInsert   Assign User Id and Acadmic Year Field.
    // 2         CSPL-00092    13-02-2019    OnModify   Assign Updated Field.

    Caption = 'Graduation - CS';
    DrillDownPageID = 50293;
    LookupPageID = 50293;
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[20])
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
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 15-02-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 15-02-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50003; Updated; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(50004; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 15-02-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 15-02-2019';
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
        //Code added for Assign User Id and Acadmic Year Field::CSPL-00092::13-02-2019: Start
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        Inserted := True;
        //Code added for Assign User Id and Acadmic Year Field::CSPL-00092::13-02-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Updated Field::CSPL-00092::13-02-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Updated Field::CSPL-00092::13-02-2019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


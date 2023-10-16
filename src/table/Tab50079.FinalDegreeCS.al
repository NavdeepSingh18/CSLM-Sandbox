table 50079 "Final Degree-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger    Remarks
    // 1         CSPL-00092    13-02-2019    OnInsert   Assign User Id and Acadmic Year Field.

    Caption = 'Final Degree-CS';
    DataCaptionFields = "Code", Description;
    LookupPageID = "Degree Detail-CS";
    DrilldownPageID = "Degree Detail-CS";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
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
        Field(50003;"Min. CGPA Required";Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(30487921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 15-02-2019';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
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
        "Academic Year" := EducationVertical.CreateSessionYear();
        //Code added for Assign User Id and Acadmic Year Field::CSPL-00092::13-02-2019: End
    end;

    var
        EducationVertical: Codeunit "CSLMVerticalEducation-CS";
}


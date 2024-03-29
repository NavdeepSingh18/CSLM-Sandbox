table 50203 "Community-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                    Remarks
    // 1         CSPL-00092    04-05-01-2019    OnInsert                Assign Value  in User Id and Academic Year Field.

    Caption = 'Community-CS';
    //DrillDownPageID = 33049625;
    //LookupPageID = 33049625;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;


        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
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
        //Code added for Assign Value  in User Id and Academic Year Field::CSPL-00092::10-01-2019: Start
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for Assign Value  in User Id and Academic Year Field::CSPL-00092::10-01-2019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


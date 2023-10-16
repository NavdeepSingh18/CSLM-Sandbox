table 50083 "Course Group Header-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    24-01-2019    OnInsert                User Id and Academic Year Assign.

    Caption = 'Course Group Header-CS';

    fields
    {
        field(1; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(2; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Academic Year Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-01-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-01-2019';
        }
    }

    keys
    {
        key(Key1; Course, "Group Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id and Academic Year Assign::CSPL-00092::24-01-2019: Start
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for User Id and Academic Year Assign::CSPL-00092::24-01-2019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


table 50085 "Evaluation Course Header-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    24-01-2019    OnInsert                User Id and Academic Year Assign.

    Caption = 'Evaluation Course Header-CS';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Student Extension New-CS";
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
        field(33048922; "Stage1 Selection List No."; Integer)
        {
            Caption = 'Stage1 Selection List No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Course Code", "Evaluation Method Code", "Stage1 Selection List No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id and Academic Year Assign::CSPL-00092::24-01-2019: Start
        "Academic Year" := VerticalEducationCS.CreateAdmission_Yr();
        "User ID" := FORMAT(UserId());
        //Code added for User Id and Academic Year Assign::CSPL-00092::24-01-2019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


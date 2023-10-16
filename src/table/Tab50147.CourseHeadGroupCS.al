table 50147 "Course Head Group-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   27/07/2019       OnInsert()                             Auto assign User ID

    Caption = 'Course Head Group-CS';
    //LookupPageID = 33049452;

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
            Description = 'CS Field Added 27072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27072019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27072019';
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

        //Code added for Auto assign User ID & Academic Year::CSPL-00114::27072019: Start
        "Academic Year" := VerticalEducationCS.CreateSessionYear();

        "User ID" := FORMAT(UserId());
        //Code added for Auto assign User ID & Academic Year::CSPL-00114::27072019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


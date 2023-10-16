table 50049 "Calendar Off Day-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                Assign Value in Academic Year Field.

    Caption = 'Calendar Off Day-CS';
    DrillDownPageID = "Off Day Edu Calendar Setup-CS";
    LookupPageID = "Off Day Edu Calendar Setup-CS";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(3; WeekDay; Option)
        {
            Caption = 'WeekDay';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Code", "Academic Year", WeekDay)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Academic Year Field::CSPL-00092::10-01-2019: Start
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for Assign Value in Academic Year Field::CSPL-00092::10-01-2019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


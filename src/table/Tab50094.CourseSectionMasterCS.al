table 50094 "Course Section Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                   Remarks
    // 1         CSPL-00092    21-04-2019    OnInsert                  Assign Value in User Id amd Mobile Insert Field
    // 2         CSPL-00092    21-04-2019    OnModify                  Assign Value in Updated and Mobile Update Field
    // 3         CSPL-00092    21-04-2019    Course Code - OnValidate  Assign Value in fields
    // 4         CSPL-00092    21-04-2019    Section Code - OnValidate Find sequence no.

    Caption = 'Course Section Master-CS';
    DrillDownPageID = "Course Section Detail-CS";
    LookupPageID = "Course Section Detail-CS";

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in fields::CSPL-00092::21-04-2019: Start
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(Code, "Course Code");
                IF CourseMasterCS.FINDFIRST() THEN BEGIN
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                    "Program" := CourseMasterCS.Graduation;
                END;
                //Code added for Assign Value in fields::CSPL-00092::21-04-2019: End
            end;
        }
        field(2; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(3; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";

            trigger OnValidate()
            begin
                //Code added for Find sequence no.::CSPL-00092::21-04-2019: Start
                CourseSectionMasterCS.Reset();
                CourseSectionMasterCS.SETRANGE("Course Code", "Course Code");
                CourseSectionMasterCS.SETRANGE("Academic Year", "Academic Year");
                IF "Type Of Course" = "Type Of Course"::Semester THEN
                    CourseSectionMasterCS.SETRANGE(Semester, Semester)
                ELSE
                    CourseSectionMasterCS.SETRANGE(Year, Year);
                IF CourseSectionMasterCS.FINDSET() THEN
                    "Sequence No" := CourseSectionMasterCS.COUNT() + 1
                ELSE
                    "Sequence No" := 1;
                //Code added for Find sequence no.::CSPL-00092::21-04-2019: Start
            end;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Sequence No"; Integer)
        {
            Caption = 'Sequence No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            Editable = false;
        }
        field(50004; Capacity; Integer)
        {
            Caption = 'Capacity';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Year Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50015; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50016; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
            TableRelation = "Graduation Master-CS";
        }
        field(50017; "Time Table Generated"; Boolean)
        {
            Caption = 'Time Table Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50018; "Template No."; Code[20])
        {
            Caption = 'Template No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50019; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50020; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50021; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Description = 'CS Field Added 25-04-2019';
        }
        field(50022; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-04-2019';
        }
    }

    keys
    {
        key(Key1; "Course Code", Year, "Section Code", "Academic Year", Semester)
        {
        }
        key(Key2; "Section Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in User Id amd Mobile Insert Field::CSPL-00092::21-04-2019: Start
        "User ID" := FORMAT(UserId());
        "Mobile Insert" := TRUE;

        Inserted := true;
        //Code added for Assign Value in User Id amd Mobile Insert Field::CSPL-00092::21-04-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated and Mobile Update Field::CSPL-00092::21-04-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        //Code added for Assign Value in Updated and Mobile Update Field::CSPL-00092::21-04-2019: End
    end;

    var

        CourseSectionMasterCS: Record "Course Section Master-CS";
        CourseMasterCS: Record "Course Master-CS";

}


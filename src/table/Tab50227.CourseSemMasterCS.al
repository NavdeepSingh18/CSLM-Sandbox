table 50227 "Course Sem. Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    11-05-2019    OnInsert                            Assign Value in User ID Field.
    // 2         CSPL-00092    11-05-2019    OnModify                            Assign Value in Updated Field
    // 3         CSPL-00092    11-05-2019    Course Code - OnValidate            Assign Value in Fields
    // 4         CSPL-00092    11-05-2019    Semester Code - OnValidate          Find Sequence No

    Caption = 'Course Sem. Master-CS';
    DrillDownPageID = "Semester Course-CS";
    LookupPageID = "Semester Course-CS";

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::11-05-2019: Start
                IF CourseMasterCS.GET("Course Code") THEN BEGIN
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::11-05-2019: End
            end;
        }
        field(2; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";

            trigger OnValidate()
            begin
                //Code added for Find Sequence No::CSPL-00092::11-05-2019: Start
                CourseSemMasterCS.Reset();
                CourseSemMasterCS.SETRANGE("Course Code", "Course Code");
                CourseSemMasterCS.SETRANGE("Academic Year", "Academic Year");
                CourseSemMasterCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                CourseSemMasterCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
                IF CourseSemMasterCS.FINDSET() THEN
                    "Sequence No" := CourseSemMasterCS.COUNT() + 1
                ELSE
                    "Sequence No" := 1;
                //Code added for Find Sequence No::CSPL-00092::11-05-2019: End
            end;
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; Promoted; Boolean)
        {
            Caption = 'Promoted';
            DataClassification = CustomerContent;
        }
        field(7; "MSPE Application"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
        field(50013; "Type Of Course"; Option)
        {
            caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
        field(50015; "Sequence No"; Integer)
        {
            caption = 'Sequence No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }

        field(50016; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50089; Term; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER, ';
            OptionMembers = FALL,SPRING,SUMMER," ";
        }
        field(50090; "Start Date Not Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50091; "New OLR Start Date"; date)
        {
            DataClassification = CustomerContent;
        }
        field(50092; "New OLR End Date"; date)
        {
            DataClassification = CustomerContent;
        }
        field(50093; "Returning OLR Start Date"; date)
        {
            DataClassification = CustomerContent;
        }
        field(50094; "Returning OLR End Date"; date)
        {
            DataClassification = CustomerContent;
        }
        field(50095; "Dismissal Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50096; "Student No. Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
		field(50097; "Elective Offering"; Boolean)
        {
            Caption = 'Elective Offering';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
        field(33048922; "Fee Due Date"; Date)
        {
            Caption = 'Fee Due Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Course Code", "Semester Code", "Academic Year", Term)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in User ID Field::CSPL-00092::11-05-2019: Start
        "User ID" := FORMAT(UserId());

        Inserted := true;
        //Code added for Assign Value in User ID Field::CSPL-00092::11-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::11-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::11-05-2019: End
    end;

    var

        CourseSemMasterCS: Record "Course Sem. Master-CS";
        CourseMasterCS: Record "Course Master-CS";
}


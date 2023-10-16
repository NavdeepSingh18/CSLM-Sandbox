table 50282 "Course Year Master-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   08/02/2019       OnInsert()                                 automatically filled "User Id"
    // 02    CSPL-00114   08/02/2019       Course Code - OnValidate()                 Code added for Course Master Related Field Value
    // 03    CSPL-00114   08/02/2019       Year Code - OnValidate()                   Code added for Sequence No Count According CourseYear Master

    Caption = 'Course Year Master-CS';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Course Master Related Field Value ::CSPL-00114::08022019: Start
                IF CourseMasterCS.GET("Course Code") THEN BEGIN
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                END;
                //Code added for Course Master Related Field Value ::CSPL-00114::08022019: End
            end;
        }
        field(2; "Year Code"; Code[10])
        {
            Caption = 'Year Code';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Sequence No Count According CourseYear Master::CSPL-00114::08022019: Start
                CourseYearMasterCS.Reset();
                CourseYearMasterCS.SETRANGE("Course Code", "Course Code");
                CourseYearMasterCS.SETRANGE("Academic Year", "Academic Year");
                CourseYearMasterCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                //CourseYearMasterCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
                IF CourseYearMasterCS.FINDSET() THEN
                    "Sequence No" := CourseYearMasterCS.COUNT() + 1
                ELSE
                    "Sequence No" := 1;
                //Code added for Sequence No Count According CourseYear Master::CSPL-00114::08022019: End
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
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09012019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09012019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09012019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Year Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09012019';
        }
        field(50015; "Sequence No"; Integer)
        {
            Caption = 'Sequence No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09012019';
            Editable = false;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09012019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09012019';
        }
    }

    keys
    {
        key(Key1; "Course Code", "Year Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for automatically filled "User Id" name::CSPL-00114::08022019: Start
        "User ID" := FORMAT(UserId());
        //Code added for automatically filled "User Id" name::CSPL-00114::08022019: End
    end;

    var
        CourseYearMasterCS: Record "Course Year Master-CS";
        CourseMasterCS: Record "Course Master-CS";
}


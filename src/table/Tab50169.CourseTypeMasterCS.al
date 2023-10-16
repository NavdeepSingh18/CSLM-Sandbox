table 50169 "Course Type Master-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   11/04/2019       OnInsert()                                 Code added for Course Name

    Caption = 'Course Type Master-CS';
    DrillDownPageID = "Course Type Detail-CS";
    LookupPageID = "Course Type Detail-CS";

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;

            TableRelation = "Course Master-CS".Code;

            trigger OnValidate()
            begin
                //Code added for Course Name::CSPL-00114::11042019: Start
                CLEAR("Course Name");
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "Course Code");
                IF CourseMasterCS.FindFirst() THEN
                    "Course Name" := CourseMasterCS.Description;
                //Code added for Course Name::CSPL-00114::11042019: End
            end;
        }
        field(2; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(5; "Course Type"; Text[30])
        {
            Caption = 'Course Type';
            DataClassification = CustomerContent;
        }
        field(6; "Course Type Name"; Text[100])
        {
            Caption = 'Course Type Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Course Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CourseMasterCS: Record "Course Master-CS";
}


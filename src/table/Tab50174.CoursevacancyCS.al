table 50174 "Course vacancy-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   10/05/2019       OnInsert()                                 Code added for Get Course Name & Dimension value

    Caption = 'Course vacancy-CS';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Get Course Name & Dimension value::CSPL-00114::10052019: Start
                IF CourseMasterCS.GET("Course Code") THEN BEGIN
                    "Course Name" := CourseMasterCS.Description;
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                END;
                //Code added for Get Course Name & Dimension value::CSPL-00114::10052019: End
            end;
        }
        field(2; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Code"; Code[10])
        {
            Caption = 'Academic Code';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(9; "Created On"; Date)
        {
            caption = 'Created On"';
            DataClassification = CustomerContent;
        }
        field(10; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(11; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(12; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(13; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
        field(14; GENERAL; Integer)
        {
            Caption = 'GENERAL';
            DataClassification = CustomerContent;
        }
        field(15; AICTE; Integer)
        {
            Caption = 'AICTE';
            DataClassification = CustomerContent;
        }
        field(16; SAGES; Integer)
        {
            Caption = 'SAGES';
            DataClassification = CustomerContent;
        }
        field(17; Graduation; Code[20])
        {
            Caption = 'Graduation';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS";
        }
        field(18; Category; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS".Code;
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


table 50250 "Elective Group Course-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   20/07/2019      Course Code - OnValidate()                  Code for Course description.
    // 02    CSPL-00114   20/07/2019      Elective Group Code - OnValidate()          code added for Get value "Elective Group Description"

    Caption = 'Elective Group Course-CS';
    DrillDownPageID = 50129;
    LookupPageID = 50129;

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code for Course description::CSPL-00114::20072019: Start
                IF CourseMasterCS.GET("Course Code") THEN
                    "Course Description" := CourseMasterCS.Description
                ELSE
                    "Course Description" := '';
                //Code for Course description::CSPL-00114::20072019: End
            end;
        }
        field(2; "Elective Group Code"; Code[20])
        {
            Caption = 'Elective Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Elective Group Master-CS";

            trigger OnValidate()
            begin
                //code added for Get value "Elective Group Description"::CSPL-00114::20072019: Start
                IF ElectiveGroupMasterCS.GET("Elective Group Code") THEN
                    "Elective Group Description" := ElectiveGroupMasterCS.Description
                ELSE
                    "Elective Group Description" := '';
                //Code added for Get value "Elective Group Description"::CSPL-00114::20072019: End
            end;
        }
        field(3; "Course Description"; Text[100])
        {
            Caption = 'Course Description';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Course Master-CS";
        }
        field(4; "Elective Group Description"; Text[80])
        {
            Caption = 'Elective Group Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Course Code", "Elective Group Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CourseMasterCS: Record "Course Master-CS";
        ElectiveGroupMasterCS: Record "Elective Group Master-CS";
}


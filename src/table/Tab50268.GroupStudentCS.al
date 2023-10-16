table 50268 "Group Student-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   03/01/2019       Course - OnValidate()           Get the Value of Academic year ,type of Course & Dimension Value From Course Master.

    Caption = 'Group Student-CS';
    DrillDownPageID = "Group(Student)-CS";
    LookupPageID = "Group(Student)-CS";

    fields
    {
        field(1; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Academic year ,type of Course & Dimension Value From Course Master::CSPL-00114::03012019: Start
                "Global Dimension 1 Code" := '';
                "Academic Year" := '';
                CLEAR("Type Of Course");

                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, Course);
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Academic Year" := CourseMasterCS."Academic Year";
                END;
                //Code added for Academic year ,type of Course & Dimension Value From Course Master::CSPL-00114::03012019: End
            end;
        }
        field(2; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
        }
        field(3; "Group Code Description"; Text[50])
        {
            Caption = 'Group Code Description';
            DataClassification = CustomerContent;
        }
        field(4; "No. Of Student"; Integer)
        {
            Caption = 'No. Of Student';
            DataClassification = CustomerContent;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(9; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(10; Session; Code[20])
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            TableRelation = Session;
        }
        field(11; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(12; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(13; "Available Student"; Integer)
        {
            Caption = 'Available Student';
            CalcFormula = Count ("Co-Curricular Activities-CS" WHERE(Code = FIELD("Group Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Course, "Group Code", Semester, "Academic Year")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Course, "Group Code")
        {
        }
    }

    var
        CourseMasterCS: Record "Course Master-CS";
}


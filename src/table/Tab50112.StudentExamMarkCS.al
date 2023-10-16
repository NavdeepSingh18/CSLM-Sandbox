table 50112 "Student Exam Mark-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/03/2019       Exam code - OnValidate()                  Code Added for Exam Code Description
    // 02    CSPL-00114   19/03/2019       Course code - OnValidate()                Code Added for Course Description
    // 03    CSPL-00114   19/03/2019       Subject Code - OnValidate()               Code Added for Subject Description

    Caption = 'Student Exam Mark-CS';
    DrillDownPageID = "Student App. (CBCS )-CS";
    LookupPageID = "Student App. (CBCS )-CS";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(2; "Exam code"; Code[20])
        {
            Caption = 'Exam Code';
            DataClassification = CustomerContent;
            TableRelation = "Exam Group Code-CS";

            trigger OnValidate()
            begin
                //Code Added for Exam Code Description::CSPL-00114::19032019: Start
                IF ExamGroupCodeCS.GET("Exam code") THEN
                    Description := ExamGroupCodeCS.Description;
                //Code Added for Exam Code Description::CSPL-00114::19032019: End
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(5; "Course code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code Added for Course Description::CSPL-00114::19032019: Start
                IF CourseMasterCS.GET("Course code") THEN
                    "Course Name" := CourseMasterCS.Description;
                //Code Added for Course Description::CSPL-00114::19032019: End
            end;
        }
        field(6; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(8; year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(10; "Subject Code"; Code[10])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS" WHERE(Course = FIELD("Course code"),
                                                       "Academic Year" = FIELD("Academic year"));

            trigger OnValidate()
            begin
                //Code Added for Subject Description::CSPL-00114::19032019: Start
                IF SubjectMasterCS.GET("Subject Code", "Course code", "Academic year") THEN
                    "Subject Name" := SubjectMasterCS.Description;
                //Code Added for Subject Description::CSPL-00114::19032019: End
            end;
        }
        field(11; "Subject Name"; Text[100])
        {
            Caption = 'Subject Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Suject Type"; Code[10])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(13; "Subject Classification"; Code[10])
        {
            Caption = 'Subject Classification';
            DataClassification = CustomerContent;
            TableRelation = "Subject Classification-CS";
        }
        field(14; "Max. Marks"; Decimal)
        {
            Caption = 'Max. Mark';
            DataClassification = CustomerContent;
        }
        field(15; "Marks Optained"; Decimal)
        {
            Caption = 'Mark Optained';
            DataClassification = CustomerContent;
        }
        field(16; "Revoluation Marks"; Decimal)
        {
            Caption = 'Revolution Mark';
            DataClassification = CustomerContent;
        }
        field(17; "Revoluation Grade"; Decimal)
        {
            Caption = 'Revolution Grade';
            DataClassification = CustomerContent;
        }
        field(18; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
            TableRelation = "Grade Master-CS";
        }
        field(19; "Marks Entered By"; Text[30])
        {
            Caption = 'Marks Entry By';
            DataClassification = CustomerContent;
        }
        field(20; "Marks Entered On"; Date)
        {
            Caption = 'Mark Entered On';
            DataClassification = CustomerContent;
        }
        field(21; "Grace Marks"; Decimal)
        {
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19032019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19032019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Student No.", "Exam code", "Exam Type", "Course code", semester, year)
        {
        }
    }

    fieldgroups
    {
    }

    var
        ExamGroupCodeCS: Record "Exam Group Code-CS";
        CourseMasterCS: Record "Course Master-CS";
        SubjectMasterCS: Record "Subject Master-CS";
}


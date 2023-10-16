table 50025 "Exam Room Allocation-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    10-01-2019    OnModify                Assign Value in Updated Field
    // 2         CSPL-00092    10-01-2019    Course - OnValidate     Assign Value Fields

    Caption = 'Exam Room Allocation-CS';
    DrillDownPageID = 50057;
    LookupPageID = 50057;

    fields
    {
        field(1; "Room No."; Code[20])
        {
            Caption = 'Room No';
            DataClassification = CustomerContent;
            TableRelation = "Rooms-CS";
        }
        field(2; Floor; Code[30])
        {
            Caption = 'Floor';
            DataClassification = CustomerContent;
        }
        field(3; "Type Of Course"; Option)
        {
            Caption = 'Room No';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(4; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value Fields::CSPL-00092::04-05-2019: Start
                "Global Dimension 1 Code" := '';
                "Academic Year" := '';
                CLEAR("Type Of Course");
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, Course);
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Academic Year" := CourseMasterCS."Academic Year";
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                END;
                //Code added for Assign Value Fields::CSPL-00092::04-05-2019: End
            end;
        }
        field(5; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
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
        field(8; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(9; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(10; Session; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Session;
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(12; "Room Type"; Option)
        {
            Caption = 'Room Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Lecture Room,Lab Room,WorkShop,Seminar Hall';
            OptionMembers = " ","Lecture Room","Lab Room",WorkShop,"Seminar Hall";
        }
        field(13; Subject; Code[20])
        {
            TableRelation = "Main Student Subject-CS" WHERE(Course = FIELD(Course),
                                                             Semester = FIELD(Semester),
                                                             Year = FIELD(Year));
        }
        field(14; Updated; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Room No.", Course, "Global Dimension 1 Code", Semester, Year)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Room No.", Course, "Global Dimension 1 Code", "Global Dimension 2 Code", Semester)
        {
        }
    }

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::04-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::04-05-2019: End
    end;

    var
        CourseMasterCS: Record "Course Master-CS";
}


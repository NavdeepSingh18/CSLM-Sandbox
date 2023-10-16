table 50047 "Batch of Student-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    04-05-2019    OnModify                Assign Value in Updated Field.
    // 2         CSPL-00092    04-05-2019    Course - OnValidate     Assign Value in Fields

    Caption = 'Batch of Student-CS';
    DrillDownPageID = "Batch List Student-CS";
    LookupPageID = "Batch List Student-CS";

    fields
    {
        field(1; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::04-05-2019: Start
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, Course);
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Academic Year" := CourseMasterCS."Academic Year";
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::04-05-2019: End
            end;
        }
        field(2; "Batch Code"; Code[20])
        {
            Caption = 'Batch Code';
            DataClassification = CustomerContent;
        }
        field(3; "Batch Code Description"; Text[50])
        {
            Caption = 'Batch Code';
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
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(15; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    keys
    {
        key(Key1; Course, "Batch Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::04-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::04-05-2019: End
    end;

    trigger OnInsert()
    Begin
        Inserted := true;
    End;

    var
        CourseMasterCS: Record "Course Master-CS";
}


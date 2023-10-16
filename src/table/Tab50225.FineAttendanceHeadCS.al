table 50225 "Fine Attendance Head-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    11-05-2019    OnInsert                            Assign Value in User ID Field.
    // 2         CSPL-00092    11-05-2019    OnDelete                            Delete data from Table

    Caption = 'Fine Attendance Head-CS';
    //DrillDownPageID = 33049481;
    //LookupPageID = 33049481;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(4; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(5; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Fine Amount"; Decimal)
        {
            CalcFormula = Sum ("Fine Attendance Line-CS"."Fine Amount" WHERE("Document No." = FIELD("No."),
                                                                             "Student No." = FIELD("Student No.")));
            Caption = 'Fine Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(9; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = CustomerContent;
        }
        field(10; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
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
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", Semester, Section, "Academic year")
        {
        }
        key(Key3; "Student No.", "Course Code", Semester, Section, "Academic year")
        {
        }
        key(Key4; "Student No.", "Academic year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Delete data from Table::CSPL-00092::11-05-2019: Start
        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETRANGE("Document No.", "No.");
        AttendPercentageLineCS.DELETEALL();
        //Code added for Delete data from Table::CSPL-00092::11-05-2019: End
    end;

    trigger OnInsert()
    begin
        //Code added for Assign Value in User ID Field::CSPL-00092::11-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Assign Value in User ID Field::CSPL-00092::11-05-2019: End
    end;

    var
        AttendPercentageLineCS: Record "Attend Percentage Line-CS";
}


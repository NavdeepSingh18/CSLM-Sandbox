table 50086 "Evaluation Course Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                                    Remarks
    // 1         CSPL-00092    15-01-2019    Marks Obtained - OnValidate                Test Marks obtained.
    // 2         CSPL-00092    15-01-2019    Attendance Status - OnValidate             update Marks Obtained

    Caption = 'Evaluation Course Line-CS';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Discipline Level-CS";
        }
        field(3; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Application-CS";
        }
        field(4; "Applicant Name"; Text[50])
        {
            Caption = 'Applicant Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Marks Obtained"; Decimal)
        {
            Caption = 'Marks Obtained';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Test Marks obtained::CSPL-00092::15-01-2019: Start
                IF EvaluationCourseCS.GET("Course Code", "Evaluation Method Code") THEN
                    IF "Marks Obtained" > EvaluationCourseCS."Maximum Mark" THEN
                        ERROR(Text000Lbl, EvaluationCourseCS."Maximum Mark");
                //Code added forTest Marks obtained ::CSPL-00092::15-01-2019: End
            end;
        }
        field(6; "Attendance Status"; Option)
        {
            Caption = 'Attendance Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Present,Absent';
            OptionMembers = ,Present,Absent;

            trigger OnValidate()
            begin
                //Code added for update Marks Obtained::CSPL-00092::15-01-2019: Start
                IF "Attendance Status" = "Attendance Status"::Absent THEN
                    "Marks Obtained" := 0;
                //Code added for update Marks Obtained::CSPL-00092::15-01-2019: Start
            end;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "Stage1 Selection List No."; Integer)
        {
            Caption = 'Stage1 Selection List No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Course Code", "Evaluation Method Code", "Academic Year", "Application No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        EvaluationCourseCS: Record "Evaluation Course-CS";
        Text000Lbl: Label 'Maximum mark allowed is %1.';
}


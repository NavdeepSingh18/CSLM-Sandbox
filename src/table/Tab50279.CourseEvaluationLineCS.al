table 50279 "Course Evaluation Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   26/05/2019       Marks Obtained - OnValidate()             Code Added for validation Check
    // 02    CSPL-00114   26/05/2019       Attendance Status - OnValidate()          Code added for Marks Obtained Updated

    Caption = 'Course Evaluation Line-CS';

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
                //Code Added for validation Check ::CSPL-00114::26052019: Start
                IF EvaluationCourseCS.GET("Course Code", "Evaluation Method Code") THEN
                    IF "Marks Obtained" > EvaluationCourseCS."Maximum Mark" THEN
                        ERROR(Text000Lbl, EvaluationCourseCS."Maximum Mark");
                //Code Added for validation Check ::CSPL-00114::26052019: End
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
                //Code added for Marks Obtained Updated::CSPL-00114::26052019: Start
                IF "Attendance Status" = "Attendance Status"::Absent THEN
                    "Marks Obtained" := 0;
                //Code added for Marks Obtained Updated::CSPL-00114::26052019: End
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
            Description = 'CS Field Added 26052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "Stage1 Selection List No."; Integer)
        {
            Caption = 'Stage1 Selection List No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
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


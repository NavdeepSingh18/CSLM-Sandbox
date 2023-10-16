table 50318 "Revaluation Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                            Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   29/06/2019       Student No. - OnValidate()                         Get Student Name
    // 02    CSPL-00114   29/06/2019       Internal Revaluation Mark - OnValidate()           Code added for Total Revaluation
    // 03    CSPL-00114   29/06/2019       External Revaluation Mark - OnValidate()           Code added for Grade value

    Caption = 'Revaluation Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(6; "External Mark"; Decimal)
        {
            Caption = 'External Mark';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Get Student Name::CSPL-00114::29062019: Start
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name"
                ELSE
                    "Student Name" := '';
                //Code added for Get Student Name::CSPL-00114::29062019: End
            end;
        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(11; "Internal Mark"; Decimal)
        {
            Caption = 'Internal Mark';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; Total; Decimal)
        {
            Caption = 'Total';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; Result; Option)
        {
            Caption = 'Result';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(14; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Present,Absent,On Duty,Leave';
            OptionMembers = " ",Present,Absent,"On Duty",Leave;
        }
        field(15; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Grade Master-CS";
        }
        field(16; "Academic year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(17; "Internal Revaluation Mark"; Decimal)
        {
            Caption = 'Internal Revaluation Mark';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Get Total Revaluation::CSPL-00114::29062019: Start
                Total := "Internal Revaluation Mark" + "External Revaluation Mark";
                //Code added for Get Total Revaluation::CSPL-00114::29062019: End
            end;
        }
        field(18; "External Revaluation Mark"; Decimal)
        {
            Caption = 'External Revaluation Mark';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RevaluationHeadCS: Record "Revaluation Head-CS";
            begin
                //Code added for Grade value::CSPL-00114::29062019: Start
                Total := "Internal Revaluation Mark" + "External Revaluation Mark";
                RevaluationHeadCS.Reset();
                IF RevaluationHeadCS.GET("Document No.") THEN BEGIN
                    IF RevaluationHeadCS."External Maximum" < "External Mark" THEN
                        ERROR(Text000Lbl, RevaluationHeadCS."External Maximum");
                    IF (RevaluationHeadCS."Total Maximum" <> 0) AND (Total <> 0) THEN BEGIN
                        PercentageDecCS := ROUND((Total / RevaluationHeadCS."Total Maximum") * 100, 1, '=');
                        GradeCourseCS.Reset();
                        GradeCourseCS.SETFILTER("Min Percentage", '<=%1', PercentageDecCS);
                        GradeCourseCS.SETFILTER("Max Percentage", '>=%1', PercentageDecCS);
                        IF GradeCourseCS.FINDFIRST() THEN
                            Grade := GradeCourseCS.Code
                        ELSE
                            Grade := '';
                    END ELSE
                        Grade := '';
                END;
                //Code added for Grade value::CSPL-00114::29062019: End
            end;
        }
        field(19; "Base Doc No."; Code[20])
        {
            Caption = 'Base Doc No.';
            DataClassification = CustomerContent;
        }
        field(20; "Base Line No."; Integer)
        {
            Caption = 'Base Line No.';
            DataClassification = CustomerContent;
        }
        field(21; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; Course, Semester, Section, "Academic year", "Subject Type", "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        StudentMasterCS: Record "Student Master-CS";
        GradeCourseCS: Record "Grade Course-CS";
        PercentageDecCS: Decimal;

        Text000Lbl: Label '''Markes Obtained Should not be greater than %1';
}


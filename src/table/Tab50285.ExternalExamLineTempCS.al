table 50285 "External Exam Line Temp-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   29/05/2019       External Mark - OnValidate()    Get Grade value According Total Marks & update points value.
    // 02    CSPL-00114   29/05/2019       Student No. - OnValidate()      Getting the "Student Name" From Student master.

    Caption = 'External Exam Line Temp-CS';

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
            trigger OnValidate()
            begin
                //Code added for Get Grade value According Total Marks & update points value::CSPL-00114::29052019: Start
                IF "Attendance Type" <> "Attendance Type"::Present THEN
                    ERROR(Text000Lbl);
                ExternalExamHeaderCS.Reset();
                IF ExternalExamHeaderCS.GET("Document No.") THEN BEGIN
                    IF ExternalExamHeaderCS."External Maximum" < "External Mark" THEN
                        ERROR(Text001Lbl, ExternalExamHeaderCS."External Maximum");
                    Total := "Internal Mark" + "External Mark";
                    IF (ExternalExamHeaderCS."Total Maximum" <> 0) AND (Total <> 0) THEN BEGIN
                        PercentageDecCS := ROUND((Total / ExternalExamHeaderCS."Total Maximum") * 100, 1, '=');
                        GradeCourseCS.Reset();
                        GradeCourseCS.SETFILTER("Min Percentage", '<=%1', PercentageDecCS);
                        GradeCourseCS.SETFILTER("Max Percentage", '>=%1', PercentageDecCS);
                        IF GradeCourseCS.FINDFIRST() THEN BEGIN
                            "Percentage Obtained" := PercentageDecCS;
                            Grade := GradeCourseCS.Code;
                            Points := GradeCourseCS.Points;
                        END ELSE BEGIN
                            Grade := '';
                            Points := 0;
                        END;
                    END ELSE BEGIN
                        Grade := '';
                        Points := 0;
                    END;
                END;
                //Code added for Get Grade value According Total Marks & update points value::CSPL-00114::29052019: Start
            END;
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
                //Code added for Getting the "Student Name" From Student master::CSPL-00114::29052019: Start
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name"
                ELSE
                    "Student Name" := '';
                //Code added for Getting the "Student Name" From Student master::CSPL-00114::29052019: Start
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
        }
        field(12; Total; Decimal)
        {
            Caption = 'Total';
            DataClassification = CustomerContent;
        }
        field(13; Result; Option)
        {
            Caption = 'Result';
            DataClassification = CustomerContent;
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
        field(17; "Apply Type"; Option)
        {
            Caption = 'Apply Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Regular,Arrears';
            OptionMembers = " ",Regular,Arrears;
        }
        field(21; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
        }
        field(22; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
        }
        field(23; "Total Maximum"; Decimal)
        {
            Caption = 'Total Maximum';
            DataClassification = CustomerContent;
        }
        field(24; "Old Result-I"; Option)
        {
            Caption = 'Old Result-I';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(25; "Old Result-II"; Option)
        {
            Caption = 'Old Result-II';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(26; "Old Result-III"; Option)
        {
            Caption = 'Old Result-III';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(27; "Cr Points"; Decimal)
        {
            Caption = 'Cr Point';
            DataClassification = CustomerContent;
        }
        field(28; "Grace Marks"; Decimal)
        {
            Caption = 'Grace Marks';
            DataClassification = CustomerContent;
        }
        field(29; "External Marks Old Result-I"; Decimal)
        {
            Caption = 'External Marks Old Result-I';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "External Marks Old Result-II"; Decimal)
        {
            Caption = 'External Marks Old Result-II';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; "External Marks Old Result-III"; Decimal)
        {
            Caption = 'External Marks Old Result-III';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; Detained; Boolean)
        {
            Caption = 'Detained';
            DataClassification = CustomerContent;
        }
        field(33; Absent; Boolean)
        {
            Caption = 'Absent';
            DataClassification = CustomerContent;
        }
        field(34; UFM; Boolean)
        {
            Caption = 'UFM';
            DataClassification = CustomerContent;
        }
        field(35; Dropped; Boolean)
        {
            Caption = 'Dropped';
            DataClassification = CustomerContent;
        }
        field(36; "Re-Appeared"; Boolean)
        {
            Caption = 'Re-Appeared';
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
        key(Key3; Course, Semester, "Academic year", "Subject Code")
        {
        }
        key(Key4; "Student No.", Semester)
        {
        }
        key(Key5; Total)
        {
        }
    }

    fieldgroups
    {
    }

    var
        ExternalExamHeaderCS: Record "External Exam Header-CS";
        StudentMasterCS: Record "Student Master-CS";
        GradeCourseCS: Record "Grade Course-CS";
        PercentageDecCS: Decimal;

        Text000Lbl: Label 'You cant enter mark if attendence type is not present.';
        Text001Lbl: Label 'Marks obtained should not be greater than %1.';
}


table 50308 "Re-Appear Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   25/01/2019       External Mark - OnValidate()               Get grade value & Points According Total Marks
    // 02    CSPL-00114   25/01/2019       Student No. - OnValidate()                 Code addd to get the Student Name
    // 03    CSPL-00114   25/01/2019       New External Marks - OnValidate()          Code added for Validation & Get Total Marks
    // 04    CSPL-00114   25/01/2019       New Internal Marks - OnValidate()          Code added for Validation & Get Total Marks
    // 05    CSPL-00114   25/01/2019       FeeStatusCheckCS()                         Added code for Fee Status.

    Caption = 'Re-Appear Line-CS';

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
                //Get grade value & Points According Total Marks::CSPL-00114::25012019: Start
                Total := "Internal Mark" + "External Mark" + "Grace Marks";
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
                //Get grade value & Points According Total Marks::CSPL-00114::25012019: End
            end;
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
                //Code added for Student Name::CSPL-00114::25012019: Start
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name"
                ELSE
                    "Student Name" := '';
                //Code added for Student Name::CSPL-00114::25012019: End
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
        field(24; "Fee Generated"; Boolean)
        {
            Caption = 'Fee Generated';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(25; "New External Marks"; Decimal)
        {
            Caption = 'New External Marks';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Validation & Get Total Marks::CSPL-00114::25012019: Start
                FeeStatusCheckCS();
                ReAppearHeaderCS.Reset();
                ReAppearHeaderCS.SETRANGE(ReAppearHeaderCS."No.", "Document No.");
                IF ReAppearHeaderCS.FindFirst() THEN BEGIN
                    ReAppearHeaderCS.TESTFIELD(ReAppearHeaderCS."External Maximum");
                    ReAppearHeaderCS.TESTFIELD(ReAppearHeaderCS."Interanl Maximum");
                    IF ReAppearHeaderCS."External Maximum" < "New External Marks" THEN
                        ERROR('New external marks should not be greater than External Maximum Marks');
                END;
                "New Total Marks" := "New External Marks" + "New Internal Marks";
                //Code added for Validation & Get Total Marks::CSPL-00114::25012019: End
            end;
        }
        field(26; "New Internal Marks"; Decimal)
        {
            Caption = 'New Internal Marks';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Validation & Get Total Marks::CSPL-00114::25012019: Start
                FeeStatusCheckCS();
                ReAppearHeaderCS.Reset();
                ReAppearHeaderCS.SETRANGE(ReAppearHeaderCS."No.", "Document No.");
                IF ReAppearHeaderCS.FindFirst() THEN BEGIN
                    ReAppearHeaderCS.TESTFIELD(ReAppearHeaderCS."External Maximum");
                    ReAppearHeaderCS.TESTFIELD(ReAppearHeaderCS."Interanl Maximum");
                    IF ReAppearHeaderCS."Interanl Maximum" < "New Internal Marks" THEN
                        ERROR('New Internal marks should not be greater than Internal Maximum Marks');
                END;
                "New Total Marks" := "New External Marks" + "New Internal Marks";
                //Code added for Validation & Get Total Marks::CSPL-00114::25012019: End
            end;
        }
        field(27; "New Result"; Option)
        {
            Caption = 'New Result';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(28; "New Total Marks"; Decimal)
        {
            Caption = 'New Total Maximum';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(29; "Fetch Document No"; Code[20])
        {
            Caption = 'Fetch Document No';
            DataClassification = CustomerContent;
        }
        field(30; "Fetch Line No"; Integer)
        {
            Caption = 'Fetch Line No';
            DataClassification = CustomerContent;
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
        field(36; "Grace Marks"; Decimal)
        {
            Caption = 'Grace Marks';
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
    }

    fieldgroups
    {
    }

    var
        ExternalExamHeaderCS: Record "External Exam Header-CS";
        StudentMasterCS: Record "Student Master-CS";
        GradeCourseCS: Record "Grade Course-CS";

        ReAppearHeaderCS: Record "Re-Appear Header-CS";
        PercentageDecCS: Decimal;


    procedure FeeStatusCheckCS()
    begin
        //Added code for Fee Status::CSPL-00114::25012019: Start
        IF "Fee Generated" = FALSE THEN
            ERROR('Fee is not generated');
        //Added code for Fee Status::CSPL-00114::25012019: End
    end;
}


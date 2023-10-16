table 50006 "Time Table Ledger-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                         Remarks
    // 1         CSPL-00092    30-04-2019    OnInsert                        User Id Assign in User Id Field.
    // 2         CSPL-00092    30-04-2019    Subject Code - OnValidate     Assign Value in Fields
    // 3         CSPL-00092    30-04-2019    Employee Code - OnValidate    Assign Value in Faculty Name Field
    // 4         CSPL-00092    30-04-2019    Exam Code - OnValidate        Validate data and Assign Value in Period Type Field

    Caption = 'Time Table Ledger-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;

        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Day No"; Integer)
        {
            Caption = 'Day No';
            DataClassification = CustomerContent;
        }
        field(5; "Hour No"; Text[30])
        {
            Caption = 'Hour No';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var

            begin
            end;
        }
        field(6; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";

            trigger OnValidate()
            var
                Subject: Record "Subject Master-CS";
            begin
                //Code added for Assign Value in Fields::CSPL-00092::30-04-2019: Start
                IF Subject.GET("Subject Code") THEN BEGIN
                    "Subject Description" := Subject.Description;
                    "Subject Type" := Subject."Subject Type";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::30-04-2019: End
            end;
        }
        field(7; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Faculty Name Field::CSPL-00092::30-04-2019: Start
                IF Employee.GET("Employee Code") THEN
                    "Faculty Name" := Employee."First Name"
                ELSE
                    "Faculty Name" := '';
                //Code added for Assign Value in Faculty Name Field::CSPL-00092::30-04-2019: End
            end;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(9; "Time Table Date"; Date)
        {
            Caption = 'Time Table Date';
            DataClassification = CustomerContent;
        }
        field(10; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            TableRelation = "Section Master-CS";
        }
        field(11; "Actual Employee Code"; Code[20])
        {
            Caption = 'Actual Employee Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(12; "Actual Subject Code"; Code[20])
        {
            Caption = 'Actual Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(13; "Time Table Status"; Option)
        {
            Caption = ' Time Table Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Cancelled,Alternate';
            OptionMembers = " ",Cancelled,Alternate;
        }
        field(14; Reason; Text[50])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
        }
        field(15; "Attendance Code"; Code[20])
        {
            Caption = 'Attendance Code';
            DataClassification = CustomerContent;
        }
        field(16; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(17; "Faculty Name"; Text[30])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
        }
        field(18; "Subject Description"; Text[100])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
        }
        field(20; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            DataClassification = CustomerContent;
            TableRelation = "Exam Group Code-CS";

            trigger OnValidate()
            begin
                //Code added for validate data and Assign Value in Period Type Field::CSPL-00092::30-04-2019: Start
                IF "Type Of Course" = "Type Of Course"::Semester THEN
                    IF "Exam Code" <> '' THEN BEGIN
                        EducationSetupCS.GET();
                        SessionalExamGroupLineCS.Reset();
                        SessionalExamGroupLineCS.SETCURRENTKEY(Course, Semester, Section, "Academic year", "Subject Code", "Exam Method");
                        SessionalExamGroupLineCS.SETRANGE(Course, "Course Code");
                        SessionalExamGroupLineCS.SETRANGE(Semester, "Semester Code");
                        SessionalExamGroupLineCS.SETRANGE(Section, "Section Code");
                        SessionalExamGroupLineCS.SETRANGE("Academic year", EducationSetupCS."Academic Year");
                        SessionalExamGroupLineCS.SETRANGE("Subject Code", "Subject Code");
                        SessionalExamGroupLineCS.SETRANGE("Subject Type", "Subject Type");
                        SessionalExamGroupLineCS.SETRANGE("Exam Method", "Exam Code");
                        IF SessionalExamGroupLineCS.ISEMPTY() then
                            ERROR(Text000Lbl, "Exam Code");
                        "Period Type" := "Period Type"::Exam;
                    END

                //Code added for validate data and Assign Value in Period Type Field::CSPL-00092::30-04-2019: End
            end;
        }
        field(21; "Exam Description"; Text[50])
        {
            Caption = 'Exam Description';
            DataClassification = CustomerContent;
        }
        field(22; "Exam Status"; Option)
        {
            Caption = 'Exam Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Deffered,Closed';
            OptionMembers = " ",Deffered,Closed;
        }
        field(23; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(24; "End Time"; DateTime)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
        field(25; "Period Type"; Option)
        {
            Caption = 'Period Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Normal,Exam';
            OptionMembers = Normal,Exam;
        }
        field(26; "Internal Exam Code"; Code[20])
        {
            Caption = 'Internal Exam Code';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;

        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Course Code", "Semester Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::30-04-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::30-04-2019: End
    end;

    var
        Employee: Record "Employee";
        SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        Text000Lbl: Label 'Internal Exam %1 is not alloted for this Subject', Comment = '';
}


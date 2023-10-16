table 50098 "Class Attendance Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    22-05-2019    OnInsert                      Assign Value in Mobile Inser Field
    // 2         CSPL-00092    22-05-2019    OnModify                    Assign Value in Mobile Update Field
    // 3         CSPL-00092    22-05-2019    Course Code - OnValidate      Validate Data
    // 4         CSPL-00092    22-05-2019    Student No. - OnValidate    Validate Data
    // 5         CSPL-00092    22-05-2019    Student No. - OnLookup      Validate and Assign Data
    // 6         CSPL-00092    22-05-2019    Attendance Type - OnValidate  Validate Data
    // 7         CSPL-00092    22-05-2019    Description - OnValidate    Validate Data
    // 8         CSPL-00092    22-05-2019    Staff Code - OnValidate     Validate Data
    // 9         CSPL-00092    22-05-2019    TestStatus                    Function for Validate Data

    Caption = 'Student Attendance Line';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(5; Hour; Integer)
        {
            Caption = 'Hour';
            DataClassification = CustomerContent;
        }
        field(6; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = true;
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate and Assign Data::CSPL-00092::22-05-2019: Start

                If "Student No." <> '' then begin
                    StudentMasterCS1.Reset();
                    StudentMasterCS1.SetRange("No.", "Student No.");
                    IF StudentMasterCS1.FindFirst() then begin
                        "Student No." := StudentMasterCS1."No.";
                        "Student Name" := StudentMasterCS1."Student Name";
                        "Course Code" := StudentMasterCS1."Course Code";
                        Semester := StudentMasterCS1.Semester;
                        Section := StudentMasterCS1.Section;
                        "Roll No." := StudentMasterCS1."Roll No.";
                        "Enrollment No." := StudentMasterCS1."Enrollment No.";
                    end;
                END ELSE BEGIN
                    "Student No." := '';
                    "Student Name" := '';
                    "Course Code" := '';
                    Semester := '';
                    Section := '';
                    "Roll No." := '';
                    "Enrollment No." := '';

                END;

            END;
            //Code added for Validate and Assign Data::CSPL-00092::22-05-2019: End

        }
        field(7; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            OptionCaption = 'Present,Absent';
            OptionMembers = Present,Absent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                IF AttendanceActionCS.ApplyndValidateAttendancePer("Course Code", Semester, Section, "Subject Type", "Subject Code") THEN
                    ERROR(Text000Lbl);
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                IF AttendanceActionCS.ApplyndValidateAttendancePer("Course Code", Semester, Section, "Subject Type", "Subject Code") THEN
                    ERROR(Text000Lbl);
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(11; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(12; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(13; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(14; Section; Code[30])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 24-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 24-05-2019';
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
        }
        field(50015; Session; Code[20])
        {
            Description = 'CS Field Added 24-05-2019';
            TableRelation = Session;
            Caption = 'Session';
            DataClassification = CustomerContent;
        }
        field(50016; Type; Option)
        {
            Description = 'CS Field Added 24-05-2019';
            OptionCaption = ' ,Group,Batch';
            OptionMembers = " ",Group,Batch;
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(50017; Graduation; Code[20])
        {
            Caption = 'Graduation';
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Grade Master-CS";
            DataClassification = CustomerContent;
        }
        field(50018; Year; Code[20])
        {
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(50019; "Batch Code"; Code[30])
        {
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Batch-CS".Code;
            Caption = 'Batch Code';
            DataClassification = CustomerContent;
        }
        field(50020; "Group Code"; Code[20])
        {
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Group Student-CS"."Group Code";
            Caption = 'Group Code';
            DataClassification = CustomerContent;
        }
        field(50021; "Attendance Generated"; Boolean)
        {
            Description = 'CS Field Added 24-05-2019';
            Caption = 'Attendance Generated';
            DataClassification = CustomerContent;
        }
        field(50022; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            Description = 'CS Field Added 24-05-2019';
            TableRelation = Employee;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50023; "Roll No."; Code[10])
        {
            Description = 'CS Field Added 24-05-2019';
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
        }
        field(50024; "Reason Code"; Code[20])
        {
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Reason Code" where(Type = filter(Timetable));
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
        }
        field(50025; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 24-05-2019';
            Editable = true;
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(50026; Remark; Text[100])
        {
            Description = 'CS Field Added 24-05-2019';
            //TableRelation = "Reason Master-CS"."Reason Description";
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(50027; Updated; Boolean)
        {
            Description = 'CS Field Added 24-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50028; "Subject Class"; Code[20])
        {
            Description = 'CS Field Added 24-05-2019';
            TableRelation = "Subject Classification-CS".Code;
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
        }
        field(50029; "Attendance Condonation"; Boolean)
        {
            Description = 'CS Field Added 24-05-2019';
            Caption = 'Attendance Condonation';
            DataClassification = CustomerContent;
        }
        field(50030; "Mobile Insert"; Boolean)
        {
            Description = 'CS Field Added 24-05-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(50031; "Mobile Update"; Boolean)
        {
            Description = 'CS Field Added 24-05-2019';
            Caption = 'Mobile Updated';
            DataClassification = CustomerContent;
        }
        Field(50032; "Final Time Table No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50033; "Time Table Doc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50036; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(50037; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50038; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50039; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(50040; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50041; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = "FALL","SPRING","SUMMER";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; "Student No.", "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key4; "Document No.", "Student No.")
        {
        }
        key(Key5; Date, Hour)
        {
        }
        key(Key6; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code", Date, Hour)
        {
        }
        key(Key7; "Student No.")
        { }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Mobile Inser Field::CSPL-00092::22-05-2019: Start
        "Mobile Insert" := TRUE;
        // "Created By" := UserId();
        // "Created On" := Today();
        Inserted := true;
        //Code added for Assign Value in Mobile Inser Field::CSPL-00092::22-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Mobile Update Field::CSPL-00092::22-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        // "Updated By" := UserId();
        // "Updated On" := Today();

        //Code added for Assign Value in Mobile Update Field::CSPL-00092::22-05-2019: End
    end;

    var
        ClassAttendanceHeaderCS: Record "Class Attendance Header-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";

        StudentMasterCS1: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        AttendanceActionCS: Codeunit "Attendance Action-CS";
        Text000Lbl: Label 'You cant modify the generated student''s attendance percentage.';
        Text001Lbl: Label 'Student is already selected.';
        Text007Lbl: Label 'Attendance has been generated';

    procedure TestStatus()
    begin
        //Code added for Validate Data::CSPL-00092::22-05-2019: Start
        IF "Attendance Generated" = TRUE THEN
            ERROR(Text007Lbl);
        //Code added for Validate Data::CSPL-00092::22-05-2019: End
    end;
}
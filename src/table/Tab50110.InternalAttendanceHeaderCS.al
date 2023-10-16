table 50110 "Internal Attendance Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   18/04/2019       OnInsert()                                 Get "No Series",& Document Type" Values
    // 02    CSPL-00114   18/04/2019       OnModify()                                 Any record Update then updated Value Change
    // 03    CSPL-00114   18/04/2019       No. - OnValidate()                         No Series Generation Code
    // 04    CSPL-00114   18/04/2019       Course Code - OnValidate()                 Course Related Validation Check
    // 05    CSPL-00114   18/04/2019       Semester - OnValidate()                    Use Student Attendance Mark Check Function
    // 06    CSPL-00114   18/04/2019       Subject Type - OnValidate()                Use Student Attendance Mark Check Function
    // 07    CSPL-00114   18/04/2019       Subject Code - OnValidate()                Use Student Attendance Mark Check Function
    // 08    CSPL-00114   18/04/2019       Subject Code - Lookup()                    Code Added For Course wise Subject Page Lookup
    // 09    CSPL-00114   18/04/2019       Academic Year - OnValidate()                Use Student Attendance Mark Check Function
    // 10    CSPL-00114   18/04/2019       Staff Code - OnValidate()                  Use Student Attendance Mark Check Function
    // 11    CSPL-00114   18/04/2019       Section - OnValidate()                     Use Student Attendance Mark Check Function
    // 12    CSPL-00114   18/04/2019       Global Dimension 1 Code - OnValidate()     Use Student Attendance Mark Check Function
    // 13    CSPL-00114   18/04/2019       Global Dimension 2 Code - OnValidate()     Use Student Attendance Mark Check Function
    // 14    CSPL-00114   18/04/2019       Type of Course - OnValidate()              Use Student Attendance Mark Check Function
    // 15    CSPL-00114   18/04/2019       Year - OnValidate()                        Use Student Attendance Mark Check Function
    // 16    CSPL-00114   18/04/2019       Document Type - OnValidate()               Use Student Attendance Mark Check Function
    // 17    CSPL-00114   18/04/2019       Exam Type - OnValidate()                   Use Student Attendance Mark Check Function
    // 18    CSPL-00114   18/04/2019       Room No. - OnValidate()                    Use Student Attendance Mark Check Function
    // 19    CSPL-00114   18/04/2019       Room Line No - OnValidate()                Use Student Attendance Mark Check Function
    // 20    CSPL-00114   18/04/2019       ValidateShortcutDimCode - Function         Create Function for Dimension Value
    // 21    CSPL-00114   18/04/2019       AssistEdit - Function                      Create Function For No Series Generation
    // 22    CSPL-00114   18/04/2019       IfLineExists() - Function                  Create Function For Attendance Mark Check
    // 23    CSPL-00114   18/04/2019       OnReleaseLineExists() - Function           Create Function For Attendance Line Finding

    Caption = 'Internal Attendance Header-CS';

    fields
    {
        field(1; "No."; Code[20])
        {

            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //No Series Generation Code::CSPL-00114::18042019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    SetupExaminationCS.GET();
                    NoSeriesMgt.TestManual(SetupExaminationCS."Internal Exam Attd. Nos.");
                    "No.Series" := '';
                END;
                //No Series Generation Code::CSPL-00114::18042019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Course Related Validation Check::CSPL-00114::18042019: Start
                IfLineExists();
                IF "Course Code" = '' THEN BEGIN
                    Semester := '';
                    Year := '';
                    "Type Of Course" := "Type Of Course"::" ";
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Subject Type" := '';
                    "Subject Code" := '';
                    Section := '';
                    "Room Line No" := 0;
                    "Room No." := '';
                    "Staff Code" := '';
                END;
                //Course Related Validation Check::CSPL-00114::18042019: End
            end;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = IF ("Type Of Course" = FILTER(Semester)) "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD("Course Code"));

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                TESTFIELD("Course Code");
                //Use Student Attendance Mark Check Function::CSPL-00114::18042019: End
            end;
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code Added For Course wise Subject Page Lookup ::CSPL-00114::18042019: Start
                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                IF "Type Of Course" = "Type Of Course"::Semester THEN
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester)
                ELSE
                    CourseWiseSubjectLineCS.SETRANGE(Year, Year);
                IF CourseWiseSubjectLineCS.FINDSET() THEN
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN
                        "Subject Code" := CourseWiseSubjectLineCS."Subject Code";

                //Code Added For Course wise Subject Page Lookup ::CSPL-00114::18042019: End
            end;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(9; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(10; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(11; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Course Section Master-CS"."Section Code" WHERE("Course Code" = FIELD("Course Code"));

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18042019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18042019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(50013; "Type Of Course"; Option)
        {

            Description = 'CS Field Added 18042019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(50015; Year; Code[20])
        {
            Description = 'CS Field Added 18042019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(50016; "Document Type"; Option)
        {
            Description = 'CS Field Added 18042019';
            Editable = false;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
            Caption = 'Document Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(50017; "Exam Type"; Option)
        {
            Description = 'CS Field Added 18042019';
            Editable = false;
            OptionCaption = ' ,Regular,Re-Sessional';
            OptionMembers = " ",Regular,"Re-Sessional";
            Caption = 'Exam Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(50018; "Room No."; Code[20])
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Room No.';
            DataClassification = CustomerContent;
            TableRelation = "Room Alloted Line-CS"."Document No." WHERE("Exam Type" = FIELD("Document Type"),
                                                                         Course = FIELD("Course Code"),
                                                                         Semester = FIELD(Semester),
                                                                         "Subject Type" = FIELD("Subject Type"),
                                                                         "Subject Code" = FIELD("Subject Code"),
                                                                         Section = FIELD(Section),
                                                                         "Academic Year" = FIELD("Academic Year"),
                                                                         "Type Of Course" = FIELD("Type Of Course"),
                                                                         Year = FIELD(Year),
                                                                         "Room Alloted" = FILTER(false),
                                                                         Status = FILTER(Released));

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(50019; Status; Option)
        {
            Description = 'CS Field Added 18042019';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(50020; "Room Line No"; Integer)
        {
            Description = 'CS Field Added 18042019';
            Editable = false;
            Caption = 'Room Line No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function ::CSPL-00114::18042019: End
            end;
        }
        field(50021; "Exam Date"; DateTime)
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
        }
        field(50022; "Subject Class"; Code[10])
        {
            Description = 'CS Field Added 18042019';
            TableRelation = "Subject Classification-CS";
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
        }
        field(50023; "Course Name"; Text[100])
        {
            Description = 'CS Field Added 18042019';
            Editable = false;
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(50032; Updated; Boolean)
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(33048922; "Created By"; Text[50])
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(33048923; "Created On"; Date)
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(33048924; "Updated By"; Text[50])
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(33048925; "Updated On"; Date)
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(33048928; "Created By Name"; Text[50])
        {
            Description = 'CS Field Added 18042019';
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series",& Document Type" Values ::CSPL-00114::18042019: Start
        IF NOT SkipInitialization() THEN BEGIN
            SetupExaminationCS.GET();
            NoSeriesMgt.InitSeries(SetupExaminationCS."Internal Exam Attd. Nos.", xRec."No.Series", TODAY(), "No.", "No.Series");
        END;
        "Document Type" := "Document Type"::Internal;
        //Get "No Series",& Document Type" Values ::CSPL-00114::18042019: End
    end;

    trigger OnModify()
    begin
        //Any record Update then updated Value Change::CSPL-00114::18042019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Any record Update then updated Value Change::CSPL-00114::18042019: End
    end;

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        SetupExaminationCS: Record "Setup Examination -CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Text_10002Lbl: Label 'Student Internal Exam Attendance Line already exists.';
        Text_10001Lbl: Label 'Student Internal Exam Attendance Line does not exists.';

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        //Create Function for Dimension Value::CSPL-00114::18042019: Start
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No." <> '' THEN
            Modify();
        //Create Function for Dimension Value ::CSPL-00114::18042019: End
    end;

    local procedure SkipInitialization(): Boolean
    begin
        IF "No." = '' THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    procedure AssistEdit(OldInternalAttendanceHeaderCS: Record "Internal Attendance Header-CS"): Boolean
    begin
        //Create Function For No Series Generation::CSPL-00114::18042019: Start
        SetupExaminationCS.GET();
        IF NoSeriesMgt.SelectSeries(SetupExaminationCS."Internal Exam Attd. Nos.", OldInternalAttendanceHeaderCS."No.Series", "No.Series") THEN BEGIN
            SetupExaminationCS.GET();
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
        //Create Function For No Series Generation::CSPL-00114::18042019: End
    end;

    local procedure IfLineExists()
    var
        InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
    begin
        //Create Function For Attendance Mark Check::CSPL-00114::18042019: Start
        InternalAttendanceLineCS.Reset();
        InternalAttendanceLineCS.SETRANGE("Document No.", Rec."No.");
        IF InternalAttendanceLineCS.FINDFIRST() THEN
            ERROR(Text_10002Lbl);
        //Create Function For Attendance Mark Check::CSPL-00114::18042019: End
    end;

    procedure OnReleaseLineExists()
    var
        InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
    begin
        //Create Function For Attendance Line Finding:CSPL-00114::18042019: Start
        InternalAttendanceLineCS.Reset();
        InternalAttendanceLineCS.SETRANGE("Document No.", "No.");
        IF InternalAttendanceLineCS.ISEMPTY() then
            ERROR(Text_10001Lbl);
        //Create Function For Attendance Line Finding::CSPL-00114::18042019: End
    end;
}


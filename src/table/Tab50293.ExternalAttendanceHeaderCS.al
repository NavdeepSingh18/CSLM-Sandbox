table 50293 "External Attendance Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   08/05/2019       OnInsert()                                 Get Document Type" Values
    // 02    CSPL-00114   08/05/2019       OnModify()                                 Any record Update then updated Value Change
    // 03    CSPL-00114   08/05/2019       No. - OnValidate()                         No Series Generation Code
    // 05    CSPL-00114   08/05/2019       Semester - OnValidate()                    Use Student Attendance Mark Check Function
    // 06    CSPL-00114   08/05/2019       Subject Type - OnValidate()                Use Student Attendance Mark Check Function
    // 07    CSPL-00114   08/05/2019       Subject Code - OnValidate()                Use Student Attendance Mark Check Function
    // 10    CSPL-00114   08/05/2019       Staff Code - OnValidate()                  Use Student Attendance Mark Check Function
    // 11    CSPL-00114   08/05/2019       Section - OnValidate()                     Use Student Attendance Mark Check Function
    // 12    CSPL-00114   08/05/2019       Type of Course - OnValidate()              Use Student Attendance Mark Check Function
    // 13    CSPL-00114   08/05/2019       Document Type - OnValidate()               Use Student Attendance Mark Check Function
    // 14    CSPL-00114   08/05/2019       Status - OnValidate()                      Use Student Attendance Mark Check Function
    // 15    CSPL-00114   08/05/2019       Room Line No - OnValidate()                Use Student Attendance Mark Check Function
    // 15    CSPL-00114   08/05/2019       Attendance Per % - OnValidate()            Use Applicable Attendance
    // 16    CSPL-00114   08/05/2019       ValidateShortcutDimCode - Function         Create Function for Dimension Value
    // 17    CSPL-00114   08/05/2019       AssistEdit - Function                      No Series Generation
    // 18    CSPL-00114   08/05/2019       IfLineExists() - Function                  Create Function For Attendance Mark Check
    // 19    CSPL-00114   08/05/2019       OnReleaseLineExists() - Function           Create Function For Attendance Line Finding
    // 20    CSPL-00114   08/05/2019       AttendanceRecheck() - Function             Create Function For Detaind Field

    Caption = 'External Attendance Header-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //No Series Generation Code::CSPL-00114::08052019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    SetupExaminationCS.GET();
                    NoSeriesMgt.TestManual(SetupExaminationCS."External Exam Attd. Nos.");
                    "No.Series" := '';
                END;
                //No Series Generation Code::CSPL-00114::08052019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
            end;
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
            end;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
            end;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(9; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
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
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Attendance Not Applicable"; Boolean)
        {
            Caption = 'Attendance Not Applicable';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50004; "Room Allocation"; Boolean)
        {
            Caption = 'Room Allocation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50005; Invigilator; Boolean)
        {
            Caption = 'Invigilator';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50006; "Hall Ticket"; Boolean)
        {
            Caption = 'Hall Ticket';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
            end;
        }
        field(50015; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Year Master-CS";
        }
        field(50016; "Document Type"; Option)
        {
            Caption = 'Document Type"';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
            end;
        }
        field(50017; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            OptionCaption = ' ,Regular,Re-Registration,Makeup,Winter,Summer,Special';
            OptionMembers = " ",Regular,"Re-Registration",Makeup,Winter,Summer,Special;
        }
        field(50018; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Room Alloted Line-CS"."Document No." WHERE("Exam Type" = FIELD("Document Type"),
                                                                         Course = FIELD("Course Code"),
                                                                         Semester = FIELD(Semester),
                                                                         "Subject Type" = FIELD("Subject Type"),
                                                                         "Subject Code" = FIELD("Subject Code"),
                                                                         Section = FIELD(Section),
                                                                         "Academic Year" = FIELD("Academic Year"),
                                                                         "Type Of Course" = FIELD("Type Of Course"),
                                                                         "Room Alloted" = FILTER(False),
                                                                         Status = FILTER(Released));
        }
        field(50019; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
            end;
        }
        field(50020; "Room Line No"; Integer)
        {
            Caption = 'Room Line No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            Editable = false;

            trigger OnValidate()
            begin
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: Start
                IfLineExists();
                //Use Student Attendance Mark Check Function::CSPL-00114::08052019: End
            end;
        }
        field(50021; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50022; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Subject Classification-CS";
        }
        field(50023; "Attendance Per %"; Decimal)
        {
            Caption = 'Attendance Per %';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';

            trigger OnValidate()
            begin
                //Use Applicable Attendance::CSPL-00114::08052019: Start
                IF NOT CONFIRM(Text_10004Lbl) THEN
                    EXIT
                ELSE
                    AttendanceRecheck("No.", "Attendance Per %");
                "Applicable Att Per%" := "Attendance Per %";
                //Use Applicable Attendance::CSPL-00114::08052019: End
            end;
        }
        field(50024; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            Editable = false;
        }
        field(50025; "Actual Attendance Per %"; Decimal)
        {
            Caption = 'Actual Attendance Per %';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50026; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Exam Time Table Head-CS"."No." WHERE("Ext Exam Attendance No." = FILTER(<> ' '));
        }
        field(50027; "Hall Ticket No."; Code[20])
        {
            Caption = 'Hall Ticket No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50028; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50029; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50030; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50031; "Sitting Plan"; Boolean)
        {
            Caption = 'Sitting Plan';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50032; Updated; Boolean)
        {
            Caption = 'Room Line No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(50033; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50034; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Group Master-CS".Code;
        }
        field(50035; "Exam Classification"; Code[20])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
            TableRelation = "Examination Type Master-CS".Code;
        }
        field(33048922; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(33048923; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(33048924; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(33048925; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(33048928; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(33048929; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
        field(33048930; "Applicable Att Per%"; Decimal)
        {
            Caption = 'Applicable Att Per%';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08052019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Exam Schedule No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get Document Type" Values ::CSPL-00114::08052019: Start
        "Document Type" := "Document Type"::External;
        //Get Document Type" Values ::CSPL-00114::08052019: End
    end;

    trigger OnModify()
    begin
        //Any record Update then updated Value Change::CSPL-00114::08052019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        "Updated By" := FORMAT(UserId());
        "Updated On" := TODAY();
        //Any record Update then updated Value Change::CSPL-00114::08052019: End
    end;

    var

        SetupExaminationCS: Record "Setup Examination -CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        DimMgt: Codeunit "DimensionManagement";
        Text_10001Lbl: Label 'Student External Exam Attendance Line does not exists.';
        Text_10003Lbl: Label 'Student External Exam attendance Line already exists.';
        Text_10004Lbl: Label 'Do you want to Change the Attendance Perecantage ?';

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        //Create Function for Dimension Value::CSPL-00114::08052019: Start
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No." <> '' THEN
            Modify();
        //Create Function for Dimension Value::CSPL-00114::08052019: End
    end;

    local procedure SkipInitialization(): Boolean
    begin
        IF "No." = '' THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    procedure AssistEdit(ExternalAttendanceHeaderCS: Record "External Attendance Header-CS"): Boolean
    begin
        //No Series Generation::CSPL-00114::08052019: Start
        SetupExaminationCS.GET();
        IF NoSeriesMgt.SelectSeries(SetupExaminationCS."External Exam Attd. Nos.", ExternalAttendanceHeaderCS."No.Series", "No.Series") THEN BEGIN
            SetupExaminationCS.GET();
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
        //No Series Generation::CSPL-00114::08052019: End
    end;

    procedure OnReleaseLineExists()
    var
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
    begin
        //Create Function For Attendance Line Finding::CSPL-00114::08052019: Start
        ExternalAttendanceLineCS.Reset();
        ExternalAttendanceLineCS.SETRANGE("Document No.", "No.");
        IF ExternalAttendanceLineCS.ISEMPTY() then
            ERROR(Text_10001Lbl);
        //Create Function For Attendance Line Finding::CSPL-00114::08052019: End
    end;

    local procedure IFLineExists()
    var
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
    begin
        //Create Function For Attendance Mark Check::CSPL-00114::08052019: Start
        ExternalAttendanceLineCS.Reset();
        ExternalAttendanceLineCS.SETRANGE("Document No.", "No.");
        IF ExternalAttendanceLineCS.FINDFIRST() THEN
            ERROR(Text_10003Lbl);
        //Create Function For Attendance Mark Check::CSPL-00114::08052019: End
    end;

    local procedure AttendanceRecheck("DocNo.": Code[20]; AttPerc: Decimal)
    var
        ExternalAttendanceLineCSNew: Record "External Attendance Line-CS";
    begin
        //Create Function For Detaind Field::CSPL-00114::08052019: Start
        ExternalAttendanceLineCSNew.Reset();
        ExternalAttendanceLineCSNew.SETRANGE("Document No.", "DocNo.");
        IF ExternalAttendanceLineCSNew.FINDSET() THEN
            REPEAT
                IF ExternalAttendanceLineCSNew."Attendance %" >= AttPerc THEN BEGIN
                    ExternalAttendanceLineCSNew."Applicable Att Per%" := AttPerc;
                    ExternalAttendanceLineCSNew.Detained := FALSE;
                    ExternalAttendanceLineCSNew.Modify();
                END ELSE BEGIN
                    ExternalAttendanceLineCSNew."Applicable Att Per%" := AttPerc;
                    ExternalAttendanceLineCSNew.Detained := TRUE;
                    ExternalAttendanceLineCSNew.Modify();
                END;
            UNTIL ExternalAttendanceLineCSNew.NEXT() = 0;
        //Create Function For Detaind Field::CSPL-00114::08052019: End
    END;
}


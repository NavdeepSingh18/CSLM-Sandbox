table 50294 "External Attendance Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   10/07/2019       OnModify()                                 Record change then Updated Field update Values
    // 02    CSPL-00114   10/07/2019       Student No. - OnValidate()                 Code Added for Student related Value
    // 03    CSPL-00114   10/07/2019       No. - OnValidate()                         Code added for Status Related
    // 04    CSPL-00114   10/07/2019       Attendance Type - OnValidate()             Code Added for Validation & Attendance Calculate
    // 05    CSPL-00114   10/07/2019       Attendance % - OnValidate()                Code Added for Detained & Validation & Attendance Calculate
    // 06    CSPL-00114   10/07/2019       Room Alloted No. - OnValidate()            Code Added for Room Validation Check
    // 07    CSPL-00114   10/07/2019       Invigilator 1 - OnValidate()               Code Added for Invigilator 1
    // 08    CSPL-00114   10/07/2019       Invigilator 2 - OnValidate()               Code Added for Invigilator 2
    // 09    CSPL-00114   10/07/2019       UpdateAttendancevalues() - Function        Code Added for Attendance Type & Detained Modified

    Caption = 'External Attendance Line';

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
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            TableRelation = "Subject Type-CS";
            DataClassification = CustomerContent;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = "Subject Master-CS".Code;
            DataClassification = CustomerContent;
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Main Student Subject-CS"."Student No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code Added for Student related Value::CSPL-00114::10072019: Start
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Student Name" := StudentMasterCS."Name as on Certificate";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    IF StudentMasterCS."Roll No." <> '' THEN BEGIN
                        EVALUATE(IntRollNo, StudentMasterCS."Roll No.");
                        "Roll No." := IntRollNo;
                    END;
                END ELSE
                    "Student Name" := '';
                "Roll No." := 0;
                //Code Added for Student related Value::CSPL-00114::10072019: End
            end;
        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;
        }
        field(11; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            OptionCaption = ' ,Present,Absent';
            OptionMembers = " ",Present,Absent;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code Added for Validation & Attendance Calculate::CSPL-00114::10072019: Start
                IF "Attendance Not Applicable" THEN
                    ERROR(Text0002Lbl);

                UpdateAttendancevaluesCS();
                //Code Added for Validation & Attendance Calculate::CSPL-00114::10072019: End
            end;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Editable = false;
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 10072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCodeCS(1, "Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCodeCS(2, "Global Dimension 2 Code");
            end;
        }
        field(50003; "Attendance Not Applicable"; Boolean)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Attendance Not Applicable';
            DataClassification = CustomerContent;
        }
        field(50004; "Room Allocation"; Boolean)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Room Allocation';
            DataClassification = CustomerContent;
        }
        field(50005; Invigilator; Boolean)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Invigilation';
            DataClassification = CustomerContent;
        }
        field(50006; "Hall Ticket"; Boolean)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Hall Ticket';
            DataClassification = CustomerContent;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 10072019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Cource';
            DataClassification = CustomerContent;
        }
        field(50016; Year; Code[10])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(50017; "Attendance %"; Decimal)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Attendance %';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code Added for Detained & Attendance Calculate::CSPL-00114::10072019: Start
                IF "Attendance Not Applicable" THEN
                    ERROR(Text0002Lbl);

                IF "Attendance %" >= "Applicable Att Per%" THEN
                    Detained := FALSE
                ELSE
                    Detained := TRUE;
                Modify();
                UpdateAttendancevaluesCS();
                //Code Added for Detained & Attendance Calculate::CSPL-00114::10072019: End
            end;
        }
        field(50018; "Answer Sheet"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Answer Sheet';
            DataClassification = CustomerContent;
        }
        field(50019; Status; Option)
        {
            Description = 'CS Field Added 10072019';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(50020; "Room Alloted No."; Code[20])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Room Alloted No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code Added for Room Validation Check::CSPL-00114::10072019: Start
                IF Detained = TRUE THEN
                    ERROR('Room Not Alloted For Detained Student');

                IF "Room Alloted No." <> '' THEN BEGIN
                    ExternalAttendanceLineCS.RESET();
                    ExternalAttendanceLineCS.SETRANGE("Exam Date", "Exam Date");
                    ExternalAttendanceLineCS.SETRANGE("Exam Slot", "Exam Slot");
                    ExternalAttendanceLineCS.SETRANGE("Room Alloted No.", "Room Alloted No.");
                    IF ExternalAttendanceLineCS.FINDSET() THEN BEGIN
                        RoomCount := ExternalAttendanceLineCS.COUNT() + 1;
                        RoomsCS.RESET();
                        RoomsCS.SETRANGE("Display Room No.", "Room Alloted No.");
                        RoomsCS.SETFILTER("Exam Capacity", '<>%1', 0);
                        IF RoomsCS.FINDFIRST() THEN
                            IF RoomCount > RoomsCS."Exam Capacity" THEN
                                ERROR('Exam capacity of Room No. %1 is %2. You have exceeded the number which is assigned to the room. Kindly enter the next Room No. here', "Room Alloted No.", RoomsCS."Exam Capacity");
                    END;
                END;
                //Code Added for Room Validation Check::CSPL-00114::10072019: End
            end;
        }
        field(50021; "Document Type"; Option)
        {
            Description = 'CS Field Added 10072019';
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(50022; "Exam Type"; Option)
        {
            Description = 'CS Field Added 10072019';
            OptionCaption = ' ,Regular,Re-Registration,Makeup,Winter,Summer,Special';
            OptionMembers = " ",Regular,"Re-Registration",Makeup,Winter,Summer,Special;
            Caption = 'Room Allocation';
            DataClassification = CustomerContent;
        }
        field(50023; "Roll No."; Integer)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Room No.';
            DataClassification = CustomerContent;
        }
        field(50024; Detained; Boolean)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Detained';
            DataClassification = CustomerContent;
        }
        field(50025; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 10072019';
            Editable = false;
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(50026; "Exam Schedule No."; Code[20])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Exam Schedule No.';
            DataClassification = CustomerContent;
        }
        field(50027; "User ID"; Code[50])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(50028; "Applicable Att Per%"; Decimal)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Applicable Attendance Percentage';
            DataClassification = CustomerContent;
        }
        field(50029; "End Time"; Time)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
        field(50030; "Exam Slot"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
        }
        field(50031; "Start Time"; Time)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(50032; "Exam Date"; Date)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
        }
        field(50033; "Sitting Plan"; Boolean)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Sitting Plan';
            DataClassification = CustomerContent;
        }
        field(50034; Updated; Boolean)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50035; "Invigilator 1"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = Employee."No.";
            Caption = 'Invigilator 1';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code Added for Invigilator::CSPL-00114::10072019: Start
                IF Detained = TRUE THEN
                    ERROR('Invigilator 1 Not Allow For Detained Student');
                SrNum := 0;
                IF "Room Alloted No." <> '' THEN BEGIN
                    ExternalAttendanceLineCS.RESET();
                    ExternalAttendanceLineCS.SETRANGE("Document No.", "Document No.");
                    ExternalAttendanceLineCS.SETRANGE("Exam Date", "Exam Date");
                    ExternalAttendanceLineCS.SETRANGE("Exam Slot", "Exam Slot");
                    ExternalAttendanceLineCS.SETRANGE("Room Alloted No.", "Room Alloted No.");
                    ExternalAttendanceLineCS.SETRANGE("Invigilator 1", '');
                    IF ExternalAttendanceLineCS.FINDSET() THEN BEGIN
                        RoomCount := ExternalAttendanceLineCS.count();
                        REPEAT
                            SrNum += 1;
                            IF RoomCount >= SrNum THEN BEGIN
                                ExternalAttendanceLineCS."Invigilator 1" := "Invigilator 1";
                                ExternalAttendanceLineCS.Modify();
                            END;
                        UNTIL ExternalAttendanceLineCS.NEXT() = 0;
                    END;
                END ELSE
                    ERROR('Please Enter the Room');

                //Code Added for Invigilator::CSPL-00114::10072019: End
            end;
        }
        field(50036; "Invigilator 2"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = Employee."No.";
            Caption = 'Invigilator 2';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code Added for Invigilator::CSPL-00114::10072019: Start
                IF Detained = TRUE THEN
                    ERROR('Invigilator 2 Not Allow For Detained Student');

                SrNum := 0;
                IF "Room Alloted No." <> '' THEN BEGIN
                    ExternalAttendanceLineCS.RESET();
                    ExternalAttendanceLineCS.SETRANGE("Document No.", "Document No.");
                    ExternalAttendanceLineCS.SETRANGE("Exam Date", "Exam Date");
                    ExternalAttendanceLineCS.SETRANGE("Exam Slot", "Exam Slot");
                    ExternalAttendanceLineCS.SETRANGE("Room Alloted No.", "Room Alloted No.");
                    ExternalAttendanceLineCS.SETRANGE("Invigilator 2", '');
                    IF ExternalAttendanceLineCS.FINDSET() THEN BEGIN
                        RoomCount := ExternalAttendanceLineCS.count();
                        REPEAT
                            SrNum += 1;
                            IF RoomCount >= SrNum THEN BEGIN
                                ExternalAttendanceLineCS."Invigilator 2" := "Invigilator 2";
                                ExternalAttendanceLineCS.Modify();
                            END;
                        UNTIL ExternalAttendanceLineCS.NEXT() = 0;
                    END;
                END ELSE
                    ERROR('Please Enter the Room');

                //Code Added for Invigilator::CSPL-00114::10072019: End
            end;
        }
        field(50037; "Invigilator 3"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = Employee."No.";
            Caption = 'Invigilator 3';
            DataClassification = CustomerContent;
        }
        field(50038; "Invigilator 4"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = Employee."No.";
            Caption = 'Invigilator 4';
            DataClassification = CustomerContent;
        }
        field(50039; Remarks; Text[100])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(50040; "Subject Class"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = "Subject Classification-CS".Code;
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
        }
        field(50041; "Program"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = "Graduation Master-CS".Code;
            Caption = 'Program';
            DataClassification = CustomerContent;
        }
        field(50042; "Student Group"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = "Group Master-CS".Code;
            Caption = 'Student Group';
            DataClassification = CustomerContent;
        }
        field(50043; "Exam Classification"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = "Examination Type Master-CS".Code;
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
        }
        field(50044; Batch; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = "Examination Type Master-CS".Code;
            Caption = 'Batch';
            DataClassification = CustomerContent;
        }
        field(50045; "MAL Practice Level"; Code[20])
        {
            Description = 'CS Field Added 10072019';
            TableRelation = "Discipline MalPractice-CS"."No.";
            Caption = 'MAL Practice Level';
            DataClassification = CustomerContent;
        }
        field(33048922; "Created By"; Text[50])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(33048923; "Created On"; Date)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(33048924; "Updated By"; Text[50])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(33048925; "Updated On"; Date)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(33048928; "Created By Name"; Text[50])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
        field(33048929; "Hall Ticket No."; Code[20])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Hall Ticket No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; Course, Semester, "Subject Type", "Subject Code")
        {
        }
        key(Key3; Course)
        {
        }
        key(Key4; "Subject Code")
        {
        }
        key(Key5; "Global Dimension 2 Code")
        {
        }
        key(Key6; "Enrollment No.")
        {
        }
        key(Key7; "Subject Code", "Room Alloted No.", Section, "Roll No.")
        {
        }
        key(Key8; "Room Alloted No.", "Subject Code", Section, "Roll No.")
        {
        }
        key(Key9; "Room Alloted No.")
        {
        }
        key(Key10; "Room Alloted No.", "Subject Code", "Enrollment No.")
        {
        }
    }

    trigger OnModify()
    begin
        //Record change then Updated Field update Values::CSPL-00114::10072019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        "Updated By" := FORMAT(UserId());
        "Updated On" := TODAY();
        //Record change then Updated Field update Values::CSPL-00114::10072019: End
    end;

    var

        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        RoomsCS: Record "Rooms-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        // ExternalAttendanceLineCS1: Record "External Attendance Line-CS";
        DimMgt: Codeunit DimensionManagement;
        IntRollNo: Integer;

        RoomCount: Integer;
        Text0002Lbl: Label 'You can''t change attendance %!!';


        SrNum: Integer;

    procedure ValidateShortcutDimCodeCS(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure UpdateAttendancevaluesCS()
    var
    //StudentSubjectCOLLEGE: Record "Main Student Subject-CS";
    // StudentOptionalSubjectCOL: Record "Optional Student Subject-CS";
    // StudExternalAttendLine: Record "External Attendance Line-CS";
    // StudentExternalLineCOL: Record "External Exam Line-CS";
    begin
        //Code Added for Attendance Type & Detained Modified::CSPL-00114::10072019: Start
        IF "Subject Type" = 'CORE' THEN BEGIN
            MainStudentSubjectCS.RESET();
            MainStudentSubjectCS.SETRANGE("Student No.", "Student No.");
            MainStudentSubjectCS.SETRANGE(Course, Course);
            MainStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
            IF "Type Of Course" = "Type Of Course"::Semester THEN
                MainStudentSubjectCS.SETRANGE(Semester, Semester)
            ELSE
                MainStudentSubjectCS.SETRANGE(Year, Year);
            MainStudentSubjectCS.SETRANGE(Section, Section);
            MainStudentSubjectCS.SETRANGE("Subject Class", "Subject Class");
            MainStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
            IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                IF xRec."Attendance Type" <> Rec."Attendance Type" THEN
                    MainStudentSubjectCS."Attendance Type" := "Attendance Type"
                ELSE
                    IF xRec."Attendance %" <> Rec."Attendance %" THEN BEGIN
                        MainStudentSubjectCS."Attendance Percentage" := "Attendance %";
                        IF "Attendance %" >= "Applicable Att Per%" THEN
                            MainStudentSubjectCS.Detained := FALSE
                        ELSE
                            MainStudentSubjectCS.Detained := TRUE;
                    END;
                MainStudentSubjectCS.Modify();
            END;
        END ELSE
            IF "Subject Type" <> 'CORE' THEN BEGIN
                OptionalStudentSubjectCS.RESET();
                OptionalStudentSubjectCS.SETRANGE("Student No.", "Student No.");
                OptionalStudentSubjectCS.SETRANGE(Course, Course);
                OptionalStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
                IF "Type Of Course" = "Type Of Course"::Semester THEN
                    OptionalStudentSubjectCS.SETRANGE(Semester, Semester)
                ELSE
                    OptionalStudentSubjectCS.SETRANGE(Year, Year);
                OptionalStudentSubjectCS.SETRANGE(Section, Section);
                OptionalStudentSubjectCS.SETRANGE("Subject Class", "Subject Class");
                OptionalStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
                OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF OptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                    IF xRec."Attendance Type" <> Rec."Attendance Type" THEN
                        OptionalStudentSubjectCS."Attendance Type" := "Attendance Type"
                    ELSE
                        IF xRec."Attendance %" <> Rec."Attendance %" THEN BEGIN
                            OptionalStudentSubjectCS."Attendance Percentage" := "Attendance %";
                            IF "Attendance %" >= "Applicable Att Per%" THEN
                                OptionalStudentSubjectCS.Detained := FALSE
                            ELSE
                                OptionalStudentSubjectCS.Detained := TRUE;
                        END;
                    OptionalStudentSubjectCS.Modify();
                END;
            END;


        ExternalExamLineCS.RESET();
        ExternalExamLineCS.SETRANGE("Student No.", "Student No.");
        ExternalExamLineCS.SETRANGE(Course, Course);
        ExternalExamLineCS.SETRANGE("Academic year", "Academic Year");
        IF "Type Of Course" = "Type Of Course"::Semester THEN
            ExternalExamLineCS.SETRANGE(Semester, Semester)
        ELSE
            ExternalExamLineCS.SETRANGE(Year, Year);
        ExternalExamLineCS.SETRANGE(Section, Section);
        ExternalExamLineCS.SETRANGE("Subject Class", "Subject Class");
        ExternalExamLineCS.SETRANGE("Subject Code", "Subject Code");
        ExternalExamLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF ExternalExamLineCS.FINDFIRST() THEN BEGIN
            IF xRec."Attendance Type" <> Rec."Attendance Type" THEN
                ExternalExamLineCS."Attendance Type" := "Attendance Type"
            ELSE
                IF xRec."Attendance %" <> Rec."Attendance %" THEN BEGIN
                    ExternalExamLineCS."Attendance %" := "Attendance %";
                    IF "Attendance %" >= "Applicable Att Per%" THEN
                        ExternalExamLineCS.Detained := FALSE
                    ELSE
                        ExternalExamLineCS.Detained := TRUE;
                END;
            ExternalExamLineCS.Modify();
        END;

        AdmitCardLineCS.RESET();
        AdmitCardLineCS.SETRANGE("Student No.", "Student No.");
        AdmitCardLineCS.SETRANGE(Course, Course);
        AdmitCardLineCS.SETRANGE("Academic Year", "Academic Year");
        IF "Type Of Course" = "Type Of Course"::Semester THEN
            AdmitCardLineCS.SETRANGE(Semester, Semester)
        ELSE
            AdmitCardLineCS.SETRANGE(Year, Year);
        AdmitCardLineCS.SETRANGE(Section, Section);
        AdmitCardLineCS.SETRANGE("Subject Class", "Subject Class");
        AdmitCardLineCS.SETRANGE("Subject Code", "Subject Code");
        AdmitCardLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF AdmitCardLineCS.FINDFIRST() THEN BEGIN
            IF xRec."Attendance %" <> Rec."Attendance %" THEN BEGIN
                AdmitCardLineCS."Actual Per%" := "Attendance %";
                IF "Attendance %" >= "Applicable Att Per%" THEN
                    AdmitCardLineCS.Detained := FALSE
                ELSE
                    AdmitCardLineCS.Detained := TRUE;
            END;
            AdmitCardLineCS.Modify();
        END;
        //Code Added for Attendance Type & Detained Modified::CSPL-00114::10072019: End
    end;
}


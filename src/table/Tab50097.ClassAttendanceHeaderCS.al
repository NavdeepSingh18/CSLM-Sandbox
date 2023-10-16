table 50097 "Class Attendance Header-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                                 Remarks
    // 1         CSPL-00092    10-01-2019    OnInsert                                No. Series and Assign Value in User Id Field
    // 2         CSPL-00092    10-01-2019    OnModify                                Assign Value Updated Field
    // 3         CSPL-00092    10-01-2019    OnDelete                                Delete data from  attandance line table
    // 4         CSPL-00092    10-01-2019    No. - OnValidate                        No series
    // 5         CSPL-00092    10-01-2019    Course Code - OnValidate                Validate Data
    // 6         CSPL-00092    10-01-2019    Semester - OnValidate                   Validate Data
    // 7         CSPL-00092    10-01-2019    Date - OnValidate                       Validate Data
    // 8         CSPL-00092    10-01-2019    Hour - OnValidate                       Validate Data
    // 9         CSPL-00092    10-01-2019    Attendance By - OnValidate              Validate Data
    // 10         CSPL-00092    10-01-2019    Present All - OnValidate                Validate Data and delete data from Class attandance line Table
    // 11         CSPL-00092    10-01-2019    Academic Year - OnValidate              Validate Data
    // 12         CSPL-00092    10-01-2019    Subject Type - OnValidate               Validate Data
    // 13         CSPL-00092    10-01-2019    Subject Code - OnValidate               Validate Data
    // 14         CSPL-00092    10-01-2019    Subject Code - OnLookup                 Validate Data
    // 15         CSPL-00092    10-01-2019    Section - OnValidate                    Validate Data
    // 16         CSPL-00092    10-01-2019    CBCS Batch - OnValidate                 Validate Data
    // 17         CSPL-00092    10-01-2019    Global Dimension 1 Code - OnValidate    Validate Data
    // 18         CSPL-00092    10-01-2019    Global Dimension 2 Code - OnValidate    Validate Data
    // 19         CSPL-00092    10-01-2019    Topic Covered - OnValidate              Validate Data
    // 20         CSPL-00092    10-01-2019    Attendance Type - OnValidate            Validate Data
    // 21        CSPL-00092    10-01-2019    Subject Description - OnValidate        Validate Data
    // 22        CSPL-00092    10-01-2019    Select Unit - OnValidate                Validate Data
    // 23        CSPL-00092    10-01-2019    Type Of Course - OnValidate             Validate Data
    // 24        CSPL-00092    10-01-2019    Final Years Course - OnValidate         Validate Data
    // 25        CSPL-00092    10-01-2019    Session - OnValidate                    Validate Data
    // 26        CSPL-00092    10-01-2019    Type - OnValidate                       Validate Data
    // 27        CSPL-00092    10-01-2019    Graduation - OnValidate                 Validate Data
    // 28        CSPL-00092    10-01-2019    Year - OnValidate                       Validate Data
    // 29        CSPL-00092    10-01-2019    Batch Code - OnValidate                 Validate Data
    // 30        CSPL-00092    10-01-2019    Group Code - OnValidate                 Validate Data
    // 31        CSPL-00092    10-01-2019    Attendance Generated - OnValidate       Validate Data
    // 32        CSPL-00092    10-01-2019    Attendance Date - OnValidate            Validate Data
    // 33        CSPL-00092    10-01-2019    Time Slot - OnValidate                  Assign Time Slot
    // 34        CSPL-00092    10-01-2019    Time Table No - OnValidate              Assign Time Slot
    // 35        CSPL-00092    10-01-2019    Assistedit                              Function for Assistedit Button
    // 36        CSPL-00092    10-01-2019    TestStatus                              Function for Validate Data
    // 37        CSPL-00092    10-01-2019    TestAttendanceLineExists                Validate Data

    Caption = 'Class Attendance Header-CS';
    DrillDownPageID = 50010;
    LookupPageID = 50010;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No series::CSPL-00092::22-05-2019: Start
                TestStatus();
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    //NoSeriesManagement.TestManual(AcademicsSetupCS."Attendance No.");
                    "No.Series" := '';
                END;
                //Code added for No series::CSPL-00092::22-05-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(5; Hour; Integer)
        {
            Caption = 'Hour';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(6; "Attendance By"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                IF Employee.GET("Attendance By") THEN
                    "Attendance By Name" := Format(Copystr(Employee."Search Name", 1, 50))
                ELSE
                    "Attendance By Name" := '';

                //TestStatus();
                //TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(7; "Present All"; Boolean)
        {
            Caption = 'Present All';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data and delete data from Class attandance line Table::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                ClassAttendanceLineCS.Reset();
                ClassAttendanceLineCS.SETRANGE("Document No.", "No.");
                IF ClassAttendanceLineCS.FINDFIRST() THEN
                    IF CONFIRM(Text006Lbl, FALSE) THEN BEGIN
                        ClassAttendanceLineCS1.Reset();
                        ClassAttendanceLineCS1.SETRANGE("Document No.", "No.");
                        ClassAttendanceLineCS1.DELETEALL();
                        "Present All" := TRUE;
                    END ELSE
                        "Present All" := xRec."Present All";

                //Code added for Validate Data and delete data from Class attandance line Table::CSPL-00092::22-05-2019: End
            end;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Academic Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(9; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();

                AcademicsSetupCS.GET();
                IF "Subject Type" <> xRec."Subject Type" THEN
                    "Subject Code" := '';
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    AcademicsSetupCS.TESTFIELD("CBCS Batch");
                    "CBCS Batch" := AcademicsSetupCS."CBCS Batch";
                END;
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(10; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(11; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            Begin
                If "Subject Code" <> '' then begin
                    SubjectMaster.Reset();
                    SubjectMaster.SetRange(Code, "Subject Code");
                    IF SubjectMaster.FindFirst() then
                        "Subject Description" := SubjectMaster.Description;
                end Else
                    "Subject Description" := '';
            End;


        }
        field(12; Section; Code[30])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(13; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(14; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();  // CORP;
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50003; "Topic Covered"; Code[20])
        {
            Caption = 'Topic Coverd';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50004; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            OptionCaption = 'Regular,Extra';
            OptionMembers = Regular,Extra;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50005; "Subject Description"; Text[100])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50006; "Select Unit"; Code[40])
        {
            Caption = 'Select Unit';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            TableRelation = "Unit Master-CS" WHERE(Subject = FIELD("Subject Code"));

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50015; Session; Code[20])
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            TableRelation = Session;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50016; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            OptionCaption = ' ,Group,Batch';
            OptionMembers = " ",Group,Batch;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50017; Graduation; Code[20])
        {
            Caption = 'Graduation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            TableRelation = "Graduation Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                EducationSetupCS.Reset();
                EducationSetupCS.SETRANGE("Global Dimension 1 Code", '09');
                IF EducationSetupCS.FINDFIRST() THEN BEGIN
                    CourseMasterCS1.Reset();
                    CourseMasterCS1.SETRANGE(Code, EducationSetupCS."Course Code");
                    IF CourseMasterCS1.FINDFIRST() THEN BEGIN
                        "Type Of Course" := CourseMasterCS1."Type Of Course";
                        "Global Dimension 1 Code" := CourseMasterCS1."Global Dimension 1 Code";
                    END;
                END;
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50018; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            TableRelation = "Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50019; "Batch Code"; Code[30])
        {
            Caption = 'Batch Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            TableRelation = "Batch-CS".Code;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50020; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            TableRelation = "Group Student-CS"."Group Code" WHERE(Course = FIELD("Course Code"));

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestStatus();
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50021; "Attendance Generated"; Boolean)
        {
            Caption = 'Attendance Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                TestAttendanceLineExists();
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50022; "Attendance Date"; Date)
        {
            Caption = 'Attendance Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::22-05-2019: Start
                ClassAttendanceHeaderCS.Reset();
                ClassAttendanceHeaderCS.SETRANGE("Course Code", "Course Code");
                IF "Type Of Course" = "Type Of Course"::Semester THEN
                    ClassAttendanceHeaderCS.SETRANGE(Semester, Semester)
                ELSE
                    ClassAttendanceHeaderCS.SETRANGE(Year, Year);
                ClassAttendanceHeaderCS.SETRANGE(Section, Section);
                ClassAttendanceHeaderCS.SETRANGE("Academic Year", "Academic Year");
                ClassAttendanceHeaderCS.SETRANGE("Subject Class", "Subject Class");
                ClassAttendanceHeaderCS.SETRANGE("Subject Type", "Subject Type");
                ClassAttendanceHeaderCS.SETRANGE("Subject Code", "Subject Code");
                ClassAttendanceHeaderCS.SETRANGE("Attendance Date", "Attendance Date");
                IF ClassAttendanceHeaderCS.FINDFIRST() THEN
                    ERROR('Attendance Already Genrated !!');
                //Code added for Validate Data::CSPL-00092::22-05-2019: End
            end;
        }
        field(50023; "Attendance By Name"; Text[50])
        {
            Caption = 'Attendance By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
        }
        field(50024; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
        }
        field(50025; "Attendance Marked"; Boolean)
        {
            Caption = 'Attendance Marked';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
        }
        field(50026; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            Editable = false;
            TableRelation = "Exam Room Allocation-CS";
        }
        field(50027; "Time Slot"; Code[20])
        {
            Caption = 'Time Slot';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            Editable = false;
            TableRelation = "Time Period-CS"."Slot No";

            trigger OnValidate()
            begin
                //Code added for Assign Time Slot::CSPL-00092::22-05-2019: Start
                IF TimePeriodCS.GET("Time Slot") THEN BEGIN
                    "Start Time" := TimePeriodCS."Start Time";
                    "End Time" := TimePeriodCS."End Time"
                END ELSE BEGIN
                    "Start Time" := 0T;
                    "End Time" := 0T;
                END;
                //Code added for Assign Time Slot::CSPL-00092::22-05-2019: End
            end;
        }
        field(50028; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
        }
        field(50029; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
        }
        field(50030; "Time Table No"; Integer)
        {
            Caption = 'Time Table No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            TableRelation = "Final Class Time Table-CS" WHERE(Date = FIELD("Attendance Date"),
                                                               "Course code" = FIELD("Course Code"),
                                                               Semester = FIELD(Semester),
                                                               Section = FIELD(Section),
                                                               "Academic Code" = FIELD("Academic Year"),
                                                               "Subject Code" = FIELD("Subject Code"),
                                                               "Attendance" = FILTER("Not Marked"));

            trigger OnValidate()
            begin
                //Code added for Assign Time Slot::CSPL-00092::22-05-2019: Start
                FinalClassTimeTableCS.Reset();
                IF FinalClassTimeTableCS.GET("Time Table No") THEN BEGIN
                    "Time Table No" := FinalClassTimeTableCS."S.No.";
                    VALIDATE("Attendance By", FinalClassTimeTableCS."Faculty 1Code");
                    "Room No." := FinalClassTimeTableCS."Room No";
                    VALIDATE("Time Slot", FinalClassTimeTableCS."Time Slot Code");
                    "Time Table Doc. No." := FinalClassTimeTableCS."Time Table  Document No.";
                END ELSE
                    IF "Time Table No" = 0 THEN BEGIN
                        "Attendance By" := '';
                        "Attendance By Name" := '';
                        "Room No." := '';
                        "Time Slot" := '';
                        "Start Time" := 0T;
                        "End Time" := 0T;
                        "Time Table Doc. No." := '';
                    END;
                //Code added for Assign Time Slot::CSPL-00092::22-05-2019: End
            end;
        }
        field(50031; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            TableRelation = "Subject Classification-CS";
        }
        field(50032; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
            Editable = false;
        }
        field(50033; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
        }
        Field(50034; "Time Table Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50035; "Time Table Date"; Date)
        {
            DataClassification = CustomerContent;
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
        field(33048920; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            Description = 'CS Field Added 25-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-05-2019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; "Course Code", Semester, Section, "Academic Year")
        {
        }
        key(Key4; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code", Date, Hour)
        {
        }
        key(Key5; "Course Code", Semester, Section, "Academic Year", Date, Hour)
        {
        }
        Key(Key6; "Time Table Doc. No.")
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        StudentWiseGoal: Record "Student Wise Goal";
    begin
        //Code added for delete data from  attandance line table::CSPL-00092::22-05-2019: Start
        ClassAttendanceLineCS.Reset();
        ClassAttendanceLineCS.SETRANGE("Document No.", "No.");
        ClassAttendanceLineCS.DELETEALL();

        StudentWiseGoal.Reset();
        StudentWiseGoal.SetRange("Final Time Table No.", Rec."Time Table No");
        StudentWiseGoal.SetRange("Time Table Doc No.", Rec."Time Table Doc. No.");
        StudentWiseGoal.DeleteAll();


        //Code added for delete data from  attandance line table::CSPL-00092::22-05-2019: End
    end;

    trigger OnInsert()
    begin
        //Code added for No. Series and Assign Value in User Id Field::CSPL-00092::22-05-2019: Start
        AcademicsSetupCS.GET();
        //IF "No.Series" = '' THEN
        AcademicsSetupCS.TESTFIELD("Attendance No.");
        NoSeriesManagement.InitSeries(AcademicsSetupCS."Attendance No.", xRec."No.Series", 0D, "No.", "No.Series");

        "User ID" := FORMAT(UserId());
        //"Created By" := UserId();
        //"Created On" := Today();
        Inserted := true;
        //Code added for No. Series and Assign Value in User Id Field::CSPL-00092::22-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value Updated Field::CSPL-00092::22-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //"Updated By" := UserId();
        //"Updated On" := Today();
        //Code added for Assign Value Updated Field::CSPL-00092::22-05-2019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";

        ClassAttendanceHeaderCS: Record "Class Attendance Header-CS";

        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        ClassAttendanceLineCS1: Record "Class Attendance Line-CS";
        TimePeriodCS: Record "Time Period-CS";
        Employee: Record "Employee";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        FinalClassTimeTableCS: Record "Final Class Time Table-CS";
        EducationSetupCS: Record "Education Setup-CS";
        CourseMasterCS1: Record "Course Master-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

        Text006Lbl: Label 'Do you want to delete the Student in Attendance Line ?';
        Text007Lbl: Label 'Attendance has been generated';

        Text_10001Lbl: Label 'Student Attendance Line already exist.';


    procedure Assistedit(OldStudentAttendanceHeader: Record "Class Attendance Header-CS"): Boolean
    begin
        //Code added for Assistedit Button::CSPL-00092::22-05-2019: Start
        WITH ClassAttendanceHeaderCS DO BEGIN
            ClassAttendanceHeaderCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Attendance No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Attendance No.", OldStudentAttendanceHeader."No.Series", "No.Series") THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := ClassAttendanceHeaderCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Assistedit Button::CSPL-00092::22-05-2019: Start
    end;

    procedure TestStatus()
    begin
        //Code added for Validate Data::CSPL-00092::22-05-2019: Start
        IF "Attendance Generated" = TRUE THEN
            ERROR(Text007Lbl);
        //Code added for Validate Data::CSPL-00092::22-05-2019: End
    end;

    local procedure TestAttendanceLineExists()
    begin
        //Code added for Validate Data::CSPL-00092::22-05-2019: Start
        ClassAttendanceLineCS.Reset();
        ClassAttendanceLineCS.SETRANGE("Document No.", Rec."No.");
        IF NOT ClassAttendanceLineCS.ISEMPTY() then
            ERROR(Text_10001Lbl);
        //Code added for Validate Data::CSPL-00092::22-05-2019: End
    end;
}


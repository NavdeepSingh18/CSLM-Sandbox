table 50128 "Class Time Table Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   13/05/2019       OnInsert()                                 Get "No Series" Values
    // 02    CSPL-00114   13/05/2019       OnModify()                                 Code added for Modification Flag
    // 03    CSPL-00114   13/05/2019       OnDelete()                                 Code added for Lines Deleted
    // 04    CSPL-00114   13/05/2019       No. - OnValidate()                         Code added for Get No Series Value
    // 05    CSPL-00114   13/05/2019       Course - OnValidate()                      Code added for Course related information
    // 06    CSPL-00114   13/05/2019       Template No. - OnValidate()                Function call  for line insert
    // 07    CSPL-00114   13/05/2019       Template Code - OnValidate()               Code added for Template Name Value & line Insert
    // 08    CSPL-00114   13/05/2019       Open Elective - OnValidate()               Code added for Validation
    // 08    CSPL-00114   13/05/2019       TemplateLinesInsertCS() - Function         Create function for line Insert
    // 08    CSPL-00114   13/05/2019       AssistEdit() - Function                    Create function for Auto no series generation

    DrillDownPageID = "Time Table Hdr List-CS";
    LookupPageID = "Time Table Hdr List-CS";
    Caption = 'Class Time Table Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No Series Value::CSPL-00114::13052019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AdmissionSetupCS.GET();
                    NoSeriesMgt.TestManual(AdmissionSetupCS."Time Table No.");
                END;
                //Code added for No Series Value::CSPL-00114::13052019: End
            end;
        }
        field(2; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS";
        }
        field(3; Semester; Text[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD(Course),
                                                                           "Academic Year" = FIELD("Academic Year"), Term = Field(Term), "Global Dimension 1 Code" = Field("Global Dimension 1 Code"));
        }
        field(4; Course; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Course related information::CSPL-00114::13052019: Start
                IF CourseMasterCS.GET(Course) THEN BEGIN
                    "Course Name" := CourseMasterCS.Description;
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                END ELSE
                    IF Course = '' THEN BEGIN
                        "Course Name" := '';
                        "Type Of Course" := "Type Of Course"::" ";
                        "Global Dimension 1 Code" := '';
                        "Global Dimension 2 Code" := '';
                    END;
                //Code added for Course related information::CSPL-00114::13052019: End
            end;
        }
        field(5; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS".Code;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "Template No."; Code[20])
        {
            Caption = 'Template No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Function call  for line insert ::CSPL-00114::13052019: Start
                TemplateLinesInsertCS();
                //Function call  for line insert ::CSPL-00114::13052019: End
            end;
        }
        field(9; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
            TableRelation = "Rooms-CS";
        }
        field(10; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(13; "Time Table Status"; Option)
        {
            Caption = 'Time Table Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Open,Released,Generated,Open for Updation,Release For Updation';
            OptionMembers = Open,Released,Generated,"Open for Updation","Release For Updation";
        }
        field(14; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(15; Group; Code[20])
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
            TableRelation = "Group Master-CS";
        }
        field(16; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(17; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = CustomerContent;
            TableRelation = "Time Table Template Head-CS"."No." WHERE(Status = FILTER(Released), "Global Dimension 1 Code" = field("Global Dimension 1 Code"));

            trigger OnValidate()
            begin
                //Code added for Template Name Value & line Insert::CSPL-00114::13052019: Start
                TimeTableTemplateHeadCS.RESET();
                TimeTableTemplateHeadCS.SETRANGE("No.", "Template Code");
                IF TimeTableTemplateHeadCS.FINDSET() THEN
                    "Template Name" := TimeTableTemplateHeadCS."Template Name"
                ELSE
                    "Template Name" := '';

                TemplateLinesInsertCS();
                //Code added for Template Name Value & line Insert::CSPL-00114::13052019: End
            end;
        }
        field(18; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(19; "Template Name"; Text[100])
        {
            Caption = 'Template Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Created By"; Code[30])
        {
            Caption = 'Creted By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13052019';
        }
        field(50002; "Created On"; Date)
        {
            Caption = 'Creted On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13052019';
        }
        field(50003; "Modified By"; Code[30])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13052019';
        }
        field(50004; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13052019';
        }
        field(50005; "Open Elective"; Boolean)
        {
            Caption = 'Open Elective';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13052019';

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::13052019: Start
                IF "Open Elective" = TRUE THEN BEGIN
                    Course := '';
                    "Course Name" := '';
                    Semester := '';
                    Section := '';
                    Year := '';
                    "Template Code" := '';
                    "Template Name" := '';
                END;
                //Code added for Validation::CSPL-00114::13052019: End
            end;
        }
        field(50006; "Time Table Updated"; Boolean)
        {
            Caption = 'Time Table Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13052019';
        }
        field(50007; "Level 1 Subject Code"; Code[20])
        {
            Caption = 'Level 1 Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code where("Level Description" = filter("Main Subject"), "Global Dimension 1 Code" = Field("Global Dimension 1 Code"));

            trigger OnValidate()
            begin
                IF "Level 1 Subject Code" <> '' then begin
                    SubjectMasterRec.Reset();
                    SubjectMasterRec.SetRange(Code, "Level 1 Subject Code");
                    IF SubjectMasterRec.FindFirst() then
                        "Level 1 Subject Description" := SubjectMasterRec.Description;
                end else
                    "Level 1 Subject Description" := '';
            end;
        }
        field(50008; "Level 1 Subject Description"; Text[100])
        {
            Caption = 'Level 1 Subject Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50009; Term; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        Field(50010; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50011; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50012; "Using TTBuffer"; Boolean)
        {
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
        fieldgroup(DropDown; "No.", "Program", Semester, Course, "Course Name", Section, "Academic Year", "Template No.", "Room No.", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
        }
    }

    trigger OnDelete()
    var
        TimeTableBuffer: Record "Time Table Buffer";
        FinalTimeTable: Record "Final Class Time Table-CS";
    begin
        //Code added for Lines Deleted ::CSPL-00114::13052019: Start
        //ERROR('You Cannot Delete Time Table');
        // IF not  ("Time Table Status" In ["Time Table Status"::Open,"Time Table Status"::"Open for Updation"]) then 
        // Error('Status must be open');

        // //CODE COMMENT REASON Every time ERROR Find first when you call the trigger
        ClassTimeTableLineCS.RESET();
        ClassTimeTableLineCS.SETRANGE("Document No.", "No.");
        ClassTimeTableLineCS.DELETEALL();

        TimeTableBuffer.Reset();
        TimeTableBuffer.SetRange("Time Table Document No.", Rec."No.");
        TimeTableBuffer.DeleteAll();

        FinalTimeTable.Reset();
        FinalTimeTable.SetRange("Time Table  Document No.", Rec."No.");
        FinalTimeTable.DeleteAll();
        //Code added for Lines Deleted ::CSPL-00114::13052019: End
    end;

    trigger OnInsert()
    begin
        //Code added for Get "No Series" Values ::CSPL-00114::13052019: Start
        AdmissionSetupCS.GET();
        //IF "No. Series" = '' THEN BEGIN
        if "No." = '' then begin
            AdmissionSetupCS.TESTFIELD(AdmissionSetupCS."Time Table No.");
            NoSeriesMgt.InitSeries(AdmissionSetupCS."Time Table No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        // "Created By" := UserId();
        // "Created On" := Today();
        Inserted := true;
        //Code added for Get "No Series" Values ::CSPL-00114::13052019: End
    end;

    trigger OnModify()
    begin
        //Code added for Modification Flag ::CSPL-00114::13052019: Start
        // IF "Time Table Status" = "Time Table Status"::Generated THEN
        //     ERROR('This Document already Generated');
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        // "Modified By" := FORMAT(UserId());
        // "Modified On" := TODAY();
        //Code added for Modification Flag ::CSPL-00114::13052019: End
    end;

    var
        ClassTimeTableLineCS: Record "Class Time Table Line-CS";
        TimeTableTemplateLineCS: Record "Time Table Template Line-CS";
        CourseMasterCS: Record "Course Master-CS";
        AdmissionSetupCS: Record "Admission Setup-CS";

        ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";
        TimeTableTemplateHeadCS: Record "Time Table Template Head-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";

        EducationSetupCS: Record "Education Setup-CS";
        SubjectMasterRec: Record "Subject Master-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        FacultyStartDate: Date;
        FacultyEndDate: Date;


    procedure TemplateLinesInsertCS()
    begin
        //Create Function for line Insert::CSPL-00114::13052019: Start

        ClassTimeTableLineCS.RESET();
        ClassTimeTableLineCS.SETCURRENTKEY("Document No.");
        ClassTimeTableLineCS.SETRANGE("Document No.", "No.");
        IF ClassTimeTableLineCS.FINDSET() THEN
            ClassTimeTableLineCS.DELETEALL(TRUE);

        If Rec."Global Dimension 1 Code" = '9000' then
            AUATimeTableLineInsert(Rec);

        IF Rec."Global Dimension 1 Code" = '9100' then
            AICASATimeTableLine(Rec);


        //Create Function for line Insert::CSPL-00114::13052019: End
    end;

    procedure AssistEdit(OldFee: Record "Class Time Table Header-CS"): Boolean
    begin
        //Create Function for Auto no series Generation::CSPL-00114::13052019: Start
        WITH ClassTimeTableHeaderCS DO BEGIN
            ClassTimeTableHeaderCS := Rec;
            AdmissionSetupCS.GET();
            AdmissionSetupCS.TESTFIELD(AdmissionSetupCS."Time Table No.");
            IF NoSeriesMgt.SelectSeries(AdmissionSetupCS."Time Table No.", OldFee."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := ClassTimeTableHeaderCS;
                EXIT(TRUE);
            END;
        END;
        //Create Function for Auto no series Generation::CSPL-00114::13052019: End
    end;


    Procedure AttendanceGeneratedforStudents(FinalClassTimeTable_lRec: Record "Final Class Time Table-CS")
    Var
        ClassAttendanceHdr_lRec: Record "Class Attendance Header-CS";
        AcademicsSetup_lRec: Record "Academics Setup-CS";
        SubjectMaster_lRec: Record "Subject Master-CS";
        NoseriesMgmt_lRec: Codeunit NoSeriesManagement;
        AttendanceActionCS: Codeunit "Attendance Action-CS";
        WebServiceFn: Codeunit WebServicesFunctionsCSL;

    Begin
        AcademicsSetup_lRec.Reset();
        AcademicsSetup_lRec.Get();

        ClassAttendanceHdr_lRec.Reset();
        ClassAttendanceHdr_lRec.SetRange("Time Table No", FinalClassTimeTable_lRec."S.No.");
        If not ClassAttendanceHdr_lRec.FindFirst() then begin
            ClassAttendanceHdr_lRec.Init();
            ClassAttendanceHdr_lRec."No." := NoseriesMgmt_lRec.GetNextNo(AcademicsSetup_lRec."Attendance No.", WorkDate(), true);
            ClassAttendanceHdr_lRec.Validate("Course Code", FinalClassTimeTable_lRec."Course code");
            ClassAttendanceHdr_lRec.Semester := FinalClassTimeTable_lRec.Semester;
            ClassAttendanceHdr_lRec.Section := FinalClassTimeTable_lRec.Section;
            ClassAttendanceHdr_lRec."Academic Year" := FinalClassTimeTable_lRec."Academic Code";
            ClassAttendanceHdr_lRec."Global Dimension 1 Code" := FinalClassTimeTable_lRec."Global Dimension 1 Code";
            ClassAttendanceHdr_lRec."Global Dimension 2 Code" := FinalClassTimeTable_lRec."Global Dimension 2 Code";
            ClassAttendanceHdr_lRec."Subject Class" := FinalClassTimeTable_lRec."Subject Class";
            ClassAttendanceHdr_lRec.Term := FinalClassTimeTable_lRec.Term;
            // SubjectMasterRec.Reset();
            // SubjectMasterRec.SetRange(Code, FinalClassTimeTable_lRec."Subject Code");
            // If SubjectMasterRec.FindFirst() then begin
            //     SubjectMaster_lRec.Reset();
            //     SubjectMaster_lRec.SetRange(Code, SubjectMasterRec."Subject Group");
            //     If SubjectMaster_lRec.FindFirst() then begin
            //         ClassAttendanceHdr_lRec."Subject Code" := SubjectMaster_lRec."Subject Group";
            //         ClassAttendanceHdr_lRec."Subject Description" := SubjectMaster_lRec."Subject Group Description";
            //     end;
            //     IF Not SubjectMaster_lRec.FindFirst() then begin
            //         ClassAttendanceHdr_lRec."Subject Code" := SubjectMasterRec."Subject Group";
            //         ClassAttendanceHdr_lRec."Subject Description" := SubjectMasterRec."Subject Group Description";
            //     end;
            // end;
            ClassAttendanceHdr_lRec."Subject Code" := FinalClassTimeTable_lRec."Subject Code";
            ClassAttendanceHdr_lRec."Subject Description" := FinalClassTimeTable_lRec."Subject Name";
            ClassAttendanceHdr_lRec."Batch Code" := FinalClassTimeTable_lRec.Batch;
            ClassAttendanceHdr_lRec."Attendance Date" := FinalClassTimeTable_lRec.Date;
            ClassAttendanceHdr_lRec."Time Table No" := FinalClassTimeTable_lRec."S.No.";
            ClassAttendanceHdr_lRec."Attendance By" := FinalClassTimeTable_lRec."Atttendance By";
            ClassAttendanceHdr_lRec."Room No." := FinalClassTimeTable_lRec."Room No";
            ClassAttendanceHdr_lRec."Time Slot" := FinalClassTimeTable_lRec."Time Slot Code";
            ClassAttendanceHdr_lRec.Year := FinalClassTimeTable_lRec.Year;
            ClassAttendanceHdr_lRec."Time Table Doc. No." := FinalClassTimeTable_lRec."Time Table  Document No.";
            ClassAttendanceHdr_lRec."Time Table Date" := FinalClassTimeTable_lRec.Date;
            ClassAttendanceHdr_lRec.Insert();
            // WebServiceFn.CreateTimeTableCalendar(FinalClassTimeTable_lRec);
            // AttendanceActionCS.AttendanceofStudentUpdated(ClassAttendanceHdr_lRec);
        end;

        // Until TimeTableLine_lRec.Next() = 0;

    End;

    Procedure ReGenerateFinalTimeTable(Rec: Record "Class Time Table Header-CS")
    var
        TimeTableLine1: Record "Class Time Table Line-CS";
        RecDate: Record Date;
        SubjectCOLLEGE: Record "Subject Master-CS";
        TimeTable: Record "Final Class Time Table-CS";
        TimeTable1: Record "Final Class Time Table-CS";
        TimeSlot: Record "Time Period-CS";
        SubjectDetail: Record "Subject Classification-CS";
        TimetableTemplateLine_lRec: Record "Time Table Template Line-CS";
        WebserviceFn: Codeunit WebServicesFunctionsCSL;
        LastNo: Integer;
        DayName_lTxt: Text;
        TimeTableDate: Date;
        TimeTableLineNo: Integer;
        I: Integer;
        StartDateFilter: Date;
        Txt002Lbl: Label 'The Time Table has been Generated for Document No. %1 .';
    Begin
        TimeTable.Reset();
        TimeTable.SetRange("Time Table  Document No.", Rec."No.");
        TimeTable.SetRange(Attendance, TimeTable.Attendance::"Not Marked");
        //IF TimeTable.FindSet() then
        TimeTable.DeleteAll(true);


        TimeTableLine1.RESET();
        TimeTableLine1.SETRANGE("Document No.", Rec."No.");
        TimeTableLine1.SetFilter("Start Date", '<>%1', 0D);
        TimeTableLine1.SETFILTER(Day, '<>%1', TimeTableLine1.Day::" ");
        IF TimeTableLine1.FINDSET() THEN begin
            REPEAT
                TimetableTemplateLine_lRec.Reset();
                TimetableTemplateLine_lRec.SetRange("Document No.", Rec."Template Code");
                TimetableTemplateLine_lRec.SetRange(Occurance, 0);
                If TimetableTemplateLine_lRec.FindFirst() then begin
                    IF TimetableDate <> TimeTableLine1."Start Date" then begin
                        DayName_lTxt := '';
                        DayName_lTxt := Format(TimeTableLine1.Day);
                        RecDate.RESET();
                        RecDate.SETRANGE("Period Type", RecDate."Period Type"::Date);
                        RecDate.SETRANGE("Period Start", TimeTableLine1."Start Date", TimeTableLine1."Start Date");
                        //RecDate.SetRange("Period Name", DayName_lTxt);
                        IF RecDate.FIND('-') THEN
                            REPEAT
                                // EduCalendarEntry.RESET();
                                // EduCalendarEntry.SETCURRENTKEY(Code, "Academic Year", Date);
                                // EduCalendarEntry.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                // EduCalendarEntry.SETRANGE("Academic Year", Rec."Academic Year");
                                // EduCalendarEntry.SETRANGE(Date, RecDate."Period Start");
                                // EduCalendarEntry.SETRANGE("Off Day", FALSE);
                                // EduCalendarEntry.SETRANGE(Holiday, FALSE);
                                // IF EduCalendarEntry.FINDFIRST() THEN BEGIN

                                SubjectCOLLEGE.RESET();
                                SubjectCOLLEGE.SETRANGE(Code, TimeTableLine1."Subject Code");
                                IF SubjectCOLLEGE.FINDSET() THEN
                                    REPEAT
                                        TimeTable.Reset();
                                        IF TimeTable.FindLast() then
                                            LastNo := TimeTable."S.No." + 1
                                        Else
                                            LastNo := 1;

                                        TimeTable.RESET();
                                        TimeTable.SETRANGE("Time Table  Document No.", Rec."No.");
                                        TimeTable.SetRange("Time Table Line No.", TimeTableLine1."Line No.");
                                        //TimeTable.SetRange("Time Table Line No.", TimeTableLine1."Line No.");
                                        Timetable.Setrange(Date, RecDate."Period Start");
                                        TimeTable.SetRange("Time Slot Code", TimeTableLine1."Time Slot");
                                        TimeTable.SetRange("Subject Group", TimeTableLine1."Subject Group");
                                        // If TimeTableLine1."Faculty 1 Code" <> '' then
                                        //     TimeTable.SetRange("Faculty 1Code", TimeTableLine1."Faculty 1 Code");
                                        TimeTable.SETFILTER(Batch, TimeTableLine1.Batch);
                                        TimeTable.SetRange("Room No", TimeTableLine1."Room No");
                                        TimeTable.SetFilter(Section, TimeTableLine1.Section);
                                        // TimeTable.SETRANGE("Subject Code", SubjectCOLLEGE."Code");
                                        //TimeTable.SETRANGE(Term,TimeTableLine1.Term);
                                        IF NOT TimeTable.FINDFIRST() THEN
                                            REPEAT
                                                TimeTable.INIT();
                                                TimeTable."S.No." := LastNo;
                                                TimeTable."Time Table  Document No." := Rec."No.";
                                                TimeTable."Time Table Line No." := TimeTableLine1."Line No.";
                                                TimeTable.Date := RecDate."Period Start";
                                                TimeTable."Time Slot Code" := TimeTableLine1."Time Slot";
                                                IF TimeSlot.GET(TimeTableLine1."Time Slot") THEN BEGIN
                                                    TimeTable."Start Time" := TimeSlot."Start Time";
                                                    TimeTable."End Time" := TimeSlot."End Time";
                                                END;
                                                TimeTable.Interval := TimeTableLine1.Interval;
                                                TimeTable."Interval Type" := TimeTableLine1."Interval Type";
                                                TimeTable."Room No" := TimeTableLine1."Room No";
                                                TimeTable.Year := Rec.Year;
                                                TimeTable.Batch := TimeTableLine1.Batch;
                                                TimeTable.Section := TimeTableLine1.Section;
                                                TimeTable."Subject Class" := TimeTableLine1."Subject Class";
                                                TimeTable."Subject Code" := TimeTableLine1."Subject Code";
                                                TimeTable."Subject Group" := TimeTableLine1."Subject Group";
                                                TimeTable."Subject Name" := TimeTableLine1."Subject Name";
                                                TimeTable."Topic Code" := TimeTableLine1."Topic Code";
                                                TimeTable."Topic Description" := TimeTableLine1."Topic Description";
                                                TimeTable.Semester := Rec.Semester;
                                                TimeTable."Course code" := Rec.Course;
                                                TimeTable."Course Name" := Rec."Course Name";
                                                TimeTable."Academic Code" := Rec."Academic Year";
                                                TimeTable.Term := Rec.Term;
                                                TimeTable."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                                TimeTable."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                                TimeTable."Faculty 1Code" := TimeTableLine1."Faculty 1 Code";
                                                TimeTable."Faculty 2 Code" := TimeTableLine1."Faculty 2 Code";
                                                TimeTable."Faculty 3 Code" := TimeTableLine1."Faculty 3 Code";
                                                TimeTable."Faculty 4 Code" := TimeTableLine1."Faculty 4 Code";
                                                TimeTable1.Reset();
                                                TimeTable1.SetRange(Date, TimeTable.Date);
                                                TimeTable1.SetRange("Time Slot Code", TimeTable."Time Slot Code");
                                                TimeTable1.SetRange(Section, TimeTable.Section);
                                                TimeTable1.SetRange("Room No", TimeTable."Room No");
                                                TimeTable1.SetRange("Subject Code", TimeTable."Subject Code");
                                                Timetable1.SetrangE("Time Table  Document No.", TimeTable."Time Table  Document No.");
                                                IF TimeTable1.FindFirst() then
                                                    TimeTable."S.No. Grouping" := TimeTableLine1."Line No.";
                                                IF Not TimeTable1.FindFirst() then
                                                    TimeTable."S.No. Grouping" := TimeTableLine1."Line No.";
                                                TimeTable.Updated := TRUE;
                                                TimeTable.INSERT(TRUE);
                                                TimeTableLine1."Final Time Table No." := TimeTableLine1."Line No.";
                                                TimeTableLineNo := TimeTableLine1."Line No.";
                                                TimeTableLine1.Modify();
                                            //WebServiceFn.CreateTimeTableCalendar(TimeTable);
                                            UNTIL TimeTable.NEXT() = 0;
                                    UNTIL SubjectCOLLEGE.NEXT() = 0;
                            //END;
                            UNTIL RecDate.NEXT() = 0;
                        TimetableDate := TimeTableLine1."Start Date";
                    end Else begin
                        TimeTableLine1."Final Time Table No." := TimeTableLineNo;
                        TimeTableLine1.Modify();
                    end;
                end;
                TimetableTemplateLine_lRec.Reset();
                TimetableTemplateLine_lRec.SetRange("Document No.", Rec."Template Code");
                TimetableTemplateLine_lRec.SetFilter(Occurance, '<>%1', 0);
                TimetableTemplateLine_lRec.SetRange("Time Slot", TimeTableLine1."Time Slot");
                TimetableTemplateLine_lRec.SetRange(Day, TimeTableLine1.Day);
                TimetableTemplateLine_lRec.SetRange("Subject Group", TimeTableLine1."Subject Group");
                TimetableTemplateLine_lRec.Setrange("Subject Class", TimeTableLine1."Subject Class");
                IF TimetableTemplateLine_lRec.FindSet() then begin
                    repeat
                        StartDateFilter := 0D;
                        For I := 1 to TimetableTemplateLine_lRec.Occurance do Begin
                            DayName_lTxt := '';
                            DayName_lTxt := Format(TimeTableLine1.Day);
                            If StartDateFilter = 0D then
                                StartDateFilter := TimeTableLine1."Start Date";
                            RecDate.RESET();
                            RecDate.SETRANGE("Period Type", RecDate."Period Type"::Date);
                            RecDate.SETRANGE("Period Start", StartDateFilter);
                            //RecDate.SetRange("Period Name", DayName_lTxt);
                            IF RecDate.FIND('-') THEN
                                REPEAT
                                    // EduCalendarEntry.RESET();
                                    // EduCalendarEntry.SETCURRENTKEY(Code, "Academic Year", Date);
                                    // EduCalendarEntry.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                    // EduCalendarEntry.SETRANGE("Academic Year", Rec."Academic Year");
                                    // EduCalendarEntry.SETRANGE(Date, RecDate."Period Start");
                                    // EduCalendarEntry.SETRANGE("Off Day", FALSE);
                                    // EduCalendarEntry.SETRANGE(Holiday, FALSE);
                                    // IF EduCalendarEntry.FINDFIRST() THEN BEGIN

                                    SubjectCOLLEGE.RESET();
                                    SubjectCOLLEGE.SETRANGE(Code, TimeTableLine1."Subject Code");
                                    IF SubjectCOLLEGE.FINDSET() THEN
                                        REPEAT
                                            TimeTable.Reset();
                                            IF TimeTable.FindLast() then
                                                LastNo := TimeTable."S.No." + 1
                                            Else
                                                LastNo := 1;

                                            TimeTable.RESET();
                                            TimeTable.SETRANGE("Time Table  Document No.", Rec."No.");
                                            //TimeTable.SetRange("Time Table Line No.", TimeTableLine1."Line No.");
                                            Timetable.Setrange(Date, RecDate."Period Start");
                                            TimeTable.SetRange("Time Slot Code", TimeTableLine1."Time Slot");
                                            TimeTable.SetRange("Subject Group", TimeTableLine1."Subject Group");
                                            // If TimeTableLine1."Faculty 1 Code" <> '' then
                                            //     TimeTable.SetRange("Faculty 1Code", TimeTableLine1."Faculty 1 Code");
                                            TimeTable.SETFILTER(Batch, TimeTableLine1.Batch);
                                            TimeTable.SetRange("Room No", TimeTableLine1."Room No");
                                            TimeTable.SetFilter(Section, TimeTableLine1.Section);
                                            // TimeTable.SETRANGE("Subject Code", SubjectCOLLEGE."Code");
                                            //TimeTable.SETRANGE(Term,TimeTableLine1.Term);
                                            IF NOT TimeTable.FINDFIRST() THEN
                                                REPEAT
                                                    TimeTable.INIT();
                                                    TimeTable."S.No." := LastNo;
                                                    TimeTable."Time Table  Document No." := Rec."No.";
                                                    TimeTable."Time Table Line No." := TimeTableLine1."Line No.";
                                                    TimeTable.Date := RecDate."Period Start";
                                                    TimeTable."Time Slot Code" := TimeTableLine1."Time Slot";
                                                    IF TimeSlot.GET(TimeTableLine1."Time Slot") THEN BEGIN
                                                        TimeTable."Start Time" := TimeSlot."Start Time";
                                                        TimeTable."End Time" := TimeSlot."End Time";
                                                    END;
                                                    TimeTable.Interval := TimeTableLine1.Interval;
                                                    TimeTable."Interval Type" := TimeTableLine1."Interval Type";
                                                    TimeTable."Room No" := TimeTableLine1."Room No";
                                                    TimeTable.Year := Rec.Year;
                                                    TimeTable.Batch := TimeTableLine1.Batch;
                                                    TimeTable.Section := TimeTableLine1.Section;
                                                    TimeTable."Subject Class" := TimeTableLine1."Subject Class";
                                                    TimeTable."Subject Code" := TimeTableLine1."Subject Code";
                                                    TimeTable."Subject Group" := TimeTableLine1."Subject Group";
                                                    TimeTable."Subject Name" := TimeTableLine1."Subject Name";
                                                    TimeTable."Topic Code" := TimeTableLine1."Topic Code";
                                                    TimeTable."Topic Description" := TimeTableLine1."Topic Description";
                                                    TimeTable.Semester := Rec.Semester;
                                                    TimeTable."Course code" := Rec.Course;
                                                    TimeTable."Course Name" := Rec."Course Name";
                                                    TimeTable."Academic Code" := Rec."Academic Year";
                                                    TimeTable.Term := Rec.Term;
                                                    TimeTable."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                                    TimeTable."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                                    TimeTable."Faculty 1Code" := TimeTableLine1."Faculty 1 Code";
                                                    TimeTable."Faculty 2 Code" := TimeTableLine1."Faculty 2 Code";
                                                    TimeTable."Faculty 3 Code" := TimeTableLine1."Faculty 3 Code";
                                                    TimeTable."Faculty 4 Code" := TimeTableLine1."Faculty 4 Code";
                                                    TimeTable1.Reset();
                                                    TimeTable1.SetRange(Date, TimeTable.Date);
                                                    TimeTable1.SetRange("Time Slot Code", TimeTable."Time Slot Code");
                                                    TimeTable1.SetRange(Section, TimeTable.Section);
                                                    TimeTable1.SetRange("Room No", TimeTable."Room No");
                                                    TimeTable1.SetRange("Subject Code", TimeTable."Subject Code");
                                                    Timetable1.SetrangE("Time Table  Document No.", TimeTable."Time Table  Document No.");
                                                    IF TimeTable1.FindFirst() then
                                                        TimeTable."S.No. Grouping" := TimeTableLine1."Line No.";
                                                    IF Not TimeTable1.FindFirst() then
                                                        TimeTable."S.No. Grouping" := TimeTableLine1."Line No.";
                                                    TimeTable.Updated := TRUE;
                                                    TimeTable.INSERT(TRUE);
                                                    TimeTableLine1."Final Time Table No." := TimeTableLine1."Line No.";
                                                    TimeTableLineNo := TimeTableLine1."Line No.";
                                                    TimeTableLine1.Modify();
                                                //WebServiceFn.CreateTimeTableCalendar(TimeTable);
                                                UNTIL TimeTable.NEXT() = 0;
                                        UNTIL SubjectCOLLEGE.NEXT() = 0;
                                //END;
                                UNTIL RecDate.NEXT() = 0;
                            If StartDateFilter <> 0D then begin
                                RecDate.Reset();
                                RecDate.SetRange("Period Type", RecDate."Period Type"::Date);
                                RecDate.SetFilter("Period Start", '>%1', StartDateFilter);
                                RecDate.SetRange("Period Name", DayName_lTxt);
                                If RecDate.FindFirst() then
                                    StartDateFilter := RecDate."Period Start";
                            end;
                        end;

                    until TimetableTemplateLine_lRec.Next() = 0;
                end;
            UNTIL TimeTableLine1.NEXT() = 0;

            Rec."Time Table Status" := Rec."Time Table Status"::Generated;
            Rec.MODIFY();

            Message(Txt002Lbl, "No.");


            If Confirm('Do you want to generate Student Attendance.?', true) then begin
                TimeTable.Reset();
                TimeTable.SetRange("Time Table  Document No.", Rec."No.");
                IF TimeTable.FindSet() then begin
                    repeat
                        SubjectDetail.Reset();
                        SubjectDetail.SetRange(Code, TimeTable."Subject Class");
                        IF SubjectDetail.FindFirst() then
                            If not SubjectDetail."Attendance Not Applicable" then
                                AttendanceGeneratedforStudents(TimeTable);
                    until TimeTable.Next() = 0;

                    Message('Student Attendance has been generated.');
                end;

            end;


        end;
    End;

    procedure CheckFinalTimeTable(Rec: Record "Class Time Table Header-CS")
    var
        TimeTableLine1: Record "Class Time Table Line-CS";
        TimeTableLine: Record "Class Time Table Line-CS";
        RecDate: Record Date;
        SubjectCOLLEGE: Record "Subject Master-CS";
        TimeTable: Record "Final Class Time Table-CS";
        TimeTable1: Record "Final Class Time Table-CS";
        TimeSlot: Record "Time Period-CS";
        SubjectDetail: Record "Subject Classification-CS";
        TimetableTemplateLine_lRec: Record "Time Table Template Line-CS";
        LastNo: Integer;
        DayName_lTxt: Text;
        TimeTableDate: Date;
        TimeTableLineNo: Integer;
        I: Integer;
        StartDateFilter: Date;
    Begin
        TimeTableLine.Reset();
        TimeTableLine.SetRange("Document No.", Rec."No.");
        IF TimeTableLine.FindSet() then begin
            repeat
                TimeTableLine1.Reset();
                TimeTableLine1.SetRange("Document No.", TimeTableLine."Document No.");
                TimeTableLine1.SetRange("Time Slot", TimeTableLine."Time Slot");
                TimeTableLine1.SetRange(Day, TimeTableLine.Day);
                TimeTableLine1.SetRange("Room No", TimeTableLine."Room No");
                TimeTableLine1.SetRange("Start Date", TimeTableLine."Start Date");
                IF TimeTableLine1.Count() >= 2 then
                    Error('Time Slot : %1 , Day : %2 , Room No. : %3 , Start Date : %4 is already used.', TimeTableLine."Time Slot", TimeTableLine.Day, TimeTableLine."Room No", TimeTableLine."Start Date");
            until TimeTableLine.Next() = 0;
        end;

        TimeTable.Reset();
        TimeTable.SetRange("Time Table  Document No.", Rec."No.");
        TimeTable.SetRange(Attendance, TimeTable.Attendance::"Not Marked");
        //IF TimeTable.FindSet() then
        TimeTable.DeleteAll(true);


        TimeTableLine1.RESET();
        TimeTableLine1.SETRANGE("Document No.", Rec."No.");
        TimeTableLine1.SetFilter("Start Date", '<>%1', 0D);
        TimeTableLine1.SETFILTER(Day, '<>%1', TimeTableLine1.Day::" ");
        IF TimeTableLine1.FINDSET() THEN begin
            REPEAT
                TimetableTemplateLine_lRec.Reset();
                TimetableTemplateLine_lRec.SetRange("Document No.", Rec."Template Code");
                TimetableTemplateLine_lRec.SetRange(Occurance, 0);
                If TimetableTemplateLine_lRec.FindFirst() then begin
                    IF TimetableDate <> TimeTableLine1."Start Date" then begin
                        DayName_lTxt := '';
                        DayName_lTxt := Format(TimeTableLine1.Day);
                        RecDate.RESET();
                        RecDate.SETRANGE("Period Type", RecDate."Period Type"::Date);
                        RecDate.SETRANGE("Period Start", TimeTableLine1."Start Date", TimeTableLine1."Start Date");
                        //RecDate.SetRange("Period Name", DayName_lTxt);
                        IF RecDate.FIND('-') THEN
                            REPEAT
                                // EduCalendarEntry.RESET();
                                // EduCalendarEntry.SETCURRENTKEY(Code, "Academic Year", Date);
                                // EduCalendarEntry.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                // EduCalendarEntry.SETRANGE("Academic Year", Rec."Academic Year");
                                // EduCalendarEntry.SETRANGE(Date, RecDate."Period Start");
                                // EduCalendarEntry.SETRANGE("Off Day", FALSE);
                                // EduCalendarEntry.SETRANGE(Holiday, FALSE);
                                // IF EduCalendarEntry.FINDFIRST() THEN BEGIN

                                SubjectCOLLEGE.RESET();
                                SubjectCOLLEGE.SETRANGE(Code, TimeTableLine1."Subject Code");
                                IF SubjectCOLLEGE.FINDSET() THEN
                                    REPEAT
                                        TimeTable.Reset();
                                        IF TimeTable.FindLast() then
                                            LastNo := TimeTable."S.No." + 1
                                        Else
                                            LastNo := 1;

                                        TimeTable.RESET();
                                        TimeTable.SETRANGE("Time Table  Document No.", Rec."No.");
                                        TimeTable.SetRange("Time Table Line No.", TimeTableLine1."Line No.");
                                        //TimeTable.SetRange("Time Table Line No.", TimeTableLine1."Line No.");
                                        Timetable.Setrange(Date, RecDate."Period Start");
                                        TimeTable.SetRange("Time Slot Code", TimeTableLine1."Time Slot");
                                        TimeTable.SetRange("Subject Group", TimeTableLine1."Subject Group");
                                        // If TimeTableLine1."Faculty 1 Code" <> '' then
                                        //     TimeTable.SetRange("Faculty 1Code", TimeTableLine1."Faculty 1 Code");
                                        TimeTable.SETFILTER(Batch, TimeTableLine1.Batch);
                                        TimeTable.SetRange("Room No", TimeTableLine1."Room No");
                                        TimeTable.SetFilter(Section, TimeTableLine1.Section);
                                        // TimeTable.SETRANGE("Subject Code", SubjectCOLLEGE."Code");
                                        //TimeTable.SETRANGE(Term,TimeTableLine1.Term);
                                        IF NOT TimeTable.FINDFIRST() THEN
                                            REPEAT
                                                TimeTable.INIT();
                                                TimeTable."S.No." := LastNo;
                                                TimeTable."Time Table  Document No." := Rec."No.";
                                                TimeTable."Time Table Line No." := TimeTableLine1."Line No.";
                                                TimeTable.Date := RecDate."Period Start";
                                                TimeTable."Time Slot Code" := TimeTableLine1."Time Slot";
                                                IF TimeSlot.GET(TimeTableLine1."Time Slot") THEN BEGIN
                                                    TimeTable."Start Time" := TimeSlot."Start Time";
                                                    TimeTable."End Time" := TimeSlot."End Time";
                                                END;
                                                TimeTable.Interval := TimeTableLine1.Interval;
                                                TimeTable."Interval Type" := TimeTableLine1."Interval Type";
                                                TimeTable."Room No" := TimeTableLine1."Room No";
                                                TimeTable.Year := Rec.Year;
                                                TimeTable.Batch := TimeTableLine1.Batch;
                                                TimeTable.Section := TimeTableLine1.Section;
                                                TimeTable."Subject Class" := TimeTableLine1."Subject Class";
                                                TimeTable."Subject Code" := TimeTableLine1."Subject Code";
                                                TimeTable."Subject Group" := TimeTableLine1."Subject Group";
                                                TimeTable."Subject Name" := TimeTableLine1."Subject Name";
                                                TimeTable."Topic Code" := TimeTableLine1."Topic Code";
                                                TimeTable."Topic Description" := TimeTableLine1."Topic Description";
                                                TimeTable.Semester := Rec.Semester;
                                                TimeTable."Course code" := Rec.Course;
                                                TimeTable."Course Name" := Rec."Course Name";
                                                TimeTable."Academic Code" := Rec."Academic Year";
                                                TimeTable.Term := Rec.Term;
                                                TimeTable."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                                TimeTable."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                                TimeTable."Faculty 1Code" := TimeTableLine1."Faculty 1 Code";
                                                TimeTable."Faculty 2 Code" := TimeTableLine1."Faculty 2 Code";
                                                TimeTable."Faculty 3 Code" := TimeTableLine1."Faculty 3 Code";
                                                TimeTable."Faculty 4 Code" := TimeTableLine1."Faculty 4 Code";
                                                TimeTable1.Reset();
                                                TimeTable1.SetRange(Date, TimeTable.Date);
                                                TimeTable1.SetRange("Time Slot Code", TimeTable."Time Slot Code");
                                                TimeTable1.SetRange(Section, TimeTable.Section);
                                                TimeTable1.SetRange("Room No", TimeTable."Room No");
                                                TimeTable1.SetRange("Subject Code", TimeTable."Subject Code");
                                                Timetable1.SetrangE("Time Table  Document No.", TimeTable."Time Table  Document No.");
                                                IF TimeTable1.FindFirst() then
                                                    TimeTable."S.No. Grouping" := TimeTableLine1."Line No.";
                                                IF Not TimeTable1.FindFirst() then
                                                    TimeTable."S.No. Grouping" := TimeTableLine1."Line No.";
                                                TimeTable.Updated := TRUE;
                                                TimeTable.INSERT(TRUE);
                                                TimeTableLine1."Final Time Table No." := TimeTableLine1."Line No.";
                                                TimeTableLineNo := TimeTableLine1."Line No.";
                                                TimeTableLine1.Modify();
                                            UNTIL TimeTable.NEXT() = 0;
                                    UNTIL SubjectCOLLEGE.NEXT() = 0;
                            //END;
                            UNTIL RecDate.NEXT() = 0;
                        TimetableDate := TimeTableLine1."Start Date";
                    end Else begin
                        TimeTableLine1."Final Time Table No." := TimeTableLineNo;
                        TimeTableLine1.Modify();
                    end;
                end;
                TimetableTemplateLine_lRec.Reset();
                TimetableTemplateLine_lRec.SetRange("Document No.", Rec."Template Code");
                TimetableTemplateLine_lRec.SetFilter(Occurance, '<>%1', 0);
                TimetableTemplateLine_lRec.SetRange("Time Slot", TimeTableLine1."Time Slot");
                TimetableTemplateLine_lRec.SetRange(Day, TimeTableLine1.Day);
                TimetableTemplateLine_lRec.SetRange("Subject Group", TimeTableLine1."Subject Group");
                TimetableTemplateLine_lRec.Setrange("Subject Class", TimeTableLine1."Subject Class");
                IF TimetableTemplateLine_lRec.FindSet() then begin
                    repeat
                        StartDateFilter := 0D;
                        For I := 1 to TimetableTemplateLine_lRec.Occurance do Begin
                            DayName_lTxt := '';
                            DayName_lTxt := Format(TimeTableLine1.Day);
                            If StartDateFilter = 0D then
                                StartDateFilter := TimeTableLine1."Start Date";
                            RecDate.RESET();
                            RecDate.SETRANGE("Period Type", RecDate."Period Type"::Date);
                            RecDate.SETRANGE("Period Start", StartDateFilter);
                            //RecDate.SetRange("Period Name", DayName_lTxt);
                            IF RecDate.FIND('-') THEN
                                REPEAT
                                    // EduCalendarEntry.RESET();
                                    // EduCalendarEntry.SETCURRENTKEY(Code, "Academic Year", Date);
                                    // EduCalendarEntry.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                    // EduCalendarEntry.SETRANGE("Academic Year", Rec."Academic Year");
                                    // EduCalendarEntry.SETRANGE(Date, RecDate."Period Start");
                                    // EduCalendarEntry.SETRANGE("Off Day", FALSE);
                                    // EduCalendarEntry.SETRANGE(Holiday, FALSE);
                                    // IF EduCalendarEntry.FINDFIRST() THEN BEGIN

                                    SubjectCOLLEGE.RESET();
                                    SubjectCOLLEGE.SETRANGE(Code, TimeTableLine1."Subject Code");
                                    IF SubjectCOLLEGE.FINDSET() THEN
                                        REPEAT
                                            TimeTable.Reset();
                                            IF TimeTable.FindLast() then
                                                LastNo := TimeTable."S.No." + 1
                                            Else
                                                LastNo := 1;

                                            TimeTable.RESET();
                                            TimeTable.SETRANGE("Time Table  Document No.", Rec."No.");
                                            //TimeTable.SetRange("Time Table Line No.", TimeTableLine1."Line No.");
                                            Timetable.Setrange(Date, RecDate."Period Start");
                                            TimeTable.SetRange("Time Slot Code", TimeTableLine1."Time Slot");
                                            TimeTable.SetRange("Subject Group", TimeTableLine1."Subject Group");
                                            // If TimeTableLine1."Faculty 1 Code" <> '' then
                                            //     TimeTable.SetRange("Faculty 1Code", TimeTableLine1."Faculty 1 Code");
                                            TimeTable.SETFILTER(Batch, TimeTableLine1.Batch);
                                            TimeTable.SetRange("Room No", TimeTableLine1."Room No");
                                            TimeTable.SetFilter(Section, TimeTableLine1.Section);
                                            // TimeTable.SETRANGE("Subject Code", SubjectCOLLEGE."Code");
                                            //TimeTable.SETRANGE(Term,TimeTableLine1.Term);
                                            IF NOT TimeTable.FINDFIRST() THEN
                                                REPEAT
                                                    TimeTable.INIT();
                                                    TimeTable."S.No." := LastNo;
                                                    TimeTable."Time Table  Document No." := Rec."No.";
                                                    TimeTable."Time Table Line No." := TimeTableLine1."Line No.";
                                                    TimeTable.Date := RecDate."Period Start";
                                                    TimeTable."Time Slot Code" := TimeTableLine1."Time Slot";
                                                    IF TimeSlot.GET(TimeTableLine1."Time Slot") THEN BEGIN
                                                        TimeTable."Start Time" := TimeSlot."Start Time";
                                                        TimeTable."End Time" := TimeSlot."End Time";
                                                    END;
                                                    TimeTable.Interval := TimeTableLine1.Interval;
                                                    TimeTable."Interval Type" := TimeTableLine1."Interval Type";
                                                    TimeTable."Room No" := TimeTableLine1."Room No";
                                                    TimeTable.Year := Rec.Year;
                                                    TimeTable.Batch := TimeTableLine1.Batch;
                                                    TimeTable.Section := TimeTableLine1.Section;
                                                    TimeTable."Subject Class" := TimeTableLine1."Subject Class";
                                                    TimeTable."Subject Code" := TimeTableLine1."Subject Code";
                                                    TimeTable."Subject Group" := TimeTableLine1."Subject Group";
                                                    TimeTable."Subject Name" := TimeTableLine1."Subject Name";
                                                    TimeTable."Topic Code" := TimeTableLine1."Topic Code";
                                                    TimeTable."Topic Description" := TimeTableLine1."Topic Description";
                                                    TimeTable.Semester := Rec.Semester;
                                                    TimeTable."Course code" := Rec.Course;
                                                    TimeTable."Course Name" := Rec."Course Name";
                                                    TimeTable."Academic Code" := Rec."Academic Year";
                                                    TimeTable.Term := Rec.Term;
                                                    TimeTable."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                                    TimeTable."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                                    TimeTable."Faculty 1Code" := TimeTableLine1."Faculty 1 Code";
                                                    TimeTable."Faculty 2 Code" := TimeTableLine1."Faculty 2 Code";
                                                    TimeTable."Faculty 3 Code" := TimeTableLine1."Faculty 3 Code";
                                                    TimeTable."Faculty 4 Code" := TimeTableLine1."Faculty 4 Code";
                                                    TimeTable1.Reset();
                                                    TimeTable1.SetRange(Date, TimeTable.Date);
                                                    TimeTable1.SetRange("Time Slot Code", TimeTable."Time Slot Code");
                                                    TimeTable1.SetRange(Section, TimeTable.Section);
                                                    TimeTable1.SetRange("Room No", TimeTable."Room No");
                                                    TimeTable1.SetRange("Subject Code", TimeTable."Subject Code");
                                                    Timetable1.SetrangE("Time Table  Document No.", TimeTable."Time Table  Document No.");
                                                    IF TimeTable1.FindFirst() then
                                                        TimeTable."S.No. Grouping" := TimeTableLine1."Line No.";
                                                    IF Not TimeTable1.FindFirst() then
                                                        TimeTable."S.No. Grouping" := TimeTableLine1."Line No.";
                                                    TimeTable.Updated := TRUE;
                                                    TimeTable.INSERT(TRUE);
                                                    TimeTableLine1."Final Time Table No." := TimeTableLine1."Line No.";
                                                    TimeTableLineNo := TimeTableLine1."Line No.";
                                                    TimeTableLine1.Modify();
                                                UNTIL TimeTable.NEXT() = 0;
                                        UNTIL SubjectCOLLEGE.NEXT() = 0;
                                //END;
                                UNTIL RecDate.NEXT() = 0;
                            If StartDateFilter <> 0D then begin
                                RecDate.Reset();
                                RecDate.SetRange("Period Type", RecDate."Period Type"::Date);
                                RecDate.SetFilter("Period Start", '>%1', StartDateFilter);
                                RecDate.SetRange("Period Name", DayName_lTxt);
                                If RecDate.FindFirst() then
                                    StartDateFilter := RecDate."Period Start";
                            end;
                        end;

                    until TimetableTemplateLine_lRec.Next() = 0;
                end;
            UNTIL TimeTableLine1.NEXT() = 0;
        end;

        TimeTable.Reset();
        TimeTable.SetRange("Time Table  Document No.", Rec."No.");
        IF TimeTable.FindSet() then begin
            repeat
                TimeTable1.Reset();
                TimeTable1.SetRange(Section, TimeTable.Section);
                TimeTable1.SetRange(Date, TimeTable.Date);
                TimeTable1.SetRange("Time Slot Code", TimeTable."Time Slot Code");
                TimeTable1.SetRange("Course code", TimeTable."Course code");
                TimeTable1.SetRange("Academic Code", TimeTable."Academic Code");
                TimeTable1.SetRange(Semester, TimeTable.Semester);
                TimeTable1.SetRange("Global Dimension 1 Code", TimeTable."Global Dimension 1 Code");
                TimeTable1.SetRange(Term, TimeTable.Term);
                IF TimeTable1.Count() >= 2 then
                    Error('Section : %1 , Date : %2 , Time Slot : %3 , Course Code : %4 , Academic Year : %5 , Semester : %6 , Institute Code : %7 , Term : %8 is already exist.', TimeTable.Section, TimeTable.Date, TimeTable."Time Slot Code", TimeTable."Course code", TimeTable."Academic Code", TimeTable.Semester, TimeTable."Global Dimension 1 Code", FormaT(TimeTable.Term));
            until TimeTable.Next() = 0;
        end;
    End;

    Procedure AUATimeTableLineInsert(Rec: Record "Class Time Table Header-CS")
    Var
        TimeTableTemplateHdr_lRec: Record "Time Table Template Head-CS";
        SubjectMaster_lRec: Record "Subject Master-CS";
        TimeTableTemplateLineCS_lRec: Record "Time Table Template Line-CS";
        TimeTableTemplateLineCS_lRec1: Record "Time Table Template Line-CS";
        Date_lRec: Record Date;
        SubjectWiseFaculty: Record "Subject Faculty Category";
        Employee_lRec: Record Employee;
        SubjectClassFound: Boolean;
        LineNo: Integer;
        TemplateLineCount: Integer;
        LineCount: Integer;
        StartDate: Date;
        StartDate1: Date;
        I: Integer;
        J: Integer;
        SubjectClassFilter: Text;
    Begin
        EducationSetupCS.RESET();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF EducationSetupCS.FINDFIRST() THEN //BEGIN
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                EducationMultiEventCalCS.RESET();
                EducationMultiEventCalCS.SETRANGE("Event Code", 'SPRING');
                EducationMultiEventCalCS.SETRANGE("Academic Year", "Academic Year");
                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                    FacultyStartDate := EducationMultiEventCalCS."Start Date";
                    FacultyEndDate := EducationMultiEventCalCS."Revised End Date"
                END;
            END ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'FALL');
                    EducationMultiEventCalCS.SETRANGE("Academic Year", "Academic Year");
                    IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                        FacultyStartDate := EducationMultiEventCalCS."Start Date";
                        FacultyEndDate := EducationMultiEventCalCS."Revised End Date";
                    END;
                END;


        TimeTableTemplateHdr_lRec.Reset();
        TimeTableTemplateHdr_lRec.SetRange("No.", Rec."Template Code");
        If TimeTableTemplateHdr_lRec.FindFirst() then begin
            IF TimeTableTemplateHdr_lRec."With Topic Code" then begin
                TimeTableTemplateLineCS_lRec1.Reset();
                TimeTableTemplateLineCS_lRec1.SetCurrentKey("Subject Class");
                TimeTableTemplateLineCS_lRec1.SetRange("Document No.", TimeTableTemplateHdr_lRec."No.");
                IF TimeTableTemplateLineCS_lRec1.FindSet() then begin
                    repeat
                        If SubjectClassFilter <> TimeTableTemplateLineCS_lRec1."Subject Class" then begin
                            SubjectClassFilter := TimeTableTemplateLineCS_lRec1."Subject Class";
                            SubjectMaster_lRec.Reset();
                            SubjectMaster_lRec.SetRange("Subject Group", Rec."Level 1 Subject Code");
                            SubjectMaster_lRec.SetRange("Level Description", SubjectMaster_lRec."Level Description"::"Level 2 Systems");
                            SubjectMaster_lRec.SetRange(Level, 2);
                            If SubjectMaster_lRec.FindSet() then begin
                                repeat
                                    LineCount := 0;
                                    LineNo := 0;
                                    SubjectMasterRec.Reset();
                                    SubjectMasterRec.SetCurrentKey("Subject Sequence");
                                    SubjectMasterRec.SetRange("Subject Group", SubjectMaster_lRec.Code);
                                    SubjectMasterRec.SetRange("Level Description", SubjectMasterRec."Level Description"::"Level 3 Topics");
                                    SubjectMasterRec.SetRange(Level, 3);
                                    SubjectMasterRec.SetRange("Subject Classification", TimeTableTemplateLineCS_lRec1."Subject Class");
                                    IF SubjectMasterRec.FindFirst() then begin
                                        //If SubjectClassFound then begin
                                        repeat

                                            TimeTableTemplateLineCS.Reset();
                                            TimeTableTemplateLineCS.SetRange("Document No.", Rec."Template Code");
                                            TimeTableTemplateLineCS.SetRange("Template Name", Rec."Template Name");
                                            TimeTableTemplateLineCS.SetRange("Subject Class", TimeTableTemplateLineCS_lRec1."Subject Class");
                                            TimeTableTemplateLineCS.SetFilter("Line No.", '>%1', LineNo);
                                            If TimeTableTemplateLineCS.FindFirst() then begin

                                                LineCount += 1;
                                                LineNo := TimeTableTemplateLineCS."Line No.";
                                                ClassTimeTableLineCS.INIT();
                                                ClassTimeTableLineCS."Document No." := "No.";
                                                ClassTimeTableLineCS."Line No." += 10000;
                                                ClassTimeTableLineCS.Validate("Time Slot", TimeTableTemplateLineCS."Time Slot");
                                                ClassTimeTableLineCS."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                                ClassTimeTableLineCS."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                                ClassTimeTableLineCS.Day := TimeTableTemplateLineCS.Day;
                                                ClassTimeTableLineCS.Interval := TimeTableTemplateLineCS.Interval;
                                                ClassTimeTableLineCS."Interval Type" := TimeTableTemplateLineCS."Interval Type";
                                                ClassTimeTableLineCS."Subject Group" := TimeTableTemplateLineCS."Subject Group";
                                                ClassTimeTableLineCS.Validate("Subject Class", TimeTableTemplateLineCS."Subject Class");
                                                ClassTimeTableLineCS."Subject Code" := SubjectMaster_lRec.Code;
                                                ClassTimeTableLineCS."Subject Name" := SubjectMaster_lRec.Description;
                                                ClassTimeTableLineCS."Topic Code" := SubjectMasterRec.Code;
                                                ClassTimeTableLineCS."Topic Description" := SubjectMasterRec.Description;
                                                SubjectWiseFaculty.Reset();
                                                SubjectWiseFaculty.SetRange("Subject Code", SubjectMasterRec.Code);
                                                IF SubjectWiseFaculty.FindFirst() then begin
                                                    ClassTimeTableLineCS."Subject Category" := SubjectWiseFaculty."Category Code";

                                                    Employee_lRec.Reset();
                                                    Employee_lRec.SetRange("Faculty Category", SubjectWiseFaculty."Category Code");
                                                    IF Employee_lRec.FindFirst() then begin
                                                        ClassTimeTableLineCS."Faculty 1 Code" := Employee_lRec."No.";
                                                        ClassTimeTableLineCS."Faculty 1 Name" := Employee_lRec."First Name" + ' ' + Employee_lRec."Last Name";
                                                    end;
                                                end;
                                                //ClassTimeTableLineCS."Room No" := "Room No.";
                                                ClassTimeTableLineCS.Section := TimeTableTemplateLineCS.Section;
                                                ClassTimeTableLineCS.Elective := TimeTableTemplateLineCS.Elective;
                                                ClassTimeTableLineCS.Term := Rec.Term;

                                                //ClassTimeTableLineCS."Start Date" := StartDate;



                                                IF ClassTimeTableLineCS.Interval = FALSE THEN BEGIN
                                                    ClassTimeTableLineCS."Faculty 1 Start Date" := FacultyStartDate;
                                                    ClassTimeTableLineCS."Faculty 1 End Date" := FacultyEndDate;
                                                END;
                                                ClassTimeTableLineCS.INSERT();

                                                TemplateLineCount := 0;
                                                TimeTableTemplateLineCS_lRec.Reset();
                                                TimeTableTemplateLineCS_lRec.SetRange("Document No.", Rec."Template Code");
                                                TimeTableTemplateLineCS_lRec.SetRange("Subject Class", TimeTableTemplateLineCS_lRec1."Subject Class");
                                                TemplateLineCount := TimeTableTemplateLineCS_lRec.Count();
                                                If LineCount = TemplateLineCount then begin
                                                    LineNo := 0;
                                                    LineCount := 0;

                                                end;

                                            end;
                                        until SubjectMasterRec.Next() = 0;
                                        //StartDate += 1;
                                    end;

                                    SubjectMasterRec.Reset();
                                    SubjectMasterRec.SetRange("Subject Group", SubjectMaster_lRec.Code);
                                    SubjectMasterRec.SetRange("Level Description", SubjectMasterRec."Level Description"::"Level 3 Topics");
                                    SubjectMasterRec.SetRange(Level, 3);
                                    SubjectMasterRec.SetRange("Subject Classification", 'SMALL GROUP');
                                    IF SubjectMasterRec.FindFirst() then begin
                                        // StartDate1 := 0D;
                                        // StartDate1 := Rec."Start Date";

                                        //If SubjectClassFound then begin
                                        repeat
                                            TimeTableTemplateLineCS.Reset();
                                            TimeTableTemplateLineCS.SetRange("Document No.", Rec."Template Code");
                                            TimeTableTemplateLineCS.SetRange("Template Name", Rec."Template Name");
                                            TimeTableTemplateLineCS.SetRange("Subject Class", SubjectMasterRec."Subject Classification");
                                            //TimeTableTemplateLineCS.SetFilter("Line No.", '>%1', LineNo);
                                            If TimeTableTemplateLineCS.FindSet() then begin
                                                repeat


                                                    LineCount += 1;
                                                    LineNo := TimeTableTemplateLineCS."Line No.";
                                                    ClassTimeTableLineCS.INIT();
                                                    ClassTimeTableLineCS."Document No." := "No.";
                                                    ClassTimeTableLineCS."Line No." += 10000;
                                                    ClassTimeTableLineCS.Validate("Time Slot", TimeTableTemplateLineCS."Time Slot");
                                                    ClassTimeTableLineCS."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                                    ClassTimeTableLineCS."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                                    ClassTimeTableLineCS.Day := TimeTableTemplateLineCS.Day;
                                                    ClassTimeTableLineCS.Interval := TimeTableTemplateLineCS.Interval;
                                                    ClassTimeTableLineCS."Interval Type" := TimeTableTemplateLineCS."Interval Type";
                                                    ClassTimeTableLineCS."Subject Group" := TimeTableTemplateLineCS."Subject Group";
                                                    ClassTimeTableLineCS.Validate("Subject Class", TimeTableTemplateLineCS."Subject Class");
                                                    ClassTimeTableLineCS."Subject Code" := SubjectMaster_lRec.Code;
                                                    ClassTimeTableLineCS."Subject Name" := SubjectMaster_lRec.Description;
                                                    ClassTimeTableLineCS."Topic Code" := SubjectMasterRec.Code;
                                                    ClassTimeTableLineCS."Topic Description" := SubjectMasterRec.Description;
                                                    SubjectWiseFaculty.Reset();
                                                    SubjectWiseFaculty.SetRange("Subject Code", SubjectMasterRec.Code);
                                                    IF SubjectWiseFaculty.FindFirst() then begin
                                                        ClassTimeTableLineCS."Subject Category" := SubjectWiseFaculty."Category Code";

                                                        Employee_lRec.Reset();
                                                        Employee_lRec.SetRange("Faculty Category", SubjectWiseFaculty."Category Code");
                                                        // Employee_lRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                                        IF Employee_lRec.FindFirst() then begin
                                                            ClassTimeTableLineCS."Faculty 1 Code" := Employee_lRec."No.";
                                                            ClassTimeTableLineCS."Faculty 1 Name" := Employee_lRec."First Name" + ' ' + Employee_lRec."Last Name";
                                                        end;
                                                    end;
                                                    //ClassTimeTableLineCS."Room No" := "Room No.";
                                                    //ClassTimeTableLineCS."Start Date" := StartDate1;
                                                    ClassTimeTableLineCS.Section := TimeTableTemplateLineCS.Section;
                                                    ClassTimeTableLineCS.Elective := TimeTableTemplateLineCS.Elective;
                                                    ClassTimeTableLineCS.Term := Rec.Term;




                                                    IF ClassTimeTableLineCS.Interval = FALSE THEN BEGIN
                                                        ClassTimeTableLineCS."Faculty 1 Start Date" := FacultyStartDate;
                                                        ClassTimeTableLineCS."Faculty 1 End Date" := FacultyEndDate;
                                                    END;
                                                    ClassTimeTableLineCS.Insert();

                                                    TemplateLineCount := 0;
                                                    TimeTableTemplateLineCS_lRec.Reset();
                                                    TimeTableTemplateLineCS_lRec.SetRange("Document No.", Rec."Template Code");
                                                    TimeTableTemplateLineCS_lRec.SetRange("Template Name", Rec."Template Name");
                                                    TimeTableTemplateLineCS_lRec.SetRange("Subject Class", Rec."Template Name");
                                                    TemplateLineCount := TimeTableTemplateLineCS_lRec.Count();
                                                    If LineCount = TemplateLineCount then begin
                                                        LineNo := 0;
                                                        LineCount := 0;
                                                    end;
                                                until TimeTableTemplateLineCS.Next() = 0;

                                            end;
                                        until SubjectMasterRec.Next() = 0;
                                    end;

                                until SubjectMaster_lRec.Next() = 0;
                            end;
                        end;

                    until TimeTableTemplateLineCS_lRec1.Next() = 0;
                end;
            end;

            If not TimeTableTemplateHdr_lRec."With Topic Code" then begin
                TimeTableTemplateLineCS_lRec.Reset();
                TimeTableTemplateLineCS_lRec.SetRange("Document No.", TimeTableTemplateHdr_lRec."No.");
                TimeTableTemplateLineCS_lRec.SetRange("Template Name", TimeTableTemplateHdr_lRec."Template Name");
                If TimeTableTemplateLineCS_lRec.FindSet() then begin
                    repeat
                        For I := 1 to TimeTableTemplateLineCS_lRec."No. of Labs" do begin

                            LineNo := 0;
                            ClassTimeTableLineCS.Reset();
                            ClassTimeTableLineCS.Setrange("Document No.", Rec."No.");
                            IF ClassTimeTableLineCS.FindLast() then
                                LineNo := ClassTimeTableLineCS."Line No." + 10000
                            Else
                                LineNo := 10000;

                            ClassTimeTableLineCS.Init();
                            ClassTimeTableLineCS."Document No." := Rec."No.";
                            ClassTimeTableLineCS."Line No." := LineNo;
                            ClassTimeTableLineCS."Time Slot" := TimeTableTemplateLineCS_lRec."Time Slot";
                            ClassTimeTableLineCS.Day := TimeTableTemplateLineCS_lRec.Day;
                            ClassTimeTableLineCS.Section := TimeTableTemplateLineCS_lRec.Section;
                            ClassTimeTableLineCS."Subject Group" := TimeTableTemplateLineCS_lRec."Subject Group";
                            ClassTimeTableLineCS."Subject Class" := TimeTableTemplateLineCS_lRec."Subject Class";
                            ClassTimeTableLineCS.Term := Rec.Term;
                            ClassTimeTableLineCS."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            ClassTimeTableLineCS."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            //ClassTimeTableLineCS.Batch := TimeTableTemplateLineCS.Ba
                            ClassTimeTableLineCS.Insert();

                        end;
                    until TimeTableTemplateLineCS_lRec.Next() = 0;
                end;


            end;
        End;
    end;

    procedure AICASATimeTableLine(Rec: Record "Class Time Table Header-CS")
    var
        TimeTableTemplateLineCS_lRec: Record "Time Table Template Line-CS";
        SubjectMaster_lRec: Record "Subject Master-CS";
        SubjectWiseFaculty: Record "Subject Faculty Category";
        Employee_lRec: Record Employee;
        LineCount: Integer;
        LineNo: Integer;
        TemplateLineCount: Integer;
    Begin
        EducationSetupCS.RESET();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF EducationSetupCS.FINDFIRST() THEN //BEGIN
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                EducationMultiEventCalCS.RESET();
                EducationMultiEventCalCS.SETRANGE("Event Code", 'SPRING');
                EducationMultiEventCalCS.SETRANGE("Academic Year", "Academic Year");
                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                    FacultyStartDate := EducationMultiEventCalCS."Start Date";
                    FacultyEndDate := EducationMultiEventCalCS."Revised End Date"
                END;
            END ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'FALL');
                    EducationMultiEventCalCS.SETRANGE("Academic Year", "Academic Year");
                    IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                        FacultyStartDate := EducationMultiEventCalCS."Start Date";
                        FacultyEndDate := EducationMultiEventCalCS."Revised End Date";
                    END;
                END;

        SubjectMaster_lRec.Reset();
        SubjectMaster_lRec.SetRange("Subject Group", Rec."Level 1 Subject Code");
        SubjectMaster_lRec.SetRange("Level Description", SubjectMaster_lRec."Level Description"::"Level 2 Systems");
        SubjectMaster_lRec.SetRange(Level, 2);
        If SubjectMaster_lRec.FindSet() then begin
            repeat
                LineCount := 0;
                LineNo := 0;
                SubjectMasterRec.Reset();
                SubjectMasterRec.SetCurrentKey("Subject Sequence");
                SubjectMasterRec.SetRange("Subject Group", SubjectMaster_lRec.Code);
                SubjectMasterRec.SetRange("Level Description", SubjectMasterRec."Level Description"::"Level 3 Topics");
                SubjectMasterRec.SetRange(Level, 3);
                //SubjectMasterRec.SetRange("Subject Classification", 'Theory');
                IF SubjectMasterRec.Findset() then begin
                    //If SubjectClassFound then begin
                    repeat

                        TimeTableTemplateLineCS.Reset();
                        TimeTableTemplateLineCS.SetRange("Document No.", Rec."Template Code");
                        TimeTableTemplateLineCS.SetRange("Subject Class", SubjectMasterRec."Subject Classification");
                        TimeTableTemplateLineCS.SetFilter("Line No.", '>%1', LineNo);
                        If TimeTableTemplateLineCS.FindFirst() then begin

                            LineCount += 1;
                            LineNo := TimeTableTemplateLineCS."Line No.";
                            ClassTimeTableLineCS.INIT();
                            ClassTimeTableLineCS."Document No." := "No.";
                            ClassTimeTableLineCS."Line No." += 10000;
                            ClassTimeTableLineCS.Validate("Time Slot", TimeTableTemplateLineCS."Time Slot");
                            ClassTimeTableLineCS.Day := TimeTableTemplateLineCS.Day;
                            ClassTimeTableLineCS.Interval := TimeTableTemplateLineCS.Interval;
                            ClassTimeTableLineCS."Interval Type" := TimeTableTemplateLineCS."Interval Type";
                            ClassTimeTableLineCS."Subject Group" := TimeTableTemplateLineCS."Subject Group";
                            ClassTimeTableLineCS.Validate("Subject Class", TimeTableTemplateLineCS."Subject Class");
                            ClassTimeTableLineCS."Subject Code" := SubjectMaster_lRec.Code;
                            ClassTimeTableLineCS."Subject Name" := SubjectMaster_lRec.Description;
                            ClassTimeTableLineCS."Topic Code" := SubjectMasterRec.Code;
                            ClassTimeTableLineCS."Topic Description" := SubjectMasterRec.Description;
                            SubjectWiseFaculty.Reset();
                            SubjectWiseFaculty.SetRange("Subject Code", SubjectMasterRec.Code);
                            IF SubjectWiseFaculty.FindFirst() then begin
                                ClassTimeTableLineCS."Subject Category" := SubjectWiseFaculty."Category Code";

                                Employee_lRec.Reset();
                                Employee_lRec.SetRange("Faculty Category", SubjectWiseFaculty."Category Code");
                                IF Employee_lRec.FindFirst() then begin
                                    ClassTimeTableLineCS."Faculty 1 Code" := Employee_lRec."No.";
                                    ClassTimeTableLineCS."Faculty 1 Name" := Employee_lRec."First Name" + ' ' + Employee_lRec."Last Name";
                                end;
                            end;
                            //ClassTimeTableLineCS."Room No" := "Room No.";
                            ClassTimeTableLineCS.Section := TimeTableTemplateLineCS.Section;
                            ClassTimeTableLineCS.Elective := TimeTableTemplateLineCS.Elective;
                            //ClassTimeTableLineCS."Start Date" := StartDate;

                            //ClassTimeTableLineCS."Room No" := "Room No.";
                            ClassTimeTableLineCS."Global Dimension 1 Code" := "Global Dimension 1 Code";
                            ClassTimeTableLineCS."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            IF ClassTimeTableLineCS.Interval = FALSE THEN BEGIN
                                ClassTimeTableLineCS."Faculty 1 Start Date" := FacultyStartDate;
                                ClassTimeTableLineCS."Faculty 1 End Date" := FacultyEndDate;
                            END;
                            ClassTimeTableLineCS.INSERT();


                            TemplateLineCount := 0;
                            TimeTableTemplateLineCS_lRec.Reset();
                            TimeTableTemplateLineCS_lRec.SetRange("Template Name", Rec."Template Name");
                            TimeTableTemplateLineCS_lRec.SetRange("Subject Class", SubjectMasterRec."Subject Classification");
                            TemplateLineCount := TimeTableTemplateLineCS_lRec.Count();
                            If LineCount = TemplateLineCount then begin
                                LineNo := 0;
                                LineCount := 0;

                            end;

                        end;
                    until SubjectMasterRec.Next() = 0;
                    //StartDate += 1;
                end;

            until SubjectMaster_lRec.Next() = 0;
        end;


    End;

    Procedure CreateFinalTimeTable(Rec: Record "Class Time Table Header-CS")
    var
        ClassTimeTableLine_lRec: Record "Class Time Table Line-CS";
        FinalTimeTable_lRec: Record "Final Class Time Table-CS";
        FinalTimeTable_lRec1: Record "Final Class Time Table-CS";
        TimeSlot: Record "Time Period-CS";
        SubjectDetail: Record "Subject Classification-CS";
        EntryNo: Integer;
        Txt002Lbl: Label 'The Time Table has been Generated for Document No. %1 .';
    begin
        FinalTimeTable_lRec.Reset();
        FinalTimeTable_lRec.SetRange("Time Table  Document No.", Rec."No.");
        FinalTimeTable_lRec.SetRange("Time Table Line No.", 0);
        FinalTimeTable_lRec.DeleteAll(true);

        FinalTimeTable_lRec.Reset();
        FinalTimeTable_lRec.SetRange("Time Table  Document No.", Rec."No.");
        FinalTimeTable_lRec.SetFilter("Time Table Line No.", '<>%1', 0);
        FinalTimeTable_lRec.SetRange(Attendance, FinalTimeTable_lRec.Attendance::"Not Marked");
        FinalTimeTable_lRec.DeleteAll(true);

        ClassTimeTableLine_lRec.Reset();
        ClassTimeTableLine_lRec.SetRange("Document No.", Rec."No.");
        IF ClassTimeTableLine_lRec.FindSet() then begin
            repeat
                FinalTimeTable_lRec1.Reset();
                IF FinalTimeTable_lRec1.FindLast() then
                    EntryNo := FinalTimeTable_lRec1."S.No." + 1
                Else
                    EntryNo := 1;

                FinalTimeTable_lRec.Reset();
                FinalTimeTable_lRec.SetRange("Time Table  Document No.", ClassTimeTableLine_lRec."Document No.");
                FinalTimeTable_lRec.SetRange("Time Table Line No.", ClassTimeTableLine_lRec."Line No.");
                IF Not FinalTimeTable_lRec.FindFirst() then begin
                    FinalTimeTable_lRec.INIT();
                    FinalTimeTable_lRec."S.No." := EntryNo;
                    FinalTimeTable_lRec."Time Table  Document No." := Rec."No.";
                    FinalTimeTable_lRec."Time Table Line No." := ClassTimeTableLine_lRec."Line No.";
                    FinalTimeTable_lRec.Date := ClassTimeTableLine_lRec."Start Date";
                    FinalTimeTable_lRec."Time Slot Code" := ClassTimeTableLine_lRec."Time Slot";
                    IF TimeSlot.GET(FinalTimeTable_lRec."Time Slot Code") THEN BEGIN
                        FinalTimeTable_lRec."Start Time" := TimeSlot."Start Time";
                        FinalTimeTable_lRec."End Time" := TimeSlot."End Time";
                    END;
                    FinalTimeTable_lRec.Interval := ClassTimeTableLine_lRec.Interval;
                    FinalTimeTable_lRec."Interval Type" := ClassTimeTableLine_lRec."Interval Type";
                    FinalTimeTable_lRec."Room No" := ClassTimeTableLine_lRec."Room No";
                    FinalTimeTable_lRec.Year := Rec.Year;
                    FinalTimeTable_lRec.Batch := ClassTimeTableLine_lRec.Batch;
                    FinalTimeTable_lRec.Section := ClassTimeTableLine_lRec.Section;
                    FinalTimeTable_lRec."Subject Class" := ClassTimeTableLine_lRec."Subject Class";
                    FinalTimeTable_lRec."Subject Code" := ClassTimeTableLine_lRec."Subject Code";
                    FinalTimeTable_lRec."Subject Group" := ClassTimeTableLine_lRec."Subject Group";
                    FinalTimeTable_lRec."Subject Name" := ClassTimeTableLine_lRec."Subject Name";
                    FinalTimeTable_lRec."Topic Code" := ClassTimeTableLine_lRec."Topic Code";
                    FinalTimeTable_lRec."Topic Description" := ClassTimeTableLine_lRec."Topic Description";
                    FinalTimeTable_lRec.Semester := Rec.Semester;
                    FinalTimeTable_lRec."Course code" := Rec.Course;
                    FinalTimeTable_lRec."Course Name" := Rec."Course Name";
                    FinalTimeTable_lRec."Academic Code" := Rec."Academic Year";
                    FinalTimeTable_lRec.Term := Rec.Term;
                    FinalTimeTable_lRec."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    FinalTimeTable_lRec."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    FinalTimeTable_lRec."Subject Category" := ClassTimeTableLine_lRec."Subject Category";
                    FinalTimeTable_lRec."Faculty 1Code" := ClassTimeTableLine_lRec."Faculty 1 Code";
                    FinalTimeTable_lRec.Validate("Faculty 1Code");
                    FinalTimeTable_lRec."Faculty 2 Code" := ClassTimeTableLine_lRec."Faculty 2 Code";
                    FinalTimeTable_lRec.Validate("Faculty 2 Code");
                    FinalTimeTable_lRec."Faculty 3 Code" := ClassTimeTableLine_lRec."Faculty 3 Code";
                    FinalTimeTable_lRec.Validate("Faculty 3 Code");
                    FinalTimeTable_lRec."Faculty 4 Code" := ClassTimeTableLine_lRec."Faculty 4 Code";
                    FinalTimeTable_lRec.Validate("Faculty 4 Code");
                    FinalTimeTable_lRec."S.No. Grouping" := ClassTimeTableLine_lRec."Line No.";
                    FinalTimeTable_lRec.Updated := TRUE;
                    FinalTimeTable_lRec.INSERT(TRUE);
                    ClassTimeTableLine_lRec."Final Time Table No." := FinalTimeTable_lRec."S.No.";
                    ClassTimeTableLine_lRec.Modify();
                end;
            until ClassTimeTableLine_lRec.Next() = 0;
        end;

        Rec."Time Table Status" := Rec."Time Table Status"::Generated;
        Rec.MODIFY();

        Message(Txt002Lbl, "No.");


        If Confirm('Do you want to generate Student Attendance.?', true) then begin
            FinalTimeTable_lRec.Reset();
            FinalTimeTable_lRec.SetRange("Time Table  Document No.", Rec."No.");
            IF FinalTimeTable_lRec.FindSet() then begin
                repeat
                    SubjectDetail.Reset();
                    SubjectDetail.SetRange(Code, FinalTimeTable_lRec."Subject Class");
                    IF SubjectDetail.FindFirst() then
                        If not SubjectDetail."Attendance Not Applicable" then
                            AttendanceGeneratedforStudents(FinalTimeTable_lRec);
                until FinalTimeTable_lRec.Next() = 0;

                Message('Student Attendance has been generated.');
            end;

        end;

    end;

}


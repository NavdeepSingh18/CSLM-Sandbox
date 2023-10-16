table 50130 "Final Class Time Table-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   16/06/2019       OnInsert()                                 Data modification Flag
    // 02    CSPL-00114   16/06/2019       OnModify()                                 Data modification Flag
    // 03    CSPL-00114   16/06/2019       Time Slot Code - OnValidate()              Get Start & End Time from Time Slot
    // 04    CSPL-00114   16/06/2019       Subject Code - OnValidate()                Code add for Subject Name
    // 05    CSPL-00114   16/06/2019       Course code - OnValidate()                 Code add for Course Name

    Caption = 'Final Class Time Table-CS';
    DrillDownPageID = "Time Tbl Detail-CS";
    LookupPageID = "Time Tbl Detail-CS";

    fields
    {
        field(1; "S.No."; Integer)
        {
            Caption = 'S.No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; "Time Slot Code"; Code[20])
        {
            Caption = 'Time Slot Code';
            DataClassification = CustomerContent;
            TableRelation = "Time Period-CS"."Slot No";

            trigger OnValidate()
            begin
                //Get Start & End Time from Time Slot::CSPL-00114::16062019: Start
                IF TimePeriodCS.GET("Time Slot Code") THEN BEGIN
                    "Start Time" := TimePeriodCS."Start Time";
                    "End Time" := TimePeriodCS."End Time";
                END;
                //Get Start & End Time from Time Slot::CSPL-00114::16062019: End
            end;
        }
        field(4; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(5; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
        field(6; "Room No"; Code[20])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
        }
        field(7; Batch; Code[30])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            TableRelation = "Batch-CS".Code;
        }
        field(8; Section; Code[30])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            // TableRelation = "Course Section Master-CS"."Section Code" WHERE("Course Code" = FIELD("Course code"),
            //                                                                  Semester = FIELD(Semester));
        }
        field(9; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            TableRelation = "Subject Classification-CS";
        }
        field(10; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            // TableRelation = "Course Wise Subject Line-CS"."Subject Code" WHERE("Course Code" = FIELD("Course code"),
            //                                                                     Semester = FIELD(Semester),
            //                                                                     "Academic Year" = FIELD("Academic Code"),
            //                                                                     "Subject Classification" = FIELD("Subject Class"));
            TableRelation = "Subject Master-CS";

            trigger OnValidate()
            begin
                //Code add for Subject Name::CSPL-00114::16062019: Start
                IF SubjectMasterCS.GET("Subject Code", "Course code") THEN
                    "Subject Name" := SubjectMasterCS.Description
                ELSE
                    "Subject Name" := '';
                //Code add for Subject Name::CSPL-00114::16062019: End
            end;
        }
        field(11; "Subject Name"; Text[150])
        {
            Caption = 'Subject Name';
            DataClassification = CustomerContent;
        }
        field(12; "Course code"; Code[20])
        {
            Caption = 'Course code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code;

            trigger OnValidate()
            begin
                //Code add for Course Name::CSPL-00114::16062019: Start
                IF CourseMasterCS.GET("Course code") THEN
                    "Course Name" := CourseMasterCS.Description;
                //Code add for Course Name::CSPL-00114::16062019: End
            end;
        }
        field(13; "Course Name"; Text[150])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;

        }
        field(14; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD("Course code"),
                                                                           "Academic Year" = FIELD("Academic Code"));
        }
        field(15; "Academic Code"; Code[20])
        {
            Caption = 'Academic Code';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(18; "Attendance Date"; Date)
        {
            Caption = 'Attendance Date';
            DataClassification = CustomerContent;
        }
        field(19; "Atttendance By"; Code[20])
        {
            Caption = 'Atttendance By';
            DataClassification = CustomerContent;
        }
        field(20; Attendance; Option)
        {
            Caption = 'Attendance';
            DataClassification = CustomerContent;
            OptionCaption = 'Not Marked,Marked';
            OptionMembers = "Not Marked",Marked;
        }
        field(21; "Absent Reascon Code"; Code[20])
        {
            Caption = 'Absent Reascon Code';
            DataClassification = CustomerContent;
        }
        field(23; "Faculty 1Code"; Code[20])
        {
            Caption = 'Faculty 1Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Subject Category" = filter('')) Employee."No."
            else
            if ("Subject Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Subject Category"));
        }
        field(24; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
            DataClassification = CustomerContent;
        }
        field(26; "Time Table  Document No."; Code[10])
        {
            Caption = 'Time Table  Document No.';
            DataClassification = CustomerContent;
            TableRelation = "Class Time Table Header-CS";
        }
        field(27; Group; Option)
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
            OptionCaption = ' ,CHEMISTRY GROUP,PHYSICS GROUP';
            OptionMembers = " ","CHEMISTRY GROUP","PHYSICS GROUP";
        }
        field(28; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(29; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(30; Interval; Boolean)
        {
            Caption = 'Interval';
            DataClassification = CustomerContent;
        }
        field(31; "Interval Type"; Code[20])
        {
            Caption = 'Interval Type';
            DataClassification = CustomerContent;
            TableRelation = "Interval-CS";
        }
        field(32; "Extra Class"; Boolean)
        {
            Caption = 'Extra Class';
            DataClassification = CustomerContent;
        }
        field(33; "Open Elective"; Boolean)
        {
            Caption = 'Open Elective';
            DataClassification = CustomerContent;
        }
        field(34; "Faculty 2 Code"; Code[20])
        {
            Caption = 'Faculty 2 Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Subject Category" = filter('')) Employee."No."
            else
            if ("Subject Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Subject Category"));
        }
        field(35; "Faculty 3 Code"; Code[20])
        {
            Caption = 'Faculty 3 Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Subject Category" = filter('')) Employee."No."
            else
            if ("Subject Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Subject Category"));
        }
        field(36; "Faculty 4 Code"; Code[20])
        {
            Caption = 'Faculty 4 Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Subject Category" = filter('')) Employee."No."
            else
            if ("Subject Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Subject Category"));
        }
        field(37; "No. of Hours"; Decimal)
        {
            Caption = 'No. of Hours';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(38; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(39; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
        }
        Field(40; "Topic Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Topic Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(42; "Time Table Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        Field(43; "S.No. Grouping"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Table Line Grouping';
        }
        field(44; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(45; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(46; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(47; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(48; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(49; "Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Time Table Subject Group-CS";
        }
        Field(50; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = "FALL","SPRING","SUMMER";
        }
        Field(51; "Subject Category"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Faculty Category";
            Caption = 'Faculty Category';
        }
    }

    keys
    {
        key(Key1; "S.No.")
        {
        }
        key(Key2; "Time Table  Document No.")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Date, "Time Slot Code", "Room No", "Course code", "Subject Code")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for Data modification Flag::CSPL-00114::16062019: Start
        "Mobile Insert" := TRUE;
        Inserted := true;
        "Created By" := UserId();
        "Created On" := Today();
        //Code added for Data modification Flag::CSPL-00114::16062019: End
    end;

    trigger OnModify()
    begin
        //Code added for Data modification Flag::CSPL-00114::16062019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        "Updated By" := UserId();
        "Updated On" := Today();

        //Code added for Data modification Flag::CSPL-00114::16062019: End
    end;

    Trigger OnDelete()
    Var
        ClassAttendanceHdr: Record "Class Attendance Header-CS";
    Begin

        ClassAttendanceHdr.Reset();
        ClassAttendanceHdr.SetRange("Time Table No", Rec."S.No.");
        IF ClassAttendanceHdr.FindSet() then
            ClassAttendanceHdr.Delete(True);

    End;

    var
        SubjectMasterCS: Record "Subject Master-CS";
        TimePeriodCS: Record "Time Period-CS";

        CourseMasterCS: Record "Course Master-CS";
}


table 50535 "Time Table Buffer"
{

    Caption = 'Time Table Buffer';
    DrillDownPageID = "Time Table Buffer List";
    LookupPageID = "Time Table Buffer List";

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
            // TableRelation = "Batch-CS".Code;
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
                IF "Subject Code" <> '' then begin
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SetRange(Code, "Subject Code");
                    IF SubjectMasterCS.FindFirst() then
                        "Subject Name" := SubjectMasterCS.Description;
                end ELSE
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
            Caption = 'Faculty ID 1';
            DataClassification = CustomerContent;
            TableRelation = if ("Faculty Category" = filter('')) Employee."No."
            else
            if ("Faculty Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Faculty Category"));
            Trigger OnValidate()
            Var
                EmployeeRec: Record Employee;
            Begin
                If "Faculty 1Code" <> '' then begin
                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("No.", Rec."Faculty 1Code");
                    IF EmployeeRec.FindFirst() then
                        "Faculty Name 1" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                end;
            End;
        }
        field(24; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
            DataClassification = CustomerContent;
        }
        field(26; "Time Table Document No."; Code[10])
        {
            Caption = 'Time Table Document No.';
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
            Caption = 'Faculty ID 2';
            DataClassification = CustomerContent;
            TableRelation = if ("Faculty Category" = filter('')) Employee."No."
            else
            if ("Faculty Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Faculty Category"));
            Trigger OnValidate()
            Var
                EmployeeRec: Record Employee;
            Begin
                If "Faculty 2 Code" <> '' then begin
                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("No.", Rec."Faculty 2 Code");
                    IF EmployeeRec.FindFirst() then
                        "Faculty Name 2" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                end;
            End;
        }
        field(35; "Faculty 3 Code"; Code[20])
        {
            Caption = 'Faculty ID 3';
            DataClassification = CustomerContent;
            TableRelation = if ("Faculty Category" = filter('')) Employee."No."
            else
            if ("Faculty Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Faculty Category"));
            Trigger OnValidate()
            Var
                EmployeeRec: Record Employee;
            Begin
                If "Faculty 3 Code" <> '' then begin
                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("No.", Rec."Faculty 3 Code");
                    IF EmployeeRec.FindFirst() then
                        "Faculty Name 3" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                end;
            End;
        }
        field(36; "Faculty 4 Code"; Code[20])
        {
            Caption = 'Faculty ID 4';
            DataClassification = CustomerContent;
            TableRelation = if ("Faculty Category" = filter('')) Employee."No."
            else
            if ("Faculty Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Faculty Category"));
            Trigger OnValidate()
            Var
                EmployeeRec: Record Employee;
            Begin
                If "Faculty 4 Code" <> '' then begin
                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("No.", Rec."Faculty 4 Code");
                    IF EmployeeRec.FindFirst() then
                        "Faculty Name 4" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                end;
            End;
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
        field(40; Select; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(41; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(42; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            DataClassification = CustomerContent;
            TableRelation = "Time Table Subject Group-CS";
        }
        Field(43; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = "FALL","SPRING","SUMMER";
        }
        Field(44; "Final TimeTable Generated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(45; "Faculty Category"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Faculty Category";
        }
        Field(46; "Faculty Name 1"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(47; "Faculty Name 2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(48; "Faculty Name 3"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(49; "Faculty Name 4"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "S.No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Date, "Time Slot Code", "Room No", "Course code", "Subject Code")
        {
        }
    }


    var
        SubjectMasterCS: Record "Subject Master-CS";
        TimePeriodCS: Record "Time Period-CS";
        CourseMasterCS: Record "Course Master-CS";


}


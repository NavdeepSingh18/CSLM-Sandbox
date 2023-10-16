table 50296 "Room Alloted Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   27/08/2019       OnModify()                                 Code added for Any Record change updated Fields value Update
    // 02    CSPL-00114   27/08/2019       Subject Code - OnLookup()                  Code added for Course wise Subject line Page Lookup
    // 03    CSPL-00114   27/08/2019       No. - OnValidate()                         Code added for Status Related
    // 04    CSPL-00114   27/08/2019       CheckRoomAllotment() - Function            Code added for Validation

    Caption = 'Room Alloted Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(10; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(11; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = IF ("Type Of Course" = FILTER(Semester)) "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD(Course));

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(12; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(13; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Course wise Subject line Page Lookup::CSPL-00114::27082019: Start
                CourseWiseSubjectLineCS.RESET();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", Course);
                CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                IF "Type Of Course" = "Type Of Course"::Semester THEN
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester)
                ELSE
                    CourseWiseSubjectLineCS.SETRANGE(Year, Year);
                IF CourseWiseSubjectLineCS.FINDSET() THEN
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN
                        "Subject Code" := CourseWiseSubjectLineCS."Subject Code";

                //Code added for Course wise Subject line Page Lookup::CSPL-00114::27082019: End
            end;

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(14; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(15; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(16; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(17; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";

            trigger OnValidate()
            begin
                CheckRoomAllotment();
            end;
        }
        field(18; "Student Capacity"; Integer)
        {
            Caption = 'Student Capacity';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                CheckRoomAllotment();
            end;
        }
        field(19; "Room Alloted"; Boolean)
        {
            Caption = 'Room Alloted';
            DataClassification = CustomerContent;
        }
        field(54; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(55; "Whom Alloted"; Code[20])
        {
            Caption = 'Whom Alloted';
            DataClassification = CustomerContent;
        }
        field(56; "Room No."; Code[10])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
        }
        field(57; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for Any Record change updated Fields value Update::CSPL-00114::27082019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Any Record change updated Fields value Update::CSPL-00114::27082019: End
    end;

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";


    local procedure CheckRoomAllotment()
    begin
        //Code added for Validation::CSPL-00114::27082019: Start
        IF "Room Alloted" THEN
            FIELDERROR("Room Alloted");
        //Code added for Validation::CSPL-00114::27082019: End
    end;
}


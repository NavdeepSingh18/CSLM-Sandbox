table 50281 "Student Intership Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   12/02/2019       OnInsert()                                 Insert Value from header to line Table (Call Function-GetIntershipHed)
    // 03    CSPL-00114   12/02/2019       Student Name - OnValidate()                Code added for Student Status Check Function Call
    // 04    CSPL-00114   12/02/2019       Student No. - OnValidate()                 Code added for Student Status Check Function Call & Student Name Get
    // 07    CSPL-00114   12/02/2019       Remarks - OnValidate()                     Code added for Student Status Check Function Call
    // 10    CSPL-00114   12/02/2019       GetIntershipHed -Function                  Getting values from Student Intership header to Student Intership line Table
    // 11    CSPL-00114   12/02/2019       StudentStatus -Function                    Check Student Status "Posted".

    Caption = 'Student Intership Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student Name"; Text[100])
        {

            Caption = 'Student Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: Start
                StudentStatus();
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: End
            end;
        }
        field(4; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(5; "Industrial Program"; Code[20])
        {
            Caption = 'Industrial Program"';
            DataClassification = CustomerContent;
            TableRelation = "Industrial-CS".Program WHERE("Type Of Course" = FIELD("Type Of Course"),
                                                         Semester = FIELD(Semester));
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student Status Check Function Call & Student Name Get::CSPL-00114::12022019: Start
                StudentStatus();

                "Student Name" := '';
                StudentMasterCS.RESET();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", "Student No.");
                IF StudentMasterCS.FindFirst() THEN
                    "Student Name" := StudentMasterCS."Student Name";
                //Code added for Student Status Check Function Call & Student Name Get::CSPL-00114::12022019: End
            end;
        }
        field(9; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(10; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(11; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(12; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(13; Remarks; Text[50])
        {

            Caption = 'Remarks';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: Start
                StudentStatus();
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: End
            end;
        }
        field(14; Section; Code[10])
        {

            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(15; Session; Code[20])
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            TableRelation = Session;
        }
        field(16; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Type Of Course", "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code Added for insert records from header to line Table::CSPL-00114::12022019: Start
        GetIntershipHed();
        //Code Added for insert records from header to line Table::CSPL-00114::12022019: End
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        Text003Lbl: Label 'Student already posted';

    procedure GetIntershipHed()
    var
        StudentIntershipHeadCS: Record "Student Intership Head-CS";
    begin
        //Code Added for Getting values from Student Intership header to Student Intership line Table::CSPL-00114::12022019: Start
        IF StudentIntershipHeadCS.GET("Document No.") THEN BEGIN
            "Type Of Course" := StudentIntershipHeadCS."Type Of Course";
            Course := StudentIntershipHeadCS.Course;
            Semester := StudentIntershipHeadCS.Semester;
            "Global Dimension 1 Code" := StudentIntershipHeadCS."Global Dimension 1 Code";
            Year := StudentIntershipHeadCS.Year;
            "Industrial Program" := StudentIntershipHeadCS."Industrial Program";
        END;
        //Code Added for Getting values from Student Intership header to Student Intership line Table::CSPL-00114::12022019: End
    end;

    procedure StudentStatus()
    begin
        //Code Added for Check Student Status "Posted"::CSPL-00114::12022019: Start
        IF Posted = TRUE THEN
            ERROR(Text003Lbl);
        //Code Added for Check Student Status "Posted"::CSPL-00114::12022019: End
    end;
}


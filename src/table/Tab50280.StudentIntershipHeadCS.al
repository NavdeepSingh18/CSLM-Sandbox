table 50280 "Student Intership Head-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   12/02/2019       OnInsert()                                 Get "No Series" Values
    // 03    CSPL-00114   12/02/2019       No. - OnValidate()                         Get "No Series" Values & Student Status Posted Function Call
    // 04    CSPL-00114   12/02/2019       Global Dimension 1 Code - OnValidate()     Code added for Student Status Check Function Call
    // 05    CSPL-00114   12/02/2019       Session - OnValidate()                     Code added for Student Status Check Function Call
    // 06    CSPL-00114   12/02/2019       Academic Year - OnValidate()               Code added for Student Status Check Function Call
    // 07    CSPL-00114   12/02/2019       Remarks - OnValidate()                     Code added for Student Status Check Function Call
    // 08    CSPL-00114   12/02/2019       Industrial Program - OnValidate()          Code added for Student Status Check Function Call
    // 09    CSPL-00114   12/02/2019       Course - OnValidate()                      Code added for Course Master Related Fill & Student Status Check Function Call
    // 10    CSPL-00114   12/02/2019       Getstudent -Function                       Insert Student Intership Line Code added
    // 11    CSPL-00114   12/02/2019       GetstudentYR -Function                     Insert Student Intership Line With Year Code added
    // 12    CSPL-00114   12/02/2019       PostStudent -Function                      Posted Status Modified.
    // 13    CSPL-00114   12/02/2019       PostStudent -Function                      Check Student Status "Posted".

    Caption = 'Student Intership Head-CS';

    fields
    {
        field(1; "No."; Code[20])
        {

            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Get "No Series" Values & Student Status Posted Function Call::CSPL-00114::12022019: Start
                StudentStatus();
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Intership No.");
                    "No.Series" := '';
                END;
                //Code added for Get "No Series" Values & Student Status Check Function Call::CSPL-00114::12022019: End
            end;
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: Start
                StudentStatus();
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: End
            end;
        }
        field(3; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(4; Session; Code[20])
        {
            TableRelation = Session;
            Caption = 'Session.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: Start
                StudentStatus();
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: End
            end;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: Start
                StudentStatus();
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: End
            end;
        }
        field(6; Remarks; Text[50])
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
        field(7; "Industrial Program"; Code[20])
        {
            Caption = 'Industrial Program"';
            DataClassification = CustomerContent;
            TableRelation = "Industrial-CS".Program WHERE("Type Of Course" = FIELD("Type Of Course"),
                                                         Semester = FIELD(Semester));

            trigger OnValidate()
            begin
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: Start
                StudentStatus();
                //Code added for Student Status Check Function Call::CSPL-00114::12022019: End
            end;
        }
        field(8; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(9; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(10; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Course Master Related Fill & Student Status Check Function Call::CSPL-00114::12022019: End
                StudentStatus();

                "Global Dimension 1 Code" := '';
                "Academic Year" := '';
                CLEAR("Type Of Course");
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, Course);
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Academic Year" := CourseMasterCS."Academic Year";
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                END;
                //Code added for Course Master Related Fill & Student Status Check Function Call::CSPL-00114::12022019: End
            end;
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
        field(13; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(14; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
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
        fieldgroup(DropDown; "No.")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for Get "No Series" Values::CSPL-00114::12022019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Intership No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Intership No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        //Code added for Get "No Series" Values::CSPL-00114::12022019: Start
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        StudentIntershipLineCS: Record "Student Intership Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        StudentIntershipLineCS1: Record "Student Intership Line-CS";

        CourseMasterCS: Record "Course Master-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text002Lbl: Label 'Please Select Either Collage Or Course Or Semester Or Acadmic Year & Session';

        Text003Lbl: Label 'Student already posted';

    procedure GetStudentCS(getCollege: Code[20]; getTypeOfCourse: Option; getSemester: Code[10]; getCourse: Code[20]; getDocNo: Code[20]; getIderProg: Code[20]; getSection: Code[10]; getSession: Code[20])
    var
        StudentMasterCS: Record "Student Master-CS";
        "LocalLineNo.": Integer;

    begin
        //Code Added for Insert Student Intership Line Code added::CSPL-00114::12022019: Start
        IF ((getCollege = '') OR (getSemester = '') OR (getCourse = '') OR (getIderProg = '') OR (getSection = '')) THEN
            ERROR(Text002Lbl);

        EducationSetupCS.GET();
        StudentIntershipLineCS.Reset();

        "LocalLineNo." := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETCURRENTKEY("Course Code", Semester, "Academic Year");

        IF getSection <> '' THEN
            StudentMasterCS.SETRANGE(Section, getSection);

        IF getSession <> '' THEN
            StudentMasterCS.SETRANGE(Session, getSession);

        IF (getCourse <> '') AND (getSemester <> '') THEN BEGIN
            StudentMasterCS.SETRANGE("Course Code", getCourse);
            StudentMasterCS.SETRANGE(Semester, getSemester);
        END;


        StudentMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                "LocalLineNo." += 10000;
                StudentIntershipLineCS.INIT();
                StudentIntershipLineCS."Document No." := getDocNo;
                StudentIntershipLineCS."Line No." := "LocalLineNo.";
                StudentIntershipLineCS."Student No." := StudentMasterCS."No.";
                StudentIntershipLineCS."Student Name" := StudentMasterCS."Student Name";
                StudentIntershipLineCS."Type Of Course" := getTypeOfCourse;
                StudentIntershipLineCS.Course := StudentMasterCS."Course Code";
                StudentIntershipLineCS."Industrial Program" := getIderProg;
                StudentIntershipLineCS.Semester := StudentMasterCS.Semester;
                StudentIntershipLineCS."Student Name" := StudentMasterCS."Student Name";
                StudentIntershipLineCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 2 Code";
                StudentIntershipLineCS.Section := StudentMasterCS.Section;
                StudentIntershipLineCS.Session := StudentMasterCS.Session;
                StudentIntershipLineCS.INSERT();
            UNTIL StudentMasterCS.NEXT() = 0;
        //Code Added for Insert Student Intership Line Code added::CSPL-00114::12022019: End
    end;

    procedure GetStudentYRCS(getCollege: Code[20]; getTypeOfCourse: Option; getYear: Code[20]; getCourse: Code[20]; getDocNo: Code[20]; getIderProg: Code[20]; getSection: Code[10]; getSession: Code[20])
    var
        StudentMasterCS: Record "Student Master-CS";
        "LocalLineNo.": Integer;

    begin
        //Code Added For Insert Student Intership Line With Year Code added::CSPL-00114::12022019: Start
        IF ((getCollege = '') OR (getYear = '') OR (getCourse = '') OR (getIderProg = '') OR (getSection = '')) THEN
            ERROR(Text002Lbl);

        EducationSetupCS.GET();
        StudentIntershipLineCS.Reset();

        "LocalLineNo." := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETCURRENTKEY("Course Code", Semester, "Academic Year");

        IF getSection <> '' THEN
            StudentMasterCS.SETRANGE(Section, getSection);

        IF getSession <> '' THEN
            StudentMasterCS.SETRANGE(Session, getSession);

        IF (getCourse <> '') AND (getYear <> '') THEN BEGIN
            StudentMasterCS.SETRANGE("Course Code", getCourse);
            StudentMasterCS.SETRANGE(Year, getYear);
        END;


        StudentMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                "LocalLineNo." += 10000;
                StudentIntershipLineCS.INIT();
                StudentIntershipLineCS."Document No." := getDocNo;
                StudentIntershipLineCS."Line No." := "LocalLineNo.";
                StudentIntershipLineCS."Student No." := StudentMasterCS."No.";
                StudentIntershipLineCS."Student Name" := StudentMasterCS."Student Name";
                StudentIntershipLineCS."Type Of Course" := getTypeOfCourse;
                StudentIntershipLineCS.Course := StudentMasterCS."Course Code";
                StudentIntershipLineCS."Industrial Program" := getIderProg;
                StudentIntershipLineCS.Year := getYear;
                StudentIntershipLineCS."Student Name" := StudentMasterCS."Student Name";
                StudentIntershipLineCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 2 Code";
                StudentIntershipLineCS.Section := StudentMasterCS.Section;
                StudentIntershipLineCS.Session := StudentMasterCS.Session;
                StudentIntershipLineCS.INSERT();
            UNTIL StudentMasterCS.NEXT() = 0;
        //Code Added For Insert Student Intership Line With Year Code added::CSPL-00114::12022019: End
    end;

    procedure PostStudentCS()
    begin
        //Code Added For Posted Status Modified::CSPL-00114::12022019: Start
        StudentIntershipLineCS1.Reset();
        StudentIntershipLineCS1.SETRANGE(StudentIntershipLineCS1."Document No.", "No.");
        IF StudentIntershipLineCS1.FindFirst() THEN
            REPEAT
                StudentIntershipLineCS1.Posted := Posted;
                StudentIntershipLineCS1.Modify();
            UNTIL StudentIntershipLineCS1.NEXT() = 0;
        //Code Added For Posted Status Modified::CSPL-00114::12022019: End
    end;

    procedure StudentStatus()
    begin
        //Code Added For Check Student Status "Posted"::CSPL-00114::12022019: Start
        IF Posted = TRUE THEN
            ERROR(Text003Lbl);
        //Code Added For Check Student Status "Posted"::CSPL-00114::12022019: End
    end;
}


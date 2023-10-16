table 50245 "Registration Student-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   23/06/2019       Student No. - OnValidate()                Code added Get Student Information Value
    // 02    CSPL-00114   23/06/2019       Course Code - OnValidate()                Code added Get Course Related Values
    // 03    CSPL-00114   23/06/2019       Session - OnValidate()                    Code added Get Student Subject & Optional Subject Modification
    // 04    CSPL-00114   23/06/2019       Subject Code - OnValidate()               Code added Get Subject Information Value

    Caption = 'Registration Student-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added Get Student Information Value::CSPL-00114::23062019: Start
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", "Student No.");
                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                    "Student Name" := StudentMasterCS."Name as on Certificate";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                END;
                //Code added Get Student Information Value::CSPL-00114::23062019: End
            end;
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added Get Course related Value::CSPL-00114::23062019: Start
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "Course Code");
                IF CourseMasterCS.FINDFIRST() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                END ELSE BEGIN
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                END;
                //Code added Get Course related Value::CSPL-00114::23062019: End
            end;
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(6; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
        }
        field(8; Session; Code[20])
        {
            TableRelation = "Session Master-CS".Session;
            Caption = 'Session';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added Get Student Subject & Optional Subject Modification::CSPL-00114::23062019: Start
                IF "Subject Type" = 'CORE' THEN BEGIN
                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE("Student No.", "Student No.");
                    MainStudentSubjectCS.SETRANGE(Course, "Course Code");
                    MainStudentSubjectCS.SETRANGE(Semester, Semester);
                    MainStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
                    MainStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
                    MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF MainStudentSubjectCS.FINDFIRST() THEN
                        REPEAT
                            IF Session = 'WINTER' THEN BEGIN
                                MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester, "Academic Year", MainStudentSubjectCS."Subject Code", '');
                                MainStudentSubjectCS."Roll No." := '';
                                MainStudentSubjectCS."Current Session" := Session;
                                MainStudentSubjectCS."Re-Registration" := TRUE;
                                MainStudentSubjectCS."Re-Registration Date" := WORKDATE();
                            END ELSE
                                IF Session = 'SUMMER' THEN BEGIN
                                    MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester, "Academic Year", MainStudentSubjectCS."Subject Code", '');
                                    MainStudentSubjectCS."Roll No." := '';
                                    MainStudentSubjectCS."Current Session" := Session;
                                    MainStudentSubjectCS."Re-Registration" := TRUE;
                                    MainStudentSubjectCS."Re-Registration Date" := WORKDATE();
                                END;
                            MainStudentSubjectCS.Modify();
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                END ELSE
                    IF "Subject Type" <> 'CORE' THEN BEGIN
                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE("Student No.", "Student No.");
                        OptionalStudentSubjectCS.SETRANGE(Course, "Course Code");
                        OptionalStudentSubjectCS.SETRANGE(Semester, Semester);
                        OptionalStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
                        OptionalStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
                        OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                        IF OptionalStudentSubjectCS.FINDFIRST() THEN
                            REPEAT
                                IF Session = 'WINTER' THEN BEGIN
                                    OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester, "Academic Year", OptionalStudentSubjectCS."Subject Code", '');
                                    OptionalStudentSubjectCS."Roll No." := '';
                                    OptionalStudentSubjectCS."Current Session" := Session;
                                    OptionalStudentSubjectCS."Re-Registration" := TRUE;
                                    OptionalStudentSubjectCS."Re-Registration Date" := WORKDATE();
                                END ELSE
                                    IF Session = 'SUMMER' THEN BEGIN
                                        OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester, "Academic Year", OptionalStudentSubjectCS."Subject Code", '');
                                        OptionalStudentSubjectCS."Roll No." := '';
                                        OptionalStudentSubjectCS."Current Session" := Session;
                                        OptionalStudentSubjectCS."Re-Registration" := TRUE;
                                        OptionalStudentSubjectCS."Re-Registration Date" := WORKDATE();
                                    END;
                                OptionalStudentSubjectCS.Modify();
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                    END;
                //Code added Get Student Subject & Optional Subject Modification::CSPL-00114::23062019: End
            end;
        }
        field(9; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(10; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added Get Subject Related Values::CSPL-00114::23062019: Start
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN BEGIN
                    "Subject Name" := SubjectMasterCS.Description;
                    "Subject Type" := SubjectMasterCS."Subject Type";
                    Credit := FORMAT(SubjectMasterCS.Credit);
                    "Subject Class" := SubjectMasterCS."Subject Classification";
                END ELSE BEGIN
                    "Subject Name" := '';
                    "Subject Type" := '';
                    Credit := '';
                END;
                //Code added Get Subject Related Values::CSPL-00114::23062019: End
            end;
        }
        field(11; "Subject Name"; Text[100])
        {
            Caption = 'Suject Name';
            DataClassification = CustomerContent;
        }
        field(12; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(13; Credit; Code[20])
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(14; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
        }
        field(15; "Registration Date"; DateTime)
        {
            Caption = 'Registration Date';
            DataClassification = CustomerContent;
        }
        field(16; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';

            CalcFormula = Lookup ("Student Master-CS"."Enrollment No." WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(17; "Student Name"; Text[100])
        {
            Caption = 'Student Name';

            CalcFormula = Lookup ("Student Master-CS"."Name as on Certificate" WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(18; "Subject Class"; Code[20])
        {
            CalcFormula = Lookup ("Subject Master-CS"."Subject Classification" WHERE(Code = FIELD("Subject Code")));
            FieldClass = FlowField;
            Caption = 'Subject Class';
        }
        field(19; Cancel; Boolean)
        {
            Caption = 'Cancel';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CourseMasterCS: Record "Course Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        StudentMasterCS: Record "Student Master-CS";
}


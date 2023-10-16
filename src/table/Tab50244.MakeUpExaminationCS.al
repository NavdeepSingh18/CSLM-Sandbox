table 50244 "MakeUp Examination-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   23/06/2019       Student No. - OnValidate()                Code added Get Student Information Value Values
    // 02    CSPL-00114   23/06/2019       Subject Code - OnValidate()               Code added Get Subject Related Values
    // 03    CSPL-00114   23/06/2019       Enrollment No. - OnValidate()             Code added Get Student Related Values
    // 04    CSPL-00114   23/06/2019       Exam Classification - OnValidate()        Code added Get Student Subject & Optional Subject Modification


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
            TableRelation = "Student Master-CS";
            Caption = 'Student No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added Get Student Information Value Values::CSPL-00114::23062019: Start
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("No.", "Student No.");
                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Academic Year" := StudentMasterCS."Academic Year";
                    "Course Code" := StudentMasterCS."Course Code";
                    "Type Of Course" := StudentMasterCS."Type Of Course";
                    Year := StudentMasterCS.Year;
                    "Program" := StudentMasterCS.Graduation;
                    "Type Of Course" := StudentMasterCS."Type Of Course";
                    "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                END;
                //Code added Get Student Information Value Values::CSPL-00114::23062019: End
            end;
        }
        field(3; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
        }
        field(4; "Course Code"; Code[20])
        {
            TableRelation = "Course Master-CS";
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(5; "Subject Code"; Code[20])
        {
            TableRelation = "Subject Master-CS".Code WHERE("Subject Closed" = FILTER(false));
            Caption = 'Subject Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added Get Subject Related Values::CSPL-00114::23062019: Start
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN BEGIN
                    "Subject Name" := SubjectMasterCS.Description;
                    Credit := SubjectMasterCS.Credit;
                    "Subject Class" := SubjectMasterCS."Subject Classification";
                    "Subject Type" := SubjectMasterCS."Subject Type";
                END;
                //Code added Get Subject Related Values::CSPL-00114::23062019: End
            end;
        }
        field(6; "Subject Name"; Text[100])
        {
            Caption = 'Subject Name';
            DataClassification = CustomerContent;
        }
        field(7; Semester; Code[10])
        {
            TableRelation = "Semester Master-CS";
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(8; Year; Code[20])
        {
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(9; "Academic Year"; Code[20])
        {
            TableRelation = "Academic Year Master-CS";
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(10; Grade; Code[20])
        {
            TableRelation = "Grade Master-CS";
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(11; Session; Code[50])
        {
            TableRelation = "Session Master-CS".Session;
            Caption = 'Session';
            DataClassification = CustomerContent;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(14; "Apply Date"; Date)
        {
            Caption = 'Apply Date';
            DataClassification = CustomerContent;
        }
        field(15; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(16; "Created  Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
        }
        field(17; "Created By Name"; Text[100])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
        field(18; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(19; "Updated By Name"; Text[100])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(20; "Updated Date"; Date)
        {
            Caption = 'Updated Date';
            DataClassification = CustomerContent;
        }
        field(21; "Subject Class"; Code[20])
        {
            TableRelation = "Subject Classification-CS".Code;
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
        }
        field(22; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            TableRelation = "Subject Type-CS";
            DataClassification = CustomerContent;
        }
        field(23; "Exam Schedule Created"; Boolean)
        {
            Caption = 'Exam Schedule Created';
            DataClassification = CustomerContent;
        }
        field(24; "Program"; Code[20])
        {
            TableRelation = "Graduation Master-CS".Code;
            Caption = 'Program';
            DataClassification = CustomerContent;
        }
        field(25; "Type Of Course"; Option)
        {
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
        }
        field(26; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;
        }
        field(27; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(28; "Student Group"; Code[20])
        {
            TableRelation = "Group Master-CS".Code;
            Caption = 'Student Group';
            DataClassification = CustomerContent;
        }
        field(29; "Student Batch"; Code[20])
        {
            TableRelation = "Batch-CS".Code;
            Caption = 'Student Batch';
            DataClassification = CustomerContent;
        }
        field(30; Credit; Decimal)
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(31; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added Get Student Related Values::CSPL-00114::23062019: Start
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    "Student No." := StudentMasterCS."No.";
                    "Academic Year" := StudentMasterCS."Academic Year";
                    "Course Code" := StudentMasterCS."Course Code";
                    "Type Of Course" := StudentMasterCS."Type Of Course";
                    Year := StudentMasterCS.Year;
                    "Program" := StudentMasterCS.Graduation;
                    "Type Of Course" := StudentMasterCS."Type Of Course";
                    "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                END;
                //Code added Get Student Related Values::CSPL-00114::23062019: End
            end;
        }
        field(32; "Exam Classification"; Code[10])
        {
            TableRelation = "Examination Type Master-CS".Code;
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added Get Student Subject & Optional Subject Modification::CSPL-00114::23062019: Start
                IF "Exam Classification" <> '' THEN
                    IF "Subject Type" = 'CORE' THEN BEGIN
                        MainStudentSubjectCS.Reset();
                        MainStudentSubjectCS.SETRANGE("Student No.", "Student No.");
                        MainStudentSubjectCS.SETRANGE(Semester, Semester);
                        MainStudentSubjectCS.SETRANGE("Subject Class", "Subject Class");
                        MainStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
                        MainStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
                        MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                        IF MainStudentSubjectCS.FINDFIRST() THEN
                            REPEAT
                                IF "Exam Classification" = 'REGULAR' THEN BEGIN
                                    MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester, "Academic Year", MainStudentSubjectCS."Subject Code", '');
                                    MainStudentSubjectCS."Roll No." := '';
                                    MainStudentSubjectCS."Current Session" := Session;
                                    MainStudentSubjectCS."Re-Registration Exam Only" := TRUE;
                                END;
                                IF "Exam Classification" = 'MAKE-UP' THEN BEGIN
                                    MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester, "Academic Year", MainStudentSubjectCS."Subject Code", '');
                                    MainStudentSubjectCS."Roll No." := '';
                                    MainStudentSubjectCS."Current Session" := Session;
                                    MainStudentSubjectCS."Make Up Examination" := TRUE;
                                END;
                                IF "Exam Classification" = 'SPECIAL' THEN BEGIN
                                    MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester, "Academic Year", MainStudentSubjectCS."Subject Code", '');
                                    MainStudentSubjectCS."Roll No." := '';
                                    MainStudentSubjectCS."Current Session" := Session;
                                    MainStudentSubjectCS."Special Exam" := TRUE;
                                END;
                                MainStudentSubjectCS.Modify();
                            UNTIL MainStudentSubjectCS.NEXT() = 0;

                    END ELSE
                        IF "Subject Type" <> 'CORE' THEN BEGIN
                            OptionalStudentSubjectCS.Reset();
                            OptionalStudentSubjectCS.SETRANGE("Student No.", "Student No.");
                            OptionalStudentSubjectCS.SETRANGE(Semester, Semester);
                            OptionalStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
                            OptionalStudentSubjectCS.SETRANGE("Subject Class", "Subject Class");
                            OptionalStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
                            OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                            IF OptionalStudentSubjectCS.FINDFIRST() THEN
                                REPEAT
                                    IF "Exam Classification" = 'REGULAR' THEN BEGIN
                                        OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester, "Academic Year", OptionalStudentSubjectCS."Subject Code", '');
                                        OptionalStudentSubjectCS."Roll No." := '';
                                        OptionalStudentSubjectCS."Current Session" := Session;
                                        OptionalStudentSubjectCS."Re-Registration Exam Only" := TRUE;
                                    END;
                                    IF "Exam Classification" = 'MAKE-UP' THEN BEGIN
                                        OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester, "Academic Year", OptionalStudentSubjectCS."Subject Code", '');
                                        OptionalStudentSubjectCS."Roll No." := '';
                                        OptionalStudentSubjectCS."Current Session" := Session;
                                        OptionalStudentSubjectCS."Make Up Examination" := TRUE;
                                    END;
                                    IF "Exam Classification" = 'SPECIAL' THEN BEGIN
                                        OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester, "Academic Year", OptionalStudentSubjectCS."Subject Code", '');
                                        OptionalStudentSubjectCS."Roll No." := '';
                                        OptionalStudentSubjectCS."Current Session" := Session;
                                        OptionalStudentSubjectCS."Special Exam" := TRUE;
                                    END;
                                    OptionalStudentSubjectCS.Modify();
                                UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                        END;

                //Code added Get Student Subject & Optional Subject Modification::CSPL-00114::23062019: End
            end;
        }
        field(33; Cancel; Boolean)
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
        SubjectMasterCS: Record "Subject Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
}
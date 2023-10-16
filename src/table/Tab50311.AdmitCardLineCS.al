table 50311 "Admit Card Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   21/01/2019       Subject Type - OnValidate()                      Get Student No & Academic year Values from Admit card Header
    // 02    CSPL-00114   21/01/2019       Subject Code - OnValidate()                      Code added for Get Subject Description
    // 03    CSPL-00114   21/01/2019       Subject Code - OnLookup()                        Code added for Course wise Subject Page Lookup
    // 04    CSPL-00114   21/01/2019       Student No. - OnValidate()                       Get Student Name

    Caption = 'Admit Card Line-CS';
    DrillDownPageID = 50329;
    LookupPageID = 50329;

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
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                //Code added for Get Student No & Academic year Values from Admit card Header::CSPL-00114::21012019: Start
                IF RecAdmitCardHCS.GET("Document No.") THEN BEGIN
                    "Student No." := RecAdmitCardHCS."Student No.";
                    "Academic Year" := RecAdmitCardHCS."Academic Year";
                END ELSE BEGIN
                    "Student No." := '';
                    "Academic Year" := '';
                END;
                //Code added for Get Student No & Academic year Values from Admit card Header::CSPL-00114::21012019: End
            end;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Course wise Subject Page lookup:CSPL-00114::21012019: Start
                AdmitCardHeaderCS.GET("Document No.");
                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", AdmitCardHeaderCS."Course Code");
                CourseWiseSubjectLineCS.SETRANGE(Semester, AdmitCardHeaderCS.Semester);
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", AdmitCardHeaderCS."Academic Year");
                IF CourseWiseSubjectLineCS.FINDSET() THEN
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                        "Subject Description" := CourseWiseSubjectLineCS.Description;
                        "Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                        "Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                    END;
                //Code added for Course wise Subject Page lookup::CSPL-00114::21012019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Get Subject Description::CSPL-00114::21012019: Start
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN
                    "Subject Description" := SubjectMasterCS.Description;
                //Code added for Get Subject Description::CSPL-00114::21012019: End
            end;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student Name::CSPL-00114::21012019: Start
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name";

                //Code added for Student Name::CSPL-00114::21012019: End
            end;
        }
        field(8; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(9; "Apply Type"; Option)
        {
            Caption = 'Apply Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Regular,Re-Registration,Makeup,Winter,Summer,Special';
            OptionMembers = " ",Regular,"Re-Registration",Makeup,Winter,Summer,Special;
        }
        field(10; "Subject Description"; Text[100])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(13; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(14; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Academic Year Master-CS";
        }
        field(15; "Time Slot"; Code[20])
        {
            Caption = 'Time Slot';
            DataClassification = CustomerContent;
            TableRelation = "Examination Time Slot-CS".Code;
        }
        field(16; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(19; Detained; Boolean)
        {
            Caption = 'Detained';
            DataClassification = CustomerContent;
        }
        field(20; "Actual Per%"; Decimal)
        {
            Caption = 'Actual Per%';
            DataClassification = CustomerContent;
        }
        field(21; "Applicable Per %"; Decimal)
        {
            Caption = 'Applicable Per%';
            DataClassification = CustomerContent;
        }
        field(22; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS".Code;
        }
        field(23; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            TableRelation = "Period Line-CS".Code;
        }
        field(24; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(25; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No';
            DataClassification = CustomerContent;
        }
        field(26; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS".Code;
        }
        field(27; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(28; "Exam ClassiFication"; Code[10])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
        }
        field(29; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No';
            DataClassification = CustomerContent;
        }
        field(33048922; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 21012019';
        }
        field(33048923; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 21012019';
        }
        field(33048924; "Updated By"; Code[30])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 21012019';
        }
        field(33048925; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 21012019';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Document No.", "Student No.")
        {
        }
        key(Key3; Course, Semester, Section, "Subject Type", "Subject Code")
        {
        }
        key(Key4; Course, Semester, Section, "Result Generated")
        {
        }
        key(Key5; Course, Semester, Section, "Subject Type", "Subject Code", "Apply Type", "Result Generated")
        {
        }
        key(Key6; Course, "Subject Type", "Subject Code", "Apply Type", "Result Generated")
        {
        }
    }

    fieldgroups
    {
    }

    var
        StudentMasterCS: Record "Student Master-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        RecAdmitCardHCS: Record "Admit Card Header-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        AdmitCardHeaderCS: Record "Admit Card Header-CS";
}


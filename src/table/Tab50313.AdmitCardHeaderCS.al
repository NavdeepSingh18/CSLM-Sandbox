table 50313 "Admit Card Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   28/04/2019       OnInsert()                                 Get "No Series" Value
    // 02    CSPL-00114   28/04/2019       OnModify()                                 Code added for Record Modify then updated by & Update on Value Fill
    // 03    CSPL-00114   28/04/2019       OnDelete()                                 Code added for Lines Delete
    // 04    CSPL-00114   28/04/2019       No. - OnValidate()                         Get "No Series" Value
    // 05    CSPL-00114   28/04/2019       Student No. - OnValidate()                 Get Student name & Enrollment No Value
    // 06    CSPL-00114   28/04/2019       Assistedit- Function                       Code added for No Series Generation

    Caption = 'Admit Card Header-CS';
    DrillDownPageID = "Stud Hall Ticket Hdr-CS";
    LookupPageID = "Stud Hall Ticket Hdr-CS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for No Series::CSPL-00114::28042019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Hall Ticket Entry No.");
                    "No.Series" := '';
                END;
                //Code added for No Series::CSPL-00114::28042019: End
            end;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student information::CSPL-00114::28042019: Start
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                END;
                //Code added for Student information::CSPL-00114::28042019: End
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(8; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(9; "Exam Fee Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Admit Card Line-CS".Amount WHERE("Document No." = FIELD("No."),
                                                        "Student No." = FIELD("Student No.")));
            Caption = 'Exam Fee Total Amount';

        }
        field(10; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = CustomerContent;
        }
        field(11; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(12; Detent; Boolean)
        {
            Caption = 'Detent';
            DataClassification = CustomerContent;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(16; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS".Code;
        }
        field(18; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS".Code;
        }
        field(19; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(20; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No.';
            DataClassification = CustomerContent;
            TableRelation = "Exam Time Table Head-CS"."No.";
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28042019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28042019';
        }
        field(33048922; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28042019';
        }
        field(33048923; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28042019';
        }
        field(33048924; "Updated By"; Code[30])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28042019';
        }
        field(33048925; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28042019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Student No.", "Course Code", Semester, Section, "Academic Year")
        {
        }
        key(Key3; "Course Code", Semester, Section, "Academic Year")
        {
        }
        key(Key4; "Student No.", "Course Code", Semester, Section)
        {
        }
        key(Key5; "Enrollment No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Line Delete::CSPL-00114::28042019: Start
        AdmitCardLineCS.Reset();
        AdmitCardLineCS.SETRANGE("Document No.", "No.");
        AdmitCardLineCS.DELETEALL();
        //Code added for Line Delete::CSPL-00114::28042019: End
    end;

    trigger OnInsert()
    begin
        //Code added for Insert No Series::CSPL-00114::28042019: Start
        AcademicsSetupCS.GET();
        IF "No." = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Hall Ticket Entry No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Hall Ticket Entry No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        //Code added for Insert No Series::CSPL-00114::28042019: End
    end;

    trigger OnModify()
    begin
        //Code added for any record modified then Updated field Update::CSPL-00114::28042019: Start
        "Updated By" := FORMAT(UserId());
        "Updated On" := TODAY();
        //Code added for any record modified then Updated field Update::CSPL-00114::28042019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";

        AdmitCardHeaderCS: Record "Admit Card Header-CS";
        StudentMasterCS: Record "Student Master-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";


    procedure Assistedit(OldAdmitCardHeaderCS: Record "Admit Card Header-CS"): Boolean
    begin
        //Code added for No Series generation::CSPL-00114::28042019: Start
        WITH AdmitCardHeaderCS DO BEGIN
            AdmitCardHeaderCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Hall Ticket Entry No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Hall Ticket Entry No.", OldAdmitCardHeaderCS."No.Series", "No.Series")
           THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := AdmitCardHeaderCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for No Series generation::CSPL-00114::28042019: End
    end;
}


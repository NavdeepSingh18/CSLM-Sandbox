table 50251 "Student Placement Reg-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   18/04/2019       OnInsert()                                 Get "No Series","Academic Year",Date & "User Id" Values
    // 02    CSPL-00114   18/04/2019       Register No. - OnValidate()                Code added for No Series
    // 03    CSPL-00114   18/04/2019       Student No. - OnValidate()                 Student related Information fill according Student No
    // 02    CSPL-00114   18/04/2019       Assistedit()  -Function                    Code added for No Series
    // 03    CSPL-00114   18/04/2019       DuplicateRegisterCheckCS() - Function      Code add for Check Duplicate

    Caption = 'Student Placement Reg-CS';
    DrillDownPageID = "Register(Placement) List-CS";
    LookupPageID = "Register(Placement) List-CS";

    fields
    {

        field(1; "Register No."; Code[20])
        {
            Caption = 'Register No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No Series::CSPL-00114::18042019: Start
                IF "Register No." <> xRec."Register No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Placement Register No.");
                    "No. Series" := '';
                END;
                //Code added for No Series::CSPL-00114::18042019: End
            end;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Student related Information fill according Student No::CSPL-00114::18042019: Start
                IF DuplicateRegisterCheckCS() THEN
                    IF StudentMasterCS.GET("Student No.") THEN BEGIN
                        "Student Name" := StudentMasterCS."Student Name";
                        Graduation := FORMAT(StudentMasterCS.Graduation);
                        Course := StudentMasterCS."Course Code";
                    END;
                //Student related Information fill according Student No::CSPL-00114::18042019: End
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(4; Graduation; Code[10])
        {
            Caption = 'Graduation';
            DataClassification = CustomerContent;

            TableRelation = "Graduation Master-CS";
        }
        field(5; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(8; History; Integer)
        {
            Caption = 'History';

            CalcFormula = Count ("Student Placement History-CS" WHERE("Student ID" = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(9; Placed; Boolean)
        {
            Caption = 'Placed';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18042019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18042019';
        }
    }

    keys
    {
        key(Key1; "Register No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series","Academic Year" & "User Id" Values::CSPL-00114::18042019: Start
        "User ID" := FORMAT(UserId());
        "Academic year" := VerticalEducationCS.CreateSessionYear();
        IF "Register No." = '' THEN BEGIN
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Register No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Placement Register No.", xRec."No. Series", 0D, "Register No.", "No. Series");
        END;
        //Get "No Series","Academic Year" & "User Id" Values::CSPL-00114::18042019: End
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        StudentPlacementRegCS: Record "Student Placement Reg-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";


        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

    procedure Assistedit(OldStudentPlacementRegCS: Record "Student Placement Reg-CS"): Boolean
    begin
        //Code add for No Series Generation ::CSPL-00114::18042019: Start
        WITH StudentPlacementRegCS DO BEGIN
            StudentPlacementRegCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Register No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Placement Register No.", OldStudentPlacementRegCS."No. Series", "No. Series") THEN BEGIN
                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Register No.");
                NoSeriesMgt.SetSeries("Register No.");
                Rec := StudentPlacementRegCS;
                EXIT(TRUE);
            END;
        END;
        //Code add for No Series Generation ::CSPL-00114::18042019: End
    end;

    procedure DuplicateRegisterCheckCS(): Boolean
    var
        Text000Lbl: Label 'This Student is already registered';
    begin
        //Code add for Check Duplicate ::CSPL-00114::18042019: End
        StudentPlacementRegCS.RESET();
        StudentPlacementRegCS.SETRANGE(StudentPlacementRegCS."Student No.", "Student No.");
        IF StudentPlacementRegCS.FINDFIRST() THEN
            ERROR(Text000Lbl)
        ELSE
            EXIT(TRUE);
        //Code add for Check Duplicate ::CSPL-00114::18042019: End
    end;
}


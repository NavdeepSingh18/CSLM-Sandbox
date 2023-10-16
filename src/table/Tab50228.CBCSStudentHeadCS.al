table 50228 "CBCS Student Head-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    11-05-2019    OnInsert                            No. Series and Assign Value in Fields.
    // 2         CSPL-00092    11-05-2019    No. - OnValidate                    No. Series
    // 3         CSPL-00092    11-05-2019    Student No. - OnValidate            Assign Value in Fields
    // 4         CSPL-00092    11-05-2019    AssistEdit                          Select NoSeries

    Caption = 'CBCS Student Head-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for No. Series::CSPL-00092::11-05-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    //NoSeriesManagement.TestManual(AcademicsSetupCS."Student CBCS No.");
                    "No. Series" := '';
                END;
                //Code added for No. Series::CSPL-00092::11-05-2019: End
            end;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::11-05-2019: Start
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    "Course Code" := StudentMasterCS."Course Code";
                    "Semester Code" := StudentMasterCS.Semester;
                    "Section Code" := StudentMasterCS.Section;
                    CourseWiseSubjectHeadCS.Reset();
                    CourseWiseSubjectHeadCS.SETRANGE(Course, StudentMasterCS."Course Code");
                    CourseWiseSubjectHeadCS.SETRANGE(Semester, StudentMasterCS.Semester);
                    IF CourseWiseSubjectHeadCS.FINDFIRST() THEN
                        "Min Credit" := CourseWiseSubjectHeadCS."Min Credit Points";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::11-05-2019: End
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(4; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(5; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(8; "Min Credit"; Integer)
        {
            Caption = 'Min Credit';
            DataClassification = CustomerContent;
        }
        field(9; "Credit Acheived"; Decimal)
        {
            CalcFormula = Sum ("CBCS Student Line-CS"."Credit" WHERE("Document No." = FIELD("No.")));
            Caption = 'Credit Acheived';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
        }
        field(11; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;
        }
        field(12; "Total no of Elective"; Decimal)
        {
            Caption = 'Total no of Elective';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; "Min Electives-Specialization"; Decimal)
        {
            Caption = 'Min Electives-Specialization';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "Max Electives-Others"; Decimal)
        {
            Caption = 'Max Electives-Others';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Electives-Specialization Taken"; Integer)
        {
            CalcFormula = Count ("Main Student Subject-CS" WHERE("Student No." = FIELD("Student No."),
                                                                 "Subject Type" = FILTER('CBCS'),
                                                                 Specilization = FIELD(FILTER("Student Specialization"))));
            Caption = 'Electives-Specialization Taken';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Electives-Others Taken"; Integer)
        {
            CalcFormula = Count ("Main Student Subject-CS" WHERE("Student No." = FIELD("Student No."),
                                                                 "Subject Type" = FILTER('CBCS'),
                                                                 Specilization = FILTER('')));
            Caption = 'Electives-Others Taken';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Total no of Elective Taken"; Integer)
        {
            Caption = 'Total no of Elective Taken';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Student Specialization"; Code[20])
        {
            CalcFormula = Lookup ("Student Master-CS"."Specialization" WHERE("No." = FIELD("Student No.")));
            Caption = 'Student Specialization';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Final Year Course';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 12-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 12-05-2019';
            DataClassification = CustomerContent;
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
    }

    trigger OnInsert()
    begin
        //Code added for No. Series and Assign Value in Fields::CSPL-00092::11-05-2019: Start
        AcademicsSetupCS.GET();
        IF "No." = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Student CBCS No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Student CBCS No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "CBCS Batch" := AcademicsStageCS.GetDataCBCSBatch();
        "User ID" := FORMAT(UserId());
        //Code added for No. Series and Assign Value in Fields::CSPL-00092::11-05-2019: End
    end;

    var

        AcademicsSetupCS: Record "Academics Setup-CS";
        CBCSStudentHeadCS: Record "CBCS Student Head-CS";

        StudentMasterCS: Record "Student Master-CS";
        CourseWiseSubjectHeadCS: Record "Course Wise Subject Head-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        AcademicsStageCS: Codeunit "Academics Stage-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

    procedure AssistEdit(OldStudentCBCSHeader: Record "CBCS Student Head-CS"): Boolean
    begin
        //Code added for Select No. Series::CSPL-00092::11-05-2019: Start
        WITH CBCSStudentHeadCS DO BEGIN
            CBCSStudentHeadCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Student CBCS No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Student CBCS No.",
            OldStudentCBCSHeader."No. Series", "No. Series")
            THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := CBCSStudentHeadCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Select No. Series::CSPL-00092::11-05-2019: End
    end;
}


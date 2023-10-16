table 50309 "External Exam Header Arch-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   24/02/2019       OnInsert()                                 Get "No Series","Academic Year",Date & "User Id" Values
    // 02    CSPL-00114   24/02/2019       OnDelete()                                 Code added for Lines Deleted
    // 03    CSPL-00114   24/02/2019       No. - OnValidate()                         Code added for No Series Generation
    // 04    CSPL-00114   24/02/2019       Course Code - OnValidate()                 Code Added For the Validation Check
    // 05    CSPL-00114   24/02/2019       Semester - OnValidate()                    Code Added For the Validation Check
    // 06    CSPL-00114   24/02/2019       Subject Type - OnValidate()                Code added for Gat Batch Value & Validation Check
    // 07    CSPL-00114   24/02/2019       Subject Code - OnLookup()                  Code added for Page Lookup & Get Subject Related value
    // 08    CSPL-00114   24/02/2019       External Maximum - OnValidate()            Code added for External Generate Validation
    // 09    CSPL-00114   24/02/2019       Staff Code - OnValidate()                  Code added for External & Internal Generate Validation
    // 10    CSPL-00114   24/02/2019       Section - OnValidate()                     Code added for Validation
    // 11    CSPL-00114   24/02/2019       Total Maximum - OnValidate()               Code added for Validation
    // 12    CSPL-00114   24/02/2019       Assistedit -Function                       Get "No Series" Code added
    // 13    CSPL-00114   24/02/2019       CreateArchiveAuto -Function                Create Archive record Automatic
    // 14    CSPL-00114   24/02/2019       GetVersionCount -Function                  Get VersionCount

    Caption = 'External Exam Header Arch-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No Series Generation::CSPL-00114::24022019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Internal Marks No.");
                    "No.Series" := '';
                END;
                //Code added for No Series Generation::CSPL-00114::24022019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::24022019: End
                TESTFIELD("Subject Type");
                ExternalExamHeaderArchCS.GET("No.");
                IF ExternalExamHeaderArchCS."Internal Generated" OR ExternalExamHeaderArchCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for Validation::CSPL-00114::24022019: End
            end;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::24022019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    Semester := '';
                    ERROR(Text003Lbl, AcademicsSetupCS."CBCS Subject Type");
                END;

                TESTFIELD("Course Code");
                ExternalExamHeaderArchCS.GET("No.");
                IF ExternalExamHeaderArchCS."Internal Generated" OR ExternalExamHeaderArchCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for Validation::CSPL-00114::24022019: End
            end;
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                //Code added for Gat Batch Value & Validation Check::CSPL-00114::24022019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    AcademicsSetupCS.TESTFIELD("CBCS Batch");
                    "CBCS Batch" := AcademicsSetupCS."CBCS Batch";
                END;

                ExternalExamHeaderArchCS.GET("No.");
                IF ExternalExamHeaderArchCS."Internal Generated" OR ExternalExamHeaderArchCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for Gat Batch Value & Validation Check::CSPL-00114::24022019: End
            end;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";

            trigger OnLookup()
            begin
                //Code added for Page Lookup & Get Subject Related value::CSPL-00114::24022019: Start
                TESTFIELD("Subject Type");
                TESTFIELD("Academic Year");
                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD("Common Subject Type");
                ExternalExamHeaderArchCS.GET("No.");
                IF "Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", "Subject Type", "Subject Code");
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        ExternalExamHeaderArchCS.Reset();
                        ExternalExamHeaderArchCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                        ExternalExamHeaderArchCS.SETRANGE("Course Code", "Course Code");
                        ExternalExamHeaderArchCS.SETRANGE(Semester, Semester);
                        ExternalExamHeaderArchCS.SETRANGE(Section, Section);
                        ExternalExamHeaderArchCS.SETRANGE("Academic Year", "Academic Year");
                        ExternalExamHeaderArchCS.SETRANGE("Subject Type", CourseWiseSubjectLineCS."Subject Type");
                        ExternalExamHeaderArchCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        ExternalExamHeaderArchCS.SETRANGE("Result Generated", FALSE);
                        IF ExternalExamHeaderArchCS.ISEMPTY() then BEGIN
                            SubjectMasterCS.Reset();
                            IF SubjectMasterCS.GET(CourseWiseSubjectLineCS."Subject Code") THEN BEGIN
                                "Subject Code" := SubjectMasterCS.Code;
                                "External Maximum" := SubjectMasterCS."External Maximum";
                                "Total Maximum" := SubjectMasterCS."Total Maximum";
                            END;
                        END ELSE BEGIN
                            "Subject Code" := '';
                            "External Maximum" := 0;
                            "Total Maximum" := 0;
                            ERROR(Text004Lbl);
                        END;
                    END;
                END ELSE BEGIN
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETRANGE("Subject Type", "Subject Type");
                    SubjectMasterCS.SETFILTER(Course, '%1|%2', "Course Code", '');
                    IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN BEGIN
                        ExternalExamHeaderArchCS.Reset();
                        ExternalExamHeaderArchCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                        ExternalExamHeaderArchCS.SETRANGE("Course Code", "Course Code");
                        ExternalExamHeaderArchCS.SETRANGE(Semester, Semester);
                        ExternalExamHeaderArchCS.SETRANGE(Section, Section);
                        ExternalExamHeaderArchCS.SETRANGE("Academic Year", "Academic Year");
                        ExternalExamHeaderArchCS.SETRANGE("Subject Type", SubjectMasterCS."Subject Type");
                        ExternalExamHeaderArchCS.SETRANGE("Subject Code", SubjectMasterCS.Code);
                        ExternalExamHeaderArchCS.SETRANGE("Result Generated", FALSE);
                        IF ExternalExamHeaderArchCS.ISEMPTY() then BEGIN
                            "Subject Code" := SubjectMasterCS.Code;
                            "External Maximum" := SubjectMasterCS."External Maximum";
                            "Total Maximum" := SubjectMasterCS."Total Maximum";
                        END ELSE
                            IF ((ExternalExamHeaderArchCS.FINDFIRST()) AND (AcademicsSetupCS."Common Subject Type" = "Subject Type")) OR
                               ((AcademicsSetupCS."Common Subject Type" <> "Subject Type") AND (ExternalExamHeaderArchCS.FINDFIRST()) AND
                               (ExternalExamHeaderArchCS.COUNT() <> 1))
                            THEN BEGIN
                                "Subject Code" := '';
                                "External Maximum" := 0;
                                "Total Maximum" := 0;
                                ERROR(Text004Lbl);
                            END ELSE BEGIN
                                "Subject Code" := SubjectMasterCS.Code;
                                "External Maximum" := SubjectMasterCS."External Maximum";
                                "Total Maximum" := SubjectMasterCS."Total Maximum";
                            END;
                    END;
                END;
                //Code added for Page Lookup & Get Subject Related value::CSPL-00114::24022019: End
            end;
        }
        field(6; "External Maximum"; Decimal)
        {
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validation Check::CSPL-00114::24022019: Start
                ExternalExamHeaderArchCS.GET("No.");
                IF ExternalExamHeaderArchCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for Validation Check::CSPL-00114::24022019: End
            end;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Validation Check::CSPL-00114::24022019: Start
                ExternalExamHeaderArchCS.GET("No.");
                IF ExternalExamHeaderArchCS."Internal Generated" OR ExternalExamHeaderArchCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for Validation Check::CSPL-00114::24022019: End
            end;
        }
        field(9; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validation Check::CSPL-00114::24022019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" <> "Subject Type" THEN BEGIN
                    Section := '';
                    ERROR(Text005Lbl, AcademicsSetupCS."CBCS Subject Type");
                END;
                //Code added for Validation Check::CSPL-00114::24022019: End
                TESTFIELD(Semester);
            end;
        }
        field(11; "Total Maximum"; Decimal)
        {
            Caption = 'Total Maximum';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validation Check::CSPL-00114::24022019: Start
                ExternalExamHeaderArchCS.GET("No.");
                IF ExternalExamHeaderArchCS."External Generated" THEN
                    ERROR(Text002Lbl);
                //Code added for Validation Check::CSPL-00114::24022019: End
            end;
        }
        field(12; "Internal Generated"; Boolean)
        {
            Caption = 'Internal Generated';
            DataClassification = CustomerContent;
        }
        field(13; "External Generated"; Boolean)
        {
            Caption = 'External Generated';
            DataClassification = CustomerContent;
        }
        field(14; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(15; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
        }
        field(50000; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
            OptionCaption = ' ,Open,Released';
            OptionMembers = " ",Open,Released;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Description = 'CS Field Added 24022019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Description = 'CS Field Added 24022019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
        }
        field(50015; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
            TableRelation = "Year Master-CS";
        }
        field(50016; "Internal Maximum"; Decimal)
        {
            Caption = 'Internal Maximum';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
        }
        field(50017; "Minimum Credit Points Required"; Decimal)
        {
            Caption = 'Minimum Credit Points Required';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
        }
        field(50091; "Archived By"; Code[50])
        {
            Caption = 'Archived By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
            Editable = false;
        }
        field(50092; "Archived on"; Date)
        {
            Caption = 'Archived on';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
            Editable = false;
        }
        field(50093; "Archived Time"; Time)
        {
            Caption = 'Archived Time';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
            Editable = false;
        }
        field(50094; "Version No"; Integer)
        {
            Caption = 'Version No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
            Editable = false;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24022019';
        }
    }

    keys
    {
        key(Key1; "No.", "Version No")
        {
        }
        key(Key2; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; "Course Code", Semester, "Subject Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Line Delete::CSPL-00114::24022019: Start
        ExternalExamLineArchCS.Reset();
        ExternalExamLineArchCS.SETRANGE("Document No.", "No.");
        ExternalExamLineArchCS.DELETEALL();
        //Code added for Line Delete::CSPL-00114::24022019: End
    end;

    trigger OnInsert()
    begin
        //Code added for Get "No Series","Academic Year",Date & "User Id" Values::CSPL-00114::24022019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("External Marks No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."External Marks No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for Get "No Series","Academic Year",Date & "User Id" Values::CSPL-00114::24022019: End
    end;

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";

        ExternalExamHeaderArchCS: Record "External Exam Header Arch-CS";

        AcademicsSetupCS: Record "Academics Setup-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        ExternalExamLineArchCS: Record "External Exam Line Arch-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text002Lbl: Label 'You cant modify completed gereration.';
        Text003Lbl: Label 'You  cant enter a semester for subject type %1';
        Text004Lbl: Label 'External marks for this subjets has created already   ';
        Text005Lbl: Label 'You Cannot enter a Section For Subject Type %1.';


    procedure Assistedit(OldStudentExternalHeader: Record "External Exam Header Arch-CS"): Boolean
    begin
        //Code added for Get No series ::CSPL-00114::24022019: Start
        WITH ExternalExamHeaderArchCS DO BEGIN
            ExternalExamHeaderArchCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("External Marks No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."External Marks No.", OldStudentExternalHeader."No.Series", "No.Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := ExternalExamHeaderArchCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Get No series::CSPL-00114::24022019: End
    end;

    procedure CreateArchiveeAuto(Rec: Record "External Exam Head Temp-CS")
    var



        ExternalExamLineTempCS: Record "External Exam Line Temp-CS";

        NoSeriesMgmt: Codeunit "NoSeriesManagement";
    // LineNo: Integer;
    begin
        //Code added for Create Archive record Automatic::CSPL-00114::24022019: End
        IF AcademicsSetupCS.Get() THEN;
        ExternalExamHeaderArchCS.INIT();
        ExternalExamHeaderArchCS.TRANSFERFIELDS(Rec);
        ExternalExamHeaderArchCS."No." := NoSeriesMgmt.GetNextNo(AcademicsSetupCS."Re-Appear External Nos.", TODAY(), TRUE);
        ExternalExamHeaderArchCS.Status := Rec.Status;
        ExternalExamHeaderArchCS."Archived By" := FORMAT(UserId());
        ExternalExamHeaderArchCS."Archived on" := TODAY();
        ExternalExamHeaderArchCS."Archived Time" := TIME();
        ExternalExamHeaderArchCS."Version No" := GetVersionCount(Rec);
        ExternalExamHeaderArchCS.INSERT();

        ExternalExamLineTempCS.Reset();
        ExternalExamLineTempCS.SETRANGE("Document No.", Rec."No.");
        IF ExternalExamLineTempCS.FINDSET() THEN
            REPEAT
                ExternalExamLineArchCS.INIT();
                ExternalExamLineArchCS.TRANSFERFIELDS(ExternalExamLineTempCS);
                ExternalExamLineArchCS."Document No." := ExternalExamHeaderArchCS."No.";
                ExternalExamLineArchCS."Old Doc No" := ExternalExamLineTempCS."Document No.";
                ExternalExamLineArchCS.INSERT();
            UNTIL ExternalExamLineTempCS.NEXT() = 0;
        //Code added for Create Archive record Automatic::CSPL-00114::24022019: End
    end;

    procedure GetVersionCount(TempExternalExamHeadTempCS: Record "External Exam Head Temp-CS"): Integer
    var

    begin
        //Code added for Get VersionCount::CSPL-00114::24022019: Start
        ExternalExamHeaderArchCS.Reset();
        ExternalExamHeaderArchCS.SETRANGE("Course Code", TempExternalExamHeadTempCS."Course Code");
        ExternalExamHeaderArchCS.SETRANGE(Semester, TempExternalExamHeadTempCS.Semester);
        ExternalExamHeaderArchCS.SETRANGE("Subject Type", TempExternalExamHeadTempCS."Subject Type");
        ExternalExamHeaderArchCS.SETRANGE("Subject Code", TempExternalExamHeadTempCS."Subject Code");
        ExternalExamHeaderArchCS.SETRANGE("Academic Year", TempExternalExamHeadTempCS."Academic Year");
        IF ExternalExamHeaderArchCS.FINDLAST() THEN
            EXIT(ExternalExamHeaderArchCS."Version No" + 1)
        ELSE
            EXIT(1);
        //Code added for Get VersionCount::CSPL-00114::24022019: End
    end;
}


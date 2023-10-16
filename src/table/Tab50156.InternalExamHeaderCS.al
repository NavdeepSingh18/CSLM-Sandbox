table 50156 "Internal Exam Header-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                           Remarks
    // 1         CSPL-00092    07-05-2019    OnInsert                          No. Series And Assign Value in Fields.
    // 2         CSPL-00092    07-05-2019    OnModify                        Assign Value in Fields
    // 3         CSPL-00092    07-05-2019    OnDelete                        Delete data form Table
    // 4         CSPL-00092    07-05-2019    No. - OnValidate                No. Series
    // 5         CSPL-00092    07-05-2019    Course Code - OnValidate        Clear Data
    // 6         CSPL-00092    07-05-2019    Subject Type - OnValidate        Validate Data
    // 7         CSPL-00092    07-05-2019    Subject Code - OnValidate        Assign Value in Subject Description Field
    // 8         CSPL-00092    07-05-2019    Subject Code - OnLookup        Assign Value in Subject Description Field
    // 9         CSPL-00092    07-05-2019    Exam Method Code - OnValidate    Assign Value in Exam Description Field
    // 10        CSPL-00092    07-05-2019    Exam Method Code - OnLookup      Assign Value in Fields
    // 11        CSPL-00092    07-05-2019    Exam Schedule Code - OnValidate  Assign Value in Fields
    // 12        CSPL-00092    07-05-2019    Assistedit                      Select No Series

    Caption = 'Internal Exam Header-CS';
    DrillDownPageID = "Internal Student List-CS";
    LookupPageID = "Internal Student List-CS";
    DataCaptionFields = "No.", "Subject Description";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No. Series::CSPL-00092::07-05-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Internal Marks No.");
                    "No.Series" := '';
                END;
                //Code added for No. Series::CSPL-00092::07-05-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Clear Data::CSPL-00092::07-05-2019: Start
                CourseMaster.Get("Course Code");
                "Course Name" := CourseMaster.Description;
                // IF "Course Code" <> xRec."Course Code" THEN BEGIN
                //     Semester := '';
                //     Year := '';
                //     "Type Of Course" := "Type Of Course"::" ";
                //     "Global Dimension 1 Code" := '';
                //     "Global Dimension 2 Code" := '';
                //     "Academic Year" := '';
                //     VALIDATE("Subject Type", '');
                //     VALIDATE("Subject Code", '');
                //     "Staff Code" := '';
                // END;
                //Code added for Clear Data::CSPL-00092::07-05-2019: End
            end;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = IF ("Course Code" = FILTER(<> '')) "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD("Course Code"))
            ELSE
            IF ("Course Code" = FILTER('')) "Semester Master-CS".Code;
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::07-05-2019: Start
                IF "Subject Type" <> xRec."Subject Type" THEN BEGIN
                    VALIDATE("Subject Code", '');
                    VALIDATE("Staff Code", '');
                END;
                //Code added for Validate Data::CSPL-00092::07-05-2019: End
            end;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Assign Value in Subject Description Field::CSPL-00092::07-05-2019: Start
                CourseWiseSubjectLineCS.RESET();
                IF "Course Code" <> '' THEN
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                IF "Type Of Course" = "Type Of Course"::Semester THEN
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester)
                ELSE
                    CourseWiseSubjectLineCS.SETRANGE(Year, Year);
                IF CourseWiseSubjectLineCS.FINDSET() THEN
                    IF "PAGE".RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        "Subject Description" := CourseWiseSubjectLineCS.Description;
                    END;
                //Code added for Assign Value in Subject Description Field::CSPL-00092::07-05-2019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Subject Description Field::CSPL-00092::07-05-2019: Start
                SubjectMasterCS1.RESET();
                SubjectMasterCS1.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS1.FINDFIRST() THEN
                    "Subject Description" := SubjectMasterCS1.Description
                else
                    "Subject Description" := '';
                //Code added for Assign Value in Subject Description Field::CSPL-00092::07-05-2019: End
            end;
        }
        field(6; "Exam Method Code"; Code[20])
        {
            Caption = 'Exam Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Sessional Exam Group-CS"."Exam Method Code" WHERE("Exam Type" = FILTER('Internal Exam'));

            trigger OnLookup()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: Start
                AcademicsSetupCS.GET();
                IF AcademicsSetupCS."Common Subject Type" = "Subject Type" THEN BEGIN
                    CourseWiseSubjectLineCS.RESET();
                    CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Type", "Subject Code");
                    IF "Course Code" <> '' THEN
                        CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                    CourseWiseSubjectLineCS.SETRANGE("Subject Code", "Subject Code");
                    IF CourseWiseSubjectLineCS.FINDFIRST() THEN BEGIN
                        SessionalExamGroupCS.RESET();
                        SessionalExamGroupCS.SETCURRENTKEY(Group);
                        SessionalExamGroupCS.SETRANGE(Group, CourseWiseSubjectLineCS."Group Code");
                        SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Exam");
                        IF "PAGE".RUNMODAL(0, SessionalExamGroupCS) = ACTION::LookupOK THEN BEGIN
                            InternalExamLineCS.RESET();
                            InternalExamLineCS.SETRANGE("Document No.", "No.");
                            IF InternalExamLineCS.FINDFIRST() THEN
                                ERROR(Text004Lbl)
                            ELSE BEGIN
                                "Exam Method Code" := SessionalExamGroupCS."Exam Method Code";
                                "Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
                                "Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
                            END;
                        END ELSE
                            IF xRec."Exam Method Code" = '' THEN BEGIN
                                "Exam Method Code" := '';
                                "Maximum Mark" := 0;
                            END ELSE BEGIN
                                "Exam Method Code" := xRec."Exam Method Code";
                                "Maximum Mark" := xRec."Maximum Mark";
                                "Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
                            END;

                    END;
                END ELSE BEGIN
                    SubjectMasterCS.RESET();
                    SubjectMasterCS.SETRANGE("Subject Type", "Subject Type");
                    SubjectMasterCS.SETRANGE(Code, "Subject Code");
                    IF SubjectMasterCS.FINDFIRST() THEN BEGIN
                        SessionalExamGroupCS.RESET();
                        SessionalExamGroupCS.SETCURRENTKEY(Group);
                        SessionalExamGroupCS.SETRANGE(Group, SubjectMasterCS."Group Code");
                        SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Exam");
                        IF "PAGE".RUNMODAL(0, SessionalExamGroupCS) = ACTION::LookupOK THEN BEGIN
                            InternalExamLineCS.RESET();
                            InternalExamLineCS.SETRANGE("Document No.", "No.");
                            IF InternalExamLineCS.FINDFIRST() THEN
                                ERROR(Text004Lbl)
                            ELSE BEGIN
                                "Exam Method Code" := SessionalExamGroupCS."Exam Method Code";
                                "Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
                                "Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
                            END;

                        END ELSE
                            IF xRec."Exam Method Code" = '' THEN BEGIN
                                "Exam Method Code" := '';
                                "Maximum Mark" := 0;
                            END ELSE BEGIN
                                "Exam Method Code" := xRec."Exam Method Code";
                                "Maximum Mark" := xRec."Maximum Mark";
                                "Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
                            END;
                    END;
                END;
                //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Exam Description Field::CSPL-00092::07-05-2019: Start
                IF ExamGroupCodeCS.GET("Exam Method Code") THEN
                    "Exam Description" := ExamGroupCodeCS.Description;
                //Code added for Assign Value in Exam Description Field::CSPL-00092::07-05-2019: End
            end;
        }
        field(7; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            DataClassification = CustomerContent;
            Description = '//UnEditable';
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(9; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(10; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(11; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = IF ("Course Code" = FILTER(<> '')) "Course Section Master-CS"."Section Code" WHERE("Course Code" = FIELD("Course Code"))
            ELSE
            IF ("Course Code" = FILTER('')) "Section Master-CS".Code;
        }
        field(12; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(13; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course ';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50015; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50016; "Exam Group"; Code[20])
        {
            Caption = 'Exam Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Sessional Exam Group-CS".Group WHERE("Exam Type" = FILTER('Internal Exam'));
        }
        field(50030; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;

            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            OptionCaption = 'Open,Released,Published';
            OptionMembers = Open,Released,Published;

            trigger OnValidate()
            begin
                Updated := TRUE;
            end;
        }
        field(50031; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(50032; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            OptionCaption = ' ,Regular,Re-Sessional';
            OptionMembers = " ",Regular,"Re-Sessional";
        }
        field(50033; "Exam Schedule Code"; Code[20])
        {
            Caption = 'Exam Schedule Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Exam Time Table Line-CS" WHERE("Examiner Type" = FIELD("Document Type"));

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: Start
                ExamTimeTableLineCS.RESET();
                ExamTimeTableLineCS.SETRANGE(ExamTimeTableLineCS."Document No.", "Exam Schedule Code");
                IF ExamTimeTableLineCS.FINDFIRST() THEN BEGIN
                    VALIDATE("Course Code", ExamTimeTableLineCS."Course Code");
                    Semester := ExamTimeTableLineCS."Semester Code";
                    "Subject Type" := ExamTimeTableLineCS."Subject Type";
                    VALIDATE("Subject Code", ExamTimeTableLineCS."Subject Code");
                    "Academic Year" := ExamTimeTableLineCS."Academic Year";
                END ELSE BEGIN
                    "Course Code" := '';
                    Semester := '';
                    "Subject Type" := '';
                    "Subject Code" := '';
                    "Academic Year" := '';
                END;
                //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: End
            end;
        }
        field(50034; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Subject Classification-CS";
        }
        field(50035; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50036; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50037; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50038; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50039; "Exam Description"; Text[50])
        {
            Caption = 'Exam Description';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50040; "Subject Description"; Text[100])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50041; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50042; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50043; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Group Master-CS".Code;
        }
        field(50044; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50045; "Exam Classification"; Code[20])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            TableRelation = "Examination Type Master-CS".Code WHERE("Exam Type" = FIELD("Document Type"));
        }
        field(50046; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
            TableRelation = "Examination Time Slot-CS";
        }
        field(50056; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            TableRelation = "Batch-CS".Code;
        }
        field(50061; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50062; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33048920; "User ID"; Code[50])
        {

            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048922; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048923; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048924; "Modified By"; Text[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048925; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048928; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code", "Exam Method Code")
        {
        }
        key(Key3; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key4; "Course Code", Semester, "Academic Year", Term, "Subject Code", "Global Dimension 1 Code", "Exam Classification")
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Delete data form Table::CSPL-00092::07-05-2019: Start


        TestField(Status, Status::Open);

        // InternalExamLineCS.RESET();
        // InternalExamLineCS.SETRANGE("Document No.", "No.");
        // InternalExamLineCS.SetFilter("Obtained Internal Marks", '<>%1', 0);
        // IF InternalExamLineCS.FindFirst() then
        //     Error('Obtained Internal Marks must be Zero');

        InternalExamLineCS.RESET();
        InternalExamLineCS.SETRANGE("Document No.", "No.");
        if InternalExamLineCS.FindSet() then
            repeat
                InternalExamLineCS.DELETE(true);
            until InternalExamLineCS.Next() = 0;

        ExamTimeTableLineCS.Reset();
        ExamTimeTableLineCS.SetRange("Exam No.", "No.");
        IF ExamTimeTableLineCS.FindSet() then
            ExamTimeTableLineCS.ModifyAll(ExamTimeTableLineCS."Exam No.", '');
        //Code added for Delete data form Table::CSPL-00092::07-05-2019: End
    end;

    trigger OnInsert()
    begin
        //Code added for No. Series And Assign Value in Fields::CSPL-00092::07-05-2019: Start
        AcademicsSetupCS.GET();
        IF "No." = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Internal Marks No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Internal Marks No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "User ID" := FORMAT(UserId());
        "Document Type" := "Document Type"::Internal;
        "Exam Type" := "Exam Type"::Regular;
        "Created By" := FORMAT(UserId());
        "Created On" := Today();
        //Code added for No. Series And Assign Value in Fields::CSPL-00092::07-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: Start
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();

        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: End
    end;

    var


        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";

        ExamGroupCodeCS: Record "Exam Group Code-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        SubjectMasterCS1: Record "Subject Master-CS";
        SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        CourseMaster: Record "Course Master-CS";
        DimensionManagement: Codeunit "DimensionManagement";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

        Text004Lbl: Label 'Method code cannot be modified.';



    procedure Assistedit(OldStudentInternalHeader: Record "Internal Exam Header-CS"): Boolean
    begin
        // Code added for Select No Series::CSPL - 00092::07-05-2019: Start
        // WITH InternalExamHeaderCS DO BEGIN
        //     InternalExamHeaderCS := Rec;
        //     AcademicsSetupCS.GET();
        //     AcademicsSetupCS.TESTFIELD("Internal Marks No.");
        //     IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Internal Marks No.", OldStudentInternalHeader."No.Series", "No.Series")
        //     THEN BEGIN
        //         NoSeriesManagement.SetSeries("No.");
        //         Rec := InternalExamHeaderCS;
        //         EXIT(TRUE);
        //     END;
        // END;
        //Code added for Select No Series::CSPL-00092::07-05-2019: End
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimensionManagement.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No." <> '' THEN
            Modify();
    end;
}


report 50090 "Marks Report Faculty-CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Marks Report Faculty-CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Marks Report Faculty';
    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            column(DimensionValue_Image; 'DimensionValue.Image')
            {
            }
            column(EnrollmentNo; 'EnrollmentNo')
            {
            }
            column(Dim; 'Dim')
            {
            }
            column(CourseCode; 'CourseCode')
            {
            }
            column(SubjectCode; 'SubjectCode')
            {
            }
            column(Semester1; 'Semester1')
            {
            }
            column(AcademicYear; 'AcademicYear')
            {
            }
            column(Section1; 'Section1')
            {
            }
        }
        dataitem("Main Student Subject-CS"; "Main Student Subject-CS")
        {
            DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                WHERE("Subject Class" = FILTER(<> 'LAB'));
            PrintOnlyIfDetail = false;
            column(SubjectCode_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Subject Code")
            {
            }
            column(Section_StudentSubjectCOLLEGE; "Main Student Subject-CS".Section)
            {
            }
            column(EnrollmentNo_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Enrollment No")
            {
            }
            column(RollNo_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Roll No.")
            {
            }
            column(AttendanceType_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Attendance Type")
            {
            }
            column(StudentName_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Student Name")
            {
            }
            column(TotalClassHeld_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Total Class Held")
            {
            }
            column(TotalAttendanceTaken_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Total Attendance Taken")
            {
            }
            column(PresentCount_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Present Count")
            {
            }
            column(AbsentCount_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Absent Count")
            {
            }
            column(AttendancePercentage_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Attendance Percentage")
            {
            }
            column(AssignmentMarks_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Assignment Marks")
            {
            }
            column(TotalInternal_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Total Internal")
            {
            }
            column(Internal1; 'Internal1')
            {
            }
            column(Internal2; 'Internal2')
            {
            }
            column(SubjectType; 'SubjectType')
            {
            }
            column(RollNo1; 'RollNo1')
            {
            }
            column(SubjectDesc; 'SubjectDesc')
            {
            }
            column(GETFILTERS1; "Main Student Subject-CS".GETFILTERS())
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Main Student Subject-CS"."Roll No." <> '' THEN BEGIN
                    EVALUATE(VarInteger, "Main Student Subject-CS"."Roll No.");
                    RollNo1 := VarInteger;
                END;


                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "Main Student Subject-CS"."Subject Code");
                IF SubjectMasterCS.findfirst() THEN
                    SubjectDesc := SubjectMasterCS.Description;

                InternalExamLineCS.Reset();
                InternalExamLineCS.SETRANGE(InternalExamLineCS."Student No.", "Student No.");
                InternalExamLineCS.SETRANGE(InternalExamLineCS.Semester, Semester);
                InternalExamLineCS.SETRANGE(InternalExamLineCS."Subject Code", "Subject Code");
                InternalExamLineCS.SETRANGE(InternalExamLineCS.Section, Section);
                InternalExamLineCS.SETRANGE(InternalExamLineCS."Academic Year", "Academic Year");
                //InternalExamLineCS.SETRANGE(InternalExamLineCS.Status,InternalExamLineCS.Status::Published);
                IF InternalExamLineCS.findset() THEN
                    REPEAT
                        IF InternalExamLineCS."Exam Method Code" = 'IA1' THEN
                            IF (InternalExamLineCS."Attendance Type" = InternalExamLineCS."Attendance Type"::Absent) OR (InternalExamLineCS."Attendance Type" = InternalExamLineCS."Attendance Type"::" ") THEN
                                Internal1 := 'AB'
                            ELSE
                                Internal1 := FORMAT(InternalExamLineCS."Obtained Internal Marks");

                        IF InternalExamLineCS."Exam Method Code" = 'IA2' THEN
                            IF (InternalExamLineCS."Attendance Type" = InternalExamLineCS."Attendance Type"::Absent) OR (InternalExamLineCS."Attendance Type" = InternalExamLineCS."Attendance Type"::" ") THEN
                                Internal2 := 'AB'
                            ELSE
                                Internal2 := FORMAT(InternalExamLineCS."Obtained Internal Marks");

                    UNTIL InternalExamLineCS.NEXT() = 0;

            end;

            trigger OnPreDataItem()
            begin
                IF Dim <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS"."Global Dimension 1 Code", Dim);

                IF SubjectCode <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS"."Subject Code", SubjectCode);

                IF CourseCode <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS".Course, CourseCode);

                IF AcademicYear <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS"."Academic Year", AcademicYear);

                IF EnrollmentNo <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS"."Enrollment No", EnrollmentNo);

                IF Semester1 <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS".Semester, Semester1);

                IF Section1 <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS".Section, Section1);
            end;
        }
        dataitem("Optional Student Subject-CS"; "Optional Student Subject-CS")
        {
            DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                WHERE("Subject Class" = FILTER(<> 'LAB'));
            PrintOnlyIfDetail = false;
            column(SubjectCode_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Subject Code")
            {
            }
            column(Section_StudentOptionalSubjectCOL; "Optional Student Subject-CS".Section)
            {
            }
            column(EnrollmentNo_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Enrollment No")
            {
            }
            column(RollNo_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Roll No.")
            {
            }
            column(AttendanceType_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Attendance Type")
            {
            }
            column(StudentName_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Student Name")
            {
            }
            column(TotalClassHeld_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Total Class Held")
            {
            }
            column(TotalAttendanceTaken_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Total Attendance Taken")
            {
            }
            column(PresentCount_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Present Count")
            {
            }
            column(AbsentCount_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Absent Count")
            {
            }
            column(AttendancePercentage_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Attendance Percentage")
            {
            }
            column(AssignmentMarks_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Assignment Marks")
            {
            }
            column(TotalInternal_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Total Internal")
            {
            }
            column(RollNo2; RollNo2)
            {
            }
            column(SubjectDesc1; SubjectDesc1)
            {
            }
            column(Internal3; Internal3)
            {
            }
            column(Internal4; Internal4)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Main Student Subject-CS"."Roll No." <> '' THEN BEGIN
                    EVALUATE(VarInteger1, "Main Student Subject-CS"."Roll No.");
                    RollNo2 := VarInteger1;
                END;

                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "Optional Student Subject-CS"."Subject Code");
                IF SubjectMasterCS.findfirst() THEN
                    SubjectDesc1 := SubjectMasterCS.Description;


                InternalExamLineCS.Reset();
                InternalExamLineCS.SETRANGE(InternalExamLineCS."Student No.", "Student No.");
                InternalExamLineCS.SETRANGE(InternalExamLineCS.Semester, Semester);
                InternalExamLineCS.SETRANGE(InternalExamLineCS."Subject Code", "Subject Code");
                InternalExamLineCS.SETRANGE(InternalExamLineCS.Section, Section);
                InternalExamLineCS.SETRANGE(InternalExamLineCS."Academic Year", "Academic Year");
                //InternalExamLineCS.SETRANGE(InternalExamLineCS.Status,InternalExamLineCS.Status::Published);
                IF InternalExamLineCS.findset() then
                    REPEAT
                        IF InternalExamLineCS."Exam Method Code" = 'IA1' THEN
                            IF (InternalExamLineCS."Attendance Type" = InternalExamLineCS."Attendance Type"::Absent) OR (InternalExamLineCS."Attendance Type" = InternalExamLineCS."Attendance Type"::" ") THEN
                                Internal3 := 'AB'
                            ELSE
                                Internal3 := FORMAT(InternalExamLineCS."Obtained Internal Marks");

                        IF InternalExamLineCS."Exam Method Code" = 'IA2' THEN
                            IF (InternalExamLineCS."Attendance Type" = InternalExamLineCS."Attendance Type"::Absent) OR (InternalExamLineCS."Attendance Type" = InternalExamLineCS."Attendance Type"::" ") THEN
                                Internal4 := 'AB'
                            ELSE
                                Internal4 := FORMAT(InternalExamLineCS."Obtained Internal Marks");

                    UNTIL InternalExamLineCS.NEXT() = 0;

            end;

            trigger OnPreDataItem()
            begin
                IF Dim <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS"."Global Dimension 1 Code", Dim);

                IF SubjectCode <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS"."Subject Code", SubjectCode);

                IF CourseCode <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS".Course, CourseCode);

                IF AcademicYear <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS"."Academic Year", AcademicYear);

                IF EnrollmentNo <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS"."Enrollment No", EnrollmentNo);

                IF Semester1 <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS".Semester, Semester1);

                IF Section1 <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS".Section, Section1);
                /*
                IF Batch1 <> '' THEN
                  "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS".Batch,Batch1);
                */

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field("Start Date"; StartDate)
                    {
                        Visible = false;
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Start Date may have a value';
                    }
                    field("End Date"; EndDate)
                    {
                        Visible = false;
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'End Date may have a value';
                    }
                    field("Enrollment No."; EnrollmentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Enrollment No.';
                        ToolTip = 'Enrollment No. may have a value';
                    }
                    field("Institude Code"; Dim)
                    {
                        ApplicationArea = All;
                        Caption = 'Institude Code';
                        ToolTip = 'Institude Code may have a value';
                        TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('INSTITUTE'));
                    }
                    field("Course Code"; CourseCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Course Code';
                        ToolTip = 'Course Code may have a value';
                        TableRelation = "Course Master-CS".Code;
                    }
                    field("Subject Code"; SubjectCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Subject Code';
                        ToolTip = 'Subject Code may have a value';
                        TableRelation = "Subject Master-CS".Code;

                        trigger OnValidate()
                        begin
                            SubjectMasterCS.Reset();
                            SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, SubjectCode);
                            IF SubjectMasterCS.findfirst() THEN
                                SubjectType := SubjectMasterCS."Subject Type";

                        end;
                    }
                    field("Subject Type"; SubjectType)
                    {
                        ApplicationArea = All;
                        Caption = 'Subject Type';
                        ToolTip = 'Subject Type may have a value';
                    }
                    field(Semester; Semester1)
                    {
                        ApplicationArea = All;
                        Caption = 'Semester';
                        ToolTip = 'Semester may have a value';
                        TableRelation = "Semester Master-CS".Code;
                    }
                    field("Academic Year"; AcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        ToolTip = 'Academic Year may have a value';
                        TableRelation = "Academic Year Master-CS".Code;
                    }
                    field(Section; Section1)
                    {
                        ApplicationArea = All;
                        Caption = 'Section';
                        ToolTip = 'Section may have a value';
                        TableRelation = "Section Master-CS".Code;
                    }
                    field(Batch; Batch1)
                    {
                        TableRelation = "Main Student Subject-CS";
                        ApplicationArea = All;
                        Caption = 'Batch';
                        ToolTip = 'Batch may have a value';
                        Visible = false;
                    }
                    field("Applicable Attendance %"; ApplicableAttendancePercentage)
                    {
                        Visible = false;
                        ApplicationArea = All;
                        Caption = 'Applicable Attendance %';
                        ToolTip = 'Applicable Attendance % may have a value';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        IF Dim = '' THEN
            ERROR('Please Mandatory a Institude Code Filter.');

        DimensionValue.Reset();
        DimensionValue.SETRANGE(DimensionValue.Code, '09');
        DimensionValue.findfirst();
        DimensionValue.CALCFIELDS(DimensionValue.Image);
    end;

    var
        SubjectMasterCS: Record "Subject Master-CS";
        DimensionValue: Record "Dimension Value";
        InternalExamLineCS: Record "Internal Exam Line-CS";

        StartDate: Date;
        EndDate: Date;
        EnrollmentNo: Code[20];
        Dim: Code[20];
        CourseCode: Code[20];
        SubjectCode: Code[20];
        Semester1: Code[20];
        AcademicYear: Code[20];
        Section1: Code[20];
        Batch1: Code[20];
        ApplicableAttendancePercentage: Decimal;
        SubjectType: Text[50];
        VarInteger: Integer;
        RollNo1: Integer;
        VarInteger1: Integer;
        RollNo2: Integer;
        SubjectDesc: Text[100];
        SubjectDesc1: Text[100];
        Internal1: Code[10];
        Internal2: Code[10];
        Internal3: Code[10];
        Internal4: Code[10];
}
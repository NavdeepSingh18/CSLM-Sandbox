report 50072 "Publish Internal Mark CS"
{
    // version V.001-CS

    PreviewMode = PrintLayout;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Publish Internal Mark';
    dataset
    {
        dataitem("Main Student Subject-CS"; "Main Student Subject-CS")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Student No.";

            trigger OnAfterGetRecord()
            begin

                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));


                InternalMax1 := 0;
                InternalObtained1 := 0;
                InternalExamLineCS.Reset();
                InternalExamLineCS.SETCURRENTKEY("Student No.", "Academic Year", Semester, "Subject Class", "Subject Type", "Subject Code");
                InternalExamLineCS.SETRANGE("Student No.", "Student No.");
                InternalExamLineCS.SETRANGE("Academic Year", "Academic Year");
                InternalExamLineCS.SETRANGE(Semester, Semester);
                InternalExamLineCS.SETRANGE("Subject Class", "Subject Class");
                InternalExamLineCS.SETRANGE("Subject Type", "Subject Type");
                InternalExamLineCS.SETRANGE("Subject Code", "Subject Code");
                IF InternalExamLineCS.findset() THEN BEGIN
                    InternalExamLineCS.SETRANGE(Status, InternalExamLineCS.Status::Published);
                    IF InternalExamLineCS.findset() THEN
                        REPEAT
                            InternalMax1 := InternalMax1 + InternalExamLineCS."Maximum Internal  Marks";
                            InternalObtained1 := InternalObtained1 + InternalExamLineCS."Obtained Internal Marks";
                        UNTIL InternalExamLineCS.NEXT() = 0
                END;


                AssignmentMax1 := 0;
                AssignmentObtained1 := 0;
                ClassAssignmentLineCS.Reset();
                ClassAssignmentLineCS.SETCURRENTKEY("Student No.", "Academic Year", Semester, "Subject Class", "Subject Type", "Subject Code");
                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Student No.", "Student No.");
                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Academic Year", "Academic Year");
                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS.Semester, Semester);
                ClassAssignmentLineCS.SETRANGE("Subject Class", "Subject Class");
                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Subject Type", "Subject Type");
                ClassAssignmentLineCS.SETRANGE("Subject Code", "Subject Code");
                IF ClassAssignmentLineCS.findset() THEN BEGIN
                    ClassAssignmentLineCS.SETRANGE(Status, ClassAssignmentLineCS.Status::Published);
                    IF ClassAssignmentLineCS.findset() THEN
                        REPEAT
                            AssignmentMax1 := AssignmentMax1 + ClassAssignmentLineCS."Maximum Mark";
                            AssignmentObtained1 := AssignmentObtained1 + ClassAssignmentLineCS."Marks Obtained";
                        UNTIL ClassAssignmentLineCS.NEXT() = 0
                END;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("No.", "Main Student Subject-CS"."Student No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    //IF StudentMasterCS."Admitted Year" > '2011-2012' THEN BEGIN
                    TotalMax1 := InternalMax1 + AssignmentMax1;
                    TotalObtained1 := InternalObtained1 + AssignmentObtained1;
                    IF TotalMax1 <> 0 THEN begin
                        IF "Main Student Subject-CS"."Subject Class" = 'THEORY' THEN BEGIN
                            "Main Student Subject-CS"."Internal Mark" := InternalObtained1;
                            "Main Student Subject-CS"."Assignment Marks" := AssignmentObtained1;
                            "Main Student Subject-CS"."Total Internal" := ROUND((TotalObtained1 / TotalMax1) * "Internal Maximum", 1, '>');
                        END ELSE
                            IF "Main Student Subject-CS"."Subject Class" = 'LAB' THEN
                                IF AssignmentMax1 <> 0 THEN BEGIN
                                    "Main Student Subject-CS"."Internal Mark" := InternalObtained1;
                                    "Main Student Subject-CS"."Assignment Marks" := ROUND((AssignmentObtained1 / AssignmentMax1) * "Internal Maximum", 1, '>');
                                    "Main Student Subject-CS"."Total Internal" := ROUND((AssignmentObtained1 / AssignmentMax1) * "Internal Maximum", 1, '>');
                                END;

                        "Main Student Subject-CS"."Internal Marks Updated" := TRUE;
                        "Main Student Subject-CS".Updated := TRUE;
                        "Main Student Subject-CS".Modify();
                    END;
                    //END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                PROGRESS.close();
            end;

            trigger OnPreDataItem()
            begin

                "Main Student Subject-CS".Reset();
                IF AcademicYear <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS"."Academic Year", AcademicYear);
                IF CourseCode <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS".Course, CourseCode);
                IF Sem <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS".Semester, Sem);
                IF Sec <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS".Section, Sec);
                IF EnrollmentNo <> '' THEN
                    "Main Student Subject-CS".SETRANGE("Main Student Subject-CS"."Enrollment No", EnrollmentNo);

                TotalCount := COUNT();
                PROGRESS.OPEN(Text_10001Lbl);
            end;
        }
        dataitem("Optional Student Subject-CS"; "Optional Student Subject-CS")
        {
            DataItemTableView = SORTING(Course, Semester, "Academic Year", "Subject Type", "Subject Code");

            trigger OnAfterGetRecord()
            begin

                Counter1 := Counter1 + 1;
                PROGRESS1.UPDATE(1, Counter1);
                PROGRESS1.UPDATE(2, ROUND(Counter1 / TotalCount1 * 10000, 1));

                InternalMax2 := 0;
                InternalObtained2 := 0;
                InternalExamLineCS.Reset();
                InternalExamLineCS.SETCURRENTKEY("Student No.", "Academic Year", Semester, "Subject Class", "Subject Type", "Subject Code");
                InternalExamLineCS.SETRANGE(InternalExamLineCS."Student No.", "Student No.");
                InternalExamLineCS.SETRANGE(InternalExamLineCS."Academic Year", "Academic Year");
                InternalExamLineCS.SETRANGE(InternalExamLineCS.Semester, Semester);
                InternalExamLineCS.SETRANGE("Subject Type", "Subject Type");
                InternalExamLineCS.SETRANGE("Subject Code", "Subject Code");
                IF InternalExamLineCS.findset() THEN BEGIN
                    InternalExamLineCS.SETRANGE(Status, InternalExamLineCS.Status::Published);
                    IF InternalExamLineCS.findset() THEN
                        REPEAT
                            InternalMax2 += InternalExamLineCS."Maximum Internal  Marks";
                            InternalObtained2 += InternalExamLineCS."Obtained Internal Marks";
                        UNTIL InternalExamLineCS.NEXT() = 0
                END;

                AssignmentMax2 := 0;
                AssignmentObtained2 := 0;
                ClassAssignmentLineCS.Reset();
                ClassAssignmentLineCS.SETCURRENTKEY("Student No.", "Academic Year", Semester, "Subject Class", "Subject Type", "Subject Code");
                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Student No.", "Student No.");
                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Academic Year", "Academic Year");
                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS.Semester, Semester);
                ClassAssignmentLineCS.SETRANGE("Subject Type", "Subject Type");
                ClassAssignmentLineCS.SETRANGE("Subject Code", "Subject Code");
                IF ClassAssignmentLineCS.findset() THEN BEGIN
                    ClassAssignmentLineCS.SETRANGE(Status, InternalExamLineCS.Status::Published);
                    IF ClassAssignmentLineCS.findset() THEN
                        REPEAT
                            AssignmentMax2 += ClassAssignmentLineCS."Maximum Mark";
                            AssignmentObtained2 += ClassAssignmentLineCS."Marks Obtained";
                        UNTIL ClassAssignmentLineCS.NEXT() = 0
                END;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("No.", "Main Student Subject-CS"."Student No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    //IF StudentMasterCS."Admitted Year" > '2013-2014' THEN BEGIN
                    TotalMax2 := InternalMax2 + AssignmentMax2;
                    TotalObtained2 := InternalObtained2 + AssignmentObtained2;
                    IF TotalMax2 <> 0 THEN BEGIN
                        IF "Optional Student Subject-CS"."Subject Class" = 'THEORY' THEN BEGIN
                            "Optional Student Subject-CS"."Internal Obtained" := InternalObtained2;
                            "Optional Student Subject-CS"."Assignment Marks" := AssignmentObtained2;
                            "Optional Student Subject-CS"."Total Internal" := ROUND((TotalObtained2 / TotalMax2) * "Internal Maximum", 1, '>');
                        END ELSE
                            IF "Optional Student Subject-CS"."Subject Class" = 'LAB' THEN
                                IF AssignmentMax2 <> 0 THEN BEGIN
                                    "Optional Student Subject-CS"."Internal Obtained" := InternalObtained2;
                                    "Optional Student Subject-CS"."Assignment Marks" := ROUND((AssignmentObtained2 / AssignmentMax2) * "Internal Maximum", 1, '>');
                                    "Optional Student Subject-CS"."Total Internal" := ROUND((AssignmentObtained2 / AssignmentMax2) * "Internal Maximum", 1, '>');
                                END;

                        "Optional Student Subject-CS"."Internal Marks Updated" := TRUE;
                        "Optional Student Subject-CS".Updated := TRUE;
                        "Optional Student Subject-CS".Modify();
                    END;
                    //END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                PROGRESS1.close();
            end;

            trigger OnPreDataItem()
            begin

                "Optional Student Subject-CS".Reset();
                IF AcademicYear <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS"."Academic Year", AcademicYear);
                IF CourseCode <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS".Course, CourseCode);
                IF Sem <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS".Semester, Sem);
                IF Sec <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS".Section, Sec);
                IF EnrollmentNo <> '' THEN
                    "Optional Student Subject-CS".SETRANGE("Optional Student Subject-CS"."Enrollment No", EnrollmentNo);

                TotalCount1 := COUNT();
                PROGRESS1.OPEN(Text_10001Lbl);
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
                field("Academic Year"; AcademicYear)
                {
                    ApplicationArea = All;
                    TableRelation = "Academic Year Master-CS".Code;
                    Caption = 'Academic Year';
                    ToolTip = 'Academic Year may have a value';

                }
                field("Course Code"; CourseCode)
                {
                    ApplicationArea = All;
                    TableRelation = "Course Master-CS".Code;
                    Caption = 'Course Code';
                    ToolTip = 'Course Code may have a value';
                }
                field(Semester; Sem)
                {
                    ApplicationArea = All;
                    TableRelation = "Semester Master-CS".Code;
                    Caption = 'Semester';
                    ToolTip = 'Semester may have a value';
                }
                field(Section; Sec)
                {
                    ApplicationArea = All;
                    TableRelation = "Section Master-CS".Code;
                    Caption = 'Section';
                    ToolTip = 'Section may have a value';
                }
                field("Enrollment No"; EnrollmentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                    ToolTip = 'Enrollment No. may have a value';
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

    trigger OnPostReport()
    begin
        MESSAGE('Marks Published Successfully !!!');
    end;

    var
        InternalExamLineCS: Record "Internal Exam Line-CS";
        ClassAssignmentLineCS: Record "Class Assignment Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        AssignmentObtained1: Decimal;
        AssignmentMax1: Decimal;
        AssignmentObtained2: Decimal;
        AssignmentMax2: Decimal;
        InternalObtained1: Decimal;
        InternalMax1: Decimal;
        InternalObtained2: Decimal;
        InternalMax2: Decimal;
        TotalMax1: Decimal;
        TotalMax2: Decimal;
        TotalObtained1: Decimal;
        TotalObtained2: Decimal;

        AcademicYear: Code[20];
        CourseCode: Code[20];
        Sem: Code[20];
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING... #1  Out Of  @2 .', Comment = '#1 = No. of Counts';
        Counter1: Integer;
        TotalCount1: Integer;
        PROGRESS1: Dialog;
        Sec: Code[20];
        EnrollmentNo: Code[20];
}


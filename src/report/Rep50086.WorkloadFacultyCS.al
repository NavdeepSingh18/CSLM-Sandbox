report 50086 "Workload Faculty CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Workload Faculty CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Workload Faculty';
    dataset
    {
        dataitem("Employee"; "Employee")
        {
            column(F1; F1)
            {
            }
            column(Name; Name)
            {
            }
            column(NoSub1; NoSub1)
            {
            }
            column(NoSub2; NoSub2)
            {
            }
            column(NoSub3; NoSub3)
            {
            }
            column(NoSub4; NoSub4)
            {
            }
            column(Hour1; Hour1)
            {
            }
            column(Hour2; Hour2)
            {
            }
            column(Hour3; Hour3)
            {
            }
            column(Hour4; Hour4)
            {
            }
            column(SrNo; SrNo)
            {
            }
            column(Num; Num)
            {
            }
            column(GETFILTERS; Employee.GETFILTERS())
            {
            }
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(EvenOddSemester; EvenOddSemester)
            {
            }
            column(AcademicYear; AcademicYear)
            {
            }
            column(DepartmentCode; DepartmentCode)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sub1 := '';
                Sub2 := '';
                Sub3 := '';
                Sub4 := '';
                Hour1 := 0;
                Hour2 := 0;
                Hour3 := 0;
                Hour4 := 0;
                SrNo += 1;
                Fb1 := '';
                NoSub1 := 0;
                NoSub2 := 0;
                NoSub3 := 0;
                NoSub4 := 0;

                // Odd semester
                IF EvenOddSemester = EvenOddSemester::"Odd Semester" THEN BEGIN
                    FacultyCourseWiseCS.Reset();
                    FacultyCourseWiseCS.SETCURRENTKEY("Subject Code", "Subject Class");
                    FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Academic Year", AcademicYear);
                    FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Faculty Code", Employee."No.");
                    FacultyCourseWiseCS.SETFILTER(FacultyCourseWiseCS."Semester Code", '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
                    IF FacultyCourseWiseCS.findset() THEN
                        REPEAT
                            F1 := FacultyCourseWiseCS."Faculty Code";
                            IF Fb1 <> FacultyCourseWiseCS."Faculty Code" THEN
                                Num += 1;
                            Fb1 := FacultyCourseWiseCS."Faculty Code";

                            Name := FacultyCourseWiseCS."Faculty Name";
                            Section1 := FacultyCourseWiseCS."Section Code";
                            BatchNew := FacultyCourseWiseCS.Batch;
                            Graduation1 := FacultyCourseWiseCS.Graduation;
                            IF Graduation1 = 'UG' THEN BEGIN
                                SubjectClass1 := FacultyCourseWiseCS."Subject Class";
                                IF SubjectClass1 = 'THEORY' THEN BEGIN
                                    Subject1 := FacultyCourseWiseCS."Subject Code";
                                    IF Sub1 <> FacultyCourseWiseCS."Subject Code" THEN
                                        NoSub1 += 1;
                                    Sub1 := FacultyCourseWiseCS."Subject Code";
                                    ClassTimeTableLineCS.Reset();
                                    ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Section, Section1);
                                    ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Subject1);
                                    //        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Batch,BatchNew);
                                    ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '>=%1', StartDate);
                                    ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '<=%1', EndDate);
                                    ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Time Table Status", '%1', ClassTimeTableLineCS."Time Table Status"::Generated);
                                    IF ClassTimeTableLineCS.findset() THEN
                                        REPEAT
                                            IF (ClassTimeTableLineCS."Faculty 1 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 2 Code" = Employee."No.") OR
                                               (ClassTimeTableLineCS."Faculty 3 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 4 Code" = Employee."No.") THEN
                                                Hour1 := Hour1 + ClassTimeTableLineCS."No. of Hours";
                                        UNTIL ClassTimeTableLineCS.NEXT() = 0;
                                END ELSE
                                    IF SubjectClass1 = 'LAB' THEN BEGIN
                                        Subject2 := FacultyCourseWiseCS."Subject Code";
                                        IF Sub2 <> FacultyCourseWiseCS."Subject Code" THEN
                                            NoSub2 += 1;
                                        Sub2 := FacultyCourseWiseCS."Subject Code";
                                        ClassTimeTableLineCS.Reset();
                                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Subject2);
                                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Batch, BatchNew);
                                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Section, Section1);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '>=%1', StartDate);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '<=%1', EndDate);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Time Table Status", '%1', ClassTimeTableLineCS."Time Table Status"::Generated);
                                        IF ClassTimeTableLineCS.findset() THEN
                                            REPEAT
                                                IF (ClassTimeTableLineCS."Faculty 1 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 2 Code" = Employee."No.") OR
                                                   (ClassTimeTableLineCS."Faculty 3 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 4 Code" = Employee."No.") THEN
                                                    Hour2 := Hour2 + ClassTimeTableLineCS."No. of Hours";
                                            UNTIL ClassTimeTableLineCS.NEXT() = 0;
                                    END;
                            END ELSE
                                IF Graduation1 = 'PG' THEN BEGIN
                                    SubjectClass2 := FacultyCourseWiseCS."Subject Class";
                                    IF SubjectClass2 = 'THEORY' THEN BEGIN
                                        Subject3 := FacultyCourseWiseCS."Subject Code";
                                        IF Sub3 <> FacultyCourseWiseCS."Subject Code" THEN
                                            NoSub3 += 1;
                                        Sub3 := FacultyCourseWiseCS."Subject Code";
                                        ClassTimeTableLineCS.Reset();
                                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Subject3);
                                        //      ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Batch,BatchNew);
                                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Section, Section1);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '>=%1', StartDate);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '<=%1', EndDate);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Time Table Status", '%1', ClassTimeTableLineCS."Time Table Status"::Generated);
                                        IF ClassTimeTableLineCS.findset() THEN
                                            REPEAT
                                                IF (ClassTimeTableLineCS."Faculty 1 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 2 Code" = Employee."No.") OR
                                                   (ClassTimeTableLineCS."Faculty 3 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 4 Code" = Employee."No.") THEN
                                                    Hour3 := Hour3 + ClassTimeTableLineCS."No. of Hours";
                                            UNTIL ClassTimeTableLineCS.NEXT() = 0;
                                    END ELSE
                                        IF SubjectClass2 = 'LAB' THEN BEGIN
                                            Subject4 := FacultyCourseWiseCS."Subject Code";
                                            IF Sub4 <> FacultyCourseWiseCS."Subject Code" THEN
                                                NoSub4 += 1;
                                            Sub4 := FacultyCourseWiseCS."Subject Code";
                                            ClassTimeTableLineCS.Reset();
                                            ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Subject4);
                                            ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Batch, BatchNew);
                                            ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Section, Section1);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '>=%1', StartDate);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '<=%1', EndDate);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Time Table Status", '%1', ClassTimeTableLineCS."Time Table Status"::Generated);
                                            IF ClassTimeTableLineCS.findset() THEN
                                                REPEAT
                                                    IF (ClassTimeTableLineCS."Faculty 1 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 2 Code" = Employee."No.") OR
                                                       (ClassTimeTableLineCS."Faculty 3 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 4 Code" = Employee."No.") THEN
                                                        Hour4 := Hour4 + ClassTimeTableLineCS."No. of Hours";
                                                UNTIL ClassTimeTableLineCS.NEXT() = 0;
                                        END;
                                END;
                        UNTIL FacultyCourseWiseCS.NEXT() = 0;
                    // Even semester
                END ELSE
                    IF EvenOddSemester = EvenOddSemester::"Even Semester" THEN BEGIN
                        FacultyCourseWiseCS.Reset();
                        FacultyCourseWiseCS.SETCURRENTKEY("Subject Code", "Subject Class");
                        FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Academic Year", AcademicYear);
                        FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Faculty Code", Employee."No.");
                        FacultyCourseWiseCS.SETFILTER(FacultyCourseWiseCS."Semester Code", '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
                        IF FacultyCourseWiseCS.findset() THEN
                            REPEAT
                                F1 := FacultyCourseWiseCS."Faculty Code";
                                Name := FacultyCourseWiseCS."Faculty Name";
                                Section2 := FacultyCourseWiseCS."Section Code";
                                BatchNew1 := FacultyCourseWiseCS.Batch;
                                Graduation1 := FacultyCourseWiseCS.Graduation;
                                IF Graduation1 = 'UG' THEN BEGIN
                                    SubjectClass1 := FacultyCourseWiseCS."Subject Class";
                                    IF SubjectClass1 = 'THEORY' THEN BEGIN
                                        Subject1 := FacultyCourseWiseCS."Subject Code";
                                        IF Sub1 <> FacultyCourseWiseCS."Subject Code" THEN
                                            NoSub1 += 1;
                                        Sub1 := FacultyCourseWiseCS."Subject Code";
                                        ClassTimeTableLineCS.Reset();
                                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Subject1);
                                        ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Section, Section2);
                                        //      ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Batch,BatchNew1);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '>=%1', StartDate);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '<=%1', EndDate);
                                        ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Time Table Status", '%1', ClassTimeTableLineCS."Time Table Status"::Generated);
                                        IF ClassTimeTableLineCS.findset() THEN
                                            REPEAT
                                                IF (ClassTimeTableLineCS."Faculty 1 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 2 Code" = Employee."No.") OR
                                                   (ClassTimeTableLineCS."Faculty 3 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 4 Code" = Employee."No.") THEN
                                                    Hour1 := Hour1 + ClassTimeTableLineCS."No. of Hours";
                                            UNTIL ClassTimeTableLineCS.NEXT() = 0;
                                    END ELSE
                                        IF SubjectClass1 = 'LAB' THEN BEGIN
                                            Subject2 := FacultyCourseWiseCS."Subject Code";
                                            IF Sub2 <> FacultyCourseWiseCS."Subject Code" THEN
                                                NoSub2 += 1;
                                            Sub2 := FacultyCourseWiseCS."Subject Code";
                                            ClassTimeTableLineCS.Reset();
                                            ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Subject2);
                                            ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Section, Section2);
                                            ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Batch, BatchNew1);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '>=%1', StartDate);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '<=%1', EndDate);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Time Table Status", '%1', ClassTimeTableLineCS."Time Table Status"::Generated);
                                            IF ClassTimeTableLineCS.findset() THEN
                                                REPEAT
                                                    IF (ClassTimeTableLineCS."Faculty 1 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 2 Code" = Employee."No.") OR
                                                       (ClassTimeTableLineCS."Faculty 3 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 4 Code" = Employee."No.") THEN
                                                        Hour2 := Hour2 + ClassTimeTableLineCS."No. of Hours";
                                                UNTIL ClassTimeTableLineCS.NEXT() = 0;
                                        END;
                                END ELSE
                                    IF Graduation1 = 'PG' THEN BEGIN
                                        SubjectClass2 := FacultyCourseWiseCS."Subject Class";
                                        IF SubjectClass2 = 'THEORY' THEN BEGIN
                                            Subject3 := FacultyCourseWiseCS."Subject Code";
                                            IF Sub3 <> FacultyCourseWiseCS."Subject Code" THEN
                                                NoSub3 += 1;
                                            Sub3 := FacultyCourseWiseCS."Subject Code";
                                            ClassTimeTableLineCS.Reset();
                                            ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Subject3);
                                            ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Section, Section2);
                                            //      ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Batch,BatchNew1);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '>=%1', StartDate);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '<=%1', EndDate);
                                            ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Time Table Status", '%1', ClassTimeTableLineCS."Time Table Status"::Generated);
                                            IF ClassTimeTableLineCS.findset() THEN
                                                REPEAT
                                                    IF (ClassTimeTableLineCS."Faculty 1 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 2 Code" = Employee."No.") OR
                                                       (ClassTimeTableLineCS."Faculty 3 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 4 Code" = Employee."No.") THEN
                                                        Hour3 := Hour3 + ClassTimeTableLineCS."No. of Hours";
                                                UNTIL ClassTimeTableLineCS.NEXT() = 0;
                                        END ELSE
                                            IF SubjectClass2 = 'LAB' THEN BEGIN
                                                Subject4 := FacultyCourseWiseCS."Subject Code";
                                                IF Sub4 <> FacultyCourseWiseCS."Subject Code" THEN
                                                    NoSub4 += 1;
                                                Sub4 := FacultyCourseWiseCS."Subject Code";
                                                ClassTimeTableLineCS.Reset();
                                                ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS."Subject Code", Subject4);
                                                ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Batch, BatchNew1);
                                                ClassTimeTableLineCS.SETRANGE(ClassTimeTableLineCS.Section, Section2);
                                                ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '>=%1', StartDate);
                                                ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Created On", '<=%1', EndDate);
                                                ClassTimeTableLineCS.SETFILTER(ClassTimeTableLineCS."Time Table Status", '%1', ClassTimeTableLineCS."Time Table Status"::Generated);
                                                IF ClassTimeTableLineCS.findset() THEN
                                                    REPEAT
                                                        IF (ClassTimeTableLineCS."Faculty 1 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 2 Code" = Employee."No.") OR
                                                           (ClassTimeTableLineCS."Faculty 3 Code" = Employee."No.") OR (ClassTimeTableLineCS."Faculty 4 Code" = Employee."No.") THEN
                                                            Hour4 := Hour4 + ClassTimeTableLineCS."No. of Hours";
                                                    UNTIL ClassTimeTableLineCS.NEXT() = 0;
                                            END;
                                    END;
                            UNTIL FacultyCourseWiseCS.NEXT() = 0;
                    END;
            end;

            trigger OnPreDataItem()
            begin
                //Image
                DimensionValue.Reset();
                DimensionValue.SETRANGE(DimensionValue.Code, '09');
                DimensionValue.findfirst();
                DimensionValue.CALCFIELDS(DimensionValue.Image);


                IF EvenOddSemester = EvenOddSemester::"Odd Semester" THEN BEGIN
                    EducationMultiEventCalCS.Reset();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'ODD SEM CLASS START');
                    EducationMultiEventCalCS.SETRANGE("Academic Year", AcademicYear);
                    IF EducationMultiEventCalCS.findfirst() THEN
                        StartDate := EducationMultiEventCalCS."Start Date";
                    EndDate := EducationMultiEventCalCS."Revised End Date";
                END ELSE
                    IF EvenOddSemester = EvenOddSemester::"Even Semester" THEN BEGIN
                        EducationMultiEventCalCS.Reset();
                        EducationMultiEventCalCS.SETRANGE("Event Code", 'EVENSEM CLASS START');
                        EducationMultiEventCalCS.SETRANGE("Academic Year", AcademicYear);
                        IF EducationMultiEventCalCS.findfirst() THEN
                            StartDate := EducationMultiEventCalCS."Start Date";
                        EndDate := EducationMultiEventCalCS."Revised End Date";
                    END;

                IF DepartmentCode <> '' THEN
                    Employee.SETFILTER("Global Dimension 2 Code", DepartmentCode);
                SrNo := 0;
                Num := 0;
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
                    field(Semester; EvenOddSemester)
                    {
                        ApplicationArea = All;
                        Caption = 'Semester';
                        ToolTip = 'Semester may have a value';
                        OptionCaption = 'Odd Semester,Even Semester';
                    }
                    field("Academic Year"; AcademicYear)
                    {
                        TableRelation = "Academic Year Master-CS".Code;
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        ToolTip = 'Academic Year may have a value';
                    }
                    field("Department Code"; DepartmentCode)
                    {
                        TableRelation = "Dimension Value".Code;
                        ApplicationArea = All;
                        Caption = 'Department Code';
                        ToolTip = 'Department Code may have a value';
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

    var
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        ClassTimeTableLineCS: Record "Class Time Table Line-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        DimensionValue: Record "Dimension Value";
        EvenOddSemester: Option "Odd Semester","Even Semester";
        AcademicYear: Code[20];
        DepartmentCode: Code[20];

        Subject1: Code[20];
        Subject2: Code[20];
        Subject3: Code[20];
        Subject4: Code[20];

        Graduation1: Code[20];
        F1: Code[20];
        Name: Text[100];
        NoSub1: Integer;
        NoSub2: Integer;
        NoSub3: Integer;
        NoSub4: Integer;
        Sub3: Code[20];
        Sub4: Code[20];
        Sub2: Code[20];
        Sub1: Code[20];
        SubjectClass1: Code[20];
        SubjectClass2: Code[20];
        Hour1: Decimal;
        Hour2: Decimal;
        Hour3: Decimal;
        Hour4: Decimal;
        StartDate: Date;
        EndDate: Date;
        SrNo: Integer;
        Section1: Code[10];
        Section2: Code[10];
        BatchNew: Code[20];
        BatchNew1: Code[20];
        Fb1: Code[20];
        Num: Integer;

}


report 50253 "Student Exam Stats"
{
    ApplicationArea = all;
    UsageCategory = Administration;
    ProcessingOnly = true;


    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {

            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";



            dataitem(CourseSubjectLine; "Course Wise Subject Line-CS")
            {
                DataItemLink = "Course Code" = field("Course Code");
                DataItemLinkReference = "Student Master-CS";
                DataItemTableView = sorting("Exam Sequence") ORDER(Ascending) WHERE(Examination = filter(true), "Level Description" = filter('Internal Examination' | 'External Examination' | 'Internal Exam Component'));
                trigger OnPreDataItem()
                begin
                    CourseSubjectLine.SetFilter("Global Dimension 1 Code", InstCode);
                    CourseSubjectLine.SetFilter("Course Code", CourseCode);
                    CourseSubjectLine.SetFilter(Semester, Sem);

                end;

                trigger OnAfterGetRecord()
                begin

                    if ExtSeq < IntSeq then begin
                        GetExtExamLn("Student Master-CS"."No.", CourseSubjectLine."Course Code", CourseSubjectLine.Semester,
                        CourseSubjectLine."Global Dimension 1 Code", AY, Trm, CourseSubjectLine);

                        GetIntExamLn("Student Master-CS"."No.", CourseSubjectLine."Course Code", CourseSubjectLine.Semester,
                        CourseSubjectLine."Global Dimension 1 Code", AY, Trm, CourseSubjectLine);
                    end
                    else
                        if IntSeq < ExtSeq then begin
                            GetIntExamLn("Student Master-CS"."No.", CourseSubjectLine."Course Code", CourseSubjectLine.Semester,
                            CourseSubjectLine."Global Dimension 1 Code", AY, Trm, CourseSubjectLine);

                            GetExtExamLn("Student Master-CS"."No.", CourseSubjectLine."Course Code", CourseSubjectLine.Semester,
                            CourseSubjectLine."Global Dimension 1 Code", AY, Trm, CourseSubjectLine);
                        end;


                end;

                trigger OnPostDataItem()
                begin
                    ExcBuff.AddColumn(TotMarks, FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Number);
                end;
            }
            trigger OnPreDataItem()
            begin
                if InstCode = '' then
                    Error('Institute Code cannot be blank');
                if CourseCode = '' then
                    Error('Course Code cannot be blank');
                if Sem = '' then
                    Error('Semester Code cannot be blank');
                if AY = '' then
                    Error('Academic Year cannot be blank');

                EduSetup.Reset();
                EduSetup.SetRange("Global Dimension 1 Code", InstCode);
                EduSetup.FindFirst();
                "Student Master-CS".SetFilter(Status, EduSetup."Active Statuses");

                MakeExcelDataHeader();
            end;

            trigger OnAfterGetRecord()
            begin
                ExcBuff.NewRow();
                ExcBuff.AddColumn("Student Master-CS"."Original Student No.", FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                ExcBuff.AddColumn("Student Master-CS"."No.", FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                ExcBuff.AddColumn("Student Master-CS"."Enrollment No.", FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                ExcBuff.AddColumn("Student Master-CS"."Student Name", FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                ExcBuff.AddColumn(InstCode, FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                ExcBuff.AddColumn(AY, FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                ExcBuff.AddColumn(Trm, FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                ExcBuff.AddColumn(CourseCode, FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                ExcBuff.AddColumn(Sem, FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
                TotMarks := 0;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(InstCode; InstCode)
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,1,1';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

                    }
                    field(CourseCode; CourseCode)
                    {
                        ApplicationArea = all;
                        TableRelation = "Course Master-CS";
                        Caption = 'Course Code';
                    }
                    field(Sem; Sem)
                    {
                        ApplicationArea = all;
                        TableRelation = "Semester Master-CS";
                        Caption = 'Semester';
                    }
                    field(AY; AY)
                    {
                        ApplicationArea = all;
                        TableRelation = "Academic Year Master-CS";
                        Caption = 'Academic Year';
                    }
                    field(Trm; Trm)
                    {
                        ApplicationArea = all;
                        Caption = 'Term';
                    }
                }
            }


        }


    }
    var
        EduSetup: Record "Education Setup-CS";
        CourseSubjectLine2: Record "Course Wise Subject Line-CS";
        ExtExamHdr: Record "External Exam Header-CS";
        IntExamHdr: Record "Internal Exam Header-CS";
        EntryFound: Integer;
        ExtExamLn: Record "External Exam Line-CS";
        IntExamLn: Record "Internal Exam Line-CS";
        ExcBuff: Record "Excel Buffer" temporary;
        InstCode: Code[20];
        CourseCode: Code[20];
        Sem: Code[20];
        AY: Code[20];
        Trm: Option FALL,SPRING,SUMMER;
        IntSeq: Integer;
        ExtSeq: Integer;
        MarksAbsent: Text;
        TotMarks: Decimal;

    trigger OnPostReport()
    begin
        CreateExcelbook();
    end;

    trigger OnInitReport()
    begin
        EduSetup.Reset();
        EduSetup.SetFilter("Global Dimension 1 Code", '%1', '9000');
        EduSetup.FindFirst();
        InstCode := EduSetup."Global Dimension 1 Code";
        AY := EduSetup."Academic Year";
        Trm := EduSetup."Even/Odd Semester";
    end;

    procedure MakeExcelDataHeader()
    begin
        ExcBuff.NewRow();
        ExcBuff.AddColumn('Student ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('SLcM No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Enrollment No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Student Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Institute Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Academic Year', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Term Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Course Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        ExcBuff.AddColumn('Semester Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        CourseSubjectLine2.Reset();
        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
        CourseSubjectLine2.Ascending(true);
        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
        CourseSubjectLine2.SetRange("Course Code", CourseCode);
        CourseSubjectLine2.SetRange(Semester, Sem);
        CourseSubjectLine2.SetRange(Examination, true);
        CourseSubjectLine2.SetFilter("Level Description", '%1|%2|%3', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"Internal Exam Component", CourseSubjectLine2."Level Description"::"External Examination");
        CourseSubjectLine2.FindSet();
        repeat
            ExcBuff.AddColumn(CourseSubjectLine2.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
        until CourseSubjectLine2.Next() = 0;
        ExcBuff.AddColumn('Total Marks', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);

        CourseSubjectLine2.Reset();
        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
        CourseSubjectLine2.Ascending(true);
        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
        CourseSubjectLine2.SetRange("Course Code", CourseCode);
        CourseSubjectLine2.SetRange(Semester, Sem);
        CourseSubjectLine2.SetRange(Examination, true);
        CourseSubjectLine2.SetFilter("Level Description", '%1|%2', CourseSubjectLine2."Level Description"::"Internal Examination", CourseSubjectLine2."Level Description"::"Internal Exam Component");
        if CourseSubjectLine2.FindFirst() then
            IntSeq := CourseSubjectLine2."Exam Sequence";
        CourseSubjectLine2.Reset();
        CourseSubjectLine2.SetCurrentKey("Exam Sequence");
        CourseSubjectLine2.Ascending(true);
        CourseSubjectLine2.SetRange("Global Dimension 1 Code", InstCode);
        CourseSubjectLine2.SetRange("Course Code", CourseCode);
        CourseSubjectLine2.SetRange(Semester, Sem);
        CourseSubjectLine2.SetRange(Examination, true);
        CourseSubjectLine2.SetFilter("Level Description", '%1', CourseSubjectLine2."Level Description"::"External Examination");
        if CourseSubjectLine2.FindFirst() then
            ExtSeq := CourseSubjectLine2."Exam Sequence";

        if IntSeq < ExtSeq then
            ExtSeq := 0
        else
            if ExtSeq < IntSeq then
                IntSeq := 0;
        // ExcBuff.AddColumn('Exam Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        ExcBuff.CreateNewBook('Student Exam Stats');
        ExcBuff.WriteSheet('Student Exam Stats', COMPANYNAME, USERID);
        ExcBuff.CloseBook();
        ExcBuff.SetFriendlyFilename('Student Exam Stats');
        ExcBuff.OpenExcel();
    end;

    procedure GetExtExamLn(pStudNo: Code[20]; pCourseCode: Code[20]; pSem: Code[20];
    pInstCode: Code[20]; pAY: Code[20]; pTrm: Option FALL,SPRING,SUMMER; pCourseSubjectLine: Record "Course Wise Subject Line-CS")
    begin
        ExtExamLn.Reset();
        ExtExamLn.SetRange("Student No.", pStudNo);
        ExtExamLn.SetRange(Course, pCourseCode);
        ExtExamLn.SetRange(Semester, pSem);
        ExtExamLn.SetRange("Global Dimension 1 Code", pInstCode);
        ExtExamLn.SetRange("Academic year", pAY);
        ExtExamLn.SetRange(Term, pTrm);
        ExtExamLn.SetRange("Subject Code", pCourseSubjectLine."Subject Code");
        if ExtExamLn.FindSet() then
            repeat
                ExtExamHdr.Reset();
                ExtExamHdr.Get(ExtExamLn."Document No.");
                MarksAbsent := '';
                if ExtExamLn."Attendance Type" IN [ExtExamLn."Attendance Type"::Absent, ExtExamLn."Attendance Type"::Withdrawal] then
                    MarksAbsent := Format(ExtExamLn."Attendance Type")
                else begin
                    MarksAbsent := Format(ExtExamLn."External Mark");
                    TotMarks += ExtExamLn."External Mark";
                end;
                ExcBuff.AddColumn(MarksAbsent, FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until ExtExamLn.Next() = 0;
    end;

    procedure GetIntExamLn(pStudNo: Code[20]; pCourseCode: Code[20]; pSem: Code[20];
    pInstCode: Code[20]; pAY: Code[20]; pTrm: Option FALL,SPRING,SUMMER; pCourseSubjectLine: Record "Course Wise Subject Line-CS")
    begin
        IntExamLn.Reset();
        IntExamLn.SetRange("Student No.", pStudNo);
        IntExamLn.SetRange(Course, pCourseCode);
        IntExamLn.SetRange(Semester, pSem);
        IntExamLn.SetRange("Global Dimension 1 Code", pInstCode);
        IntExamLn.SetRange("Academic year", pAY);
        IntExamLn.SetRange(Term, pTrm);
        IntExamLn.SetRange("Subject Code", pCourseSubjectLine."Subject Code");
        if IntExamLn.FindSet() then
            repeat
                IntExamHdr.Reset();
                IntExamHdr.Get(IntExamLn."Document No.");
                MarksAbsent := '';
                if IntExamLn."Attendance Type" IN [IntExamLn."Attendance Type"::Absent, IntExamLn."Attendance Type"::Withdrawal] then
                    MarksAbsent := Format(IntExamLn."Attendance Type")
                else begin
                    MarksAbsent := Format(IntExamLn."Obtained Internal Marks");
                    TotMarks += IntExamLn."Obtained Internal Marks";
                end;
                ExcBuff.AddColumn(MarksAbsent, FALSE, '', False, FALSE, FALSE, '', ExcBuff."Cell Type"::Text);
            until IntExamLn.Next() = 0;
    end;

}
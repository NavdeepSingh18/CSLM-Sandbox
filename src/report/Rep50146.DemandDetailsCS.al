report 50146 "Demand Details-CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Demand Details-CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = WHERE("Source Code" = FILTER('@*COURSE FEE*' | '@*GENJNL*'),
                                      "Document Type" = FILTER(Invoice),
                                      Description = FILTER('@*Course Fees*'),
                                      Amount = FILTER(> 0),
                                      "Reversal New" = FILTER(false),
                                      "Document No." = FILTER('<>@*OPN*'));
            column(CourseCode_GLEntry; "G/L Entry"."Course Code")
            {
            }
            column(AcademicYear_GLEntry; AcademcyYear)
            {
            }
            column(Category_GLEntry; "G/L Entry".Category)
            {
            }
            column(Narration_GLEntry; "G/L Entry".Narration)
            {
            }
            column(CurrencyCode_GLEntry; "G/L Entry"."Currency Code")
            {
            }
            column(EnrollmentNo_GLEntry; "G/L Entry"."Enrollment No.")
            {
            }
            column(PostingDate_GLEntry; FORMAT("G/L Entry"."Posting Date"))
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(AmountReceipt_GLEntry; ROUND("G/L Entry"."Amount Receipt"))
            {
            }
            column(GlobalDimension1Code_GLEntry; "G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_GLEntry; "G/L Entry"."Global Dimension 2 Code")
            {
            }
            column(Course_Code; CourseCode)
            {
            }
            column(Course_Name; CourseName)
            {
            }
            column("Program"; "Program")
            {
            }
            column(Taxable; Taxable)
            {
            }
            column(Student_Name; StudentName)
            {
            }
            column(Category; Category)
            {
            }
            column(Admitted_Year; AdmittedYear)
            {
            }
            column(Tuition_Fee; TuitionFee)
            {
            }
            column(University_Fee; UniversityFee)
            {
            }
            column(Exam_Fee; ExamFee)
            {
            }
            column(Other_Fee; OtherFee)
            {
            }
            column(Due_Date; FORMAT(DueDate))
            {
            }
            column(Inst_Name; InstName)
            {
            }
            column(CourseFeeUSD; "CourseFee(USD)")
            {
            }
            column(CourseFeeINR; "CourseFee(INR)")
            {
            }
            column(CautionFeeUSD; "CautionFee(USD)")
            {
            }
            column(CautionFeeINR; "CautionFee(INR)")
            {
            }

            trigger OnAfterGetRecord()
            begin
                InstName := '';
                DueDate := 0D;
                TuitionFee := 0;
                UniversityFee := 0;
                ExamFee := 0;
                OtherFee := 0;
                "CourseFee(INR)" := 0;
                "CourseFee(USD)" := 0;
                "CautionFee(INR)" := 0;
                "CautionFee(USD)" := 0;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("Enrollment No.", "G/L Entry"."Enrollment No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    StudentName := StudentMasterCS."Student Name";
                    Category := StudentMasterCS.Category;
                    AdmittedYear := StudentMasterCS."Admitted Year";
                    CourseCode := StudentMasterCS."Course Code";
                    AcademcyYear := StudentMasterCS."Academic Year";

                    CourseMasterCS.Reset();
                    CourseMasterCS.SETRANGE(Code, StudentMasterCS."Course Code");
                    IF CourseMasterCS.findfirst() THEN BEGIN
                        CourseName := CourseMasterCS.Description;
                        "Program" := CourseMasterCS.Graduation;
                        IF CourseMasterCS.Taxable THEN
                            Taxable := 'Y'
                        ELSE
                            Taxable := 'N'
                    END;
                END;

                IF DimensionValue.GET('INSTITUTE', "G/L Entry"."Global Dimension 1 Code") THEN
                    InstName := DimensionValue.Name;

                CustLedgerEntry.Reset();
                CustLedgerEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                IF CustLedgerEntry.findfirst() THEN
                    DueDate := CustLedgerEntry."Due Date";

                GLEntry1.Reset();
                GLEntry1.SETRANGE("Document No.", "G/L Entry"."Document No.");
                GLEntry1.SETFILTER(Description, '%1|%2', '@*Tuition Fee - NRI*', '@*Tution Fee - Gen*');
                IF GLEntry1.findfirst() THEN
                    TuitionFee := ABS(ROUND(GLEntry1."Amount Receipt", 0.01, '='));
                /*
                IF GLEntry1."Currency Code" <> '' THEN
                  TuitionFee := ABS(ROUND(GLEntry1.Amount/(1/GLEntry1."Currency Factor"),0.01,'='))
                ELSE
                  TuitionFee := ABS(ROUND(GLEntry1.Amount,0.01,'='))
                */


                GLEntry2.Reset();
                GLEntry2.SETRANGE("Document No.", "G/L Entry"."Document No.");
                GLEntry2.SETFILTER(Description, '%1', '@*University Fee*');
                IF GLEntry2.findfirst() THEN
                    UniversityFee := ABS(ROUND(GLEntry2."Amount Receipt", 0.01, '='));
                /*
                IF GLEntry2."Currency Code" <> '' THEN
                  UniversityFee := ABS(ROUND(GLEntry2.Amount/(1/GLEntry2."Currency Factor"),0.01,'='))
                ELSE
                  UniversityFee := ABS(ROUND(GLEntry2.Amount,0.01,'='))
                */


                GLEntry3.Reset();
                GLEntry3.SETRANGE("Document No.", "G/L Entry"."Document No.");
                GLEntry3.SETFILTER(Description, '%1', '@*Examination Fee*');
                IF GLEntry3.findfirst() THEN
                    ExamFee := ABS(ROUND(GLEntry3."Amount Receipt", 0.01, '='));
                /*
                IF GLEntry3."Currency Code" <> '' THEN
                  ExamFee := ABS(ROUND(GLEntry3.Amount/(1/GLEntry3."Currency Factor"),0.01,'='))
                ELSE
                  ExamFee := ABS(ROUND(GLEntry3.Amount,0.01,'='))
                */

                GLEntry4.Reset();
                GLEntry4.SETRANGE("Document No.", "G/L Entry"."Document No.");
                GLEntry4.SETFILTER(Description, '%1', '@*Other Fee (TF)*');
                IF GLEntry4.findfirst() THEN
                    OtherFee := ABS(ROUND(GLEntry4."Amount Receipt", 0.01, '='));
                /*
                IF GLEntry4."Currency Code" <> '' THEN
                  OtherFee := ABS(ROUND(GLEntry4.Amount/(1/GLEntry4."Currency Factor"),0.01,'='))
                ELSE
                  OtherFee := ABS(ROUND(GLEntry4.Amount,0.01,'='))
                  */

                GLEntry5.Reset();
                GLEntry5.SETRANGE("Enrollment No.", "G/L Entry"."Enrollment No.");
                GLEntry5.SETFILTER(Description, '%1', '@*Caution Deposit*');
                GLEntry5.SETFILTER(Amount, '>%1', 0);
                IF GLEntry5.findfirst() THEN
                    IF GLEntry5."Currency Code" <> '' THEN
                        "CautionFee(USD)" := ROUND(GLEntry5."Amount Receipt", 0.01, '=')
                    ELSE
                        "CautionFee(INR)" := ROUND(GLEntry5.Amount, 0.01, '=');

                IF "G/L Entry"."Currency Code" <> '' THEN
                    "CourseFee(USD)" := "G/L Entry"."Amount Receipt"
                ELSE
                    "CourseFee(INR)" := "G/L Entry".Amount;

            end;

            trigger OnPreDataItem()
            begin
                //"G/L Entry".SETRANGE("Posting Date",StartDate,EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Start Date may have a value';
                    }

                    field("End Date"; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'End Date may have a value';
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
        CourseMasterCS: Record "Course Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        DimensionValue: Record "Dimension Value";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GLEntry1: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        GLEntry3: Record "G/L Entry";
        GLEntry4: Record "G/L Entry";
        GLEntry5: Record "G/L Entry";
        StartDate: Date;
        EndDate: Date;
        TuitionFee: Decimal;
        UniversityFee: Decimal;
        ExamFee: Decimal;
        OtherFee: Decimal;
        CourseCode: Code[20];
        CourseName: Text[100];
        Taxable: Code[10];
        StudentName: Text[100];

        AdmittedYear: Code[20];
        DueDate: Date;

        InstName: Text[100];
        "CautionFee(USD)": Decimal;
        "CautionFee(INR)": Decimal;
        "CourseFee(USD)": Decimal;
        "CourseFee(INR)": Decimal;
        AcademcyYear: Code[20];
        "Program": Code[20];
}


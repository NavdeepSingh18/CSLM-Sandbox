report 50103 "Fee Generation - College1 CS"
{
    // version V.001-CS

    Caption = 'Fee Generation - COLLEGE';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Customer"; "Customer")
        {
            DataItemTableView = WHERE("Student Status" = FILTER(Student | "Student Transfer-In-Process"),
                                      "Parent Customer" = FILTER(''));

            trigger OnAfterGetRecord()
            var
                NoSeries: Codeunit "NoSeriesManagement";
                TempDocNo: Code[20];
            begin
                //Counter := Counter + 1;
                //Window.UPDATE(1,"No.");
                //Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
                /*EduSetup.Reset();
                EduSetup.SETRANGE("Academic Year",Customer."Academic Year");
                IF EduSetup.ISEMPTY() then
                  CurrReport.Skip();
                  */
                CLEAR(TempDocNo);

                FeeSetupCS.GET();
                FeeSetupCS.TESTFIELD("Journal Template Name");
                FeeSetupCS.TESTFIELD("Journal Batch Name");

                EducationMultiEventCalCS.Reset();
                EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
                EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
                IF EducationMultiEventCalCS.findfirst() THEN
                    DueDate := EducationMultiEventCalCS."End Date";

                CustLedgerEntry.Reset();
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Source Code", 'COURSE FEE');
                //CustLedgerEntry.SETRANGE("Course Code","Course Code");
                CustLedgerEntry.SETRANGE("Academic Year", "Academic Year");
                CustLedgerEntry.SETRANGE(Year, Year);
                CustLedgerEntry.SETRANGE(Semester, Semester);
                CustLedgerEntry.SETRANGE(Reversed, FALSE);
                IF CustLedgerEntry.findfirst() THEN
                    CurrReport.Skip()
                //ERROR('Fee Already Genrated !!');
                ELSE BEGIN
                    TempDocNo := NoSeries.GETNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);
                    Amount := 0;

                    FeeCourseHeadCS.Reset();
                    FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Course Code", "Course Code");
                    FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Fee Classification Code", "Fee Classification Code");
                    IF Customer."Lateral Student" THEN
                        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS.Category, Category);

                    FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Academic Year", "Academic Year");
                    FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 1 Code", "Global Dimension 1 Code");
                    FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 2 Code", "Global Dimension 2 Code");
                    FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Admitted Year", Customer."Admitted Year");
                    FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS.Semester, Semester);
                    FeeCourseHeadCS.SETRANGE(Year, Year);
                    FeeCourseHeadCS.SETRANGE("Other Fees", FALSE);
                    IF FeeCourseHeadCS.findfirst() THEN BEGIN
                        FeeCourseLineCS.Reset();
                        FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                        FeeCourseLineCS.SETRANGE(FeeCourseLineCS."Fee Group Type", FeeCourseLineCS."Fee Group Type"::Admission);
                        IF FeeCourseLineCS.findfirst() THEN begin
                            REPEAT
                                FeeComponentMasterCS.GET(FeeCourseLineCS."Fee Code");
                                ManagementsFeeCS.FeeProcessNewCS("No.", FeeCourseLineCS."Fee Code", FeeCourseLineCS.Amount, Customer, YearPart, TempDocNo, FeeCourseHeadCS."Currency Code", DueDate);
                                Amount += FeeCourseLineCS.Amount;
                            UNTIL FeeCourseLineCS.NEXT() = 0;
                            ManagementsFeeCS.CustomerInsertCS("No.", FeeCourseLineCS."Fee Code", Amount, Customer, YearPart, TempDocNo, FeeCourseHeadCS."Late Fine %", FeeCourseHeadCS."Currency Code", DueDate);
                            //Customer."Fee Generated" := TRUE;
                            //Customer.Modify();
                        END ELSE
                            CurrReport.Skip();
                        //ERROR(Text001,FeeCourseLineCS."Fees Type");
                    END ELSE
                        CurrReport.Skip();
                    //ERROR(Text002,Customer."No.");
                    Amount1 := 0;
                    TempDocNo := NoSeries.GETNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);

                    FeeCourseHeadCS1.Reset();
                    FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Course Code", "Course Code");
                    FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Fee Classification Code", "Fee Classification Code");
                    IF Customer."Lateral Student" THEN
                        FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1.Category, Category);

                    FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Academic Year", "Academic Year");
                    FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Global Dimension 1 Code", "Global Dimension 1 Code");
                    FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Global Dimension 2 Code", "Global Dimension 2 Code");
                    FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Admitted Year", Customer."Admitted Year");
                    FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1.Semester, Semester);
                    FeeCourseHeadCS1.SETRANGE(Year, Year);
                    FeeCourseHeadCS1.SETRANGE("Other Fees", FALSE);
                    IF FeeCourseHeadCS1.findfirst() THEN BEGIN
                        FeeCourseLineCS1.Reset();
                        FeeCourseLineCS1.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                        FeeCourseLineCS1.SETRANGE(FeeCourseLineCS1."Fee Code", 'CAUN');
                        IF FeeCourseLineCS1.findfirst() THEN BEGIN
                            REPEAT
                                FeeComponentMasterCS.GET(FeeCourseLineCS1."Fee Code");
                                ManagementsFeeCS.FeeProcessNewCS("No.", FeeCourseLineCS1."Fee Code", FeeCourseLineCS1.Amount, Customer, YearPart, TempDocNo, FeeCourseHeadCS1."Currency Code", DueDate);
                                Amount1 += FeeCourseLineCS1.Amount;
                            UNTIL FeeCourseLineCS1.NEXT() = 0;
                            ManagementsFeeCS.CustomerCautionInsertCS("No.", FeeCourseLineCS1."Fee Code", Amount1, Customer, YearPart, TempDocNo, FeeCourseHeadCS1."Late Fine %", FeeCourseHeadCS1."Currency Code", DueDate);
                            //Customer."Fee Generated" := TRUE;
                            //Customer.Modify();
                        END ELSE
                            CurrReport.Skip();
                    END ELSE
                        CurrReport.Skip();
                    //END;








                    /*  FeeCourseHeadCS.Reset();
                      FeeCourseHeadCS.SETRANGE("Course Code","Course Code");
                      IF "Type Of Course" = "Type Of Course"::Semester THEN
                        FeeCourseHeadCS.SETRANGE(Semester,Semester)
                      ELSE IF "Type Of Course" = "Type Of Course"::Year THEN
                        FeeCourseHeadCS.SETRANGE(Year,Year);
                      FeeCourseHeadCS.SETRANGE("Academic Year","Academic Year");
                      FeeCourseHeadCS.SETRANGE("Global Dimension 1 Code","Global Dimension 1 Code");
                      //FeeCourseHeadCS.SETRANGE("Year Part",YearPart);
                      IF FeeCourseHeadCS.findfirst() THEN BEGIN
                        FeeCourseLineCS.Reset();
                        FeeCourseLineCS.SETRANGE("Document No.",FeeCourseHeadCS."No.");
                        FeeCourseLineCS.SETFILTER("Fees Type",VarFeeType);
                        IF FeeCourseLineCS.findset() THEN BEGIN
                          FeeComponentMasterCS.Reset();
                          FeeComponentMasterCS.GET(FeeCourseLineCS."Fee Code");
                          IF FeeComponentMasterCS."Check Duplication" THEN BEGIN
                            IF "Type Of Course" = "Type Of Course"::Semester THEN BEGIN
                         ;     IF ManagementsFeeCS.CheckDuplication("No.",FeeCourseLineCS."Fee Code","Course Code",Semester,"Academic Year") THEN
                                Flag := TRUE;
                            END ELSE IF "Type Of Course" = "Type Of Course"::Year THEN BEGIN
                              IF ManagementsFeeCS.CheckDuplicationYR("No.",FeeCourseLineCS."Fee Code","Course Code",Year,"Academic Year","Year") THEN
                                Flag := TRUE;
                            END;
                          END;
                          IF Flag THEN
                            ManagementsFeeCS.FeeProcessDis("No.",FeeCourseLineCS.Amount,VarFeeType,Customer,YearPart);
                        END ELSE
                          ERROR(Text001,VarFeeType);
                      END ELSE
                        ERROR(Text002,Customer."No.");
                    END;*/
                END;
                //CounterOK := CounterOK + 1;
                //MESSAGE('Fee Generated ');

            end;

            trigger OnPostDataItem()
            begin
                //IF Flag THEN BEGIN

                /* GenJournalLine.Reset();
                  GenJournalLine.SETRANGE("Journal Template Name",FeeSetupCS."Journal Template Name");
                  GenJournalLine.SETRANGE("Journal Batch Name",FeeSetupCS."Journal Batch Name");
                  IF GenJournalLine.findset() THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                    MESSAGE(Text003);
                  END;*/
                //Window.close();
                //MESSAGE(Text0004,CounterOK,CounterTotal);

                //END;

            end;

            trigger OnPreDataItem()
            begin
                //CounterTotal := COUNT();
                //Window.OPEN(Text0001);
                IF AcademicYear = '' THEN
                    ERROR('Academic Year must have a value in it');
                Customer.SETRANGE(Customer."Academic Year", AcademicYear);
                IF AdmittedYear <> '' THEN
                    Customer.SETRANGE("Admitted Year", AdmittedYear);
                IF EnrollmentNo <> '' THEN
                    Customer.SETRANGE(Customer."Enrollment No.", EnrollmentNo);
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
                field("Enrollment No"; EnrollmentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                    ToolTip = 'Enrollment No. may have a value';


                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        StudentMasterCS.Reset();
                        StudentMasterCS.findset();
                        IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                            EnrollmentNo := StudentMasterCS."Enrollment No.";

                    end;
                }
                field("Admitted Year"; AdmittedYear)
                {
                    ApplicationArea = ALL;
                    TableRelation = "Academic Year Master-CS".Code;

                    Caption = 'Admitted Year';
                    ToolTip = 'Admitted Year may have a value';
                }
                field("Academic Year"; AcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    ToolTip = 'Academic Year may have a value';
                    TableRelation = "Academic Year Master-CS";
                }
                field("Fee Type"; VarFeeType)
                {
                    ApplicationArea = All;
                    Caption = 'Fee Type';
                    ToolTip = 'Fee Type may have a value';
                    TableRelation = "Fee Component Master-CS";
                    Visible = false;
                }
                field("Fee Amount"; FeeAmount)
                {

                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Fee Amount';
                    ToolTip = 'Fee Amount may have a value';

                    trigger OnValidate()
                    begin
                        FeeComponentMasterCS1.Reset();
                        IF FeeComponentMasterCS1.GET(VarFeeType) THEN;
                        //IF NOT FeeComponentMasterCS1."Fee Generation Amount Based" THEN
                        //ERROR(Text004,VarFeeType);
                    end;
                }
                group("For Year Fee Generation")
                {
                    Caption = 'For Year Fee Generation';
                    field("Year Part"; YearPart)
                    {
                        ApplicationArea = All;
                        Caption = 'Year Part';
                        ToolTip = 'Year Part may have a value';
                        Visible = false;
                        OptionCaption = ' ,1st,2nd';
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

    trigger OnPostReport()
    begin
        MESSAGE('Fee Generated ');
    end;

    var

        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        FeeSetupCS: Record "Fee Setup-CS";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        FeeComponentMasterCS1: Record "Fee Component Master-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        FeeCourseHeadCS1: Record "Fee Course Head-CS";
        FeeCourseLineCS1: Record "Fee Course Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        VarFeeType: Code[150];
        FeeAmount: Decimal;
        YearPart: Option " ","1st","2nd";
        DueDate: Date;
        AcademicYear: Code[20];
        EnrollmentNo: Code[20];
        Amount1: Decimal;
        AdmittedYear: Code[20];
}
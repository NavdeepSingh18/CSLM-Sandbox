report 50150 "Fee Gen.In Period-College CS"
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
            DataItemTableView = WHERE("Student Status" = CONST(Student),
                                      "Parent Customer" = FILTER(''));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                NoSeries: Codeunit "NoSeriesManagement";
                TempDocNo: Code[20];

            begin
                //Counter := Counter + 1;
                //Window.UPDATE(1,"No.");
                //Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));


                FeeSetupCS.GET();
                FeeSetupCS.TESTFIELD("Journal Template Name");
                FeeSetupCS.TESTFIELD("Journal Batch Name");

                CustLedgerEntry.Reset();
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Course Code", "Course Code");
                CustLedgerEntry.SETRANGE("Academic Year", "Academic Year");
                CustLedgerEntry.SETRANGE(Year, Year);
                CustLedgerEntry.SETRANGE(Reversed, FALSE);
                IF CustLedgerEntry.findfirst() THEN
                    CurrReport.SKIP()
                //ERROR('Entry Already Exist')
                ELSE BEGIN
                    TempDocNo := NoSeries.GETNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);
                    Amount := 0;

                    EducationMultiEventCalCS.Reset();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'FEE GENERATION');
                    EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
                    EducationMultiEventCalCS.SETFILTER("Start Date", '<%1', TODAY());
                    EducationMultiEventCalCS.SETFILTER("Revised End Date", '>%1', TODAY());
                    IF EducationMultiEventCalCS.findfirst() THEN BEGIN
                        FeeCourseHeadCS.Reset();
                        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Course Code", "Course Code");
                        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Fee Classification Code", "Fee Classification Code");
                        IF Customer."Lateral Student" THEN
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS.Category, Category);
                        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Academic Year", "Academic Year");
                        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 1 Code", "Global Dimension 1 Code");
                        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 2 Code", "Global Dimension 2 Code");
                        FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Admitted Year", Customer."Admitted Year");
                        FeeCourseHeadCS.SETRANGE(Year, Year);
                        IF FeeCourseHeadCS.findfirst() THEN BEGIN
                            FeeCourseLineCS.Reset();
                            FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                            FeeCourseLineCS.SETRANGE(FeeCourseLineCS."Fee Group Type", FeeCourseLineCS."Fee Group Type"::Admission);
                            IF FeeCourseLineCS.findfirst() THEN begin
                                REPEAT
                                    FeeComponentMasterCS.GET(FeeCourseLineCS."Fee Code");
                                    ManagementsFeeCS.FeeProcessNewCS("No.", FeeCourseLineCS."Fee Code", FeeCourseLineCS.Amount, Customer, YearPart, TempDocNo, FeeCourseLineCS."Currency Code", EducationMultiEventCalCS."End Date");
                                    Amount += FeeCourseLineCS.Amount;
                                UNTIL FeeCourseLineCS.NEXT() = 0;
                                ManagementsFeeCS.CustomerInsertCS("No.", FeeCourseLineCS."Fee Code", Amount, Customer, YearPart, TempDocNo, FeeCourseHeadCS."Late Fine %", FeeCourseLineCS."Currency Code", EducationMultiEventCalCS."End Date");
                                //Customer."Fee Generated" := TRUE;
                                //Customer.Modify();
                            END ELSE
                                CurrReport.Skip();
                            //ERROR(Text001,FeeCourseLineCS."Fees Type");
                        END ELSE
                            CurrReport.Skip();
                        //ERROR(Text002,Customer."No.");
                    END ELSE
                        ERROR(Text0005Lbl);
                END;


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
                //END;
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
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Fee Type"; VarFeeType)
                {
                    TableRelation = "Fee Component Master-CS";
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Fee Type';
                    ToolTip = 'Fee Type may have a value';
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
                        Visible = false;
                        ApplicationArea = All;
                        Caption = 'Year Part';
                        ToolTip = 'Student Promoted may have a value';
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
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        VarFeeType: Code[150];
        FeeAmount: Decimal;
        YearPart: Option " ","1st","2nd";
        Text0005Lbl: Label 'You Can Only Generate Fee In between Fee Generation Period . ';
}
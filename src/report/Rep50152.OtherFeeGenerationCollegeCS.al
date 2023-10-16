report 50152 "Other FeeGeneration-College CS"
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
            DataItemTableView = WHERE("Student Status" = CONST(Student));

            trigger OnPostDataItem()
            begin
                //IF Flag THEN BEGIN
                /*
                 GenJournalLine.Reset();
                 GenJournalLine.SETRANGE("Journal Template Name",FeeSetup."Journal Template Name");
                 GenJournalLine.SETRANGE("Journal Batch Name",FeeSetup."Journal Batch Name");
                 IF GenJournalLine.findset() THEN BEGIN
                   CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                   MESSAGE(Text003);
                 END;
                 */
                //END;

            end;

            trigger OnPreDataItem()
            begin
                IF EnrollmentNo <> '' THEN
                    CustRec.Reset();
                CustRec.SETRANGE(CustRec."Enrollment No.", EnrollmentNo);
                IF CustRec.findfirst() THEN
                    IF VarFeeType = '' THEN
                        ERROR(Text000Lbl);
                IF StudentNo = '' THEN
                    ERROR(Text006Lbl);

                CustLedgerEntry.Reset();
                CustLedgerEntry.SETRANGE("Customer No.", CustRec."No.");
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Fee Code", VarFeeType);
                CustLedgerEntry.SETRANGE("Course Code", CustRec."Course Code");
                CustLedgerEntry.SETRANGE("Academic Year", CustRec."Academic Year");
                CustLedgerEntry.SETRANGE(Year, CustRec.Year);
                IF CustLedgerEntry.findfirst() THEN
                    ERROR('Entry Already Exist')
                ELSE BEGIN
                    FeeCourseHeadCS.Reset();
                    FeeCourseHeadCS.SETRANGE("Admitted Year", CustRec."Admitted Year");
                    FeeCourseHeadCS.SETRANGE("Program", CustRec."Program");
                    FeeCourseHeadCS.SETRANGE("Global Dimension 1 Code", CustRec."Global Dimension 1 Code");
                    FeeCourseHeadCS.SETRANGE("Course Code", '');
                    IF FeeCourseHeadCS.findfirst() THEN BEGIN
                        FeeCourseLineCS.Reset();
                        FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                        FeeCourseLineCS.SETFILTER("Fee Code", VarFeeType);
                        IF FeeCourseLineCS.findset() THEN
                            ManagementsFeeCS.OtherFeeGenerationCS(CustRec."No.", FeeCourseLineCS.Amount, VarFeeType)
                        ELSE
                            ERROR(Text001Lbl, VarFeeType);
                    END ELSE
                        ERROR(Text002Lbl, CustRec."No.");
                END;
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
                field("Student No."; StudentNo)
                {
                    TableRelation = Customer;
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Student No.';
                    ToolTip = 'Student No. may have a value';
                }
                field("Fee Type"; VarFeeType)
                {
                    ApplicationArea = All;
                    Caption = 'Fee Type';
                    ToolTip = 'Fee Type may have a value';
                    TableRelation = "Fee Component Master-CS";
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
                        ToolTip = 'Year Part may have a value';
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
        MESSAGE('Done');
    end;

    var
        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        FeeComponentMasterCS1: Record "Fee Component Master-CS";

        CustRec: Record "Customer";

        StudentMasterCS: Record "Student Master-CS";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";

        VarFeeType: Code[50];


        Text000Lbl: Label 'Select Fee Type !!';
        Text001Lbl: Label 'Fee Type %1 is not Set in Course Fee', Comment = '%1 =  Fee Type';
        Text002Lbl: Label 'Course wise fee setup for Customer No. %1 does not exists.', Comment = '%1 = Customer No.';
        FeeAmount: Decimal;
        YearPart: Option " ","1st","2nd";
        StudentNo: Code[20];
        Text006Lbl: Label 'Select Student No. !!';
        EnrollmentNo: Code[20];

}


report 50172 "Student Statement of Account"
{
    Caption = 'Student Statement of Account';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Student Statement of Account New.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {

            Column(HousingType; HousingType)
            { }
            column(Filter_Caption1; GETFILTERS())
            {

            }
            column(FromDate; FromDate - 1)
            {

            }
            column(ToDate; ToDate)
            {

            }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            {

            }
            Column(Grenvillelogo; RecEduSetup1."Grenville Logo")
            {

            }
            Column("Institute_Name"; RecEduSetup."Institute Name")
            {

            }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            {

            }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            {

            }
            Column("Institute_City"; RecEduSetup."Institute City")
            {

            }

            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            {

            }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            {

            }
            Column("Institute_Email"; RecEduSetup."Institute E-Mail")
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            column(HousingOpBalance; HousingOpBalance)
            {

            }
            column(NoneHousingOpBalance; NoneHousingOpBalance)
            { }

            column(No; "Original Student No.")
            {

            }
            column(Enroll; "Enrollment No.")
            {

            }
            column(StudentName; "Student Name")
            {

            }
            column(Address1; Addressee)
            {

            }
            column(Address2; Address1)
            {

            }
            column(Address3; Address2)
            {

            }
            column(Email; "E-Mail Address")
            {

            }
            column(PhoneNo; "Phone Number")
            {

            }
            column(City; City)
            {

            }
            column(State; State)
            {

            }

            column(postCode; "Post Code")
            {

            }

            column(Country_Code; "Country Code")
            {

            }
            column(Course; "Course Code")
            {

            }
            column(Sem; Semester)
            {

            }
            column(AcademicYear; "Academic Year")
            {

            }
            column(Institute; "Global Dimension 1 Code")
            {

            }
            dataitem("Temp Record"; "Temp Record")
            {
                DataItemLink = Field2 = Field("Original Student No.");

                column(Filter_Caption; GETFILTERS())
                {

                }
                column(DepartmentCode; Field6)
                {

                }
                column(DeparmentPage; Field31)
                {

                }
                column(Posting_Date; Field73)
                {

                }
                column(Document_Type; Field12)
                {

                }
                column(Document_No_; Field7)
                {

                }
                column(Description; Field11)
                {

                }
                column(Amount; Field21)
                {

                }
                column("Running_Balance"; Balance)
                {

                }
                column(OpeningBalance; OpeningBalance)
                {

                }
                column(Field22; Field22)
                { }
                column(Select; Select)
                { }
                column(Beneficiary; Beneficiary)
                {

                }
                column(Bank; Bank)
                {

                }
                column(BeneficiaryAccountNo; BeneficiaryAccountNo)
                {

                }
                column(BeneficiaryABANo; BeneficiaryABANo)
                {

                }
                column(BenefifiarySwift; BenefifiarySwift)
                {

                }
                trigger OnPreDataItem()
                Begin
                    GD2 := '';
                    "Temp Record".SetCurrentKey(Field31);

                    "Temp Record".SETRANGE(Field73, FromDate, ToDate);

                    IF HousingType = HousingType::"Only Housing" then
                        "Temp Record".SetFilter(Field6, '%1|%2', '9300', '9500');

                    IF HousingType = HousingType::" " then
                        "Temp Record".SetRange(Field6, '');

                    //InstituteCode := '';
                    IF InstituteCode = '' then begin
                        StudentMasterCS.Reset();
                        StudentMasterCS.SetCurrentKey("Enrollment Order");
                        StudentMasterCS.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                        IF StudentMasterCS.FindLast() then
                            InstituteCode := StudentMasterCS."Global Dimension 1 Code";
                    end;

                    RecEduSetup.Reset();
                    RecEduSetup.SetRange("Global Dimension 1 Code", InstituteCode);
                    IF RecEduSetup.FindFirst() then
                        RecEduSetup.CALCFIELDS("Logo Image");

                    RecEduSetup1.Reset();
                    RecEduSetup1.SetRange("Global Dimension 1 Code", InstituteCode);
                    IF RecEduSetup1.FindFirst() then
                        RecEduSetup1.CALCFIELDS("Grenville Logo");



                    Beneficiary := '';
                    Bank := '';
                    BeneficiaryAccountNo := '';
                    BeneficiaryABANo := '';
                    BenefifiarySwift := '';
                    RecBankAccount.Reset();
                    RecBankAccount.SetRange("SAP Company Code", InstituteCode);
                    RecBankAccount.SetRange("Statement of Accounts", true);
                    IF RecBankAccount.FindFirst() then begin
                        Beneficiary := RecBankAccount."Beneficiary Name";
                        Bank := RecBankAccount."Bank Branch No.";
                        if RecBankAccount.Address <> '' then
                            Bank += ',' + RecBankAccount.Address;
                        if RecBankAccount."Address 2" <> '' then
                            Bank += ',' + RecBankAccount."Address 2";
                        if RecBankAccount.City <> '' then
                            Bank += ',' + RecBankAccount.City;
                        if RecBankAccount.County <> '' then
                            Bank += ',' + RecBankAccount.County;
                        if RecBankAccount."Post code" <> '' then
                            Bank += ',' + RecBankAccount."Post code";
                        BeneficiaryAccountNo := RecBankAccount."Bank Account No.";
                        BeneficiaryABANo := RecBankAccount."Beneficiary ABA No.";
                        BenefifiarySwift := RecBankAccount."SWIFT Code";
                    end;

                End;

                trigger OnAfterGetRecord()
                begin
                    if "Temp Record".Field6 <> '' then
                        DeparmentPage := 2
                    else
                        DeparmentPage := 1;




                    If (GD2 <> "Temp Record".Field6) then begin
                        IF (GD2 = '') then begin
                            Balance := 0;
                            OpeningBalance := 0;

                            OpeningBalance := HousingOpBalance;
                            Balance := OpeningBalance;

                            Beneficiary := '';
                            Bank := '';
                            BeneficiaryAccountNo := '';
                            BeneficiaryABANo := '';
                            BenefifiarySwift := '';
                            RecBankAccount.Reset();
                            RecBankAccount.SetRange("SAP Company Code", '9300');
                            RecBankAccount.SetRange("Statement of Accounts", true);
                            IF RecBankAccount.FindFirst() then begin
                                Beneficiary := RecBankAccount."Beneficiary Name";
                                Bank := RecBankAccount."Bank Branch No.";
                                if RecBankAccount.Address <> '' then
                                    Bank += ',' + RecBankAccount.Address;
                                if RecBankAccount."Address 2" <> '' then
                                    Bank += ',' + RecBankAccount."Address 2";
                                if RecBankAccount.City <> '' then
                                    Bank += ',' + RecBankAccount.City;
                                if RecBankAccount.County <> '' then
                                    Bank += ',' + RecBankAccount.County;
                                if RecBankAccount."Post code" <> '' then
                                    Bank += ',' + RecBankAccount."Post code";

                                BeneficiaryAccountNo := RecBankAccount."Bank Account No.";
                                BeneficiaryABANo := RecBankAccount."Beneficiary ABA No.";
                                BenefifiarySwift := RecBankAccount."SWIFT Code";
                            end;
                        end;
                    end;

                    Balance := Balance + (("Temp Record".Field21));
                    GD2 := "Temp Record".Field6;
                end;

            }

            trigger OnPreDataItem()
            Begin
                "Student Master-CS".SetCurrentKey("Enrollment Order");
                "Student Master-CS".Ascending(false);

                "Student Master-CS".SetFilter("Original Student No.", EnrollmentNo);

                DimensionValue_gRec.Reset();
                DimensionValue_gRec.SetRange("Dimension Code", 'DEPARTMENT');
                DimensionValue_gRec.SetRange(Code, '9300');
                If DimensionValue_gRec.FindFirst() then;



            End;

            trigger OnAfterGetRecord()
            begin

                Balance := 0;
                OpeningBalance := 0;
                IF StudentIDFilter <> "Student Master-CS"."Original Student No." then begin

                    TempRecord.Reset();
                    TempRecord.SetRange(Field2, "Student Master-CS"."Original Student No.");
                    TempRecord.SetRange(Field73, 0D, FromDate - 1);
                    If TempRecord.FindSet() then begin
                        repeat
                            IF TempRecord.Field6 <> '' then
                                HousingOpBalance += TempRecord.Field21
                            Else
                                NoneHousingOpBalance += TempRecord.Field21;
                        until TempRecord.Next() = 0;
                    end;

                    OpeningBalance := NoneHousingOpBalance;
                    Balance := OpeningBalance;
                    StudentIDFilter := "Student Master-CS"."Original Student No.";
                    If HousingOpBalance <> 0 then begin
                        EntryNo := 0;
                        TempRecord.Reset();
                        IF TempRecord.FindLast() then
                            EntryNo := TempRecord."Entry No" + 1
                        Else
                            EntryNo := 1;

                        TempRecord.Init();
                        TempRecord."Entry No" := EntryNo;
                        TempRecord.Field73 := FromDate;
                        TempRecord.Field22 := HousingOpBalance;
                        TempRecord.Select := true;
                        TempRecord.Field6 := '9300';
                        TempRecord.Field31 := 2;
                        TempRecord."Unique ID" := UserId();
                        TempRecord.Field2 := "Student Master-CS"."Original Student No.";
                        TempRecord.Insert();
                    end;
                    If NoneHousingOpBalance <> 0 then begin
                        EntryNo := 0;
                        TempRecord.Reset();
                        IF TempRecord.FindLast() then
                            EntryNo := TempRecord."Entry No" + 1
                        Else
                            EntryNo := 1;

                        TempRecord.Init();
                        TempRecord."Entry No" := EntryNo;
                        TempRecord.Field73 := FromDate;
                        TempRecord.Field22 := NoneHousingOpBalance;
                        TempRecord.Select := true;
                        TempRecord.Field6 := '';
                        TempRecord.Field31 := 1;
                        TempRecord.Field2 := "Student Master-CS"."Original Student No.";
                        TempRecord."Unique ID" := UserId();
                        TempRecord.Insert();
                    end;
                end Else
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("From Date"; FromDate)
                {
                    ApplicationArea = All;
                    Caption = 'From Date';
                }
                field("To Date"; ToDate)
                {
                    ApplicationArea = All;
                    Caption = 'To Date';
                }
                field("Institute Code"; InstituteCode)
                {
                    ApplicationArea = All;
                    Caption = 'Institude Code';
                    //Visible = False;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                }
                field("Housing Type"; "HousingType")
                {
                    ApplicationArea = All;
                    Caption = 'Housing Type';
                    OptionCaption = ' ,With Housing,Only Housing';
                }
                field("Enrollment No"; EnrollmentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Student ID';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        StudentMasterCS.Reset();
                        StudentMasterCS.findset();
                        IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN begin
                            EnrollmentNo := StudentMasterCS."Original Student No.";
                            //InstituteCode := StudentMasterCS."Global Dimension 1 Code";
                        end;
                    end;
                }
                field("Semester"; Semester1)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                    TableRelation = "Semester Master-CS";
                    Visible = false;
                }
                field("Academic Year"; AcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    TableRelation = "Academic Year Master-CS";
                    Visible = false;
                }
                group(OutputOptions)
                {
                    Caption = 'Output Options';
                    field(ReportOutput; SupportedOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;

                        Caption = 'Report Output';
                        ToolTip = 'Specifies the output of the scheduled report, such as PDF or Word.';

                        trigger OnValidate()
                        begin
                            MapOutputMethod;
                        end;
                    }
                    field(OutputMethod; ChosenOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin

            MapOutputMethod();
            ChosenOutputMethod := SupportedOutputMethod::PDF;



        end;
    }

    trigger OnPreReport()
    begin
        // IF InstituteCode = '' THEN
        //     ERROR('Institute Code must have a value in it');
        IF FromDate = 0D THEN
            ERROR('FromDate must have a value.');
        IF ToDate = 0D THEN
            ERROR('ToDate must have a value.');

        TempRecord.Reset();
        //TempRecord.SetRange("Unique ID", UserId());
        TempRecord.DeleteAll();


        StudentLegacyLedger.Reset();
        StudentLegacyLedger.SetCurrentKey(Date);
        StudentLegacyLedger.Ascending(true);
        StudentLegacyLedger.SetRange("Student Number", EnrollmentNo);
        StudentLegacyLedger.SetRange(Date, 0D, ToDate);
        IF InstituteCode <> '' then
            StudentLegacyLedger.SetRange("Global Dimension 1 Code", InstituteCode);
        IF StudentLegacyLedger.FindSet() then begin
            repeat
                TempRecord.Reset();
                IF TempRecord.FindLast() then
                    EntryNo := TempRecord."Entry No" + 1
                Else
                    EntryNo := 1;

                TempRecord.Init();
                TempRecord."Entry No" := EntryNo;
                TempRecord.Field2 := StudentLegacyLedger."Student Number";      //Student ID
                TempRecord.Field3 := '';        // SLcM No
                TempRecord.Field4 := '';        // Enrollment No
                TempRecord.Field5 := StudentLegacyLedger."Global Dimension 1 Code";
                TempRecord.Field6 := StudentLegacyLedger."Global Dimension 2 Code";
                If TempRecord.Field6 <> '' then
                    TempRecord.Field31 := 2
                Else
                    TempRecord.Field31 := 1;
                TempRecord.Field7 := '';        //Document No
                TempRecord.Field73 := StudentLegacyLedger.Date;
                TempRecord.Field11 := StudentLegacyLedger.Description;
                TempRecord.Field12 := Format(StudentLegacyLedger."Document Type");
                TempRecord.Field21 := StudentLegacyLedger.Amount;
                TempRecord."Unique ID" := UserId();
                TempRecord.Select := false;
                TempRecord.Insert();

            until StudentLegacyLedger.Next() = 0;
        end;

        StudentMasterCS.Reset();
        StudentMasterCS.SetRange("Original Student No.", EnrollmentNo);
        IF StudentMasterCS.FindSet() then begin
            repeat
                GLEntry.Reset();
                GLEntry.SetCurrentKey("Posting Date");
                GLEntry.Ascending(true);
                GLEntry.SetRange("Enrollment No.", StudentMasterCS."Enrollment No.");
                GLEntry.SetRange("Posting Date", 0D, ToDate);
                GLEntry.SetRange(Reversed, false);
                GLEntry.SetFilter("Document No.", '<>%1', 'OPNG*');
                If InstituteCode <> '' then
                    GLEntry.SetRange("Global Dimension 1 Code", InstituteCode);
                If GLEntry.FindSet() then begin
                    repeat
                        Customer.Reset();
                        Customer.SetRange("No.", StudentMasterCS."Original Student No.");
                        If Customer.FindFirst() then begin
                            CustomerPostingGroup.Reset();
                            CustomerPostingGroup.SetRange(Code, Customer."Customer Posting Group");
                            IF CustomerPostingGroup.FindFirst() then begin
                                IF GLEntry."Document Type" <> GLEntry."Document Type"::" " then begin
                                    If CustomerPostingGroup."Receivables Account" <> GLEntry."G/L Account No." then begin

                                        TempRecord.Reset();
                                        IF TempRecord.FindLast() then
                                            EntryNo := TempRecord."Entry No" + 1
                                        Else
                                            EntryNo := 1;

                                        TempRecord.Init();
                                        TempRecord."Entry No" := EntryNo;
                                        TempRecord.Field2 := StudentMasterCS."Original Student No.";      //Student ID
                                        TempRecord.Field3 := StudentMasterCS."No.";        // SLcM No
                                        TempRecord.Field4 := GLEntry."Enrollment No.";        // Enrollment No
                                        TempRecord.Field5 := GLEntry."Global Dimension 1 Code";
                                        TempRecord.Field6 := GLEntry."Global Dimension 2 Code";
                                        If TempRecord.Field6 <> '' then
                                            TempRecord.Field31 := 2
                                        Else
                                            TempRecord.Field31 := 1;
                                        TempRecord.Field7 := GLEntry."Document No.";        //Document No
                                        TempRecord.Field73 := GLEntry."Posting Date";
                                        TempRecord.Field11 := GLEntry.Description;
                                        TempRecord.Field12 := Format(GLEntry."Document Type");
                                        TempRecord.Field21 := -1 * GLEntry.Amount;
                                        TempRecord."Unique ID" := UserId();
                                        TempRecord.Select := false;
                                        TempRecord.Insert();
                                    end;
                                end Else begin
                                    TempRecord.Reset();
                                    IF TempRecord.FindLast() then
                                        EntryNo := TempRecord."Entry No" + 1
                                    Else
                                        EntryNo := 1;

                                    TempRecord.Init();
                                    TempRecord."Entry No" := EntryNo;
                                    TempRecord.Field2 := StudentMasterCS."Original Student No.";      //Student ID
                                    TempRecord.Field3 := StudentMasterCS."No.";        // SLcM No
                                    TempRecord.Field4 := GLEntry."Enrollment No.";        // Enrollment No
                                    TempRecord.Field5 := GLEntry."Global Dimension 1 Code";
                                    TempRecord.Field6 := GLEntry."Global Dimension 2 Code";
                                    If TempRecord.Field6 <> '' then
                                        TempRecord.Field31 := 2
                                    Else
                                        TempRecord.Field31 := 1;
                                    TempRecord.Field7 := GLEntry."Document No.";        //Document No
                                    TempRecord.Field73 := GLEntry."Posting Date";
                                    TempRecord.Field11 := GLEntry.Description;
                                    TempRecord.Field12 := Format(GLEntry."Document Type");
                                    TempRecord.Field21 := GLEntry.Amount;
                                    TempRecord."Unique ID" := UserId();
                                    TempRecord.Select := false;
                                    TempRecord.Insert();
                                end;
                            end;
                        end;
                    until GLEntry.Next() = 0;
                end;
            until StudentMasterCS.Next() = 0;
        end;
    End;

    trigger OnPostReport()
    Begin
        TempRecord.Reset();
        TempRecord.SetRange("Unique ID", UserId());
        TempRecord.DeleteAll();
    End;

    var
        StudentMasterCS: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";
        RecEduSetup1: Record "Education Setup-CS";
        CustomerPostingGroup: Record "Customer Posting Group";
        GLEntry: Record "G/L Entry";
        RecBankAccount: Record "Bank Account";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DimensionValue_gRec: Record "Dimension Value";
        Customer: Record Customer;
        TempRecord: Record "Temp Record";
        TempRecord_gRec: Record "Temp Record";
        StudentLegacyLedger: Record "Student Legacy Ledger";
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        ChosenOutputMethod: Integer;

        FromDate: Date;
        ToDate: Date;
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        Semester1: Code[100];
        HousingType: Option " ","With Housing","Only Housing";
        DeparmentPage: Integer;
        Balance: Decimal;
        GD2: Code[20];
        OpeningBalance: Decimal;
        Beneficiary: Text[100];
        Bank: Text[100];
        BeneficiaryAccountNo: Code[20];
        BeneficiaryABANo: Code[20];
        BenefifiarySwift: Code[20];
        HousingOpBalance: Decimal;
        NoneHousingOpBalance: Decimal;
        [InDataSet]
        ShowPrintIfEmailIsMissing: Boolean;
        GrenvilleLogoShow: Boolean;
        EntryNo: Integer;
        StudentIDFilter: Text;
        OpenHouseBal: Decimal;
        OpenNonHouseBal: Decimal;



    procedure VariablePassing(FromDate1: Date; ToDate1: Date; InstituteCode1: Code[20]; EnrollmentNo1: Code[20]; AcademicYear1: Code[20]; Semester2: Code[100]; Housing1: Option " ","With Housing","Only Housing");
    begin
        FromDate := FromDate1;
        ToDate := ToDate1;
        InstituteCode := InstituteCode1;
        EnrollmentNo := EnrollmentNo1;
        AcademicYear := AcademicYear1;
        Semester1 := Semester2;
        HousingType := Housing1;

    end;

    local procedure MapOutputMethod()
    var
        CustomLayoutReporting: Codeunit "Custom Layout Reporting";
    begin
        ShowPrintIfEmailIsMissing := (SupportedOutputMethod = SupportedOutputMethod::Email);
        // Map the supported option (shown on the page) to the list of supported output methods
        // Most output methods map directly - Word/XML do not, however.
        case SupportedOutputMethod of
            SupportedOutputMethod::XML:
                ChosenOutputMethod := CustomLayoutReporting.GetXMLOption;
            else
                ChosenOutputMethod := SupportedOutputMethod;
        end;
    end;
}
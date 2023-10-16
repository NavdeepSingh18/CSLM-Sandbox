table 50410 "G/L Entries Date Wise"
{
    Caption = 'SAP Integration Data';
    // DrillDownPageID = "SAP Integration Data";
    // LookupPageID = "SAP Integration Data";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";

        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';

        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(10; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Bal. Account Type" = CONST(Employee)) Employee;
        }
        field(17; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';

        }
        field(28; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(29; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
        }
        field(30; "Prior-Year Entry"; Boolean)
        {
            Caption = 'Prior-Year Entry';
        }
        field(41; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(42; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(43; "VAT Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(45; "Business Unit Code"; Code[20])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(46; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(47; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(48; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(49; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(51; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(52; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(53; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
        }
        field(54; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
        }
        field(55; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
        }
        field(56; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(57; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset,Employee';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        }
        field(58; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Source Type" = CONST(Employee)) Employee;
        }
        field(59; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(60; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(61; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(62; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(63; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(64; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(65; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(68; "Additional-Currency Amount"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 1;
            Caption = 'Additional-Currency Amount';
        }
        field(69; "Add.-Currency Debit Amount"; Decimal)
        {

            AutoFormatType = 1;
            Caption = 'Add.-Currency Debit Amount';
        }
        field(70; "Add.-Currency Credit Amount"; Decimal)
        {

            AutoFormatType = 1;
            Caption = 'Add.-Currency Credit Amount';
        }
        field(71; "Close Income Statement Dim. ID"; Integer)
        {
            Caption = 'Close Income Statement Dim. ID';
        }
        field(72; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(73; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(74; "Reversed by Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed by Entry No.';
            TableRelation = "G/L Entry";
        }
        field(75; "Reversed Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed Entry No.';
            TableRelation = "G/L Entry";
        }
        field(76; "G/L Account Name"; Text[100])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE("No." = FIELD("G/L Account No.")));
            Caption = 'G/L Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

        }
        field(5400; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(5600; "FA Entry Type"; Option)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Entry Type';
            OptionCaption = ' ,Fixed Asset,Maintenance';
            OptionMembers = " ","Fixed Asset",Maintenance;
        }
        field(5601; "FA Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'FA Entry No.';
            TableRelation = IF ("FA Entry Type" = CONST("Fixed Asset")) "FA Ledger Entry"
            ELSE
            IF ("FA Entry Type" = CONST(Maintenance)) "Maintenance Ledger Entry";
        }
        field(8001; "Account Id"; Guid)
        {
            CalcFormula = Lookup("G/L Account".SystemId WHERE("No." = FIELD("G/L Account No.")));
            Caption = 'Account Id';
            FieldClass = FlowField;
            TableRelation = "G/L Account".SystemId;
        }
        field(8005; "Last Modified DateTime"; DateTime)
        {
            Caption = 'Last Modified DateTime';
            Editable = false;
        }
        field(10018; "STE Transaction ID"; Text[20])
        {
            Caption = 'STE Transaction ID';
            Editable = false;
        }
        field(10019; "GST/HST"; Option)
        {
            Caption = 'GST/HST';
            OptionCaption = ' ,Acquisition,Self Assessment,Rebate,New Housing Rebates,Pension Rebate';
            OptionMembers = " ",Acquisition,"Self Assessment",Rebate,"New Housing Rebates","Pension Rebate";
        }
        field(50000; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50001; "Cheque Date"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50002; "Cheque No."; Code[35])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50003; "Withdrawal No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50004; "Synchronised with SFAS"; Boolean)
        {
            Caption = 'Synchronised with SFAS';
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50005; "Customer Bank Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50006; "Customer Bank Branch Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50007; "Instrument Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,DD,CK,RT,CA,SM,WT,Other,CS,OI';
            OptionMembers = " ",DD,CK,RT,CA,SM,WT,Other,CS,OI;
            DataClassification = CustomerContent;
        }
        field(50008; "Instrument Date"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50009; "Actual Synch to SFAS"; Boolean)
        {
            Caption = 'Actual Synch to SFAS';
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50010; "Credit Memo Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Credit Memo,Refund';
            OptionMembers = " ","Credit Memo",Refund;
            DataClassification = CustomerContent;
        }
        field(50011; Narration; Text[100])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50012; "UnRelazised Doc No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50013; "Transaction Number"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50014; Posted; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50015; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Description = 'CS Field Added 02-05-2019';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(50016; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(50017; "Receipt No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50018; "ShortCut Dimension Code 3"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50019; "Course Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(50020; Semester; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(50021; "Academic Year"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(50022; Year; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(50023; Category; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Category Master-CS";
            DataClassification = CustomerContent;
        }
        field(50024; "Reversal New"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50025; "Applies To Rev. Doc. No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50026; "Show INR"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50027; "Currency Code Receipt"; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50028; "Amount Receipt"; Decimal)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50029; "Fee Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Fee Component Master-CS";
            DataClassification = CustomerContent;
        }
        field(50032; "SAP Code"; Code[20])
        {
            Caption = 'SAP Code';
            DataClassification = CustomerContent;
            TableRelation = "SAP Fee Code";
        }
        field(50033; "SAP G/L Account"; Code[20])
        {
            Caption = 'SAP G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(50034; "SAP Assignment Code"; Code[20])
        {
            Caption = 'SAP Assignment Code';
            DataClassification = CustomerContent;
        }
        field(50035; "SAP Description"; Text[30])
        {
            Caption = 'SAP Descriptions';
            DataClassification = CustomerContent;
        }

        field(50036; "SAP Cost Centre"; Code[20])
        {
            Caption = 'SAP Cost Centre';
            DataClassification = CustomerContent;
        }
        field(50037; "SAP Profit Centre"; Code[20])
        {
            Caption = 'SAP Profit Centre';
            DataClassification = CustomerContent;
        }
        field(50038; "SAP Company Code"; Code[20])
        {
            Caption = 'SAP Company Code';
            DataClassification = CustomerContent;
        }
        field(50039; "SAP Bus. Area"; Code[20])
        {
            Caption = 'SAP Bus. Area';
            DataClassification = CustomerContent;
        }
        field(50040; "Fee Group"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Group';
            OptionCaption = ' ,Non-Institutional,Institutional';
            OptionMembers = " ","Non-Institutional",Institutional;
        }
        field(50041; "Payment By Financial Aid"; Boolean)
        {
            Caption = 'Payment By Financial Aid';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50042; "Fund Type"; Option)
        {
            Caption = 'Fund Type';
            OptionCaption = ' ,FDSL-Plus,FDSL-Unsub';
            OptionMembers = " ","FDSL-Plus","FDSL-Unsub";
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50043; "Roster Entry No."; Integer)
        {
            Caption = 'Roster Entry No.';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50044; "Financial Aid Approved"; Boolean)
        {
            Caption = 'Financial Aid Approved';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50045; "Payment Plan Applied"; Boolean)
        {
            Caption = 'Payment Plan Applied';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50046; "Payment Plan Instalment"; Integer)
        {
            Caption = 'Payment Plan Instalment';
            MinValue = 2;
            MaxValue = 4;
            Editable = false;
        }

        field(50047; "Auto Generated"; Boolean)
        {
            Caption = 'Auto Generated';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50048; "Deposit Type"; Option)
        {
            Caption = 'Deposit Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Seat Deposit,Housing Deposit';
            OptionMembers = " ","Seat Deposit","Housing Deposit";
        }
        field(50049; "Self Payment Applied"; Boolean)
        {
            Caption = 'Self Payment Applied';
            DataClassification = CustomerContent;
        }
        field(50050; "Waiver/Scholar/Grant Code"; Code[20])
        {
            Caption = 'Waiver/Scholarship/Grant Code';
            DataClassification = CustomerContent;
        }
        field(50051; "Waiver/Scholar/Grant Desc"; Text[100])
        {
            Caption = 'Waiver/Scholarship/Grant Description';
            DataClassification = CustomerContent;
        }
        field(50052; Reason; Text[500])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50053; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(100054; StartDate; Date)
        {
            Caption = 'StartDate';
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(100055; EndDate; Date)
        {
            Caption = 'EndDate';
            DataClassification = CustomerContent;
            //Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "G/L Account No.", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount", "VAT Amount";
        }
        key(Key3; "G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount", "VAT Amount";
        }
        key(Key4; "G/L Account No.", "Business Unit Code", "Posting Date")
        {
            Enabled = false;
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        key(Key5; "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")
        {
            Enabled = false;
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        key(Key6; "Document No.", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount", "VAT Amount";
        }
        key(Key7; "Transaction No.")
        {
        }
        key(Key8; "IC Partner Code")
        {
        }
        key(Key9; "G/L Account No.", "Job No.", "Posting Date")
        {
            SumIndexFields = Amount;
        }
        key(Key10; "Posting Date", "G/L Account No.", "Dimension Set ID")
        {
            SumIndexFields = Amount;
        }
        key(Key11; "Gen. Bus. Posting Group", "Gen. Prod. Posting Group")
        {
        }
        key(Key12; "VAT Bus. Posting Group", "VAT Prod. Posting Group")
        {
        }
        key(Key13; "External Document No.", "Posting Date")
        {
            Enabled = false;
        }
        key(Key14; "SAP Code")
        {
        }
        key(Key15; "SAP G/L Account")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "G/L Account No.", "Posting Date", "Document Type", "Document No.")
        {
        }
    }

    trigger OnInsert()
    begin
        "Last Modified DateTime" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Modified DateTime" := CurrentDateTime;
    end;

    trigger OnRename()
    begin
        "Last Modified DateTime" := CurrentDateTime;
    end;

}


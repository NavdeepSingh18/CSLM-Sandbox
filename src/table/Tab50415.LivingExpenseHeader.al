table 50415 "Living Expense Header"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "No.", "Student ID", "Student Name";
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'No.';
            trigger OnValidate()
            var
                FeeSetup: Record "Fee Setup-CS";
            begin
                FeeSetup.Reset();
                FeeSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF FeeSetup.FindFirst() then
                    FeeSetup.TestField("Living Exps Document Nos.");

                NoSeriesMgt.TestManual(FeeSetup."Living Exps Document Nos.");
            end;
        }
        field(2; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Creation Date';
        }
        field(5; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student ID';
            Editable = false;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                "Student Name" := '';
                "Enrollment No." := '';
                "Academic Year" := '';
                Semester := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then begin
                    "Student Name" := StudentMaster."Student Name";
                    "Enrollment No." := StudentMaster."Enrollment No.";
                    "Academic Year" := StudentMaster."Academic Year";
                    Semester := StudentMaster.Semester;
                    Term := StudentMaster.Term;
                    "T4 Authorization" := StudentMaster."T4 Authorization";
                end;
            end;
        }
        field(6; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(7; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(8; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            Editable = false;
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(9; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS".Code;
        }
        field(10; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(11; Status; Option)
        {
            OptionMembers = "Open","Posted";
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(12; "T4 Authorization"; Boolean)
        {
            Caption = 'T4 Authorization';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(16; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Sorting_1; "Student ID")
        {
            Clustered = false;
        }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    var
        FeeSetup: Record "Fee Setup-CS";
    begin
        FeeSetup.Reset();
        FeeSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF FeeSetup.FindFirst() then
            FeeSetup.TestField("Living Exps Document Nos.");
        NoSeriesMgt.InitSeries(FeeSetup."Living Exps Document Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        "Creation Date" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        LivingExpenseLine: Record "Living Expense Line";
    begin
        LivingExpenseLine.Reset();
        LivingExpenseLine.SetCurrentKey("Student ID", "Document No.");
        LivingExpenseLine.SetRange("Document No.", "No.");
        LivingExpenseLine.SetRange("Student ID", "Student ID");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        if LivingExpenseLine.FindSet() then
            repeat
                LivingExpenseLine.Delete();
            until LivingExpenseLine.Next() = 0;
    end;

    trigger OnRename()
    begin

    end;

    procedure DeleteEntries(StudentMaster: Record "Student Master-CS"; LNo: Code[20])
    var
        LivingExpenseLine: Record "Living Expense Line";
        DelLivingExpenseLine: Record "Living Expense Line";
    begin
        LivingExpenseLine.Reset();
        LivingExpenseLine.SetCurrentKey("Student ID", "Document No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::Approved);
        if not LivingExpenseLine.FindFirst() then begin
            DelLivingExpenseLine.Reset();
            DelLivingExpenseLine.SetCurrentKey("Student ID", "Document No.");
            DelLivingExpenseLine.SetRange("Document No.", LNo);
            DelLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            if DelLivingExpenseLine.FindFirst() then
                DelLivingExpenseLine.DeleteAll();
        end;
    end;

    procedure InsertLivingExpsHeader(StudentMaster: Record "Student Master-CS"; Var LNo: Code[20])
    var
        LivingExpenseHeader: Record "Living Expense Header";
        INSLivingExpenseHeader: Record "Living Expense Header";
    begin
        LNo := '';

        LivingExpenseHeader.Reset();
        LivingExpenseHeader.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseHeader.SetRange("Academic Year", StudentMaster."Academic Year");
        LivingExpenseHeader.SetRange(Semester, StudentMaster.Semester);
        LivingExpenseHeader.SetRange(Term, StudentMaster.Term);
        if LivingExpenseHeader.FindFirst() then begin
            LNo := LivingExpenseHeader."No.";
            LivingExpenseHeader."T4 Authorization" := StudentMaster."T4 Authorization";
            LivingExpenseHeader.Modify();
            DeleteEntries(StudentMaster, LNo);
        end
        else begin
            INSLivingExpenseHeader.Init();
            INSLivingExpenseHeader."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
            INSLivingExpenseHeader."No." := '';
            INSLivingExpenseHeader.Insert(true);
            INSLivingExpenseHeader.Validate("Student ID", StudentMaster."No.");
            INSLivingExpenseHeader.Modify();
            LNo := INSLivingExpenseHeader."No.";
        end;
    end;

    procedure InsertLivingExpsPastBalance(StudentMaster: Record "Student Master-CS"; LNo: Code[20])
    var
        CLE: Record "Cust. Ledger Entry";
        LivingExpenseLine: Record "Living Expense Line";
        SemesterRec: Record "Semester Master-CS";
        OpeningAmount: Decimal;
        CurrentSemesterSequence: Integer;
        PreviousSemesters: Code[100];
        PermissibleEntry: Boolean;
        Text000Lbl: Label 'Process In Progress....      ##################1################\';
        Text001Lbl: Label 'Total Entries....      #################2#################\';
        Text002Lbl: Label 'Entry In Progress....      ##################3################\';
        W: Dialog;
        T: Integer;
        C: Integer;
    begin
        W.Open('\' + Text000Lbl + Text001Lbl + Text002Lbl);

        W.Update(1, 'Inserting Past Balances  (Process: 0/4)');

        CurrentSemesterSequence := 0;
        PreviousSemesters := '';

        SemesterRec.Reset();
        SemesterRec.SetRange(Code, StudentMaster.Semester);
        SemesterRec.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if SemesterRec.FindFirst() then
            CurrentSemesterSequence := SemesterRec.Sequence;

        SemesterRec.Reset();
        SemesterRec.SetFilter(Sequence, '<%1', CurrentSemesterSequence);
        SemesterRec.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if SemesterRec.FindSet() then
            repeat
                if PreviousSemesters = '' then
                    PreviousSemesters := SemesterRec.Code
                else
                    PreviousSemesters := PreviousSemesters + '|' + SemesterRec.Code;
            until SemesterRec.Next() = 0;

        if PreviousSemesters = '' then
            PreviousSemesters := StudentMaster.Semester;

        OpeningAmount := 0;
        Clear(CLE);
        CLE.Reset();
        CLE.SetCurrentKey("Customer No.", Semester);
        CLE.SetRange("Customer No.", StudentMaster."No.");
        CLE.SetFilter(Semester, PreviousSemesters);
        if CLE.FindSet() then begin
            T := CLE.Count;
            C := 0;
            repeat
                C += 1;
                W.Update(2, T);
                W.Update(3, C);

                PermissibleEntry := true;

                if CLE."Payment Plan Applied" then
                    PermissibleEntry := false;

                if CLE."Self Payment Applied" then
                    PermissibleEntry := false;

                SemesterRec.Reset();
                SemesterRec.SetRange(Code, CLE.Semester);
                if SemesterRec.FindFirst() then
                    if (SemesterRec.Sequence < CurrentSemesterSequence) and (PermissibleEntry = true) then begin
                        CLE.CalcFields(Amount);

                        if CLE."Amount" <> 0 then
                            OpeningAmount := OpeningAmount + CLE.Amount;
                    end;
            until CLE.Next() = 0;
        end;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetCurrentKey("Student ID", "Document No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Past Balance");
        if LivingExpenseLine.FindFirst() then
            OpeningAmount := 0;

        IF OpeningAmount > 0 then begin
            LivingExpenseLine.Init();
            LivingExpenseLine."Document No." := LNo;
            LivingExpenseLine.Validate("Student ID", StudentMaster."No.");
            LivingExpenseLine."Entry Document No." := 'PAST_BALANCE';
            LivingExpenseLine.Description := 'PAST BALANCE';
            LivingExpenseLine."Posting Date" := 0D;
            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Past Balance";
            LivingExpenseLine."View Part" := LivingExpenseLine."View Part"::"Posted Entries";
            LivingExpenseLine."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
            LivingExpenseLine."Document Type" := LivingExpenseLine."Document Type"::Invoice;
            LivingExpenseLine."Fee Code" := 'PAYMENT';
            LivingExpenseLine."Fee Description" := 'Payment';
            LivingExpenseLine."Fee Code" := 'PAST_BALANCE';
            LivingExpenseLine."Fee Description" := 'PAST BALANCE';
            LivingExpenseLine.Amount := OpeningAmount;
            LivingExpenseLine."Remaining Amount" := LivingExpenseLine.Amount;
            LivingExpenseLine."Provisional Remaining Amount" := LivingExpenseLine."Remaining Amount";
            LivingExpenseLine."Application Entry No." := LivingExpenseLine."Entry No.";


            LivingExpenseLine.Insert();
        end;
    end;

    procedure InsertLivingExpsDetails(StudentMaster: Record "Student Master-CS"; LNo: Code[20]; InternalCall: Boolean)
    var
        GLEntry: Record "G/L Entry";
        CLE: Record "Cust. Ledger Entry";
        LivingExpenseLine: Record "Living Expense Line";
        LivingExpenseLine_FST: Record "Living Expense Line";
        //LivingExpenseLine_SEC: Record "Living Expense Line";
        CRLivingExpenseLine: Record "Living Expense Line";
        SourceScholarship: Record "Source Scholarship-CS";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        HousingApplication: Record "Housing Application";
        FinancialAID: Record "Financial AID";
        CustomerPostingGroup: Record "Customer Posting Group";
        Text000Lbl: Label 'Process In Progress....      ##################1################\';
        Text001Lbl: Label 'Total Entries....      #################2#################\';
        Text002Lbl: Label 'Entry In Progress....      ##################3################\';
        RefundAmount: Decimal;
        SeatDepositAmt: Decimal;
        RemainingCrBalance: Decimal;
        GVTrfAmt: Decimal;
        GLEntrySign: Text[1];
        CLESign: Text[1];
        W: Dialog;
        T: Integer;
        C: Integer;
        PermissibleEntry: Boolean;
        PermissibleEntry_FST: Boolean;
        ScholarshipEntry: Boolean;
    begin
        W.Open('\' + Text000Lbl + Text001Lbl + Text002Lbl);

        W.Update(1, 'Deleting Entries  (Process: 1/4)');

        if InternalCall = false then begin
            LivingExpenseLine.Reset();
            LivingExpenseLine.SetCurrentKey("Student ID", "Document No.");
            LivingExpenseLine.SetRange("Document No.", LNo);
            LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
            if LivingExpenseLine.FindSet() then begin
                T := LivingExpenseLine.Count;
                C := 0;
                repeat
                    W.Update(2, T);
                    W.Update(3, C);
                    LivingExpenseLine.Delete();
                until LivingExpenseLine.Next() = 0;
            end;
        end;

        InsertLivingExpsPastBalance(StudentMaster, LNo);

        W.Update(1, 'Copying Entries (Process: 2/4)');

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetCurrentKey("Student ID", "Document No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Posted Entries");
        if LivingExpenseLine.FindSet() then begin
            T := LivingExpenseLine.Count;
            C := 0;
            repeat
                W.Update(2, T);
                W.Update(3, C);
                LivingExpenseLine."Remaining Amount" := LivingExpenseLine.Amount;
                LivingExpenseLine.Modify();
            until LivingExpenseLine.Next() = 0;
        end;

        GLEntry.Reset();
        GLEntry.SetCurrentKey("Enrollment No.", "Academic Year", Semester);
        GLEntry.SetRange("Enrollment No.", StudentMaster."Enrollment No.");
        GLEntry.SetRange("Academic Year", StudentMaster."Academic Year");
        GLEntry.SetRange(Semester, StudentMaster.Semester);
        GLEntry.SetRange(Term, StudentMaster.Term);
        if GLEntry.FindSet() then begin
            T := GLEntry.Count;
            C := 0;
            repeat
                C += 1;
                W.Update(2, T);
                W.Update(3, C);

                CLESign := '';
                GLEntrySign := '';

                PermissibleEntry := false;
                PermissibleEntry_FST := false;
                ScholarshipEntry := false;

                LivingExpenseLine_FST.Reset();
                LivingExpenseLine_FST.SetCurrentKey("Student ID", "Cust. Ledger Entry No.");
                LivingExpenseLine_FST.SetRange("Document No.", LNo);
                LivingExpenseLine_FST.SetRange("Student ID", StudentMaster."No.");
                LivingExpenseLine_FST.SetRange("G/L Entry No.", GLEntry."Entry No.");
                if not LivingExpenseLine_FST.FindFirst() then begin
                    IF GLEntry."Financial Aid Approved" = true then
                        PermissibleEntry_FST := true;
                    IF GLEntry."Payment By Financial Aid" = true then
                        PermissibleEntry_FST := true;
                    IF GLEntry."Source Code" IN ['T_IV_ADVNC', 'T_IV_STPND'] then
                        PermissibleEntry_FST := true;
                    IF GLEntry."Deposit Type" IN [GLEntry."Deposit Type"::"Housing Deposit", GLEntry."Deposit Type"::"Seat Deposit"] then
                        PermissibleEntry_FST := true;
                    IF GLEntry."Waiver/Scholar/Grant Code" <> '' then begin
                        SourceScholarship.Reset();
                        if SourceScholarship.Get(GLEntry."Waiver/Scholar/Grant Code") then
                            if SourceScholarship."Discount Type" IN [SourceScholarship."Discount Type"::Scholarship, SourceScholarship."Discount Type"::Grant] then begin
                                PermissibleEntry_FST := true;
                                ScholarshipEntry := true;
                            end;
                    end;

                    PermissibleEntry := true;
                    Clear(CLE);
                    CLE.Reset();
                    CLE.SetCurrentKey("Document No.", "Customer No.");
                    CLE.SetRange("Document No.", GLEntry."Document No.");
                    CLE.SetRange("Customer No.", StudentMaster."No.");
                    if CLE.FindFirst() then begin
                        CLE.CalcFields(Amount, "Remaining Amount");

                        if CLE.Amount >= 0 then begin
                            CLESign := '+';
                            if CLE.Description = 'Refund of Student Payments' then
                                PermissibleEntry_FST := true;
                        end
                        else begin
                            CLESign := '-';
                            BankAccountLedgerEntry.Reset();
                            BankAccountLedgerEntry.SetRange("Document No.", GLEntry."Document No.");
                            if BankAccountLedgerEntry.FindFirst() then begin
                                CustomerPostingGroup.Reset();
                                if CustomerPostingGroup.Get(CLE."Customer Posting Group") then
                                    if CustomerPostingGroup."Receivables Account" = GLEntry."G/L Account No." then
                                        PermissibleEntry_FST := true;
                            end;
                        end;

                        if CLE.Reversed then
                            PermissibleEntry := false;
                    end
                    else
                        PermissibleEntry := false;

                    if GLEntry.Amount >= 0 then
                        GLEntrySign := '+'
                    else
                        GLEntrySign := '-';

                    if GLEntry."Document Type" IN [GLEntry."Document Type"::Invoice] then
                        if GLEntrySign = CLESign then
                            PermissibleEntry_FST := false;

                    if GLEntry."Document Type" IN [GLEntry."Document Type"::"Credit Memo"] then
                        if GLEntrySign <> CLESign then
                            PermissibleEntry_FST := false;

                    if GLEntry."Fee Code" = '' then begin
                        CustomerPostingGroup.Reset();
                        if CustomerPostingGroup.Get(CLE."Customer Posting Group") then
                            if CustomerPostingGroup."Receivables Account" <> GLEntry."G/L Account No." then
                                PermissibleEntry_FST := false;
                    end;

                    if (PermissibleEntry = true) and (PermissibleEntry_FST = true) then begin
                        GLEntry.CalcFields("G/L Account Name");
                        LivingExpenseLine.Init();
                        LivingExpenseLine."Document No." := LNo;
                        LivingExpenseLine.Validate("Student ID", StudentMaster."No.");
                        LivingExpenseLine."Entry Document No." := GLEntry."Document No.";
                        LivingExpenseLine."G/L Account No." := GLEntry."G/L Account No.";
                        LivingExpenseLine."G/L Account Name" := GLEntry."G/L Account Name";
                        LivingExpenseLine.Description := GLEntry.Description;
                        LivingExpenseLine."Posting Date" := GLEntry."Posting Date";
                        LivingExpenseLine."View Part" := LivingExpenseLine."View Part"::"Posted Entries";
                        LivingExpenseLine."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                        LivingExpenseLine."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";

                        if GLEntry."Document Type" = GLEntry."Document Type"::Invoice then
                            LivingExpenseLine."Document Type" := LivingExpenseLine."Document Type"::Invoice;

                        if GLEntry."Document Type" = GLEntry."Document Type"::Payment then begin
                            LivingExpenseLine."Document Type" := LivingExpenseLine."Document Type"::Payment;
                            LivingExpenseLine."Deposit Type" := GLEntry."Deposit Type";

                            if GLEntry."Payment By Financial Aid" = false then
                                LivingExpenseLine."Receipt Type" := LivingExpenseLine."Receipt Type"::"Non-Financial Aid"
                            else
                                LivingExpenseLine."Receipt Type" := LivingExpenseLine."Receipt Type"::"Financial Aid";
                        end;

                        if GLEntry."Document Type" = GLEntry."Document Type"::"Credit Memo" then
                            LivingExpenseLine."Document Type" := LivingExpenseLine."Document Type"::"Credit Note";

                        if GLEntry."Document Type" = GLEntry."Document Type"::Refund then
                            LivingExpenseLine."Document Type" := LivingExpenseLine."Document Type"::Refund;

                        if GLEntry."Fee Code" <> '' then begin
                            LivingExpenseLine.Validate("Fee Code", GLEntry."Fee Code");
                            if LivingExpenseLine."Fee Type" = LivingExpenseLine."Fee Type"::Rent then begin
                                HousingApplication.Reset();
                                HousingApplication.SetRange("Student No.", StudentMaster."No.");
                                HousingApplication.SetRange("Academic Year", StudentMaster."Academic Year");
                                HousingApplication.SetRange(Semester, StudentMaster.Semester);
                                if HousingApplication.FindLast() then
                                    LivingExpenseLine.Validate("Global Dimension 2 Code", HousingApplication."Global Dimension 2 Code");
                            end;
                        end
                        ELSE begin
                            LivingExpenseLine."Fee Code" := 'PAYMENT';
                            LivingExpenseLine."Fee Description" := 'Payment';

                            if GLEntry."Document Type" = GLEntry."Document Type"::Refund then begin
                                LivingExpenseLine."Fee Code" := 'REFUND';
                                LivingExpenseLine."Fee Description" := 'Refund';
                            end;

                            if GLEntry."Source Code" = 'T_IV_ADVNC' then begin
                                LivingExpenseLine."Fee Code" := 'T4_ADVNC';
                                LivingExpenseLine."Fee Description" := 'T4 Advance';
                            end;
                            if GLEntry."Source Code" = 'T_IV_STPND' then begin
                                LivingExpenseLine."Fee Code" := 'T4_STPND';
                                LivingExpenseLine."Fee Description" := 'T4 Stipend';
                            end;
                        end;

                        if CLE.Amount > 0 then
                            LivingExpenseLine.Amount := Abs(GLEntry.Amount)
                        else
                            LivingExpenseLine.Amount := -1 * Abs(GLEntry.Amount);

                        LivingExpenseLine."Remaining Amount" := LivingExpenseLine.Amount;

                        LivingExpenseLine."Provisional Remaining Amount" := LivingExpenseLine."Remaining Amount";
                        LivingExpenseLine."G/L Entry No." := GLEntry."Entry No.";
                        LivingExpenseLine."Cust. Ledger Entry No." := CLE."Entry No.";
                        LivingExpenseLine."Application Entry No." := LivingExpenseLine."Entry No.";

                        if LivingExpenseLine."Fee Group" = LivingExpenseLine."Fee Group"::Institutional then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::Institutional;
                        if LivingExpenseLine."Fee Group" = LivingExpenseLine."Fee Group"::"Non-Institutional" then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Non-Institutional";
                        if LivingExpenseLine."Receipt Type" = LivingExpenseLine."Receipt Type"::"Financial Aid" then begin
                            if GLEntry."Fund Type" = GLEntry."Fund Type"::"FDSL-Plus" then
                                LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Grad Plus";
                            if GLEntry."Fund Type" = GLEntry."Fund Type"::"FDSL-Unsub" then
                                LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::Unsubsidized;
                        end;
                        if LivingExpenseLine."Receipt Type" = LivingExpenseLine."Receipt Type"::"Non-Financial Aid" then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Student Payment";
                        if LivingExpenseLine."Deposit Type" = LivingExpenseLine."Deposit Type"::"Seat Deposit" then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Seat Deposit";
                        if LivingExpenseLine."Deposit Type" = LivingExpenseLine."Deposit Type"::"Housing Deposit" then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Housing Deposit";
                        if ScholarshipEntry = true then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::Scholarship;
                        if GLEntry."Source Code" = 'T_IV_ADVNC' then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"T4 Advance";
                        if GLEntry."Source Code" = 'T_IV_STPND' then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"T4 Stipend Payment Advance";
                        if GLEntry."Living Exps. Entry Type" = GLEntry."Living Exps. Entry Type"::"Seat Deposit Refund" then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Seat Deposit Refund";
                        if GLEntry."Living Exps. Entry Type" = GLEntry."Living Exps. Entry Type"::"Rent Transfer Refund" then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Rent Transfer Refund";
                        if GLEntry."Living Exps. Entry Type" = GLEntry."Living Exps. Entry Type"::"Rent Transfer Payment" then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Rent Transfer Payment";
                        if GLEntry."Living Exps. Entry Type" = GLEntry."Living Exps. Entry Type"::"T4 Stipend Payment" then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"T4 Stipend Payment";
                        if GLEntry.Description = 'Refund of Student Payments' then
                            LivingExpenseLine."Entry Type" := LivingExpenseLine."Entry Type"::"Refund of Student Payment";
                        LivingExpenseLine.Insert();
                    end;
                end;
            until GLEntry.Next() = 0;
        end;

        UpdateRemainingBalances(StudentMaster, LNo);

        ApplyEntries(StudentMaster, LNo);

        FinancialAID.Reset();
        FinancialAID.SetRange("Student No.", StudentMaster."No.");
        //FinancialAID.SetRange("Academic Year", StudentMaster."Academic Year");   //TO BE OPEN
        FinancialAID.SetRange(Semester, StudentMaster.Semester);
        if FinancialAID.FindLast() then;

        SeatDepositAmt := 0;
        CreateSeatDepositEntry(StudentMaster, LNo, SeatDepositAmt, RemainingCrBalance);

        RemainingCrBalance := 0;
        CRLivingExpenseLine.Reset();
        CRLivingExpenseLine.SetRange("Document No.", LNo);
        CRLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        CRLivingExpenseLine.SetRange(Status, CRLivingExpenseLine.Status::"Posted Entries");
        CRLivingExpenseLine.SetRange("View Part", CRLivingExpenseLine."View Part"::"Posted Entries");
        CRLivingExpenseLine.SetFilter("Amount", '<%1', 0);
        CRLivingExpenseLine.SetFilter("Provisional Remaining Amount", '<%1', 0);
        CRLivingExpenseLine.SetFilter("Document Type", '<>%1', CRLivingExpenseLine."Document Type"::Application);
        CRLivingExpenseLine.SetFilter("Entry Type", '%1|%2', CRLivingExpenseLine."Entry Type"::"Grad Plus", CRLivingExpenseLine."Entry Type"::Unsubsidized);
        CRLivingExpenseLine.CalcSums("Provisional Remaining Amount");
        RemainingCrBalance := Abs(CRLivingExpenseLine."Provisional Remaining Amount");

        if RemainingCrBalance <> 0 then begin
            GVTrfAmt := 0;
            if (RemainingCrBalance > 0) and (StudentMaster."T4 Authorization" = true) then
                CreateRentTransferEntry_T4_TRUE(StudentMaster, LNo, GVTrfAmt, RemainingCrBalance);

            if (StudentMaster."T4 Authorization" = false) then
                CreateRentTransferEntry_T4_FALSE(StudentMaster, LNo, GVTrfAmt, RemainingCrBalance);

            if (RemainingCrBalance <> 0) and
            (FinancialAID."Living expenses" = FinancialAID."Living expenses"::YES) then
                CreateStipendPaymentEntry(StudentMaster, LNo, RefundAmount, RemainingCrBalance);
        end;

        CreateStudentPaymentRefundEntry(StudentMaster, LNo);

        W.Close();
    end;

    procedure UpdateRemainingBalances(StudentMaster: Record "Student Master-CS"; LNo: Code[20])
    var
        LivingExpenseLine: Record "Living Expense Line";
        //INSLivingExpenseLine: Record "Living Expense Line";
        //AppliedLivingExpenseLine: Record "Living Expense Line";
        LivingExpenseLine_FST: Record "Living Expense Line";
        LivingExpenseLine_SEC: Record "Living Expense Line";
        CLE: Record "Cust. Ledger Entry";
        DCLE: Record "Detailed Cust. Ledg. Entry";
        TotalDCLE: Record "Detailed Cust. Ledg. Entry";
        DCLELSEntryNo: Integer;
        AppliedAmt: Decimal;
        Text000Lbl: Label 'Process In Progress....      ##################1################\';
        Text001Lbl: Label 'Total Entries....      #################2#################\';
        Text002Lbl: Label 'Entry In Progress....      ##################3################\';
        W: Dialog;
        T: Integer;
        C: Integer;
    begin
        W.Open('Updating Remaining Balances\' + Text000Lbl + Text001Lbl + Text002Lbl);
        W.Update(1, 'Updating Remaining Balances (Process: 3/4)');

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetCurrentKey("Document No.", "Student ID", Amount);
        LivingExpenseLine.Ascending(false);
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Posted Entries");
        if LivingExpenseLine.FindSet() then begin
            T := LivingExpenseLine.Count;
            C := 0;
            repeat
                C += 1;
                W.Update(2, T);
                W.Update(3, C);
                LivingExpenseLine."Remaining Amount" := LivingExpenseLine.Amount;
                LivingExpenseLine."Provisional Remaining Amount" := LivingExpenseLine.Amount;
                LivingExpenseLine.Modify();
            until LivingExpenseLine.Next() = 0;
        end;

        CLE.Reset();
        CLE.SetCurrentKey("Enrollment No.", "Academic Year", Semester);
        CLE.SetRange("Enrollment No.", StudentMaster."Enrollment No.");
        if CLE.FindSet() then begin
            T := CLE.Count;
            C := 0;
            repeat
                C += 1;
                W.Update(2, T);
                W.Update(3, C);

                DCLELSEntryNo := -1;
                DCLE.Reset();
                DCLE.SetCurrentKey("Entry Type", "Cust. Ledger Entry No.", "Living Exps. Entry No.");
                DCLE.SetRange("Entry Type", DCLE."Entry Type"::Application);
                DCLE.SetRange("Cust. Ledger Entry No.", CLE."Entry No.");
                DCLE.SetRange(Unapplied, false);
                if DCLE.FindSet() then
                    repeat
                        if DCLE."Living Exps. Applied Entry No." <> DCLELSEntryNo then begin
                            DCLELSEntryNo := DCLE."Living Exps. Applied Entry No.";

                            TotalDCLE.Reset();
                            TotalDCLE.SetRange("Entry Type", DCLE."Entry Type"::Application);
                            TotalDCLE.SetRange("Cust. Ledger Entry No.", CLE."Entry No.");
                            TotalDCLE.SetRange("Living Exps. Applied Entry No.", DCLE."Living Exps. Applied Entry No.");
                            TotalDCLE.CalcSums(Amount);
                            AppliedAmt := Abs(TotalDCLE.Amount);

                            LivingExpenseLine.Reset();
                            LivingExpenseLine.SetCurrentKey("Document No.", "Entry Document No.", "Entry Type", "Fee Type");
                            LivingExpenseLine.SetRange("Document No.", LNo);
                            if DCLE."Living Exps. Applied Entry No." <> 0 then
                                LivingExpenseLine.SetRange("Entry No.", DCLE."Living Exps. Applied Entry No.");
                            LivingExpenseLine.SetRange("Entry Document No.", CLE."Document No.");
                            LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                            LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Posted Entries");
                            LivingExpenseLine.SetFilter("Provisional Remaining Amount", '<>%1', 0);
                            if LivingExpenseLine.FindSet() then
                                repeat
                                    if Abs(LivingExpenseLine."Remaining Amount") >= AppliedAmt then begin
                                        LivingExpenseLine."Remaining Amount" := Abs(LivingExpenseLine."Remaining Amount") - AppliedAmt;
                                        AppliedAmt := 0;
                                    end
                                    else begin
                                        AppliedAmt := AppliedAmt - Abs(LivingExpenseLine."Remaining Amount");
                                        LivingExpenseLine."Remaining Amount" := 0;
                                    end;

                                    if LivingExpenseLine.Amount < 0 then
                                        LivingExpenseLine."Remaining Amount" := -1 * LivingExpenseLine."Remaining Amount";

                                    LivingExpenseLine."Provisional Remaining Amount" := LivingExpenseLine."Remaining Amount";
                                    LivingExpenseLine.Modify();
                                until (LivingExpenseLine.Next() = 0);
                        end;
                    until DCLE.Next() = 0;
            Until CLE.Next() = 0;
        end;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetCurrentKey("Document No.", "Entry Document No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        //LivingExpenseLine.SetRange("Entry Document No.", CLE."Document No.");
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Posted Entries");
        if LivingExpenseLine.FindSet() then
            repeat
                if LivingExpenseLine."Entry Type" = LivingExpenseLine."Entry Type"::"Past Balance" then begin
                    LivingExpenseLine_FST.Reset();
                    LivingExpenseLine_FST.SetRange("Document No.", LNo);
                    LivingExpenseLine_FST.SetRange("Document Type", LivingExpenseLine_FST."Document Type"::Application);
                    LivingExpenseLine_FST.SetRange("Entry Document No.", LivingExpenseLine."Entry Document No.");
                    LivingExpenseLine_FST.SetRange(Status, LivingExpenseLine_FST.Status::Approved);
                    if LivingExpenseLine_FST.FindFirst() then begin
                        LivingExpenseLine."Remaining Amount" := 0;
                        LivingExpenseLine."Provisional Remaining Amount" := 0;
                        LivingExpenseLine.Modify();
                    end;
                end;

                if LivingExpenseLine."Document Type" IN [LivingExpenseLine."Document Type"::Payment, LivingExpenseLine."Document Type"::"Credit Note"] then begin
                    LivingExpenseLine_FST.Reset();
                    LivingExpenseLine_FST.SetRange("Document No.", LNo);
                    LivingExpenseLine_FST.SetRange("Document Type", LivingExpenseLine_FST."Document Type"::Application);
                    LivingExpenseLine_FST.SetRange("Applied Document No.", LivingExpenseLine."Entry Document No.");
                    LivingExpenseLine_FST.SetRange(Status, LivingExpenseLine_FST.Status::"Pending for Approval");
                    LivingExpenseLine_FST.CalcSums(Amount);
                    AppliedAmt := LivingExpenseLine_FST.Amount;
                end
                else begin
                    LivingExpenseLine_FST.Reset();
                    LivingExpenseLine_FST.SetRange("Document No.", LNo);
                    LivingExpenseLine_FST.SetRange("Document Type", LivingExpenseLine_FST."Document Type"::Application);
                    LivingExpenseLine_FST.SetRange("Entry Document No.", LivingExpenseLine."Entry Document No.");
                    LivingExpenseLine_FST.SetRange(Status, LivingExpenseLine_FST.Status::"Pending for Approval");
                    LivingExpenseLine_FST.CalcSums(Amount);
                    AppliedAmt := LivingExpenseLine_FST.Amount;
                end;

                if AppliedAmt <> 0 then begin
                    LivingExpenseLine_SEC.Reset();
                    LivingExpenseLine_SEC.SetCurrentKey("Document No.", "Student ID");
                    LivingExpenseLine_SEC.SetRange("Document No.", LNo);
                    LivingExpenseLine_SEC.SetRange("Cust. Ledger Entry No.", LivingExpenseLine."Cust. Ledger Entry No.");
                    LivingExpenseLine_SEC.SetRange("Student ID", StudentMaster."No.");
                    LivingExpenseLine_SEC.SetRange(Status, LivingExpenseLine.Status::"Posted Entries");
                    if LivingExpenseLine_SEC.FindSet() then
                        repeat
                            if Abs(LivingExpenseLine_SEC."Remaining Amount") > AppliedAmt then begin
                                LivingExpenseLine_SEC."Provisional Remaining Amount" := Abs(LivingExpenseLine_SEC."Remaining Amount") - AppliedAmt;
                                AppliedAmt := 0;
                            end
                            else begin
                                LivingExpenseLine_SEC."Provisional Remaining Amount" := 0;
                                AppliedAmt := AppliedAmt - Abs(LivingExpenseLine_SEC."Provisional Remaining Amount");
                            end;

                            if LivingExpenseLine_SEC.Amount < 0 then
                                LivingExpenseLine_SEC."Provisional Remaining Amount" := -1 * LivingExpenseLine_SEC."Provisional Remaining Amount";

                            LivingExpenseLine_SEC.Modify();
                        until (LivingExpenseLine_SEC.Next() = 0) or (AppliedAmt = 0);
                end;
            until (LivingExpenseLine.Next() = 0);

        UpdateStatus(LNo, StudentMaster);
    end;

    procedure ApplyEntries(StudentMaster: Record "Student Master-CS";
            LNo: Code[20])
    var
        FEELivingExpenseLine: Record "Living Expense Line";
        RCPTLivingExpenseLine: Record "Living Expense Line";
        AppliedLivingExpenseLine: Record "Living Expense Line";
        INSLivingExpenseLine: Record "Living Expense Line";
        AmountToApply: Decimal;
        Text000Lbl: Label 'Process In Progress....      ##################1################\';
        Text001Lbl: Label 'Total Entries....      #################2#################\';
        Text002Lbl: Label 'Entry In Progress....      ##################3################\';
        W: Dialog;
        T: Integer;
        C: Integer;
    begin
        W.Open('Applying Entries\' + Text000Lbl + Text001Lbl + Text002Lbl);
        W.Update(1, 'Applying Entries (Process: 4/4)');

        if StudentMaster."T4 Authorization" = false then begin
            FEELivingExpenseLine.Reset();
            FEELivingExpenseLine.SetCurrentKey("Document No.", "Student ID", "Entry Type");
            FEELivingExpenseLine.SetRange("Document No.", LNo);
            FEELivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            FEELivingExpenseLine.SetFilter("Document Type", '<>%1', FEELivingExpenseLine."Document Type"::Application);
            FEELivingExpenseLine.SetRange(Status, FEELivingExpenseLine.Status::"Posted Entries");
            FEELivingExpenseLine.SetFilter("Remaining Amount", '>%1', 0);
            FEELivingExpenseLine.SetFilter("Fee Type", '<>%1&<>%2', FEELivingExpenseLine."Fee Type"::Rent, FEELivingExpenseLine."Fee Type"::Housing);
            FEELivingExpenseLine.Setfilter("Entry Type", '%1|%2', FEELivingExpenseLine."Entry Type"::"Past Balance", FEELivingExpenseLine."Entry Type"::"Non-Institutional");
            if FEELivingExpenseLine.FindSet() then begin
                T := FeeLivingExpenseLine.Count;
                C := 0;
                repeat
                    C += 1;
                    W.Update(2, T);
                    W.Update(3, C);
                    AmountToApply := FEELivingExpenseLine."Remaining Amount";
                    FEELivingExpenseLine."Provisional Remaining Amount" := FEELivingExpenseLine."Remaining Amount";

                    if AmountToApply > 0 then begin
                        RCPTLivingExpenseLine.Reset();
                        RCPTLivingExpenseLine.SetCurrentKey("Document No.", "Student ID");
                        RCPTLivingExpenseLine.SetRange("Document No.", LNo);
                        RCPTLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                        RCPTLivingExpenseLine.SetFilter("Entry Type", '%1', RCPTLivingExpenseLine."Entry Type"::"Student Payment");
                        IF RCPTLivingExpenseLine.FindSet() then
                            repeat
                                AppliedLivingExpenseLine.Reset();
                                AppliedLivingExpenseLine.SetCurrentKey("Document No.", "Student ID", "Applied Document No.");
                                AppliedLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                                AppliedLivingExpenseLine.SetRange("Document No.", LNo);
                                AppliedLivingExpenseLine.SetRange("Applied Document No.", RCPTLivingExpenseLine."Entry Document No.");
                                AppliedLivingExpenseLine.SetRange("Document Type", AppliedLivingExpenseLine."Document Type"::Application);
                                AppliedLivingExpenseLine.CalcSums(Amount);
                                RCPTLivingExpenseLine."Provisional Remaining Amount" := RCPTLivingExpenseLine."Amount" + AppliedLivingExpenseLine.Amount;

                                if RCPTLivingExpenseLine."Provisional Remaining Amount" <> 0 then begin
                                    INSLivingExpenseLine.Init();
                                    INSLivingExpenseLine."Document No." := LNo;
                                    INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
                                    INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Application;
                                    INSLivingExpenseLine."Entry Document No." := FEELivingExpenseLine."Entry Document No.";
                                    INSLivingExpenseLine.Description := FEELivingExpenseLine."Fee Description";
                                    INSLivingExpenseLine."Receipt Type" := RCPTLivingExpenseLine."Receipt Type";
                                    INSLivingExpenseLine."Fee Code" := FEELivingExpenseLine."Fee Code";
                                    INSLivingExpenseLine."Fee Description" := FEELivingExpenseLine."Fee Description";
                                    INSLivingExpenseLine."Fee Group" := FEELivingExpenseLine."Fee Group";
                                    INSLivingExpenseLine."Fee Type" := FEELivingExpenseLine."Fee Type";
                                    INSLivingExpenseLine."Applied Document No." := RCPTLivingExpenseLine."Entry Document No.";
                                    INSLivingExpenseLine."G/L Entry No." := FEELivingExpenseLine."G/L Entry No.";
                                    INSLivingExpenseLine."G/L Account No." := FEELivingExpenseLine."G/L Account No.";
                                    INSLivingExpenseLine."G/L Account Name" := FEELivingExpenseLine."G/L Account Name";
                                    INSLivingExpenseLine."Cust. Ledger Entry No." := FEELivingExpenseLine."Cust. Ledger Entry No.";
                                    INSLivingExpenseLine."Application Entry No." := FEELivingExpenseLine."Entry No.";
                                    INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Application Entries";

                                    if FEELivingExpenseLine."Entry Type" = FEELivingExpenseLine."Entry Type"::"Past Balance" then
                                        INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Past Application";

                                    INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
                                    if AmountToApply > Abs(RCPTLivingExpenseLine."Provisional Remaining Amount") then begin
                                        INSLivingExpenseLine.Amount := Abs(RCPTLivingExpenseLine."Provisional Remaining Amount");
                                        AmountToApply := AmountToApply - Abs(RCPTLivingExpenseLine."Provisional Remaining Amount");
                                        FEELivingExpenseLine."Provisional Remaining Amount" := FEELivingExpenseLine."Provisional Remaining Amount" - INSLivingExpenseLine.Amount;
                                        RCPTLivingExpenseLine."Provisional Remaining Amount" := 0;
                                    end
                                    else begin
                                        INSLivingExpenseLine.Amount := FEELivingExpenseLine."Provisional Remaining Amount";
                                        AmountToApply := 0;
                                        FEELivingExpenseLine."Provisional Remaining Amount" := 0;
                                        RCPTLivingExpenseLine."Provisional Remaining Amount" := RCPTLivingExpenseLine."Provisional Remaining Amount" + INSLivingExpenseLine.Amount;
                                    end;

                                    FEELivingExpenseLine.Modify();
                                    RCPTLivingExpenseLine.Modify();

                                    INSLivingExpenseLine.Insert();
                                end;
                            until (RCPTLivingExpenseLine.Next() = 0) or (AmountToApply = 0);
                    end;
                until FEELivingExpenseLine.Next() = 0;
            end;
        end;


        FEELivingExpenseLine.Reset();
        FEELivingExpenseLine.SetCurrentKey("Document No.", "Student ID");
        FEELivingExpenseLine.SetRange("Document No.", LNo);
        FEELivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        FEELivingExpenseLine.SetFilter("Document Type", '<>%1', FEELivingExpenseLine."Document Type"::Application);
        FEELivingExpenseLine.SetRange(Status, FEELivingExpenseLine.Status::"Posted Entries");
        FEELivingExpenseLine.SetFilter("Remaining Amount", '>%1', 0);
        FEELivingExpenseLine.SetFilter("Fee Type", '<>%1&<>%2', FEELivingExpenseLine."Fee Type"::Rent, FEELivingExpenseLine."Fee Type"::Housing);
        if StudentMaster."T4 Authorization" = false then
            FEELivingExpenseLine.SetFilter("Entry Type", '%1|%2|%3', FEELivingExpenseLine."Entry Type"::Institutional, FEELivingExpenseLine."Entry Type"::"T4 Advance",
            FEELivingExpenseLine."Entry Type"::"T4 Stipend Payment Advance");
        if FEELivingExpenseLine.FindSet() then begin
            T := FeeLivingExpenseLine.Count;
            C := 0;
            repeat
                C += 1;
                W.Update(2, T);
                W.Update(3, C);

                AmountToApply := FEELivingExpenseLine."Remaining Amount";

                if (StudentMaster."T4 Authorization" = false) and (FEELivingExpenseLine."Entry Type" = FEELivingExpenseLine."Entry Type"::"Past Balance") then
                    AmountToApply := 0;

                //if not (FEELivingExpenseLine."Entry Type" IN [FEELivingExpenseLine."Entry Type"::"T4 Advance"]) then
                //  FEELivingExpenseLine."Provisional Remaining Amount" := FEELivingExpenseLine."Remaining Amount";

                if AmountToApply > 0 then begin
                    RCPTLivingExpenseLine.Reset();
                    RCPTLivingExpenseLine.SetCurrentKey("Document No.", "Student ID");
                    RCPTLivingExpenseLine.SetRange("Document No.", LNo);
                    RCPTLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");

                    if (FEELivingExpenseLine."Entry Type" = FEELivingExpenseLine."Entry Type"::"Past Balance") and (AmountToApply > 200) then
                        RCPTLivingExpenseLine.SetFilter("Entry Type", '%1', RCPTLivingExpenseLine."Entry Type"::"Student Payment");

                    if (FEELivingExpenseLine."Entry Type" = FEELivingExpenseLine."Entry Type"::"Past Balance") and (AmountToApply <= 200) then
                        RCPTLivingExpenseLine.SetFilter("Entry Type", '%1|%2', RCPTLivingExpenseLine."Entry Type"::"Grad Plus", RCPTLivingExpenseLine."Entry Type"::Unsubsidized);

                    if FEELivingExpenseLine."Entry Type" <> FEELivingExpenseLine."Entry Type"::"Past Balance" then
                        RCPTLivingExpenseLine.SetFilter("Entry Type", '%1|%2', RCPTLivingExpenseLine."Entry Type"::"Grad Plus", RCPTLivingExpenseLine."Entry Type"::Unsubsidized);

                    IF RCPTLivingExpenseLine.FindSet() then
                        repeat
                            AppliedLivingExpenseLine.Reset();
                            AppliedLivingExpenseLine.SetCurrentKey("Document No.", "Student ID", "Applied Document No.");
                            AppliedLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                            AppliedLivingExpenseLine.SetRange("Document No.", LNo);
                            AppliedLivingExpenseLine.SetRange("Applied Document No.", RCPTLivingExpenseLine."Entry Document No.");
                            AppliedLivingExpenseLine.SetRange("Document Type", AppliedLivingExpenseLine."Document Type"::Application);
                            AppliedLivingExpenseLine.CalcSums(Amount);
                            RCPTLivingExpenseLine."Provisional Remaining Amount" := RCPTLivingExpenseLine."Amount" + AppliedLivingExpenseLine.Amount;

                            if RCPTLivingExpenseLine."Provisional Remaining Amount" <> 0 then begin
                                INSLivingExpenseLine.Init();
                                INSLivingExpenseLine."Document No." := LNo;
                                INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
                                INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Application;
                                INSLivingExpenseLine."Entry Document No." := FEELivingExpenseLine."Entry Document No.";
                                INSLivingExpenseLine.Description := FEELivingExpenseLine."Fee Description";
                                INSLivingExpenseLine."Receipt Type" := RCPTLivingExpenseLine."Receipt Type";
                                INSLivingExpenseLine."Fee Code" := FEELivingExpenseLine."Fee Code";
                                INSLivingExpenseLine."Fee Description" := FEELivingExpenseLine."Fee Description";
                                INSLivingExpenseLine."Fee Group" := FEELivingExpenseLine."Fee Group";
                                INSLivingExpenseLine."Fee Type" := FEELivingExpenseLine."Fee Type";
                                INSLivingExpenseLine."Applied Document No." := RCPTLivingExpenseLine."Entry Document No.";
                                INSLivingExpenseLine."G/L Entry No." := FEELivingExpenseLine."G/L Entry No.";
                                INSLivingExpenseLine."G/L Account No." := FEELivingExpenseLine."G/L Account No.";
                                INSLivingExpenseLine."G/L Account Name" := FEELivingExpenseLine."G/L Account Name";
                                INSLivingExpenseLine."Cust. Ledger Entry No." := FEELivingExpenseLine."Cust. Ledger Entry No.";
                                INSLivingExpenseLine."Application Entry No." := FEELivingExpenseLine."Entry No.";
                                INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Application Entries";
                                INSLivingExpenseLine."Entry Type" := FEELivingExpenseLine."Entry Type";

                                if FEELivingExpenseLine."Entry Type" = FEELivingExpenseLine."Entry Type"::"Past Balance" then
                                    INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Past Application";

                                INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
                                if AmountToApply > Abs(RCPTLivingExpenseLine."Provisional Remaining Amount") then begin
                                    INSLivingExpenseLine.Amount := Abs(RCPTLivingExpenseLine."Provisional Remaining Amount");
                                    AmountToApply := AmountToApply - Abs(RCPTLivingExpenseLine."Provisional Remaining Amount");
                                    FEELivingExpenseLine."Provisional Remaining Amount" := FEELivingExpenseLine."Provisional Remaining Amount" - INSLivingExpenseLine.Amount;
                                    RCPTLivingExpenseLine."Provisional Remaining Amount" := 0;
                                end
                                else begin
                                    INSLivingExpenseLine.Amount := FEELivingExpenseLine."Provisional Remaining Amount";
                                    AmountToApply := 0;
                                    FEELivingExpenseLine."Provisional Remaining Amount" := 0;
                                    RCPTLivingExpenseLine."Provisional Remaining Amount" := RCPTLivingExpenseLine."Provisional Remaining Amount" + INSLivingExpenseLine.Amount;
                                end;

                                FEELivingExpenseLine.Modify();
                                RCPTLivingExpenseLine.Modify();

                                INSLivingExpenseLine.Insert();
                            end;
                        until (RCPTLivingExpenseLine.Next() = 0) or (AmountToApply = 0);
                end;
            until FEELivingExpenseLine.Next() = 0;
        end;
    end;


    procedure CreateSeatDepositEntry(StudentMaster: Record "Student Master-CS"; LNo: Code[20]; var SeatDepositAmt: Decimal; var RemainingCrBalance: Decimal)
    var
        CRLivingExpenseLine: Record "Living Expense Line";
        INSLivingExpenseLine: Record "Living Expense Line";
        RefundType: Option " ","Seat Deposit","GV Transfer","T4 Stipend Payment","Refund of Student Payment";
    begin
        SeatDepositAmt := 0;
        if CheckEntryExistance(LNo, RefundType::"Seat Deposit") = false then begin
            CRLivingExpenseLine.Reset();
            CRLivingExpenseLine.SetRange("Document No.", LNo);
            CRLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            CRLivingExpenseLine.SetRange(Status, CRLivingExpenseLine.Status::"Posted Entries");
            CRLivingExpenseLine.SetFilter("Amount", '<%1', 0);
            CRLivingExpenseLine.SetFilter("Provisional Remaining Amount", '<%1', 0);
            CRLivingExpenseLine.SetFilter("Document Type", '<>%1', CRLivingExpenseLine."Document Type"::Application);
            CRLivingExpenseLine.SetRange("Deposit Type", CRLivingExpenseLine."Deposit Type"::"Seat Deposit");
            CRLivingExpenseLine.CalcSums(Amount);
            SeatDepositAmt := -1 * CRLivingExpenseLine.Amount;
        end;

        if SeatDepositAmt <> 0 then begin
            INSLivingExpenseLine.Init();
            INSLivingExpenseLine."Document No." := LNo;
            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Refund;
            INSLivingExpenseLine.Description := 'Refund of Seat Deposit';
            INSLivingExpenseLine."Fee Code" := 'SEAT_DEPOSIT';
            INSLivingExpenseLine."Fee Description" := 'Refund of Seat Deposit';
            INSLivingExpenseLine."Entry Type" := INSLivingExpenseLine."Entry Type"::"Seat Deposit Refund";
            INSLivingExpenseLine."Applied Document No." := 'SEAT DEPOSIT PAYMENT';
            INSLivingExpenseLine.Amount := SeatDepositAmt;
            INSLivingExpenseLine."Posting Amount" := SeatDepositAmt;
            INSLivingExpenseLine."Deposit Type" := INSLivingExpenseLine."Deposit Type"::"Seat Deposit";
            INSLivingExpenseLine."Refund Type" := INSLivingExpenseLine."Refund Type"::"Seat Deposit";
            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Posting Entries";
            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
            INSLivingExpenseLine.Insert();
            RemainingCrBalance := 1 * RemainingCrBalance; //TO REMOVE WARNING
        end;
    end;


    procedure CreateRentTransferEntry_T4_TRUE(StudentMaster: Record "Student Master-CS"; LNo: Code[20]; var GVTrfAmt: Decimal; var RemainingCrBalance: Decimal)
    var
        DRLivingExpenseLine: Record "Living Expense Line";
        FeeLivingExpenseLine: Record "Living Expense Line";
        RCPTLivingExpenseLine: Record "Living Expense Line";
        INSLivingExpenseLine: Record "Living Expense Line";
        RefundType: Option " ","Seat Deposit","GV Transfer","T4 Stipend Payment","Refund of Student Payment";
        TempGVTrfAmt: Decimal;
    begin
        if CheckEntryExistance(LNo, RefundType::"GV Transfer") = false then begin
            DRLivingExpenseLine.Reset();
            DRLivingExpenseLine.SetRange("Document No.", LNo);
            DRLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            DRLivingExpenseLine.SetRange(Status, DRLivingExpenseLine.Status::"Posted Entries");
            DRLivingExpenseLine.SetFilter("Amount", '>%1', 0);
            DRLivingExpenseLine.SetFilter("Provisional Remaining Amount", '>%1', 0);
            DRLivingExpenseLine.SetFilter("Fee Type", '%1|%2', DRLivingExpenseLine."Fee Type"::Rent, DRLivingExpenseLine."Fee Type"::Housing);
            DRLivingExpenseLine.CalcSums("Provisional Remaining Amount");

            if (DRLivingExpenseLine."Provisional Remaining Amount" <> 0) then
                if (RemainingCrBalance > DRLivingExpenseLine."Provisional Remaining Amount") then
                    GVTrfAmt := DRLivingExpenseLine."Provisional Remaining Amount"
                else
                    GVTrfAmt := RemainingCrBalance;

            TempGVTrfAmt := GVTrfAmt;

            FeeLivingExpenseLine.Reset();
            FeeLivingExpenseLine.SetRange("Document No.", LNo);
            FeeLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            FeeLivingExpenseLine.SetRange(Status, FeeLivingExpenseLine.Status::"Posted Entries");
            FeeLivingExpenseLine.SetFilter("Amount", '>%1', 0);
            FeeLivingExpenseLine.SetFilter("Provisional Remaining Amount", '>%1', 0);
            FeeLivingExpenseLine.SetFilter("Fee Type", '%1|%2', DRLivingExpenseLine."Fee Type"::Rent, DRLivingExpenseLine."Fee Type"::Housing);
            if FeeLivingExpenseLine.FindSet() then
                repeat
                    RCPTLivingExpenseLine.Reset();
                    RCPTLivingExpenseLine.SetRange("Document No.", LNo);
                    RCPTLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                    RCPTLivingExpenseLine.SetRange(Status, RCPTLivingExpenseLine.Status::"Posted Entries");
                    RCPTLivingExpenseLine.SetRange("View Part", RCPTLivingExpenseLine."View Part"::"Posted Entries");
                    RCPTLivingExpenseLine.SetFilter("Amount", '<%1', 0);
                    RCPTLivingExpenseLine.SetFilter("Provisional Remaining Amount", '<%1', 0);
                    RCPTLivingExpenseLine.SetFilter("Entry Type", '%1|%2', RCPTLivingExpenseLine."Entry Type"::"Grad Plus", RCPTLivingExpenseLine."Entry Type"::Unsubsidized);
                    if RCPTLivingExpenseLine.FindSet() then
                        repeat
                            INSLivingExpenseLine.Init();
                            INSLivingExpenseLine."Document No." := LNo;
                            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
                            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Application;
                            INSLivingExpenseLine."Entry Document No." := FeeLivingExpenseLine."Entry Document No.";
                            INSLivingExpenseLine.Description := FeeLivingExpenseLine."Fee Description";
                            INSLivingExpenseLine."Receipt Type" := RCPTLivingExpenseLine."Receipt Type";
                            INSLivingExpenseLine."Fee Code" := FeeLivingExpenseLine."Fee Code";
                            INSLivingExpenseLine."Fee Description" := FeeLivingExpenseLine."Fee Description";
                            INSLivingExpenseLine."Fee Group" := FeeLivingExpenseLine."Fee Group";
                            INSLivingExpenseLine."Fee Type" := FeeLivingExpenseLine."Fee Type";
                            INSLivingExpenseLine."Applied Document No." := RCPTLivingExpenseLine."Entry Document No.";
                            INSLivingExpenseLine."G/L Entry No." := FeeLivingExpenseLine."G/L Entry No.";
                            INSLivingExpenseLine."G/L Account No." := FeeLivingExpenseLine."G/L Account No.";
                            INSLivingExpenseLine."G/L Account Name" := FeeLivingExpenseLine."G/L Account Name";
                            INSLivingExpenseLine."Cust. Ledger Entry No." := FEELivingExpenseLine."Cust. Ledger Entry No.";
                            INSLivingExpenseLine."Application Entry No." := FEELivingExpenseLine."Entry No.";
                            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Housing Application";

                            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";

                            if FeeLivingExpenseLine."Provisional Remaining Amount" > Abs(RCPTLivingExpenseLine."Provisional Remaining Amount") then begin
                                if Abs(RCPTLivingExpenseLine."Provisional Remaining Amount") > TempGVTrfAmt then
                                    INSLivingExpenseLine.Amount := TempGVTrfAmt
                                else
                                    INSLivingExpenseLine.Amount := Abs(RCPTLivingExpenseLine."Provisional Remaining Amount");
                                FEELivingExpenseLine."Provisional Remaining Amount" := FEELivingExpenseLine."Provisional Remaining Amount" - INSLivingExpenseLine.Amount;
                                RCPTLivingExpenseLine."Provisional Remaining Amount" := RCPTLivingExpenseLine."Provisional Remaining Amount" + INSLivingExpenseLine.Amount;
                            end
                            else begin
                                if FEELivingExpenseLine."Provisional Remaining Amount" > TempGVTrfAmt then
                                    INSLivingExpenseLine.Amount := TempGVTrfAmt
                                else
                                    INSLivingExpenseLine.Amount := FEELivingExpenseLine."Provisional Remaining Amount";
                                FEELivingExpenseLine."Provisional Remaining Amount" := FEELivingExpenseLine."Provisional Remaining Amount" - INSLivingExpenseLine.Amount;
                                RCPTLivingExpenseLine."Provisional Remaining Amount" := RCPTLivingExpenseLine."Provisional Remaining Amount" + INSLivingExpenseLine.Amount;
                            end;

                            TempGVTrfAmt := TempGVTrfAmt - INSLivingExpenseLine.Amount;
                            FEELivingExpenseLine.Modify();
                            RCPTLivingExpenseLine.Modify();

                            INSLivingExpenseLine.Insert();
                        until (RCPTLivingExpenseLine.Next() = 0) or (TempGVTrfAmt = 0) or (FEELivingExpenseLine."Provisional Remaining Amount" = 0);
                until FeeLivingExpenseLine.Next() = 0;

        end;

        if GVTrfAmt <> 0 then begin
            INSLivingExpenseLine.Init();
            INSLivingExpenseLine."Document No." := LNo;
            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Refund;
            INSLivingExpenseLine.Description := 'GV Transfer';
            INSLivingExpenseLine."Fee Code" := 'GV-TRF';
            INSLivingExpenseLine."Fee Description" := 'GV Transfer';
            INSLivingExpenseLine."Entry Type" := INSLivingExpenseLine."Entry Type"::"Rent Transfer Refund";
            INSLivingExpenseLine."Applied Document No." := 'FINANCIAL AID';
            INSLivingExpenseLine.Amount := GVTrfAmt;
            INSLivingExpenseLine."Posting Amount" := GVTrfAmt;
            INSLivingExpenseLine."Refund Type" := INSLivingExpenseLine."Refund Type"::"GV Transfer";
            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Posting Entries";
            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
            INSLivingExpenseLine.Insert();

            INSLivingExpenseLine.Init();
            INSLivingExpenseLine."Document No." := LNo;
            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Payment;
            INSLivingExpenseLine.Description := 'GV Transfer';
            INSLivingExpenseLine."Entry Type" := INSLivingExpenseLine."Entry Type"::"Rent Transfer Payment";
            INSLivingExpenseLine."Fee Code" := 'GV-TRF';
            INSLivingExpenseLine."Fee Description" := 'GV Transfer';
            INSLivingExpenseLine."Applied Document No." := 'FINANCIAL AID';
            INSLivingExpenseLine.Amount := -1 * GVTrfAmt;
            INSLivingExpenseLine."Posting Amount" := -1 * GVTrfAmt;
            INSLivingExpenseLine."Refund Type" := INSLivingExpenseLine."Refund Type"::"GV Transfer";
            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Posting Entries";
            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
            INSLivingExpenseLine.Insert();


            RemainingCrBalance := RemainingCrBalance - GVTrfAmt;
        end;
    end;


    procedure CreateRentTransferEntry_T4_FALSE(StudentMaster: Record "Student Master-CS"; LNo: Code[20]; var GVTrfAmt: Decimal; var RemainingCrBalance: Decimal)
    var
        DRLivingExpenseLine: Record "Living Expense Line";
        CRLivingExpenseLine: Record "Living Expense Line";
        FeeLivingExpenseLine: Record "Living Expense Line";
        RCPTLivingExpenseLine: Record "Living Expense Line";
        INSLivingExpenseLine: Record "Living Expense Line";
        StudentPaymentBalance: Decimal;
        TempGVTrfAmt: Decimal;
        RefundType: Option " ","Seat Deposit","GV Transfer","T4 Stipend Payment","Refund of Student Payment";
    begin
        RemainingCrBalance := 1 * RemainingCrBalance;  //JUST TO REMOVE WANRING
        if CheckEntryExistance(LNo, RefundType::"GV Transfer") = false then begin
            DRLivingExpenseLine.Reset();
            DRLivingExpenseLine.SetRange("Document No.", LNo);
            DRLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            DRLivingExpenseLine.SetRange(Status, DRLivingExpenseLine.Status::"Posted Entries");
            DRLivingExpenseLine.SetFilter("Amount", '>%1', 0);
            DRLivingExpenseLine.SetFilter("Provisional Remaining Amount", '>%1', 0);
            DRLivingExpenseLine.SetFilter("Fee Type", '%1|%2', DRLivingExpenseLine."Fee Type"::Rent, DRLivingExpenseLine."Fee Type"::Housing);
            DRLivingExpenseLine.CalcSums("Provisional Remaining Amount");

            CRLivingExpenseLine.Reset();
            CRLivingExpenseLine.SetRange("Document No.", LNo);
            CRLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            CRLivingExpenseLine.SetRange(Status, CRLivingExpenseLine.Status::"Posted Entries");
            CRLivingExpenseLine.SetFilter("Amount", '<%1', 0);
            CRLivingExpenseLine.SetFilter("Provisional Remaining Amount", '<%1', 0);
            CRLivingExpenseLine.SetRange("Entry Type", CRLivingExpenseLine."Entry Type"::"Student Payment");
            CRLivingExpenseLine.CalcSums("Provisional Remaining Amount");
            StudentPaymentBalance := Abs(CRLivingExpenseLine."Provisional Remaining Amount");

            if DRLivingExpenseLine."Provisional Remaining Amount" <> 0 then
                if StudentPaymentBalance > DRLivingExpenseLine."Provisional Remaining Amount" then
                    GVTrfAmt := DRLivingExpenseLine."Provisional Remaining Amount"
                else
                    GVTrfAmt := StudentPaymentBalance;

            TempGVTrfAmt := GVTrfAmt;

            FeeLivingExpenseLine.Reset();
            FeeLivingExpenseLine.SetRange("Document No.", LNo);
            FeeLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            FeeLivingExpenseLine.SetRange(Status, FeeLivingExpenseLine.Status::"Posted Entries");
            FeeLivingExpenseLine.SetFilter("Amount", '>%1', 0);
            FeeLivingExpenseLine.SetFilter("Provisional Remaining Amount", '>%1', 0);
            FeeLivingExpenseLine.SetFilter("Fee Type", '%1|%2', DRLivingExpenseLine."Fee Type"::Rent, DRLivingExpenseLine."Fee Type"::Housing);
            if FeeLivingExpenseLine.FindSet() then
                repeat
                    RCPTLivingExpenseLine.Reset();
                    RCPTLivingExpenseLine.SetRange("Document No.", LNo);
                    RCPTLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                    RCPTLivingExpenseLine.SetRange(Status, RCPTLivingExpenseLine.Status::"Posted Entries");
                    RCPTLivingExpenseLine.SetRange("View Part", RCPTLivingExpenseLine."View Part"::"Posted Entries");
                    RCPTLivingExpenseLine.SetFilter("Amount", '<%1', 0);
                    RCPTLivingExpenseLine.SetFilter("Provisional Remaining Amount", '<%1', 0);
                    RCPTLivingExpenseLine.SetFilter("Entry Type", '%1', RCPTLivingExpenseLine."Entry Type"::"Student Payment");
                    if RCPTLivingExpenseLine.FindSet() then
                        repeat
                            INSLivingExpenseLine.Init();
                            INSLivingExpenseLine."Document No." := LNo;
                            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
                            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Application;
                            INSLivingExpenseLine."Entry Document No." := FeeLivingExpenseLine."Entry Document No.";
                            INSLivingExpenseLine.Description := FeeLivingExpenseLine."Fee Description";
                            INSLivingExpenseLine."Receipt Type" := RCPTLivingExpenseLine."Receipt Type";
                            INSLivingExpenseLine."Fee Code" := FeeLivingExpenseLine."Fee Code";
                            INSLivingExpenseLine."Fee Description" := FeeLivingExpenseLine."Fee Description";
                            INSLivingExpenseLine."Fee Group" := FeeLivingExpenseLine."Fee Group";
                            INSLivingExpenseLine."Fee Type" := FeeLivingExpenseLine."Fee Type";
                            INSLivingExpenseLine."Applied Document No." := RCPTLivingExpenseLine."Entry Document No.";
                            INSLivingExpenseLine."G/L Entry No." := FeeLivingExpenseLine."G/L Entry No.";
                            INSLivingExpenseLine."G/L Account No." := FeeLivingExpenseLine."G/L Account No.";
                            INSLivingExpenseLine."G/L Account Name" := FeeLivingExpenseLine."G/L Account Name";
                            INSLivingExpenseLine."Cust. Ledger Entry No." := FEELivingExpenseLine."Cust. Ledger Entry No.";
                            INSLivingExpenseLine."Application Entry No." := FEELivingExpenseLine."Entry No.";
                            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Housing Application";

                            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";

                            if FeeLivingExpenseLine."Provisional Remaining Amount" > Abs(RCPTLivingExpenseLine."Provisional Remaining Amount") then begin
                                if Abs(RCPTLivingExpenseLine."Provisional Remaining Amount") > TempGVTrfAmt then
                                    INSLivingExpenseLine.Amount := TempGVTrfAmt
                                else
                                    INSLivingExpenseLine.Amount := Abs(RCPTLivingExpenseLine."Provisional Remaining Amount");
                                FEELivingExpenseLine."Provisional Remaining Amount" := FEELivingExpenseLine."Provisional Remaining Amount" - INSLivingExpenseLine.Amount;
                                RCPTLivingExpenseLine."Provisional Remaining Amount" := RCPTLivingExpenseLine."Provisional Remaining Amount" + INSLivingExpenseLine.Amount;
                            end
                            else begin
                                if FEELivingExpenseLine."Provisional Remaining Amount" > TempGVTrfAmt then
                                    INSLivingExpenseLine.Amount := TempGVTrfAmt
                                else
                                    INSLivingExpenseLine.Amount := FEELivingExpenseLine."Provisional Remaining Amount";
                                FEELivingExpenseLine."Provisional Remaining Amount" := FEELivingExpenseLine."Provisional Remaining Amount" - INSLivingExpenseLine.Amount;
                                RCPTLivingExpenseLine."Provisional Remaining Amount" := RCPTLivingExpenseLine."Provisional Remaining Amount" + INSLivingExpenseLine.Amount;
                            end;

                            TempGVTrfAmt := TempGVTrfAmt - INSLivingExpenseLine.Amount;
                            FEELivingExpenseLine.Modify();
                            RCPTLivingExpenseLine.Modify();
                            INSLivingExpenseLine.Insert();
                        until (RCPTLivingExpenseLine.Next() = 0) or (TempGVTrfAmt = 0) or (FEELivingExpenseLine."Provisional Remaining Amount" = 0);
                until FEELivingExpenseLine.Next() = 0;
        end;

        if GVTrfAmt <> 0 then begin
            INSLivingExpenseLine.Init();
            INSLivingExpenseLine."Document No." := LNo;
            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Refund;
            INSLivingExpenseLine.Description := 'GV Transfer';
            INSLivingExpenseLine."Fee Code" := 'GV-TRF';
            INSLivingExpenseLine."Fee Description" := 'GV Transfer';
            INSLivingExpenseLine."Entry Type" := INSLivingExpenseLine."Entry Type"::"Rent Transfer Refund";
            INSLivingExpenseLine."Applied Document No." := 'STUDENT PAYMENT';
            INSLivingExpenseLine.Amount := GVTrfAmt;
            INSLivingExpenseLine."Posting Amount" := GVTrfAmt;
            INSLivingExpenseLine."Refund Type" := INSLivingExpenseLine."Refund Type"::"GV Transfer";
            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Posting Entries";
            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
            INSLivingExpenseLine.Insert();

            INSLivingExpenseLine.Init();
            INSLivingExpenseLine."Document No." := LNo;
            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Payment;
            INSLivingExpenseLine.Description := 'GV Transfer';
            INSLivingExpenseLine."Entry Type" := INSLivingExpenseLine."Entry Type"::"Rent Transfer Payment";
            INSLivingExpenseLine."Fee Code" := 'GV-TRF';
            INSLivingExpenseLine."Fee Description" := 'GV Transfer';
            INSLivingExpenseLine."Applied Document No." := 'STUDENT PAYMENT';
            INSLivingExpenseLine.Amount := -1 * GVTrfAmt;
            INSLivingExpenseLine."Posting Amount" := -1 * GVTrfAmt;
            INSLivingExpenseLine."Refund Type" := INSLivingExpenseLine."Refund Type"::"GV Transfer";
            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Posting Entries";
            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
            INSLivingExpenseLine.Insert();
        end;
    end;

    procedure CreateStipendPaymentEntry(StudentMaster: Record "Student Master-CS"; LNo: Code[20]; var RefundAmount: Decimal; var RemainingCrBalance: Decimal)
    var
        INSLivingExpenseLine: Record "Living Expense Line";
        RefundType: Option " ","Seat Deposit","GV Transfer","T4 Stipend Payment","Refund of Student Payment";
    begin
        if CheckEntryExistance(LNo, RefundType::"T4 Stipend Payment") = false then
            RefundAmount := RemainingCrBalance
        else
            RefundAmount := 0;

        if RefundAmount <> 0 then begin
            INSLivingExpenseLine.Init();
            INSLivingExpenseLine."Document No." := LNo;
            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Refund;
            INSLivingExpenseLine.Description := 'T4 Stipend Payment';
            INSLivingExpenseLine."Fee Description" := 'T4 Stipend Payment';
            INSLivingExpenseLine."Entry Type" := INSLivingExpenseLine."Entry Type"::"T4 Stipend Payment";
            INSLivingExpenseLine."Applied Document No." := '';
            INSLivingExpenseLine.Amount := RefundAmount;
            INSLivingExpenseLine."Posting Amount" := RefundAmount;
            INSLivingExpenseLine."Refund Type" := INSLivingExpenseLine."Refund Type"::"T4 Stipend Payment";
            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Posting Entries";
            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
            INSLivingExpenseLine.Insert();
            RemainingCrBalance := 1 * RemainingCrBalance;  //JUST TO REMOVE WARNING
        end;
    end;

    procedure CreateStudentPaymentRefundEntry(StudentMaster: Record "Student Master-CS"; LNo: Code[20])
    var
        INSLivingExpenseLine: Record "Living Expense Line";
        CRLivingExpenseLine: Record "Living Expense Line";
        ApplLivingExpenseLine: Record "Living Expense Line";
        LivingExpenseLine_FST: Record "Living Expense Line";
        RemainingCrBalance: Decimal;
        RefundType: Option " ","Seat Deposit","GV Transfer","T4 Stipend Payment","Refund of Student Payment";
    begin
        if CheckEntryExistance(LNo, RefundType::"Refund of Student Payment") = true then
            exit;
        RemainingCrBalance := 0;
        CRLivingExpenseLine.Reset();
        CRLivingExpenseLine.SetRange("Document No.", LNo);
        CRLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        CRLivingExpenseLine.SetRange(Status, CRLivingExpenseLine.Status::"Posted Entries");
        CRLivingExpenseLine.SetRange("View Part", CRLivingExpenseLine."View Part"::"Posted Entries");
        CRLivingExpenseLine.SetFilter("Document Type", '<>%1', CRLivingExpenseLine."Document Type"::Application);
        CRLivingExpenseLine.SetRange("Entry Type", CRLivingExpenseLine."Entry Type"::"Student Payment");
        CRLivingExpenseLine.SetFilter("Amount", '<%1', 0);
        CRLivingExpenseLine.CalcSums("Remaining Amount", "Provisional Remaining Amount");
        RemainingCrBalance := Abs(CRLivingExpenseLine."Remaining Amount");


        CRLivingExpenseLine.Reset();
        CRLivingExpenseLine.SetRange("Document No.", LNo);
        CRLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        CRLivingExpenseLine.SetRange(Status, CRLivingExpenseLine.Status::"Posted Entries");
        CRLivingExpenseLine.SetRange("View Part", CRLivingExpenseLine."View Part"::"Posted Entries");
        CRLivingExpenseLine.SetFilter("Document Type", '<>%1', CRLivingExpenseLine."Document Type"::Application);
        CRLivingExpenseLine.SetRange("Entry Type", CRLivingExpenseLine."Entry Type"::"Student Payment");
        CRLivingExpenseLine.SetFilter("Amount", '<%1', 0);
        if CRLivingExpenseLine.FindSet() then
            repeat
                ApplLivingExpenseLine.Reset();
                ApplLivingExpenseLine.SetRange("Document No.", LNo);
                ApplLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                ApplLivingExpenseLine.SetRange("Document Type", ApplLivingExpenseLine."Document Type"::Application);
                ApplLivingExpenseLine.SetRange("Applied Document No.", CRLivingExpenseLine."Entry Document No.");
                ApplLivingExpenseLine.SetFilter("Amount", '>%1', 0);
                if ApplLivingExpenseLine.FindFirst() then
                    RemainingCrBalance := RemainingCrBalance - ApplLivingExpenseLine.Amount;
            until CRLivingExpenseLine.Next() = 0;

        CRLivingExpenseLine.Reset();
        CRLivingExpenseLine.SetRange("Document No.", LNo);
        CRLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        CRLivingExpenseLine.SetRange("View Part", CRLivingExpenseLine."View Part"::"Posting Entries");
        CRLivingExpenseLine.SetFilter("Amount", '>%1', 0);
        CRLivingExpenseLine.SetRange("Entry Type", CRLivingExpenseLine."Entry Type"::"Rent Transfer Refund");
        CRLivingExpenseLine.SetRange("Applied Document No.", 'STUDENT PAYMENT');
        CRLivingExpenseLine.CalcSums("Amount");
        RemainingCrBalance := RemainingCrBalance - CRLivingExpenseLine.Amount;

        if RemainingCrBalance > 0 then begin
            INSLivingExpenseLine.Init();
            INSLivingExpenseLine."Document No." := LNo;
            INSLivingExpenseLine.Validate("Student ID", StudentMaster."No.");
            INSLivingExpenseLine."Document Type" := INSLivingExpenseLine."Document Type"::Refund;
            INSLivingExpenseLine.Description := 'Refund of Student Payments';
            INSLivingExpenseLine."Fee Description" := 'Refund of Student Payments';
            INSLivingExpenseLine."Entry Type" := INSLivingExpenseLine."Entry Type"::"Refund of Student Payment";
            INSLivingExpenseLine."Applied Document No." := '';
            INSLivingExpenseLine.Amount := RemainingCrBalance;
            INSLivingExpenseLine."Posting Amount" := RemainingCrBalance;
            INSLivingExpenseLine."Refund Type" := INSLivingExpenseLine."Refund Type"::"Student Payment";
            INSLivingExpenseLine."View Part" := INSLivingExpenseLine."View Part"::"Posting Entries";
            INSLivingExpenseLine.Status := INSLivingExpenseLine.Status::"Pending for Approval";
            INSLivingExpenseLine.Insert();

            LivingExpenseLine_FST.Reset();
            LivingExpenseLine_FST.SetCurrentKey("Student ID", "Document No.");
            LivingExpenseLine_FST.SetRange("Document No.", LNo);
            LivingExpenseLine_FST.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine_FST.SetRange(Status, LivingExpenseLine_FST.Status::"Posted Entries");
            LivingExpenseLine_FST.SetRange("Entry Type", LivingExpenseLine_FST."Entry Type"::"Student Payment");
            LivingExpenseLine_FST.SetFilter("Provisional Remaining Amount", '<%1', 0);
            if LivingExpenseLine_FST.FindSet() then
                repeat
                    IF Abs(LivingExpenseLine_FST."Provisional Remaining Amount") > RemainingCrBalance then begin
                        LivingExpenseLine_FST."Provisional Remaining Amount" := LivingExpenseLine_FST."Provisional Remaining Amount" - RemainingCrBalance;
                        RemainingCrBalance := 0;
                    end
                    else begin
                        RemainingCrBalance := RemainingCrBalance + LivingExpenseLine_FST."Provisional Remaining Amount";
                        LivingExpenseLine_FST."Provisional Remaining Amount" := 0;
                    end;

                    LivingExpenseLine_FST.Modify();
                until LivingExpenseLine_FST.Next() = 0;
        end;
    end;

    procedure PostApplication(StudentMaster: Record "Student Master-CS"; DocumentNo: Code[20]; BulkCall: Boolean)
    var
        CLE: Record "Cust. Ledger Entry";
        CLE_FST: Record "Cust. Ledger Entry";
        LivingExpenseLine: Record "Living Expense Line";
        RCPTLivingExpenseLine: Record "Living Expense Line";
        SemesterRec: Record "Semester Master-CS";
        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
        CurrentSemesterSequence: Integer;
        ApplyingAmount: Decimal;
        PreviousSemesters: Code[100];
        NewApplicationDate: Date;
        NewDocumentNo: Code[20];
    begin
        if BulkCall = false then begin
            LivingExpenseLine.Reset();
            LivingExpenseLine.SetRange("Document No.", DocumentNo);
            LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
            LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Application);
            if not LivingExpenseLine.FindFirst() then
                Error('There is no application entry pending to Post.');
        end;

        CurrentSemesterSequence := 0;
        PreviousSemesters := '';

        SemesterRec.Reset();
        SemesterRec.SetRange(Code, StudentMaster.Semester);
        SemesterRec.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if SemesterRec.FindFirst() then
            CurrentSemesterSequence := SemesterRec.Sequence;

        SemesterRec.Reset();
        SemesterRec.SetFilter(Sequence, '<%1', CurrentSemesterSequence);
        SemesterRec.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if SemesterRec.FindSet() then
            repeat
                if PreviousSemesters = '' then
                    PreviousSemesters := SemesterRec.Code
                else
                    PreviousSemesters := PreviousSemesters + '|' + SemesterRec.Code;
            until SemesterRec.Next() = 0;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", DocumentNo);
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Application);
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Past Application");
        if LivingExpenseLine.FindFirst() then begin
            ApplyingAmount := LivingExpenseLine.Amount;

            RCPTLivingExpenseLine.Reset();
            RCPTLivingExpenseLine.SetRange("Document No.", DocumentNo);
            RCPTLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            RCPTLivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Posted Entries");
            RCPTLivingExpenseLine.SetRange("Entry Document No.", LivingExpenseLine."Applied Document No.");
            if RCPTLivingExpenseLine.FindFirst() then;

            CLE_FST.Reset();
            CLE_FST.SetRange("Document No.", LivingExpenseLine."Applied Document No.");
            CLE_FST.SetRange("Customer No.", LivingExpenseLine."Student ID");
            if CLE_FST.FindFirst() then begin
                CLE_FST.CalcFields(Amount, "Remaining Amount");
                CLE_FST."Applies-to ID" := UserId;
                CLE_FST."Amount to Apply" := -1 * ApplyingAmount;
                CLE_FST."Living Exps. Document No." := LivingExpenseLine."Document No.";
                CLE_FST."Living Exps. Entry No." := LivingExpenseLine."Entry No.";
                CLE_FST."Living Exps. INV Entry No." := LivingExpenseLine."Application Entry No.";
                CLE_FST."Living Exps. RCPT Entry No." := RCPTLivingExpenseLine."Entry No.";
                CLE_FST.Modify();
            end;

            Clear(CLE);
            CLE.Reset();
            CLE.SetCurrentKey("Customer No.", Semester);
            CLE.SetRange("Customer No.", StudentMaster."No.");
            CLE.SetFilter(Semester, PreviousSemesters);
            if CLE.FindSet() then
                repeat
                    CLE.CalcFields("Remaining Amount");

                    if ApplyingAmount > CLE."Remaining Amount" then begin
                        CLE."Applies-to ID" := UserId;
                        CLE."Amount to Apply" := CLE."Remaining Amount";
                        CLE."Applying Entry" := true;
                        CLE."Living Exps. Document No." := LivingExpenseLine."Document No.";
                        CLE."Living Exps. Entry No." := LivingExpenseLine."Entry No.";
                        CLE."Living Exps. INV Entry No." := LivingExpenseLine."Application Entry No.";
                        CLE.Modify();
                        ApplyingAmount := ApplyingAmount - Abs(CLE."Remaining Amount");
                    end
                    else begin
                        CLE."Applies-to ID" := UserId;
                        CLE."Amount to Apply" := ApplyingAmount;
                        CLE."Applying Entry" := true;
                        CLE."Living Exps. Document No." := LivingExpenseLine."Document No.";
                        CLE."Living Exps. Entry No." := LivingExpenseLine."Entry No.";
                        CLE."Living Exps. INV Entry No." := LivingExpenseLine."Application Entry No.";
                        CLE.Modify();
                        ApplyingAmount := 0;
                    end;
                until (CLE.Next() = 0) or (ApplyingAmount = 0);

            NewApplicationDate := 0D;
            NewDocumentNo := '';
            CustEntryApplyPostedEntries.Apply(CLE_FST, NewDocumentNo, NewApplicationDate);
        end;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", DocumentNo);
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Application);
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Application Entries");
        if LivingExpenseLine.FindSet() then
            repeat
                RCPTLivingExpenseLine.Reset();
                RCPTLivingExpenseLine.SetRange("Document No.", DocumentNo);
                RCPTLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                RCPTLivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Posted Entries");
                RCPTLivingExpenseLine.SetRange("Entry Document No.", LivingExpenseLine."Applied Document No.");
                if RCPTLivingExpenseLine.FindFirst() then;

                NewApplicationDate := 0D;
                NewDocumentNo := '';
                CLE_FST.Reset();
                CLE_FST.SetRange("Document No.", LivingExpenseLine."Entry Document No.");
                CLE_FST.SetRange("Customer No.", LivingExpenseLine."Student ID");
                if CLE_FST.FindFirst() then begin
                    CLE_FST."Applies-to ID" := UserId;
                    CLE_FST."Amount to Apply" := LivingExpenseLine.Amount;
                    CLE_FST."Applying Entry" := true;
                    CLE_FST."Living Exps. Document No." := LivingExpenseLine."Document No.";
                    CLE_FST."Living Exps. Entry No." := LivingExpenseLine."Entry No.";
                    CLE_FST."Living Exps. INV Entry No." := LivingExpenseLine."Application Entry No.";
                    CLE_FST.Modify();
                end;
                CLE.Reset();
                CLE.SetRange("Document No.", LivingExpenseLine."Applied Document No.");
                CLE.SetRange("Customer No.", LivingExpenseLine."Student ID");
                if CLE.FindFirst() then begin
                    CLE.CalcFields(Amount, "Remaining Amount");
                    CLE."Applies-to ID" := UserId;
                    CLE."Amount to Apply" := CLE."Remaining Amount";
                    CLE."Living Exps. Document No." := LivingExpenseLine."Document No.";
                    CLE."Living Exps. Entry No." := LivingExpenseLine."Entry No.";
                    CLE."Living Exps. INV Entry No." := LivingExpenseLine."Application Entry No.";
                    CLE."Living Exps. RCPT Entry No." := RCPTLivingExpenseLine."Entry No.";
                    CLE.Modify();
                    NewApplicationDate := 0D;
                    NewDocumentNo := '';
                    CustEntryApplyPostedEntries.Apply(CLE, NewDocumentNo, NewApplicationDate);
                end;
            until LivingExpenseLine.Next() = 0;

        UpdateRemainingBalances(StudentMaster, "No.");
    end;

    procedure InitialiseSeatDepositRefundPostingEntry(StudentMaster: Record "Student Master-CS"; BulkCall: Boolean; LNo: Code[20])
    var
        FeeSetup: Record "Fee Setup-CS";
        LivingExpenseLine: Record "Living Expense Line";
        LivingExpenseLine_FST: Record "Living Expense Line";
        //GJB: Record "Gen. Journal Batch";
        GJL: Record "Gen. Journal Line";
        EntryAmount: Decimal;
        LivingExpsEntryType: Option " ","Seat Deposit Refund","Rent Transfer Refund","Rent Transfer Payment","T4 Stipend Payment","Refund of Student Payment";
        DocumentNo: Code[20];
        AppliesToDocumentNo: Code[20];
    begin
        FeeSetup.Reset();
        FeeSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        IF FeeSetup.FindFirst() then begin
            FeeSetup.TESTFIELD("Living Expense Template");
            FeeSetup.TESTFIELD("Living Expense Batch");
            FeeSetup.TESTFIELD("Regular Refund Bank No.");
        end;

        if BulkCall = false then begin
            LivingExpenseLine.Reset();
            LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine.SetRange("Document No.", LNo);
            LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"Seat Deposit");
            LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
            LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
            if Not LivingExpenseLine.FindFirst() then
                Error('There is nothing pending to post for the Type Seat Deposit.');
        end;

        GJL.Reset();
        GJL.SetRange("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.SetRange("Journal Batch Name", FeeSetup."Living Expense Batch");
        if GJL.FindSet() then
            repeat
                GJL.Delete(true);
            until GJL.Next() = 0;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"Seat Deposit");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        if LivingExpenseLine.FindFirst() then begin
            DocumentNo := '';
            DocumentNo := GetNextNo(FeeSetup);
            AppliesToDocumentNo := '';

            EntryAmount := Abs(LivingExpenseLine."Posting Amount");

            LivingExpenseLine_FST.Reset();
            LivingExpenseLine_FST.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine_FST.SetRange("Document Type", LivingExpenseLine_FST."Document Type"::Payment);
            LivingExpenseLine_FST.SetRange("Deposit Type", LivingExpenseLine_FST."Deposit Type"::"Seat Deposit");
            LivingExpenseLine_FST.SetFilter("Provisional Remaining Amount", '<>%1', 0);
            IF LivingExpenseLine_FST.FindFirst() then
                AppliesToDocumentNo := LivingExpenseLine_FST."Entry Document No.";
            CreateRefundEntry(LivingExpenseLine, EntryAmount, FeeSetup, DocumentNo, FeeSetup."Regular Refund Bank No.", AppliesToDocumentNo, true, LivingExpsEntryType::"Seat Deposit Refund");

            CreateRefundEntry(LivingExpenseLine, -1 * EntryAmount, FeeSetup, DocumentNo, FeeSetup."Regular Refund Bank No.", AppliesToDocumentNo, false, LivingExpsEntryType::"Seat Deposit Refund");
        end;

        PostParkedEntries(FeeSetup, StudentMaster, "No.", DocumentNo);

        UpdateRemainingBalances(StudentMaster, LNo);
        InsertLivingExpsDetails(StudentMaster, LNo, true);

        // GJB.RESET();
        // GJB.SETRANGE("Journal Template Name", FeeSetup."Living Expense Template");
        // GJB.SETRANGE(Name, FeeSetup."Living Expense Batch");
        // IF GJB.FindFirst() then
        //     GenJnlManagement.TemplateSelectionFromBatch(GJB);

    end;


    procedure InitialiseGVTransferRefundPostingEntry(StudentMaster: Record "Student Master-CS"; BulkCall: Boolean; LNo: Code[20])
    var
        FeeSetup: Record "Fee Setup-CS";
        LivingExpenseLine: Record "Living Expense Line";
        LivingExpenseLine_FST: Record "Living Expense Line";
        GJL: Record "Gen. Journal Line";
        // GJB: Record "Gen. Journal Batch";
        // GenJnlManagement: Codeunit GenJnlManagement;
        EntryAmount: Decimal;
        LivingExpsEntryType: Option " ","Seat Deposit Refund","Rent Transfer Refund","Rent Transfer Payment","T4 Stipend Payment","Refund of Student Payment";
        DocumentNo: Code[20];
        AppliesToDocumentNo: Code[20];
        HousingTransferPosted: Boolean;
    begin
        FeeSetup.Reset();
        FeeSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        IF FeeSetup.FindFirst() then begin
            FeeSetup.TESTFIELD("Living Expense Template");
            FeeSetup.TESTFIELD("Living Expense Batch");
            FeeSetup.TESTFIELD("Regular Refund Bank No.");
            FeeSetup.TESTFIELD("GV Transfer Payment Bank No.");
        end;

        if BulkCall = false then begin
            LivingExpenseLine.Reset();
            LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine.SetRange("Document No.", LNo);
            LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"GV Transfer");
            LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
            LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
            if Not LivingExpenseLine.FindFirst() then
                Error('There is nothing pending to post for the Type GV Transfer.');
        end;

        HousingTransferPosted := false;

        GJL.Reset();
        GJL.SetRange("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.SetRange("Journal Batch Name", FeeSetup."Living Expense Batch");
        if GJL.FindSet() then
            repeat
                GJL.Delete(true);
            until GJL.Next() = 0;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"GV Transfer");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        if LivingExpenseLine.FindFirst() then begin
            AppliesToDocumentNo := '';

            EntryAmount := Abs(LivingExpenseLine."Posting Amount");
            if EntryAmount <> 0 then begin
                DocumentNo := '';
                DocumentNo := GetNextNo(FeeSetup);
                CreateRefundEntry(LivingExpenseLine, EntryAmount, FeeSetup, DocumentNo, FeeSetup."Regular Refund Bank No.", AppliesToDocumentNo, true, LivingExpsEntryType::"Rent Transfer Refund");
                CreateRefundEntry(LivingExpenseLine, -1 * EntryAmount, FeeSetup, DocumentNo, FeeSetup."Regular Refund Bank No.", AppliesToDocumentNo, false, LivingExpsEntryType::"Rent Transfer Refund");
                PostParkedEntries(FeeSetup, StudentMaster, "No.", DocumentNo);
            end;
        end;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"GV Transfer");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Payment);
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        if LivingExpenseLine.FindFirst() then begin
            LivingExpenseLine_FST.Reset();
            LivingExpenseLine_FST.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine_FST.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"GV Transfer");
            LivingExpenseLine_FST.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
            LivingExpenseLine_FST.SetRange(Status, LivingExpenseLine.Status::Approved);
            if LivingExpenseLine_FST.FindFirst() then begin
                AppliesToDocumentNo := LivingExpenseLine_FST."Entry Document No.";
                EntryAmount := Abs(LivingExpenseLine_FST."Posted Amount");
            end;

            if EntryAmount <> 0 then begin
                DocumentNo := '';
                DocumentNo := GetNextNo(FeeSetup);
                CreateRefundEntry(LivingExpenseLine, EntryAmount, FeeSetup, DocumentNo, FeeSetup."GV Transfer Payment Bank No.", AppliesToDocumentNo, false, LivingExpsEntryType::"Rent Transfer Payment");
                CreateRefundEntry(LivingExpenseLine, -1 * EntryAmount, FeeSetup, DocumentNo, FeeSetup."GV Transfer Payment Bank No.", AppliesToDocumentNo, true, LivingExpsEntryType::"Rent Transfer Payment");
                PostParkedEntries(FeeSetup, StudentMaster, "No.", DocumentNo);
                HousingTransferPosted := true;
            end;
        end;


        if HousingTransferPosted = true then
            PostHousingApplication(StudentMaster, LNo, false);

        UpdateRemainingBalances(StudentMaster, LNo);
        InsertLivingExpsDetails(StudentMaster, LNo, true);
        // GJB.RESET();
        // GJB.SETRANGE("Journal Template Name", FeeSetup."Living Expense Template");
        // GJB.SETRANGE(Name, FeeSetup."Living Expense Batch");
        // IF GJB.FindFirst() then
        //     GenJnlManagement.TemplateSelectionFromBatch(GJB);
    end;

    procedure PostHousingApplication(StudentMaster: Record "Student Master-CS"; DocumentNo: Code[20]; BulkCall: Boolean)
    var
        CLE: Record "Cust. Ledger Entry";
        CLE_FST: Record "Cust. Ledger Entry";
        LivingExpenseLine: Record "Living Expense Line";
        RCPTLivingExpenseLine: Record "Living Expense Line";
        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
        NewApplicationDate: Date;
        NewDocumentNo: Code[20];
    begin
        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", DocumentNo);
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Application);
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Housing Application");
        if LivingExpenseLine.FindSet() then
            repeat
                RCPTLivingExpenseLine.Reset();
                RCPTLivingExpenseLine.SetRange("Document No.", DocumentNo);
                RCPTLivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
                RCPTLivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Posted Entries");
                RCPTLivingExpenseLine.SetRange("Entry Document No.", LivingExpenseLine."Applied Document No.");
                if RCPTLivingExpenseLine.FindFirst() then;

                NewApplicationDate := 0D;
                NewDocumentNo := '';
                CLE_FST.Reset();
                CLE_FST.SetRange("Document No.", LivingExpenseLine."Entry Document No.");
                CLE_FST.SetRange("Customer No.", LivingExpenseLine."Student ID");
                if CLE_FST.FindFirst() then begin
                    CLE_FST."Applies-to ID" := UserId;
                    CLE_FST."Amount to Apply" := LivingExpenseLine.Amount;
                    CLE_FST."Applying Entry" := true;
                    CLE_FST."Living Exps. Document No." := LivingExpenseLine."Document No.";
                    CLE_FST."Living Exps. Entry No." := LivingExpenseLine."Entry No.";
                    CLE_FST."Living Exps. INV Entry No." := LivingExpenseLine."Application Entry No.";
                    CLE_FST.Modify();
                end;
                CLE.Reset();
                CLE.SetRange("Document No.", LivingExpenseLine."Applied Document No.");
                CLE.SetRange("Customer No.", LivingExpenseLine."Student ID");
                if CLE.FindFirst() then begin
                    CLE.CalcFields(Amount, "Remaining Amount");
                    CLE."Applies-to ID" := UserId;
                    CLE."Amount to Apply" := CLE."Remaining Amount";
                    CLE."Living Exps. Document No." := LivingExpenseLine."Document No.";
                    CLE."Living Exps. Entry No." := LivingExpenseLine."Entry No.";
                    CLE."Living Exps. INV Entry No." := LivingExpenseLine."Application Entry No.";
                    CLE."Living Exps. RCPT Entry No." := RCPTLivingExpenseLine."Entry No.";
                    CLE.Modify();
                    NewApplicationDate := 0D;
                    NewDocumentNo := '';
                    CustEntryApplyPostedEntries.Apply(CLE, NewDocumentNo, NewApplicationDate);
                end;
            until LivingExpenseLine.Next() = 0;
    end;

    procedure InitialiseT4RefundPostingEntry(StudentMaster: Record "Student Master-CS"; BulkCall: Boolean; LNo: Code[20])
    var
        FeeSetup: Record "Fee Setup-CS";
        LivingExpenseLine: Record "Living Expense Line";
        LivingExpenseLine_FST: Record "Living Expense Line";
        //GJB: Record "Gen. Journal Batch";
        GJL: Record "Gen. Journal Line";
        AmountToApply: Decimal;
        EntryAmount: Decimal;
        LivingExpsEntryType: Option " ","Seat Deposit Refund","Rent Transfer Refund","Rent Transfer Payment","T4 Stipend Payment","Refund of Student Payment";
        DocumentNo: Code[20];
        AppliesToDocumentNo: Code[20];
    begin
        FeeSetup.Reset();
        FeeSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        IF FeeSetup.FindFirst() then begin
            FeeSetup.TESTFIELD("Living Expense Template");
            FeeSetup.TESTFIELD("Living Expense Batch");
            FeeSetup.TESTFIELD("Regular Refund Bank No.");
        end;

        if BulkCall = false then begin
            LivingExpenseLine.Reset();
            LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine.SetRange("Document No.", LNo);
            LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"T4 Stipend Payment");
            LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
            LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
            if Not LivingExpenseLine.FindFirst() then
                Error('There is nothing pending to post for the Type T4 Stipend Refund.');
        end;

        GJL.Reset();
        GJL.SetRange("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.SetRange("Journal Batch Name", FeeSetup."Living Expense Batch");
        if GJL.FindSet() then
            repeat
                GJL.Delete(true);
            until GJL.Next() = 0;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"T4 Stipend Payment");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        if LivingExpenseLine.FindFirst() then begin
            DocumentNo := '';
            DocumentNo := GetNextNo(FeeSetup);
            AppliesToDocumentNo := '';
            AmountToApply := Abs(LivingExpenseLine."Posting Amount");
            EntryAmount := 0;

            LivingExpenseLine_FST.Reset();
            LivingExpenseLine_FST.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine_FST.SetRange("Document No.", LNo);
            LivingExpenseLine_FST.SetRange("Document Type", LivingExpenseLine_FST."Document Type"::Payment);
            LivingExpenseLine_FST.SetRange("Receipt Type", LivingExpenseLine_FST."Receipt Type"::"Financial Aid");
            LivingExpenseLine_FST.SetFilter("Provisional Remaining Amount", '<>%1', 0);
            IF LivingExpenseLine_FST.FindSet() then
                repeat
                    if AmountToApply < Abs(LivingExpenseLine_FST."Provisional Remaining Amount") then begin
                        EntryAmount := Abs(AmountToApply);
                        AmountToApply := 0;
                        AppliesToDocumentNo := LivingExpenseLine_FST."Entry Document No.";
                    end
                    else begin
                        EntryAmount := Abs(LivingExpenseLine_FST."Provisional Remaining Amount");
                        AmountToApply := AmountToApply - EntryAmount;
                        AppliesToDocumentNo := LivingExpenseLine_FST."Entry Document No.";
                    end;
                    CreateRefundEntry(LivingExpenseLine, EntryAmount, FeeSetup, DocumentNo, FeeSetup."Regular Refund Bank No.", AppliesToDocumentNo, true, LivingExpsEntryType::"T4 Stipend Payment");
                until (LivingExpenseLine_FST.Next() = 0) or (AmountToApply = 0);

            EntryAmount := Abs(LivingExpenseLine."Posting Amount");
            CreateRefundEntry(LivingExpenseLine, -1 * EntryAmount, FeeSetup, DocumentNo, FeeSetup."Regular Refund Bank No.", AppliesToDocumentNo, false, LivingExpsEntryType::"T4 Stipend Payment");
            PostParkedEntries(FeeSetup, StudentMaster, "No.", DocumentNo);

            UpdateRemainingBalances(StudentMaster, LNo);
            InsertLivingExpsDetails(StudentMaster, LNo, true);
        end;

        // GJB.RESET();
        // GJB.SETRANGE("Journal Template Name", FeeSetup."Living Expense Template");
        // GJB.SETRANGE(Name, FeeSetup."Living Expense Batch");
        // IF GJB.FindFirst() then
        //     GenJnlManagement.TemplateSelectionFromBatch(GJB);
    end;


    procedure InitialiseStudentPaymentRefundPostingEntry(StudentMaster: Record "Student Master-CS"; BulkCall: Boolean; LNo: Code[20])
    var
        FeeSetup: Record "Fee Setup-CS";
        LivingExpenseLine: Record "Living Expense Line";
        LivingExpenseLine_FST: Record "Living Expense Line";
        //GJB: Record "Gen. Journal Batch";
        GJL: Record "Gen. Journal Line";
        AmountToApply: Decimal;
        EntryAmount: Decimal;
        LivingExpsEntryType: Option " ","Seat Deposit Refund","Rent Transfer Refund","Rent Transfer Payment","T4 Stipend Payment","Refund of Student Payment";
        DocumentNo: Code[20];
        AppliesToDocumentNo: Code[20];
    begin
        FeeSetup.Reset();
        FeeSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        IF FeeSetup.FindFirst() then begin
            FeeSetup.TESTFIELD("Living Expense Template");
            FeeSetup.TESTFIELD("Living Expense Batch");
            FeeSetup.TESTFIELD("Regular Refund Bank No.");
        end;

        if BulkCall = false then begin
            LivingExpenseLine.Reset();
            LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine.SetRange("Document No.", LNo);
            LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"Student Payment");
            LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
            LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
            if Not LivingExpenseLine.FindFirst() then
                Error('There is nothing pending to post for the Type Refund of Student Payment.');
        end;

        GJL.Reset();
        GJL.SetRange("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.SetRange("Journal Batch Name", FeeSetup."Living Expense Batch");
        if GJL.FindSet() then
            repeat
                GJL.Delete(true);
            until GJL.Next() = 0;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"Student Payment");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        if LivingExpenseLine.FindFirst() then begin
            DocumentNo := '';
            DocumentNo := GetNextNo(FeeSetup);
            AppliesToDocumentNo := '';
            AmountToApply := Abs(LivingExpenseLine."Posting Amount");
            EntryAmount := 0;

            LivingExpenseLine_FST.Reset();
            LivingExpenseLine_FST.SetRange("Student ID", StudentMaster."No.");
            LivingExpenseLine_FST.SetRange("Document No.", LNo);
            LivingExpenseLine_FST.SetRange("Document Type", LivingExpenseLine_FST."Document Type"::Payment);
            LivingExpenseLine_FST.SetRange("Entry Type", LivingExpenseLine_FST."Entry Type"::"Student Payment");
            LivingExpenseLine_FST.SetFilter("Provisional Remaining Amount", '<>%1', 0);
            IF LivingExpenseLine_FST.FindSet() then
                repeat
                    if AmountToApply < Abs(LivingExpenseLine_FST."Remaining Amount") then begin
                        EntryAmount := Abs(AmountToApply);
                        AmountToApply := 0;
                        AppliesToDocumentNo := LivingExpenseLine_FST."Entry Document No.";
                    end
                    else begin
                        EntryAmount := Abs(LivingExpenseLine_FST."Remaining Amount");
                        AmountToApply := AmountToApply - EntryAmount;
                        AppliesToDocumentNo := LivingExpenseLine_FST."Entry Document No.";
                    end;
                    CreateRefundEntry(LivingExpenseLine, EntryAmount, FeeSetup, DocumentNo, FeeSetup."Regular Refund Bank No.", AppliesToDocumentNo, true, LivingExpsEntryType::"Refund of Student Payment");
                until (LivingExpenseLine_FST.Next() = 0) or (AmountToApply = 0);

            EntryAmount := Abs(LivingExpenseLine."Posting Amount");
            CreateRefundEntry(LivingExpenseLine, -1 * EntryAmount, FeeSetup, DocumentNo, FeeSetup."Regular Refund Bank No.", AppliesToDocumentNo, false, LivingExpsEntryType::"Refund of Student Payment");
            PostParkedEntries(FeeSetup, StudentMaster, "No.", DocumentNo);

            UpdateRemainingBalances(StudentMaster, LNo);
            InsertLivingExpsDetails(StudentMaster, LNo, true);
        end;

        // GJB.RESET();
        // GJB.SETRANGE("Journal Template Name", FeeSetup."Living Expense Template");
        // GJB.SETRANGE(Name, FeeSetup."Living Expense Batch");
        // IF GJB.FindFirst() then
        //     GenJnlManagement.TemplateSelectionFromBatch(GJB);
    end;


    procedure CreateRefundEntry(LED: Record "Living Expense Line"; EntryAmount: Decimal; FeeSetup: Record "Fee Setup-CS"; DocumentNo: Code[20]; BankAccountNo: Code[20]; AppliesToDocNo: Code[20]; CustomerEntry: Boolean;
    LivingExpsEntryType: Option " ","Seat Deposit Refund","Rent Transfer Refund","Rent Transfer Payment","T4 Stipend Payment","Refund of Student Payment");
    var
        GJL: Record "Gen. Journal Line";
        StudentMaster: Record "Student Master-CS";
        LineNo: Integer;
    begin
        GJL.Reset();
        GJL.SETRANGE("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.SETRANGE("Journal Batch Name", FeeSetup."Living Expense Batch");
        IF GJL.FINDLAST() THEN
            LineNo := GJL."Line No.";

        LineNo += 10000;

        StudentMaster.Reset();
        if StudentMaster.Get(LED."Student ID") then;

        GJL.INIT();
        GJL.VALIDATE("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.VALIDATE("Journal Batch Name", FeeSetup."Living Expense Batch");
        GJL."Line No." := LineNo;
        GJL.Insert(true);

        if LED."Document Type" = LED."Document Type"::Refund then
            GJL.VALIDATE("Document Type", GJL."Document Type"::Refund);
        if LED."Document Type" = LED."Document Type"::Payment then
            GJL.VALIDATE("Document Type", GJL."Document Type"::Payment);

        GJL."Document No." := DocumentNo;

        if CustomerEntry then begin
            GJL.VALIDATE("Account Type", GJL."Account Type"::Customer);
            GJL.VALIDATE("Account No.", LED."Student ID");
        end
        else begin
            GJL.VALIDATE("Account Type", GJL."Account Type"::"Bank Account");
            if LED."Refund Type" = LED."Refund Type"::"Seat Deposit" then
                GJL.VALIDATE("Account No.", FeeSetup."Regular Refund Bank No.");
            if (LED."Refund Type" = LED."Refund Type"::"GV Transfer") and (LED."Document Type" = LED."Document Type"::Refund) then
                GJL.VALIDATE("Account No.", FeeSetup."Regular Refund Bank No.");
            if (LED."Refund Type" = LED."Refund Type"::"GV Transfer") and (LED."Document Type" = LED."Document Type"::Payment) then
                GJL.VALIDATE("Account No.", FeeSetup."GV Transfer Payment Bank No.");
            if LED."Refund Type" = LED."Refund Type"::"T4 Stipend Payment" then
                GJL.VALIDATE("Account No.", FeeSetup."Regular Refund Bank No.");
            if LED."Refund Type" = LED."Refund Type"::"Student Payment" then
                GJL.VALIDATE("Account No.", FeeSetup."Regular Refund Bank No.");
        end;

        GJL.Description := LED.Description;
        GJL.Validate("Posting Date", WorkDate());
        GJL.VALIDATE("Amount", EntryAmount);
        GJL.VALIDATE("Shortcut Dimension 1 Code", StudentMaster."Global Dimension 1 Code");

        GJL."Enrollment No." := StudentMaster."Enrollment No.";
        GJL.Course := StudentMaster."Course Code";
        GJL.Semester := LED.Semester;
        GJL."Academic Year" := LED."Academic Year";
        GJL.Year := StudentMaster.Year;
        //GJL.Term := StudentMaster.Term;

        if LED."Global Dimension 2 Code" <> '' then
            GJL.Validate("Shortcut Dimension 2 Code", LED."Global Dimension 2 Code");
        GJL."Financial Aid Approved" := true;
        IF (AppliesToDocNo <> '') and (GJL."Account Type" = GJL."Account Type"::Customer) then begin
            if GJL."Document Type" = GJL."Document Type"::Refund then
                GJL."Applies-to Doc. Type" := GJL."Applies-to Doc. Type"::Payment;
            if GJL."Document Type" = GJL."Document Type"::Payment then
                GJL."Applies-to Doc. Type" := GJL."Applies-to Doc. Type"::Refund;
            GJL."Applies-to Doc. No." := AppliesToDocNo;
        end;

        GJL."Living Exps. Entry Type" := LivingExpsEntryType;
        GJL."Living Exps. Document No." := LED."Document No.";
        GJL."Living Exps. Entry No." := LED."Entry No.";

        IF GJL.Modify(TRUE) then;
    end;

    procedure GetNextNo(FeeSetup: Record "Fee Setup-CS") DocumentNo: Code[20]
    var
        GJL: Record "Gen. Journal Line";
        GJB: Record "Gen. Journal Batch";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        GJL.Reset();
        GJL.SetRange("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.SetRange("Journal Batch Name", FeeSetup."Living Expense Batch");
        if GJL.FindLast() then
            DocumentNo := IncStr(GJL."Document No.")
        else begin
            GJB.Reset();
            if GJB.Get(FeeSetup."Living Expense Template", FeeSetup."Living Expense Batch") then
                GJB.TestField("No. Series")
            else
                Error('Living Expense Batch %1 not found.', FeeSetup."Living Expense Batch");

            DocumentNo := NoSeriesManagement.GetNextNo(GJB."No. Series", WorkDate(), false);
        end;
    end;

    procedure PostParkedEntries(FeeSetup: Record "Fee Setup-CS"; StudentMaster: Record "Student Master-CS"; LNo: Code[20]; DocumentNo: Code[20])
    var
        GJL: Record "Gen. Journal Line";
    begin
        GJL.Reset();
        GJL.SETRANGE("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.SETRANGE("Journal Batch Name", FeeSetup."Living Expense Batch");
        GJL.SETRANGE("Document No.", DocumentNo);
        IF GJL.Findset() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GJL);

        GJL.Reset();
        GJL.SETRANGE("Journal Template Name", FeeSetup."Living Expense Template");
        GJL.SETRANGE("Journal Batch Name", FeeSetup."Living Expense Batch");
        GJL.SETRANGE("Document No.", DocumentNo);
        IF GJL.Findset() THEN
            GJL.DeleteAll();

        UpdateStatus(LNo, StudentMaster);
    end;

    procedure UpdateStatus(LNo: Code[20]; StudentMaster: Record "Student Master-CS")
    var
        LivingExpenseHeader: Record "Living Expense Header";
        LivingExpenseLine: Record "Living Expense Line";
        AllPosted: Boolean;
    begin
        AllPosted := true;
        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", StudentMaster."No.");
        LivingExpenseLine.SetRange("Document No.", LNo);
        LivingExpenseLine.SetFilter("View Part", '<>%1', LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetFilter(Status, '%1', LivingExpenseLine.Status::"Pending for Approval");
        if LivingExpenseLine.FindFirst() then
            AllPosted := false;

        if AllPosted = true then begin
            LivingExpenseHeader.Reset();
            if LivingExpenseHeader.Get(LNo) then begin
                LivingExpenseHeader.Status := LivingExpenseHeader.Status::Posted;
                LivingExpenseHeader.Modify();
            end;
        end
        else begin
            LivingExpenseHeader.Reset();
            if LivingExpenseHeader.Get(LNo) then begin
                LivingExpenseHeader.Status := LivingExpenseHeader.Status::Open;
                LivingExpenseHeader.Modify();
            end;
        end
    end;

    procedure CheckEntryExistance(DocumentNo: Code[20]; RefundType: Option " ","Seat Deposit","GV Transfer","T4 Stipend Payment","Refund of StudentPayment") EntryExist: Boolean
    var
        LivingExpenseLine: Record "Living Expense Line";
    begin
        EntryExist := false;
        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", DocumentNo);
        LivingExpenseLine.SetRange("Refund Type", RefundType);
        if LivingExpenseLine.FindFirst() then
            EntryExist := true;

        exit(EntryExist);
    end;
}
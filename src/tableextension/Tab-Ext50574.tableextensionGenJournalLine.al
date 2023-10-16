tableextension 50574 "tableextensionGenJournalLine" extends "Gen. Journal Line"
{
    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019    Bal. Account No. - OnValidate   Code added for Assign Value in Fields.
    // 2         CSPL-00136    02-05-2019    Account No. - OnValidate         Code added for Assign Value in Fields.
    // 3         CSPL-00136    02-05-2019    UnRelazised Doc No. - OnLookup   Code added for Assign Value in UnRelazised Doc No. Field.
    // 4         CSPL-00136    02-05-2019    ApproveCS Function           Code added for Assign Value in UnRelazised Doc No. Field.
    // 5         CSPL-00136    02-05-2019    ReopenVoucherCS Function         Code added for Assign Value in UnRelazised Doc No. Field.
    // 6         CSPL-00136    02-05-2019    AddNewLineCS Function           Code added for Assign Value in UnRelazised Doc No. Field.
    fields
    {
        modify("Account Type")
        {
            trigger OnAfterValidate()
            begin
                //Code added for Assign Value in Enrollment No. Field::CSPL-00136::02-05-2019: Start
                "Enrollment No." := '';
                //Code added for Assign Value in Enrollment No. Field::CSPL-00136::02-05-2019: End
            end;
        }

        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                GenjournalLine_lRec: Record "Gen. Journal Line";
                FeeDesc_lTxt: Text[100];
                DepartmentCode_lCod: Code[20];
            begin
                //Code added for Assign Blank Value in Enrollment No. Field::CSPL-00136::02-05-2019: Start
                "Pre Document No." := "Document No.";
                IF ("Account Type" = "Account Type"::"G/L Account") OR
                ("Account Type" = "Account Type"::"Bank Account") OR
                ("Account Type" = "Account Type"::"Fixed Asset") OR
                ("Account Type" = "Account Type"::Vendor) OR
                ("Account Type" = "Account Type"::"IC Partner") Then
                    "Enrollment No." := '';
                //Code added for Assign Blank Value in Enrollment No. Field::CSPL-00136::02-05-2019: End

                //Code added for Assign Value in Fields::CSPL-00136::02-05-2019: Start
                // GetAdditionalInfo();
                IF "Account Type" = "Account Type"::"Bank Account" Then begin
                    BankAccount.Reset();
                    BankAccount.SetRange("No.", "Account No.");
                    IF BankAccount.FindFirst() then begin
                        "SAP G/L Account" := BankAccount."SAP G/L Account";
                        "SAP Bus. Area" := BankAccount."SAP Bus. Area";
                        "SAP Profit Centre" := BankAccount."SAP Profit Centre";
                        "SAP Company Code" := BankAccount."SAP Company Code";
                    end Else begin
                        "SAP G/L Account" := '';
                        "SAP Bus. Area" := '';
                        "SAP Profit Centre" := '';
                        "SAP Company Code" := '';
                    end;
                end;
                //CS:Navdeep -Start
                FeeDesc_lTxt := '';
                DepartmentCode_lCod := '';
                IF ("Account Type" = "Account Type"::Customer) AND ("Fee Code" = '') then begin
                    GenjournalLine_lRec.Reset();
                    GenjournalLine_lRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenjournalLine_lRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    GenjournalLine_lRec.SetRange("Document No.", Rec."Document No.");
                    GenjournalLine_lRec.SetRange("Account Type", GenjournalLine_lRec."Account Type"::"G/L Account");
                    IF GenjournalLine_lRec.FindLast() then begin
                        FeeDesc_lTxt := GenjournalLine_lRec."Fee Description";
                        DepartmentCode_lCod := GenjournalLine_lRec."Shortcut Dimension 2 Code";
                    end;

                    "Fee Description" := FeeDesc_lTxt;
                    "Shortcut Dimension 2 Code" := DepartmentCode_lCod;
                end;

                IF ("Account Type" = "Account Type"::"G/L Account") and ("Fee Code" <> '') then begin
                    GenjournalLine_lRec.Reset();
                    GenjournalLine_lRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenjournalLine_lRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    GenjournalLine_lRec.SetRange("Document No.", Rec."Document No.");
                    GenjournalLine_lRec.SetRange("Account Type", GenjournalLine_lRec."Account Type"::Customer);
                    IF GenjournalLine_lRec.FindSet() then begin
                        repeat
                            GenjournalLine_lRec."Fee Description" := Rec."Fee Description";
                            GenjournalLine_lRec."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            GenjournalLine_lRec.Modify();
                        until GenjournalLine_lRec.Next() = 0;
                    end;
                end;
                //CS:Navdeep -End

                //CSPL-00307
                IF "Journal Batch Name" = 'BANKPYTM' then
                    Description := 'Cash Refund -';
                //CSPL-00307
            END;
        }
        modify("Bal. Account No.")
        {
            trigger OnAfterValidate()
            var
                FeeComponent: Record "Fee Component Master-CS";
                SAPFeeCode: Record "SAP Fee Code";

            begin
                //Code added for Assign Value in Fields::CSPL-00136::02-05-2019: Start
                // GetAdditionalInfo();
                IF ("Bal. Account Type" = "Bal. Account Type"::Customer) and ("Fee Code" <> '') Then begin
                    FeeComponent.Reset();
                    FeeComponent.SetRange("Code", "Fee Code");
                    IF FeeComponent.FindFirst() then begin
                        "Fee Description" := FeeComponent.Description;
                        //Validate("Shortcut Dimension 1 Code", FeeComponent."Global Dimension 1 Code");
                        Validate("Shortcut Dimension 2 Code", FeeComponent."Global Dimension 2 Code");

                        SAPFeeCode.Reset();
                        SAPFeeCode.SetRange("SAP Code", FeeComponent."SAP Code");
                        IF SAPFeeCode.FindFirst() then begin
                            "SAP Code" := SAPFeeCode."SAP Code";
                            "SAP G/L Account" := SAPFeeCode."SAP G/L Account";
                            "SAP Assignment Code" := SAPFeeCode."SAP Assignment Code";
                            "SAP Description" := SAPFeeCode."SAP Description";
                            "SAP Cost Centre" := SAPFeeCode."SAP Cost Centre";
                            "SAP Profit Centre" := SAPFeeCode."SAP Profit Centre";
                            "SAP Company Code" := SAPFeeCode."SAP Company Code";
                            "SAP Bus. Area" := SAPFeeCode."SAP Bus. Area";
                            "Fee Group" := SAPFeeCode."Fee Group";
                        end;
                    end Else begin
                        "SAP Code" := '';
                        "SAP G/L Account" := '';
                        "SAP Assignment Code" := '';
                        "SAP Description" := '';
                        "SAP Cost Centre" := '';
                        "SAP Profit Centre" := '';
                        "SAP Company Code" := '';
                        "SAP Bus. Area" := '';
                        "Fee Group" := "Fee Group"::" ";
                        "Account No." := '';
                        "Shortcut Dimension 1 Code" := '';
                        "Shortcut Dimension 2 Code" := '';
                    end;
                end;

                IF "Account Type" = "Account Type"::"Bank Account" Then begin
                    BankAccount.Reset();
                    BankAccount.SetRange("No.", "Account No.");
                    IF BankAccount.FindFirst() then begin
                        "SAP G/L Account" := BankAccount."SAP G/L Account";
                        "SAP Bus. Area" := BankAccount."SAP Bus. Area";
                        "SAP Profit Centre" := BankAccount."SAP Profit Centre";
                        "SAP Company Code" := BankAccount."SAP Company Code";
                    end Else begin
                        "SAP G/L Account" := '';
                        "SAP Bus. Area" := '';
                        "SAP Profit Centre" := '';
                        "SAP Company Code" := '';
                    end;
                end;


            END;
        }

        modify("Currency Code")
        {
            trigger OnAfterValidate()
            var
                CurrExchRate: Record "Currency Exchange Rate";
                PostingDate: Date;
            begin
                //Code added for Assign Value in Currency Exch. Rate Field::CSPL-00136::02-05-2019: Start
                PostingDate := "Posting Date";
                CurrExchRate.GetLastestExchangeRate("Currency Code", PostingDate, "Currency Exch. Rate");
                //Code added for Assign Value in Currency Exch. Rate Field::CSPL-00136::02-05-2019: End

                VALIDATE("Currency Exch. Rate");
                "Currency Code Receipt" := "Currency Code";
            end;
        }

        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00136::02-05-2019: Start
                "Amount Receipt" := Amount;
                // if ("Bal. Account Type" = "Bal. Account Type"::Customer) and ("Bal. Account No." <> '') then begin
                //     TestField("Enrollment No.");
                //     StudentMasterCS1.Reset();
                //     // StudentMasterCS1.SETRANGE(StudentMasterCS1."No.", "Bal. Account No.");
                //     StudentMasterCS1.SetRange("Enrollment No.", "Enrollment No.");
                //     IF StudentMasterCS1.FINDFIRST() THEN BEGIN
                //         Narration := "Enrollment No." + '-' + FORMAT(StudentMasterCS1."Name as on Certificate");
                //         "Shortcut Dimension 1 Code" := StudentMasterCS1."Global Dimension 1 Code";
                //         "Shortcut Dimension 2 Code" := StudentMasterCS1."Global Dimension 2 Code";
                //         VALIDATE("Enrollment No.", StudentMasterCS1."Enrollment No.");
                //         Semester := StudentMasterCS1.Semester;
                //         Year := StudentMasterCS1.Year;
                //         "Academic Year" := StudentMasterCS1."Academic Year";
                //         Course := StudentMasterCS1."Course Code";
                //         Category := StudentMasterCS1.Category;
                //     END;
                // end;
            end;
        }
        //Code added for Assign Value in Fields::CSPL-00136::02-05-2019: End

        modify("Amount (LCY)")
        {
            trigger OnAfterValidate()
            begin

                //Code added for Update Currency Code Field::CSPL-00136::02-05-2019: Start
                IF "Journal Batch Name" = 'FCR RCPT' THEN
                    "Currency Code" := 'USD'
                ELSE
                    "Currency Code" := "Currency Code";

                //Code added for Update Currency Code Field::CSPL-00136::02-05-2019: End
            end;
        }

        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            begin
                //Code added for Assign Value in Applies To Rev. Doc. No. Field::CSPL-00136::02-05-2019: Start
                IF "Reversal New" = TRUE THEN
                    "Applies To Rev. Doc. No." := "Applies-to Doc. No."
                ELSE
                    "Applies To Rev. Doc. No." := '';
                //Code added for Assign Value in Applies To Rev. Doc. No. Field::CSPL-00136::02-05-2019: End
            end;
        }
        modify("Bank Payment Type")
        {
            trigger OnBeforeValidate()
            var
            // myInt: Integer;
            begin
                //CSPL-00307
                IF "Payment Method Code" = 'CHK' then begin
                    IF NOT ("Bank Payment Type" IN ["Bank Payment Type"::"Computer Check", "Bank Payment Type"::"Manual Check"]) then
                        Error('You have to Select Computer Check or Manual Check only because Payment method code is CHK');
                end else
                    IF ("Bank Payment Type" IN ["Bank Payment Type"::"Computer Check", "Bank Payment Type"::"Manual Check"]) then
                        Error('You Can Not Select Computer Check or Manual Check because Payment method code is not CHK');
            end;
        }

        field(50000; Course; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Course';
            DataClassification = CustomerContent;
        }
        field(50001; Semester; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Semester Master-CS";
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(50002; "Academic Year"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(50003; "Fee Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Fee Component Master-CS";
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                FeeComponent: Record "Fee Component Master-CS";
                SAPFeeCode: Record "SAP Fee Code";
            begin
                if "Fee Code" <> '' then begin
                    FeeComponent.Reset();
                    FeeComponent.SetRange("Code", "Fee Code");
                    FeeComponent.FindFirst();
                    begin
                        "Fee Description" := FeeComponent.Description;
                        "Account Type" := "Account Type"::"G/L Account";
                        Validate("Account No.", FeeComponent."G/L Account");
                        Validate("Shortcut Dimension 1 Code", FeeComponent."Global Dimension 1 Code");
                        Validate("Shortcut Dimension 2 Code", FeeComponent."Global Dimension 2 Code");
                        Validate("1098-T From", FeeComponent."1098-T From");
                        SAPFeeCode.Reset();
                        SAPFeeCode.SetRange("SAP Code", FeeComponent."SAP Code");
                        IF SAPFeeCode.FindFirst() then begin
                            "SAP Code" := SAPFeeCode."SAP Code";
                            "SAP G/L Account" := SAPFeeCode."SAP G/L Account";
                            "SAP Assignment Code" := SAPFeeCode."SAP Assignment Code";
                            "SAP Description" := SAPFeeCode."SAP Description";
                            "SAP Cost Centre" := SAPFeeCode."SAP Cost Centre";
                            "SAP Profit Centre" := SAPFeeCode."SAP Profit Centre";
                            "SAP Company Code" := SAPFeeCode."SAP Company Code";
                            "SAP Bus. Area" := SAPFeeCode."SAP Bus. Area";
                            "Fee Group" := SAPFeeCode."Fee Group";
                        end;
                    end;
                end
                Else begin
                    "SAP Code" := '';
                    "SAP G/L Account" := '';
                    "SAP Assignment Code" := '';
                    "SAP Description" := '';
                    "SAP Cost Centre" := '';
                    "SAP Profit Centre" := '';
                    "SAP Company Code" := '';
                    "SAP Bus. Area" := '';
                    "Fee Group" := "Fee Group"::" ";
                    "Account No." := '';
                    "Shortcut Dimension 1 Code" := '';
                    "Shortcut Dimension 2 Code" := '';
                end;
            end;
        }
        field(50004; "Send for Approval"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Send for Approval';
            DataClassification = CustomerContent;
        }
        field(50005; Approved; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Approved';
            DataClassification = CustomerContent;
        }
        field(50006; "Approved On"; DateTime)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Approved On';
            DataClassification = CustomerContent;
        }
        field(50007; "Approved By"; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(50008; Status; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Open,Send for approval,Approved';
            OptionMembers = " ",Open,"Send for approval",Approved;
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(50009; "Send for Approval On"; DateTime)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Send for Approval On';
            DataClassification = CustomerContent;
        }
        field(50010; "Send for Approval By"; Code[50])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Send for Approval By';
            DataClassification = CustomerContent;
        }
        field(50011; "Created By"; Code[50])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(50013; Section; Code[10])
        {
            Caption = 'Section';
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50014; "Withdrawal No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Withdrawal No';
            DataClassification = CustomerContent;
        }
        field(50033; Month; Integer)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(50034; Year; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(50035; "TDS Applicable"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'TDS Applicable';
            DataClassification = CustomerContent;
        }
        field(50036; "TDS Non Applicable"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'TDS Non Applicable';
            DataClassification = CustomerContent;
        }
        field(50037; "Late Fee"; Decimal)
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'Late Fee';
            DataClassification = CustomerContent;
        }
        field(50038; "Bal. Account Name"; Text[100])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Bal. Account Name';
            DataClassification = CustomerContent;
        }
        field(50039; Applied; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Applied';
            DataClassification = CustomerContent;
        }
        field(50040; "Fine Entry Generated"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'Fine Entry Generated';
            DataClassification = CustomerContent;
        }
        field(50041; "G/L Reference Doc No"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'G/L Reference Doc No.';
            DataClassification = CustomerContent;
        }
        field(50042; "Applied CLE No"; Integer)
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'Applied CLE No.';
            DataClassification = CustomerContent;
        }
        field(50044; "Fine Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Fixed,Percentage,Slab-Wise';
            OptionMembers = " ","Fixed",Percentage,"Slab-Wise";
            Caption = 'Fine Type';
            DataClassification = CustomerContent;
        }
        field(50045; Class; Code[10])
        {
            Caption = 'Class';
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50046; "Instrument Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,DD,CK,RT,CA,SM,WT,Other,CS,OI';
            OptionMembers = " ",DD,CK,RT,CA,SM,WT,Other,CS,OI;
            Caption = 'Instrument Type';
            DataClassification = CustomerContent;
        }
        field(50047; "Drawn On"; Text[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Drawn On';
            DataClassification = CustomerContent;
        }
        field(50048; "Payable At"; Text[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Payable At';
            DataClassification = CustomerContent;
        }
        field(50051; "Cheque/DD No"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Cheque/DD No.';
            DataClassification = CustomerContent;
        }
        field(50052; "Instrument Date"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Intrument Date';
            DataClassification = CustomerContent;
        }
        field(50053; "Issuing Bank"; Text[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Issuing Bank';
            DataClassification = CustomerContent;
        }
        field(50054; "IFSC Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'IFSC Code';
            DataClassification = CustomerContent;
        }
        field(50055; Transaction; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Withdraw,Refund';
            OptionMembers = " ",Withdraw,Refund;
            Caption = 'Transaction';
            DataClassification = CustomerContent;
        }
        field(50056; "Late Fee %"; Decimal)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Late Fee %';
            DataClassification = CustomerContent;
        }
        field(50057; Updated; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50058; Category; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Category Master-CS";
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(50059; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            //Editable = false;
            trigger OnValidate()
            var
                FeeComponent: Record "Fee Component Master-CS";
                SAPFeeCode: Record "SAP Fee Code";
            begin
                //Code added for Assign Value in Field::CSPL-00136::02-05-2019: Start

                IF ("Enrollment No." <> '') and ((("Bal. Account Type" = "Bal. Account Type"::Customer) AND ("Bal. Account No." <> '')) or
                (("Account Type" = "Account Type"::Customer) AND ("Account No." <> ''))) Then begin
                    StudentMasterCS.Reset();
                    if ("Bal. Account Type" = "Bal. Account Type"::Customer) AND ("Bal. Account No." <> '') then
                        StudentMasterCS.SetRange("Original Student No.", "Bal. Account No.")
                    else
                        if ("Account Type" = "Account Type"::Customer) AND ("Account No." <> '') then
                            StudentMasterCS.SetRange("Original Student No.", "Account No.");
                    StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                    StudentMasterCS.FINDFIRST();
                    BEGIN
                        Narration := "Enrollment No." + '-' + FORMAT(StudentMasterCS."Name as on Certificate");
                        VALIDATE("Shortcut Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");
                        VALIDATE("Shortcut Dimension 2 Code", StudentMasterCS."Global Dimension 2 Code");
                        validate(Semester, StudentMasterCS.Semester);
                        validate(Year, StudentMasterCS.Year);
                        "Student ID" := StudentMasterCS."Original Student No.";
                        validate("Academic Year", StudentMasterCS."Academic Year");
                        "Financial Aid Approved" := StudentMasterCS."Financial Aid Approved";
                        validate(Course, StudentMasterCS."Course Code");
                        Validate(Term, StudentMasterCS.Term);
                        Validate("Admitted Year", StudentMasterCS."Admitted Year");

                    END;
                    IF ("Bal. Account Type" = "Bal. Account Type"::Customer) and ("Fee Code" <> '') Then begin
                        FeeComponent.Reset();
                        FeeComponent.SetRange("Code", "Fee Code");
                        IF FeeComponent.FindFirst() then begin
                            "Fee Description" := FeeComponent.Description;
                            //"Shortcut Dimension 1 Code" := FeeComponent."Global Dimension 1 Code";
                            "Shortcut Dimension 2 Code" := FeeComponent."Global Dimension 2 Code";

                            StudentMasterCS.Reset();
                            StudentMasterCS.SetRange("Enrollment No.", Rec."Enrollment No.");
                            IF StudentMasterCS.FindFirst() then
                                Validate("Shortcut Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");

                            SAPFeeCode.Reset();
                            SAPFeeCode.SetRange("SAP Code", FeeComponent."SAP Code");
                            IF SAPFeeCode.FindFirst() then begin
                                "SAP Code" := SAPFeeCode."SAP Code";
                                "SAP G/L Account" := SAPFeeCode."SAP G/L Account";
                                "SAP Assignment Code" := SAPFeeCode."SAP Assignment Code";
                                "SAP Description" := SAPFeeCode."SAP Description";
                                "SAP Cost Centre" := SAPFeeCode."SAP Cost Centre";
                                "SAP Profit Centre" := SAPFeeCode."SAP Profit Centre";
                                "SAP Company Code" := SAPFeeCode."SAP Company Code";
                                "SAP Bus. Area" := SAPFeeCode."SAP Bus. Area";
                                "Fee Group" := SAPFeeCode."Fee Group";
                            end;
                        end Else begin
                            "SAP Code" := '';
                            "SAP G/L Account" := '';
                            "SAP Assignment Code" := '';
                            "SAP Description" := '';
                            "SAP Cost Centre" := '';
                            "SAP Profit Centre" := '';
                            "SAP Company Code" := '';
                            "SAP Bus. Area" := '';
                            "Fee Group" := "Fee Group"::" ";
                            "Account No." := '';
                            "Shortcut Dimension 1 Code" := '';
                            "Shortcut Dimension 2 Code" := '';
                        end;
                    end;

                end;
                //Code added for Assign Value in Field::CSPL-00136::02-05-2019: Start
            end;

            trigger Onlookup()
            var
                StudentMasterRec: Record "Student Master-CS";
            begin
                IF ("Bal. Account Type" = "Bal. Account Type"::Customer) AND ("Bal. Account No." <> '') Then begin
                    StudentMasterRec.RESET();
                    StudentMasterRec.SETRANGE("Original Student No.", "Bal. Account No.");
                    IF PAGE.RUNMODAL(0, StudentMasterRec) = ACTION::LookupOK THEN BEGIN
                        Validate("Enrollment No.", StudentMasterRec."Enrollment No.");
                    end;
                end;

                IF ("Account Type" = "Account Type"::Customer) AND ("Account No." <> '') Then begin
                    StudentMasterRec.RESET();
                    StudentMasterRec.SETRANGE("Original Student No.", "Account No.");
                    IF PAGE.RUNMODAL(0, StudentMasterRec) = ACTION::LookupOK THEN BEGIN
                        Validate("Enrollment No.", StudentMasterRec."Enrollment No.");
                    end;
                end;
            end;
        }
        field(50060; "Customer Bank Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Customer Bank Code-CS".BankCode;
            Caption = 'Customer Bank Code';
            DataClassification = CustomerContent;
        }
        field(50061; "Customer Bank Branch Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Cust Bank Branch-CS".BranchCode;
            Caption = 'Customer Bank Branch Code';
            DataClassification = CustomerContent;
        }
        field(50062; "Credit Memo Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Credit Memo,Refund';
            OptionMembers = " ","Credit Memo",Refund;
            Caption = 'Credit Memo Type';
            DataClassification = CustomerContent;
        }
        field(50063; Narration; Text[100])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Narration';
            DataClassification = CustomerContent;
        }
        field(50064; "UnRelazised Doc No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Unrelazised Document No.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Assign Value in UnRelazised Doc No. Field::CSPL-00136::02-05-2019: Start
                GenJournalLine.Reset();
                GenJournalLine.SETRANGE("Journal Template Name", 'BANK RECEI');
                GenJournalLine.SETRANGE("Journal Batch Name", 'DEFAULT');
                GenJournalLine.SETRANGE("Bal. Account Type", "Bal. Account Type"::"G/L Account");
                GenJournalLine.SETRANGE("Bal. Account No.", '1309002');
                IF GenJournalLine.FINDFIRST() THEN
                    GLEntry.Reset();
                GLEntry.SETRANGE("Bal. Account No.", '1309002');
                GLEntry.SETRANGE(GLEntry.Posted, FALSE);
                IF GLEntry.FINDFIRST() THEN
                    IF PAGE.RUNMODAL(20, GLEntry) = ACTION::LookupOK THEN
                        "UnRelazised Doc No." := GLEntry."Document No.";
                //Code added for Assign Value in UnRelazised Doc No. Field::CSPL-00136::02-05-2019: End
            end;
        }
        field(50065; "Transaction Number"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Transaction Number';
            DataClassification = CustomerContent;
        }
        field(50066; Posted; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(50067; "Receipt No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Receipt No.';
            DataClassification = CustomerContent;
        }
        field(50068; "Currency Exch. Rate"; Decimal)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Currency Exch. Rate';
            DataClassification = CustomerContent;
        }
        field(50069; "ShortCut Dimension Code 3"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'ShortCut Dimension Code 3';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "ShortCut Dimension Code 3");
            end;
        }
        field(50070; "Synchronised with SFAS"; Boolean)
        {
            Caption = 'Synchronised with SFAS';
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50071; "Not Synchronised with SFAS"; Boolean)
        {
            Caption = ' Not Synchronised with SFAS';
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50072; "User ID"; Text[50])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50073; "Reversal New"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50074; "Applies To Rev. Doc. No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'Applies To Rev. Doc. No.';
            DataClassification = CustomerContent;
        }
        field(50075; "Show INR"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50076; "Currency Code Receipt"; Code[10])
        {
            Caption = 'Currency Code Receipt';
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50077; "Amount Receipt"; Decimal)
        {
            Caption = 'Amount Receipt';
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50078; "Cheque Nos."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Cheque Nos.';
            DataClassification = CustomerContent;
        }

        field(50079; "Cheque Dates"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Customer Bank Code-CS".BankCode;
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(50082; "18 Digit Student ID"; Text[20])
        {
            Caption = '18 Digit Student ID';
            DataClassification = CustomerContent;
        }
        field(50083; "Item Code"; Option)
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
            OptionCaption = ',SEATDEP,HOUDEP,EM-SEATHOS';
            OptionMembers = " ",SEATDEP,HOUDEP,"EM-SEATHOS";

        }
        field(50084; Paid; Boolean)
        {
            Caption = 'Paid';
            DataClassification = CustomerContent;
        }
        field(50085; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Authorized,Captured,Partially Captured,Refunded,Partially Refunded,Uncaptured';
            OptionMembers = " ",Authorized,Captured,"Partially Captured",Refunded,"Partially Refunded",Uncaptured;
        }
        field(50086; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            DataClassification = CustomerContent;
        }
        field(50087; "Student Application"; Code[20])
        {
            Caption = 'Student Application';
            DataClassification = CustomerContent;
        }
        field(50088; "Transaction ID"; Text[250])
        {
            Caption = 'Transaction ID';
            DataClassification = CustomerContent;
        }
        field(50089; "Transaction Status"; Option)
        {
            Caption = 'Transaction Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Completed,Cancelled';
            OptionMembers = " ",Completed,Cancelled;
        }
        field(50090; "Transaction Sub-Type"; Option)
        {
            Caption = 'Transaction Sub-Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Charge Card,ACH,Check,Cash,Wire Transfer,Money Order';
            OptionMembers = " ","Charge Card",ACH,Check,Cash,"Wire Transfer","Money Order";
        }
        field(50091; "Transaction Types"; Option)
        {
            Caption = 'Transaction Types';
            DataClassification = CustomerContent;
            OptionCaption = ',Normal,Refund,Seat Deposit,Housing Deposit,Housing and Seat Deposit';
            OptionMembers = " ",Normal,Refund,"Seat Deposit","Housing Deposit","Housing and Seat Deposit";
        }
        field(50092; "18 Digit Transaction ID"; Text[20])
        {
            Caption = '18 Digit Transaction ID';
            DataClassification = CustomerContent;
        }
        field(50093; "SAP Code"; Code[20])
        {
            Caption = 'SAP Code';
            DataClassification = CustomerContent;
            TableRelation = "SAP Fee Code";
            Editable = false;
        }
        field(50094; "Payment Plan Applied"; Boolean)
        {
            Caption = 'Payment Plan Applied';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50095; "Payment Plan Instalment"; Integer)
        {
            Caption = 'Payment Plan Instalment';
            MinValue = 2;
            MaxValue = 4;
            Editable = false;
        }
        field(50096; "SAP G/L Account"; Code[20])
        {
            Caption = 'SAP G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            Editable = false;
        }
        field(50097; "SAP Profit Centre"; Code[20])
        {
            Caption = 'SAP Profit Centre';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50098; "SAP Company Code"; Code[20])
        {
            Caption = 'SAP Company Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50099; "SAP Bus. Area"; Code[20])
        {
            Caption = 'SAP Bus. Area';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50100; "SAP Assignment Code"; Code[20])
        {
            Caption = 'SAP Assignment Code';
            DataClassification = CustomerContent;
        }
        field(50101; "SAP Description"; Text[30])
        {
            Caption = 'SAP Descriptions';
            DataClassification = CustomerContent;
        }
        field(50102; "Fee Group"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Group';
            OptionCaption = ' ,Non-Institutional,Institutional';
            OptionMembers = " ","Non-Institutional",Institutional;
        }
        field(50103; "SAP Cost Centre"; Code[20])
        {
            Caption = 'SAP Cost Centre';
            DataClassification = CustomerContent;
        }
        field(50104; "Payment By Financial Aid"; Boolean)
        {
            Caption = 'Payment By Financial Aid';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50105; "Fund Type"; Option)
        {
            Caption = 'Fund Type';
            OptionCaption = ' ,FDSL-Plus,FDSL-Unsub';
            OptionMembers = " ","FDSL-Plus","FDSL-Unsub";
            DataClassification = CustomerContent;
            Editable = False;
            TRigger OnValidate()
            Begin
                If "Journal Batch Name" = 'BANKRCPT' then begin
                    IF "Fund Type" <> "Fund Type"::" " then
                        "Payment By Financial Aid" := true;
                end;

            End;
        }
        field(50106; "Roster Entry No."; Integer)
        {
            Caption = 'Roster Entry No.';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50107; "Financial Aid Approved"; Boolean)
        {
            Caption = 'Financial Aid Approved';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50108; "Auto Generated"; Boolean)
        {
            Caption = 'Auto Generated';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50109; "Deposit Type"; Option)
        {
            Caption = 'Deposit Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Seat Deposit,Housing Deposit';
            OptionMembers = " ","Seat Deposit","Housing Deposit";
        }
        field(50110; "Self Payment Applied"; Boolean)
        {
            Caption = 'Self Payment Applied';
            DataClassification = CustomerContent;
        }
        field(50111; "Waiver/Scholar/Grant Code"; Code[20])
        {
            Caption = 'Waiver/Scholarship/Grant Code';
            DataClassification = CustomerContent;
            TableRelation = "Source Scholarship-CS";
            trigger OnValidate()
            begin
                if SourceScholarship.Get("Waiver/Scholar/Grant Code") then
                    "Waiver/Scholar/Grant Desc" := SourceScholarship.Description
                else
                    "Waiver/Scholar/Grant Desc" := '';

            end;
        }
        field(50112; "Waiver/Scholar/Grant Desc"; Text[100])
        {
            Caption = 'Waiver/Scholarship/Grant Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50113; Reason; Text[500])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50114; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50120; "Living Exps. Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Living Expense Document No.';
        }
        field(50121; "Living Exps. Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Living Expense Entry No.';
        }
        field(50122; "Living Exps. RCPT Entry No."; Integer)
        {
            Caption = 'Living Exps. RCPT Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50123; "Living Exps. INV Entry No."; Integer)
        {
            Caption = 'Living Exps. INV Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50124; "Living Exps. Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Seat Deposit Refund","Rent Transfer Refund","Rent Transfer Payment","T4 Stipend Payment","Refund of Student Payment";
        }
        field(50125; "Pre Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50126; "Type of Billing"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type of Billing';
            OptionMembers = " ","Clinical Billing","FIU Surcharge";
        }
        field(50127; "Billing Weeks"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Billing Weeks';
            DecimalPlaces = 0;
        }
        field(50128; "Admitted Year"; Code[20])
        {
            Description = 'CS Field Added 04-01-2021';
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
        }

        field(50129; "Fee Description"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Fee Description';
            Description = 'CS Field Added 21-01-2021';
        }
        field(50130; "FIU Billing Weeks"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FIU Billing Weeks';
            DecimalPlaces = 0;
        }
        field(50136; "1098-T From"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50137; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50138; "Return Reason Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Reason Code" where(Type = filter(R2T4));

        }
        field(50139; "Return Reason Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        Field(50140; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50141; "Applied from Portal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    trigger OnInsert()
    begin
        "Pre Document No." := "Document No.";
    end;

    trigger OnModify()
    begin
        If "Roster Entry No." <> 0 then begin
            FinancialAidRoster.Reset();
            FinancialAidRoster.SetRange("Entry No", "Roster Entry No.");
            IF FinancialAidRoster.FindFirst() then
                Error('Financial Aid Roster Already Approved for Student No. %1 , Bank Account No. %2 & Fund Type %3', FinancialAidRoster."Student No.", FinancialAidRoster."Bank Account No.", FinancialAidRoster."Fund Type");
        end;

        If "Auto Generated" = true then
            Error('Auto Generated entries cannot be modified.');


        "Pre Document No." := "Document No.";

        IF xRec.Updated = Updated THEN
            Updated := TRUE;
    end;

    trigger OnDelete()
    begin
        If "Roster Entry No." <> 0 then begin
            FinancialAidRoster.Reset();
            FinancialAidRoster.SetRange("Entry No", "Roster Entry No.");
            IF FinancialAidRoster.FindFirst() then
                Error('Financial Aid Roster Already Approved for Student No. %1 , Bank Account No. %2 & Fund Type %3', FinancialAidRoster."Student No.", FinancialAidRoster."Bank Account No.", FinancialAidRoster."Fund Type");
        end;

        If "Auto Generated" = true then begin
            GenJournalLine.Reset();
            GenJournalLine.SetRange("Journal Template Name", "Journal Template Name");
            GenJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
            GenJournalLine.SetRange("Enrollment No.", "Enrollment No.");
            GenJournalLine.SetRange(Semester, Semester);
            GenJournalLine.SetRange("Academic Year", "Academic Year");
            GenJournalLine.SetRange("Enrollment No.", "Enrollment No.");
            If GenJournalLine.FindSet() then
                GenJournalLine.DeleteAll();
        end;
    End;



    procedure ReopenVoucherCS()
    begin
        //Code added for voucher reopen ::CSPL-00136::02-05-2019: Start
        GenJnlLine.Reset();
        GenJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        GenJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        GenJnlLine.SETRANGE("Document No.", "Document No.");
        IF GenJnlLine.FindSet() THEN
            // IF CONFIRM('Do you want to Reopen Document No. %1 and Amount %2.....', TRUE, GenJnlLine."Document No.", GenJnlLine.Amount) THEN    Confirm Message Not Req
            REPEAT
                GenJnlLine.Approved := FALSE;
                CLEAR(GenJnlLine."Approved On");
                GenJnlLine."Send for Approval" := FALSE;
                CLEAR(GenJnlLine."Send for Approval On");
                GenJnlLine."Approved By" := '';
                GenJnlLine.Status := GenJnlLine.Status::Open;
                GenJnlLine.Modify();
            UNTIL GenJnlLine.NEXT() = 0;
        //Code added for voucher reopen ::CSPL-00136::02-05-2019: End
    end;



    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlLine: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        StudentMasterCS: Record "Student Master-CS";
        StudentMasterCS1: Record "Student Master-CS";
        BankAccount: Record "Bank Account";
        FinancialAidRoster: Record "Financial Aid Roster";
        SourceScholarship: Record "Source Scholarship-CS";

    // procedure GetAdditionalInfo()
    // var
    //     GenjournalLine_lRec: Record "Gen. Journal Line";
    //     FeeComponent: Record "Fee Component Master-CS";
    //     SAPFeeCode: Record "SAP Fee Code";
    //     FeeDesc_lTxt: Text;
    //     DepartmentCode_lCod: Code[20];

    // begin
    //     IF "Account Type" = "Account Type"::"Bank Account" Then begin
    //         BankAccount.Reset();
    //         BankAccount.SetRange("No.", "Account No.");
    //         IF BankAccount.FindFirst() then begin
    //             "SAP G/L Account" := BankAccount."SAP G/L Account";
    //             "SAP Bus. Area" := BankAccount."SAP Bus. Area";
    //             "SAP Profit Centre" := BankAccount."SAP Profit Centre";
    //             "SAP Company Code" := BankAccount."SAP Company Code";
    //         end Else begin
    //             "SAP G/L Account" := '';
    //             "SAP Bus. Area" := '';
    //             "SAP Profit Centre" := '';
    //             "SAP Company Code" := '';
    //         end;
    //     end;
    //     //CS:Navdeep -Start
    //     FeeDesc_lTxt := '';
    //     DepartmentCode_lCod := '';
    //     IF ("Account Type" = "Account Type"::Customer) AND ("Fee Code" = '') then begin
    //         GenjournalLine_lRec.Reset();
    //         GenjournalLine_lRec.SetRange("Journal Template Name", Rec."Journal Template Name");
    //         GenjournalLine_lRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
    //         GenjournalLine_lRec.SetRange("Document No.", Rec."Document No.");
    //         GenjournalLine_lRec.SetRange("Account Type", GenjournalLine_lRec."Account Type"::"G/L Account");
    //         IF GenjournalLine_lRec.FindLast() then begin
    //             FeeDesc_lTxt := GenjournalLine_lRec."Fee Description";
    //             DepartmentCode_lCod := GenjournalLine_lRec."Shortcut Dimension 2 Code";
    //         end;

    //         "Fee Description" := FeeDesc_lTxt;
    //         "Shortcut Dimension 2 Code" := DepartmentCode_lCod;
    //     end;

    //     IF ("Account Type" = "Account Type"::"G/L Account") and ("Fee Code" <> '') then begin
    //         GenjournalLine_lRec.Reset();
    //         GenjournalLine_lRec.SetRange("Journal Template Name", Rec."Journal Template Name");
    //         GenjournalLine_lRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
    //         GenjournalLine_lRec.SetRange("Document No.", Rec."Document No.");
    //         GenjournalLine_lRec.SetRange("Account Type", GenjournalLine_lRec."Account Type"::Customer);
    //         IF GenjournalLine_lRec.FindSet() then begin
    //             repeat
    //                 GenjournalLine_lRec."Fee Description" := Rec."Fee Description";
    //                 GenjournalLine_lRec."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
    //                 GenjournalLine_lRec.Modify();
    //             until GenjournalLine_lRec.Next() = 0;
    //         end;
    //     end;
    //     //---------------------------------------------------
    //     IF ("Bal. Account Type" = "Bal. Account Type"::Customer) and ("Fee Code" <> '') Then begin
    //         FeeComponent.Reset();
    //         FeeComponent.SetRange("Code", "Fee Code");
    //         IF FeeComponent.FindFirst() then begin
    //             "Fee Description" := FeeComponent.Description;
    //             Validate("Shortcut Dimension 1 Code", FeeComponent."Global Dimension 1 Code");
    //             Validate("Shortcut Dimension 2 Code", FeeComponent."Global Dimension 2 Code");

    //             SAPFeeCode.Reset();
    //             SAPFeeCode.SetRange("SAP Code", FeeComponent."SAP Code");
    //             IF SAPFeeCode.FindFirst() then begin
    //                 "SAP Code" := SAPFeeCode."SAP Code";
    //                 "SAP G/L Account" := SAPFeeCode."SAP G/L Account";
    //                 "SAP Assignment Code" := SAPFeeCode."SAP Assignment Code";
    //                 "SAP Description" := SAPFeeCode."SAP Description";
    //                 "SAP Cost Centre" := SAPFeeCode."SAP Cost Centre";
    //                 "SAP Profit Centre" := SAPFeeCode."SAP Profit Centre";
    //                 "SAP Company Code" := SAPFeeCode."SAP Company Code";
    //                 "SAP Bus. Area" := SAPFeeCode."SAP Bus. Area";
    //                 "Fee Group" := SAPFeeCode."Fee Group";
    //             end;
    //         end Else begin
    //             "SAP Code" := '';
    //             "SAP G/L Account" := '';
    //             "SAP Assignment Code" := '';
    //             "SAP Description" := '';
    //             "SAP Cost Centre" := '';
    //             "SAP Profit Centre" := '';
    //             "SAP Company Code" := '';
    //             "SAP Bus. Area" := '';
    //             "Fee Group" := "Fee Group"::" ";
    //             "Account No." := '';
    //             "Shortcut Dimension 1 Code" := '';
    //             "Shortcut Dimension 2 Code" := '';
    //         end;
    //     end;

    //     IF "Account Type" = "Account Type"::"Bank Account" Then begin
    //         BankAccount.Reset();
    //         BankAccount.SetRange("No.", "Account No.");
    //         IF BankAccount.FindFirst() then begin
    //             "SAP G/L Account" := BankAccount."SAP G/L Account";
    //             "SAP Bus. Area" := BankAccount."SAP Bus. Area";
    //             "SAP Profit Centre" := BankAccount."SAP Profit Centre";
    //             "SAP Company Code" := BankAccount."SAP Company Code";
    //         end Else begin
    //             "SAP G/L Account" := '';
    //             "SAP Bus. Area" := '';
    //             "SAP Profit Centre" := '';
    //             "SAP Company Code" := '';
    //         end;
    //     end;

    // end;




}


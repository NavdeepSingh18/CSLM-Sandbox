tableextension 50580 "tableextensionCLE" extends "Cust. Ledger Entry"
{
    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    30-04-2019    Apply - OnValidate            Code added for Assign Value in Detailed Cust. Ledg. Entry Apply Field
    // 2         CSPL-00136    30-04-2019    CopyFromGenJnlLine            Code added for Assign Value in Fields
    fields
    {

        field(50000; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Fee Component Master-CS";
            DataClassification = CustomerContent;
        }
        field(50001; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Course Master-CS";
        }
        field(50002; Semester; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Semester Master-CS";
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(50003; "Academic Year"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Academic Year Master-CS";
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(50004; Year; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(50005; "Paid/Unpaid Online Fee"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Paid/Unpaid Online Fee';
            DataClassification = CustomerContent;
        }
        field(50006; "Late Fee Amount %"; Decimal)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Late Fee Amount %';
            DataClassification = CustomerContent;
        }
        field(50008; Updated; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50009; Category; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Category Master-CS";
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(50010; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(50011; "Cheque Dates"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(50012; "Cheque Nos."; Code[35])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
        }
        field(50013; "Instrument Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,DD,CK,RT,CA,SM,WT,Other,CS,OI';
            OptionMembers = " ",DD,CK,RT,CA,SM,WT,Other,CS,OI;
            Caption = 'Instrument Type';
            DataClassification = CustomerContent;
        }
        field(50014; "Customer Bank Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Customer Bank Code';
            DataClassification = CustomerContent;
        }
        field(50015; "Customer Bank Branch Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Customer Bank Branch Code';
            DataClassification = CustomerContent;
        }
        field(50016; Narration; Text[100])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Narration';
        }
        field(50017; "UnRelazised Doc No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'UnRelazised Doc No.';
            DataClassification = CustomerContent;
        }
        field(50018; "Transaction Number"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = true;
            Caption = 'Transaction Number';
            DataClassification = CustomerContent;
        }
        field(50019; Posted; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(50020; "Receipt No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = true;
            Caption = 'Receipt No.';
            DataClassification = CustomerContent;
        }
        field(50021; "Record To Show"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Record To Show';
            DataClassification = CustomerContent;
        }
        field(50022; Apply; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Apply';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Detailed Cust. Ledg. Entry Apply Field::CSPL-00136::30-04-2019: Start
                /*
                CustLedgerEntry.Reset();
                CustLedgerEntry.SETRANGE("Entry No.",Rec."Entry No.");
                IF CustLedgerEntry.FINDFIRST()THEN
                  IF Rec.Apply = TRUE THEN
                    CustLedgerEntry."APPLY USER ID" := FORMAT(UserId())
                  ELSE
                    CustLedgerEntry."APPLY USER ID" := '';
                  CustLedgerEntry.MODIFY(TRUE);
                  */
                DtldCustLedgEntry.Reset();
                DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.");
                DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", Rec."Entry No.");
                IF DtldCustLedgEntry.FINDSET() THEN
                    REPEAT
                        DtldCustLedgEntry.Apply := Apply;
                        DtldCustLedgEntry.MODIFY(TRUE);
                    UNTIL DtldCustLedgEntry.NEXT() = 0;
                //Code added for Assign Value in Detailed Cust. Ledg. Entry Apply Field::CSPL-00136::30-04-2019: End

            end;
        }
        field(50023; "Reversal New"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Reversal New';
            DataClassification = CustomerContent;
        }
        field(50024; "Applies To Rev. Doc. No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = true;
            Caption = 'Applies To Rev. Doc. No.';
            DataClassification = CustomerContent;
        }
        field(50025; "APPLY USER ID"; Code[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'APPLY USER ID';
            DataClassification = CustomerContent;
        }
        field(50026; "Show INR"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Show INR';
            DataClassification = CustomerContent;
        }
        field(50027; "Fee Classification Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Fee Classification Code" WHERE("No." = FIELD("Customer No.")));
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Fee Classification Code';
        }
        field(50028; "Payment By Financial Aid"; Boolean)
        {
            Caption = 'Payment By Financial Aid';
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(50029; "Fund Type"; Option)
        {
            Caption = 'Fund Type';
            OptionCaption = ' ,FDSL-Plus,FDSL-Unsub';
            OptionMembers = " ","FDSL-Plus","FDSL-Unsub";
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50030; "Roster Entry No."; Integer)
        {
            Caption = 'Roster Entry No.';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50031; "Financial Aid Approved"; Boolean)
        {
            Caption = 'Financial Aid Approved';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50032; "Payment Plan Applied"; Boolean)
        {
            Caption = 'Payment Plan Applied';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50033; "Payment Plan Instalment"; Integer)
        {
            Caption = 'Payment Plan Instalment';
            MinValue = 2;
            MaxValue = 4;
            Editable = false;
        }
        field(50034; "Auto Generated"; Boolean)
        {
            Caption = 'Auto Generated';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50035; "Deposit Type"; Option)
        {
            Caption = 'Deposit Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Seat Deposit,Housing Deposit';
            OptionMembers = " ","Seat Deposit","Housing Deposit";
        }
        field(50036; "Self Payment Applied"; Boolean)
        {
            Caption = 'Self Payment Applied';
            DataClassification = CustomerContent;
        }
        field(50037; "Waiver/Scholar/Grant Code"; Code[20])
        {
            Caption = 'Waiver/Scholarship/Grant Code';
            DataClassification = CustomerContent;
        }
        field(50038; "Waiver/Scholar/Grant Desc"; Text[100])
        {
            Caption = 'Waiver/Scholarship/Grant Description';
            DataClassification = CustomerContent;
        }
        field(50039; "Withdrawal No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Withdrawal No';
            DataClassification = CustomerContent;
        }
        field(50040; Reason; Text[500])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50041; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50050; "Living Exps. Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Living Expense Document No.';
        }
        field(50051; "Living Exps. Entry No."; Integer)
        {
            Caption = 'Living Exps. Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50052; "Living Exps. RCPT Entry No."; Integer)
        {
            Caption = 'Living Exps. RCPT Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50053; "Living Exps. INV Entry No."; Integer)
        {
            Caption = 'Living Exps. INV Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50054; "Item Code"; Option)
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
            OptionCaption = ',SEATDEP,HOUDEP,EM-SEATHOS';
            OptionMembers = " ",SEATDEP,HOUDEP,"EM-SEATHOS";

        }
        field(50055; Paid; Boolean)
        {
            Caption = 'Paid';
            DataClassification = CustomerContent;
        }
        field(50056; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Authorized,Captured,Partially Captured,Refunded,Partially Refunded,Uncaptured';
            OptionMembers = " ",Authorized,Captured,"Partially Captured",Refunded,"Partially Refunded",Uncaptured;
        }
        field(50057; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            DataClassification = CustomerContent;
        }
        field(50058; "Student Application"; Code[20])
        {
            Caption = 'Student Application';
            DataClassification = CustomerContent;
        }
        field(50059; "Transaction ID"; Text[250])
        {
            Caption = 'Transaction ID';
            DataClassification = CustomerContent;
        }
        field(50060; "Transaction Status"; Option)
        {
            Caption = 'Transaction Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Completed,Cancelled';
            OptionMembers = " ",Completed,Cancelled;
        }
        field(50061; "Transaction Sub-Type"; Option)
        {
            Caption = 'Transaction Sub-Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Charge Card,ACH,Check,Cash,Wire Transfer,Money Order';
            OptionMembers = " ","Charge Card",ACH,Check,Cash,"Wire Transfer","Money Order";
        }
        field(50062; "Transaction Types"; Option)
        {
            Caption = 'Transaction Types';
            DataClassification = CustomerContent;
            OptionCaption = ',Normal,Refund,Seat Deposit,Housing Deposit,Housing and Seat Deposit';
            OptionMembers = " ",Normal,Refund,"Seat Deposit","Housing Deposit","Housing and Seat Deposit";
        }
        field(50063; "18 Digit Transaction ID"; Text[20])
        {
            Caption = '18 Digit Transaction ID';
            DataClassification = CustomerContent;
        }
        field(50064; "Type of Billing"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type of Billing';
            OptionMembers = " ","Clinical Billing","FIU Surcharge";
        }
        field(50065; "Billing Weeks"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Billing Weeks';
            DecimalPlaces = 0;
        }
        field(50066; "Admitted Year"; Code[20])
        {
            Description = 'CS Field Added 04-01-2021';
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
        }
        field(50067; "Fee Description"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Fee Description';
            Description = 'CS Field Added 21-01-2021';
        }

        field(50068; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50069; "FIU Billing Weeks"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50070; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(50076; "1098-T From"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1098-T Form';
        }
        Field(50080; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        Updated := TRUE;
    end;

    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
}


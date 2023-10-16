table 50155 "Fee Setup-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    07-05-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Fee Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Course Fee No"; Code[20])
        {
            Caption = 'Course Fee No';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(3; "Installment Scheme"; Option)
        {
            Caption = 'Installment Scheme';
            DataClassification = CustomerContent;
            OptionCaption = ' ,By Organization,By Course';
            OptionMembers = " ","By Organization","By Course";
        }
        field(4; "No Of Installment"; Integer)
        {
            MinValue = 2;
            MaxValue = 4;
            Caption = 'No Of Installment';
            DataClassification = CustomerContent;
        }
        field(5; "Installment Charges"; Decimal)
        {
            BlankZero = true;
            Caption = 'Installment Charges';
            DataClassification = CustomerContent;
        }
        field(6; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(7; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(8; "Fee Invoice No."; Code[20])
        {
            Caption = 'Fee Invoice No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(10; "Exam Fee Code"; Code[20])
        {
            Caption = 'Exam Fee Code';
            DataClassification = CustomerContent;
            TableRelation = "Fee Component Master-CS".Code;
        }
        field(12; "Attendance Fine Code"; Code[20])
        {
            Caption = 'Attendance Fine Code';
            DataClassification = CustomerContent;
            TableRelation = "Fee Component Master-CS";
        }
        field(50000; "Journal Batch For Hostel"; Code[20])
        {
            Caption = 'Journal Batch For Hostel';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Journal Batch For Transport"; Code[20])
        {
            Caption = 'Journal Batch For Transport';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(50004; "Fee Discount No."; Code[20])
        {
            Caption = 'Fee Discount No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(50005; "Fine No"; Code[20])
        {
            Caption = 'Fine No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(50006; "Scholarship Detail No."; Code[10])
        {
            Caption = 'Scholarship Details No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(50007; "Rank Detail No."; Code[10])
        {
            Caption = 'Rank Details No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(50008; "Late Fee Fine No."; Code[10])
        {
            Caption = 'Late Fee Fine No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(50009; "Other Fee No."; Code[10])
        {
            Caption = 'Other Fee No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(50010; "Payment Template Name"; Code[10])
        {
            Caption = 'Payment Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(50011; "Payment Batch Name"; Code[10])
        {
            Caption = 'Payment Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payment Template Name"));
        }
        field(50012; "ScholarShip Template Name"; Code[10])
        {
            Caption = 'ScholarShip Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(50013; "ScholarShip Batch Name"; Code[10])
        {
            Caption = 'ScholarShip Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("ScholarShip Template Name"));
        }
        field(50014; "Financial Aid Payment Bank"; Code[20])
        {
            Caption = 'Financial Aid Payment Bank';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(50015; "Reminder Payment Plan"; DateFormula)
        {
            Caption = 'Reminder Payment Plan';
            DataClassification = CustomerContent;
        }
        field(50016; "Payment Plan Batch Name"; Code[10])
        {
            Caption = 'Payment Plan Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payment Plan Template Name"));
        }
        field(50017; "Other Fee Batch Name"; Code[10])
        {
            Caption = 'Other Fee Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Other Fee Template Name"));
        }
        field(50018; "Withdrawal Template Name"; Code[10])
        {
            Caption = 'Withdrawal Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(50019; "Withdrawal Batch Name"; Code[10])
        {
            Caption = 'Withdrawal Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Withdrawal Template Name"));
        }
        field(50020; "Withdrawal G/L Account No."; Code[20])
        {
            Caption = 'Withdrawal G/L Account No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(50021; "Withdrawal Document No."; Code[20])
        {
            Caption = 'Withdrawal Document No.';
            DataClassification = CustomerContent;

            TableRelation = "No. Series";
        }
        field(50022; "Unsubsidized Budgetted Amount"; Decimal)
        {
            Caption = 'Unsubsidized Budgetted Amount';
            DataClassification = CustomerContent;
        }
        field(50023; "Graduate Plus Budgetted Amount"; Decimal)
        {
            Caption = 'Graduate Plus Budgetted Amount';
            DataClassification = CustomerContent;
        }

        field(50024; "Standard Cost"; Decimal)
        {
            Caption = 'Standard Cost';
            DataClassification = CustomerContent;
        }
        field(50025; "Waiver Auto Post"; Boolean)
        {
            Caption = 'Waiver Auto Post';
            DataClassification = CustomerContent;
        }
        field(50031; "Financial AID No."; Code[20])
        {
            Caption = 'Financial AID No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50032; "Fin. Aid Exp. Date Formula"; DateFormula)
        {
            caption = 'Fin. Aid Exp. Date Formula';
            DataClassification = CustomerContent;
        }
        field(50033; "Payment Plan No."; Code[20])
        {
            Caption = 'Payment Plan No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50034; "Fin Account Template Name"; Code[10])
        {
            Caption = 'Financial Accountability Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(50035; "Fin Acc Batch Name"; Code[10])
        {
            Caption = 'Financial Accountability Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Withdrawal Template Name"));
        }
        field(50036; "Fin Acc Due Date"; DateFormula)
        {
            Caption = 'Financial Accountability Due Date';
            DataClassification = CustomerContent;
        }
        field(50041; "Seat Deposit Payment Batch"; Code[10])
        {
            Caption = 'Seat Deposit Payment Batch';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payment Template Name"));
        }
        field(50042; "Housing Deposit Payment Batch"; Code[10])
        {
            Caption = 'Housing Deposit Payment Batch';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payment Template Name"));
        }
        field(50043; "Payment Plan Template Name"; Code[10])
        {
            Caption = 'Payment Plan Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(50044; "Other Fee Template Name"; Code[10])
        {
            Caption = 'Other Fee Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(50045; "SAP Bus. Area"; Code[20])
        {
            Caption = 'SAP Bus. Area';
            DataClassification = CustomerContent;
        }
        field(50046; "SAP Profit Centre"; Code[20])
        {
            Caption = 'SAP Profit Centre';
            DataClassification = CustomerContent;
        }
        field(50060; "Living Expense Template"; Code[10])
        {
            Caption = 'Living Expense Template';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(50061; "Living Expense Batch"; Code[10])
        {
            Caption = 'Living Expense Batch';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Living Expense Template"));
        }
        field(50062; "Living Exps Document Nos."; Code[20])
        {
            Caption = 'Living Exps Document Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50063; "Regular Refund Bank No."; Code[20])
        {
            Caption = 'Regular Refund Bank No.';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(50065; "GV Transfer Payment Bank No."; Code[20])
        {
            Caption = 'GV Transfer Payment Bank No.';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(50066; "Receipt Batch"; Code[20])
        {
            Caption = 'Receipt Batch';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payment Template Name"));
        }
        field(50067; "Wired Transfer Nos."; Code[20])
        {
            Caption = 'Wired Transfer Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50068; "Wired Transfer Template Name"; Code[10])
        {
            Caption = 'Wired Transfer Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(50069; "Wired Transfer Batch Name"; Code[10])
        {
            Caption = 'Wired Transfer Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Wired Transfer Template Name"));
        }
        //SD-SN-18-Dec-2020 +
        // field(50070; "Wired Bank Account No."; Code[20])
        // {
        //     Caption = 'Wired Transfer Bank Account No.';
        //     DataClassification = CustomerContent;
        //     TableRelation = "Bank Account";
        // }
        field(50070; "Fee Bank Account No."; Code[20])
        {
            Caption = 'Fee Bank Account No.';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        //SD-SN-18-Dec-2020 -

        field(50071; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50072; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(33009102; "Discount No."; Code[20])
        {
            Caption = 'Discount No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(33009103; "Fee Discount"; Code[20])
        {
            Caption = 'Fee Discount';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048922; "Hostal No"; Code[20])
        {
            Caption = 'Hostal No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(33048923; "Transport No"; Code[20])
        {
            Caption = 'Transport No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        field(33048924; "Transfer Fee Amount"; Decimal)
        {
            Caption = 'Transfer fee Amount';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048925; "Transfer Fee No. Series"; Code[20])
        {
            Caption = 'Transfer Fee Bo Series';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "No. Series";
        }
        //SD-SN-18-Dec-2020 +
        field(33048926; "Grenville Bank Account No."; Code[20])
        {
            Caption = 'Grenville Bank Account No.';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(33048927; "AUA Housing Bank Account No."; Code[20])
        {
            Caption = 'AUA Housing Bank Account No.';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        //SD-SN-18-Dec-2020 -
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
        key(Key2; "Global Dimension 1 Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::07-05-2019: Start
        "User ID" := FORMAT(UserId());
        Inserted := True;

        //Code added for User Id Assign in User Id Field::CSPL-00092::07-05-2019: End
    end;

    trigger OnModify()
    begin
        IF xRec.Updated = Updated then
            Updated := true;
    end;
}


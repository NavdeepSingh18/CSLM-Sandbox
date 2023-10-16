tableextension 50512 "tableextensionSalesHeader" extends "Sales Header"
{
    // Sr.No.    Emp. ID       Date          Trigger                              Remarks
    // 1         CSPL-00136    30-04-2019    Applies-to Doc. No. - OnLookup       Code added for Assign Value in Applies To Rev. Doc. No. Field
    // 3         CSPL-00136    30-04-2019    Sell-to Customer No. - OnValidate    Code added for Assign Value in Enrollment No.
    fields
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Cust: Record Customer;
            begin
                //Code added for Assign Value in Field::CSPL-00136::30-04-2019: Start
                Cust.Reset();
                if Cust.Get("Sell-to Customer No.") then;
                "Enrollment No." := Cust."Enrollment No.";
                //Code added for Assign Value in Field::CSPL-00136::30-04-2019: End
            end;

        }
        field(50000; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(50001; "Cheque No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
        }
        field(50002; "Cheque Date"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(50003; "Withdrawal No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Withdrawal No.';
            DataClassification = CustomerContent;
            TableRelation = "Withdrawal Student-CS"."No." WHERE("Student No." = FIELD("Sell-to Customer No."),
                                                               Refund = FILTER(false));
        }
        field(50004; "Credit Memo Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Credit Memo,Refund';
            OptionMembers = " ","Credit Memo",Refund;
        }
        field(50006; "Reversal New"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50007; "Applies To Rev. Doc. No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
        }
        field(33048920; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048921; Class; Code[10])
        {
            Caption = 'Class';
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048922; Section; Code[10])
        {
            Caption = 'Section';
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048923; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048924; Course; Code[20])
        {
            Caption = 'Course';
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048925; Semester; Code[10])
        {
            Caption = 'Semester';
            Description = 'CS Field Added 02-05-2019';
        }
    }
}


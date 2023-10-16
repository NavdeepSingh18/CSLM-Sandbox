table 50476 "FA Refund Master"
{
    Caption = 'FA Refund Master';

    fields
    {
        field(1; "FaRefundID"; Integer)
        {
            Caption = 'FA Refund ID';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
        }
        field(3; "AdEnrollID"; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
        }
        field(4; "AdTermID"; Code[20])
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
        }
        field(5; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "CheckNo"; Text[20])
        {
            Caption = 'Check No.';
            DataClassification = CustomerContent;
        }
        field(7; "DateDue"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(8; "DateSent"; Date)
        {
            Caption = 'Sent Date';
            DataClassification = CustomerContent;
        }
        field(9; "FaStudentAidID"; Code[20])
        {
            Caption='FSA ID';
            DataClassification = CustomerContent;
        }
        field(10; "ReturnMethod"; Text[20])
        {
            Caption='Return Method';
            DataClassification = CustomerContent;
        }
        field(11; "Status"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
    }

    keys
    {
        key(Key1; FaRefundID)
        {

        }
    }

    trigger OnInsert()
    begin

        "Creation Date" := Today();
        "Created By" := Userid();
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;
}
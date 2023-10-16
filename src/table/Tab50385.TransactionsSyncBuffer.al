table 50385 "Transactions Sync Buffer"
{
    Caption = 'Transactions Sync Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SLcM ID"; Code[20])
        {
            Caption = 'SLcM ID';
            DataClassification = CustomerContent;
        }
        field(2; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = CustomerContent;
        }
        field(3; Account; Code[20])
        {
            Caption = 'Account';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; "Item Code"; Option)
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
            OptionCaption = ',SEATDEP,HOUDEP,EM-SEATHOS';
            OptionMembers = " ",SEATDEP,HOUDEP,"EM-SEATHOS";

        }
        field(7; Paid; Boolean)
        {
            Caption = 'Paid';
            DataClassification = CustomerContent;
        }
        field(8; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Authorized,Captured,Partially Captured,Refunded,Partially Refunded,Uncaptured';
            OptionMembers = " ",Authorized,Captured,"Partially Captured",Refunded,"Partially Refunded",Uncaptured;
        }
        field(9; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            DataClassification = CustomerContent;
        }
        field(10; "Student Application"; Code[20])
        {
            Caption = 'Student Application';
            DataClassification = CustomerContent;
        }
        field(11; "Transaction ID"; Text[250])
        {
            Caption = 'Transaction ID';
            DataClassification = CustomerContent;
        }
        field(12; "Transaction Status"; Option)
        {
            Caption = 'Transaction Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Completed,Cancelled';
            OptionMembers = " ",Completed,Cancelled;
        }
        field(13; "Transaction Sub-Type"; Option)
        {
            Caption = 'Transaction Sub-Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Charge Card,ACH,Check,Cash,Wire Transfer,Money Order';
            OptionMembers = " ","Charge Card",ACH,Check,Cash,"Wire Transfer","Money Order";
        }
        field(14; "Transaction Type"; Option)
        {
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Normal,Refund,Seat Deposit,Housing Deposit,Housing and Seat Deposit';
            OptionMembers = " ",Normal,Refund,"Seat Deposit","Housing Deposit","Housing and Seat Deposit";
        }
        field(15; "18 Digit Transaction ID"; Text[20])
        {
            Caption = '18 Digit Transaction ID';
            DataClassification = CustomerContent;
        }
        field(16; "Deposit Type"; Option)
        {
            Caption = 'Deposit Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Seat Deposit,Housing Deposit';
            OptionMembers = " ","Seat Deposit","Housing Deposit";
        }
        field(17; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
        field(18; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(19; "Void Entry"; Boolean)
        {
            Caption = 'Void Entry';
        }

    }
    keys
    {
        key(PK; "SLcM ID", "Line No.")
        {
            Clustered = true;
        }
    }

}

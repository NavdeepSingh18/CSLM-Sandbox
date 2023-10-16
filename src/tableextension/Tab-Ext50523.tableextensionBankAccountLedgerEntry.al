tableextension 50523 "tableextension50523" extends "Bank Account Ledger Entry"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778-CS

    fields
    {

        field(50000; "Cheque Printed"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50001; "Cheque Reprint"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50002; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50003; "Customer Bank Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50004; "Customer Bank Branch Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50005; Narration; Text[100])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50006; "UnRelazised Doc No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50007; "Transaction Number"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50008; Posted; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50009; "Receipt No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50010; "Reversal New"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50011; "Applies To Rev. Doc. No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50012; "Instrument Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,DD,CK,RT,CA,SM,WT,Other,CS,OI';
            OptionMembers = " ",DD,CK,RT,CA,SM,WT,Other,CS,OI;
        }
        field(50013; "Currency Code Receipt"; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50014; "Amount Receipt"; Decimal)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50015; "Show INR"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50016; "Cheque Nos."; Code[20])
        {
            Description = 'CS Field';
        }
        field(50017; "Cheque Dates"; Date)
        {
            Description = 'CS Field';
        }
        field(50018; "SAP G/L Account"; Code[20])
        {
            Caption = 'SAP G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(50019; "SAP Profit Centre"; Code[20])
        {
            Caption = 'SAP Profit Centre';
            DataClassification = CustomerContent;
        }
        field(50020; "SAP Company Code"; Code[20])
        {
            Caption = 'SAP Company Code';
            DataClassification = CustomerContent;
        }
        field(50021; "SAP Bus. Area"; Code[20])
        {
            Caption = 'SAP Bus. Area';
            DataClassification = CustomerContent;
        }
        field(50022; "Payment By Financial Aid"; Boolean)
        {
            Caption = 'Payment By Financial Aid';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50023; "Fund Type"; Option)
        {
            Caption = 'Fund Type';
            OptionCaption = ' ,FDSL-Plus,FDSL-Unsub';
            OptionMembers = " ","FDSL-Plus","FDSL-Unsub";
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50024; "Roster Entry No."; Integer)
        {
            Caption = 'Roster Entry No.';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50025; "Financial Aid Approved"; Boolean)
        {
            Caption = 'Financial Aid Approved';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50026; "Payment Plan Applied"; Boolean)
        {
            Caption = 'Payment Plan Applied';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50027; "Payment Plan Instalment"; Integer)
        {
            Caption = 'Payment Plan Instalment';
            MinValue = 2;
            MaxValue = 4;
            Editable = false;
        }
        field(50028; "Auto Generated"; Boolean)
        {
            Caption = 'Auto Generated';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50029; "Deposit Type"; Option)
        {
            Caption = 'Deposit Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Seat Deposit,Housing Deposit';
            OptionMembers = " ","Seat Deposit","Housing Deposit";
        }
        field(50030; "Self Payment Applied"; Boolean)
        {
            Caption = 'Self Payment Applied';
            DataClassification = CustomerContent;
        }
        field(50031; "Waiver/Scholar/Grant Code"; Code[20])
        {
            Caption = 'Waiver/Scholarship/Grant Code';
            DataClassification = CustomerContent;
        }
        field(50032; "Waiver/Scholar/Grant Desc"; Text[100])
        {
            Caption = 'Waiver/Scholarship/Grant Description';
            DataClassification = CustomerContent;
        }
        field(50033; "Withdrawal No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Withdrawal No';
            DataClassification = CustomerContent;
        }
        field(50034; Reason; Text[500])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50035; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50036; "Item Code"; Option)
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
            OptionCaption = ',SEATDEP,HOUDEP,EM-SEATHOS';
            OptionMembers = " ",SEATDEP,HOUDEP,"EM-SEATHOS";

        }
        field(50037; Paid; Boolean)
        {
            Caption = 'Paid';
            DataClassification = CustomerContent;
        }
        field(50038; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Authorized,Captured,Partially Captured,Refunded,Partially Refunded,Uncaptured';
            OptionMembers = " ",Authorized,Captured,"Partially Captured",Refunded,"Partially Refunded",Uncaptured;
        }
        field(50039; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            DataClassification = CustomerContent;
        }
        field(50040; "Student Application"; Code[20])
        {
            Caption = 'Student Application';
            DataClassification = CustomerContent;
        }
        field(50041; "Transaction ID"; Text[250])
        {
            Caption = 'Transaction ID';
            DataClassification = CustomerContent;
        }
        field(50042; "Transaction Status"; Option)
        {
            Caption = 'Transaction Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Completed,Cancelled';
            OptionMembers = " ",Completed,Cancelled;
        }
        field(50043; "Transaction Sub-Type"; Option)
        {
            Caption = 'Transaction Sub-Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Charge Card,ACH,Check,Cash,Wire Transfer,Money Order';
            OptionMembers = " ","Charge Card",ACH,Check,Cash,"Wire Transfer","Money Order";
        }
        field(50044; "Transaction Types"; Option)
        {
            Caption = 'Transaction Types';
            DataClassification = CustomerContent;
            OptionCaption = ',Normal,Refund,Seat Deposit,Housing Deposit,Housing and Seat Deposit';
            OptionMembers = " ",Normal,Refund,"Seat Deposit","Housing Deposit","Housing and Seat Deposit";
        }
        field(50045; "18 Digit Transaction ID"; Text[20])
        {
            Caption = '18 Digit Transaction ID';
            DataClassification = CustomerContent;
        }
        field(50046; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(50048; "1098-T From"; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }
}


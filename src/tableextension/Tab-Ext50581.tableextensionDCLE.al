tableextension 50581 "tableextension50581" extends "Detailed Cust. Ledg. Entry"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019    OnModify                    Code added for Assign Value in Updated Field.
    // 2         CSPL-00136    02-05-2019                                Added New Fields.
    fields
    {
        field(50006; "Late Fee Amount %"; Decimal)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50007; Updated; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50008; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50009; "Cheque Dates"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50010; "Cheque Nos."; Code[35])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50011; "Instrument Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,DD,CK,RT,CA,SM,WT,Other,CS,OI';
            OptionMembers = " ",DD,CK,RT,CA,SM,WT,Other,CS,OI;
        }
        field(50012; "Customer Bank Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50013; "Customer Bank Branch Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50014; Narration; Text[100])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50015; "UnRelazised Doc No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50016; "Transaction Number"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50017; Posted; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50018; "Receipt No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50019; "Course Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Course Master-CS";
        }
        field(50020; Semester; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Semester Master-CS";
        }
        field(50021; "Academic Year"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Academic Year Master-CS";
        }
        field(50022; Year; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50023; Apply; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50024; "Reversal New"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50025; "Applies To Rev. Doc. No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50026; "APPLY USER ID"; Code[30])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50027; "Show INR"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
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
            Editable = false;
        }
        field(50051; "Living Exps. Entry No."; Integer)
        {
            Caption = 'Living Exps. Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50052; "Living Exps. Applied Entry No."; Integer)
        {
            Caption = 'Living Exps. Applied Entry No.';
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
        field(50064; "Admitted Year"; Code[20])
        {
            Description = 'CS Field Added 04-01-2021';
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
        }
        field(50065; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50066; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(50067; "1098-T From"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50068; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    trigger OnModify()
    begin

        //Code added for Assign Value in Updated Field::CSPL-00136::02-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00136::02-05-2019: Start

    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;
}


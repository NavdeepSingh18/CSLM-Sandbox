tableextension 50564 "tableextension50564" extends "G/L Entry"
{
    fields
    {
        field(50000; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50001; "Cheque Dates"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
        }
        field(50002; "Cheque Nos."; Code[35])
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
        field(50055; "Living Exps. Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Living Expense Document No.';
        }
        field(50056; "Living Exps. Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Living Expense Entry No.';
        }
        field(50057; "Living Exps. Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Seat Deposit Refund","Rent Transfer Refund","Rent Transfer Payment","T4 Stipend Payment","Refund of Student Payment";
        }
        field(50058; "Admitted Year"; Code[20])
        {
            Description = 'CS Field Added 04-01-2021';
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
        }
        field(50059; "Fee Description"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Fee Description';
            Description = 'CS Field Added 21-01-2021';
        }
        field(50060; "Student No."; code[20])
        {
            Caption = 'Student No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."Original Student No." where("Enrollment No." = field("Enrollment No.")));
        }
        // field(50061; Comments; Text[250])
        // {
        //     Caption = 'Comments';
        // }
        field(50067; "1098-T From"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1098-T Form';
        }
        field(50068; "Student ID"; code[20])
        {
            Caption = 'Student ID';
            DataClassification = CustomerContent;
        }
        Field(50071; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key2; "Enrollment No.")
        {
        }
    }
}


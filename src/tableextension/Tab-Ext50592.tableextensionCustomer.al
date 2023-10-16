tableextension 50592 "tableextensionCustomer" extends Customer
{
    fields
    {
        field(50010; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50000; "Application No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Pay Type"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Paid,Unpaid';
            OptionMembers = " ",Paid,Unpaid;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "Course Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50003; Semester; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; Year; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Year Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "Academic Year"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50007; "Convert to Student"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50008; Category; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50009; "Parents Income"; Decimal)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50011; "Scholarship Source"; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Scholarship Code';
            Dataclassification = CustomerContent;
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Scholarship));
            Editable = false;
        }
        field(50012; "Internal Rank"; Integer)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50013; "Entrance Test Rank"; Integer)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50014; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50015; "Check Manually"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50016; "Fee Generated"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50017; "Certification Course"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50018; "Parent Customer"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50019; "Branch Transfer"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50020; "Lateral Student"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50021; "Program"; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Graduation Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50022; "Pending For Registration"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50023; "Course Completion NOC"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50024; Section; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50025; Batch; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50026; "Roll No."; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50027; "Fees to Generate"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50160; Status; Code[20])
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            TableRelation = "Student Status";
            Editable = false;
        }

        field(50175; "Payment Plan Instalment"; Integer)
        {
            Caption = 'Payment Plan Instalment';
            MinValue = 2;
            MaxValue = 4;
            Editable = false;
        }
        field(50176; "Sibling/Spouse No."; Code[20])
        {
            Caption = 'Sibling/Spouse No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            Editable = false;
        }
        field(50177; "Grant Code 1"; Code[10])
        {
            Caption = 'Grant Code 1';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Grant));
        }
        field(50178; "Financial Aid Approved"; Boolean)
        {
            Caption = 'Financial Aid Approved';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(50179; "Payment Plan Applied"; Boolean)
        {
            Caption = 'Payment Plan Applied';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50183; "Self Payment Applied"; Boolean)
        {
            Caption = 'Self Payment Applied';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50184; "Fee Generated Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                         "Semester" = FIELD(Semester),
                                                                         "Document Type" = filter(Invoice),
                                                                          "Entry Type" = filter("Initial Entry")));
            Caption = 'Fee Generated Amount';
            Editable = false;

        }
        field(50185; "Grant Code 2"; Code[10])
        {
            Caption = 'Grant Code 2';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Grant));
        }
        field(50186; "Grant Code 3"; Code[10])
        {
            Caption = 'Grant Code 3';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Grant));
        }
        field(50187; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(33048926; "Student Status"; Option)
        {
            OptionMembers = "","Student","Inactive","Provisional Student","Expired","Withdrwal -In- Process","Withdrwal/Discontinue","Student Transfer-In-Process","Course Completion","Casual","Reject & Rejoin","NFT","NFT-Extended","Academic Break","Terminated";
            OptionCaption = ',"Student","Inactive","Provisional Student","Expired","Withdrwal -In- Process","Withdrwal/Discontinue","Student Transfer-In-Process","Course Completion","Casual","Reject & Rejoin","NFT","NFT-Extended","Academic Break","Terminated"';
            FieldClass = FlowField;
            CalcFormula = Lookup("Student Master-CS"."Student Status" WHERE("No." = FIELD("No.")));
            Description = 'CS Field Added 02-05-2019';
            Editable = false;


        }
        field(33048927; Gender; Option)
        {
            Caption = 'Gender';
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33048928; Session; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = Session;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33048929; "Hostel Accomadation"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33048930; "Transport Accomadation"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33048931; "Student Mother Name"; Text[150])
        {
            Description = 'CS Field Added 02-05-2019';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33048932; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33048934; "Fee Classification Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Fee Classification Master-CS";
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                IF "Fee Classification Code" = 'FOREIGN/NRI' THEN BEGIN
                    VALIDATE("Gen. Bus. Posting Group", 'FOREIGN');
                    VALIDATE("Customer Posting Group", 'FORGN/NRI');
                    VALIDATE("VAT Bus. Posting Group", 'NO VAT');
                END;
                IF "Fee Classification Code" = 'GENERAL' THEN BEGIN
                    VALIDATE("Gen. Bus. Posting Group", 'DOMESTIC');
                    VALIDATE("Customer Posting Group", 'GENERAL');
                    VALIDATE("VAT Bus. Posting Group", 'NO VAT');
                END;
                IF "Fee Classification Code" = 'NRI SPECIAL' THEN BEGIN
                    VALIDATE("Gen. Bus. Posting Group", 'DOMESTIC');
                    VALIDATE("Customer Posting Group", 'FORGN/NRI');
                    VALIDATE("VAT Bus. Posting Group", 'NO VAT');
                END;
            end;
        }
        field(50188; "Tuition Balance"; Decimal)
        {
            Caption = 'Tuition Balance';
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"), "Currency Code" = field("Currency Filter"), "Initial Entry Global Dim. 2" = filter('')));
            Editable = false;
        }
        field(50189; "Grenville Balance"; Decimal)
        {
            Caption = 'Grenville Balance';
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = filter('9300'), "Currency Code" = field("Currency Filter")));
            Editable = false;
        }
        field(50190; "AUA Housing Balance"; Decimal)
        {
            Caption = 'AUA Housing Balance';
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = filter('9500'), "Currency Code" = field("Currency Filter")));
            Editable = false;
        }
        field(50191; "Postal Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(50192; Cities; Text[30])
        {
            DataClassification = CustomerContent;
        }


    }
    keys
    {
        key(Key1; "Enrollment No.")
        {
        }
    }
}


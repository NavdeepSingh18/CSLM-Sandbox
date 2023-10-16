table 50379 "CLN Billing Reversal Detail"
{
    Caption = 'Clinical Billing Reversal Detail';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            var
                StudentMasterCS: Record "Student Master-CS";
            begin
                "Student Name" := '';
                "Enrollment No." := '';
                "Academic Year" := '';
                Semester := '';
                StudentMasterCS.Reset();
                if StudentMasterCS.Get("Student No.") then begin
                    "Student Name" := StudentMasterCS."Student Name";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Academic Year" := StudentMasterCS."Academic Year";
                    Semester := StudentMasterCS.Semester;
                end;
            end;
        }
        field(7; "Student Name"; Text[150])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(15; "Fee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            var
                FeeComponentMaster: Record "Fee Component Master-CS";
            begin
                "Fee Description" := '';
                FeeComponentMaster.Reset();
                if FeeComponentMaster.Get("Fee Code") then begin
                    "Fee Description" := FeeComponentMaster.Description;

                    if FeeComponentMaster."Type Of Fee" = FeeComponentMaster."Type Of Fee"::"FIU SURCHARGE" then
                        "FIU Surcharge" := true;
                end;
            end;
        }
        field(16; "Fee Description"; Text[150])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "G/L Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            var
                Customer: Record Customer;
                GLAcc: Record "G/L Account";
            begin
                if "Account Type" = "Account Type"::Customer then begin
                    "G/L Account Name" := '';
                    Customer.Reset();
                    if Customer.Get("G/L Account No.") then
                        "G/L Account Name" := Customer.Name;
                end;

                if "Account Type" = "Account Type"::"G/L Account" then begin
                    "G/L Account Name" := '';
                    GLAcc.Reset();
                    if GLAcc.Get("G/L Account No.") then
                        "G/L Account Name" := GLAcc.Name;
                end;
            end;
        }
        field(18; "G/L Account Name"; Text[150])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(21; "Financial Aid Approved"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Aid Approved';
        }
        field(25; "Invoice Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Amount to Reverse"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(27; "Reversal Weeks"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(28; "FIU Surcharge"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(29; "Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Posted No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}
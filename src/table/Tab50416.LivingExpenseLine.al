table 50416 "Living Expense Line"
{
    Caption = 'Living Expense Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            Editable = false;
        }
        field(2; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student ID';
            Editable = false;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
                LivingExpenseLine: Record "Living Expense Line";
                LastEntryNo: Integer;
            begin
                "Student Name" := '';
                "Enrollment No." := '';
                "Academic Year" := '';
                Semester := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then begin
                    "Student Name" := StudentMaster."Student Name";
                    "Enrollment No." := StudentMaster."Enrollment No.";
                    "Academic Year" := StudentMaster."Academic Year";
                    Semester := StudentMaster.Semester;
                    Term := StudentMaster.Term;
                end;

                LastEntryNo := 0;
                LivingExpenseLine.Reset();
                LivingExpenseLine.SetRange("Student ID", "Student ID");
                LivingExpenseLine.SetRange("Document No.", "Document No.");
                if LivingExpenseLine.FindLast() then
                    LastEntryNo := LivingExpenseLine."Entry No.";

                "Entry No." := LastEntryNo + 1;
            end;
        }
        field(3; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = false;
        }
        field(4; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(5; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(6; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            Editable = false;
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(7; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS".Code;
        }
        field(8; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            Editable = false;
            OptionMembers = " ",Invoice,Payment,Refund,"Credit Note",Application;
        }
        field(9; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(10; "Entry Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Document No.';
            Editable = false;
        }
        field(12; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
            Editable = false;
        }
        field(13; "G/L Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Entry No.';
            Editable = false;
        }
        field(14; "Cust. Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cust. Ledger Entry No.';
            Editable = false;
        }
        field(15; "DCLE Application Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'DCLE Application Entry No.';
            Editable = false;
        }
        field(16; "Application Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Entry No.';
            Editable = false;
        }
        field(20; "G/L Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Account No.';
            Editable = false;
        }
        field(21; "G/L Account Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Account Name';
            Editable = false;
        }
        field(22; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
        field(23; "Fee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Code';
            Editable = false;
            trigger OnValidate()
            var
                FeeComponent: Record "Fee Component Master-CS";
            begin
                "Fee Description" := '';
                "Fee Group" := "Fee Group"::" ";
                "Fee Type" := "Fee Type"::" ";
                FeeComponent.Reset();
                if FeeComponent.Get("Fee Code") then begin
                    "Fee Description" := FeeComponent.Description;
                    "Fee Group" := FeeComponent."Fee Group";
                    "Fee Type" := FeeComponent."Type Of Fee";

                    if ("Fee Type" <> "Fee Type"::Rent) and ("Global Dimension 2 Code" <> '') then
                        "Fee Type" := "Fee Type"::Housing;
                end;
            end;
        }
        field(24; "Fee Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Description';
            Editable = false;
        }
        field(25; "Fee Group"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Group';
            OptionCaption = ' ,Non-Institutional,Institutional';
            OptionMembers = " ","Non-Institutional",Institutional;
            Editable = false;
        }
        field(26; "Fee Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Type';
            OptionMembers = " ",HealthInsurance,Repatins,Rent,"Bus-Semester",Tuition,Damage,"Installment Fee","Parking Fee","Re-Registration Fee","Duplicate ID Card Fee","Official Transcript Fee","Non-Official Transcript Fee","Bhhs Degree Fee","Course Completion Certificate Fee","No-Objection Certificate Fee","Spouse ID Card Fee",GHTSurcharge,Other_1,Other_2,Housing;
        }
        field(27; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Type';
            OptionMembers = "Past Balance","Seat Deposit","Housing Deposit","Institutional","Non-Institutional","Grad Plus","Unsubsidized","Student Payment",Rent,Fine,Scholarship,Grant,"T4 Advance","T4 Stipend Payment Advance","Seat Deposit Refund","Rent Transfer Refund","Rent Transfer Payment","T4 Stipend Payment","Refund of Student Payment";
        }
        field(28; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(29; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(30; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            Editable = false;
        }
        field(31; "Remaining Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(32; "Applied Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Applied Amount';
            Editable = false;
        }
        field(33; "Provisional Remaining Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Provisional Remaining Amount';
            Editable = false;
        }
        field(34; "Posting Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Amount';
            trigger OnValidate()
            begin
                if (Amount > 0) and ("Posting Amount" < 0) then
                    Error('Posting Amount must be "Positive".');
                if (Amount < 0) and ("Posting Amount" > 0) then
                    Error('Posting Amount must be in "Negative".');
            end;
        }
        field(35; "Posted Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Amount';
        }
        field(36; "Applied Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applied Document No.';
            Editable = false;
        }
        field(37; "Receipt Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Type';
            Editable = false;
            OptionMembers = " ","Non-Financial Aid","Financial Aid";
        }
        field(38; "Deposit Type"; Option)
        {
            Caption = 'Deposit Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Seat Deposit,Housing Deposit';
            OptionMembers = " ","Seat Deposit","Housing Deposit";
        }
        field(39; "Refund Type"; Option)
        {
            Caption = 'Refund Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Seat Deposit","GV Transfer","T4 Stipend Payment","Student Payment";
        }
        field(43; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
            OptionMembers = "Posted Entries","Pending for Approval","Approved";
        }
        field(44; "View Part"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'View Part';
            Editable = false;
            OptionMembers = "Posted Entries","Application Entries","Posting Entries","Past Application","Housing Application";
        }
    }

    keys
    {
        key(PK; "Student ID", "Document No.", "Entry No.")
        {
            Clustered = true;
        }
        key(Sorting_1; "Student ID", "Document No.", "Entry Type")
        {
            Clustered = false;
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
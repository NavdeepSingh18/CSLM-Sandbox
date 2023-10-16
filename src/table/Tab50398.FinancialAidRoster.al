table 50398 "Financial Aid Roster"
{

    Caption = 'Financial Aid Roster';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No"';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(4; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            Var
                StudentRec: Record "Student Master-CS";
            begin
                StudentRec.Reset();
                StudentRec.SetRange("No.", "Student No.");
                IF StudentRec.FindFirst() then begin
                    Semester := StudentRec.Semester;
                    "Academic Year" := StudentRec."Academic Year";
                    Course := StudentRec."Course Code";
                    Year := StudentRec.Year;
                    "Enrollment No." := StudentRec."Enrollment No.";
                    "Global Dimension 1 Code" := StudentRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := StudentRec."Global Dimension 2 Code";
                end else begin
                    Semester := '';
                    "Academic Year" := '';
                    Course := '';
                    Year := '';
                    "Enrollment No." := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                end;

            end;
        }
        field(5; "Fund Type"; Option)
        {
            Caption = 'Fund Type';
            OptionCaption = ' ,FDSL-Plus,FDSL-Unsub';
            OptionMembers = " ","FDSL-Plus","FDSL-Unsub";
            DataClassification = CustomerContent;
        }
        field(6; "Uploaded Amount"; Decimal)
        {
            Caption = 'Uploaded Amount';
            DataClassification = CustomerContent;
        }
        field(7; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; Semester; Code[10])
        {
            TableRelation = "Semester Master-CS";
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "User ID"; Text[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Approved/Rejected On"; Date)
        {
            Caption = 'Approved/Rejected On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Approved/Rejected By"; Code[50])
        {
            Caption = 'Approved/Rejected By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; Status; Option)
        {
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
        }
        field(18; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;
        }
        field(19; "Rejection Remarks"; Text[250])
        {
            Caption = 'Rejection Remarks';
            DataClassification = CustomerContent;
        }
        field(20; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }

        field(21; "Applies to Doc. Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Applies to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;

        }
        field(22; "Applies to Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies to Doc. No.';
        }
    }
}
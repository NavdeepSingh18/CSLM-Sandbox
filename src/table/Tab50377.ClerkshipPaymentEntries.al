table 50377 "Clerkship Payment Ledger Entry"
{
    DataClassification = CustomerContent;
    Caption = 'Clerkship Payment Ledger Entry';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Type';
            OptionMembers = " ",Invoice,Payment,"Invoice Reversal","Payment Reversal";
        }
        field(4; "Rotation Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Entry No.';
        }
        field(5; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation ID';
        }
        field(6; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital ID';
        }
        field(7; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
            Editable = false;
        }
        field(8; "Student ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student ID';
        }
        field(9; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
        }
        field(10; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
        }
        field(11; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
        }
        field(12; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
        }
        field(13; "Enrollment No."; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
        }
        field(14; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }

        field(15; "Student Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Course Code';
            TableRelation = "Course Master-CS";
        }
        field(16; "Student Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Course Description';
        }
        field(17; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = "Subject Master-CS".Code;
            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                "Course Description" := '';
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.FindFirst() then
                    "Course Description" := SubjectMaster.Description;
            end;
        }
        field(18; "Course Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
        }
        field(19; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
            Editable = false;
            TableRelation = "Subject Master-CS".Code;
        }
        field(20; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
            Editable = false;
        }
        field(21; "Course Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }
        field(30; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(31; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Semester Master-CS".Code;
        }
        field(32; "Total No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. of Weeks';
        }
        field(33; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(34; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(35; "Weeks Completed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Completed';
        }
        field(36; "Estimated Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Rotation Cost';
            trigger OnValidate()
            begin
                "Total Estd. Rotation Cost" := "Total No. of Weeks" * "Estimated Rotation Cost";
            end;
        }
        field(37; "Total Estd. Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Estd. Rotation Cost';
            Editable = false;
        }
        field(38; "Valid Rotation"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Valid Rotation';
        }

        field(39; "Weeks Invoiced"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Invoiced';
        }
        field(40; "Weeks Paid"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Paid';
        }
        field(41; "Actual Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Rotation Cost';
            trigger OnValidate()
            begin
                "Total Actual Rotation Cost" := "Actual Rotation Cost" * "Total No. of Weeks";
            end;
        }
        field(42; "Total Actual Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Actual Rotation Cost';
            Editable = false;
        }
        field(43; "Invoice No."; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice No.';
        }

        field(45; "Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Date';
        }
        field(46; "Check No."; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Check No.';
        }

        field(49; "Check Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Check Date';
        }
        field(50; "Check No. Updated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Check No. Updated';
        }
        field(51; "Weeks to Pay"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks to Pay';
            DecimalPlaces = 0;
        }
        field(60; "Changed Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Changed Reason Code';
        }
        field(61; "Changed Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Changed Reason Description';
        }
        field(62; "Changed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Changed By';
        }
        field(63; "Changed On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Changed On';
        }
        field(66; "Request of Cancellation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Request of Cancellation';
            OptionMembers = " ","Cancellation Request Raised","Cancellation Request Approved","Cancellation Request Rejected";
        }
        field(67; "Cancellation Request Raised By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Request Raised By';
        }
        field(68; "Cancellation Request Raised On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Request Raised On';
        }
        field(69; "Cancellation Request Status By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Request Status By';
        }
        field(70; "Cancellation Request Status On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Request Status On';
        }
        field(71; "Cancel Request Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Request Reason Code';
        }
        field(72; "Cancel Request Reason Desc"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Request Reason Description';
        }
        field(73; Reversed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Reversed';
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
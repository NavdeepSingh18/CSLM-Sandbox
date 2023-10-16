table 50511 "Withdrawal Student Subject"
{
    DataClassification = CustomerContent;
    Caption = 'Withdraw Student Subject';
    fields
    {
        field(1; "Withdrawal Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Withdrawal Request No.';
        }
        field(2; "Subject Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subject Code';
            TableRelation = "Main Student Subject-CS"."Subject Code" where("Student No." = field("Student No."));
            trigger OnValidate()
            var
                SubjectMaster_lRec: Record "Subject Master-CS";
                WithdrawalStudentRec: Record "Withdrawal Student-CS";
            begin
                SubjectMaster_lRec.Reset();
                SubjectMaster_lRec.SetRange(Code, "Subject Code");
                IF SubjectMaster_lRec.FindFirst() then
                    "Subject Name" := SubjectMaster_lRec.Description;

                WithdrawalStudentRec.Get("Withdrawal Request No.");
                Validate("Student No.", WithdrawalStudentRec."Student No.");
            end;
        }
        field(3; "Subject Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subject Name';
            Editable = false;
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            var
                StudentMaster_lRec: Record "Student Master-CS";
            begin
                StudentMaster_lRec.RESET();
                StudentMaster_lRec.SetRange("No.", "Student No.");
                IF StudentMaster_lRec.FindFirst() then
                    "Student Name" := StudentMaster_lRec."Name as on Certificate";

            end;
        }
        field(5; "Student Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student Name';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Withdrawal Request No.", "Student No.", "Subject Code")
        {
            Clustered = true;
        }
    }

}
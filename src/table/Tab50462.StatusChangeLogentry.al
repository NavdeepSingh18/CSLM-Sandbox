table 50462 "Status Change Log entry"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Student Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Status change From"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Status change to"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Modified by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Modified On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Reason Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(13; "Reason Description"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Begin Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Comment"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "NSLDS Withdrawal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "AdEnrollStuNum"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "AdTermCode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(17; "Date Of Determination"; Date)
        {
            Caption = 'Date of Determination';
            DataClassification = ToBeClassified;
        }
        field(18; "Last Date Of Attendance"; Date)
        {
            Caption = 'Last Date Of Attendance';
            DataClassification = ToBeClassified;
        }
        Field(19; "Current Semester"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".Semester where("No." = field("Student No.")));
            Editable = false;
        }
        field(20; "Current Status"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".Status where("No." = Field("Student No.")));
            Editable = false;
        }

        Field(21; "Dismissal Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(22; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
        key(Key2; "Modified On")
        {
        }
    }
    procedure InsertRecordfun(StudNOPara: Code[20]; StudNamePara: Text[80]; StatusChangeFromPara: Code[20]; StatusChangeToPara: Code[20]; ModifiedByPara: Code[50]; ModifiedOnPara: Date;
    ReasonCode: Code[10]; ReasonDesc: Text[2048]; Comment: Text[255]; NSDLWithdrawalDate: Date; DateofDetermination: Date; LastDateofAttendance: Date; EffectiveDate: Date; BeginDate: Date; DismissalDate: Date)
    var
        StatusChangeLog: Record "Status Change Log entry";
        StatusChangeLog1: Record "Status Change Log entry";
    begin
        StatusChangeLog1.Reset();
        IF StatusChangeLog1.FindLast() then;

        StatusChangeLog.Init();
        StatusChangeLog.Validate("Student No.", StudNOPara);
        StatusChangeLog.Validate("Student Name", StudNamePara);
        StatusChangeLog.Validate("Status change From", StatusChangeFromPara);
        StatusChangeLog.Validate("Status change to", StatusChangeToPara);
        StatusChangeLog.Validate("Modified By", ModifiedByPara);
        StatusChangeLog.Validate("Modified on", ModifiedOnPara);
        StatusChangeLog.Validate("Reason Code", ReasonCode);
        StatusChangeLog.Validate("Reason Description", ReasonDesc);
        StatusChangeLog.Validate(Comment, Comment);
        StatusChangeLog.Validate("NSLDS Withdrawal Date", NSDLWithdrawalDate);
        StatusChangeLog.Validate("Date Of Determination", DateofDetermination);
        StatusChangeLog.Validate("Last Date Of Attendance", LastDateofAttendance);
        StatusChangeLog.Validate("Begin Date", BeginDate);
        StatusChangeLog.Validate("Effective Date", EffectiveDate);
        StatusChangeLog.Validate("Dismissal Date", DismissalDate);
        StatusChangeLog."Entry No" := StatusChangeLog1."Entry No" + 1;
        StatusChangeLog.Insert();
    end;



    trigger OnDelete()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(UserId());
        IF not UserSetup."Status Change Log Allowed" THEN
            Error('You are not authorized');

    end;




}
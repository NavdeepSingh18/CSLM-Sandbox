table 50214 "Rotation Cancellation Appln"
{
    DataClassification = CustomerContent;
    Caption = 'Rotation Cancellation Applications';

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Roster Scheduling Line"."Rotation ID" where("Student No." = field("Student No."), Status = filter(Published | Scheduled));
            trigger OnValidate()
            begin
                UpdateValues();
            end;
        }
        field(3; "Rotation No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No." where(Semester = field("Clerkship Semester Filter"));

            trigger OnValidate()
            begin
                UpdateValues();
            end;
        }
        field(5; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            Editable = false;
        }
        field(6; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            Editable = false;
        }
        field(7; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            Editable = false;
        }
        field(8; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(9; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(10; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
            Editable = false;
        }
        field(11; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
            Editable = false;
        }
        field(12; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            Editable = false;
        }
        field(17; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(18; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
            Editable = false;
        }
        field(19; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
            Editable = false;
        }
        field(15; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Weeks';
            Editable = false;
        }
        field(22; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }

        field(23; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }

        field(24; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital ID';
            Editable = false;
        }
        field(25; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
            Editable = false;
        }
        field(26; "Coordinator ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Coordinator ID';
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(47; "Cancel Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter("Rotation Cancellation"));

            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                "Cancel Reason Description" := '';
                ReasonCode.Reset();
                if ReasonCode.Get("Cancel Reason Code") then
                    "Cancel Reason Description" := ReasonCode.Description;
            end;
        }
        field(48; "Cancel Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Reason Description';
        }
        field(55; "Course Prefix Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Prefix Code';
            Editable = false;
        }
        field(400; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;
        }
        field(401; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;
        }
        field(402; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = " ","Pending for Approval",Approved,Rejected;
            Editable = false;

            trigger OnValidate()
            begin
                "Status By" := UserId;
                "Status On" := Today;
            end;
        }
        field(403; "Status By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Status By';
            Editable = false;
        }
        field(404; "Status On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Status By';
            Editable = false;
        }

        field(420; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
        }
        field(60000; "Clerkship Semester Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }
        field(60001; "Filtering ID"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    var
        EducationSetup: Record "Education Setup-CS";
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Rotation Cancel Appln Nos.");
        NoSeriesManagement.InitSeries(EducationSetup."Rotation Cancel Appln Nos.", xRec."No. Series", 0D, "Application No.", "No. Series");
        "Created By" := UserId;
        "Created On" := Today;
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

    procedure UpdateValues()
    var
        StudentMasterCS: Record "Student Master-CS";
        RSL: Record "Roster Scheduling Line";
    begin
        "First Name" := '';
        "Middle Name" := '';
        "Last Name" := '';
        "Student Name" := '';
        "Enrollment No." := '';
        "Coordinator ID" := '';
        Semester := '';
        "Rotation No." := 0;

        StudentMasterCS.Reset();
        if StudentMasterCS.Get("Student No.") then begin
            "First Name" := StudentMasterCS."First Name";
            "Middle Name" := StudentMasterCS."Middle Name";
            "Last Name" := StudentMasterCS."Last Name";
            "Student Name" := StudentMasterCS."Student Name";
            "Enrollment No." := StudentMasterCS."Enrollment No.";
            "Coordinator ID" := StudentMasterCS."Clinical Coordinator";
            Semester := StudentMasterCS.Semester;
        end;

        "Rotation No." := 0;
        "Clerkship Type" := "Clerkship Type"::" ";
        "Course Code" := '';
        "Course Description" := '';
        "Elective Course Code" := '';
        "Rotation Description" := '';
        "Course Prefix Code" := '';
        "Start Date" := 0D;
        "End Date" := 0D;
        "No. of Weeks" := 0;

        RSL.Reset();
        RSL.SetRange("Rotation ID", "Rotation ID");
        RSL.SetRange("Student No.", "Student No.");
        RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
        if RSL.FindLast() then begin
            "Rotation No." := RSL."Rotation No.";
            "Clerkship Type" := RSL."Clerkship Type";
            "Course Code" := RSL."Course Code";
            "Course Description" := RSL."Course Description";
            "Elective Course Code" := RSL."Elective Course Code";
            "Rotation Description" := RSL."Rotation Description";
            "Course Prefix Code" := RSL."Course Prefix Code";
            "Start Date" := RSL."Start Date";
            "End Date" := RSL."End Date";
            "No. of Weeks" := RSL."No. of Weeks";
            "Hospital ID" := RSL."Hospital ID";
            "Hospital Name" := RSL."Hospital Name";
        end;
    end;
}
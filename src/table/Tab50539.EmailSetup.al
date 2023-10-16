table 50539 "EMail Setup"
{
    DataClassification = CustomerContent;
    // DrillDownPageId = "Email Setup Lists";
    // LookupPageId = "Email Setup Lists";
    Caption = 'Employee Email Alert Setup';

    fields
    {
        field(1; "Department Type"; Option)
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bursar,Financial Aid,Residential Services,Student Services,Registrar,Admissions,Clinicals,EED Pre-Clinical,EED Clinical,Graduate Affairs,Examination,Graduation,BackOffice,Store';
            OptionMembers = " ","Bursar Department","Financial Aid Department","Residential Services","Student Services","Registrar Department","Admissions","Clinical Details","EED Pre-Clinical","EED Clinical","Graduate Affairs","Examination","Graduation",BackOffice,Store;

        }
        field(2; "Employee No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if EmployeeRec.Get("Employee No.") then
                    Rec."Employee Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Email Alert Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Advising Module","Teaching Assistance","Form Uploads";

            // " ,Advising Request from Student,Advising Request from Faculty/Chair,Request Approval from Student,Request Approval from Faculty/Chair,Request Rejection from Student,Request Rejection from Faculty/Chair,Request Rescheduled from Faculty/Chair,Request Completion from Student,Request Completion from Faculty/Chair,Check Request Creation,Check Request Approval,Check Request Rejection,Form Upload";
        }
        field(7; "Email Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Created On"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Modified On"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Department Type", "Employee No.", "Email Alert Type")
        {
            Clustered = true;
        }
    }
    var
        EmployeeRec: Record Employee;

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
    end;
}
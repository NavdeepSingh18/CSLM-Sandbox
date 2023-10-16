table 50196 "Student Advisor Details"
{
    DrillDownPageId = "Student Advisor Detail";
    LookupPageId = "Student Advisor Detail";
    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = Customercontent;
            TableRelation = "Student Master-CS";

            Trigger OnValidate()
            var
                StudentMaster_lRec: Record "Student Master-CS";
            Begin
                If "Student No." <> '' then begin
                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetRange("No.", "Student No.");
                    If StudentMaster_lRec.FindFirst() then
                        "Student Name" := StudentMaster_lRec."Student Name";
                end Else
                    "Student Name" := '';
            End;

        }
        field(2; "Advisor No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                EmployeeMaster_lRec: Record Employee;
            begin
                If "Advisor No." <> '' then begin
                    EmployeeMaster_lRec.Reset();
                    EmployeeMaster_lRec.Setrange("No.", "Advisor No.");
                    If EmployeeMaster_lRec.FindFirst() then
                        "Advisor Name" := EmployeeMaster_lRec."First Name" + ' ' + EmployeeMaster_lRec."Last Name";
                end Else
                    "Advisor Name" := '';
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Advisor Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; Updated; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Advisor No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId();
        "Created On" := Today();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Updated By" := UserId();
        "Updated On" := Today();
        Inserted := true;

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
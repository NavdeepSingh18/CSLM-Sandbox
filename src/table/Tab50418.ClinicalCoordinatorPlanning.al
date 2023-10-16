table 50418 "Clinical Coordinator Planning"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Role; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Document Specialist","FM1/IM1 Coordinator","Clerkship Coordinator";
            Caption = 'Role';

            trigger OnValidate()
            begin
                CheckDuplicateRange();
                ;
            end;
        }
        field(3; "Start Alpha Range"; Code[1])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CheckDuplicateRange();
                ;
            end;
        }
        field(4; "End Alpha Range"; Code[1])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CheckDuplicateRange();
                ;
            end;
        }
        field(5; "User ID"; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';
            trigger OnValidate()
            begin
                CheckDuplicateRange();
                ;
            end;
        }
        field(6; "User Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'User Name';
            trigger OnValidate()
            begin
                CheckDuplicateRange();
            end;
        }
        field(7; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Active,Inactive;
            trigger OnValidate()
            begin
                CheckDuplicateRange();
                ;
            end;
        }
        field(8; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(9; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    Trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        IF xRec.Updated = Updated then
            Updated := true;
    end;

    procedure CheckDuplicateRange()
    var
        Users: Record User;
        ClinicalCoordinatorPlanning: Record "Clinical Coordinator Planning";
    begin
        Users.Reset();
        Users.SetRange("User Name", "User ID");
        if Users.FindFirst() then
            "User Name" := Users."Full Name";

        ClinicalCoordinatorPlanning.Reset();
        ClinicalCoordinatorPlanning.SetRange(Role, Role);
        ClinicalCoordinatorPlanning.SetRange(Status, ClinicalCoordinatorPlanning.Status::Active);
        ClinicalCoordinatorPlanning.SetFilter("Entry No.", '<>%1', "Entry No.");
        if ClinicalCoordinatorPlanning.FindSet() then
            repeat
                if ("Start Alpha Range" >= ClinicalCoordinatorPlanning."Start Alpha Range") and ("End Alpha Range" <= ClinicalCoordinatorPlanning."End Alpha Range") then
                    Error('%1 No. Alpha Range already exist with Start Alpha Range: %2.\End Alpha Range %3.', ClinicalCoordinatorPlanning."Entry No.", ClinicalCoordinatorPlanning."Start Alpha Range", ClinicalCoordinatorPlanning."End Alpha Range");
            until ClinicalCoordinatorPlanning.Next() = 0;
    end;

    procedure ViewStudentsWithUserList()
    var
        StudentMaster: Record "Student Master-CS";
    // StudentsWithClinicalUsers: Page "Students With Clinical Users";
    begin
        // Clear(StudentsWithClinicalUsers);

        if Role = Role::"Document Specialist" then begin
            StudentMaster.Reset();
            StudentMaster.FilterGroup(2);
            StudentMaster.SetRange("Document Specialist", "User ID");
            StudentMaster.FilterGroup(0);
            // StudentsWithClinicalUsers.SetVariable(true, false, false);
        end;
        if Role = Role::"FM1/IM1 Coordinator" then begin
            StudentMaster.Reset();
            StudentMaster.FilterGroup(2);
            StudentMaster.SetRange("FM1/IM1 Coordinator", "User ID");
            StudentMaster.FilterGroup(0);
            // StudentsWithClinicalUsers.SetVariable(false, true, false);
        end;
        if Role = Role::"Clerkship Coordinator" then begin
            StudentMaster.Reset();
            StudentMaster.FilterGroup(2);
            StudentMaster.SetRange("Clinical Coordinator", "User ID");
            StudentMaster.FilterGroup(0);
            // StudentsWithClinicalUsers.SetVariable(true, false, false);
        end;

        // StudentsWithClinicalUsers.SetTableView(StudentMaster);
        // StudentsWithClinicalUsers.RunModal();
    end;
}
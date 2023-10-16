tableextension 50562 "tableextensionEmployee" extends Employee
{
    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019    Employee Group - OnValidate       Code added for Validate Employee Group Field.
    // 2         CSPL-00136    02-05-2019    No. - OnValidate                 Code added for Assign Value in Field.
    // 3         CSPL-00136    02-05-2019    OnModify                         Code added for Assign Value in Field.
    // 4         CSPL-00136    02-05-2019    PortalUser                       Code added for Portal User Login CS Table Update.
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                "Web Portal Password" := "No.";
                "Web portal Access" := TRUE;
            END;

        }

        field(50006; "Location Code"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = Location;
            Caption = 'Location Code';
            DataClassification = CustomerContent;

        }
        field(50008; "Full Name"; Text[60])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Full Name';
            DataClassification = CustomerContent;
        }
        field(50010; "Job Title/Grade"; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Job Title/Grade';
            DataClassification = CustomerContent;
        }
        field(50035; "Employee Machine Code"; Text[15])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Employee Machine Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EmployeeMacgineMaster: Record "Employee Absence";
                EmployeeMacgineMasterInsert: Record "Employee Absence";
            begin
                EmployeeMacgineMaster.Reset();
                EmployeeMacgineMaster.SETRANGE(EmployeeMacgineMaster."Employee No.", "No.");
                IF NOT EmployeeMacgineMaster.FindFirst() THEN BEGIN
                    EmployeeMacgineMasterInsert.Reset();
                    EmployeeMacgineMasterInsert.INIT();
                    EmployeeMacgineMasterInsert."Employee No." := "No.";
                    EmployeeMacgineMasterInsert.INSERT();
                END;
            end;
        }
        field(50037; "Shift Pattern"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = 'Fixed,Weekly,Monthly';
            OptionMembers = "Fixed",Weekly,Monthly;
            Caption = 'Shift Pattern';
            DataClassification = CustomerContent;

        }
        field(50038; "Shift Code only Fixed Shift"; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Shift Code only Fixed Shift';
            DataClassification = CustomerContent;
        }
        field(50039; "Weekly Off only Fixed Shift"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';
            OptionMembers = " ",Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
            Caption = 'Weekly Off only Fixed Shift';
            DataClassification = CustomerContent;
        }
        field(50045; "Start In"; Integer)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Start In';
            DataClassification = CustomerContent;
        }
        field(50046; "End Out"; Integer)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'End Out';
            DataClassification = CustomerContent;
        }
        field(50048; "Company Holiday Allowed"; Option)
        {
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = 'Yes,No';
            OptionMembers = Yes,No;
            Caption = 'Company Holiday Allowed';
            DataClassification = CustomerContent;
        }
        field(50057; HOD; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = Employee."No.";
            Caption = 'HOD';
            DataClassification = CustomerContent;

        }
        field(50058; "Job Title/Grade Desc"; Text[50])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Job Title/Grade Desc';
            DataClassification = CustomerContent;
        }
        field(50061; "HOD Name"; Text[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'HOD Name';
            DataClassification = CustomerContent;
        }
        field(50071; "Branch Name"; Text[50])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'Branch Name';
            DataClassification = CustomerContent;
        }
        field(50122; "HOD 1"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = Employee."No.";
            Caption = 'HOD 1';
            DataClassification = CustomerContent;

        }
        field(50123; "HOD Name 1"; Text[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Editable = false;
            Caption = 'HOD Name 1';
            DataClassification = CustomerContent;
        }
        field(50126; "Designation Code"; Text[100])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Designation Code';
            DataClassification = CustomerContent;

        }
        field(50147; "Employee Posting Group New"; Code[10])
        {
            Caption = 'Employee Posting Group New';
            Description = 'CS Field Added 02-05-2019';
            NotBlank = true;
            DataClassification = CustomerContent;

        }
        field(50148; "Deparment Name"; Text[80])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Department Name';
            DataClassification = CustomerContent;
        }
        field(50149; "Employee Group"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "User Group-CS";
            Caption = 'Employee Group';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Employee Group Field::CSPL-00136::02-05-2019: Start
                IF ("Employee Group" <> xRec."Employee Group") and ("Employee Group" <> '') THEN BEGIN
                    RecPortalUserLoginCS.Reset();
                    RecPortalUserLoginCS.SETRANGE(U_ID, Rec."No.");
                    RecPortalUserLoginCS.SETRANGE(RecPortalUserLoginCS.Type, RecPortalUserLoginCS.Type::Employee);
                    IF RecPortalUserLoginCS.FINDFIRST() THEN BEGIN
                        RecPortalUserLoginCS.Updated := TRUE;
                        Updated := TRUE;
                        RecPortalUserLoginCS."User Group" := "Employee Group";
                        RecPortalUserLoginCS."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        RecPortalUserLoginCS."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        InstituteRoleCS.Reset();
                        InstituteRoleCS.SETRANGE("Role Name", PortalUserLoginCS."User Group");
                        IF InstituteRoleCS.FINDFIRST() THEN
                            RecPortalUserLoginCS.Role_Code := InstituteRoleCS."Role Code";
                        RecPortalUserLoginCS.IsAdmin := FALSE;
                        RecPortalUserLoginCS.UserName := "First Name";
                        RecPortalUserLoginCS."Created By" := FORMAT(UserId());
                        RecPortalUserLoginCS."Created On" := TODAY();
                        RecPortalUserLoginCS.Modify();
                    END ELSE begin
                        PortalUserCS();
                        WebServicesFunctionsCS.EmployeeCreation(Rec);
                    end;
                END;
                //Code added for Assign Value in Employee Group Field::CSPL-00136::02-05-2019: End
            end;
        }
        field(50150; "Mobile Insert"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(50151; "Mobile Update"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
        }
        field(50152; "Faculty Category"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Faculty Category";
            Trigger OnValidate()
            var
                FacultyCategoryRec: Record "Faculty Category";
            begin
                if FacultyCategoryRec.Get("Faculty Category") then
                    "Faculty Category Description" := FacultyCategoryRec."Category Description"
                else
                    "Faculty Category Description" := '';
            end;
        }
        field(50153; "Faculty Category Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50154; "Cancel Class Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50155; "Reschedule Class Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50156; "Azure Service Link"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        Field(50157; "Delete Class Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60003; State; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            //TableRelation = State;
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(60020; "Emergency Contact Person"; Text[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Emergency Contact Person';
            DataClassification = CustomerContent;
        }
        field(60021; "Emergency Phone No."; Code[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Emergency Phone No.';
            DataClassification = CustomerContent;
        }
        field(60036; "Web Portal Password"; Text[30])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Web Portal Password';
            DataClassification = CustomerContent;
        }
        field(70075; "Web portal Access"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Web Portal Access';
            DataClassification = CustomerContent;
        }
        field(70076; "Web Portal Type"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = 'User,Admin,HR';
            OptionMembers = User,Admin,HR;
            Caption = 'Web Portal Type';
        }
        field(70077; ProfilePhoto; Text[100])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Profile Photo';
            DataClassification = CustomerContent;
        }
        field(70078; Change_PasswordStatus; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Change Password Status';
            DataClassification = CustomerContent;
        }
        field(70079; HR; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = Employee."No.";
            Caption = 'HR';
            DataClassification = CustomerContent;
        }
        field(70080; Finance; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Finance';
            DataClassification = CustomerContent;
        }
        field(70102; "Google Site Link"; Text[70])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Google Site Link';
            DataClassification = CustomerContent;
        }
        field(70103; Updated; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(70104; Inserted; Boolean)
        {
            DataClassification = CustomerContent;

        }
        field(70105; Department; Option)
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bursar,Financial Aid,Residential Services,Student Services,Registrar,Admissions,Clinicals,EED Pre-Clinical,EED Clinical,Graduate Affairs,Examination,Graduation,BackOffice,Verity';
            OptionMembers = " ","Bursar Department","Financial Aid Department","Residential Services","Immigration Department","Registrar Department","Admissions","Clinical Details","EED Pre-Clinical","EED Clinical","Graduate Affairs","Examination","Graduation",BackOffice,Verity;
        }
        Field(70106; "Clinical Chair"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(70107; "Administrative Assistant"; boolean)
        {
            Caption = 'Administrative Assistant';
            DataClassification = CustomerContent;
        }
        field(70108; "Blackboard Synch Status"; Option)//5.6.22//GAURAV//
        {
            OptionMembers = " ",Pending,Completed,Error;
            OptionCaption = ' ,Pending,Completed,Error';
        }
        field(70109; "Synch to Blackboard"; Boolean)
        {
            Caption = 'Synch to Blackboard';

        }
    }

    Trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

    local procedure EmployeeFullName()
    begin
        TESTFIELD("First Name");
        CLEAR("Search Name");

        "Search Name" := "First Name";
        IF ("Last Name" <> '') AND ("Middle Name" = '') THEN
            "Search Name" := "First Name" + ' ' + "Last Name"
        ELSE
            IF ("Last Name" = '') AND ("Middle Name" <> '') THEN
                "Search Name" := "First Name" + ' ' + "Middle Name"
            ELSE
                IF ("Last Name" <> '') AND ("Middle Name" <> '') THEN
                    "Search Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name"
    end;

    procedure PortalUserCS()
    begin

        //Code added for Portal User Login CS Table Update::CSPL-00136::02-05-2019: Start
        PortalUserLoginCS1.Reset();
        IF PortalUserLoginCS1.FINDLAST() THEN
            EntryNo := PortalUserLoginCS1.No + 1
        ELSE
            EntryNo := 1;

        PortalUserLoginCS.Reset();
        PortalUserLoginCS.SETRANGE(U_ID, "No.");
        IF NOT PortalUserLoginCS.FINDSET() THEN
            REPEAT
                PortalUserLoginCS.INIT();
                PortalUserLoginCS.No := EntryNo;
                PortalUserLoginCS.Type := PortalUserLoginCS.Type::Employee;
                // String1 := "E-Mail";
                // Stringpos := STRPOS(String1, '@');
                // Stringleg := STRLEN(String1);
                // ABC := FORMAT(COPYSTR(String1, 1, (Stringpos - 1)));
                // PortalUserLoginCS."Login ID" := FORMAT(ABC);
                PortalUserLoginCS.Password := "Web Portal Password";
                PortalUserLoginCS."User Group" := "Employee Group";
                PortalUserLoginCS."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PortalUserLoginCS."Global Dimension 2 Code" := "Global Dimension 2 Code";
                PortalUserLoginCS.U_ID := "No.";
                InstituteRoleCS.Reset();
                InstituteRoleCS.SETRANGE("Role Name", PortalUserLoginCS."User Group");
                IF InstituteRoleCS.FINDFIRST() THEN
                    PortalUserLoginCS.Role_Code := InstituteRoleCS."Role Code";
                PortalUserLoginCS.WindowsAuthentication := FALSE;
                PortalUserLoginCS.IsAdmin := FALSE;
                PortalUserLoginCS.UserName := "First Name";
                PortalUserLoginCS.MobileNo := "Phone No.";
                PortalUserLoginCS.Email := "Company E-Mail";
                PortalUserLoginCS."Created By" := FORMAT(UserId());
                PortalUserLoginCS."Created On" := TODAY();
                PortalUserLoginCS.INSERT();
                EntryNo += 1;
            UNTIL PortalUserLoginCS.NEXT() = 0;
        //Code added for Portal User Login CS Table Update::CSPL-00136::02-05-2019: End
    end;

    var
        PortalUserLoginCS: Record "Portal User Login-CS";
        PortalUserLoginCS1: Record "Portal User Login-CS";
        InstituteRoleCS: Record "Institute Role-CS";
        RecPortalUserLoginCS: Record "Portal User Login-CS";
        WebServicesFunctionsCS: Codeunit "WebServicesFunctionsCSL";
        EntryNo: Integer;
}


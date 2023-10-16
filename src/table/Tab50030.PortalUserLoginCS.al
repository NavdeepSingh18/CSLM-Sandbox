table 50030 "Portal User Login-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                   Remarks
    // 1         CSPL-00092    02-05-2019    OnModify                  Assign Value in Updated Field
    // 2         CSPL-00092    02-05-2019    Login ID - OnLookup       Assign Value in Login ID Field
    // 3         CSPL-00092    02-05-2019    Password - OnValidate     Update Password in Employee Table
    // 4         CSPL-00092    02-05-2019    Email - OnValidate        Update Email in Employee Table

    Caption = 'Portal Users Login-CS';
    DataPerCompany = false;
    DrillDownPageID = "User Portal Detail-CS";
    LookupPageID = "User Portal Detail-CS";

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Student,Employee,Parent';
            OptionMembers = " ",Student,Employee,Parent;
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(3; "Login ID"; Code[50])
        {
            Caption = 'Login ID';
            TableRelation = IF (Type = CONST(Student)) "Student Master-CS"."Enrollment No."
            ELSE
            IF (Type = CONST(Employee)) Employee."No.";
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Assign Value in Login ID Field::CSPL-00092::02-05-2019: Start
                IF Type = Type::Employee THEN begin
                    IF PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK THEN
                        "Login ID" := Employee."No.";
                END
                ELSE
                    IF Type = Type::Student THEN
                        IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                            "Login ID" := StudentMasterCS."Enrollment No.";

                //Code added for Assign Value in Login ID Field::CSPL-00092::02-05-2019: End
            end;
        }
        field(4; Password; Code[30])
        {
            Caption = 'Password';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Update Password in Employee Table::CSPL-00092::02-05-2019: Start
                Employee.Reset();
                Employee.SETRANGE(Employee."No.", U_ID);
                IF Employee.FINDFIRST() THEN
                    Employee."Web Portal Password" := Password;
                Employee.Modify();
                //Code added for Update Password in Employee Table::CSPL-00092::02-05-2019: Start
            end;
        }
        field(5; "User Group"; Code[20])
        {
            Caption = 'User Group';
            TableRelation = "User Group-CS";
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 06-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50003; U_ID; Code[20])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(50004; Role_Code; Code[20])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Role Code';
            DataClassification = CustomerContent;
        }
        field(50005; WindowsAuthentication; Boolean)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'WindowsAuthentication';
            DataClassification = CustomerContent;
        }
        field(50006; IsAdmin; Boolean)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'IsAdmin';
            DataClassification = CustomerContent;
        }
        field(50007; UserName; Text[100])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'User Name';
            DataClassification = CustomerContent;
        }
        field(50008; MobileNo; Text[30])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Mobile No.';
            DataClassification = CustomerContent;
        }
        field(50009; Email; Text[80])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'E-Mail';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Update Email in Employee Table::CSPL-00092::02-05-2019: Start
                Employee.Reset();
                Employee.SETRANGE(Employee."No.", U_ID);
                IF Employee.FINDFIRST() THEN
                    Employee."E-Mail" := Email;
                Employee.Modify();
                //Code added for Update Email in Employee Table::CSPL-00092::02-05-2019: End
            end;
        }
        field(50010; Image_Path; Text[150])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Image Path';
            DataClassification = CustomerContent;
        }
        field(50011; Extension; Text[20])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Extension';
            DataClassification = CustomerContent;
        }
        field(50012; FileName; Text[50])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(50013; "Created By"; Text[50])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(50014; "Created On"; Date)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(50015; "Updated By"; Text[50])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(50016; "Updated On"; Date)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(50017; "Updated By Name"; Text[50])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(50018; "Created By Name"; Text[50])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
        field(50019; Updated; Boolean)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50020; "Shadow Login"; Boolean)
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'Shadow Login';
            DataClassification = CustomerContent;
        }
        field(50021; SU_ID; Code[20])
        {
            Description = 'CS Field Added 06-05-2019';
            Caption = 'SU_ID';
            DataClassification = CustomerContent;
        }
        field(50022; "Password Changed"; Boolean)
        {
            Caption = 'Password Changed';
            DataClassification = CustomerContent;
        }

        field(50023; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    keys
    {
        //key(Key1; No)
        key(Key1; U_ID)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::02-05-2019: Start
        IF xRec.Updated <> Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::02-05-2019: End
    end;

    var
        Employee: Record Employee;
        StudentMasterCS: Record "Student Master-CS";
}


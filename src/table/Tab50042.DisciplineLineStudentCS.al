table 50042 "Discipline Line Student-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                      User Id Assign in User Id Field.
    // 2         CSPL-00092    03-05-2019    Date Commited - OnValidate    Assign Value in Fields
    // 3         CSPL-00092    03-05-2019    Staff Code - OnValidate       Assign Value in Staff Name Field

    Caption = 'Discipline Line Student-CS';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Class; Code[20])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            Enabled = false;
        }
        field(4; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
            Enabled = false;
        }
        field(5; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(6; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(7; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(9; "Severity Code"; Code[20])
        {
            Caption = 'Severity Code';
            DataClassification = CustomerContent;
            TableRelation = "Discipline Level-CS";
        }
        field(10; "Action Taken"; Code[20])
        {
            Caption = 'Action Taken';
            DataClassification = CustomerContent;
            TableRelation = "College Taken Action-CS";
        }
        field(11; "Remedial Measures"; Text[250])
        {
            Caption = 'Remedial Measures';
            DataClassification = CustomerContent;
        }
        field(12; "Date Commited"; Date)
        {
            Caption = 'Date Commited';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::03-05-2019: Start
                EducationSetupCS.GET();
                EducationSetupCS.TESTFIELD(Company);
                IF EducationSetupCS.Company = EducationSetupCS.Company::College THEN
                    IF StudentMasterCS1.GET("Student No.") THEN BEGIN
                        IF "Type Of Course" = "Type Of Course"::Semester THEN BEGIN
                            Course := StudentMasterCS1."Course Code";
                            Semester := StudentMasterCS1.Semester;
                            Section := StudentMasterCS1.Section;
                            "Academic Year" := StudentMasterCS1."Academic Year";
                        END ELSE
                            Course := StudentMasterCS1."Course Code";
                        Section := StudentMasterCS1.Section;
                        "Academic Year" := StudentMasterCS1."Academic Year";
                    END;
                //Code added for Assign Value in Fields::CSPL-00092::03-05-2019: End
            end;
        }
        field(13; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(14; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Staff Name Field::CSPL-00092::03-05-2019: Start
                IF Employee.GET("Staff Code") THEN
                    "Staff Name" := Employee."First Name";
                //Code added for Assign Value in Staff Name Field::CSPL-00092::03-05-2019: End
            end;
        }
        field(15; "Staff Name"; Text[30])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
        }
        field(16; "Fine Amount"; Decimal)
        {
            Caption = 'Fine Amount';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50015; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50016; "Discipline Classification"; Option)
        {
            Caption = 'Discipline Classification';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            OptionCaption = ' ,Minor Offences,Major Offences-I,Major Offences-II';
            OptionMembers = " ","Minor Offences","Major Offences-I","Major Offences-II";
        }
        field(50017; "Offence Description"; Text[100])
        {
            Caption = 'Offence Description';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50018; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50019; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            OptionCaption = 'Open,Forwarded to Committee,Closed';
            OptionMembers = Open,"Forwarded to Committee",Closed;
        }
        field(50020; Category; Code[10])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Category Master-CS".Code;
        }
        field(50021; "Black DOT Awarded"; Integer)
        {
            Caption = 'Black DOT Awarded';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048920; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
    }

    keys
    {
        key(Key1; "Student No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::03-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::03-05-2019: End
    end;

    var
        EducationSetupCS: Record "Education Setup-CS";

        StudentMasterCS1: Record "Student Master-CS";

        Employee: Record "Employee";
}


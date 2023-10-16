table 50404 "FERPA Module Allowed"
{
    Caption = 'FERPA Module Allowed';
    DataClassification = CustomerContent;
    DrillDownPageId = "FERPA Module Allowed List";
    LookupPageId = "FERPA Module Allowed List";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            begin
                if StudentRec.Get("Student No.") then begin
                    "Enrolment No." := StudentRec."Enrollment No.";
                    "Student Name" := StudentRec."Student Name";
                    Semester := StudentRec.Semester;
                    "Academic Year" := StudentRec."Academic Year";
                    Term := StudentRec.Term;
                end else begin
                    "Enrolment No." := '';
                    "Student Name" := '';
                    Semester := '';
                    "Academic Year" := '';
                    Term := Term::FALL;
                end;
            end;
        }
        field(2; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;

        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Module Name"; Option)
        {
            Caption = 'Module Name';
            OptionCaption = ' ,All Records,Student Account,Registration,Admission,Academic Records,Financial aid';
            OptionMembers = " ","All Records","Student Account",Registration,Admission,"Academic Records","Financial aid";
        }
        field(7; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(8; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(9; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(10; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        Field(11; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;

        }
        Field(12; "Info Header No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Info Header No';
        }
        Field(13; "Ferpa Detail Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ferpa Detail Line No';
        }
        Field(14; "Module Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Module Code';
            TableRelation = "Ferpa Module"."Module Code";
        }

        Field(15; Block; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Block';
        }
        field(16; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        Field(17; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }
    keys
    {
        key(Key1; "Info Header No", "Module Code", "Ferpa Detail Line No")
        {
            Clustered = true;
        }
    }
    var
        StudentRec: Record "Student Master-CS";

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := Today();

        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := Today();

        If xRec.Updated = Updated then
            Updated := true;
    end;
}

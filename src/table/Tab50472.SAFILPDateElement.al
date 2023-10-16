table 50472 "SAFI LP Date Element"
{
    DataClassification = CustomerContent;
    Caption = 'SAP Review Entries';

    fields
    {
        field(1; Semester; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        //***Not in Use***
        Field(2; Term; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(3; "LP Start"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(4; "LP End"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(5; "EST Disbursement"; Date)
        {
            DataClassification = CustomerContent;
        }
        //***Not in Use***
        field(6; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RecStudent: Record "Student Master-CS";
            begin
                If "Student No." <> '' then begin
                    RecStudent.Get("Student No.");
                    "Original Student No." := RecStudent."Original Student No.";
                    "Student Name" := RecStudent."Student Name";
                    "Student Semester" := RecStudent.Semester;
                    "FA Semester" := RecStudent."FA Semester";
                    "Academic Year" := RecStudent."Academic Year";
                    "Student Term" := RecStudent.Term;
                end Else begin
                    "Original Student No." := '';
                    "Student Name" := '';
                    "Student Semester" := '';
                    "Student Term" := "Student Term"::" ";
                    "Academic Year" := '';
                end;
            end;
        }
        field(7; "Original Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Student Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Student Semester"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "GPA"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Pace of Progression"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Time Frame"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "SAP Status"; Option)
        {
            OptionMembers = " ","SAP REVOKE","SAP SATISFIED","SAP WARNING";
            // DataClassification = ToBeClassified;
        }
        field(14; "Mail Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "FA Semester"; Code[20])
        {
            Caption = 'FA Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(17; "GPA Match"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Pace of Progression Match"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Time Frame Match"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Student Term"; Option)
        {
            Caption = 'Student Term';
            OptionCaption = 'FALL,SPRING,SUMMER, ';
            OptionMembers = FALL,SPRING,SUMMER," ";
        }
        field(22; Term_AcademicYear; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; CreatedOn; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; CreatedBy; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; GradeBookDocumentNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Semester, Term)
        {
            Clustered = true;
        }
    }

    var
        EducationSetup: Record "Education Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        IF Semester = '' THEN BEGIN
            EducationSetup.Reset();
            EducationSetup.FindFirst();
            EducationSetup.TESTFIELD("SAP Review NOS");
            NoSeriesMgt.InitSeries(EducationSetup."SAP Review NOS", xRec."No. Series", 0D, Semester, "No. Series");
        END;
        CreatedOn := Today;
        CreatedBy := UserId;
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

}
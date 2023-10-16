table 50455 "Student Degree"
{
    Caption = 'Student Degree';

    fields
    {
        field(1; "Degree Code"; Code[20])
        {
            Caption = 'Degree Code';
            DataClassification = CustomerContent;
            //TableRelation = "Final Degree-CS".Code;
            TableRelation = "Course Degree"."Degree Code" where("Course Code" = Field("Course Code"));

            trigger OnValidate()
            var
                DegreeAudit: Record "Degree Audit";
                DegreeMAster : Record "Final Degree-CS";
            begin
                if "Degree Code" <> '' then begin
                    DegreeMaster.Reset();
                    DegreeMaster.Setrange(Code,Rec."Degree Code");
                    DegreeMAster.Findfirst();
                    StudentMaster.Get("Student No.");
                    CourseMasterRec.Reset();
                    CourseMasterRec.SetRange(Code, StudentMaster."Course Code");
                    if CourseMasterRec.FindFirst() then
                        IF DegreeMaster."Min. CGPA Required" then
                            if CourseMasterRec."Min CGPA Required" > StudentMaster.CGPA then
                                Error('Student CGPA must be greater than or equal to %1', CourseMasterRec."Min CGPA Required");

                    if CourseDegree.Get("Course Code", "Degree Code") then
                        "Degree Name" := CourseDegree."Degree Name";

                    Validate(DateAwarded, Today());
                    "Graduation Date" := DegreeAuditRec.CalculationofGraduationDate(StudentMaster."Estimated Graduation Date", "Degree Code");

                    DegreeAudit.Reset();
                    DegreeAudit.SetRange("Student No.", Rec."Student No.");
                    IF DegreeAudit.FindFirst() then begin
                        DegreeAudit."Graduation Date" := Rec."Graduation Date";
                        DegreeAudit.Modify();
                    end;
                    StudentMaster."Graduation Date" := "Graduation Date";
                    StudentMaster.Modify();


                end;
            end;
        }
        field(2; "Degree Name"; Text[100])
        {
            Caption = 'Degree Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            ValidateTableRelation = false;
            trigger OnValidate()
            begin
                if ("Student No." <> '') then begin
                    if StudentMaster.Get("Student No.") then begin
                        "Enrollment No." := StudentMaster."Enrollment No.";
                        "Course Code" := StudentMaster."Course Code";
                        "Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                        "Student Name" := StudentMaster."Student Name";


                    end;
                end else begin
                    "Enrollment No." := '';
                    "Course Code" := '';
                    "Global Dimension 1 Code" := '';
                    "Student Name" := '';
                end;

            end;
        }
        field(4; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Updated By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(12; "DateAwarded"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
            begin
                DegreeAuditRec.Reset();
                DegreeAuditRec.SetRange("Student No.", "Student No.");
                if DegreeAuditRec.FindFirst() then begin
                    DegreeAuditRec."Date Awarded" := DateAwarded;
                    DegreeAuditRec.Modify();
                end;

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."Date Awarded" := DateAwarded;
                    StudentMaster.Modify();
                end;

            end;
        }
        field(13; "DateCleared"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Certificate Date"; Date)
        {
            Caption = 'Certificate Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CourseDegree: Record "Course Degree";
            begin
                CourseDegree.Reset();
                CourseDegree.SetRange("Degree Code", "Degree Code");
                CourseDegree.SetRange("With Expiration", True);
                IF CourseDegree.FindFirst() then
                    IF "Certificate Date" <> 0D then
                        "Expiration Date" := CalcDate(CourseDegree."Expiration Duration", "Certificate Date");
            end;
        }
        field(15; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(16; "Printed Date"; Date)
        {
            Caption = 'Printed Date';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(17; "Printed By"; Text[50])
        {
            Caption = 'Printed By';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(18; "Last Printed Date"; Date)
        {
            Caption = 'Last Printed Date';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(19; "Last Printed By"; Text[50])
        {
            Caption = 'Last Printed By';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(21; "Student Name"; text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(22; "Graduation Date"; Date)
        {
            Caption = 'Graduation Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
            begin
                DegreeAuditRec.Reset();
                DegreeAuditRec.SetRange("Student No.", "Student No.");
                if DegreeAuditRec.FindFirst() then begin
                    DegreeAuditRec."Graduation Date" := "Graduation Date";
                    DegreeAuditRec.Modify();
                end;

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."Graduation Date" := "Graduation Date";
                    StudentMaster.Modify();
                end;

            end;
        }

        field(23; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(24; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        Field(25; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
    }

    keys
    {
        key(Key1; "Student No.", "Degree Code")
        {

        }
    }

    trigger OnInsert()
    begin

        "Creation Date" := Today();
        "Created By" := Userid();
        "User ID" := FORMAT(UserId());
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());


        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());

        If xRec.Updated = Updated then
            Updated := true;
    end;

    var

        FinalDegree: Record "Final Degree-CS";
        CourseDegree: Record "Course Degree";
        StudentMaster: Record "Student Master-CS";
        CourseMasterRec: Record "Course Master-CS";
        DegreeAuditRec: Record "Degree Audit";

}
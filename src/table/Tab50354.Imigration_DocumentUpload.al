table 50354 "Immigration Document Upload"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Studentmaster.Reset();
                Studentmaster.SetRange(Studentmaster."No.", "Student No.");
                IF Studentmaster.FindFirst() then begin
                    "Enrolment No." := Studentmaster."Enrollment No.";
                    Semester := Studentmaster.Semester;
                    "Academic Year" := Studentmaster."Academic Year";
                    "Global Dimension 1 Code" := Studentmaster."Global Dimension 1 Code";
                end Else begin
                    "Enrolment No." := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                end;

            end;
        }
        field(2; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; Semester; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Document Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Application Form","Passport Biodata","Stamp on Arrival Copy","Visa Copy","Return Ticket Copy","Passport Size Photo";
        }
        field(6; "Document Sub Category"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Document Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Document Path"; Text[500])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                FileExtension: Text[500];
                I: Integer;
                Alfa: Text[1];
            begin
                FileExtension := '';

                for I := 1 to StrLen("Document Path") do begin
                    Alfa := CopyStr("Document Path", I, 1);
                    if Alfa = '.' then
                        FileExtension := ''
                    else
                        FileExtension := FORMAT(FileExtension + Alfa);
                end;
                "Document Extension" := FileExtension;
            end;
        }
        field(9; "Document Extension"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Document ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Document Update Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Verified Document"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                VerifiedDocuments("Student No.", Semester, "Academic Year");
            end;

        }
        field(13; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(14; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;

        }
        field(15; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        field(16; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = false;

        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(23; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Student No.", Semester, "Academic Year", "Document Category", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        Studentmaster: Record "Student Master-CS";
        ImmigrationRec: Record "Immigration Document Upload";
        RecStudentWiseHold: Record "Student Wise Holds";
        //RecHoldStatusLedger: Record "Hold Status Ledger";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        CountNum: Integer;
        CountNum1: Integer;

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
    end;


    procedure VerifiedDocuments(StudentNo: Code[20]; Semester: Code[20]; AcademicYear: Code[20])
    begin
        ImmigrationRec.Reset();
        ImmigrationRec.SetRange(ImmigrationRec."Student No.", StudentNo);
        ImmigrationRec.SetRange(ImmigrationRec."Academic Year", AcademicYear);
        ImmigrationRec.SetRange(ImmigrationRec.Semester, Semester);
        IF ImmigrationRec.FindSet() then begin
            CountNum := ImmigrationRec.Count();
            repeat
                If ImmigrationRec."Verified Document" = true then
                    CountNum1 := CountNum1 + 1;
            until ImmigrationRec.Next() = 0;
            IF CountNum = CountNum1 then begin
                RecStudentWiseHold.Reset();
                RecStudentWiseHold.SetRange("Student No.", StudentNo);
                RecStudentWiseHold.SetRange("Academic Year", AcademicYear);
                RecStudentWiseHold.SetRange(Semester, Semester);
                RecStudentWiseHold.SetRange("Hold Type", RecStudentWiseHold."Hold Type"::Immigration);
                IF RecStudentWiseHold.FindFirst() then begin
                    RecStudentWiseHold.Status := RecStudentWiseHold.Status::Disable;
                    IF RecStudentWiseHold.Modify() then begin
                        RecCodeUnit50037.HoldStatusLedgerEntryInsert(StudentNo, RecStudentWiseHold."Hold Code",
                         RecStudentWiseHold."Hold Description", RecStudentWiseHold."Hold Type"::Immigration, RecStudentWiseHold.Status::Disable);
                        // RecHoldStatusLedger.Reset();
                        // RecHoldStatusLedger.SetRange("Student No.", StudentNo);
                        // RecHoldStatusLedger.SetRange("Academic Year", AcademicYear);
                        // RecHoldStatusLedger.SetRange(Semester, Semester);
                        // RecHoldStatusLedger.SetRange("Hold Type", RecHoldStatusLedger."Hold Type"::" ");
                        // if RecHoldStatusLedger.FindFirst() then begin
                        //     RecHoldStatusLedger."Table Caption" := TableName();
                        //     RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::Immigration;
                        //     RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
                        //     RecHoldStatusLedger.Modify();
                        // end;
                    end;
                end;
            end;
        end;
    end;
}
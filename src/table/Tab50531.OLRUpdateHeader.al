table 50531 "OLR Update Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()

            begin
                If Rec."No." <> xRec."No." then begin
                    EducationSetup_gRec.Reset();
                    If EducationSetup_gRec.FindFirst() then begin
                        NoseriesMgmt_gCU.TestManual(EducationSetup_gRec."OLR Update Application Nos.");
                        "No. Series" := '';
                    end;
                end;
            end;


        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(3; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(4; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
        }
        field(5; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"), "OLR Applicable" = const(true));
        }
        field(6; "OLR Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(7; "OLR Term"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(8; "OLR Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(14; Updated; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(15; "OLR Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Released';
            OptionMembers = "Open","Released";
            Editable = false;
        }
        field(17; "Confirmed On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Confirmed By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        EducationSetup_gRec.Reset();
        If EducationSetup_gRec.FindFirst() then begin
            IF "No." = '' then begin
                EducationSetup_gRec.TestField("OLR Update Application Nos.");
                NoseriesMgmt_gCU.InitSeries(EducationSetup_gRec."OLR Update Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            "Academic Year" := EducationSetup_gRec."Academic Year";
            Term := EducationSetup_gRec."Even/Odd Semester";

        end;


        "Created On" := Today();
        "Created By" := UserId();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        Updated := true;
        "Updated By" := UserId();
        "Updated On" := Today();

    end;

    trigger OnDelete()
    var
        OLRUpdateLine_lRec: Record "OLR Update Line";
    begin
        OLRUpdateLine_lRec.Reset();
        OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
        OLRUpdateLine_lRec.SetRange("Ready to Confirm", false);
        OLRUpdateLine_lRec.DeleteAll();
    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(OldOLRHeader: Record "OLR Update Header"): Boolean
    begin
        With OLRHeaderRec do begin
            OLRHeaderRec := Rec;
            EducationSetup_gRec.Reset();
            If EducationSetup_gRec.FindFirst() then begin
                EducationSetup_gRec.TestField("OLR Update Application Nos.");
                IF NoseriesMgmt_gCU.SelectSeries(EducationSetup_gRec."OLR Update Application Nos.", OldOLRHeader."No. Series", "No. Series") then begin
                    NoseriesMgmt_gCU.SetSeries("No.");
                    Rec := OLRHeaderRec;
                    exit(true);
                end;
            end;
        end;

    end;

    procedure GetStudent()
    var
        OLRUpdateLine_lRec: Record "OLR Update Line";
        OLRUpdateLine_lRec1: Record "OLR Update Line";
        StudentMaster_lRec: Record "Student Master-CS";
        AcademicYearMaster_lRec: Record "Academic Year Master-CS";
        AcademicYearMaster_lRec1: Record "Academic Year Master-CS";
        CourseSemesterMaster_lRec: Record "Course Sem. Master-CS";
        SemesterMaster_lRec1: Record "Semester Master-CS";
        SemesterMaster_lRec: Record "Semester Master-CS";
        LineNo: Integer;
    begin
        OLRUpdateLine_lRec.Reset();
        OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
        OLRUpdateLine_lRec.SetRange("Ready to Confirm", false);
        OLRUpdateLine_lRec.DeleteAll();

        // TestField("Course Code");
        // TestField(Semester);
        TestField(Status, Status::Open);

        IF Term <> Term::SPRING then begin
            AcademicYearMaster_lRec.Reset();
            AcademicYearMaster_lRec.SetRange(Code, Rec."Academic Year");
            IF AcademicYearMaster_lRec.FindFirst() then begin
                AcademicYearMaster_lRec1.Reset();
                AcademicYearMaster_lRec1.SetRange(Sequence, AcademicYearMaster_lRec.Sequence + 1);
                IF AcademicYearMaster_lRec1.FindFirst() then
                    "OLR Academic Year" := AcademicYearMaster_lRec1.Code;
            end;
        end Else
            "OLR Academic Year" := "Academic Year";

        If Term = Term::FALL then
            "OLR Term" := "OLR Term"::SPRING;

        IF Term = Term::SPRING then
            "OLR Term" := "OLR Term"::FALL;

        SemesterMaster_lRec.Reset();
        SemesterMaster_lRec.SetRange(Code, Rec.Semester);
        SemesterMaster_lRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        If SemesterMaster_lRec.FindFirst() then begin
            SemesterMaster_lRec1.Reset();
            SemesterMaster_lRec1.SetRange(Sequence, SemesterMaster_lRec.Sequence + 1);
            SemesterMaster_lRec1.SetRange("Global Dimension 1 Code", SemesterMaster_lRec."Global Dimension 1 Code");
            IF SemesterMaster_lRec1.FindFirst() then begin
                CourseSemesterMaster_lRec.Reset();
                CourseSemesterMaster_lRec.SetRange("Course Code", Rec."Course Code");
                CourseSemesterMaster_lRec.SetRange("Semester Code", SemesterMaster_lRec1.Code);
                IF CourseSemesterMaster_lRec.FindFirst() then
                    "OLR Semester" := CourseSemesterMaster_lRec."Semester Code";
            end;

        end;

        IF "OLR Semester" = '' then begin
            SemesterMaster_lRec.Reset();
            SemesterMaster_lRec.SetRange(Code, Rec.Semester);
            SemesterMaster_lRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            If SemesterMaster_lRec.FindFirst() then begin

                CourseSemesterMaster_lRec.Reset();
                CourseSemesterMaster_lRec.SetRange("Course Code", Rec."Course Code");
                //CourseSemesterMaster_lRec.SetRange("Semester Code", SemesterMaster_lRec.Code);
                CourseSemesterMaster_lRec.SetRange("Sequence No", SemesterMaster_lRec.Sequence + 1);
                IF CourseSemesterMaster_lRec.FindFirst() then
                    "OLR Semester" := CourseSemesterMaster_lRec."Semester Code";
            end;


        end;

        "OLR Start Date" := Today();
        Rec.Modify();

        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Returning Student", true);
        StudentMaster_lRec.SetRange("Course Code", Rec."Course Code");
        StudentMaster_lRec.SetRange(Term, Rec.Term);
        StudentMaster_lRec.SetRange(Semester, Rec.Semester);
        StudentMaster_lRec.SetRange("Academic Year", Rec."Academic Year");
        StudentMaster_lRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        StudentMaster_lRec.SetFilter(Status, '%1|%2|%3|%4', 'ATT', 'PROB', 'REENTRY', 'EXTLOA');
        If StudentMaster_lRec.FindSet() then begin
            repeat
                OLRUpdateLine_lRec1.Reset();
                OLRUpdateLine_lRec1.SetRange("Student No.", StudentMaster_lRec."No.");
                OLRUpdateLine_lRec1.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                OLRUpdateLine_lRec1.SetRange(Term, StudentMaster_lRec.Term);
                If not OLRUpdateLine_lRec1.FindFirst() then begin
                    OLRUpdateLine_lRec.Reset();
                    OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
                    IF OLRUpdateLine_lRec.FindLast() then
                        LineNo := OLRUpdateLine_lRec."Line No." + 10000
                    ELse
                        LineNo := 10000;

                    OLRUpdateLine_lRec.Reset();
                    OLRUpdateLine_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
                    IF not OLRUpdateLine_lRec.FindFirst() then begin
                        OLRUpdateLine_lRec.Init();
                        OLRUpdateLine_lRec."Document No." := Rec."No.";
                        OLRUpdateLine_lRec."Line No." := LineNo;
                        OLRUpdateLine_lRec."Student No." := StudentMaster_lRec."No.";
                        OLRUpdateLine_lRec."Student Name" := StudentMaster_lRec."Student Name";
                        OLRUpdateLine_lRec."Enrollment No." := StudentMaster_lRec."Enrollment No.";
                        OLRUpdateLine_lRec."Original Student No." := StudentMaster_lRec."Original Student No.";
                        OLRUpdateLine_lRec.Status := StudentMaster_lRec.Status;
                        OLRUpdateLine_lRec."Registrar Sign Off" := StudentMaster_lRec."Registrar Signoff";
                        OLRUpdateLine_lRec."Academic Year" := Rec."Academic Year";
                        OLRUpdateLine_lRec.Term := Rec.Term;
                        OLRUpdateLine_lRec."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        OLRUpdateLine_lRec."Course Code" := Rec."Course Code";
                        OLRUpdateLine_lRec.Semester := Rec.Semester;
                        OLRUpdateLine_lRec."OLR Academic Year" := Rec."OLR Academic Year";
                        OLRUpdateLine_lRec."OLR Semester" := Rec."OLR Semester";
                        OLRUpdateLine_lRec."OLR Term" := Rec."OLR Term";
                        OLRUpdateLine_lRec."OLR Start Date" := Rec."OLR Start Date";
                        OLRUpdateLine_lRec."OLR Status" := Rec.Status;
                        OLRUpdateLine_lRec.Insert();
                    end;
                end;
            until StudentMaster_lRec.Next() = 0;
        end;
    end;

    var
        EducationSetup_gRec: Record "Education Setup-CS";
        OLRHeaderRec: Record "OLR Update Header";
        NoseriesMgmt_gCU: Codeunit NoSeriesManagement;

}
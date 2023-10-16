table 50425 "Grade Book Header"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Document No.", Semester, "Academic year", Term;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(3; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(4; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(5; "Academic year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(7; Status; Option)
        {
            OptionMembers = Open,"Pending For Approval",Approved,Rejected,Published;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GradeBook: Record "Grade Book";
            begin
                GradeBook.Reset();
                GradeBook.SetRange("Grade Book No.", "Document No.");
                if GradeBook.FindSet() then
                    repeat
                        GradeBook.validate(Status, Status);
                        GradeBook.Modify(true);
                    until GradeBook.Next() = 0;


            end;
        }

        field(33; "Created By"; Code[50])
        {
            Caption = 'Created By"';
            DataClassification = CustomerContent;
        }
        field(34; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(35; "Updated By"; Code[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(36; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(37; "No. of Archives"; Integer)
        {
            Caption = 'No. of Archives';
            FieldClass = FlowField;
            CalcFormula = Count("Grade Book Header Archive" WHERE("Document No." = FIELD("Document No.")));
        }
        field(38; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approved/Rejected By';
        }
        field(39; "Approved On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved/Rejected On';
        }
        field(41; "To Be Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'To Be Approved/Rejected By';
        }
        field(44; "Rejected Reason"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code WHERE(Type = FILTER(GradeBook));
            trigger OnValidate()
            var
                RsnCode: Record "Reason Code";

            begin
                RsnCode.Reset();
                RsnCode.SetRange(code, "Rejected Reason");
                if RsnCode.FindFirst() then
                    "Rejected Reason Description" := RsnCode.Description
                else
                    "Rejected Reason Description" := '';
            end;
        }
        field(45; "Rejected Reason Description"; text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(46; "Send for Approval By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Send for Approval By';
        }
        field(47; "Send for Approval On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Send for Approval By';
        }
        field(48; "Send for Approval Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(49; "Published By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Published On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(51; "Published Time"; Time)
        {
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }


    }
    trigger OnDelete()
    var
        GradeBook: Record "Grade Book";
        GradeBookInputGB: Record "Marks Weightage Grade Book";
        GradeMasterGB: Record "Grade Master Grade Book";
        RecommGB: Record "Recommendations GradeBook";
        GradeBookHdrLdg: Record "Grade Book Header Ledger";
    begin
        if Status <> Status::Open then
            if Status <> Status::Rejected then
                Error('Grade Book No. %1 Status should be Open or Rejected', "Document No.");
        GradeBook.Reset();
        GradeBook.SetRange("Grade Book No.", "Document No.");
        if GradeBook.findset() then
            GradeBook.DeleteAll();
        GradeBookInputGB.Reset();
        GradeBookInputGB.SetRange("Grade Book No.", "Document No.");
        if GradeBookInputGB.FindSet() then
            GradeBookInputGB.DeleteAll();
        GradeMasterGB.Reset();
        GradeMasterGB.SetRange("Grade Book No.", "Document No.");
        if GradeMasterGB.FindSet() then
            GradeMasterGB.DeleteAll();
        RecommGB.Reset();
        RecommGB.SetRange("Grade Book No.", "Document No.");
        if RecommGB.FindSet() then
            RecommGB.DeleteAll();
        GradeBookHdrLdg.Reset();
        GradeBookHdrLdg.SetRange("Document No.", "Document No.");
        if GradeBookHdrLdg.FindSet() then
            GradeBookHdrLdg.DeleteAll();
    end;

    procedure DocumentArchive(GradeBookHdr: Record "Grade Book Header")
    var
        GradeBook: Record "Grade Book";
        GradeBookHdrArc: Record "Grade Book Header Archive";
        GradeBookArc: Record "Grade Book Archive";
        NextArcNo: Integer;
        LineArcNo: Integer;
    begin
        GradeBookHdrArc.Reset();
        GradeBookHdrArc.SetRange("Document No.", GradeBookHdr."Document No.");
        if GradeBookHdrArc.FindLast() then;
        NextArcNo := GradeBookHdrArc."Archive No." + 1;

        GradeBookHdrArc.Reset();
        GradeBookHdrArc.Init();
        GradeBookHdrArc.TransferFields(GradeBookHdr);
        GradeBookHdrArc."Archive No." := NextArcNo;
        GradeBookHdrArc."Archived By" := USERID();
        GradeBookHdrArc."Archived On" := Today();
        GradeBookHdrArc."Archived Time" := Time();
        GradeBookHdrArc."Approved On" := GradeBookHdr."Approved On";
        GradeBookHdrArc."Approved By" := GradeBookHdr."Approved By";
        GradeBookHdrArc."To Be Approved By" := GradeBookHdr."To Be Approved By";
        GradeBookHdrArc.Insert();

        GradeBook.Reset();
        GradeBook.SetRange("Grade Book No.", GradeBookHdr."Document No.");
        GradeBook.FindSet();
        repeat
            GradeBookArc.Reset();
            GradeBookArc.SetRange("Entry No.", GradeBook."Entry No.");
            GradeBookArc.SetRange("Student No.", GradeBook."Student No.");
            if GradeBookArc.FindLast() then;
            LineArcNo := GradeBookArc."Archive No." + 1;

            GradeBookArc.Reset();
            GradeBookArc.Init();
            GradeBookArc.TransferFields(GradeBook);
            GradeBookArc."Archive No." := LineArcNo;
            GradeBookArc."Header Archive No." := NextArcNo;
            GradeBookArc.Insert();
        until GradeBook.Next() = 0;

    end;

    procedure CreateDocumentLedger(var GradeBookHdr: Record "Grade Book Header")
    var
        GradeBookHdrLdg: Record "Grade Book Header Ledger";
        NextArcNo: Integer;
    begin
        GradeBookHdrLdg.Reset();
        // GradeBookHdrLdg.SetRange("Document No.", GradeBookHdr."Document No.");
        if GradeBookHdrLdg.FindLast() then;
        NextArcNo := GradeBookHdrLdg."Entry No." + 1;

        GradeBookHdrLdg.Reset();
        GradeBookHdrLdg.Init();
        GradeBookHdrLdg.TransferFields(GradeBookHdr);
        GradeBookHdrLdg."Entry No." := NextArcNo;

        GradeBookHdrLdg."Approved On" := Today();
        GradeBookHdrLdg."Approved By" := UserId();
        GradeBookHdrLdg."Entry Time" := Time();
        GradeBookHdrLdg.Insert();

    end;


}
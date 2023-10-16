table 50470 StudentSemesterDecision
{
    DataClassification = CustomerContent;
    Caption = 'Student Semester Decision';
    DataCaptionFields = "Document No.", "Student Name";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            begin
                Stud.Reset();
                if Stud.Get("Student No.") then begin
                    "Student Name" := Stud."Student Name";
                    Validate("Previous SAP", Stud."Remaining Academic SAP");
                    Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                    Validate("Course Code", Stud."Course Code");
                    Validate(Semester, Stud.Semester);
                    Validate("Academic Year", Stud."Academic Year");
                    Validate(Term, Stud.Term);

                    Validate("Calculated SAP", 0);

                    CheckifMultiple(Rec);

                    Dataupdate();
                end
                else begin
                    "Student Name" := '';
                    "Global Dimension 1 Code" := '';
                    "Academic Year" := '';
                    Term := 0;
                    "Course Code" := '';
                    Semester := '';
                    "Previous SAP" := 0;
                    "Calculated SAP" := 0;
                    "Decision Type" := "Decision Type"::" ";
                end;

            end;
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(3; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            Editable = false;
            trigger OnValidate()
            begin
                CheckifMultiple(Rec);
                Dataupdate();
            end;
        }
        field(4; "Term"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
            trigger OnValidate()
            begin
                CheckifMultiple(Rec);
                DataUpdate();
            end;
        }
        field(5; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            Editable = false;
        }
        field(6; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
            Editable = false;
            trigger OnValidate()
            begin
                CheckifMultiple(Rec);
                DataUpdate();
            end;
        }
        field(7; "Decision No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Decision Type"; Option)
        {
            OptionMembers = " ",RepeatApp,Restart;
            OptionCaption = ' ,Repeat,Restart';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Sem: Record "Semester Master-CS";
            begin
                // Sem.Reset();
                // Sem.SetRange(Code, Semester);
                // Sem.FindFirst();
                // if ((Sem.Sequence MOD 2) > 0) and ("Decision Type" = "Decision Type"::Restart) then
                //     Error('Decision Type Repeat cannot be set for Semester %1', Sem.Code);
                // if ((Sem.Sequence MOD 2) = 0) and ("Decision Type" = "Decision Type"::Restart) then
                //     Error('Decision Type Restart cannot be set for Semester %1', Sem.Code);
                // "Calculated SAP" := CalculateSAP(Rec);

                Sem.Reset();
                Sem.SetRange(Code, Semester);
                Sem.FindFirst();

                if ((Sem.Sequence MOD 2) > 0) then begin
                    if "Decision Type" = "Decision Type"::Restart then
                        Error('Decision Type Restart cannot be set for this Student ');
                    // "Decision Type" := "Decision Type"::RepeatApp;
                end;

                if ((Sem.Sequence MOD 2) = 0) then begin
                    StudSubGB.Reset();
                    StudSubGB.SetRange("Student No.", Stud."No.");
                    StudSubGB.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                    StudSubGB.SetRange(Course, Stud."Course Code");
                    StudSubGB.SetRange(Semester, Stud.Semester);
                    StudSubGB.SetRange("Academic Year", Stud."Academic Year");
                    StudSubGB.SetRange(Term, Stud.Term);
                    StudSubGB.SetRange(Status, StudSubGB.Status::Published);
                    if StudSubGB.FindFirst() then begin
                        // "Decision Type" := "Decision Type"::Restart;
                        if "Decision Type" = "Decision Type"::RepeatApp then
                            Error('Decision Type Repeat cannot be set for this Student ');
                    end
                    else begin
                        //"Decision Type" := "Decision Type"::RepeatApp;
                        if "Decision Type" = "Decision Type"::Restart then
                            Error('Decision Type Restart cannot be set for this Student ');
                    end;
                end;

                "Calculated SAP" := CalculateSAP(Rec);
            end;
        }
        field(9; "Decision Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Decision Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Entry From Portal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(12; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(13; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(14; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(15; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Previous SAP"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Calculated SAP"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Approved/Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Approved/Rejected On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(21; Status; Option)
        {
            OptionMembers = Open,"Pending For Approval",Approved,Rejected;
            DataClassification = CustomerContent;
        }
        field(22; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK; "Decision No.")
        {
            Clustered = true;
        }
    }
    var
        Stud: Record "Student Master-CS";
        StudSemDecs: Record StudentSemesterDecision;
        StudSubGB: Record "Student Subject GradeBook";
        Sem: Record "Semester Master-CS";
        NextEntryNo: Integer;
        AcaSetup: Record "Academics Setup-CS";
        NoSeries: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        AcaSetup.Get();
        AcaSetup.TestField("Decision Document Nos.");
        if "Decision No." = 0 then begin
            "Document No." := NoSeries.GetNextNo(AcaSetup."Decision Document Nos.", 0D, TRUE);
            StudSemDecs.Reset();
            if StudSemDecs.FindLast() then;
            NextEntryNo := StudSemDecs."Decision No." + 1;
            "Decision No." := NextEntryNo;
            "Decision Date" := Today();
            "Decision Time" := Time();
            "Created By" := Userid();
            "Created On" := Today();
        end;
    end;

    trigger OnModify()
    begin
        "Updated By" := Userid();
        "Updated On" := Today();
    end;

    trigger OnDelete()
    begin
        // TestField(Status, Status::Open);
    end;

    procedure CalculateSAP(pStudSemDec: Record StudentSemesterDecision): Integer
    var
        EduSetup: Record "Education Setup-CS";
        StudRec: Record "Student Master-CS";
    begin
        pStudSemDec.Testfield("Previous SAP");
        if pStudSemDec."Decision Type" = pStudSemDec."Decision Type"::" " then
            Error('Decision Type must not be blank')
        else
            if pStudSemDec."Decision Type" = pStudSemDec."Decision Type"::RepeatApp then
                Exit(pStudSemDec."Previous SAP" + 1)
            else
                if pStudSemDec."Decision Type" = pStudSemDec."Decision Type"::Restart then
                    Exit(pStudSemDec."Previous SAP" + 2);
    end;

    procedure SendForApproval(pStudSemDec: Record StudentSemesterDecision)
    var
        EduSetup: Record "Education Setup-CS";
        StudRec: Record "Student Master-CS";
        StudSubGB: Record "Student Subject GradeBook";
    begin

        if pStudSemDec."Decision No." = 0 then
            Error('Decision No. must not be zero');
        if pStudSemDec.Status = pStudSemDec.Status::Approved then
            Error('Decision No. %1 is already Approved', pStudSemDec."Decision No.");
        if pStudSemDec.Status = pStudSemDec.Status::"Pending For Approval" then
            Error('Decision No. %1 is already sent for Approval', pStudSemDec."Decision No.");
        pStudSemDec.TestField("Student No.");
        StudRec.Reset();
        StudRec.Get(pStudSemDec."Student No.");
        pStudSemDec.TestField("Global Dimension 1 Code");
        EduSetup.Reset();
        EduSetup.SetRange("Global Dimension 1 Code", pStudSemDec."Global Dimension 1 Code");
        EduSetup.FindFirst();
        pStudSemDec.TestField("Academic Year", EduSetup."Academic Year");
        pStudSemDec.TestField(Term, EduSetup."Even/Odd Semester");
        if StudRec."Academic Year" <> EduSetup."Academic Year" then
            Error('Student does not have Academic Year same as in Education Setup');
        if StudRec.Term <> EduSetup."Even/Odd Semester" then
            Error('Student does not have Term same as in Education Setup');
        if pStudSemDec."Course Code" <> StudRec."Course Code" then
            Error('Course Code in the Decision No. %1 does not match with Student Course Code', pStudSemDec."Decision No.");
        if pStudSemDec.Semester <> StudRec.Semester then
            Error('Semester in the Decision No. %1 does not match with Student Semester', pStudSemDec."Decision No.");
        if pStudSemDec."Decision Type" = pStudSemDec."Decision Type"::" " then
            Error('Decision Type cannot be empty');

        pStudSemDec.TestField("Decision Date");
        pStudSemDec.TestField("Decision Time");
        pStudSemDec.Testfield("Previous SAP");
        pStudSemDec.TestField("Calculated SAP");

        pStudSemDec.Validate(Status, pStudSemDec.Status::"Pending For Approval");
        pStudSemDec.Modify(true);
        StudSubGB.Reset();
        StudSubGB.SetRange("Student No.", pStudSemDec."Student No.");
        StudSubGB.SetRange(Course, pStudSemDec."Course Code");
        StudSubGB.SetRange(Semester, pStudSemDec.Semester);
        StudSubGB.SetRange("Academic Year", pStudSemDec."Academic Year");
        StudSubGB.SetRange(Term, pStudSemDec.Term);
        StudSubGB.SetRange("Global Dimension 1 Code", pStudSemDec."Global Dimension 1 Code");
        // StudSubGB.SetFilter(Status, '%1|%2', StudSubGB.Status::Open, StudSubGB.Status::"Pending For Approval");
        StudSubGB.SetRange(Status, StudSubGB.Status::Published);
        if StudSubGB.FindFirst() then begin
            StudSubGB."Student Sem Document No." := pStudSemDec."Document No.";
            StudSubGB.Modify(true);
        end;


    end;

    procedure ApproveDocs(pStudSemDec: Record StudentSemesterDecision; AppRej: Integer)
    var
        EduSetup: Record "Education Setup-CS";
        StudRec: Record "Student Master-CS";
        DocAppUsr: Record "Document Approver Users";
        StudSubGB: Record "Student Subject GradeBook";
        StudSub: Record "Main Student Subject-CS";
        CrsSemLn: Record "Course Sem. Master-CS";
        SemSeq: Integer;
        RestartSem: Code[20];
    begin
        DocAppUsr.Reset();
        DocAppUsr.SetRange("User ID", UserId());
        DocAppUsr.SetRange("Department Approver Type", DocAppUsr."Department Approver Type"::"Registrar Department");
        if not DocAppUsr.FindFirst() then
            Error('You are not authorised to Approve/Reject the Document');

        if pStudSemDec."Decision No." = 0 then
            Error('Decision No. must not be zero');
        pStudSemDec.TestField("Student No.");
        if pStudSemDec.Status = pStudSemDec.Status::Approved then
            Error('Decision No. %1 is already Approved', pStudSemDec."Decision No.");
        if pStudSemDec.Status IN [pStudSemDec.Status::Open, pStudSemDec.Status::Rejected] then
            Error('Decision No. %1 must be sent for Approval first', pStudSemDec."Decision No.");
        StudRec.Reset();
        StudRec.Get(pStudSemDec."Student No.");
        pStudSemDec.TestField("Global Dimension 1 Code");
        EduSetup.Reset();
        EduSetup.SetRange("Global Dimension 1 Code", pStudSemDec."Global Dimension 1 Code");
        EduSetup.FindFirst();
        pStudSemDec.TestField("Academic Year", EduSetup."Academic Year");
        pStudSemDec.TestField(Term, EduSetup."Even/Odd Semester");
        if StudRec."Academic Year" <> EduSetup."Academic Year" then
            Error('Student does not have Academic Year same as in Education Setup');
        if StudRec.Term <> EduSetup."Even/Odd Semester" then
            Error('Student does not have Term same as in Education Setup');
        if pStudSemDec."Course Code" <> StudRec."Course Code" then
            Error('Course Code in the Decision No. %1 does not match with Student Course Code', pStudSemDec."Decision No.");
        // if pStudSemDec.Semester <> StudRec.Semester then
        //     Error('Semester in the Decision No. %1 does not match with Student Semester', pStudSemDec."Decision No.");
        if pStudSemDec."Decision Type" = pStudSemDec."Decision Type"::" " then
            Error('Decision Type cannot be empty');

        pStudSemDec.TestField("Decision Date");
        pStudSemDec.TestField("Decision Time");
        pStudSemDec.Testfield("Previous SAP");
        pStudSemDec.TestField("Calculated SAP");


        if AppRej = 1 then begin
            CrsSemLn.Reset();
            CrsSemLn.SetRange("Course Code", pStudSemDec."Course Code");
            CrsSemLn.SetRange("Semester Code", pStudSemDec.Semester);
            CrsSemLn.SetRange("Academic Year", pStudSemDec."Academic Year");
            CrsSemLn.SetRange(Term, pStudSemDec.Term);
            CrsSemLn.FindFirst();
            SemSeq := CrsSemLn."Sequence No";

            If SemSeq > 1 then begin
            CrsSemLn.Reset();
            CrsSemLn.SetRange("Course Code", pStudSemDec."Course Code");
            CrsSemLn.SetRange("Sequence No", (SemSeq - 1));
            CrsSemLn.SetRange("Academic Year", pStudSemDec."Academic Year");
            CrsSemLn.SetRange(Term, pStudSemDec.Term);
            CrsSemLn.FindFirst();//arv
            end;
            RestartSem := CrsSemLn."Semester Code";

            StudSubGB.Reset();
            StudSubGB.SetRange("Student No.", pStudSemDec."Student No.");
            StudSubGB.SetRange(Course, pStudSemDec."Course Code");
            //StudSubGB.SetRange(Semester, CrsSemLn."Semester Code");   //25Aug2022
            StudSubGB.SetRange(Semester, pStudSemDec.Semester);
            StudSubGB.SetRange("Academic Year", pStudSemDec."Academic Year");
            StudSubGB.SetRange(Term, pStudSemDec.Term);
            StudSubGB.SetRange("Global Dimension 1 Code", pStudSemDec."Global Dimension 1 Code");
            // StudSubGB.SetFilter(Status, '%1|%2', StudSubGB.Status::Open, StudSubGB.Status::"Pending For Approval");
            StudSubGB.SetRange(Status, StudSubGB.Status::Published);
            // StudSubGB.SetRange("Student Sem Document No.", pStudSemDec."Document No.");
            if not StudSubGB.FindFirst() then
                Error('Grade Book with current filters and Status Published not found.');
            // if StudSubGB.Status = StudSubGB.Status::Published then
            //     Error('Decision No. %1 cannot be Approved as Grade Book %2 is already Published', pStudSemDec."Decision No.", StudSubGB."Grade Book No.");


            pStudSemDec.Validate(Status, pStudSemDec.Status::Approved);
            StudRec."Remaining Academic SAP" := pStudSemDec."Calculated SAP";
            StudRec."Semester Decision" := pStudSemDec."Decision Type";
            if pStudSemDec."Decision Type" = pStudSemDec."Decision Type"::RepeatApp then begin
                StudRec.Validate(Semester, StudSubGB."Old Semester");
                //RS
                StudSub.Reset();
                //key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code", Section, "Start Date")
                StudSub.SetRange("Student No.", StudSubGB."Student No.");
                StudSub.SetRange(Course, StudSubGB.Course);
                StudSub.SetRange(Semester, StudSubGB.Semester);
                StudSub.SetRange("Academic Year", StudSubGB."Academic Year");
                StudSub.SetRange("Subject Code", StudSubGB."Subject Code");
                StudSub.SetRange(Section, StudSubGB.Section);
                StudSub.SetRange(Term, StudSubGB.Term);
                StudSub.FindFirst();
                StudSub.Validate(Grade, 'RS');
                StudSub."Grade Confirmed" := true;
                StudSub.Modify(true);

                if StudRec.Status = 'DIS' then
                    StudRec.Validate(Status, 'RADM');
            end
            else
                if pStudSemDec."Decision Type" = pStudSemDec."Decision Type"::Restart then begin
                    CrsSemLn.Reset();
                    CrsSemLn.SetRange("Course Code", StudSubGB.Course);
                    CrsSemLn.SetRange("Semester Code", StudSubGB.Semester);
                    CrsSemLn.SetRange("Academic Year", StudSubGB."Academic year");
                    CrsSemLn.SetRange(Term, StudSubGB.Term);
                    CrsSemLn.FindFirst();
                    SemSeq := CrsSemLn."Sequence No";

                    CrsSemLn.Reset();
                    CrsSemLn.SetRange("Course Code", StudSubGB.Course);
                    CrsSemLn.SetRange("Sequence No", (SemSeq - 1));
                    CrsSemLn.SetRange("Academic Year", StudSubGB."Academic year");
                    CrsSemLn.SetRange(Term, StudSubGB.Term);
                    CrsSemLn.FindFirst();
                    RestartSem := CrsSemLn."Semester Code";

                    StudRec.Validate(Semester, RestartSem);
                    if StudRec.Status = 'DIS' then
                        StudRec.Validate(Status, 'RADM');
                end;

            if StudSubGB."Student Sem Document No." <> '' then begin
                StudSubGB."Student Sem Document No." := pStudSemDec."Document No.";
                StudSubGB.Modify(true);
            end;

            StudRec.Modify(true);
        end
        else
            if AppRej = 2 then
                pStudSemDec.Validate(Status, pStudSemDec.Status::Rejected);
        pStudSemDec."Approved/Rejected By" := UserId();
        pStudSemDec."Approved/Rejected On" := Today();

        pStudSemDec.Modify(true);
    end;

    procedure CheckifMultiple(pStudSemDec: Record StudentSemesterDecision)
    var
        StudSemDec2: Record StudentSemesterDecision;
    begin
        StudSemDec2.Reset();
        StudSemDec2.SetRange("Student No.", pStudSemDec."Student No.");
        StudSemDec2.SetRange("Academic Year", pStudSemDec."Academic Year");
        StudSemDec2.SetRange(Term, pStudSemDec.Term);
        StudSemDec2.SetFilter("Document No.", '<>%1', pStudSemDec."Document No.");
        if StudSemDec2.FindFirst() then
            Error('Student Semester Decision Document No. %1 already exists for Academic Year %2 Term %3 Student No. %4',
            StudSemDec2."Document No.", StudSemDec2."Academic Year", StudSemDec2.Term, StudSemDec2."Student No.");
    end;

    Procedure Dataupdate()
    begin
        Sem.Reset();
        Sem.SetRange(Code, Semester);
        Sem.FindFirst();

        if ((Sem.Sequence MOD 2) > 0) then begin
            "Decision Type" := "Decision Type"::RepeatApp;
        end;

        if ((Sem.Sequence MOD 2) = 0) then begin
            StudSubGB.Reset();
            StudSubGB.SetRange("Student No.", Stud."No.");
            StudSubGB.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
            StudSubGB.SetRange(Course, Rec."Course Code");
            StudSubGB.SetRange(Semester, Rec.Semester);
            StudSubGB.SetRange("Academic Year", Rec."Academic Year");
            StudSubGB.SetRange(Term, Rec.Term);
            StudSubGB.SetRange(Status, StudSubGB.Status::Published);
            if StudSubGB.FindFirst() then
                "Decision Type" := "Decision Type"::Restart
            else
                "Decision Type" := "Decision Type"::RepeatApp;
        end;

        "Calculated SAP" := CalculateSAP(Rec);
    end;
}
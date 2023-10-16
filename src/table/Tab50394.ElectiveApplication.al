table 50394 "Elective Application"
{
    DataClassification = CustomerContent;
    Caption = 'Elective Application';

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if UserSetupRec.Get(UserId()) then;
                IF "Application No." <> xRec."Application No." THEN BEGIN
                    EducationSetup_lRec.Reset();
                    EducationSetup_lRec.Setrange("Global Dimension 1 Code", '9100');
                    if EducationSetup_lRec.Findfirst() then
                        NoSeriesManagement.TestManual(EducationSetup_lRec."Elective Application No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(3; "Application Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Elective Application';
            OptionMembers = "Elective Application";
            trigger OnValidate()
            begin
                IF Rec."Application Type" <> xRec."Application Type" then begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    "Academic Year" := '';
                    Semester := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Course Code" := '';
                    "Course Description" := '';
                end;
            end;
        }
        field(10; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS" where("Global Dimension 1 Code" = filter(9100), Status = Filter('Att'));
            trigger OnValidate()
            var
                StudentMaster_lRec: Record "Student Master-CS";
                Semester_lRec: Record "Semester Master-CS";
                ElectiveApplicationRec: Record "Elective Application";
            begin

                IF "Student No." <> '' then begin
                    StudentMaster_lRec.Reset();
                    If StudentMaster_lRec.Get("Student No.") then begin

                        Semester_lRec.Reset();
                        Semester_lRec.SetRange(Code, StudentMaster_lRec.Semester);
                        IF Semester_lRec.FindFirst() then
                            IF Semester_lRec.Sequence = 1 then
                                Error('Student : %1 must not be in Semester : %2', StudentMaster_lRec."No.", Semester_lRec.Code);

                        ElectiveApplicationRec.Reset();
                        ElectiveApplicationRec.SetRange("Student No.", StudentMaster_lRec."No.");
                        ElectiveApplicationRec.SetFilter(Status, '%1|%2|%3', ElectiveApplicationRec.Status::"Pending for Approval", ElectiveApplicationRec.Status::Approved, ElectiveApplicationRec.Status::Open);
                        If ElectiveApplicationRec.FindFirst() then
                            Error('Elective Application already exist for Student %1 whose status is %2', StudentMaster_lRec."No.", ElectiveApplicationRec.Status);


                        "Student Name" := StudentMaster_lRec."Student Name";
                        "Academic Year" := StudentMaster_lRec."Academic Year";
                        Semester := StudentMaster_lRec.Semester;
                        "Enrolment No." := StudentMaster_lRec."Enrollment No.";
                        "Course Code" := StudentMaster_lRec."Course Code";
                        "Course Description" := StudentMaster_lRec."Course Name";
                        "Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                    end;
                end;
                IF "Student No." = '' then begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    "Academic Year" := '';
                    Semester := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Course Code" := '';
                    "Course Description" := '';
                end;
            end;

        }
        field(11; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(12; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(13; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS".Code;
            Editable = False;
        }
        field(14; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code;
            Editable = False;
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = False;
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 05-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = False;
        }

        field(18; "Reason"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code where(Type = filter(" "));
            trigger OnValidate()
            var
                ReasonCode_lRec: Record "Reason Code";
            begin
                IF Reason <> '' then Begin
                    ReasonCode_lRec.Reset();
                    If ReasonCode_lRec.Get(Reason) then BEGIN
                        IF ReasonCode_lRec.Type = ReasonCode_lRec.Type::" " then
                            "Reason Description" := ReasonCode_lRec.Description;
                    END;
                End ELSE
                    "Reason Description" := '';
            end;
        }
        field(19; "Reason Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            OptionCaption = 'Open,"Pending for Approval",Approved,Rejected';
        }
        field(21; "Approved/Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Approved/Rejected On"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(25; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(26; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(27; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(28; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(38; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(39; "Subject 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS" where("Global Dimension 1 Code" = Filter(9100), "Level Description" = filter("Main Subject"), "Subject Type" = Filter('ELECTIVE'), "Elective Offering" = filter(true));
            trigger Onvalidate()
            begin
                IF "Subject 1" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 1") then
                        "Subject Description 1" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 1" = '' then
                        "Subject Description 1" := '';
            end;
        }
        field(40; "Subject 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject 2" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 2") then
                        "Subject Description 2" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 2" = '' then
                        "Subject Description 2" := '';
            end;
        }
        field(41; "Subject 3"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject 3" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 3") then
                        "Subject Description 3" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 3" = '' then
                        "Subject Description 3" := '';
            end;
        }
        field(42; "Subject 4"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject 4" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 4") then
                        "Subject Description 4" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 4" = '' then
                        "Subject Description 4" := '';
            end;
        }
        field(43; "Subject 5"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject 5" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 5") then
                        "Subject Description 5" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 5" = '' then
                        "Subject Description 5" := '';
            end;
        }
        field(44; "Subject Description 1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(45; "Subject Description 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(46; "Subject Description 3"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(47; "Subject Description 4"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(48; "Subject Description 5"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        Field(49; "Course Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }

    }


    trigger OnInsert()
    begin
        //if UserSetupRec.Get(UserId()) then;
        EducationSetup_lRec.Reset();
        EducationSetup_lRec.Setrange("Global Dimension 1 Code", '9100');
        if EducationSetup_lRec.Findfirst() then
            IF "No. Series" = '' THEN BEGIN
                EducationSetup_lRec.TESTFIELD("Elective Application No.");
                NoSeriesManagement.InitSeries(EducationSetup_lRec."Elective Application No.", xRec."No. Series", 0D, "Application No.", "No. Series");
            END;
        "Application Date" := WorkDate();
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        Updated := true;
    end;


    procedure AssistEdit(OldElectiveApplication: Record "Elective Application"): Boolean
    var
        ElectiveApplicationRec: Record "Elective Application";

    begin
        with ElectiveApplicationRec do begin
            ElectiveApplicationRec := Rec;
            UserSetupRec.get(UserId());
            EducationSetup_lRec.Reset();
            EducationSetup_lRec.SetRange("Global Dimension 1 Code", '9100');
            if EducationSetup_lRec.FindFirst() then begin
                EducationSetup_lRec.TestField("Elective Application No.");
                if NoSeriesManagement.SelectSeries(EducationSetup_lRec."Elective Application No.", OldElectiveApplication."No. Series", "No. Series") then begin
                    NoSeriesManagement.SetSeries("Application No.");
                    Rec := ElectiveApplicationRec;
                    exit(true);
                end;
            end;
        end;
    end;

    var
        EducationSetup_lRec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        SubjectMaster_lRec: Record "Subject Master-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    Procedure InsertStudentSubject(Rec: Record "Elective Application")
    var
        StudentSubject_lRec: Record "Main Student Subject-CS";
        StudentMAster_lRec: Record "Student Master-CS";
        CourseSemesterMaster_lRec: Record "Course Sem. Master-CS";
        SubjectMaster_lRec: Record "Subject Master-CS";
        SemesterMaster_lRec: Record "Semester Master-CS";
    begin
        StudentSubject_lRec.Reset();
        SemesterMaster_lRec.Reset();
        SubjectMaster_lRec.Reset();
        StudentMAster_lRec.Reset();
        StudentMAster_lRec.SetRange("No.", Rec."Student No.");
        IF StudentMAster_lRec.FindFirst() then begin
            StudentSubject_lRec.Init();
            StudentSubject_lRec.Validate("Student No.", Rec."Student No.");
            StudentSubject_lRec.Course := StudentMAster_lRec."Course Code";
            StudentSubject_lRec.Validate(Semester, StudentMAster_lRec.Semester);
            StudentSubject_lRec."Academic Year" := StudentMAster_lRec."Academic Year";
            StudentSubject_lRec.Validate("Subject Code", Rec."Subject 1");
            StudentSubject_lRec.Validate(Term, StudentMAster_lRec.Term);
            CourseSemesterMaster_lRec.Reset();
            CourseSemesterMaster_lRec.SetRange("Course Code", StudentMAster_lRec."Course Code");
            CourseSemesterMaster_lRec.SetRange("Semester Code", StudentMAster_lRec.Semester);
            CourseSemesterMaster_lRec.SetRange("Academic Year", StudentMAster_lRec."Academic Year");
            CourseSemesterMaster_lRec.SetRange(Term, StudentMAster_lRec.Term);
            IF CourseSemesterMaster_lRec.FindFirst() then begin
                StudentSubject_lRec."Start Date" := CourseSemesterMaster_lRec."Start Date";
                StudentSubject_lRec."End Date" := CourseSemesterMaster_lRec."End Date";
            end;
            IF SubjectMaster_lRec.Get(Rec."Subject 1") then begin
                StudentSubject_lRec."Category-Course Description" := SubjectMaster_lRec."Category Code";
                StudentSubject_lRec.Credit := SubjectMaster_lRec.Credit;
            end;
            StudentSubject_lRec."Term Description" := Format(StudentMAster_lRec.Term) + ' Session';
            SemesterMaster_lRec.SetRange(Code, StudentMAster_lRec.Semester);
            IF SemesterMaster_lRec.FindFirst() then begin
                StudentSubject_lRec.Graduation := SemesterMaster_lRec.Graduation;
                StudentSubject_lRec.Year := SemesterMaster_lRec.Year;
            end;
            StudentSubject_lRec."Type Of Course" := StudentSubject_lRec."Type Of Course"::Semester;
            StudentSubject_lRec.Insert();
        end;
    end;

    Procedure DeleteStudentSubject(Rec: REcord "Elective Application")
    var
        StudentSubject_lRec: Record "Main Student Subject-CS";
        StudentMAster_lRec: Record "Student Master-CS";
        CourseSemesterMaster_lRec: Record "Course Sem. Master-CS";
    Begin
        StudentSubject_lRec.Reset();
        StudentMAster_lRec.Reset();
        StudentMAster_lRec.SetRange("No.", Rec."Student No.");
        IF StudentMAster_lRec.FindFirst() then begin
            CourseSemesterMaster_lRec.Reset();
            CourseSemesterMaster_lRec.SetRange("Course Code", StudentMAster_lRec."Course Code");
            CourseSemesterMaster_lRec.SetRange("Semester Code", StudentMAster_lRec.Semester);
            CourseSemesterMaster_lRec.SetRange("Academic Year", StudentMAster_lRec."Academic Year");
            CourseSemesterMaster_lRec.SetRange(Term, StudentMAster_lRec.Term);
            IF CourseSemesterMaster_lRec.FindFirst() then begin
                StudentSubject_lRec.Reset();
                StudentSubject_lRec.SetRange("Student No.", StudentMAster_lRec."No.");
                StudentSubject_lRec.SetRange(Course, StudentMAster_lRec."Course Code");
                StudentSubject_lRec.SetRange(Semester, StudentMAster_lRec.Semester);
                StudentSubject_lRec.SetRange("Academic Year", StudentMAster_lRec."Academic Year");
                StudentSubject_lRec.SetRange("Subject Code", Rec."Subject 1");
                StudentSubject_lRec.SetRange(Term, StudentMAster_lRec.Term);
                StudentSubject_lRec.SetRange("Start Date", CourseSemesterMaster_lRec."Start Date");
                IF StudentSubject_lRec.FindFirst() then
                    StudentSubject_lRec.Delete();
            end;
        end;
    End;

}
table 50153 "Internal Exam Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                     Remarks
    // 1         CSPL-00092    07-05-2019    OnInsert                                    Assign Value in Fields
    // 2         CSPL-00092    07-05-2019    OnModify                                    Assign Value in Fields
    // 3         CSPL-00092    07-05-2019    Marks Obtained - OnValidate                 Validate Data
    // 4         CSPL-00092    07-05-2019    Student No. - OnValidate                    Validate Data and Assign Value in Fields
    // 5         CSPL-00092    07-05-2019    Obtained Internal Marks - OnValidate        Validate Data
    // 6         CSPL-00092    07-05-2019    SetFilterOnCourseSubjectExGroupLine         Function for Filter Data
    // 7         CSPL-00092    07-05-2019    ValidateShortcutDimCode Validate            Function For Dimensions

    Caption = 'Internal Exam Line-CS';
    //DrillDownPageID = 33049433;
    //LookupPageID = 33049433;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(6; "Marks Obtained"; Decimal)
        {
            Caption = 'Marks Obtained';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::07-05-2019: Start
                // IF "Attendance Type" <> "Attendance Type"::Present THEN          
                //     ERROR(Text001Lbl);           //18Nov2021 : Ajay

                InternalExamHeaderCS.Reset();
                IF InternalExamHeaderCS.GET("Document No.") THEN
                    IF InternalExamHeaderCS."Maximum Mark" < "Marks Obtained" THEN
                        ERROR(Text002Lbl, InternalExamHeaderCS."Maximum Mark");
                //Code added for Validate Data::CSPL-00092::07-05-2019: End
            end;
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            var
                IntExamHdr: Record "Internal Exam Header-CS";
                MarksWeight: Record "Marks Weightage";
                Stud: Record "Student Master-CS";
                ExmMgt: Codeunit "Examination Management";
            begin
                //Code added for Validate Data and Assign Value in Fields::CSPL-00092::07-05-2019: Start
                IntExamHdr.Get("Document No.");
                InternalExamLineCS.Reset();
                InternalExamLineCS.SETRANGE("Document No.", "Document No.");
                InternalExamLineCS.SETRANGE("Student No.", "Student No.");
                InternalExamLineCS.SETRANGE("Subject Code", "Subject Code");
                IF InternalExamLineCS.FINDFIRST() THEN
                    ERROR('Student No. %1 Already Exsist In Document No. %2', "Student No.", "Document No.");

                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Program" := StudentMasterCS.Graduation;
                    IF StudentMasterCS.Status = 'WITH' then
                        "Attendance Type" := "Attendance Type"::Withdrawal              //18Nov2021: Ajay
                    Else
                        "Attendance Type" := "Attendance Type"::Present;
                    InternalExamHeaderCS.Reset();
                    InternalExamHeaderCS.SETRANGE("No.", "Document No.");
                    IF InternalExamHeaderCS.FINDFIRST() THEN BEGIN

                        if ExmMgt.DuplicationFound(IntExamHdr."Academic Year", IntExamHdr.Term, IntExamHdr."Subject Code", IntExamHdr."Exam Classification", "Student No.", 1) then
                            Error('Duplicate entry found for Student No. %1, Subject Code %2, Academic Year %3, Term %4',
                            "Student No.", IntExamHdr."Subject Code", IntExamHdr."Academic Year",
                            IntExamHdr.Term);
                        Semester := IntExamHdr.Semester;
                        "Type Of Course" := IntExamHdr."Type Of Course";
                        "Exam Schedule No." := IntExamHdr."Exam Schedule Code";
                        Section := IntExamHdr."Student Group";
                        Course := IntExamHdr."Course Code";
                        "Exam Classification" := IntExamHdr."Exam Classification";
                        Term := IntExamHdr.Term;
                        "Exam Slot" := IntExamHdr."Exam Slot";
                        "Start Time" := IntExamHdr."Start Time";
                        "End Time" := IntExamHdr."End Time";
                        //"Attendance Type" := "Attendance Type"::Present;
                        "Academic Year" := IntExamHdr."Academic Year";
                        "Subject Class" := IntExamHdr."Subject Class";
                        "Subject Type" := IntExamHdr."Subject Type";
                        "Subject Code" := IntExamHdr."Subject Code";

                        Stud.Reset();
                        Stud.Get("Student No.");
                        "Student Name" := Stud."Student Name";
                        "Original Student No." := Stud."Original Student No.";
                        "Enrollment No." := Stud."Enrollment No.";
                        Batch := IntExamHdr.Batch;
                        "Student Group" := IntExamHdr."Student Group";
                        VALIDATE(Status, IntExamHdr.Status);
                        VALIDATE("Global Dimension 1 Code", IntExamHdr."Global Dimension 1 Code");
                        Year := IntExamHdr.Year;
                        "Exam Type" := IntExamHdr."Exam Type";
                        "Program" := IntExamHdr."Program";
                        "Maximum Internal  Marks" := IntExamHdr."Maximum Mark";
                        // "Total Maximum" := IntExamHdr."Total Maximum";

                        MarksWeight.Reset();
                        MarksWeight.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                        MarksWeight.SetRange("Academic Year", "Academic year");
                        MarksWeight.SetRange("Course Code", Course);
                        MarksWeight.SetRange(Semester, Semester);
                        // If "Global Dimension 1 Code" = '9000' then
                        MarksWeight.SetRange("Exam Code", "Subject Code");
                        // IF "Global Dimension 1 Code" = '9100' then
                        //     MarksWeight.SetRange("Subject Code", "Subject Code");
                        MarksWeight.SetRange(Term, Term);
                        MarksWeight.FindFirst();
                        MarksWeight.TestField(Points);
                        "Maximum Weightage" := MarksWeight.Points;

                        "Exam Date" := IntExamHdr."Exam Date";
                        "Created By" := Format(USERID());
                        "Created On" := TODAY();


                    END;
                END ELSE BEGIN
                    "Student Name" := '';
                    "Enrollment No." := '';
                    "Attendance Type" := "Attendance Type"::" ";
                    "Maximum Internal  Marks" := 0;
                    "Maximum Weightage" := 0;
                    "Academic Year" := '';
                    Course := '';
                    "Type Of Course" := "Type Of Course"::" ";
                    Year := '';
                    Semester := '';
                    "Subject Class" := '';
                    "Subject Type" := '';
                    "Subject Code" := '';
                    "Exam Type" := "Exam Type"::" ";
                    "Exam Group" := '';
                    "Exam Method Code" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Exam Schedule No." := '';
                END;
                //Code added for Validate Data and Assign Value in Fields::CSPL-00092::07-05-2019: End
            end;
        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(11; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Present,Absent,Withdrawal';
            OptionMembers = " ",Present,Absent,Withdrawal;
            trigger OnValidate()
            begin
                validate("Obtained Internal Marks", 0);
                "Obtained Weightage" := 0;
                "Percentage Obtained" := 0;
                Grade := '';
                CreateLedgerEntry(Rec);
            end;
        }
        field(12; "Exam Method Code"; Code[20])
        {
            Caption = 'Exam Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Internal Exam Line-CS"."Document No.";
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(14; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Grade Master-CS";
        }
        field(15; Rank; Integer)
        {
            Caption = 'Rank';
            DataClassification = CustomerContent;
        }
        field(19; ASN; Decimal)
        {
            Caption = 'ASN';
            DataClassification = CustomerContent;
        }
        field(20; ACT; Decimal)
        {
            Caption = 'ACT';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50015; "Exam Group"; Code[20])
        {
            Caption = 'Exam Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Sessional Exam Group-CS".Group;
        }
        field(50016; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50031; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(50032; "Re-Sessional"; Decimal)
        {
            Caption = 'Re-Sessional';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50033; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            OptionCaption = 'Open,Released,Published';
            OptionMembers = Open,Released,Published;

            trigger OnValidate()
            begin
                Updated := TRUE;
            end;
        }
        field(50034; "Attendance %"; Decimal)
        {
            Caption = 'Attendance %';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50035; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            OptionCaption = ' ,Regular,Re-Sessional';
            OptionMembers = " ",Regular,"Re-Sessional";
        }
        field(50036; "Roll No."; Code[10])
        {
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50037; "Assignment Marks"; Decimal)
        {
            Caption = 'Assignment Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50038; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50039; "Exam Method"; Code[10])
        {
            Caption = 'Exam Method';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50040; "Maximum Internal  Marks"; Decimal)
        {
            Caption = 'Maximum Internal  Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50041; "Obtained Internal Marks"; Decimal)
        {
            Caption = 'Obtained Internal Marks';
            DataClassification = CustomerContent;
            MinValue = 0;
            Description = 'CS Field Added 10-05-2019';

            trigger OnValidate()
            var
                SubjMaster: Record "Subject Master-CS";
                CrsSubj: Record "Course Wise Subject Line-CS";
                IntExamLn: Record "Internal Exam Line-CS";
                // ObtMarks: Decimal;
                ObtWeightage: Decimal;
                TotRec: Integer;

            begin
                //TestField("Attendance Type", "Attendance Type"::Present);             //18Nov2021 : Ajay
                //Code added for Validate Data::CSPL-00092::07-05-2019: Start
                // IF "Leave Types" <> '' Then
                //     Error('You Can''t Enter Marks If Student is on Leave!!');


                IF "Attendance Type" In ["Attendance Type"::Present, "Attendance Type"::Withdrawal] THEN BEGIN          //18Nov2021 : Ajay
                    //TestField("Obtained Internal Marks");
                    if "Obtained Internal Marks" > "Maximum Internal  Marks" then
                        Error('Obtained Internal Marks %1 cannot be more than Maximum Internal Marks %2', "Obtained Internal Marks", "Maximum Internal  Marks");
                    SubjMaster.Reset();
                    SubjMaster.SetRange(code, "Subject Code");
                    SubjMaster.FindFirst();
                    if SubjMaster."Exam Record Not Required" then
                        Error('Marks for Subject Code %1 cannot be entered manually', SubjMaster.Code);

                    IF "Obtained Internal Marks" > "Maximum Internal  Marks" THEN
                        ERROR(Text004Lbl)
                    ELSE BEGIN
                        TestField("Maximum Weightage");
                        // "Obtained Weightage" := ("Obtained Internal Marks" / 100) * "Maximum Weightage";
                        "Obtained Weightage" := ("Obtained Internal Marks" / "Maximum Internal  Marks") * "Maximum Weightage";

                        // "Percentage Obtained" := ROUND((("Obtained Weightage" * 100) / "Maximum Weightage"), 0.01, '=');
                        "Percentage Obtained" := ROUND((("Obtained Internal Marks" * 100) / "Maximum Internal  Marks"), 0.01, '=');
                        GradeMaster.Reset();
                        GradeMaster.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                        GradeMaster.SetFilter("Min Percentage", '<=%1', "Percentage Obtained");
                        GradeMaster.SetFilter("Max Percentage", '>=%1', "Percentage Obtained");
                        GradeMaster.SetRange("Blocked for Grading", false);
                        If GradeMaster.FindFirst() Then
                            Grade := GradeMaster.Code;
                        CreateLedgerEntry(Rec);
                        Modify();


                        ObtWeightage := 0;
                        SubjMaster.Reset();
                        SubjMaster.SetRange(code, "Subject Code");
                        SubjMaster.FindFirst();
                        if SubjMaster.Level = 3 then begin
                            IntExamLn.Reset();
                            IntExamLn.SetRange("Student No.", "Student No.");
                            IntExamLn.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                            IntExamLn.SetRange(Course, Course);
                            IntExamLn.SetRange(Semester, Semester);
                            IntExamLn.SetRange("Academic Year", "Academic Year");
                            IntExamLn.SetRange(Term, Term);
                            IntExamLn.SetRange("Subject Code", SubjMaster."Subject Group");
                            IntExamLn.SetFilter("Exam Classification", '%1', 'REGULAR');
                            if IntExamLn.FindLast() then begin
                                IntExamLn."Obtained Internal Marks" := 0;
                                IntExamLn."Percentage Obtained" := 0;
                                IntExamLn."Obtained Weightage" := 0;
                                IntExamLn.Modify();
                            end;

                            IntExamLn.Reset();
                            IntExamLn.SetRange("Student No.", "Student No.");
                            IntExamLn.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                            IntExamLn.SetRange(Course, Course);
                            IntExamLn.SetRange(Semester, Semester);
                            IntExamLn.SetRange("Academic Year", "Academic Year");
                            IntExamLn.SetRange(Term, Term);
                            IntExamLn.SetRange("Subject Code", SubjMaster."Subject Group");
                            IntExamLn.SetFilter("Exam Classification", '%1', 'SPECIAL');
                            if IntExamLn.FindLast() then begin
                                IntExamLn."Obtained Internal Marks" := 0;
                                IntExamLn."Percentage Obtained" := 0;
                                IntExamLn."Obtained Weightage" := 0;
                                IntExamLn.Modify();
                            end;



                            CrsSubj.Reset();
                            CrsSubj.SetRange("Course Code", Course);
                            CrsSubj.SetRange(Semester, Semester);
                            CrsSubj.SetRange("Subject Group", SubjMaster."Subject Group");
                            CrsSubj.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                            CrsSubj.SetRange(Examination, true);
                            TotRec := CrsSubj.Count();
                            CrsSubj.FindSet();
                            repeat
                                // IntExamLn.Reset();
                                // IntExamLn.SetRange("Student No.", "Student No.");
                                // IntExamLn.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                                // IntExamLn.SetRange(Course, Course);
                                // IntExamLn.SetRange(Semester, Semester);
                                // IntExamLn.SetRange("Academic Year", "Academic Year");
                                // IntExamLn.SetRange(Term, Term);
                                // IntExamLn.SetRange("Subject Code", CrsSubj."Subject Code");
                                // IntExamLn.SetRange("Exam Classification", "Exam Classification");
                                // IntExamLn.FindLast();

                                IntExamLn.Reset();
                                IntExamLn.SetRange("Student No.", "Student No.");
                                IntExamLn.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                                IntExamLn.SetRange(Course, Course);
                                IntExamLn.SetRange(Semester, Semester);
                                IntExamLn.SetRange("Academic Year", "Academic Year");
                                IntExamLn.SetRange(Term, Term);
                                IntExamLn.SetRange("Subject Code", CrsSubj."Subject Code");
                                IntExamLn.SetFilter("Exam Classification", '%1', 'REGULAR');
                                if IntExamLn.FindLast() then begin
                                    // ObtMarks := IntExamLn."Obtained Internal Marks";
                                    ObtWeightage := IntExamLn."Obtained Weightage";
                                end;
                                IntExamLn.Reset();
                                IntExamLn.SetRange("Student No.", "Student No.");
                                IntExamLn.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                                IntExamLn.SetRange(Course, Course);
                                IntExamLn.SetRange(Semester, Semester);
                                IntExamLn.SetRange("Academic Year", "Academic Year");
                                IntExamLn.SetRange(Term, Term);
                                IntExamLn.SetRange("Subject Code", CrsSubj."Subject Code");
                                IntExamLn.SetFilter("Exam Classification", '%1', 'SPECIAL');
                                if IntExamLn.FindLast() then begin
                                    // ObtMarks := IntExamLn."Obtained Internal Marks";
                                    ObtWeightage := IntExamLn."Obtained Weightage";
                                end;

                                IntExamLn.Reset();
                                IntExamLn.SetRange("Student No.", "Student No.");
                                IntExamLn.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                                IntExamLn.SetRange(Course, Course);
                                IntExamLn.SetRange(Semester, Semester);
                                IntExamLn.SetRange("Academic Year", "Academic Year");
                                IntExamLn.SetRange(Term, Term);
                                IntExamLn.SetRange("Subject Code", SubjMaster."Subject Group");
                                IntExamLn.SetFilter("Exam Classification", '%1', 'REGULAR');
                                if IntExamLn.FindLast() then begin
                                    // IntExamLn."Obtained Internal Marks" += ObtMarks / TotRec;
                                    // IntExamLn.Testfield("Maximum Internal  Marks");
                                    IntExamLn."Maximum Internal  Marks" := 100;


                                    IntExamLn."Obtained Weightage" += ObtWeightage;
                                    If IntExamLn."Obtained Weightage" > IntExamLn."Maximum Weightage" then
                                        Error('Calculation Issue in Weightage');
                                    // IntExamLn."Percentage Obtained" := ROUND(((IntExamLn."Obtained Internal Marks" * 100) / IntExamLn."Maximum Internal  Marks"), 0.01, '=');
                                    IntExamLn."Percentage Obtained" := ROUND(((IntExamLn."Obtained Weightage" * 100) / IntExamLn."Maximum Weightage"), 0.01, '=');
                                    IntExamLn."Obtained Internal Marks" := IntExamLn."Percentage Obtained";
                                    IntExamLn.Modify();
                                end;

                                IntExamLn.Reset();
                                IntExamLn.SetRange("Student No.", "Student No.");
                                IntExamLn.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                                IntExamLn.SetRange(Course, Course);
                                IntExamLn.SetRange(Semester, Semester);
                                IntExamLn.SetRange("Academic Year", "Academic Year");
                                IntExamLn.SetRange(Term, Term);
                                IntExamLn.SetRange("Subject Code", SubjMaster."Subject Group");
                                IntExamLn.SetFilter("Exam Classification", '%1', 'SPECIAL');
                                if IntExamLn.FindLast() then begin
                                    // IntExamLn."Obtained Internal Marks" += ObtMarks / TotRec;
                                    // IntExamLn.Testfield("Maximum Internal  Marks");
                                    IntExamLn."Maximum Internal  Marks" := 100;

                                    IntExamLn."Obtained Weightage" += ObtWeightage;
                                    If IntExamLn."Obtained Weightage" > IntExamLn."Maximum Weightage" then
                                        Error('Calculation Issue in Weightage');
                                    // IntExamLn."Percentage Obtained" := ROUND(((IntExamLn."Obtained Internal Marks" * 100) / IntExamLn."Maximum Internal  Marks"), 0.01, '=');
                                    IntExamLn."Percentage Obtained" := ROUND(((IntExamLn."Obtained Weightage" * 100) / IntExamLn."Maximum Weightage"), 0.01, '=');
                                    IntExamLn."Obtained Internal Marks" := IntExamLn."Percentage Obtained";
                                    IntExamLn.Modify();
                                end;


                            until CrsSubj.Next() = 0;
                        end;

                    End;
                END;
                //  ELSE
                //     ERROR(Text003Lbl);           //18Nov2021 : Ajay
                //Code added for Validate Data::CSPL-00092::07-05-2019: End
            end;
        }
        field(50042; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50043; "Obtained Weightage"; Decimal)
        {
            Caption = 'Obtained Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = true;
        }
        field(50044; "Marks Published"; Boolean)
        {
            Caption = 'Marks Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50045; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50046; "MAL Practice Level"; Code[20])
        {
            Caption = 'MAL Practice Level';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Discipline MalPractice-CS";
        }
        field(50047; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50048; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Group Master-CS".Code;
        }
        field(50049; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Subject Classification-CS".Code;
        }
        field(50050; Reason; Text[100])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50051; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50052; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50053; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
        }
        field(50054; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
        }
        field(50055; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
            TableRelation = "Examination Time Slot-CS";
        }
        field(50056; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50057; "Exam Classification"; Code[20])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            TableRelation = "Examination Type Master-CS".Code WHERE("Exam Type" = FIELD("Document Type"));
        }
        field(50058; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No';
            DataClassification = CustomerContent;
        }
        field(50059; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
        }
        field(50060; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50061; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50062; "Leave Types"; Code[20])
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,ELOA,SLOA,CLOA';
            // OptionMembers = " ","ELOA","SLOA","CLOA";
            Editable = false;
        }
        field(50063; "Original Student No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50071; "Select To Perform"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50072; "Published Document No."; code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(103; "CBSE Version"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(201; "Entry From Portal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33048922; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048923; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048924; "Modified By"; Text[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048925; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048928; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: Start
        InternalExamHeaderCS.Reset();
        IF InternalExamHeaderCS.GET("Document No.") THEN BEGIN
            Course := InternalExamHeaderCS."Course Code";
            Semester := InternalExamHeaderCS.Semester;
            Section := InternalExamHeaderCS."Section";
            //"Subject Type" := InternalExamHeaderCS."Subject Type";
            //"Subject Code" := InternalExamHeaderCS."Subject Code";
            "Exam Schedule No." := InternalExamHeaderCS."Exam Schedule Code";
        END;

        "Created By" := FORMAT(UserId());
        "Created On" := Today();
        "Mobile Insert" := TRUE;
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: Start
        if Status = Status::Published then
            Error('Modification is not allowed as Line No. %1 is Published', "Line No.");
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;


        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: End
    end;

    trigger OnDelete()
    begin
        if Status = Status::Published then
            Error('Deletion is not allowed as Line No. %1 is Published', "Line No.");
    end;

    var
        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        StudentMasterCS: Record "Student Master-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        GradeMaster: Record "Grade Master-CS";
        DimensionManagement: Codeunit "DimensionManagement";
        TotalObtainedWeightage: Decimal;
        Text001Lbl: Label 'You cant enter the mark if attendance type is not present.';
        Text002Lbl: Label 'Marks obtained should not be greater than %1.';
        Text003Lbl: Label 'You Can''t Enter Marks If Student Is Absent !!';
        Text004Lbl: Label 'You Can''t Enter Marks More Than Maximum Internal Marks !!';

    //   WeightagePercentage: Decimal;


    local procedure SetFilterOnCourseSubjectExGroupLine()
    begin
        //Code added for Filter Data::CSPL-00092::07-05-2019: Start
        SessionalExamGroupLineCS.Reset();
        SessionalExamGroupLineCS.SETCURRENTKEY(Course, Semester, "Subject Type", "Subject Code", "Academic year", Section, "Exam Group");
        SessionalExamGroupLineCS.SETRANGE(Course, Course);
        SessionalExamGroupLineCS.SETRANGE(Semester, Semester);
        SessionalExamGroupLineCS.SETRANGE("Subject Type", "Subject Type");
        SessionalExamGroupLineCS.SETRANGE("Subject Code", "Subject Code");
        SessionalExamGroupLineCS.SETRANGE("Academic year", "Academic Year");
        SessionalExamGroupLineCS.SETRANGE(Section, Section);
        SessionalExamGroupLineCS.SETRANGE("Exam Group", "Exam Group");
        //Code added for Filter Data::CSPL-00092::07-05-2019: End
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //Code added for Validate Dimension::CSPL-00092::07-05-2019: Start
        DimensionManagement.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //Code added for Validate Dimension::CSPL-00092::07-05-2019: End
    end;

    procedure CreateLedgerEntry(IntExamLn: Record "Internal Exam Line-CS")
    var
        IntExamLnLdgr: Record "Internal Exam Line Ledger";
        NextLnNo: Integer;
    begin
        NextLnNo := 0;
        IntExamLnLdgr.Reset();
        if IntExamLnLdgr.FindLast() then;
        NextLnNo := IntExamLnLdgr."Entry No." + 1;

        IntExamLnLdgr.Reset();
        IntExamLnLdgr.Init();
        IntExamLnLdgr.TransferFields(IntExamLn);
        IntExamLnLdgr."Entry No." := NextLnNo;
        IntExamLnLdgr.Insert(true);
    end;
}


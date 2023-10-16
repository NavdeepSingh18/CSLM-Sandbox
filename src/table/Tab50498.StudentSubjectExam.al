table 50498 "Student Subject Exam"
{
    // version V.001-CS


    Caption = 'Student Subject Exam Details';
    DataCaptionFields = "Student No.", "Student Name";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Master-CS";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for value Assign in Student Name And Roll No. Field::CSPL-00092::05-04-2019: Start
                IF StudentMasterCS.GET("Student No.") THEN Begin
                    "Student Name" := StudentMasterCS."Student Name";
                    "Original Student No." := StudentMasterCS."Original Student No.";
                    "Enrollment No" := StudentMasterCS."Enrollment No.";
                END ELSE begin
                    "Student Name" := '';
                    "Original Student No." := '';
                    "Enrollment No" := '';
                end;

                //Code added for value Assign in Student Name And Roll No. Field::CSPL-00092::05-04-2019: End
            end;
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SemesterRec: Record "Semester Master-CS";
            begin
                //Code added for Update log::CSPL-00092::05-04-2019: Start
                UpdateDetails();
                SemesterRec.Reset();
                SemesterRec.SetRange(Code, Semester);
                If SemesterRec.FindFirst() then
                    Sequence := SemesterRec.Sequence;
                //Code added for Update log::CSPL-00092::05-04-2019: End
            end;
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = "Subject Master-CS".Code where(Examination = const(true));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::05-04-2019: Start
                // Clear(Duration);
                // "Type of Subject" := "Type of Subject"::" ";
                "Subject Group" := '';
                Level := 0;
                "Level Description" := "Level Description"::" ";
                // "Core Rotation Group" := '';
                // Examination := false;

                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN BEGIN
                    Description := SubjectMasterCS.Description;
                    // Specilization := SubjectMasterCS.Specilization;
                    // "Type Of Course" := SubjectMasterCS."Type Of Course";
                    //"Subject Type" := SubjectMasterCS."Subject Type";
                    //"Subject Class" := SubjectMasterCS."Subject Classification";
                    // "Internal Maximum" := SubjectMasterCS."Internal Maximum";
                    // "External Maximum" := SubjectMasterCS."External Maximum";
                    // "Program/Open Elective Temp" := SubjectMasterCS."Program/Open Elective Temp";
                    "Global Dimension 1 Code" := SubjectMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := SubjectMasterCS."Global Dimension 2 Code";
                    "Category-Course Description" := SubjectMasterCS."Category Code";
                    "Exam Sequence" := SubjectMasterCS."Exam Sequence";
                    // Duration := SubjectMasterCS.Duration;
                    // "Type of Subject" := SubjectMasterCS."Type of Subject";
                    "Subject Group" := SubjectMasterCS."Subject Group";
                    Level := SubjectMasterCS.Level;
                    "Score Type" := SubjectMasterCS."Score type";
                    "Level Description" := SubjectMasterCS."Level Description";
                    // "Core Rotation Group" := SubjectMasterCS."Core Rotation Group";
                    // Examination := SubjectMasterCS.Examination;
                END;
                //Code added for Assign Value in Fields::CSPL-00092::05-04-2019: Start
            end;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        // field(6; "Subject Type"; Code[20])
        // {
        //     Caption = 'Subject Type';
        //     TableRelation = "Subject Type-CS";
        //     DataClassification = CustomerContent;
        // }
        field(7; Course; Code[20])
        {
            Caption = 'Course';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Update log::CSPL-00092::05-04-2019: Start
                UpdateDetails();
                //Code added for Update log::CSPL-00092::05-04-2019: End
            end;
        }
        field(8; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Update log and clear Roll No field::CSPL-00092::05-04-2019: Start
                UpdateDetails();
                //"Roll No." := '';
                //Code added for Update log and clear Roll No field::CSPL-00092::05-04-2019: End
            end;
        }
        field(9; "Internal Mark"; Decimal)
        {
            Caption = 'Internal Mark';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Update log::CSPL-00092::05-04-2019: Start
                UpdateDetails();
                //Code added for Update log::CSPL-00092::05-04-2019: End
            end;
        }
        field(10; "External Mark"; Decimal)
        {
            Caption = 'External Mark';
            DataClassification = CustomerContent;

            trigger OnValidate()
            Var
                ExamPassingRec: Record "Exam Passing";
            begin
                //Code added for Update log and Assign value in Total field::CSPL-00092::05-04-2019: Start
                UpdateDetails();
                Total := "Total Internal" + "External Mark";

                if ("Score Type" = "Score Type"::CCSE) or ("Score Type" = "Score Type"::CBSE) then begin
                    ExamPassingRec.Reset();
                    ExamPassingRec.SetRange("Subject Code", "Subject Code");
                    ExamPassingRec.SetFilter("Effective Date", '<=%1', Today());
                    ExamPassingRec.FindLast();
                    if "External Mark" >= ExamPassingRec."Passing Marks" then
                        Result := Result::Certified
                    else
                        Result := Result::" ";
                end;



                //if ("Score Type" = "Score Type"::"STEP 1") or ("Score Type" = "Score Type"::"STEP 2 CK") or ("Score Type" = "Score Type"::"STEP 2 CS") then begin     //09Feb2022
                if ("Score Type" = "Score Type"::"STEP 2 CK") or ("Score Type" = "Score Type"::"STEP 2 CS") then begin
                    ExamPassingRec.Reset();
                    ExamPassingRec.SetRange("Subject Code", "Subject Code");
                    ExamPassingRec.SetFilter("Effective Date", '<=%1', Today());
                    ExamPassingRec.FindLast();
                    if "External Mark" >= ExamPassingRec."Passing Marks" then
                        Result := Result::Pass
                    else
                        Result := Result::Fail;

                    //Code added for Update log and Assign value in Total field::CSPL-00092::05-04-2019: End
                end;

                // //09Feb2022-Start
                // IF "Score Type" = "Score Type"::"STEP 1" then
                //     Result := Result::Pass;
                // //09Feb2022-End
            end;
        }
        field(11; Total; Decimal)
        {
            Caption = 'Total';
            Editable = true;
        }
        field(12; Result; Option)
        {
            Caption = 'Result';
            Editable = true;
            OptionCaption = ' ,Pass,Fail,Certified';
            OptionMembers = " ",Pass,Fail,Certified;
            DataClassification = CustomerContent;
        }
        // field(13; "Attendance Type"; Option)
        // {
        //     Caption = 'Attendance Type';
        //     OptionCaption = ' ,Present,Absent,On Duty,Leave';
        //     OptionMembers = " ",Present,Absent,"On Duty",Leave;
        //     DataClassification = CustomerContent;

        //     trigger OnValidate()
        //     begin
        //         //Code added for Validate attendance ::CSPL-00092::05-04-2019: Start
        //         UpdateAttendance();
        //         //Code added for Validate attendance ::CSPL-00092::05-04-2019: End
        //     end;
        // }
        field(14; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = "Grade Master-CS";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

            end;
        }

        field(21; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(22; Credit; Decimal)
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }

        field(27; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            DataClassification = CustomerContent;
        }
        field(28; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
        }

        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }

        field(50015; Year; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateDetails();
            end;
        }
        field(50016; "Enrollment No"; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(50030; "Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50031; "Credit Grade Points Earned"; Integer)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Credit Grade Points Earned';
            DataClassification = CustomerContent;
        }
        field(50032; "Currency Code"; Code[10])
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(50033; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24 Jan 2023';
            Editable = false;
        }
        field(50034; "Obtained Weightage"; Decimal)
        {
            Caption = 'Obtained Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24 Jan 2023';
            Editable = true;
        }

        field(50040; "Total Weightage"; Decimal)
        {
            Caption = 'Total Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24 Jan 2023';
            Editable = false;
        }

        field(50042; "Total Internal"; Decimal)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Total Internal';
            DataClassification = CustomerContent;
        }
        field(50043; Updated; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }


        field(50071; "Student Status"; Option)
        {
            CalcFormula = Lookup("Student Master-CS"."Student Status" WHERE("No." = FIELD("Student No.")));
            Caption = 'Student Status';
            Description = 'CS Field Added 14-05-2019';
            FieldClass = FlowField;
            OptionCaption = ' ,Student,Inactive,Provisional Student,Expired,Withdrwal -In- Process,Withdrawl/Discontinue,Student Transfer-In-Process,Course Completion,Casual,Reject & Rejoin,NFT,NFT-Extended,Academic Break,Terminated';
            OptionMembers = " ",Student,Inactive,"Provisional Student",Expired,"Withdrwal -In- Process","Withdrawl/Discontinue","Student Transfer-In-Process","Course Completion",Casual,"Reject & Rejoin",NFT,"NFT-Extended","Academic Break",Terminated;
        }
        field(50072; "Subject Not Required"; Boolean)
        {
            CalcFormula = Lookup("Subject Master-CS"."Subject Not Required" WHERE(Code = FIELD("Subject Code")));
            Description = 'CS Field Added 14-05-2019';
            FieldClass = FlowField;
            Caption = 'Subject Not Required';
        }

        field(50082; "Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Group';
            TableRelation = "Subject Master-CS".Code;
            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                "Subject Group Description" := '';
                SubjectMaster.Reset();
                if SubjectMaster.Get("Subject Group") then
                    "Subject Group Description" := SubjectMaster.Description
            end;
        }
        field(50083; "Subject Group Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Group Description';
            Editable = false;
        }

        field(50084; "Level"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Level';
        }
        field(50085; "Level Description"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Level Description';
            OptionMembers = " ","Main Subject","Level 2 Systems","Level 3 Topics","Internal Exam Component","External Examination","Level 2 Clinical Rotation","Clinical Shelf Examination","Prep Examination","Level 2 Elective Rotation","Level 3 Exam","Level 3 Component","Level 3 Clinical Objective";
        }

        field(50089; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50090; "Category-Course Description"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Category-Course Description';
            TableRelation = "Subject Category Master";
        }
        field(50091; "Sequence"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Sequence';
            Editable = False;
        }
        field(50092; "School ID"; Code[20])
        {
            Caption = 'SLcM School ID';
            DataClassification = CustomerContent;
            TableRelation = School;
        }
        field(50093; TC; Boolean)
        {
            Caption = 'TC';
            DataClassification = CustomerContent;

        }
        field(50094; "Program ID"; Code[20])
        {
            Caption = 'Program ID';
            DataClassification = CustomerContent;
        }
        field(50095; "Program Description"; Text[100])
        {
            Caption = 'Program Description';
            DataClassification = CustomerContent;
        }
        field(50096; "Program Version Code"; Code[20])
        {
            caption = 'Program Version Code';
            DataClassification = CustomerContent;
        }
        field(50097; "Program Version Description"; Text[100])
        {
            Caption = 'Program Version Description';
            DataClassification = CustomerContent;
        }
        field(50098; "Score Type"; Option)
        {
            Caption = 'Score Type';
            OptionMembers = " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK",KAPLAN,CAS;
            OptionCaption = ' ,CBSE,CCSE,CCSSE,STEP 1,STEP 2 CS, STEP 2 CK,KAPLAN,CAS';
        }
        field(50099; "Original Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50100; "Step Exam"; Option)
        {
            Caption = 'Score Type';
            OptionMembers = " ","Step 1","Step 2 CK","Step 2 CS";
            OptionCaption = ' ,Step 1,Step 2 CK,Step 2 CS';
            Editable = false;
        }
        field(50101; "Score Available Until"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50102; "Date Certified"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50103; "Exam Window"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50104; "Sitting Date"; date)
        {
            DataClassification = CustomerContent;
            Caption = 'Exam Date';
        }
        field(50105; "Exam. Location"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50106; "Published Document No."; code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50107; Published; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50108; "Published Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50109; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(50110; "Modification Date"; Date)
        {
            Caption = 'Modification Date';
            DataClassification = CustomerContent;
        }
        field(50111; "Modified By"; Code[50])
        {
            Caption = 'Modification Date';
            DataClassification = CustomerContent;
        }
        field(50112; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50113; "Exam Sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50114; "Core Clerkship Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Core Clerkship Subject Code';
            TableRelation = "Subject Master-CS";
            trigger OnValidate()
            begin
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Core Clerkship Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN BEGIN
                    "Core Clerkship Subject Desc" := SubjectMasterCS.Description;
                end;
            end;
        }
        field(50115; "Core Clerkship Subject Desc"; text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Core Clerkship Subject Description';
        }
        field(50116; "Shelf Exam Value"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CCSSEScoreConversion: Record "CCSSE Score Conversion";
            begin
                if ("Score Type" = "Score Type"::CCSSE) then begin
                    CCSSEScoreConversion.Reset();
                    CCSSEScoreConversion.SetRange("Course Code", "Core Clerkship Subject Code");
                    CCSSEScoreConversion.SetRange(Score, "Shelf Exam Value");
                    CCSSEScoreConversion.SetFilter("Effective Date", '<=%1', Today);
                    if CCSSEScoreConversion.FindFirst() then
                        Validate("External Mark", CCSSEScoreConversion."Score Value");
                end;
            end;
        }
        field(50117; "Considered in Grading"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50120; Remakrs; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50318; "CBSE Version"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50700; "Grade Book No."; Code[20])
        {
            DataClassification = CustomerContent;

        }


        Field(60000; "USMLE ID"; Text[8])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".UsmleID where("No." = Field("Student No.")));
            Editable = False;

        }
        Field(60001; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'Created By';
            Description = 'CS Field Added 14-05-2019';
            DataClassification = CustomerContent;
        }


        field(33048932; AdClassSchedCode; Code[20])
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'AdClassSchedCode';
            DataClassification = CustomerContent;
        }
        field(33048933; "Start Date"; date)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }


        field(33048935; "End Date"; Date)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }

        field(33048941; Block; boolean)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Block';
            DataClassification = CustomerContent;
        }
        field(33048942; "Blackboard Synch Status"; Option)
        {
            OptionMembers = " ",Pending,Completed,Error;
            OptionCaption = ' ,Pending,Completed,Error';
        }


    }

    keys
    {
        key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code", Section, "Line No.")
        {
        }
        key(Key2; Course, Semester, "Academic Year", "Subject Code")
        {
        }
        key(Key3; Course, Semester, Section, "Academic Year", "Subject Code")
        {
        }
        key(Key4; "Student No.", Semester, Section)
        {
        }
        key(Key5; "Student No.", Semester, Result)
        {
        }
        key(Key6; Course, Semester, Section, "Academic Year")
        {
        }
        key(Key7; "Student No.", Course, Semester, Section, "Subject Code")
        {
        }
        key(Key8; "Student No.", Result)
        {
            SumIndexFields = Credit;
        }
        key(Key9; Course, "Academic Year", Semester, "Student No.")
        {
        }
        key(Key10; "Enrollment No")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id and Mobile Insert Field::CSPL-00092::05-04-2019: Start
        "User ID" := FORMAT(UserId());
        "Creation Date" := today();
        Inserted := true;
    end;

    trigger OnDelete()
    var
        USerSetup_lRec: Record "User Setup";
    begin
        USerSetup_lRec.Reset();
        USerSetup_lRec.SetRange("User ID", UserId());
        If USerSetup_lRec.FindFirst() then
            IF not USerSetup_lRec."SSE Delete Permission" then
                Error('You do not have permission to delete Student Subject Exam entries');


        MainOptionalSubjectLogCS.Reset();
        MainOptionalSubjectLogCS.SETRANGE("Student No.", "Student No.");
        IF MainOptionalSubjectLogCS.FINDLAST() THEN
            LineNo := MainOptionalSubjectLogCS."Line No." + 10000
        ELSE
            LineNo := 10000;

        MainOptionalSubjectLogCS.INIT();
        MainOptionalSubjectLogCS."Student No." := "Student No.";
        MainOptionalSubjectLogCS."Line No." := LineNo;
        MainOptionalSubjectLogCS."Enrollment No." := "Enrollment No";
        MainOptionalSubjectLogCS."Student Name" := "Student Name";
        MainOptionalSubjectLogCS."Subject Code" := "Subject Code";
        MainOptionalSubjectLogCS."Table Type" := MainOptionalSubjectLogCS."Table Type"::"Student Subject Exam";
        MainOptionalSubjectLogCS."Stud. No." := "Student No.";
        MainOptionalSubjectLogCS.Course := Course;
        MainOptionalSubjectLogCS.Semester := Semester;
        MainOptionalSubjectLogCS."Academic Year" := "Academic Year";
        MainOptionalSubjectLogCS."Subject Code" := "Subject Code";
        MainOptionalSubjectLogCS.Section := Section;
        MainOptionalSubjectLogCS."Start Date" := "Sitting Date";
        MainOptionalSubjectLogCS."Document Line No." := "Line No.";
        MainOptionalSubjectLogCS.Marks := "External Mark";
        MainOptionalSubjectLogCS."Score Type" := "Score Type";

        MainOptionalSubjectLogCS."Document Type" := 'Deletion';

        MainOptionalSubjectLogCS."Modified By" := FORMAT(UserId());
        MainOptionalSubjectLogCS."Modified On" := TODAY();
        MainOptionalSubjectLogCS.INSERT();
    end;

    trigger OnModify()
    var
        USerSetup_lRec: Record "User Setup";
    begin
        USerSetup_lRec.Reset();
        USerSetup_lRec.SetRange("User ID", UserId());
        If USerSetup_lRec.FindFirst() then
            IF not USerSetup_lRec."SSE Delete Permission" then
                Error('You do not have permission to delete Student Subject Exam entries');

        //Code added for User Id Assign value in Updated and Mobile Update Field::CSPL-00092::05-04-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        "Modification Date" := Today();
        "Modified By" := FORMAT(UserId());
        // IF "Mobile Insert" = FALSE THEN
        //     IF xRec."Mobile Update" = "Mobile Update" THEN
        //         "Mobile Update" := TRUE;

        //Code added for User Id Assign value in Updated and Mobile Update Field::CSPL-00092::05-04-2019: End
    end;


    var
        StudentMasterCS: Record "Student Master-CS";
        MainOptionalSubjectLogCS: Record "Student Subject Exam Log-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        MakeUpExaminationCS: Record "MakeUp Examination-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";

        LineNo: Integer;
        Text_10001Lbl: Label 'Do You want To Drop Student Subject ? ';



    local procedure CreateStudentSubjectLog()
    begin

        MainOptionalSubjectLogCS.Reset();
        MainOptionalSubjectLogCS.SETRANGE("Student No.", "Student No.");
        IF MainOptionalSubjectLogCS.FINDLAST() THEN
            LineNo := MainOptionalSubjectLogCS."Line No." + 10000
        ELSE
            LineNo := 10000;

        MainOptionalSubjectLogCS.INIT();
        MainOptionalSubjectLogCS."Student No." := "Student No.";
        MainOptionalSubjectLogCS."Line No." := LineNo;
        MainOptionalSubjectLogCS."Enrollment No." := "Enrollment No";
        MainOptionalSubjectLogCS."Student Name" := "Student Name";
        MainOptionalSubjectLogCS."Subject Code" := "Subject Code";
        // MainOptionalSubjectLogCS."Grade Change Type" := "Grade Change Type";
        MainOptionalSubjectLogCS."Table Type" := MainOptionalSubjectLogCS."Table Type"::"Student Subject Exam";
        MainOptionalSubjectLogCS."Stud. No." := "Student No.";
        MainOptionalSubjectLogCS.Course := Course;
        MainOptionalSubjectLogCS.Semester := Semester;
        MainOptionalSubjectLogCS."Academic Year" := "Academic Year";
        MainOptionalSubjectLogCS."Subject Code" := "Subject Code";
        MainOptionalSubjectLogCS.Section := Section;
        MainOptionalSubjectLogCS."Start Date" := "Start Date";
        MainOptionalSubjectLogCS."Document Line No." := "Line No.";
        IF Rec.Semester <> xRec.Semester THEN BEGIN
            MainOptionalSubjectLogCS."Document Type" := 'Semester';
            MainOptionalSubjectLogCS."Old Value" := xRec.Semester;
            MainOptionalSubjectLogCS."New Value" := Rec.Semester;
        END ELSE
            IF Rec.Course <> xRec.Course THEN BEGIN
                MainOptionalSubjectLogCS."Document Type" := 'Course';
                MainOptionalSubjectLogCS."Old Value" := xRec.Course;
                MainOptionalSubjectLogCS."New Value" := Rec.Course;
            END ELSE
                IF Rec.Section <> xRec.Section THEN BEGIN
                    MainOptionalSubjectLogCS."Document Type" := 'Section';
                    MainOptionalSubjectLogCS."Old Value" := xRec.Section;
                    MainOptionalSubjectLogCS."New Value" := Rec.Section;
                END ELSE
                    IF Rec."Internal Mark" <> xRec."Internal Mark" THEN BEGIN
                        MainOptionalSubjectLogCS."Document Type" := 'Internal Mark';
                        MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Internal Mark");
                        MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Internal Mark");
                    END ELSE
                        IF Rec."External Mark" <> xRec."External Mark" THEN BEGIN
                            MainOptionalSubjectLogCS."Document Type" := 'External Mark';
                            MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."External Mark");
                            MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."External Mark");
                        END ELSE
                            IF Rec.Grade <> xRec.Grade THEN BEGIN
                                MainOptionalSubjectLogCS."Document Type" := 'Grade';
                                MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec.Grade);
                                MainOptionalSubjectLogCS."New Value" := FORMAT(Rec.Grade);
                            END ELSE
                                // IF "Attendance Percentage" <> xRec."Attendance Percentage" THEN BEGIN
                                //     MainOptionalSubjectLogCS."Document Type" := 'Attendance Percentage';
                                //     MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Attendance Percentage");
                                //     MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Attendance Percentage");
                                // END ELSE
                                IF Rec.Year <> xRec.Year THEN BEGIN
                                    MainOptionalSubjectLogCS."Document Type" := 'Year';
                                    MainOptionalSubjectLogCS."Old Value" := xRec.Year;
                                    MainOptionalSubjectLogCS."New Value" := Rec.Year;
                                END;
        // IF Rec."Registration Date" <> xRec."Registration Date" THEN BEGIN
        //     MainOptionalSubjectLogCS."Document Type" := 'Registration Date';
        //     MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Registration Date");
        //     MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Registration Date");
        // END ELSE
        // IF Rec."Re-Registration Date" <> xRec."Re-Registration Date" THEN BEGIN
        //     MainOptionalSubjectLogCS."Document Type" := 'Re-Registration Date';
        //     MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Re-Registration Date");
        //     MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Re-Registration Date");
        // END;
        MainOptionalSubjectLogCS."Modified By" := FORMAT(UserId());
        MainOptionalSubjectLogCS."Modified On" := TODAY();
        MainOptionalSubjectLogCS.INSERT();
    end;

    local procedure UpdateDetails()
    begin
        IF Rec.Semester <> xRec.Semester THEN
            CreateStudentSubjectLog()
        ELSE
            IF Rec.Course <> xRec.Course THEN
                CreateStudentSubjectLog()
            ELSE
                IF Rec.Section <> xRec.Section THEN
                    CreateStudentSubjectLog()
                ELSE
                    IF Rec."Internal Mark" <> xRec."Internal Mark" THEN
                        CreateStudentSubjectLog()
                    ELSE
                        IF Rec."External Mark" <> xRec."External Mark" THEN
                            CreateStudentSubjectLog()
                        ELSE
                            IF Rec.Grade <> xRec.Grade THEN
                                CreateStudentSubjectLog()
                            ELSE
                                // IF "Attendance Percentage" <> xRec."Attendance Percentage" THEN
                                //     CreateStudentSubjectLog()
                                // ELSE
                                IF Rec.Year <> xRec.Year THEN
                                    CreateStudentSubjectLog()
    end;


}
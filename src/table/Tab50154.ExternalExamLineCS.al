table 50154 "External Exam Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                 Remarks
    // 1         CSPL-00092    07-05-2019    OnModify                                Assign Value in Updated Field.
    // 2         CSPL-00092    07-05-2019    External Mark - OnValidate            Find Total Marks And Validate Data
    // 3         CSPL-00092    07-05-2019    Student No. - OnValidate              Assign Value in fields
    // 4         CSPL-00092    07-05-2019    Cr Points - OnValidate              Validate Data
    // 5         CSPL-00092    07-05-2019    MAL Practice Level - OnValidate        Find Grade

    Caption = 'External Exam Line-CS';

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
        field(6; "External Mark"; Decimal)
        {
            Caption = 'External Mark';
            DataClassification = CustomerContent;
            MinValue = 0;

            trigger OnValidate()
            var
                GradeMaster: Record "Grade Master-CS";
                MarksWeight: Record "Marks Weightage";
                Sem: Record "Semester Master-CS";
            begin
                //Code added for Find Total Marks And Validate Data::CSPL-00092::07-05-2019: Start
                //TestField("Attendance Type", "Attendance Type"::Present);         //19Nov2021
                Total := "Internal Mark" + "External Mark";
                TestField("External Maximum");
                if "External Mark" > "External Maximum" then
                    Error('Obtained External Marks %1 cannot be more than Maximum External Marks %2', "External Mark", "External Maximum");

                // TESTFIELD(Result, Result::" ");
                // IF "Leave Types" <> '' Then
                //     Error('You Can''t Enter Marks If Student on Leave!!');

                // IF Detained = TRUE THEN
                //     ERROR('You Cannot Enter Marks of a Detained Student !!');
                // "Std. Grade" := '';
                Total := "Internal Mark" + "External Mark";
                "Percentage Obtained" := ROUND((Total / "Total Maximum") * 100, 0.01, '=');

                // GradeMaster.Reset();
                // GradeMaster.SetFilter("Min Percentage", '<=%1', "Percentage Obtained");
                // GradeMaster.SetFilter("Max Percentage", '>=%1', "Percentage Obtained");
                // If GradeMaster.FindFirst() Then
                //     "Std. Grade" := GradeMaster.Code;

                //Code added for Find Total Marks And Validate Data::CSPL-00092::07-05-2019: End


                Sem.Reset();
                Sem.SetRange(Code, Semester);
                Sem.FindFirst();
                Sem.TestField("Total Weightage");


                TestField("Maximum Weightage");
                TestField("Total Maximum");
                "Obtained Weightage" := ("External Mark" / "Total Maximum") * "Maximum Weightage";
                CreateLedgerEntry(Rec);
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
                ExtExamHdr: Record "External Exam Header-CS";
                MarksWeight: Record "Marks Weightage";
                Stud: Record "Student Master-CS";
                ExmMgt: Codeunit "Examination Management";
            begin
                //Code added for Assign Value in fields::CSPL-00092::07-05-2019: Start
                ExtExamHdr.get("Document No.");
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    if ExmMgt.DuplicationFound(ExtExamHdr."Academic Year", ExtExamHdr.Term, ExtExamHdr."Subject Code", ExtExamHdr."Exam Classification", "Student No.", 2) then
                        Error('Duplicate entry found for Student No. %1, Subject Code %2, Academic Year %3, Term %4',
                        "Student No.", ExtExamHdr."Subject Code", ExtExamHdr."Academic Year",
                        ExtExamHdr.Term);
                    Semester := ExtExamHdr.Semester;
                    "Type Of Course" := ExtExamHdr."Type Of Course";
                    "Exam Schedule No." := ExtExamHdr."Exam Schedule Code";
                    Section := ExtExamHdr."Student Group";
                    Course := ExtExamHdr."Course Code";
                    "Exam Classification" := ExtExamHdr."Exam Classification";
                    Term := ExtExamHdr.Term;
                    "Exam Slot" := ExtExamHdr."Exam Slot";
                    "Start Time" := ExtExamHdr."Start Time";
                    "End Time" := ExtExamHdr."End Time";
                    IF StudentMasterCS.Status = 'WITH' then
                        "Attendance Type" := "Attendance Type"::Withdrawal              //19Nov2021
                    Else
                        "Attendance Type" := "Attendance Type"::Present;
                    "Academic Year" := ExtExamHdr."Academic Year";
                    "Subject Class" := ExtExamHdr."Subject Class";
                    "Subject Type" := ExtExamHdr."Subject Type";
                    "Subject Code" := ExtExamHdr."Subject Code";

                    Stud.Reset();
                    Stud.Get("Student No.");
                    "Student Name" := Stud."Student Name";
                    "Original Student No." := Stud."Original Student No.";
                    "Enrollment No." := Stud."Enrollment No.";
                    Batch := ExtExamHdr.Batch;
                    "Student Group" := ExtExamHdr."Student Group";
                    VALIDATE(Status, ExtExamHdr.Status);
                    VALIDATE("Global Dimension 1 Code", ExtExamHdr."Global Dimension 1 Code");
                    Year := ExtExamHdr.Year;
                    "Exam Type" := ExtExamHdr."Exam Type";
                    "Program" := ExtExamHdr."Program";
                    "External Maximum" := ExtExamHdr."External Maximum";
                    "Total Maximum" := ExtExamHdr."Total Maximum";

                    MarksWeight.Reset();
                    MarksWeight.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    MarksWeight.SetRange("Academic Year", "Academic year");
                    MarksWeight.SetRange("Course Code", Course);
                    MarksWeight.SetRange(Semester, Semester);
                    MarksWeight.SetRange("Exam Code", "Subject Code");
                    MarksWeight.SetRange(Term, Term);
                    MarksWeight.FindFirst();
                    MarksWeight.TestField(Points);
                    "Maximum Weightage" := MarksWeight.Points;

                    "Exam Date" := ExtExamHdr."Exam Date";
                    "Created By" := Format(USERID());
                    "Created On" := TODAY();


                END ELSE Begin
                    "Student Name" := '';
                    "Enrollment No." := '';
                    "Roll No." := '';
                    Semester := '';
                    "Academic year" := '';
                    Year := '';
                    Course := '';
                    "Subject Code" := '';
                End;
                //Code added for Assign Value in fields::CSPL-00092::07-05-2019: End
            end;
        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(11; "Internal Mark"; Decimal)
        {
            Caption = 'Internal Mark';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(12; Total; Decimal)
        {
            Caption = 'Total';
            DataClassification = CustomerContent;
        }
        field(13; Result; Option)
        {
            Caption = 'Result';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail,On Hold';
            OptionMembers = " ",Pass,Fail,"On Hold";
        }
        field(14; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            Editable = true;
            OptionCaption = ' ,Present,Absent,Withdrawal';
            OptionMembers = " ",Present,Absent,Withdrawal;
            trigger OnValidate()
            begin
                validate("External Mark", 0);
                CreateLedgerEntry(Rec);
            end;

        }
        field(15; "Std. Grade"; Code[20])
        {
            Caption = 'Std. Grade';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Academic year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(17; "Apply Type"; Option)
        {
            Caption = 'Apply Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Regular,Arrears';
            OptionMembers = " ",Regular,Arrears;
        }
        field(18; "Reason Code"; Code[20])
        {
            TableRelation = "Reason Code".Code where(Type = filter('Attendence'));
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            Begin

                ReasonCode.Reset();
                ReasonCode.SetRange(Code, "Reason Code");
                if ReasonCode.FindFirst() then
                    "Reason Description" := ReasonCode.Description
                else
                    "Reason Description" := '';
            End;
        }
        field(19; "Reason Description"; Text[2048])
        {
            DataClassification = CustomerContent;
        }

        field(21; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
        }
        field(22; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
        }
        field(23; "Total Maximum"; Decimal)
        {
            Caption = 'Total Maximum';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(24; "Old Result-I"; Option)
        {
            Caption = 'Old Result-I';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(25; "Old Result-II"; Option)
        {
            Caption = 'Old Result-II';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(26; "Old Result-III"; Option)
        {
            Caption = 'Old Result-III';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(27; "Cr Points"; Decimal)
        {

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::07-05-2019: Start
                TESTFIELD(Result, Result::" ");  // CORP
                IF Detained = TRUE THEN
                    ERROR('You Cannot Enter Credit Points of a Detained Student !!');
                //Code added for Validate Data::CSPL-00092::07-05-2019: End
            end;
        }
        field(28; "Grace Marks"; Decimal)
        {
            Caption = 'Grace Marks';
            DataClassification = CustomerContent;
        }
        field(29; "External Marks Old Result-I"; Decimal)
        {
            Caption = 'Ext. mark Old Result-I';
            DataClassification = CustomerContent;
        }
        field(30; "External Marks Old Result-II"; Decimal)
        {
            Caption = 'Ext. mark Old Result-II';
            DataClassification = CustomerContent;
        }
        field(31; "External Marks Old Result-III"; Decimal)
        {
            Caption = 'Ext. mark Old Result-I';
            DataClassification = CustomerContent;
        }
        field(32; Detained; Boolean)
        {
            Caption = 'Detained';
            DataClassification = CustomerContent;
        }
        field(33; Absent; Boolean)
        {
            Caption = 'Absent';
            DataClassification = CustomerContent;
        }
        field(34; UFM; Boolean)
        {
            Caption = 'UFM';
            DataClassification = CustomerContent;
        }
        field(35; Dropped; Boolean)
        {
            Caption = 'Dropped';
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
            Caption = 'Type of Course';
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
        field(50015; Year; Code[20])
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
        field(50032; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            OptionCaption = 'Open,Released,Published';
            OptionMembers = Open,Released,Published;
        }
        field(50033; "Attendance %"; Decimal)
        {
            Caption = 'Attendance';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50034; "Grade Generated"; Boolean)
        {
            Caption = 'Grade Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50035; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            OptionCaption = ' ,Regular,Re-Registration,Makeup';
            OptionMembers = " ",Regular,"Re-Registration",Makeup;
        }
        field(50036; "Grade Points"; Integer)
        {
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50037; "Credit Grade Points(CGP)"; Integer)
        {
            Caption = 'Credit Grade Points';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50038; "Rev. Grade"; Code[20])
        {
            Caption = 'Rev. Grade';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50039; "Roll No."; Code[10])
        {
            Caption = 'Roll No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50040; "MAL Practice Level"; Code[20])
        {
            Caption = 'MAL Practive Level';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Discipline MalPractice-CS"."No.";

            trigger OnValidate()
            begin
                //Code added for Find Grade::CSPL-00092::07-05-2019: Start
                IF ("MAL Practice Level" = 'MALPRACTICE') THEN BEGIN
                    IF "Subject Type" = 'CORE' THEN BEGIN
                        MainStudentSubjectCS.Reset();
                        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student No.");
                        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Subject Code", "Subject Code");
                        IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                            MainStudentSubjectCS.Grade := 'F';
                            MainStudentSubjectCS.Modify();
                        END;
                    END ELSE
                        IF "Subject Type" <> 'CORE' THEN BEGIN
                            OptionalStudentSubjectCS.Reset();
                            OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", "Student No.");
                            OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Subject Code", "Subject Code");
                            IF OptionalStudentSubjectCS.FINDFIRST() THEN //BEGIN
                                OptionalStudentSubjectCS.Modify();
                            // OptionalStudentSubjectCS.Grade := 'F';
                            //END;
                        END;
                END ELSE
                    IF ("MAL Practice Level" = 'MEDICAL') OR ("MAL Practice Level" = 'OTHERS') THEN BEGIN
                        IF "Subject Type" = 'CORE' THEN
                            MainStudentSubjectCS.Reset();
                        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student No.");
                        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Subject Code", "Subject Code");
                        IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                            MainStudentSubjectCS.Grade := 'I';
                            MainStudentSubjectCS.Modify()
                        END
                        ELSE
                            IF "Subject Type" <> 'CORE' THEN BEGIN
                                OptionalStudentSubjectCS.Reset();
                                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", "Student No.");
                                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Subject Code", "Subject Code");
                                IF OptionalStudentSubjectCS.FINDFIRST() THEN
                                    //OptionalStudentSubjectCS.Grade := 'I';
                                    OptionalStudentSubjectCS.Modify();

                            END;
                    END;
                //Code added for Find Grade::CSPL-00092::07-05-2019: End
            end;
        }
        field(50041; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50042; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = Employee."No.";
        }
        field(50043; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50044; "Exam Classification"; Code[20])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Examination Type Master-CS".Code WHERE("Exam Type" = FIELD("Document Type"));
        }
        field(50045; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50046; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Subject Classification-CS".Code;
        }
        field(50047; "Marks Published"; Boolean)
        {
            Caption = 'Marks Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50048; "Exam Group"; Code[10])
        {
            Caption = 'Exam Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Sessional Exam Group-CS";
        }
        field(50049; "External Maximum"; Decimal)
        {
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50050; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Batch-CS".Code;
        }

        field(50051; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50052; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50053; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            TableRelation = "Group Master-CS".Code;
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
        field(50056; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50057; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50058; "Leave Types"; Code[20])
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,ELOA,SLOA,CLOA';
            // OptionMembers = " ","ELOA","SLOA","CLOA";
            Editable = false;
        }
        field(50059; "Obtained Weightage"; Decimal)
        {
            Caption = 'Obtained Weightage';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(50060; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(50061; "Original Student No."; Code[20])
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
        field(33048924; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048925; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By name';
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
        key(Key2; Course, Semester, Section, "Academic year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; Course, Semester, "Academic year", "Subject Code")
        {
        }
        key(Key4; "Student No.", Semester)
        {
        }
        key(Key5; Total)
        {
        }

    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: Start
        StudentExamHeader.Reset();
        IF StudentExamHeader.GET("Document No.") THEN BEGIN
            Course := StudentExamHeader."Course Code";
            Semester := StudentExamHeader.Semester;
            Section := StudentExamHeader."Section";
            "Academic year" := StudentExamHeader."Academic Year";
            "Subject Type" := StudentExamHeader."Subject Type";
            "Subject Code" := StudentExamHeader."Subject Code";
            "External Maximum" := StudentExamHeader."External Maximum";
            "Total Maximum" := StudentExamHeader."Total Maximum";
            "Exam Classification" := StudentExamHeader."Exam Classification";
            "Exam Schedule No." := StudentExamHeader."Exam Schedule Code";
            Term := StudentExamHeader.Term;
        END;
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::07-05-2019: Start
        if Status = Status::Published then
            Error('Modification is not allowed as Line No. %1 is Published', "Line No.");
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        //Code added for Assign Value in Updated Field::CSPL-00092::07-05-2019: End
    end;

    trigger OnDelete()
    begin
        if Status = Status::Published then
            Error('Deletion is not allowed as Line No. %1 is Published', "Line No.");
    end;

    var
        // ExternalExamHeaderCS: Record "External Exam Header-CS";

        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        StudentExamHeader: Record "External Exam Header-CS";
    // DecPercentage: Decimal;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //DimensionManagement.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure CreateLedgerEntry(ExtExamLn: Record "External Exam Line-CS")
    var
        ExtExamLnLdgr: Record "External Exam Line Ledger";
        NextLnNo: Integer;
    begin
        NextLnNo := 0;
        ExtExamLnLdgr.Reset();
        if ExtExamLnLdgr.FindLast() then;
        NextLnNo := ExtExamLnLdgr."Entry No." + 1;

        ExtExamLnLdgr.Reset();
        ExtExamLnLdgr.Init();
        ExtExamLnLdgr.TransferFields(ExtExamLn);
        ExtExamLnLdgr."Entry No." := NextLnNo;
        ExtExamLnLdgr.Insert(true);
    end;


}


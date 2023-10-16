table 50072 "Main Student Subject-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    05-04-2019    OnInsert                      User Id Assign in User Id and Mobile Insert Field
    // 2         CSPL-00092    05-04-2019    OnModify                      User Id Assign value in Updated and Mobile Update Field
    // 3         CSPL-00092    05-04-2019    Student No. OnValidate        Value Assign in Student Name And Roll No. Field
    // 4         CSPL-00092    05-04-2019    Semester OnValidate           Update Log
    // 5         CSPL-00092    05-04-2019    Subject Code OnValidate       Asign Value in Fields
    // 6         CSPL-00092    05-04-2019    Course OnValidate             Update Log
    // 7         CSPL-00092    05-04-2019    Section OnValidate            Update log and clear Roll No field
    // 8         CSPL-00092    05-04-2019    Internal Mark OnValidate      Update Log
    // 9         CSPL-00092    05-04-2019    External Mark OnValidate      Update log and Assign value in Total field
    // 10        CSPL-00092    05-04-2019    Attendance Type OnValidate    Validate attendance
    // 12        CSPL-00092    05-04-2019    Grade OnValidate              Validate Grade

    Caption = 'Main Student Subject';
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
                If "Student No." <> '' then begin
                    IF StudentMasterCS.GET("Student No.") THEN BEGIN
                        "Student Name" := StudentMasterCS."Student Name";
                        "Roll No." := StudentMasterCS."Roll No.";
                        "Original Student No." := StudentMasterCS."Original Student No.";
                        "Enrollment No" := StudentMasterCS."Enrollment No.";
                        Validate(Course, StudentMasterCS."Course Code");
                        Validate(Semester, StudentMasterCS.Semester);
                        Validate("Academic Year", StudentMasterCS."Academic Year");
                        Validate(Term, StudentMasterCS.Term);
                        "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                    end;
                END ELSE begin
                    "Student Name" := '';
                    "Roll No." := '';
                    "Original Student No." := '';
                    "Enrollment No" := '';
                    Validate(Course, '');
                    Validate(Semester, '');
                    Validate("Academic Year", '');
                    Term := Term::" ";
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                End;
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
                CourseSemesterMasterRec: Record "Course Sem. Master-CS";
            begin
                //Code added for Update log::CSPL-00092::05-04-2019: Start
                UpdateDetails();
                SemesterRec.Reset();
                SemesterRec.SetRange(Code, Semester);
                If SemesterRec.FindFirst() then
                    Sequence := SemesterRec.Sequence;

                //   if Level = 1 then begin
                CourseSemesterMasterRec.Reset();
                CourseSemesterMasterRec.SetRange("Course Code", Course);
                CourseSemesterMasterRec.SetRange("Semester Code", Semester);
                CourseSemesterMasterRec.SetRange("Academic Year", "Academic Year");
                CourseSemesterMasterRec.SetRange(Term, Term);
                if CourseSemesterMasterRec.FindFirst() then begin
                    "Start Date" := CourseSemesterMasterRec."Start Date";
                    "End Date" := CourseSemesterMasterRec."End Date";
                end;
                // end;

                //Code added for Update log::CSPL-00092::05-04-2019: End
            end;
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = "Subject Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CourseSubjectMaster_lRec: Record "Course Wise Subject Line-CS";
            begin
                //Code added for Assign Value in Fields::CSPL-00092::05-04-2019: Start
                Clear(Duration);
                "Type of Subject" := "Type of Subject"::" ";
                "Subject Group" := '';
                Level := 0;
                "Level Description" := "Level Description"::" ";
                "Core Rotation Group" := '';
                Examination := false;

                CourseSubjectMaster_lRec.Reset();
                CourseSubjectMaster_lRec.SetRange("Course Code", Rec.Course);
                CourseSubjectMaster_lRec.SetRange(Semester, Rec.Semester);
                CourseSubjectMaster_lRec.SetRange("Academic Year", Rec."Academic Year");
                CourseSubjectMaster_lRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                CourseSubjectMaster_lRec.SetRange("Subject Code", Rec."Subject Code");
                IF CourseSubjectMaster_lRec.FindFirst() then begin
                    IF CourseSubjectMaster_lRec."Global Dimension 1 Code" = '9000' then begin
                        IF (CourseSubjectMaster_lRec.Level = 1) or (CourseSubjectMaster_lRec.Examination = True) then begin
                            Description := CourseSubjectMaster_lRec.Description;
                            Specilization := CourseSubjectMaster_lRec.Specilization;
                            "Type Of Course" := CourseSubjectMaster_lRec."Type Of Course";
                            "Subject Type" := CourseSubjectMaster_lRec."Subject Type";
                            "Subject Class" := CourseSubjectMaster_lRec."Subject Classification";
                            "Internal Maximum" := CourseSubjectMaster_lRec."Internal Maximum";
                            "External Maximum" := CourseSubjectMaster_lRec."External Maximum";
                            "Program/Open Elective Temp" := CourseSubjectMaster_lRec."Program/Open Elective Temp";
                            "Global Dimension 1 Code" := CourseSubjectMaster_lRec."Global Dimension 1 Code";
                            "Global Dimension 2 Code" := CourseSubjectMaster_lRec."Global Dimension 2 Code";
                            Duration := CourseSubjectMaster_lRec.Duration;
                            "Type of Subject" := CourseSubjectMaster_lRec."Type of Subject";
                            "Subject Group" := CourseSubjectMaster_lRec."Subject Group";
                            Level := CourseSubjectMaster_lRec.Level;
                            "Level Description" := CourseSubjectMaster_lRec."Level Description";
                            "Core Rotation Group" := CourseSubjectMaster_lRec."Core Rotation Group";
                            Examination := CourseSubjectMaster_lRec.Examination;
                        end;
                    end;
                    IF CourseSubjectMaster_lRec."Global Dimension 1 Code" = '9100' then begin
                        If (CourseSubjectMaster_lRec.Level = 1) then begin
                            Description := CourseSubjectMaster_lRec.Description;
                            Specilization := CourseSubjectMaster_lRec.Specilization;
                            "Type Of Course" := CourseSubjectMaster_lRec."Type Of Course";
                            "Subject Type" := CourseSubjectMaster_lRec."Subject Type";
                            "Subject Class" := CourseSubjectMaster_lRec."Subject Classification";
                            "Internal Maximum" := CourseSubjectMaster_lRec."Internal Maximum";
                            "External Maximum" := CourseSubjectMaster_lRec."External Maximum";
                            "Program/Open Elective Temp" := CourseSubjectMaster_lRec."Program/Open Elective Temp";
                            "Global Dimension 1 Code" := CourseSubjectMaster_lRec."Global Dimension 1 Code";
                            "Global Dimension 2 Code" := CourseSubjectMaster_lRec."Global Dimension 2 Code";
                            Duration := CourseSubjectMaster_lRec.Duration;
                            "Type of Subject" := CourseSubjectMaster_lRec."Type of Subject";
                            "Subject Group" := CourseSubjectMaster_lRec."Subject Group";
                            Level := CourseSubjectMaster_lRec.Level;
                            "Level Description" := CourseSubjectMaster_lRec."Level Description";
                            "Core Rotation Group" := CourseSubjectMaster_lRec."Core Rotation Group";
                            Examination := CourseSubjectMaster_lRec.Examination;
                        end;
                    end;
                end else begin
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETRANGE(Code, "Subject Code");
                    IF SubjectMasterCS.FINDFIRST() THEN BEGIN
                        Description := SubjectMasterCS.Description;
                        Specilization := SubjectMasterCS.Specilization;
                        "Type Of Course" := SubjectMasterCS."Type Of Course";
                        "Subject Type" := SubjectMasterCS."Subject Type";
                        "Subject Class" := SubjectMasterCS."Subject Classification";
                        "Internal Maximum" := SubjectMasterCS."Internal Maximum";
                        "External Maximum" := SubjectMasterCS."External Maximum";
                        "Program/Open Elective Temp" := SubjectMasterCS."Program/Open Elective Temp";
                        "Global Dimension 1 Code" := SubjectMasterCS."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := SubjectMasterCS."Global Dimension 2 Code";
                        Duration := SubjectMasterCS.Duration;
                        "Type of Subject" := SubjectMasterCS."Type of Subject";
                        "Subject Group" := SubjectMasterCS."Subject Group";
                        Level := SubjectMasterCS.Level;
                        "Level Description" := SubjectMasterCS."Level Description";
                        "Core Rotation Group" := SubjectMasterCS."Core Rotation Group";
                        Examination := SubjectMasterCS.Examination;
                    END;
                    //Code added for Assign Value in Fields::CSPL-00092::05-04-2019: Start
                End;
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
        field(6; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            TableRelation = "Subject Type-CS";
            DataClassification = CustomerContent;
        }
        field(7; Course; Code[20])
        {
            Caption = 'Course';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CourseMaster_lRec: Record "Course Master-CS";
            begin
                //Code added for Update log::CSPL-00092::05-04-2019: Start
                UpdateDetails();
                CourseMaster_lRec.Reset();
                CourseMaster_lRec.SetRange(Code, Rec.Course);
                IF CourseMaster_lRec.FindFirst() then begin
                    // "Category-Course Description" := CourseMaster_lRec."Category Code";
                    IF CourseMaster_lRec."Non Degree" then
                        "Non Degree" := true;
                end;
                //Code added for Update log::CSPL-00092::05-04-2019: End
            end;
        }
        field(8; Section; Code[10])
        {
            Caption = 'Section';
            // TableRelation = "Section Master-CS";
            TableRelation = "Group Master-CS".Code;

            DataClassification = CustomerContent;

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
            begin
                //Code added for Update log and Assign value in Total field::CSPL-00092::05-04-2019: Start
                UpdateDetails();
                IF "External Mark" <> 0 THEN
                    Total := "Total Internal" + "External Mark";
                //Code added for Update log and Assign value in Total field::CSPL-00092::05-04-2019: End
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
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
            DataClassification = CustomerContent;
        }
        field(13; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            OptionCaption = ' ,Present,Absent,On Duty,Leave';
            OptionMembers = " ",Present,Absent,"On Duty",Leave;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate attendance ::CSPL-00092::05-04-2019: Start
                UpdateAttendance();
                //Code added for Validate attendance ::CSPL-00092::05-04-2019: End
            end;
        }
        field(14; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = "Grade Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GradeMaster: Record "Grade Master-CS";
                SubMas: Record "Subject Master-CS";
                StudentTimelineRec: Record "Student Time Line";
                UserSetup: Record "User Setup";
                StuMaster: Record "Student Master-CS";
                SemesterMaster: Record "Semester Master-CS";
                EditList: Boolean;

            begin
                //11.8.2021-->Start
                Clear(StuMaster);
                IF StuMaster.Get(Rec."Student No.") THEN begin
                    IF StuMaster."Student SFP Initiation" <> 0 then begin
                        StuMaster.Validate(StuMaster."SAFI Sync", StuMaster."SAFI Sync"::Pending);
                        SemesterMaster.Reset();
                        SemesterMaster.SetRange(Code, StuMaster.Semester);
                        SemesterMaster.SetRange(Sequence, 1);
                        IF SemesterMaster.FindFirst() then
                            IF Rec.Grade = 'W' then
                                StuMaster."Incoming Cohort" := '';
                        StuMaster.Modify(True);
                    end;
                end;
                //11.8.2021-->END
                TestField("Global Dimension 1 Code");
                EditList := false;
                IF UserSetup.GET(UserId()) THEN
                    IF UserSetup."Grade Modify Allowed" THEN
                        EditList := TRUE
                    ELSE
                        EditList := FALSE;
                if not EditList then
                    Error('You are not authorized.');
                if Grade <> '' then begin
                    GradeMaster.Reset();
                    GradeMaster.SetRange(code, Grade);
                    GradeMaster.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    GradeMaster.FindFirst();
                    if GradeMaster."Grade Points" = 0 then begin
                        "Credit Earned" := 0;

                        If GradeMaster."Update Credit Attempt" then begin
                            SubMas.Reset();
                            SubMas.SetRange(code, "Subject Code");
                            IF SubMas.FindFirst() then
                                "Credits Attempt" := SubMas.Credit;
                        end;

                    end else begin
                        SubMas.Reset();
                        SubMas.SetRange(code, "Subject Code");
                        SubMas.FindFirst();
                        begin
                            Credit := SubMas.Credit;
                            "Credit Earned" := SubMas.Credit;
                            "Credits Attempt" := SubMas.Credit;
                        end;
                    end;

                    IF Rec.Grade <> xRec.Grade then
                        StudentTimelineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'For ' + Rec.Description + ' Grade has been changed ' + xRec.Grade + ' to ' + Rec.Grade, UserId(), Today());
                end;
                "Grade Confirmed" := false;

                UpdateDetails();


                //Code added for Validate Grade ::CSPL-00092::05-04-2019: Start
                // IF (Grade = 'A+') OR (Grade = 'A') OR (Grade = 'B') OR (Grade = 'C') OR (Grade = 'D') OR (Grade = 'E') THEN BEGIN
                //     "Credit Earned" := Credit;

                //     IF Grade = 'A+' THEN
                //         "Credit Grade Points Earned" := 10 * "Credit Earned";

                //     IF Grade = 'A' THEN
                //         "Credit Grade Points Earned" := 9 * "Credit Earned";

                //     IF Grade = 'B' THEN
                //         "Credit Grade Points Earned" := 8 * "Credit Earned";

                //     IF Grade = 'C' THEN
                //         "Credit Grade Points Earned" := 7 * "Credit Earned";

                //     IF Grade = 'D' THEN
                //         "Credit Grade Points Earned" := 6 * "Credit Earned";

                //     IF Grade = 'E' THEN
                //         "Credit Grade Points Earned" := 5 * "Credit Earned";

                // END ELSE BEGIN
                //     "Credit Earned" := 0;
                //     "Credit Grade Points Earned" := 0;
                // END;

                // IF Revaluation1 = TRUE THEN BEGIN
                //     "Attendance Detail" := 'Revaluation1';
                //     IF "Attendance Detail" = 'Revaluation1' THEN
                //         IF (Grade = 'A+') OR (Grade = 'A') OR (Grade = 'B') OR (Grade = 'C') OR (Grade = 'D') OR (Grade = 'E') THEN BEGIN
                //             MakeUpExaminationCS.Reset();
                //             MakeUpExaminationCS.SETRANGE("Student No.", "Student No.");
                //             MakeUpExaminationCS.SETRANGE(Semester, "Actual Semester");
                //             MakeUpExaminationCS.SETRANGE("Subject Code", "Actual Subject Code");
                //             MakeUpExaminationCS.SETRANGE("Academic Year", "Academic Year");
                //             IF MakeUpExaminationCS.FINDFIRST() THEN BEGIN
                //                 MakeUpExaminationCS.Cancel := TRUE;
                //                 MakeUpExaminationCS.Modify();
                //                 "Make Up Examination" := FALSE;
                //             END;

                //             RegistrationStudentCS.Reset();
                //             RegistrationStudentCS.SETRANGE("Student No.", "Student No.");
                //             RegistrationStudentCS.SETRANGE(Semester, "Actual Semester");
                //             RegistrationStudentCS.SETRANGE("Subject Code", "Actual Subject Code");
                //             RegistrationStudentCS.SETRANGE("Academic Year", "Academic Year");
                //             IF RegistrationStudentCS.FINDFIRST() THEN BEGIN
                //                 RegistrationStudentCS.Cancel := TRUE;
                //                 RegistrationStudentCS.Modify();
                //                 "Re-Registration" := FALSE;
                //             END;
                //         END;
                // END ELSE
                //     IF Revaluation2 = TRUE THEN BEGIN
                //         "Attendance Detail" := 'Revaluation2';
                //         IF "Attendance Detail" = 'Revaluation2' THEN
                //             IF (Grade = 'A+') OR (Grade = 'A') OR (Grade = 'B') OR (Grade = 'C') OR (Grade = 'D') OR (Grade = 'E') THEN BEGIN
                //                 MakeUpExaminationCS.Reset();
                //                 MakeUpExaminationCS.SETRANGE("Student No.", "Student No.");
                //                 MakeUpExaminationCS.SETRANGE(Semester, "Actual Semester");
                //                 MakeUpExaminationCS.SETRANGE("Subject Code", "Actual Subject Code");
                //                 MakeUpExaminationCS.SETRANGE("Academic Year", "Academic Year");
                //                 IF MakeUpExaminationCS.FINDFIRST() THEN BEGIN
                //                     MakeUpExaminationCS.Cancel := TRUE;
                //                     MakeUpExaminationCS.Modify();
                //                     "Make Up Examination" := FALSE;
                //                 END;

                //                 RegistrationStudentCS.Reset();
                //                 RegistrationStudentCS.SETRANGE("Student No.", "Student No.");
                //                 RegistrationStudentCS.SETRANGE(Semester, "Actual Semester");
                //                 RegistrationStudentCS.SETRANGE("Subject Code", "Actual Subject Code");
                //                 RegistrationStudentCS.SETRANGE("Academic Year", "Academic Year");
                //                 IF RegistrationStudentCS.FINDFIRST() THEN BEGIN
                //                     RegistrationStudentCS.Cancel := TRUE;
                //                     RegistrationStudentCS.Modify();
                //                     "Re-Registration" := FALSE;
                //                 END;
                //             END;
                //     END;


                //Code added for Validate Grade ::CSPL-00092::05-04-2019: End
            end;
        }
        field(20; Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = CustomerContent;
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
            trigger OnValidate()
            begin
                UpdateDetails();
            end;
        }
        field(23; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
        }
        field(24; "Attendance Percentage"; Decimal)
        {
            Caption = 'Attendance Percentage';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateDetails();

                IF "Attendance Percentage" >= "Applicable Attendance per" THEN
                    Detained := FALSE
                ELSE
                    Detained := TRUE;

                UpdateAttendance();
            end;
        }
        field(25; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(26; "Attendance % as on Date"; Date)
        {
            Caption = 'Attendance % as on Date';
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
        field(29; Specilization; Code[100])
        {
            Caption = 'Specilization';
            DataClassification = CustomerContent;
        }
        field(30; Detained; Boolean)
        {
            Caption = 'Detained';
            DataClassification = CustomerContent;
        }
        field(31; "Attendance Detail"; Text[80])
        {
            Caption = 'Attendance Detail';
            DataClassification = CustomerContent;
        }
        field(32; Absent; Boolean)
        {
            Caption = 'Absent';
            DataClassification = CustomerContent;
        }
        field(33; "Main Exam Result Updated"; Boolean)
        {
            Caption = 'Main Exam Result Updated';
            DataClassification = CustomerContent;
        }
        field(50; "Grace Marks"; Integer)
        {
        }
        field(70; "Re-Appear External Marks"; Decimal)
        {
            Editable = false;
            Caption = 'Re-Appear External Marks';
            DataClassification = CustomerContent;
        }
        field(71; "Re-Appear Total"; Decimal)
        {
            Editable = false;
            Caption = 'Re-Appear Total';
            DataClassification = CustomerContent;
        }
        field(72; "Re-Appear Result"; Integer)
        {
            Editable = false;
            Caption = 'Re-Appear Result';
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
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 14-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Final Year Course';
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
            trigger OnValidate()
            begin
                UpdateDetails();
            end;
        }
        field(50030; "Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Credit Earned';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateDetails();
            end;
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
        field(50033; "Selected Subject"; Code[10])
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Selected Subject';
            DataClassification = CustomerContent;
        }
        field(50034; "Selected Sub. Name"; Text[50])
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Selected Subject Name';
            DataClassification = CustomerContent;
        }
        field(50035; "Subject Class"; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Subject Classification-CS";
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
        }
        field(50036; "Re- Register"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Re-Register';
            DataClassification = CustomerContent;
        }
        field(50037; "Grace Criteria"; Option)
        {
            Description = 'CS Field Added 14-05-2019';
            OptionCaption = ' ,External,Total';
            OptionMembers = " ",External,Total;
            Caption = 'Grade Criteria';
            DataClassification = CustomerContent;
        }
        field(50038; Publish; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Publish';
            DataClassification = CustomerContent;
        }
        field(50039; "Re-Registration"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Re-Registration';
            DataClassification = CustomerContent;
        }
        field(50040; "Re-Apply"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Re-Apply';
            DataClassification = CustomerContent;
        }
        field(50041; "Assignment Marks"; Decimal)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Assignment';
            DataClassification = CustomerContent;
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
        field(50044; "Elective Group Code"; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Elective Group Code';
            DataClassification = CustomerContent;
        }
        field(50046; "Program/Open Elective Temp"; Option)
        {
            Description = 'CS Field Added 14-05-2019';
            OptionCaption = ' ,Open Elective Common Subject,Program Elective Common Subject';
            OptionMembers = " ","Open Elective Common Subject","Program Elective Common Subject";
            Caption = 'Program/Open Elective Temp';
            DataClassification = CustomerContent;
        }
        field(50047; "Exam Fee"; Decimal)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Exam Fee';
            DataClassification = CustomerContent;
        }
        field(50048; "Registration Date"; Date)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Registration Date';
            DataClassification = CustomerContent;
        }
        field(50049; "Re-Registration Date"; Date)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Re-Registration Date';
            DataClassification = CustomerContent;
        }
        field(50050; "Grade Change Type"; Option)
        {
            Description = 'CS Field Added 14-05-2019';
            OptionCaption = ' ,Revaluation,MakeUp';
            OptionMembers = " ",Revaluation,MakeUp;
            Caption = 'Grade Change Type';
            DataClassification = CustomerContent;
        }
        field(50051; Graduation; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Graduation Master-CS".Code;
            Caption = 'Graduation';
            DataClassification = CustomerContent;
        }
        field(50052; "Internal Marks Updated"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Internal Marks Updated';
            DataClassification = CustomerContent;
        }
        field(50053; "External Marks Updated"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'External Marks Updated';
            DataClassification = CustomerContent;
        }
        field(50054; "Actual Semester"; Code[10])
        {
            Description = 'CS Field Added 14-05-2019';
            Editable = true;
            TableRelation = "Semester Master-CS".Code;
            Caption = 'Actual Semester';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF ("Actual Semester" = 'I') OR ("Actual Semester" = 'II') THEN
                    "Actual Year" := '1st';
            end;
        }
        field(50055; "Actual Year"; Code[10])
        {
            Description = 'CS Field Added 14-05-2019';
            Editable = true;
            TableRelation = "Year Master-CS";
            Caption = 'Actual Year';
            DataClassification = CustomerContent;
        }
        field(50056; "Actual Academic Year"; Code[10])
        {
            Description = 'CS Field Added 14-05-2019';
            Editable = true;
            TableRelation = "Academic Year Master-CS".Code;
            Caption = 'Actual Academic Year';
            DataClassification = CustomerContent;
        }
        field(50057; "Actual Subject Code"; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            Editable = true;
            TableRelation = "Subject Master-CS";
            Caption = 'Actual Subject Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Actual Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN
                    "Actual Subject Description" := SubjectMasterCS.Description;

            end;
        }
        field(50058; "Actual Subject Description"; Text[100])
        {
            Description = 'CS Field Added 14-05-2019';
            Editable = true;
            Caption = 'Actual Subject Description';
            DataClassification = CustomerContent;
        }
        field(50059; "Make Up Examination"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Makeup Examination';
            DataClassification = CustomerContent;
        }
        field(50060; Revaluation1; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Revaluation 1';
            DataClassification = CustomerContent;
        }
        field(50061; Revaluation2; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Revaluation 2';
            DataClassification = CustomerContent;
        }
        field(50062; "Special Exam"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Special Exam';
            DataClassification = CustomerContent;
        }
        field(50063; "Re-Registration Exam Only"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Re-Registration Exam Only';
            DataClassification = CustomerContent;
        }
        field(50064; "Total Class Held"; Integer)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Total Class Held';
            DataClassification = CustomerContent;
        }
        field(50065; "Total Attendance Taken"; Integer)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Total Attendance Taken';
            DataClassification = CustomerContent;
        }
        field(50066; "Present Count"; Integer)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Present Count';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Absent Count" := "Total Attendance Taken" - "Present Count";
                "Attendance Percentage" := ROUND(("Present Count" / "Total Attendance Taken") * 100, 1, '>');

                IF "Attendance Percentage" >= "Applicable Attendance per" THEN BEGIN
                    Detained := FALSE;
                    "Attendance Type" := "Attendance Type"::Present;
                END ELSE BEGIN
                    Detained := TRUE;
                    "Attendance Type" := "Attendance Type"::Absent;
                END;

                UpdateAttendance();
            end;
        }
        field(50067; "Absent Count"; Integer)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Absent Count';
            DataClassification = CustomerContent;
        }
        field(50068; "Subject Drop"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Subject Drop';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF "Subject Drop" = TRUE THEN
                    IF CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETRANGE("Academic Year", "Academic Year");
                        IF "Type Of Course" = "Type Of Course"::Semester THEN
                            ClassAttendanceLineCS.SETRANGE(Semester, Semester)
                        ELSE
                            ClassAttendanceLineCS.SETRANGE(Year, Year);
                        ClassAttendanceLineCS.SETRANGE("Subject Code", "Subject Code");
                        ClassAttendanceLineCS.SETRANGE("Student No.", "Student No.");
                        ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            ClassAttendanceLineCS.DELETEALL();
                        Rec.RENAME(Rec."Student No.", Rec.Course, Rec.Semester, Rec."Academic Year", Rec."Subject Code", '');
                        Rec."Roll No." := '';
                        Rec.Batch := '';
                        Modify();
                    END;


            end;
        }
        field(50069; "Subject Pass Date"; Date)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Subject Pass Date';
            DataClassification = CustomerContent;
        }
        field(50070; "Previous Detained Status"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Previous Detained Status';
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
        field(50073; "Mobile Insert"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(50074; "Mobile Update"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Mobile Updated';
            DataClassification = CustomerContent;
        }
        field(50075; "Mobile Result"; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Mobile Result';
            DataClassification = CustomerContent;
        }
        field(50076; "Current Session"; Code[50])
        {
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Session Master-CS";
            Caption = 'Current Session';
            DataClassification = CustomerContent;
        }
        field(50077; "Previous Session"; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Session Master-CS";
            Caption = 'Previous Session';
            DataClassification = CustomerContent;
        }
        field(50078; "Actual Session"; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Session Master-CS";
            Caption = 'Actual Session';
            DataClassification = CustomerContent;
        }
        field(50080; Duration; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(50081; "Type of Subject"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Core,Elective,"Open Elective","FM1/IM1",Other;
            Caption = 'Type of Subject';
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
            trigger OnValidate()
            begin
                Validate(Semester);
            end;
        }
        field(50085; "Level Description"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Level Description';
            OptionMembers = " ","Main Subject","Level 2 Systems","Level 3 Topics","Internal Exam Component","External Examination","Level 2 Clinical Rotation","Clinical Shelf Examination","Prep Examination","Level 2 Elective Rotation","Level 3 Exam","Level 3 Component","Level 3 Clinical Objective";
        }
        field(50086; "Core Rotation Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Core Rotation Group';
            TableRelation = "Subject Master-CS".Code;
        }
        field(50087; "Examination"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Examination';
        }
        field(50088; "SLcM Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'SLcM Subject Code';
        }
        field(50089; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER, ';
            OptionMembers = FALL,SPRING,SUMMER," ";
            trigger OnValidate()
            begin
                If Term = Term::FALL then
                    "Term Sequence" := 3;
                IF Term = Term::SPRING then
                    "Term Sequence" := 1;
                IF Term = Term::SUMMER then
                    "Term Sequence" := 2;
            end;
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
        field(50094; "Term Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Term Description';
            Editable = false;
        }
        // field(50095; "Goal Code"; text[100])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Goal Code';
        // }

        field(50095; Inserted; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Inserted';
        }

        field(50096; "Original Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50097; "Grade Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentTimelineRec: Record "Student Time Line";
                UserSetup: Record "User Setup";
                EditList: Boolean;

            begin
                EditList := false;
                IF UserSetup.GET(UserId()) THEN
                    IF UserSetup."Grade Modify Allowed" THEN
                        EditList := TRUE
                    ELSE
                        EditList := FALSE;
                if not EditList then
                    Error('You are not authorized.');

                If "Grade Confirmed" then
                    StudentTimelineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'Grade Confirmed has been changed to TRUE', UserId(), Today());

            end;
        }

        field(50098; "Term Sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50099; "Non Degree"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50100; "Semester Break"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50101; "Course Prefix"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50102; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50103; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50104; "Dean's Honor Roll"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            Var
                CourseMAster: Record "Course Master-CS";
            Begin
                If "Dean's Honor Roll" then begin
                    CourseMAster.Reset();
                    CourseMAster.SetRange(Code, Rec.Course);
                    CourseMAster.SetRange("Course Change Allowed", false);
                    If CourseMAster.FindFirst() then
                        Error(Rec.FieldCaption("Dean's Honor Roll") + ' is not applicable for %1.', Rec.Course);
                end;
            End;
        }
        field(60000; "Exist in Rotation"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Roster Ledger Entry" where("Student ID" = field("Student No."), "Course Code" = field("Subject Code"), "Start Date" = field("Start Date")));
        }
        field(60001; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60002; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(60003; "Grade Book No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(60004; "Communications"; text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(65000; "Small Group / Section"; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                If "Lab Group" <> '' then
                    If "Small Group / Section" <> '' then
                        Error('Either Small Group/Section Or Lab Group must have as value.');
            end;

            trigger OnLookup()
            var
                SectionMaster_lRec: Record "Section Master-CS";
                SectionList_lPage: Page "Sections List-CS";
            Begin
                Clear(SectionList_lPage);
                SectionMaster_lRec.Reset();
                SectionList_lPage.SetTableView(SectionMaster_lRec);
                SectionList_lPage.LookupMode := true;
                IF SectionList_lPage.RunModal() = Action::LookupOK then begin
                    repeat
                        IF SectionMaster_lRec.Selection then begin
                            IF "Small Group / Section" = '' then
                                "Small Group / Section" := SectionMaster_lRec.Code
                            Else
                                "Small Group / Section" += '|' + SectionMaster_lRec.Code;
                            SectionMaster_lRec.Selection := false;
                            SectionMaster_lRec.Modify();
                        end;
                    until SectionMaster_lRec.Next() = 0;
                end;
                Validate(Section);
            End;
        }
        field(65001; "Lab Group"; Text[30])
        {
            DataClassification = CustomerContent;
            Trigger OnValidate()
            begin

                If "Small Group / Section" <> '' then
                    If "Lab Group" <> '' then
                        Error('Either Small Group/Section Or Lab Group must have as value.');
            end;

            Trigger OnLookup()
            var
                Batch_lRec: Record "Batch-CS";
                BatchDetail_lPage: Page "Batch Detail-CS";
            Begin
                TestField("Subject Class", 'LAB');
                Batch_lRec.Reset();
                Clear(BatchDetail_lPage);
                BatchDetail_lPage.SetTableView(Batch_lRec);
                BatchDetail_lPage.LookupMode := True;
                IF BatchDetail_lPage.RunModal() = Action::LookupOK then begin
                    Repeat
                        If Batch_lRec.Selection then begin
                            IF Batch = '' then
                                "Lab Group" := Batch_lRec.Code
                            Else
                                "Lab Group" += '|' + Batch_lRec.Code;
                            Batch_lRec.Selection := false;
                            Batch_lRec.Modify();
                        end;
                    until Batch_lRec.Next() = 0;
                end;
                Validate(Batch);
            end;
        }
        Field(99988; GPA; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(99994; Failed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(99996; "Recommendation"; Text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Recommendation';
        }
        field(99997; "% Range"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = '% Range';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 14-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 14-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048923; UFM; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'UFM';
            DataClassification = CustomerContent;
        }
        field(33048924; Inactive; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Inactive';
            DataClassification = CustomerContent;
        }
        field(33048925; Dropped; Boolean)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Dropped';
            DataClassification = CustomerContent;
        }
        field(33048926; "Internal Maximum"; Decimal)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Internal Minimum';
            DataClassification = CustomerContent;
        }
        field(33048927; "External Maximum"; Decimal)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
        }
        field(33048928; Group; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            TableRelation = "Group Master-CS".Code;
            Caption = 'Group';
            DataClassification = CustomerContent;
        }
        field(33048929; Batch; Code[20])
        {
            Description = 'CS Field Added 14-05-2019';
            ////TableRelation = "Batch-CS".Code;
            Caption = 'Batch';
            DataClassification = CustomerContent;

        }
        field(33048930; "Roll No."; Code[10])
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
        }
        field(33048931; "Applicable Attendance per"; Decimal)
        {
            Description = 'CS Field Added 14-05-2019';
            Caption = 'Applicable Attendance percent';
            DataClassification = CustomerContent;
        }
        //

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
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                Clear(StudentMaster);
                IF StudentMaster.get("Student No.") then begin
                    IF StudentMaster."Student SFP Initiation" <> 0 then begin
                        StudentMaster.validate("SAFI Sync", StudentMaster."SAFI Sync"::Pending);
                        StudentMaster.Modify(True);
                    end;
                end;
            end;
        }

        field(33048934; "Expected End Date"; date)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Expected End Date';
            DataClassification = CustomerContent;

        }
        field(33048935; "End Date"; Date)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'End Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                Clear(StudentMaster);
                IF StudentMaster.get("Student No.") then begin
                    If StudentMaster."Student SFP Initiation" <> 0 then begin
                        StudentMaster.validate("SAFI Sync", StudentMaster."SAFI Sync"::Pending);
                        StudentMaster.Modify(True);
                    end;
                end;
            end;
        }
        field(33048936; "Date Grade Posted"; date)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Date Grade Posted';
            DataClassification = CustomerContent;
        }
        field(33048937; "Status"; Text[1])
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(33048938; "Numeric Grade"; Decimal)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Numeric Grade';
            DataClassification = CustomerContent;
        }
        field(33048939; "Credits Attempt"; Decimal)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Credits Attempt';
            DataClassification = CustomerContent;
        }
        field(33048940; "Max Students"; Integer)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Max Students';
            DataClassification = CustomerContent;
        }
        field(33048941; Block; boolean)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Block';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code", Section, "Start Date")
        {
            SumIndexFields = Points;
        }
        key(Key2; Course, Semester, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; Course, Semester, Section, "Academic Year", "Subject Type", "Subject Code")
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
        key(Key7; "Student No.", Course, Semester, Section, "Subject Type", "Subject Code")
        {
        }
        key(Key8; "Student No.", Result)
        {
            SumIndexFields = Credit;
        }
        key(Key9; Course, "Academic Year", Semester, "Student No.")
        {
        }
        key(Key10; "Subject Class")
        {
        }
        key(Key11; "Enrollment No")
        {
        }
        Key(Key12; "Student No.", Semester, Sequence, TC, Grade, "Credits Attempt", "Credit Earned")
        {

        }
        key(Key13; Level)
        {

        }
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id and Mobile Insert Field::CSPL-00092::05-04-2019: Start
        "User ID" := FORMAT(UserId());
        "Mobile Insert" := TRUE;

        Inserted := True;
        //Code added for User Id Assign in User Id and Mobile Insert Field::CSPL-00092::05-04-2019: End
    end;

    trigger OnDelete()
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
        MainOptionalSubjectLogCS."Grade Change Type" := "Grade Change Type";
        MainOptionalSubjectLogCS."Table Type" := MainOptionalSubjectLogCS."Table Type"::"Student Subject";
        MainOptionalSubjectLogCS."Stud. No." := "Student No.";
        MainOptionalSubjectLogCS.Course := Course;
        MainOptionalSubjectLogCS.Semester := Semester;
        MainOptionalSubjectLogCS."Academic Year" := "Academic Year";
        MainOptionalSubjectLogCS."Subject Code" := "Subject Code";
        MainOptionalSubjectLogCS.Section := Section;
        MainOptionalSubjectLogCS."Start Date" := "Start Date";

        MainOptionalSubjectLogCS."Document Type" := 'Deletion';

        MainOptionalSubjectLogCS."Modified By" := FORMAT(UserId());
        MainOptionalSubjectLogCS."Modified On" := TODAY();
        MainOptionalSubjectLogCS.INSERT();
    end;

    trigger OnModify()
    var
        StudentMasterRec: Record "Student Master-CS";
    begin
        //Code added for User Id Assign value in Updated and Mobile Update Field::CSPL-00092::05-04-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        If Term = Term::FALL then
            "Term Sequence" := 3;
        IF Term = Term::SPRING then
            "Term Sequence" := 1;
        IF Term = Term::SUMMER then
            "Term Sequence" := 2;


        If Rec."Student No." <> '' then begin
            StudentMasterRec.Reset();
            If StudentMasterRec.Get(Rec."Student No.") then;

            IF xRec."Start Date" <> 0D then
                IF xRec."Start Date" <> Rec."Start Date" then
                    IF StudentMasterRec."Student SFP Initiation" <> 0 then begin
                        StudentMasterRec."Student SFP Update" := 1;
                        StudentMasterRec.Modify();
                    end;

            IF xRec."End Date" <> 0D then
                IF xRec."End Date" <> Rec."End Date" then
                    IF StudentMasterRec."Student SFP Initiation" <> 0 then begin
                        StudentMasterRec."Student SFP Update" := 1;
                        StudentMasterRec.Modify();
                    end;
        end;

        //Code added for User Id Assign value in Updated and Mobile Update Field::CSPL-00092::05-04-2019: End
    end;


    var
        StudentMasterCS: Record "Student Master-CS";
        MainOptionalSubjectLogCS: Record "Main&Optional Subject Log-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        MakeUpExaminationCS: Record "MakeUp Examination-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";

        LineNo: Integer;
        Text_10001Lbl: Label 'Do You want To Drop Student Subject ? ';

    procedure CheckTimetable()
    var
        TimeTable: Record "Final Class Time Table-CS";
        StudentSubjectCOLLEGE: Record "Main Student Subject-CS";
        Text0001Lbl: Label 'Student %1 Already mapped  to Theory Subect.Please select another section!!';
    begin

        IF ("Re-Registration" = TRUE) AND ("Subject Class" = 'LAB') THEN BEGIN
            TimeTable.Reset();
            TimeTable.SETRANGE("Academic Code", "Academic Year");
            TimeTable.SETRANGE(Semester, Semester);
            TimeTable.SETRANGE(Section, Section);
            TimeTable.SETRANGE("Subject Class", 'LAB');
            IF TimeTable.FINDFIRST() THEN BEGIN
                StudentSubjectCOLLEGE.Reset();
                StudentSubjectCOLLEGE.SETRANGE(StudentSubjectCOLLEGE."Student No.", "Student No.");
                StudentSubjectCOLLEGE.SETRANGE("Academic Year", "Academic Year");
                StudentSubjectCOLLEGE.SETRANGE(Semester, Semester);
                StudentSubjectCOLLEGE.SETRANGE("Subject Class", 'LAB');
                IF StudentSubjectCOLLEGE.FINDFIRST() THEN BEGIN
                    StudentSubjectCOLLEGE.Section := '';
                    StudentSubjectCOLLEGE.Batch := '';
                    StudentSubjectCOLLEGE."Roll No." := '';
                    StudentSubjectCOLLEGE.Modify();
                END;
            END ELSE
                ERROR(Text0001Lbl, "Student No.");
        END;
    end;

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
        MainOptionalSubjectLogCS."Grade Change Type" := "Grade Change Type";
        MainOptionalSubjectLogCS."Table Type" := MainOptionalSubjectLogCS."Table Type"::"Student Subject";
        MainOptionalSubjectLogCS."Stud. No." := "Student No.";
        MainOptionalSubjectLogCS.Course := Course;
        MainOptionalSubjectLogCS.Semester := Semester;
        MainOptionalSubjectLogCS."Academic Year" := "Academic Year";
        MainOptionalSubjectLogCS."Subject Code" := "Subject Code";
        MainOptionalSubjectLogCS.Section := Section;
        MainOptionalSubjectLogCS."Start Date" := "Start Date";

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
                                IF "Attendance Percentage" <> xRec."Attendance Percentage" THEN BEGIN
                                    MainOptionalSubjectLogCS."Document Type" := 'Attendance Percentage';
                                    MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Attendance Percentage");
                                    MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Attendance Percentage");
                                END ELSE
                                    IF Rec.Year <> xRec.Year THEN BEGIN
                                        MainOptionalSubjectLogCS."Document Type" := 'Year';
                                        MainOptionalSubjectLogCS."Old Value" := xRec.Year;
                                        MainOptionalSubjectLogCS."New Value" := Rec.Year;
                                    END ELSE
                                        IF Rec."Registration Date" <> xRec."Registration Date" THEN BEGIN
                                            MainOptionalSubjectLogCS."Document Type" := 'Registration Date';
                                            MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Registration Date");
                                            MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Registration Date");
                                        END ELSE
                                            IF Rec."Re-Registration Date" <> xRec."Re-Registration Date" THEN BEGIN
                                                MainOptionalSubjectLogCS."Document Type" := 'Re-Registration Date';
                                                MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Re-Registration Date");
                                                MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Re-Registration Date");
                                            END else
                                                IF ((Rec.Credit > xRec.Credit) OR (Rec.Credit < xRec.Credit)) THEN BEGIN
                                                    MainOptionalSubjectLogCS."Document Type" := rec.fieldcaption(Credit);
                                                    MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec.Credit);
                                                    MainOptionalSubjectLogCS."New Value" := FORMAT(Rec.Credit);
                                                END else
                                                    IF ((Rec."Credit Earned" > xRec."Credit Earned") OR (Rec."Credit Earned" < xRec."Credit Earned")) THEN BEGIN
                                                        MainOptionalSubjectLogCS."Document Type" := rec.fieldcaption("Credit Earned");
                                                        MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Credit Earned");
                                                        MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Credit Earned");
                                                    END else
                                                        IF (Rec."Enrollment No" > xRec."Enrollment No") THEN BEGIN
                                                            MainOptionalSubjectLogCS."Document Type" := rec.fieldcaption("Enrollment No");
                                                            MainOptionalSubjectLogCS."Old Value" := FORMAT(xRec."Enrollment No");
                                                            MainOptionalSubjectLogCS."New Value" := FORMAT(Rec."Enrollment No");
                                                        END;

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
                                IF "Attendance Percentage" <> xRec."Attendance Percentage" THEN
                                    CreateStudentSubjectLog()
                                ELSE
                                    IF Rec.Year <> xRec.Year THEN
                                        CreateStudentSubjectLog()
                                    else
                                        if ((Rec.Credit > xRec.Credit) OR (Rec.Credit < xRec.Credit)) THEN
                                            CreateStudentSubjectLog()
                                        else
                                            IF ((Rec."Credit Earned" > xRec."Credit Earned") OR (Rec."Credit Earned" < xRec."Credit Earned")) THEN
                                                CreateStudentSubjectLog()
                                            else
                                                IF (Rec."Enrollment No" > xRec."Enrollment No") THEN
                                                    CreateStudentSubjectLog();

    end;

    procedure UpdateAttendance()
    begin
        ExternalAttendanceLineCS.Reset();
        ExternalAttendanceLineCS.SETRANGE("Student No.", "Student No.");
        ExternalAttendanceLineCS.SETRANGE(Course, Course);
        ExternalAttendanceLineCS.SETRANGE("Academic Year", "Academic Year");
        IF "Type Of Course" = "Type Of Course"::Semester THEN
            ExternalAttendanceLineCS.SETRANGE(Semester, Semester)
        ELSE
            ExternalAttendanceLineCS.SETRANGE(Year, Year);
        ExternalAttendanceLineCS.SETRANGE(Section, Section);
        ExternalAttendanceLineCS.SETRANGE("Subject Class", "Subject Class");
        ExternalAttendanceLineCS.SETRANGE("Subject Code", "Subject Code");
        ExternalAttendanceLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF ExternalAttendanceLineCS.FINDFIRST() THEN
            REPEAT
                IF xRec."Attendance Percentage" <> Rec."Attendance Percentage" THEN
                    ExternalAttendanceLineCS."Attendance %" := "Attendance Percentage";
                IF "Attendance Percentage" >= "Applicable Attendance per" THEN BEGIN
                    ExternalAttendanceLineCS.Detained := FALSE;
                    ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Present;
                END ELSE BEGIN
                    ExternalAttendanceLineCS.Detained := TRUE;
                    ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Absent;
                END;
                ExternalAttendanceLineCS.Modify();

            UNTIL ExternalAttendanceLineCS.NEXT() = 0;



        ExternalExamLineCS.Reset();
        ExternalExamLineCS.SETRANGE("Student No.", "Student No.");
        ExternalExamLineCS.SETRANGE(Course, Course);
        ExternalExamLineCS.SETRANGE("Academic year", "Academic Year");
        IF "Type Of Course" = "Type Of Course"::Semester THEN
            ExternalExamLineCS.SETRANGE(Semester, Semester)
        ELSE
            ExternalExamLineCS.SETRANGE(Year, Year);
        ExternalExamLineCS.SETRANGE(Section, Section);
        ExternalExamLineCS.SETRANGE("Subject Class", "Subject Class");
        ExternalExamLineCS.SETRANGE("Subject Code", "Subject Code");
        ExternalExamLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF ExternalExamLineCS.FINDFIRST() THEN
            REPEAT
                IF xRec."Attendance Percentage" <> Rec."Attendance Percentage" THEN
                    ExternalExamLineCS."Attendance %" := "Attendance Percentage";
                IF "Attendance Percentage" >= "Applicable Attendance per" THEN BEGIN
                    ExternalExamLineCS.Detained := FALSE;
                    ExternalExamLineCS."Attendance Type" := ExternalExamLineCS."Attendance Type"::Present;
                END ELSE BEGIN
                    ExternalExamLineCS.Detained := TRUE;
                    ExternalExamLineCS."Attendance Type" := ExternalExamLineCS."Attendance Type"::Absent;
                END;

                ExternalExamLineCS.Modify();
            UNTIL ExternalExamLineCS.NEXT() = 0;



        AdmitCardLineCS.Reset();
        AdmitCardLineCS.SETRANGE("Student No.", "Student No.");
        AdmitCardLineCS.SETRANGE(Course, Course);
        AdmitCardLineCS.SETRANGE("Academic Year", "Academic Year");
        IF "Type Of Course" = "Type Of Course"::Semester THEN
            AdmitCardLineCS.SETRANGE(Semester, Semester)
        ELSE
            AdmitCardLineCS.SETRANGE(Year, Year);
        AdmitCardLineCS.SETRANGE(Section, Section);
        AdmitCardLineCS.SETRANGE("Subject Class", "Subject Class");
        AdmitCardLineCS.SETRANGE("Subject Code", "Subject Code");
        AdmitCardLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF AdmitCardLineCS.FINDFIRST() THEN
            REPEAT
                IF xRec."Attendance Percentage" <> Rec."Attendance Percentage" THEN BEGIN
                    AdmitCardLineCS."Actual Per%" := "Attendance Percentage";
                    IF "Attendance Percentage" >= "Applicable Attendance per" THEN
                        AdmitCardLineCS.Detained := FALSE
                    ELSE
                        AdmitCardLineCS.Detained := TRUE;

                    AdmitCardLineCS.Modify();
                END;
            UNTIL AdmitCardLineCS.NEXT() = 0;

    end;
}
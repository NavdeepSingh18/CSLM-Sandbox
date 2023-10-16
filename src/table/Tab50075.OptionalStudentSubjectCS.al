table 50075 "Optional Student Subject-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                         Remarks
    // 1         CSPL-00092    18-03-2019    OnInsert                        Assign Value in User Id and Mobile Insert Field
    // 2         CSPL-00092    18-03-2019    OnModify                        Assign Value in Updated and Mobile Insert Field
    // 3         CSPL-00092    18-03-2019    Student No. OnValidate          Assign Value in Student Name and Roll No. Field
    // 4         CSPL-00092    18-03-2019    Subject Code OnValidate         Assign Values in Fields
    // 5         CSPL-00092    18-03-2019    Subject Code OnOnLookup         Assign Values in Fields
    // 6         CSPL-00092    18-03-2019    Acadmic Year OnValidate         Assign Value in Actual Acadmic Year Field
    // 7         CSPL-00092    18-03-2019    Section OnValidate              Clear Roll No Field
    // 8         CSPL-00092    18-03-2019    Year OnValidate                 Assign value in Actual Year Field
    // 9         CSPL-00092    18-03-2019    Grade OnValidate                Assign values
    // 10        CSPL-00092    18-03-2019    External Obtained OnValidate    Assign values
    // 11        CSPL-00092    18-03-2019    Actual Subject Code On Validate Assign value in Actual Subject Description Field
    // 12        CSPL-00092    18-03-2019    Present Count OnValidate        Assign values
    // 13        CSPL-00092    18-03-2019    Subject Drop OnValidate         Assign values
    // 14        CSPL-00092    18-03-2019    Function UpdateAttendance       update Attendance

    Caption = 'Optional Student Subject';
    DrillDownPageID = 50004;
    LookupPageID = 50004;
    DataCaptionFields = "Student No.", "Student Name";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Student Name and Roll No. Field::CSPL-00092::18-03-2019: Start
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Student Name" := Copystr(StudentMasterCS."Name as on Certificate", 1, 60);
                    "Roll No." := StudentMasterCS."Roll No.";
                END ELSE
                    "Student Name" := '';
                "Roll No." := '';
                //Code added for Assign Value in Student Name and Roll No. Field::CSPL-00092::18-03-2019: End
            end;
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";

            trigger OnLookup()
            begin
                //Code added for Assign Values in Fields::CSPL-00092::18-03-2019: End
                IF "Type Of Course" = "Type Of Course"::Semester THEN BEGIN
                    AcademicsSetupCS.GET();
                    AcademicsSetupCS.TESTFIELD("Common Subject Type");
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETFILTER("Subject Type", '<>%1', AcademicsSetupCS."Common Subject Type");
                    IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN BEGIN
                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETCURRENTKEY("Student No.", Course, Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                        OptionalStudentSubjectCS.SETRANGE("Student No.", "Student No.");
                        OptionalStudentSubjectCS.SETRANGE(Course, Course);
                        OptionalStudentSubjectCS.SETRANGE(Semester, Semester);
                        OptionalStudentSubjectCS.SETRANGE(Section, Section);
                        OptionalStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
                        OptionalStudentSubjectCS.SETRANGE("Subject Type", SubjectMasterCS."Subject Type");
                        OptionalStudentSubjectCS.SETRANGE("Subject Code", SubjectMasterCS.Code);
                        IF OptionalStudentSubjectCS.ISEMPTY() then BEGIN
                            Description := SubjectMasterCS.Description;
                            "Subject Type" := SubjectMasterCS."Subject Type";
                            "Subject Code" := SubjectMasterCS.Code;
                        END ELSE
                            ERROR(Text000Lbl);
                    END
                END;

                IF "Type Of Course" = "Type Of Course"::Year THEN BEGIN
                    AcademicsSetupCS.GET();
                    AcademicsSetupCS.TESTFIELD("Common Subject Type");
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETFILTER("Subject Type", '<>%1', AcademicsSetupCS."Common Subject Type");
                    IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN BEGIN
                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETCURRENTKEY("Student No.", Course, Section, "Academic Year", "Subject Type", "Subject Code");
                        OptionalStudentSubjectCS.SETRANGE("Student No.", "Student No.");
                        OptionalStudentSubjectCS.SETRANGE(Course, Course);
                        OptionalStudentSubjectCS.SETRANGE(Section, Section);
                        OptionalStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
                        OptionalStudentSubjectCS.SETRANGE("Subject Type", SubjectMasterCS."Subject Type");
                        OptionalStudentSubjectCS.SETRANGE("Subject Code", SubjectMasterCS.Code);
                        IF OptionalStudentSubjectCS.ISEMPTY() then BEGIN
                            Description := SubjectMasterCS.Description;
                            "Subject Type" := SubjectMasterCS."Subject Type";
                            "Subject Code" := SubjectMasterCS.Code;
                        END ELSE
                            ERROR(Text000Lbl);
                    END
                END;
                //Code added for Assign Values in Fields::CSPL-00092::18-03-2019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Assign Values in Fields::CSPL-00092::18-03-2019: Start
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
                END;
                //Code added for Assign Values in Fields::CSPL-00092::18-03-2019: End
            end;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Actual Acadmic Year Field::CSPL-00092::18-03-2019: Start
                "Actual Academic Year" := "Academic Year";
                //Code added for Assign Value in Actual Acadmic Year Field::CSPL-00092::18-03-2019: End
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Subject Type-CS";
        }
        field(7; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(8; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";

            trigger OnValidate()
            begin
                //Code added for Clear Roll No Field::CSPL-00092::18-03-2019: Start
                "Roll No." := '';
                //Code added for Clear Roll No Field::CSPL-00092::18-03-2019: End
            end;
        }
        field(20; Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = CustomerContent;
        }
        field(22; Credit; Decimal)
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Total; Decimal)
        {
            Caption = 'Total';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50009; "Elective Group Code"; Code[20])
        {
            Caption = 'Elective Group Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50016; "Enrollment No"; Code[20])
        {
            Caption = 'Enrollment No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50017; Group; Code[20])
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Group Master-CS".Code;
        }
        field(50018; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Batch-CS".Code;
        }
        field(50019; Inactive; Boolean)
        {
            Caption = 'Inactive';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50020; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50021; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign value in Actual Year Field::CSPL-00092::18-03-2019: Start
                "Actual Year" := Year;
                //Code added for Assign value in Actual Year Field::CSPL-00092::18-03-2019: End
            end;
        }
        field(50022; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Grade Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign values ::CSPL-00092::18-03-2019: Start
                IF (Grade = 'A+') OR (Grade = 'A') OR (Grade = 'B') OR (Grade = 'C') OR (Grade = 'D') OR (Grade = 'E') THEN BEGIN
                    "Credit Earned" := Credit;

                    IF Grade = 'A+' THEN
                        "Credit Grade Points Earned" := 10 * "Credit Earned";

                    IF Grade = 'A' THEN
                        "Credit Grade Points Earned" := 9 * "Credit Earned";

                    IF Grade = 'B' THEN
                        "Credit Grade Points Earned" := 8 * "Credit Earned";

                    IF Grade = 'C' THEN
                        "Credit Grade Points Earned" := 7 * "Credit Earned";

                    IF Grade = 'D' THEN
                        "Credit Grade Points Earned" := 6 * "Credit Earned";

                    IF Grade = 'E' THEN
                        "Credit Grade Points Earned" := 5 * "Credit Earned"

                END ELSE BEGIN
                    "Credit Earned" := 0;
                    "Credit Grade Points Earned" := 0;
                END;


                IF Revaluation1 = TRUE THEN BEGIN
                    "Attendance Detail" := 'Revaluation1';
                    IF "Attendance Detail" = 'Revaluation1' THEN
                        IF (Grade = 'A+') OR (Grade = 'A') OR (Grade = 'B') OR (Grade = 'C') OR (Grade = 'D') OR (Grade = 'E') THEN BEGIN
                            MakeUpExaminationCS.Reset();
                            MakeUpExaminationCS.SETRANGE("Student No.", "Student No.");
                            MakeUpExaminationCS.SETRANGE(Semester, Semester);
                            MakeUpExaminationCS.SETRANGE("Subject Code", "Subject Code");
                            MakeUpExaminationCS.SETRANGE("Academic Year", "Academic Year");
                            IF MakeUpExaminationCS.FINDFIRST() THEN BEGIN
                                MakeUpExaminationCS.Cancel := TRUE;
                                MakeUpExaminationCS.Modify();
                            END;

                            RegistrationStudentCS.Reset();
                            RegistrationStudentCS.SETRANGE("Student No.", "Student No.");
                            RegistrationStudentCS.SETRANGE(Semester, Semester);
                            RegistrationStudentCS.SETRANGE("Subject Code", "Subject Code");
                            RegistrationStudentCS.SETRANGE("Academic Year", "Academic Year");
                            IF RegistrationStudentCS.FINDFIRST() THEN BEGIN
                                RegistrationStudentCS.Cancel := TRUE;
                                RegistrationStudentCS.Modify();
                            END;
                        END;
                END ELSE
                    IF Revaluation2 = TRUE THEN BEGIN
                        "Attendance Detail" := 'Revaluation2';
                        IF "Attendance Detail" = 'Revaluation2' THEN
                            IF (Grade = 'A+') OR (Grade = 'A') OR (Grade = 'B') OR (Grade = 'C') OR (Grade = 'D') OR (Grade = 'E') THEN BEGIN
                                MakeUpExaminationCS.Reset();
                                MakeUpExaminationCS.SETRANGE("Student No.", "Student No.");
                                MakeUpExaminationCS.SETRANGE(Semester, Semester);
                                MakeUpExaminationCS.SETRANGE("Subject Code", "Subject Code");
                                MakeUpExaminationCS.SETRANGE("Academic Year", "Academic Year");
                                IF MakeUpExaminationCS.FINDFIRST() THEN BEGIN
                                    MakeUpExaminationCS.Cancel := TRUE;
                                    MakeUpExaminationCS.Modify();
                                END;

                                RegistrationStudentCS.Reset();
                                RegistrationStudentCS.SETRANGE("Student No.", "Student No.");
                                RegistrationStudentCS.SETRANGE(Semester, Semester);
                                RegistrationStudentCS.SETRANGE("Subject Code", "Subject Code");
                                RegistrationStudentCS.SETRANGE("Academic Year", "Academic Year");
                                IF RegistrationStudentCS.FINDFIRST() THEN BEGIN
                                    RegistrationStudentCS.Cancel := TRUE;
                                    RegistrationStudentCS.Modify();
                                END;
                            END;
                    END;

                //Code added for Assign values ::CSPL-00092::18-03-2019: End
            end;
        }
        field(50023; "Internal Obtained"; Decimal)
        {
            Caption = 'Internal Obtained';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50024; "External Obtained"; Decimal)
        {
            Caption = 'External Obtained';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';

            trigger OnValidate()
            begin
                //Code added for Assign values ::CSPL-00092::18-03-2019: Start
                IF "External Obtained" <> 0 THEN
                    Total := "Total Internal" + "External Obtained";
                //Code added for Assign values ::CSPL-00092::18-03-2019: End
            end;
        }
        field(50025; "Grace Marks"; Decimal)
        {
            Caption = 'Grace Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50026; "Total Internal"; Decimal)
        {
            Caption = 'Total Internal';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50036; "Re- Register"; Boolean)
        {
            Caption = 'Re-Register';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50038; "Grace Criteria"; Option)
        {
            Caption = 'Grace Criteria';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            OptionCaption = ' ,External,Total';
            OptionMembers = " ",External,Total;
        }
        field(50039; "Roll No."; Code[10])
        {
            Caption = 'Roll No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50040; Publish; Boolean)
        {
            Caption = 'Publish';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50041; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Period Line-CS";
        }
        field(50042; "Re-Registration"; Boolean)
        {
            Caption = 'Re-Registration';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50043; "Re-Apply"; Boolean)
        {
            Caption = 'Re-Apply';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50044; "Attendance Percentage"; Decimal)
        {
            Caption = 'Attendance Percentage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';

            trigger OnValidate()
            begin
                //Code added for Assign values ::CSPL-00092::18-03-2019: Start
                IF "Attendance Percentage" >= "Applicable Attendance per" THEN
                    Detained := FALSE
                ELSE
                    Detained := TRUE;

                AttendanceUpdate();
                //Code added for Assign values ::CSPL-00092::18-03-2019: End
            end;
        }
        field(50045; "Assignment Marks"; Decimal)
        {
            Caption = 'Assignment Mark';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50046; "Program/Open Elective Temp"; Option)
        {
            Caption = 'Program/Open elective Temp';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            OptionCaption = ' ,Open Elective Common Subject,Program Elective Common Subject';
            OptionMembers = " ","Open Elective Common Subject","Program Elective Common Subject";
        }
        field(50047; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50048; UFM; Boolean)
        {
            Caption = 'UFM';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50049; Dropped; Boolean)
        {
            Caption = 'Dropped';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50050; "Credit Earned"; Decimal)
        {
            Caption = 'Credit Earned';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = true;
        }
        field(50051; "Credit Grade Points Earned"; Integer)
        {
            Caption = 'Credit Grade Points Earned';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = true;
        }
        field(50052; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50053; "Selected Subject"; Code[10])
        {
            Caption = 'Selected Subject';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50054; "Selected Sub. Name"; Text[50])
        {
            Caption = 'Selected Sub. Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50055; "Re-Appear External Marks"; Decimal)
        {
            Caption = 'Re-Appear External marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = false;
        }
        field(50056; "Re-Appear Total"; Decimal)
        {
            Caption = 'Re-Appear Total';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = false;
        }
        field(50057; "Re-Appear Result"; Option)
        {
            Caption = 'Re-Appear Result';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(50058; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = true;
        }
        field(50059; "Attendance % as on Date"; Date)
        {
            Caption = 'Attendance % as on Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50060; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50061; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50062; Specilization; Code[100])
        {
            Caption = 'Specilization';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50063; Detained; Boolean)
        {
            Caption = 'Detained';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50064; "Attendance Detail"; Text[80])
        {
            Caption = 'Attendance Detail';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50065; Absent; Boolean)
        {
            Caption = 'Absent';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50066; "Main Exam Result Updated"; Boolean)
        {
            Caption = 'Main Exam Result Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50067; Result; Option)
        {
            Caption = 'Result';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = true;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(50068; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            OptionCaption = ' ,Present,Absent,On Duty,Leave';
            OptionMembers = " ",Present,Absent,"On Duty",Leave;

            trigger OnValidate()
            begin
                AttendanceUpdate();
            end;
        }
        field(50069; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50070; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50071; "Re-Registration Date"; Date)
        {
            Caption = 'Re-Registration Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50072; "Grade Change Type"; Option)
        {
            Caption = 'Grade Change Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            OptionCaption = ' ,Revaluation,MakeUp';
            OptionMembers = " ",Revaluation,MakeUp;
        }
        field(50073; Graduation; Code[20])
        {
            Caption = 'Graduation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50074; "Internal Marks Updated"; Boolean)
        {
            Caption = 'Internal marks Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50075; "External Marks Updated"; Boolean)
        {
            Caption = 'External Marks Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50076; "Actual Semester"; Code[10])
        {
            Caption = 'Actual Semester';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(50077; "Actual Year"; Code[10])
        {
            Caption = 'Actual Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            Editable = true;
            TableRelation = "Year Master-CS";
        }
        field(50078; "Actual Academic Year"; Code[20])
        {
            Caption = 'Actual Academic Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(50079; "Actual Subject Code"; Code[20])
        {
            Caption = 'Registration Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Subject Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign value in Actual Subject Description Field ::CSPL-00092::18-03-2019: Start
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Actual Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN
                    "Actual Subject Description" := SubjectMasterCS.Description;

                //Code added for Assign value in Actual Subject Description Field ::CSPL-00092::18-03-2019: End
            end;
        }
        field(50080; "Actual Subject Description"; Text[100])
        {
            Caption = 'Actual Subject Description';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50081; "Make Up Examination"; Boolean)
        {
            Caption = 'Make Up Examination';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50082; Revaluation1; Boolean)
        {
            Caption = 'Revaluation1';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50083; Revaluation2; Boolean)
        {
            Caption = 'Revaluation2';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50084; "Special Exam"; Boolean)
        {
            Caption = 'Special Exam';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50085; "Re-Registration Exam Only"; Boolean)
        {
            Caption = 'Re-Registration Exam Only';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50086; "Total Class Held"; Integer)
        {
            Caption = 'Total Class Held';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50087; "Total Attendance Taken"; Integer)
        {
            Caption = 'Total Attendance Taken';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50088; "Present Count"; Integer)
        {
            Caption = 'Present Count';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';

            trigger OnValidate()
            begin
                //Code added for Assign values::CSPL-00092::18-03-2019: Start
                "Absent Count" := "Total Attendance Taken" - "Present Count";
                "Attendance Percentage" := ROUND(("Present Count" / "Total Attendance Taken") * 100, 1, '>');


                IF "Attendance Percentage" >= "Applicable Attendance per" THEN
                    Detained := FALSE
                ELSE
                    Detained := TRUE;

                AttendanceUpdate();
                //Code added for Assign values::CSPL-00092::18-03-2019: End
            end;
        }
        field(50089; "Absent Count"; Integer)
        {
            Caption = 'Absent Count';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50090; "Subject Drop"; Boolean)
        {
            Caption = 'Subject Drop';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';

            trigger OnValidate()
            begin
                //Code added for Assign values::CSPL-00092::18-03-2019: Start
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

                //Code added for Assign values::CSPL-00092::18-03-2019: End
            end;
        }
        field(50091; "Subject Pass Date"; Date)
        {
            Caption = 'Subject Pass Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50092; "Previous Detained Status"; Boolean)
        {
            Caption = 'Previous Detained Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50093; "Student Status"; Option)
        {
            Caption = 'Student Status';
            CalcFormula = Lookup("Student Master-CS"."Student Status" WHERE("No." = FIELD("Student No.")));
            Description = 'CS Field Added 23-04-2019';
            FieldClass = FlowField;
            OptionCaption = ' ,Student,Inactive,Provisional Student,Expired,Withdrwal -In- Process,Withdrawl/Discontinue,Student Transfer-In-Process,Course Completion,Casual,Reject & Rejoin,NFT,NFT-Extended,Academic Break,Terminated';
            OptionMembers = " ",Student,Inactive,"Provisional Student",Expired,"Withdrwal -In- Process","Withdrawl/Discontinue","Student Transfer-In-Process","Course Completion",Casual,"Reject & Rejoin",NFT,"NFT-Extended","Academic Break",Terminated;
        }
        field(50094; "Subject Not Required"; Boolean)
        {
            Caption = 'Subject Not Required';
            CalcFormula = Lookup("Subject Master-CS"."Subject Not Required" WHERE(Code = FIELD("Subject Code")));
            Description = 'CS Field Added 23-04-2019';
            FieldClass = FlowField;
        }
        field(50095; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50096; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50097; "Mobile Result"; Boolean)
        {
            Caption = 'Mobile Result';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(50098; "Current Session"; Code[50])
        {
            Caption = 'Current Session';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Session Master-CS";
        }
        field(50099; "Previous Session"; Code[20])
        {
            Caption = 'Previous Session';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Session Master-CS";
        }
        field(50100; "Actual Session"; Code[20])
        {
            Caption = 'Actual Session';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
            TableRelation = "Session Master-CS";
        }
        field(50101; "Subject Group"; Code[20])
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
        field(50102; "Subject Group Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Group Description';
            Editable = false;
        }

        field(50103; "Level"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Level';
        }
        field(50104; "Level Description"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Level Description';
            OptionMembers = " ","Main Subject","Level 2 Systems","Level 3 Topics","Internal Exam Component","External Examination","Level 2 Clinical Rotation","Clinical Shelf Examination","Prep Examination","Level 2 Elective Rotation","Level 3 Exam","Level 3 Component","Level 3 Clinical Objective";
        }
        field(50105; "Examination"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Examination';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(33048922; "Exam Fee"; Decimal)
        {
            Caption = 'Exam Fee';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(33048926; "Internal Maximum"; Decimal)
        {
            Caption = 'Internal Maximum';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(33048927; "External Maximum"; Decimal)
        {
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
        field(33048931; "Applicable Attendance per"; Decimal)
        {
            Caption = 'Applicable Attendance Per';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23-04-2019';
        }
    }

    keys
    {
        key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
        {
        }
        key(Key2; Course, Semester, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; Course, Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key4; "Student No.", Course, Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key5; Course, Semester, Section, "Academic Year")
        {
        }
        key(Key6; "Subject Class")
        {
        }
        key(Key7; "Subject Code", Section, "Enrollment No")
        {
        }
        key(Key8; "Enrollment No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in User Id and Mobile Insert Field::CSPL-00092::18-03-2019: Start
        "User ID" := FORMAT(UserId());
        "Mobile Insert" := TRUE;
        //Code added for Assign Value in User Id and Mobile Insert Field::CSPL-00092::18-03-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated and Mobile Insert Field::CSPL-00092::18-03-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEn
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        //Code added for Assign Value in Updated and Mobile Insert Field::CSPL-00092::18-03-2019: End
    end;

    var
        SubjectMasterCS: Record "Subject Master-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        MakeUpExaminationCS: Record "MakeUp Examination-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        StudentMasterCS: Record "Student Master-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        Text000Lbl: Label 'Subject is already selected.';

        Text_10001Lbl: Label 'Do You Want To Drop Student Subject ?';


    local procedure AttendanceUpdate()
    begin
        //Code added for Assign values::CSPL-00092::18-03-2019: Start
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
                IF xRec."Attendance Type" <> Rec."Attendance Type" THEN
                    ExternalAttendanceLineCS."Attendance Type" := "Attendance Type"
                ELSE
                    IF xRec."Attendance Percentage" <> Rec."Attendance Percentage" THEN BEGIN
                        ExternalAttendanceLineCS."Attendance %" := "Attendance Percentage";
                        IF "Attendance Percentage" >= "Applicable Attendance per" THEN
                            ExternalAttendanceLineCS.Detained := FALSE
                        ELSE
                            ExternalAttendanceLineCS.Detained := TRUE;
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
                IF xRec."Attendance Type" <> Rec."Attendance Type" THEN
                    ExternalExamLineCS."Attendance Type" := "Attendance Type"
                ELSE
                    IF xRec."Attendance Percentage" <> Rec."Attendance Percentage" THEN BEGIN
                        ExternalExamLineCS."Attendance %" := "Attendance Percentage";
                        IF "Attendance Percentage" >= "Applicable Attendance per" THEN
                            ExternalExamLineCS.Detained := FALSE
                        ELSE
                            ExternalExamLineCS.Detained := TRUE;
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
                END;
                AdmitCardLineCS.Modify();
            UNTIL AdmitCardLineCS.NEXT() = 0;

        //Code added for Assign values::CSPL-00092::18-03-2019: End
    end;
}


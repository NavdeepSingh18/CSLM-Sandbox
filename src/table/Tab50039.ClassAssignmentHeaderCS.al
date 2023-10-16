table 50039 "Class Assignment Header-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                             Remarks
    // 1         CSPL-00092    02-05-2019    OnInsert                            No. Series and  Assign Value in Fields.
    // 2         CSPL-00092    02-05-2019    OnModify                            Assign Value in Updated Field
    // 3         CSPL-00092    02-05-2019    OnDelete                            Delete data from Table
    // 4         CSPL-00092    02-05-2019    Assignment No. - OnValidate         No. Series
    // 5         CSPL-00092    02-05-2019    Faculty Code - OnValidate           Call function for Validate Data
    // 6         CSPL-00092    02-05-2019    Course Code - OnValidate            Call function for Validate Data and Assign Value in Fields
    // 7         CSPL-00092    02-05-2019    Semester - OnValidate               Call function for Validate Data
    // 8         CSPL-00092    02-05-2019    Section - OnValidate                Call function for Validate Data
    // 9         CSPL-00092    02-05-2019    Academic Year - OnValidate          Call function for Validate Data
    // 10        CSPL-00092    02-05-2019    Subject Type - OnValidate           Call function for Validate Data
    // 11        CSPL-00092    02-05-2019    Subject Code - OnValidate           Call function for Validate Data and Assign Value in Fields
    // 12        CSPL-00092    02-05-2019    Subject Code - OnLookup             Assign Value in Fields
    // 13        CSPL-00092    02-05-2019    Assignment Description - OnValidateValidate Data
    // 14        CSPL-00092    02-05-2019    Created Date - OnValidate           Call function for Validate Data
    // 15        CSPL-00092    02-05-2019    Due Date - OnValidate           Call function for Validate Data
    // 16        CSPL-00092    02-05-2019    Assignment Status - OnValidate    Call function for Validate Data
    // 17        CSPL-00092    02-05-2019    Type Of Course - OnValidate       Call function for Validate Data
    // 18        CSPL-00092    02-05-2019    Final Years Course - OnValidate     Call function for Validate Data
    // 19        CSPL-00092    02-05-2019    Year - OnValidate                 Call function for Validate Data
    // 20        CSPL-00092    02-05-2019    Exam Method Code - OnValidate     Assign Value in Fields
    // 21        CSPL-00092    02-05-2019    AssistEdit                          Lookup No series

    Caption = 'Class Assignment Header-CS';

    fields
    {
        field(1; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No. Series::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                IF "Assignment No." <> xRec."Assignment No." THEN BEGIN
                    EducationSetupCS.GET();
                    NoSeriesManagement.TestManual(EducationSetupCS."Assignment No.");
                    "No. Series" := '';
                END;
                //Code added for No. Series::CSPL-00092::02-05-2019: End
            end;
        }
        field(2; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data and Assign Value in Fields::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                CourseMasterCS.RESET();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "Course Code");
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Course Name" := CourseMasterCS.Description;
                    "Program" := CourseMasterCS.Graduation;
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                END;
                //Code added for Call function for Validate Data and Assign Value in Fields::CSPL-00092::02-05-2019: End
            end;
        }
        field(4; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = IF ("Course Code" = FILTER(<> '')) "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD("Course Code"))
            ELSE
            IF ("Course Code" = FILTER('')) "Semester Master-CS".Code;

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(5; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = IF ("Course Code" = FILTER(<> '')) "Course Section Master-CS"."Section Code" WHERE("Course Code" = FIELD("Course Code"),
                                                                                                           Semester = FIELD(Semester))
            ELSE
            IF ("Course Code" = FILTER('""')) "Section Master-CS".Code;

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(7; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(8; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::02-05-2019: Start
                CourseWiseSubjectLineCS.RESET();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE("Subject Classification", "Subject Class");
                CourseWiseSubjectLineCS.SETRANGE("Subject Type", "Subject Type");
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                IF "Type Of Course" = "Type Of Course"::Semester THEN
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester)
                ELSE
                    CourseWiseSubjectLineCS.SETRANGE(Year, Year);
                IF CourseWiseSubjectLineCS.FINDSET() THEN
                    //IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                "Subject Description" := CourseWiseSubjectLineCS.Description;
                //END;
                //Code added for Assign Value in Fields::CSPL-00092::02-05-2019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data and Assign Value in Fields::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                SubjectMasterCS.RESET();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF "Course Code" <> '' THEN
                    SubjectMasterCS.SETRANGE(Course, "Course Code");
                IF SubjectMasterCS.FINDFIRST() THEN
                    "Subject Description" := SubjectMasterCS.Description;
                //Code added for Call function for Validate Data and Assign Value in Fields::CSPL-00092::02-05-2019: End
            end;
        }
        field(9; "Assignment Description"; Text[250])
        {
            Caption = 'Assignment Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                TESTFIELD("Assignment Description");
                //Code added for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(10; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(11; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(12; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            DataClassification = CustomerContent;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Assignment Status"; Option)
        {
            Caption = 'Assignment Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Released,Published';
            OptionMembers = Open,Released,Published;

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(15; "Closed Date"; Date)
        {
            Caption = 'Closed Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Assignmentstatus();
            end;
        }
        field(16; "Time Required"; Decimal)
        {
            Caption = 'Time Required';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Assignmentstatus();
            end;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                Assignmentstatus();
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Assignmentstatus();
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: End
            end;
        }
        field(50015; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
                Assignmentstatus();
                //Code added for Call function for Validate Data::CSPL-00092::02-05-2019: Start
            end;
        }
        field(50016; Session; Code[20])
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = Session;
        }
        field(50017; "Assignment Submitted"; Boolean)
        {
            Caption = 'Assignment Submitted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50018; "Subject Description"; Text[100])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            Editable = false;
        }
        field(50019; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            Editable = false;
        }
        field(50020; "Exam Group"; Code[20])
        {
            Caption = 'Exam Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Sessional Exam Group-CS".Group WHERE("Exam Type" = FILTER(Assignment));
        }
        field(50021; "Exam Method Code"; Code[20])
        {
            Caption = 'Exam Method Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Sessional Exam Group-CS"."Exam Method Code" WHERE(Group = FIELD("Exam Group"),
                                                                                "Exam Type" = FILTER('Assignment|Internal Lab'));

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::02-05-2019: Start
                SessionalExamGroupCS.RESET();
                SessionalExamGroupCS.SETRANGE("Exam Method Code", "Exam Method Code");
                SessionalExamGroupCS.SETRANGE(Group, "Exam Group");
                IF SessionalExamGroupCS.FINDFIRST() THEN BEGIN
                    "Exam Description" := SessionalExamGroupCS.Description;
                    "Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::02-05-2019: End
            end;
        }
        field(50022; "Subject Class"; Code[10])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Subject Classification-CS".Code;
        }
        field(50023; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50024; "Exam Description"; Text[50])
        {
            Caption = 'Exam Description';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50025; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50026; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50027; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50028; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Group Master-CS".Code;
        }
        field(50029; "Student Batch"; Code[20])
        {
            Caption = 'Student Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Batch-CS".Code;
        }
        field(50030; "Faculty Name"; Text[80])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50033; "Title of Experiment"; Text[250])
        {
            Caption = 'Title of Experiment';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048922; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048923; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048924; "Modified By"; Text[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048925; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048926; Block; Boolean)
        {
            Caption = 'Block';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2021';
        }
        field(33048927; "Can Amend"; Boolean)
        {
            Caption = 'Can Amend';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2021';
        }
        field(33048928; "Can Review"; Boolean)
        {
            Caption = 'Can Amend';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2021';
        }
    }

    keys
    {
        key(Key1; "Assignment No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Delete data from Table::CSPL-00092::02-05-2019: Start
        ClassAssignmentLineCS.RESET();
        ClassAssignmentLineCS.SETRANGE("Assignment No.", "Assignment No.");
        ClassAssignmentLineCS.DELETEALL();
        //Code added for Delete data from Table::CSPL-00092::02-05-2019: End
    end;

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::02-05-2019: Start
        Assignmentstatus();
        EducationSetupCS.GET();
        IF "Assignment No." = '' THEN BEGIN
            EducationSetupCS.TESTFIELD("Assignment No.");
            NoSeriesManagement.InitSeries(EducationSetupCS."Assignment No.", xRec."No. Series", 0D, "Assignment No.", "No. Series");
        END;

        "User ID" := FORMAT(UserId());
        EducationSetupCS.TESTFIELD("Academic Year");
        "Academic Year" := EducationSetupCS."Academic Year";
        //Code added for User Id Assign in User Id Field::CSPL-00092::02-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::02-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::02-05-2019: End
    end;

    var

        EducationSetupCS: Record "Education Setup-CS";
        ClassAssignmentHeaderCS: Record "Class Assignment Header-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CourseMasterCS: Record "Course Master-CS";
        ClassAssignmentLineCS: Record "Class Assignment Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";

        SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        Text002Lbl: Label 'Please Select Either Graduation Or Collage Or Course Or Semester Or Acadmic Year & Session';
        Text003Lbl: Label 'Student assignment has been submitted';


    procedure AssistEdit(OldAssignment: Record "Class Assignment Header-CS"): Boolean
    begin
        //Code added for lookup No. series::CSPL-00092::02-05-2019: Start
        WITH ClassAssignmentHeaderCS DO BEGIN
            ClassAssignmentHeaderCS := Rec;
            EducationSetupCS.GET();
            EducationSetupCS.TESTFIELD("Assignment No.");
            IF NoSeriesManagement.SelectSeries(EducationSetupCS."Assignment No.", OldAssignment."No. Series", "No. Series") THEN BEGIN
                NoSeriesManagement.SetSeries("Assignment No.");
                Rec := ClassAssignmentHeaderCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for No. series::CSPL-00092::02-05-2019: Start
    end;

    procedure GetStudents(AssignmentHeader: Record "Class Assignment Header-CS")
    var

        recAssignemtLine: Record "Class Assignment Line-CS";
        StudentSubject: Record "Main Student Subject-CS";
        StudentOptionalSubject: Record "Optional Student Subject-CS";

        "LocalLineNo.": Integer;

    begin
        //Code added for Insert Assignment Line::CSPL-00092::02-05-2019: Start
        "LocalLineNo." := 0;
        IF AssignmentHeader."Subject Type" = 'CORE' THEN BEGIN
            StudentSubject.RESET();
            StudentSubject.SETCURRENTKEY(Course, Semester, "Academic Year");
            StudentSubject.SETRANGE(Course, AssignmentHeader."Course Code");
            IF AssignmentHeader."Type Of Course" = AssignmentHeader."Type Of Course"::Semester THEN
                StudentSubject.SETRANGE(Semester, AssignmentHeader.Semester)
            ELSE
                StudentSubject.SETRANGE(Year, AssignmentHeader.Year);
            StudentSubject.SETRANGE("Academic Year", AssignmentHeader."Academic Year");
            StudentSubject.SETRANGE(Section, AssignmentHeader.Section);
            StudentSubject.SETRANGE("Subject Class", AssignmentHeader."Subject Class");
            StudentSubject.SETRANGE("Subject Type", AssignmentHeader."Subject Type");
            StudentSubject.SETRANGE("Subject Code", AssignmentHeader."Subject Code");
            StudentSubject.SETRANGE("Global Dimension 1 Code", AssignmentHeader."Global Dimension 1 Code");
            StudentSubject.SETRANGE("Global Dimension 2 Code", AssignmentHeader."Global Dimension 2 Code");
            IF StudentSubject.FINDSET() THEN
                REPEAT
                    "LocalLineNo." += 10000;
                    recAssignemtLine.INIT();
                    recAssignemtLine."Assignment No." := AssignmentHeader."Assignment No.";
                    recAssignemtLine."Line No." := "LocalLineNo.";
                    recAssignemtLine."Student No." := StudentSubject."Student No.";
                    recAssignemtLine."Enrollment No." := StudentSubject."Enrollment No";
                    recAssignemtLine."Type Of Course" := StudentSubject."Type Of Course";
                    recAssignemtLine."Course Code" := StudentSubject.Course;
                    recAssignemtLine.Semester := StudentSubject.Semester;
                    recAssignemtLine."Student Name" := StudentSubject."Student Name";
                    recAssignemtLine.Section := StudentSubject.Section;
                    recAssignemtLine."Global Dimension 1 Code" := StudentSubject."Global Dimension 1 Code";
                    recAssignemtLine."Global Dimension 2 Code" := StudentSubject."Global Dimension 2 Code";
                    recAssignemtLine."Academic Year" := StudentSubject."Academic Year";
                    recAssignemtLine."Maximum Mark" := AssignmentHeader."Maximum Mark";
                    recAssignemtLine."Maximum Weightage" := AssignmentHeader."Maximum Weightage";
                    recAssignemtLine."Created By" := FORMAT(UserId());
                    recAssignemtLine."Created On" := TODAY();
                    recAssignemtLine.INSERT();
                UNTIL StudentSubject.NEXT() = 0;
        END ELSE BEGIN
            StudentOptionalSubject.RESET();
            StudentOptionalSubject.SETCURRENTKEY(Course, Semester, "Academic Year");
            StudentOptionalSubject.SETRANGE(Course, AssignmentHeader."Course Code");
            IF AssignmentHeader."Type Of Course" = AssignmentHeader."Type Of Course"::Semester THEN
                StudentOptionalSubject.SETRANGE(Semester, AssignmentHeader.Semester)
            ELSE
                StudentOptionalSubject.SETRANGE(Year, AssignmentHeader.Year);
            StudentOptionalSubject.SETRANGE("Academic Year", AssignmentHeader."Academic Year");
            StudentOptionalSubject.SETRANGE(Section, AssignmentHeader.Section);
            StudentOptionalSubject.SETRANGE("Subject Class", AssignmentHeader."Subject Class");
            StudentOptionalSubject.SETRANGE("Subject Type", AssignmentHeader."Subject Type");
            StudentOptionalSubject.SETRANGE("Subject Code", AssignmentHeader."Subject Code");
            StudentOptionalSubject.SETRANGE("Global Dimension 1 Code", AssignmentHeader."Global Dimension 1 Code");
            StudentOptionalSubject.SETRANGE("Global Dimension 2 Code", AssignmentHeader."Global Dimension 2 Code");
            IF StudentOptionalSubject.FINDSET() THEN
                REPEAT
                    "LocalLineNo." += 10000;
                    recAssignemtLine.INIT();
                    recAssignemtLine."Assignment No." := AssignmentHeader."Assignment No.";
                    recAssignemtLine."Line No." := "LocalLineNo.";
                    recAssignemtLine."Student No." := StudentOptionalSubject."Student No.";
                    recAssignemtLine."Enrollment No." := StudentOptionalSubject."Enrollment No";
                    recAssignemtLine."Type Of Course" := StudentOptionalSubject."Type Of Course";
                    recAssignemtLine."Course Code" := StudentOptionalSubject.Course;
                    recAssignemtLine.Semester := StudentOptionalSubject.Semester;
                    recAssignemtLine."Student Name" := StudentOptionalSubject."Student Name";
                    recAssignemtLine.Section := StudentOptionalSubject.Section;
                    recAssignemtLine."Global Dimension 1 Code" := StudentOptionalSubject."Global Dimension 1 Code";
                    recAssignemtLine."Global Dimension 2 Code" := StudentOptionalSubject."Global Dimension 2 Code";
                    recAssignemtLine."Academic Year" := StudentOptionalSubject."Academic Year";
                    recAssignemtLine."Maximum Mark" := AssignmentHeader."Maximum Mark";
                    recAssignemtLine."Maximum Weightage" := AssignmentHeader."Maximum Weightage";
                    recAssignemtLine."Created By" := FORMAT(UserId());
                    recAssignemtLine."Created On" := TODAY();
                    recAssignemtLine.INSERT();
                UNTIL StudentOptionalSubject.NEXT() = 0;
        END;
        //Code added for Insert Assignment Line::CSPL-00092::02-05-2019: End
    End;

    procedure GetStudentsYear(getCourse: Code[20]; getYear: Code[10]; getSection: Code[10]; getCollage: Code[20]; getAcdemicYear: Code[20]; getSession: Code[20]; getDocumentNo: Code[20]; getTypeOfCourse: Option)
    var
        Student: Record "Student Master-CS";
        recAssignemtLine: Record "Class Assignment Line-CS";
        "LocalLineNo.": Integer;
    begin
        //Code added for Insert Assignment Line::CSPL-00092::02-05-2019: Start
        IF ((getCourse = '') AND (getYear = '') OR (getCollage = '') OR (getAcdemicYear = '') OR (getSession = '')) THEN
            ERROR(Text002Lbl);

        "LocalLineNo." := 0;

        Student.RESET();
        Student.SETCURRENTKEY("Course Code", Semester, "Academic Year");

        IF getCollage <> '' THEN
            Student.SETRANGE("Global Dimension 1 Code", getCollage);

        IF getAcdemicYear <> '' THEN
            Student.SETRANGE("Academic Year", getAcdemicYear);

        IF getSession <> '' THEN
            Student.SETRANGE(Session, getSession);

        IF (getCourse <> '') AND (getYear <> '') THEN BEGIN
            Student.SETRANGE("Course Code", getCourse);
            Student.SETRANGE(Year, getYear);
        END;
        IF Student.FINDSET() THEN
            REPEAT
                "LocalLineNo." += 10000;
                recAssignemtLine.INIT();
                recAssignemtLine."Assignment No." := getDocumentNo;
                recAssignemtLine."Line No." := "LocalLineNo.";
                recAssignemtLine."Student No." := Student."No.";
                recAssignemtLine."Type Of Course" := getTypeOfCourse;
                recAssignemtLine."Course Code" := Student."Course Code";
                recAssignemtLine.Year := Student.Year;
                recAssignemtLine."Student Name" := Student."Student Name";
                recAssignemtLine.Section := Student.Section;
                recAssignemtLine."Global Dimension 1 Code" := Student."Global Dimension 1 Code";
                recAssignemtLine."Academic Year" := Student."Academic Year";
                recAssignemtLine.Session := Student.Session;
                recAssignemtLine.INSERT();
            UNTIL Student.NEXT() = 0;
        //Code added for Insert Assignment Line::CSPL-00092::02-05-2019: End
    end;

    procedure assignmentsubmitted()
    var
        recAssignmentLine: Record "Class Assignment Line-CS";
    begin
        //Code added for Assign value in Assignment Submitted Field ::CSPL-00092::02-05-2019: Start
        recAssignmentLine.RESET();
        recAssignmentLine.SETRANGE(recAssignmentLine."Assignment No.", "Assignment No.");
        IF recAssignmentLine.FindFirst() THEN
            REPEAT
                recAssignmentLine."Assignment Submitted" := "Assignment Submitted";
                recAssignmentLine.Modify();
            UNTIL recAssignmentLine.NEXT() = 0;
    end;

    procedure Assignmentstatus()
    begin
        IF ("Assignment Submitted" = TRUE) THEN
            ERROR(Text003Lbl);
    end;

    procedure InsertStudentAssignmet()
    var
        recStudentAssignment: Record "Student Class Assignment-CS";
        recAssignmentLine: Record "Class Assignment Line-CS";


    begin
        //Code added for Insert Assignment Line::CSPL-00092::02-05-2019: Start
        recAssignmentLine.RESET();
        recAssignmentLine.SETRANGE(recAssignmentLine."Assignment No.", "Assignment No.");
        IF recAssignmentLine.FINDSET() THEN
            REPEAT
                recStudentAssignment.INIT();
                recStudentAssignment.Semester := recAssignmentLine.Semester;
                recStudentAssignment.Course := recAssignmentLine."Course Code";
                recStudentAssignment."Global Dimension 1 Code" := recAssignmentLine."Global Dimension 1 Code";
                recStudentAssignment."Global Dimension 2 Code" := recAssignmentLine."Global Dimension 2 Code";
                recStudentAssignment."Academic Year" := recAssignmentLine."Academic Year";
                recStudentAssignment.Section := recAssignmentLine.Section;
                recStudentAssignment.Session := recAssignmentLine.Session;
                recStudentAssignment.Subject := recAssignmentLine."Subject Code";
                recStudentAssignment.Order := recAssignmentLine.Order;
                recStudentAssignment."Assignment No." := recAssignmentLine."Assignment No.";
                recStudentAssignment."Student No." := recAssignmentLine."Student No.";
                recStudentAssignment.INSERT();
            UNTIL recAssignmentLine.NEXT() = 0;

        //Code added for Insert Assignment Line::CSPL-00092::02-05-2019: End
    end;
}


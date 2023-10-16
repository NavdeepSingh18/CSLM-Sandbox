table 50071 "Course Wise Subject Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                         Remarks
    // 1         CSPL-00092    04-04-2019    OnModify                        Assign True Updated Boolean.
    // 2         CSPL-00092    04-04-2019    Course Code OnValidate          Assign Value in Type ofcourse, Program and dimensions.
    // 3         CSPL-00092    04-04-2019    Subject Code OnValidate         Assign Values in Fields
    // 4         CSPL-00092    04-04-2019    Subject Code OnOnLookup         Assign Values in Fields
    // 5         CSPL-00092    04-04-2019    Faculty Code OnValidate         Insert Subject wise Detail and Section
    // 6         CSPL-00092    04-04-2019    Section OnValidate              Validate section::CSPL-00092::04-04-2019: Start
    // 7         CSPL-00092    04-04-2019    Elective Group Code OnValidate  Assign Value in Elective Group Code Field::CSPL-00092::04-04-2019: Start
    // 
    // inprogress  change variable pending

    Caption = 'Course Subject Line - COLLEGE';
    DrillDownPageID = "Course Subject Detail L-CS";
    lookupPageID = "Course Subject Detail L-CS";

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code WHERE("Course Closed" = FILTER(False));

            trigger OnValidate()
            begin
                //Code added for Assign Value in Type ofcourse, Program and dimensions::CSPL-00092::04-04-2019: Start
                CourseWiseSubjectHeadCS.RESET();
                CourseWiseSubjectHeadCS.SETRANGE(Course, "Course Code");
                IF CourseWiseSubjectHeadCS.FINDSET() THEN BEGIN
                    "Type Of Course" := CourseWiseSubjectHeadCS."Type Of Course";
                    "Program" := CourseWiseSubjectHeadCS."Program";
                    "Global Dimension 1 Code" := CourseWiseSubjectHeadCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseWiseSubjectHeadCS."Global Dimension 2 Code";
                END;
                //Code added for Assign Value in Type ofcourse, Program and dimensions::CSPL-00092::04-04-2019: End
            end;
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code;

            trigger OnLookup()
            var
                CourseWiseSubjectHead: Record "Course Wise Subject Head-CS";
            begin
                //Code added for Assign Values in Fields::CSPL-00092::04-04-2019: Start
                "Admitted Year" := '';
                CourseWiseSubjectHead.Reset();
                if CourseWiseSubjectHead.Get("Course Code", Semester, "Academic Year", Year) then
                    "Admitted Year" := CourseWiseSubjectHead."Admitted Year";

                Clear(Duration);
                "Type of Subject" := "Type of Subject"::" ";
                "Subject Group" := '';
                Level := 0;
                "Level Description" := "Level Description"::" ";
                "Core Rotation Group" := '';
                Examination := false;

                SubjectMasterCS.RESET();
                // SubjectMasterCS.SETRANGE(Course, "Course Code");
                SubjectMasterCS.SETFILTER("Subject Closed", '<>%1', TRUE);
                IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN BEGIN
                    CourseWiseSubjectLineCS.RESET();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                    IF CourseWiseSubjectLineCS.FindFirst() THEN
                        "Subject Code" := SubjectMasterCS.Code;
                    Description := SubjectMasterCS.Description;
                    "Subject Type" := SubjectMasterCS."Subject Type";
                    "Subject Classification" := SubjectMasterCS."Subject Classification";
                    "Internal Maximum" := SubjectMasterCS."Internal Maximum";
                    "Exam Fee" := SubjectMasterCS."Exam Fee";
                    Credit := SubjectMasterCS.Credit;
                    Capacity := SubjectMasterCS."Min. Capacity";
                    "External Pass" := SubjectMasterCS."External Pass";
                    "External Maximum" := SubjectMasterCS."External Maximum";
                    "Total Pass" := SubjectMasterCS."Total Pass";
                    "Total Maximum" := SubjectMasterCS."Total Maximum";
                    CourseWiseSubjectLineCS."Elective Group Code" := SubjectMasterCS."Elective Group Code";
                    //Code added for Assign Values in Fields::CSPL-00044::06-04-2020: Start
                    "Category Code" := SubjectMasterCS."Category Code";
                    "Category Description" := SubjectMasterCS."Category Description";
                    "Course Description" := SubjectMasterCS."Course Description";
                    "Part/Semester" := SubjectMasterCS."Part/Semester";
                    Duration := SubjectMasterCS.Duration;
                    "Type of Subject" := SubjectMasterCS."Type of Subject";
                    "Subject Group" := SubjectMasterCS."Subject Group";
                    "Subject Group Description" := SubjectMasterCS."Subject Group Description";
                    Level := SubjectMasterCS.Level;
                    "Level Description" := SubjectMasterCS."Level Description";
                    "Core Rotation Group" := SubjectMasterCS."Core Rotation Group";
                    Examination := SubjectMasterCS.Examination;
                    // "Goal Code" := SubjectMasterCS."Goal Code";


                    //Code added for Assign Values in Fields::CSPL-00044::06-04-2020: End
                END;
                //Code added for Assign Values in Fields::CSPL-00092::04-04-2019: End
            end;

            trigger OnValidate()
            var
                CourseWiseSubjectHead: Record "Course Wise Subject Head-CS";
            begin
                //Code added for Assign Values in Fields::CSPL-00092::04-04-2019: Start
                "Admitted Year" := '';
                CourseWiseSubjectHead.Reset();
                if CourseWiseSubjectHead.Get("Course Code", Semester, "Academic Year", Year) then
                    "Admitted Year" := CourseWiseSubjectHead."Admitted Year";

                Clear(Duration);
                "Type of Subject" := "Type of Subject"::" ";
                "Subject Group" := '';
                Level := 0;
                "Level Description" := "Level Description"::" ";
                "Core Rotation Group" := '';
                Examination := false;
                SubjectMasterCS.RESET();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN BEGIN
                    Description := SubjectMasterCS.Description;
                    "Subject Type" := SubjectMasterCS."Subject Type";
                    "Subject Classification" := SubjectMasterCS."Subject Classification";
                    "Internal Maximum" := SubjectMasterCS."Internal Maximum";
                    "Exam Fee" := SubjectMasterCS."Exam Fee";
                    Credit := SubjectMasterCS.Credit;
                    Capacity := SubjectMasterCS."Min. Capacity";
                    "External Pass" := SubjectMasterCS."External Pass";
                    "External Maximum" := SubjectMasterCS."External Maximum";
                    "Total Pass" := SubjectMasterCS."Total Pass";
                    "Total Maximum" := SubjectMasterCS."Total Maximum";
                    "Applicable Batch" := SubjectMasterCS."Applicable Batch";
                    "Number of Lab Component" := SubjectMasterCS."Number of Lab Component";
                    //Code added for Assign Values in Fields::CSPL-00044::06-04-2020: Start
                    "Category Code" := SubjectMasterCS."Category Code";
                    "Category Description" := SubjectMasterCS."Category Description";
                    "Course Description" := SubjectMasterCS."Course Description";
                    "Part/Semester" := SubjectMasterCS."Part/Semester";
                    Duration := SubjectMasterCS.Duration;
                    "Type of Subject" := SubjectMasterCS."Type of Subject";
                    "Subject Group" := SubjectMasterCS."Subject Group";
                    "Subject Group Description" := SubjectMasterCS."Subject Group Description";
                    Level := SubjectMasterCS.Level;
                    "Level Description" := SubjectMasterCS."Level Description";
                    "Core Rotation Group" := SubjectMasterCS."Core Rotation Group";
                    Examination := SubjectMasterCS.Examination;
                    //Code added for Assign Values in Fields::CSPL-00044::06-04-2020: End
                END;
                //Code added for Assign Values in Fields::CSPL-00092::04-04-2019: End
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
            TableRelation = "Subject Type-CS";
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Sessional Exam Group-CS".Group;
        }
        field(9; "Internal Maximum"; Decimal)
        {
            Caption = 'Internal Maximum';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(10; "Exam Fee"; Decimal)
        {
            Caption = 'Exam Fee';
            DataClassification = CustomerContent;
        }
        field(11; Credit; Decimal)
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(12; Capacity; Integer)
        {
            Caption = 'Capacity';
            DataClassification = CustomerContent;
        }
        field(20; "Weekly Hours"; Integer)
        {
            Caption = 'Weekly Hours';
            DataClassification = CustomerContent;
        }
        field(21; "Subject Classification"; Code[20])
        {
            Caption = 'Subject Classification';
            DataClassification = CustomerContent;
            TableRelation = "Subject Classification-CS";
        }
        field(22; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = CustomerContent;
        }
        field(23; "Preference Hours"; Code[10])
        {
            Caption = 'Preference Hours';
            DataClassification = CustomerContent;
        }
        field(24; "Max Hours Per Day"; Integer)
        {
            BlankZero = true;
            Caption = 'Max Hours Per Day';
            DataClassification = CustomerContent;
        }
        field(25; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            TableRelation = "Faculty Course Wise-CS"."Faculty Code" WHERE("Course Code" = FIELD("Course Code"),
                                                                           "Semester Code" = FIELD(Semester),
                                                                           "Year Code" = FIELD(Year));

            trigger OnValidate()
            begin
                //Code added for Insert Subject wise Detail and Section::CSPL-00092::04-04-2019: Start
                TESTFIELD("Course Code");
                TESTFIELD("Subject Code");
                FacultyDetailSubjWiseCS.Reset();
                FacultyDetailSubjWiseCS.SETRANGE("Course Code", "Course Code");
                FacultyDetailSubjWiseCS.SETRANGE("Semester Code", Semester);
                FacultyDetailSubjWiseCS.SETRANGE("Subject Code", "Subject Code");
                IF FacultyDetailSubjWiseCS.ISEMPTY() then BEGIN
                    FacultyDetailSubjWiseCS.Init();
                    ;
                    FacultyDetailSubjWiseCS."Faculty Code" := "Faculty Code";
                    IF Employee.GET("Faculty Code") THEN
                        FacultyDetailSubjWiseCS."Faculty Name" := Format(Employee."First Name" + ' ' + Employee."Last Name" + ' ' + Employee."Middle Name");
                    FacultyDetailSubjWiseCS."Course Code" := "Course Code";
                    FacultyDetailSubjWiseCS."Semester Code" := Semester;
                    FacultyDetailSubjWiseCS."Subject Code" := "Subject Code";
                    FacultyDetailSubjWiseCS.Insert();
                END;

                FacultyCourseWiseCS.Reset();
                ;
                FacultyCourseWiseCS.SETRANGE(FacultyCourseWiseCS."Faculty Code", "Faculty Code");
                IF FacultyCourseWiseCS.FindFirst() THEN
                    Section := FacultyCourseWiseCS."Section Code";
                //Code added for Insert Subject wise Detail and Section::CSPL-00092::04-04-2019: End
            end;
        }
        field(26; "Combination Code"; Code[20])
        {
            Caption = 'Combination Code';
            DataClassification = CustomerContent;
        }
        field(27; "External Pass"; Decimal)
        {
            Caption = 'External Pass';
            DataClassification = CustomerContent;
        }
        field(28; "External Maximum"; Decimal)
        {
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
        }
        field(29; "Total Pass"; Decimal)
        {
            Caption = 'Total Pass';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Total Maximum"; Decimal)
        {
            Caption = 'Total Maximum';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; Specilization; Code[20])
        {
            Caption = 'Specilization';
            DataClassification = CustomerContent;
        }
        field(32; "Minimum Passing Marks"; Decimal)
        {
        }
        field(33; Duration; DateFormula)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34; "Type of Subject"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Core,Elective,"Open Elective","FM1/IM1",Other;
            Caption = 'Type of Subject';
            Editable = false;
        }
        field(35; "Admitted Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS".Code;
            Editable = false;
        }
        field(36; "Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Group';
            TableRelation = "Subject Master-CS".Code;
            Editable = false;
        }
        field(37; "Subject Group Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Group Description';
            TableRelation = "Subject Master-CS".Code;
            Editable = false;

        }
        field(38; "Level"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Level';
            Editable = false;
        }
        field(39; "Level Description"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Level Description';
            OptionMembers = " ","Main Subject","Level 2 Systems","Level 3 Topics","Internal Exam Component","External Examination","Level 2 Clinical Rotation","Clinical Shelf Examination","Prep Examination","Level 2 Elective Rotation","Level 3 Exam","Level 3 Component","Level 3 Clinical Objective","Internal Examination";
            Editable = false;
        }
        field(40; "Core Rotation Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Core Rotation Group';
            TableRelation = "Subject Master-CS".Code;
            Editable = false;
        }
        field(41; "Examination"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Examination';
            Editable = false;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50015; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            TableRelation = "Year Master-CS";
        }
        field(50016; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            TableRelation = "Faculty Course Wise-CS"."Section Code" WHERE("Faculty Code" = FIELD("Faculty Code"),
                                                                           "Course Code" = FIELD("Course Code"),
                                                                           "Semester Code" = FIELD(Semester),
                                                                           "Year Code" = FIELD(Year));

            trigger OnValidate()
            begin
                //Code added for Validate section::CSPL-00092::04-04-2019: Start
                CourseWiseSubjectLineCS1.RESET();
                CourseWiseSubjectLineCS1.SETRANGE(CourseWiseSubjectLineCS1."Course Code", "Course Code");
                CourseWiseSubjectLineCS1.SETRANGE(CourseWiseSubjectLineCS1."Academic Year", "Academic Year");
                CourseWiseSubjectLineCS1.SETRANGE(CourseWiseSubjectLineCS1."Faculty Code", "Faculty Code");
                CourseWiseSubjectLineCS1.SETRANGE(CourseWiseSubjectLineCS1.Year, Year);
                CourseWiseSubjectLineCS1.SETRANGE(CourseWiseSubjectLineCS1."Subject Code", "Subject Code");
                CourseWiseSubjectLineCS1.SETRANGE(CourseWiseSubjectLineCS1.Semester, Semester);
                CourseWiseSubjectLineCS1.SETRANGE(CourseWiseSubjectLineCS1.Section, Section);
                IF CourseWiseSubjectLineCS1.FindFirst() THEN
                    ERROR(Text001Lbl, "Subject Code", "Faculty Code", Section);
                //Code added for Validate section::CSPL-00092::04-04-2019: End
            end;
        }
        field(50017; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            TableRelation = "Group Student-CS"."Group Code";
        }
        field(50018; "Student Batch"; Code[20])
        {
            Caption = 'Student Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            TableRelation = "Batch of Student-CS"."Batch Code";
        }
        field(50019; "Elective Group Code"; Code[20])
        {
            caption = 'Elective Group Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';

            trigger OnLookup()
            begin
                //Code added for Assign Value in Elective Group Code Field::CSPL-00092::04-04-2019: Start
                IF "Subject Type" = 'OPEN ELECTIVE' THEN BEGIN
                    SubjectMasterCS1.RESET();
                    SubjectMasterCS1.SETRANGE(SubjectMasterCS1.Course, "Course Code");
                    SubjectMasterCS1.SETRANGE(SubjectMasterCS1."Subject Type", 'OPEN ELECTIVE');
                    SubjectMasterCS1.SETRANGE(SubjectMasterCS1."Program/Open Elective Temp", SubjectMasterCS1."Program/Open Elective Temp"::"Open Elective Common Subject");
                    IF PAGE.RUNMODAL(0, SubjectMasterCS1) = ACTION::LookupOK THEN
                        "Elective Group Code" := SubjectMasterCS1.Code;

                END;

                IF "Subject Type" = 'ELECTIVE' THEN BEGIN
                    SubjectMasterCS1.RESET();
                    SubjectMasterCS1.SETRANGE(SubjectMasterCS1.Course, "Course Code");
                    SubjectMasterCS1.SETRANGE(SubjectMasterCS1."Subject Type", 'ELECTIVE');
                    SubjectMasterCS1.SETRANGE(SubjectMasterCS1."Program/Open Elective Temp", SubjectMasterCS1."Program/Open Elective Temp"::"Program Elective Common Subject");
                    IF PAGE.RUNMODAL(0, SubjectMasterCS1) = ACTION::LookupOK THEN
                        "Elective Group Code" := SubjectMasterCS1.Code;

                END;
                //Code added for Assign Value in Elective Group Code Field::CSPL-00092::04-04-2019: End
            end;
        }
        field(50020; "Program/Open Elective Temp"; Option)
        {
            Caption = 'Program/Open Elective Temp';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            OptionCaption = ' ,Open Elective Common Subject,Program Elective Common Subject';
            OptionMembers = " ","Open Elective Common Subject","Program Elective Common Subject";
        }
        field(50021; "Re-Registration"; Boolean)
        {
            Caption = 'Re-Registration';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50022; "Re-Apply"; Boolean)
        {
            Caption = 'Re-Apply';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50023; "Exam Schedule Created"; Boolean)
        {
            Caption = 'Exam Schedule Created';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50024; "Int. Exam Group Generated"; Boolean)
        {
            Caption = 'Int. Exam Group Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50025; "Int. Exam Generated"; Boolean)
        {
            Caption = 'Int. Exam Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50026; "Assignment Generated"; Boolean)
        {
            Caption = 'Assigment Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50027; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50028; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50029; "Course Faculty Generated"; Boolean)
        {
            Caption = 'Course Faculty Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50030; "External Exam Generated"; Boolean)
        {
            caption = 'External Exam Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50031; "Audit Subject"; Boolean)
        {
            Caption = 'Audit Subject';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50032; "Applicable Batch"; Text[100])
        {
            Caption = 'Applicable Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50033; "Number of Lab Component"; Integer)
        {
            Caption = 'Number Of Lab Component';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50034; "Min. Capacity"; Integer)
        {
            Caption = 'Capacity';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50035; "Max. Capacity UG"; Integer)
        {
            Caption = 'Max. Capacity UG';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50036; "Max. Capacity PG"; Integer)
        {
            Caption = 'Max. Capacity PG';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-04-2019';
        }
        field(50037; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50038; "Category Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Description';
            Editable = false;
        }
        field(50039; "Course Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(50040; "Part/Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Part/Semester';
            Editable = false;
        }
        // field(50051; "Goal Code"; Text[100])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Goal Code';
        // }
        field(50052; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50053; "Term Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Term Description';
        }
        field(50054; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50055; "Exam Sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50056; "Additional Subject"; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Crs: Record "Course Master-CS";
            begin
                if "Additional Subject" <> '' then begin
                    Crs.Reset();
                    Crs.Get("Course Code");
                    Crs.TestField("Additional Subject Grade");
                end;
            end;
        }
        field(50057; "Synch to Blackboard"; Boolean)//GAURAV//5.6.22//
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                If "Synch to Blackboard" then
                    "Blackboard Synch Status" := "Blackboard Synch Status"::Pending;
            end;
        }
        field(50058; "Blackboard Group"; Option)
        {
            Caption = 'Blackboard Group';
            DataClassification = CustomerContent;
            OptionMembers = " ",SmallGroup,LabGroup;
        }
        field(50059; "Blackboard Synch Status"; Option)
        {
            Caption = 'Blackboard Synch Status';
            OptionMembers = " ",Pending,Completed,Error;
            OptionCaption = ' ,Pending,Completed,Error';

        }


    }

    keys
    {
        key(Key1; "Course Code", Semester, "Academic Year", Year, "Subject Code", "Line No.")
        {
        }
        key(Key2; "Course Code", Semester, "Subject Type", "Subject Code")
        {
        }
        key(Key3; "Course Code", Semester, "Subject Classification")
        {
        }
        key(Key4; "Course Code", Semester, "Subject Classification", "Preference Hours", Selected)
        {
        }
        key(Key5; "Course Code", Semester, "Subject Classification", Selected)
        {
        }
        key(Key6; "Course Code", Semester, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(key7; "Exam Sequence")
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for Assign True Updated Boolean::CSPL-00092::04-04-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign True Updated Boolean::CSPL-00092::04-04-2019: End
    end;

    trigger OnInsert()
    Begin
        Inserted := true;
    End;

    var
        SubjectMasterCS: Record "Subject Master-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        FacultyDetailSubjWiseCS: Record "Faculty Detail Subj Wise-CS";
        Employee: Record "Employee";
        CourseWiseSubjectHeadCS: Record "Course Wise Subject Head-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        CourseWiseSubjectLineCS1: Record "Course Wise Subject Line-CS";
        SubjectMasterCS1: Record "Subject Master-CS";
        Text001Lbl: Label 'The same subject..%1 Faculty..%2 Section..%3 has been already selected.';
}
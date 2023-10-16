table 50077 "Course Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                           Remarks
    // 1         CSPL-00092    13-02-2019    OnInsert                          Assign User Id, Mobele Insert and Acadmic Year Field.
    // 2         CSPL-00092    13-02-2019    OnModify                          Assign Updated and Mobile Updated field
    // 3         CSPL-00092    13-02-2019    "Duration of Years" OnValidate    Insert Course detail
    // 4         CSPL-00092    13-02-2019    "Number of Semesters" OnValidate  Insert Semester Course Detail
    // 4         CSPL-00092    13-02-2019    "Course Type" OnLookup            Assign Course Type Field

    Caption = 'Course Master';
    DrillDownPageID = "Course Detail-CS";
    LookupPageID = "Course Detail-CS";
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Graduation; Code[20])
        {
            Caption = 'Graduation';
            TableRelation = "Graduation Master-CS";
            DataClassification = CustomerContent;
        }
        field(4; "Duration of Years"; Integer)
        {
            Caption = 'Duration of Years';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Insert Course detail::CSPL-00092::13-02-2019: Start
                EducationSetupCS.Reset();
                EducationSetupCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF EducationSetupCS.FINDFIRST() THEN BEGIN
                    CourseYearMasterCS.Reset();
                    CourseYearMasterCS.SETRANGE("Course Code", Code);
                    CourseYearMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    IF CourseYearMasterCS.FINDSET() THEN
                        CourseYearMasterCS.DELETEALL();
                END;

                YearMasterCS.Reset();
                YearMasterCS.SETRANGE(YearMasterCS."Sequence No.", 1, "Duration of Years");
                IF YearMasterCS.FINDSET() THEN
                    REPEAT
                        CourseYearMasterCS.INIT();
                        CourseYearMasterCS."Course Code" := Code;
                        CourseYearMasterCS."Type Of Course" := "Type Of Course";
                        CourseYearMasterCS."Year Code" := YearMasterCS.Code;
                        CourseYearMasterCS."Academic Year" := EducationSetupCS."Academic Year";
                        CourseYearMasterCS."Sequence No" := YearMasterCS."Sequence No.";
                        CourseYearMasterCS."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        CourseYearMasterCS."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        CourseYearMasterCS.INSERT(TRUE);
                    UNTIL YearMasterCS.NEXT() = 0;
                //Code added for Insert Course detail::CSPL-00092::13-02-2019: End
            end;
        }
        field(5; "Application Cost For Reserve"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost For Reserve';
            DataClassification = CustomerContent;
        }
        field(6; "Application Cost For Others"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost For Others';
            DataClassification = CustomerContent;
        }
        field(7; "Registration Cost For Reserve"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost For Reserve';
            DataClassification = CustomerContent;
        }
        field(8; "Registration Cost For Others"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost For Others';
            DataClassification = CustomerContent;
        }
        field(9; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            Enabled = false;
            TableRelation = "Department Head-CS";
            DataClassification = CustomerContent;
        }
        field(10; "Degree Code"; Code[20])
        {
            Caption = 'Degree Code';
            TableRelation = "Final Degree-CS";
            DataClassification = CustomerContent;
        }
        field(11; Entrance; Boolean)
        {
            Caption = 'Entrance';
            DataClassification = CustomerContent;
        }
        field(12; "Entrance Date"; Date)
        {
            Caption = 'Entrance Date';
            DataClassification = CustomerContent;
        }
        field(13; "Entrance Max Mark"; Decimal)
        {
            BlankZero = true;
            Caption = 'Entrance Max Mark';
            DataClassification = CustomerContent;
        }
        field(14; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(15; "Miniimum Age Limit"; Integer)
        {
            BlankZero = true;
            Caption = 'Miniimum Age Limit';
            DataClassification = CustomerContent;
        }
        field(16; "Maximum Age Limit"; Integer)
        {
            BlankZero = true;
            Caption = 'Maximum Age Limit';
            DataClassification = CustomerContent;
        }
        field(17; "Age As on Date"; Date)
        {
            Caption = 'Age As on Date';
            DataClassification = CustomerContent;
        }
        field(18; "Application Sale From"; Date)
        {
            Caption = 'Application Sale From';
            DataClassification = CustomerContent;
        }
        field(19; "Application Sale Till"; Date)
        {
            Caption = 'Application Sale Till';
            DataClassification = CustomerContent;
        }
        field(20; "Application Receive From"; Date)
        {
            Caption = 'Application Receive From';
            DataClassification = CustomerContent;
        }
        field(21; "Application Receive Till"; Date)
        {
            Caption = 'Application Receive Till';
            DataClassification = CustomerContent;
        }
        field(22; University; Code[20])
        {
            Caption = 'University';
            DataClassification = CustomerContent;
        }
        field(23; "Last Stage2 Generated List No."; Integer)
        {
            BlankZero = true;
            Caption = 'Last Stage2 Generated List No.';
            DataClassification = CustomerContent;
        }
        field(24; Capacity; Integer)
        {
            BlankZero = true;
            Caption = 'Capacity';
            DataClassification = CustomerContent;
        }
        field(25; "Present Strength"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" WHERE("Course Code" = FIELD(Code),
                                                           "Academic Year" = FIELD("Academic Year")));
            Caption = 'Present Strength';
            Editable = false;
        }
        field(26; "Number of Semesters"; Integer)
        {
            Caption = 'Number of Semesters';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Insert Semester Course Detail::CSPL-00092::13-02-2019: Start
                EducationSetupCS.Reset();
                EducationSetupCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF EducationSetupCS.FINDFIRST() THEN BEGIN
                    CourseSemMasterCS1.Reset();
                    CourseSemMasterCS1.SETRANGE("Course Code", Code);
                    CourseSemMasterCS1.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    IF CourseSemMasterCS1.FINDSET() THEN
                        CourseSemMasterCS1.DELETEALL();
                END;

                SemesterMasterCS.Reset();
                SemesterMasterCS.SETCURRENTKEY(Code);
                SemesterMasterCS.SETRANGE(Graduation, Graduation);
                SemesterMasterCS.SETRANGE(SemesterMasterCS.Sequence, 1, "Number of Semesters");
                IF SemesterMasterCS.FINDSET() THEN
                    REPEAT
                        CourseSemMasterCS.INIT();
                        CourseSemMasterCS."Course Code" := Code;
                        CourseSemMasterCS."Type Of Course" := "Type Of Course";
                        CourseSemMasterCS."Semester Code" := SemesterMasterCS.Code;
                        CourseSemMasterCS."Academic Year" := EducationSetupCS."Academic Year";
                        CourseSemMasterCS."Sequence No" := SemesterMasterCS.Sequence;
                        CourseSemMasterCS."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        CourseSemMasterCS."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        CourseSemMasterCS.INSERT(TRUE);
                    UNTIL SemesterMasterCS.NEXT() = 0;
                //Code added for Insert Semester Course Detail::CSPL-00092::13-02-2019: End
            end;
        }
        field(27; "Last Stage1 Generated List No."; Integer)
        {
            Caption = 'Last Stage1 Generated List No.';
            DataClassification = CustomerContent;
        }
        field(28; "Total Credit"; Decimal)
        {
            Caption = 'Total Credit';
            DataClassification = CustomerContent;
        }
        field(29; "Final Semester Code"; Code[20])
        {
            Caption = 'Final Semester Code';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(30; "Course Droped"; Boolean)
        {
            Caption = 'Course Droped';
            DataClassification = CustomerContent;
        }
        field(31; "Grace Marks"; Decimal)
        {
            Caption = 'Grace Marks';
            DataClassification = CustomerContent;
        }
        field(32; "Credit Required"; Integer)
        {
            Caption = 'Credit Required';
            DataClassification = CustomerContent;
        }
        field(33; "Lateral Entry Allowed"; Boolean)
        {
            Caption = 'Lateral Entry Allowed';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 15-02-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 15-02-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 15-02-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[20])
        {
            Description = 'CS Field Added 15-02-2019';
            TableRelation = "Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(50015; Year; Code[20])
        {
            Description = 'CS Field Added 15-02-2019';
            TableRelation = "Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(50016; Semester; Code[10])
        {
            Caption = 'Semester';
            Description = 'CS Field Added 15-02-2019';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(50017; "Assignment Mark"; Decimal)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Assignment Mark';
            DataClassification = CustomerContent;
        }
        field(50020; "Attendance Percentage"; Integer)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Assignment Percentage';
            DataClassification = CustomerContent;
        }
        field(50021; "Convert Type Of Course"; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Convert Type Of Course';
            DataClassification = CustomerContent;
        }
        field(50023; "Course Closed"; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Course Closed';
            DataClassification = CustomerContent;
        }
        field(50024; "Department Name"; Text[80])
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Department Name';
            DataClassification = CustomerContent;
        }
        field(50025; "Promotion Criteria"; Option)
        {
            Description = 'CS Field Added 15-02-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Promotion Criteria';
            DataClassification = CustomerContent;
        }
        field(50026; "Min. Passing Credit"; Decimal)
        {
            Description = 'CS Field Added 15-02-2019';
        }
        field(50027; "Group Mandatory"; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Group Mandatory';
            DataClassification = CustomerContent;
        }
        field(50028; "SIS Code"; Code[10])
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'SIS Code';
            DataClassification = CustomerContent;
        }
        field(50029; Updated; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50030; "Course Type"; Option)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Course Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Degree,Certificate,Diploma';
            OptionMembers = " ",Degree,Certificate,Diploma;
        }
        field(50031; "Mobile Insert"; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(50032; "Mobile Update"; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
        }
        field(50033; Taxable; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Taxable';
            DataClassification = CustomerContent;
        }
        field(50034; "Duration in Month"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50035; "Event Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Education Event-CS"."Event Code";
        }
        field(50036; "Admitted Year Wise Fee"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50037; "Semester Wise Fee"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50038; "Enrollment Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50039; "Financial AID Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50040; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50041; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50042; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50043; "Course Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",GHT;
        }
        field(50044; "Academic SAP"; Integer)
        {
            Caption = 'Academic SAP';
            DataClassification = CustomerContent;
        }
        field(50045; "Core Rotation Weeks"; Decimal)
        {
            Caption = 'Core Rotation Weeks';
            DataClassification = CustomerContent;
            DecimalPlaces = 0;
        }
        field(50046; "Elective Rotation Weeks"; Decimal)
        {
            Caption = 'Elective Rotation Weeks';
            DataClassification = CustomerContent;
            DecimalPlaces = 0;
        }
        field(50047; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50048; "Clinical Clerkship Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Clerkship Applicable';
        }

        field(50049; "Logo Image"; Blob)
        {
            Caption = 'Logo Image';
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;

        }

        field(50050; "Transcript Data Filter"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50051; "Honors Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50052; "Min CGPA Required"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum CGPA For Degree';
        }
        field(50053; "Non Degree"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50054; "Show Grade Description"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50055; "Course Change Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50056; "OLR Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50057; "New OLR Enabled"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'New OLR Enabled';
            Trigger OnValidate()
            var
                HoldBulkUpload_lCU: Codeunit "Hold Bulk Upload";
                StudentType: Option " ",New,Returning;
            Begin
                // If "New OLR Enabled" then begin
                //     If Confirm('Do you want to reset OLR information for all the New Student whose Course : %1?', true, Rec.Code) then
                //         HoldBulkUpload_lCU.ResetStudentforOLR(Rec.Code, StudentType::New)
                //     Else
                //         "New OLR Enabled" := false;
                // end;
            End;
        }
        Field(50058; "Returning OLR Enabled"; Boolean)
        {
            DataClassification = CustomerContent;
            Trigger OnValidate()
            var
                HoldBulkUpload_lCU: Codeunit "Hold Bulk Upload";
                StudentType: Option " ",New,Returning;
            Begin
                // If "Returning OLR Enabled" then begin
                //     If Confirm('Do you want to reset OLR information for all the Returning Student whose Course : %1?', true, Rec.Code) then
                //         HoldBulkUpload_lCU.ResetStudentforOLR(Rec.Code, StudentType::Returning)
                //     Else
                //         "Returning OLR Enabled" := false;
                // end;
            End;
        }
        field(50059; "Additional Subject Grade"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50060; "Consider for Grading"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50061; "EMT Transcript"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50062; "Advance Course(EMT)"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50063; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Category Master"."Category Code";
            trigger OnValidate()
            var
                SubjectCategory: Record "Subject Category Master";
            begin
                IF "Category Code" <> '' then begin
                    IF SubjectCategory.get("Category Code") then
                        "Category Description" := SubjectCategory."Category Code";
                end else
                    "Category Description" := '';
            end;
        }
        field(50064; "Category Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Description';
            Editable = false;
        }


        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 15-02-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 15-02-2019';
            DataClassification = CustomerContent;
        }
        field(33048922; Section; Code[10])
        {
            Description = 'CS Field Added 15-02-2019';
            TableRelation = "Count Transaction-CS";
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(33048923; "Discount Granted"; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Discount Granted';
            DataClassification = CustomerContent;
        }
        field(33048924; "Optional Pre Qualification"; Boolean)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'Optional Pre Qualification';
            DataClassification = CustomerContent;
        }
        field(33048925; "USIN No."; Integer)
        {
            Description = 'CS Field Added 15-02-2019';
            Caption = 'USIN No.';
            DataClassification = CustomerContent;
        }
        field(33048926; Block; boolean)
        {

            Caption = 'Block';
            DataClassification = CustomerContent;
        }
        field(33048927; "Program Version ID"; code[20])
        {

            Caption = 'Program Version ID';
            DataClassification = CustomerContent;
        }
        field(33048928; "Program Group ID"; code[20])
        {
            Caption = 'Program Group ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Graduation)
        {
        }
        key(Key3; Description)
        {
        }
        key(Key4; "Global Dimension 1 Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Global Dimension 1 Code")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for Assign User Id, Mobele Insert and Acadmic Year Field::CSPL-00092::13-02-2019: Start
        "User ID" := FORMAT(UserId());
        "Mobile Insert" := TRUE;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();

        Inserted := true;
        //Code added for Assign User Id, Mobele Insert and Acadmic Year Field::CSPL-00092::13-02-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Updated and Mobile Updated field::CSPL-00092::13-02-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        //Code added for Assign Updated and Mobile Updated field::CSPL-00092::13-02-2019: End
    end;

    var

        CourseSemMasterCS: Record "Course Sem. Master-CS";
        SemesterMasterCS: Record "Semester Master-CS";
        CourseSemMasterCS1: Record "Course Sem. Master-CS";
        CourseYearMasterCS: Record "Course Year Master-CS";
        YearMasterCS: Record "Year Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";


}


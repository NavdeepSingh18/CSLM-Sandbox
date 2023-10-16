table 50058 "Subject Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    13-03-2019    OnInsert                      Assign in User Id and Mobile Insert Field.
    // 2         CSPL-00092    13-03-2019    OnModify                      Assign in Update and Mobile update Field.
    // 3         CSPL-00092    13-03-2019    Code OnValidate               Assign True in Audit Subject Field
    // 4         CSPL-00092    13-03-2019    Course OnValidate             Assign value in Dimensions and Type of Coures Field
    // 5         CSPL-00092    13-03-2019    Elective Group Code OnLookup  Select Elective Group Code

    Caption = 'Subject Master';
    DrillDownPageID = "Subject Detail -CS";
    LookupPageID = "Subject Detail -CS";
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                //Code added for Assign True in Audit Subject Field::CSPL-00092::13-03-2019: Start
                "Audit Subject" := TRUE;
                //Code added for Assign True in Audit Subject Field::CSPL-00092::13-03-2019: End
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Description = '//CS-length 80-100';
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Academic Year Master-CS";
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
            trigger OnValidate()
            var
                SubjectType: Record "Subject Type-CS";
            begin
                "Type of Subject" := "Type of Subject"::" ";
                SubjectType.Reset();
                if SubjectType.Get("Subject Type") then begin
                    SubjectType.TestField("Type of Subject");
                    "Type of Subject" := SubjectType."Type of Subject";
                end;
            end;
        }
        field(5; "Subject Classification"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            TableRelation = "Subject Classification-CS";
            trigger OnValidate()
            begin
                if SubjectClassificationRec.Get("Subject Classification") then
                    "Attendance Not Applicable" := SubjectClassificationRec."Attendance Not Applicable"
                else
                    "Attendance Not Applicable" := false;
            end;
        }
        field(6; Credit; Decimal)
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(7; "Min. Capacity"; Integer)
        {
            Caption = 'Capacity';
            DataClassification = CustomerContent;
        }
        field(8; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Group Student-CS"."Group Code";
        }
        field(9; "Internal Maximum"; Decimal)
        {
            Caption = 'Internal Maximum';
            DataClassification = CustomerContent;
        }
        field(10; "External Pass"; Decimal)
        {
            Caption = 'External Pass';
        }
        field(11; "External Maximum"; Decimal)
        {
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
        }
        field(12; "Total Pass"; Decimal)
        {
            Caption = 'Total Pass';
            DataClassification = CustomerContent;
        }
        field(13; "Total Maximum"; Decimal)
        {
            Caption = 'Total Maximum';
            DataClassification = CustomerContent;
        }
        field(14; "Exam Fee"; Decimal)
        {
            Caption = 'Exam Fee';
            DataClassification = CustomerContent;
        }
        field(15; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign value in Dimensions and Type of Coures Field::CSPL-00092::13-03-2019: Start
                //Course:= '0' + Course;
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, Course);
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                END;
                //Code added for Assign value in Dimensions and Type of Coures Field::CSPL-00092::13-03-2019: End
            end;
        }
        field(16; "Internal Subject Code"; Code[20])
        {
            Caption = 'Internal Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(17; "Max. Capacity UG"; Integer)
        {
            Caption = 'Max Capacity UG';
            DataClassification = CustomerContent;
        }
        field(18; "Max. Capacity PG"; Integer)
        {
            Caption = 'Max Capacity UG';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //"Global Dimension 1 Code":= '0' + "Global Dimension 1 Code";
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
            TableRelation = "Semester Master-CS";
        }
        field(50004; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50008; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
            TableRelation = "Year Master-CS";
        }
        field(50009; "Elective Group Code"; Code[20])
        {
            Caption = 'Elective Group Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';

            trigger OnLookup()
            begin
                //Code added for Select Elective Group Code::CSPL-00092::13-03-2019: Start
                IF "Subject Type" = 'OPEN ELECTIVE' THEN BEGIN
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETRANGE(SubjectMasterCS."Subject Type", 'OPEN ELECTIVE');
                    IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN
                        "Elective Group Code" := SubjectMasterCS.Code;

                END;

                IF "Subject Type" = 'ELECTIVE' THEN BEGIN
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SETRANGE(SubjectMasterCS."Subject Type", 'ELECTIVE');
                    IF PAGE.RUNMODAL(0, SubjectMasterCS) = ACTION::LookupOK THEN
                        "Elective Group Code" := SubjectMasterCS.Code;

                END;
                //Code added for Select Elective Group Code::CSPL-00092::13-03-2019: Start
            end;
        }
        field(50010; "Subject Closed"; Boolean)
        {
            Caption = 'Subject Closed';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50011; "Audit Subject"; Boolean)
        {
            Caption = 'Audit Subject';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50012; "Program/Open Elective Temp"; Option)
        {
            Caption = 'Program/Open Elective Temp';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
            OptionCaption = ' ,Open Elective Common Subject,Program Elective Common Subject';
            OptionMembers = " ","Open Elective Common Subject","Program Elective Common Subject";
        }
        field(50013; "Assign max marks"; Decimal)
        {
            Caption = 'Max Capacity UG';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50014; "Assigment Calculation"; Decimal)
        {
            Caption = 'Assigment Calculation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50015; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50016; "Internal Pass"; Decimal)
        {
            Caption = 'Internal Pass';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50017; "Applicable Batch"; Text[100])
        {
            Caption = 'Applicable Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50018; "Number of Lab Component"; Integer)
        {
            Caption = 'Number of Lab Component';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50019; "Subject Wise Examination"; Boolean)
        {
            Caption = 'Subject Wise Examination';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50020; "Re-Apply"; Boolean)
        {
            Caption = 'Re-Apply';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50021; "Subject Not Required"; Boolean)
        {
            Caption = 'Subject Not Required';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50022; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50023; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50024; "Common Subject"; Boolean)
        {
            Caption = 'Common Subject';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50025; Specilization; Code[100])
        {
            Caption = 'Specilization';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(50026; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Category Master"."Category Code";
            trigger OnValidate()
            begin
                IF SubjectCategory.get("Category Code") then begin
                    "Category Description" := SubjectCategory."Category Code";
                    "Course Description" := SubjectCategory."Category Description";
                    "Part/Semester" := SubjectCategory.Semester;
                end else begin
                    "Category Description" := '';
                    "Course Description" := '';
                    "Part/Semester" := '';
                end;
            end;
        }
        field(50028; "Category Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Description';
            Editable = false;
        }
        field(50029; "Course Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(50030; "Part/Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Part/Semester';
            Editable = false;
        }
        field(50031; Duration; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(50032; "Type of Subject"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Core,Elective,"Open Elective","FM1/IM1",Other;
            Caption = 'Type of Subject';
        }

        field(50033; "Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Group';
            trigger OnValidate()
            var
                SubjectMasterRec: Record "Subject Master-CS";
            begin
                // if Level = 0 then
                //     Error('Level must be define first.');

                If Rec."Subject Group" <> '' then begin
                    SubjectMasterRec.RESET();
                    SubjectMasterRec.Setrange(Code, "Subject Group");
                    if SubjectMasterRec.FindFirst() then
                        "Subject Group Description" := SubjectMasterRec.Description;
                end Else
                    "Subject Group Description" := '';

            end;

            trigger OnLookup()
            var
                SubjectMasterRec: Record "Subject Master-CS";
            begin
                // if Level = 0 then
                //     Error('Level must be define first.');

                SubjectMasterRec.RESET();
                SubjectMasterRec.FILTERGROUP(2);
                SubjectMasterRec.Setrange("Subject Closed", false);
                SubjectMasterRec.SetRange(Level, Level - 1);
                SubjectMasterRec.FILTERGROUP(0);
                IF PAGE.RUNMODAL(0, SubjectMasterRec) = ACTION::LookupOK THEN BEGIN
                    "Subject Group" := SubjectMasterRec.Code;
                    "Subject Group Description" := SubjectMasterRec."Subject Group Description";
                end;
            end;
        }
        field(50034; "Subject Group Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Group Description';
            Editable = false;
        }

        field(50035; Level; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Level';
            TableRelation = Level;
        }
        field(50036; "Level Description"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Level Description';
            OptionMembers = " ","Main Subject","Level 2 Systems","Level 3 Topics","Internal Exam Component","External Examination","Level 2 Clinical Rotation","Clinical Shelf Examination","Prep Examination","Level 2 Elective Rotation","Level 3 Exam","Level 3 Component","Level 3 Clinical Objective","Internal Examination";
            Editable = false;
        }
        field(50037; "Core Rotation Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Core Rotation Group';
            TableRelation = "Subject Master-CS".Code;
        }
        field(50038; "Examination"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Examination';
        }
        field(50039; "Subject Prefix"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Prefix';
            TableRelation = "Subject Prefix".Code;
        }
        field(50040; "Maximum Weightage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Weightage';
        }
        field(50050; "Exam Opt Out"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Exam Opt Out';
        }
        // field(50051; "Goal Code"; Text[250])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Goal Code';
        //     //TableRelation = "Subject Goal"."Goal Code" where("Subject Code" = field(Code));
        // }
        field(50052; "Max Capacity of Lab"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Max Capacity of Lab';
        }
        field(50053; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50054; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50055; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50056; "Attendance Not Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Attendance Not Applicable';

        }
        field(50057; "Level Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Level Code';
            TableRelation = "Level Wise Description"."Level Code" where(Level = field(Level));
            trigger OnValidate()
            begin

                LevelWiseDescriptionRec.Reset();
                LevelWiseDescriptionRec.Setrange("Level Code", "Level Code");
                if LevelWiseDescriptionRec.FindFirst() then
                    "Level Description" := LevelWiseDescriptionRec."Level Description"
                else
                    "Level Description" := "Level Description"::" ";
            end;

            // trigger OnLookup()
            // begin
            //     LevelWiseDescriptionRec.Reset();
            //     LevelWiseDescriptionRec.FILTERGROUP(2);
            //     LevelWiseDescriptionRec.Setrange(Level, Level);
            //     LevelWiseDescriptionRec.FILTERGROUP(0);
            //     IF PAGE.RUNMODAL(0, LevelWiseDescriptionRec) = ACTION::LookupOK THEN BEGIN
            //         "Level Code" := LevelWiseDescriptionRec."Level Code";
            //         "Level Description" := LevelWiseDescriptionRec."Level Description";
            //     end else begin
            //         "Level Code" := '';
            //         "Level Description" := "Level Description"::" ";
            //     end;
            // end;
        }

        field(50058; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50059; "Score type"; Option)
        {
            OptionMembers = " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK";
            OptionCaption = ' ,CBSE,CCSE,CCSSE,STEP 1,STEP 2 CS,STEP 2 CK';
        }
        field(50060; "Exam Sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50061; "CCSSE Exam Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50062; "Exam Schedule"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50063; "Exam Record Not Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50064; "Subject Sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        Field(50065; "Elective Offering"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50066; "BSIC/MED4 not Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16-06-2019';
        }
    }

    keys
    {
        key(Key1; "Code", Course)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for Assign in User Id and Mobile Insert Field::CSPL-00092::13-03-2019: Start
        "User ID" := FORMAT(UserId());
        "Mobile Insert" := TRUE;
        Inserted := True;
        //Code added for Assign in User Id and Mobile Insert Field::CSPL-00092::13-03-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign in Update and Mobile update Field::CSPL-00092::13-03-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;
        //Code added for Assign in Update and Mobile update Field::CSPL-00092::13-03-2019: End
    end;

    var
        CourseMasterCS: Record "Course Master-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        SubjectCategory: Record "Subject Category Master";
        SubjectClassificationRec: Record "Subject Classification-CS";
        LevelWiseDescriptionRec: Record "Level Wise Description";
}


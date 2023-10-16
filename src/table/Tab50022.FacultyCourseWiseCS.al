table 50022 "Faculty Course Wise-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                             Remarks
    // 1         CSPL-00092    04-05-2019    OnInsert                            User Id Assign in User Id Field.
    // 2         CSPL-00092    04-05-2019    OnModify                          Assign Value in User Updated Field
    // 3         CSPL-00092    04-05-2019    Course Code - OnValidate          Assign Value in Fields
    // 4         CSPL-00092    04-05-2019    Faculty Code - OnValidate         Assign Value in Faculty Name Field
    // 5         CSPL-00092    04-05-2019    Subject Code - OnValidate         Assign Value in Subject Description Field
    // 6         CSPL-00092    04-05-2019    Subject Code - OnLookup           Assign Value in Fields
    // 7         CSPL-00092    04-05-2019    Section Code - OnLookup           Assign Value in Section Code Field
    // 8         CSPL-00092    04-05-2019    Role - OnValidate                 Validate data

    Caption = 'Faculty Course Wise';
    DrillDownPageID = "Faculty-Course Wise";
    LookupPageID = "Faculty-Course Wise";

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::04-05-2019: Start
                CourseMasterCS1.Reset();
                CourseMasterCS1.SETRANGE(Code, "Course Code");
                IF CourseMasterCS1.FINDFIRST() THEN BEGIN
                    "Global Dimension 1 Code" := CourseMasterCS1."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS1."Global Dimension 2 Code";
                    "Type Of Course" := CourseMasterCS1."Type Of Course";
                    Graduation := CourseMasterCS1.Graduation;
                END ELSE BEGIN
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    Graduation := '';
                END;
                //Code added for Assign Value in Fields::CSPL-00092::04-05-2019: End
            end;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Faculty Name Field::CSPL-00092::04-05-2019: Start
                Employee.Reset();
                Employee.SETRANGE(Employee."No.", "Faculty Code");
                IF Employee.FindFirst() THEN
                    "Faculty Name" := Employee."First Name";

                //Code added for Assign Value in Faculty Name Field::CSPL-00092::04-05-2019: End
            end;
        }
        field(4; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::04-05-2019: Start
                IF "Course Code" = '' THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                    //   CourseWiseSubjectLineCS.SETRANGE(Year, "Year Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, "Semester Code");
                    IF CourseWiseSubjectLineCS.FINDFIRST() THEN
                        IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                            "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                            "Subject Description" := CourseWiseSubjectLineCS.Description;
                        END ELSE BEGIN
                            "Subject Code" := '';
                            "Subject Description" := '';
                        END;
                END ELSE
                    CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", "Course Code");
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
                // CourseWiseSubjectLineCS.SETRANGE(Year, "Year Code");
                CourseWiseSubjectLineCS.SETRANGE(Semester, "Semester Code");
                IF CourseWiseSubjectLineCS.FINDFIRST() THEN
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                        "Subject Description" := CourseWiseSubjectLineCS.Description;
                    END ELSE BEGIN
                        "Subject Code" := '';
                        "Subject Description" := '';
                    END;
                //Code added for Assign Value in Fields::CSPL-00092::04-05-2019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Subject Description Field::CSPL-00092::04-05-2019: Start
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN
                    "Subject Description" := SubjectMasterCS.Description
                ELSE
                    "Subject Description" := '';
                //Code added for Assign Value in Subject Description Field::CSPL-00092::04-05-2019: End
            end;
        }
        field(6; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Assign Value in Section Code Field::CSPL-00092::04-05-2019: Start
                IF "Course Code" = '' THEN BEGIN
                    IF PAGE.RUNMODAL(0, SectionMasterCS) = ACTION::LookupOK THEN
                        "Section Code" := SectionMasterCS.Code;
                END ELSE
                    CourseSectionMasterCS.Reset();
                CourseSectionMasterCS.SETRANGE("Course Code", "Course Code");
                CourseSectionMasterCS.SETRANGE("Academic Year", "Academic Year");
                CourseSectionMasterCS.SETRANGE(Semester, "Semester Code");
                CourseSectionMasterCS.SETRANGE(Year, "Year Code");
                CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF CourseSectionMasterCS.FINDFIRST() THEN
                    "Section Code" := CourseSectionMasterCS."Section Code";
                //Code added for Assign Value in Section Code Field::CSPL-00092::04-05-2019: End
            end;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(12; "Faculty Name"; Text[30])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
        }
        field(13; "Subject Description"; Text[100])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(50000; Role; Code[20])
        {
            Caption = 'Role';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "User Group-CS"."User Group";

            trigger OnValidate()
            begin
                //Code added for Validate data::CSPL-00092::04-05-2019: Start
                IF "Faculty Code" = '' THEN
                    ERROR('Please fill the faculty Code');

                IF "Section Code" <> '' THEN
                    IF Role = 'SUBJECT COORDINATOR' THEN
                        ERROR('You can not enter this role');
                //Code added for Validate data::CSPL-00092::04-05-2019: End
            end;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Year Code"; Code[10])
        {
            Caption = 'Year Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50020; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50021; Graduation; Code[20])
        {
            Caption = 'Graduation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Graduation Master-CS";
        }
        field(50022; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Subject Classification-CS";
        }
        field(50023; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Batch-CS";
        }
        field(50024; Group; Code[20])
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Group Master-CS".Code;
        }
        field(50025; "Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Code';
            TableRelation = "Faculty Category";
            trigger OnValidate()
            begin
                if FacultyCategoryRec.Get("Category Code") then
                    "Category Description" := FacultyCategoryRec."Category Description"
                else
                    "Category Description" := '';
            end;
        }
        field(50026; "Category Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Description';
            Editable = false;
        }

        field(50027; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
    }

    keys
    {
        key(Key1; "Course Code", "Faculty Code", "Semester Code", "Section Code", "Line No")
        {
        }
        key(Key2; "Faculty Code", "Faculty Name", "Section Code")
        {
        }
        key(Key3; "Line No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Faculty Code", "Faculty Name", "Section Code")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::04-05-2019: Start
        "User ID" := FORMAT(UserId());

        Inserted := true;
        //Code added for User Id Assign in User Id Field::CSPL-00092::04-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in User Updated Field::CSPL-00092::04-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in User Updated Field::CSPL-00092::04-05-2019: End
    end;

    var
        Employee: Record "Employee";
        SubjectMasterCS: Record "Subject Master-CS";

        SectionMasterCS: Record "Section Master-CS";
        CourseSectionMasterCS: Record "Course Section Master-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CourseMasterCS1: Record "Course Master-CS";
        FacultyCategoryRec: Record "Faculty Category";
}


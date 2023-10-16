table 50000 "Faculty Detail Subj Wise-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    30-04-2019    OnInsert                      User Id Assign in User Id Field.
    // 2         CSPL-00092    30-04-2019    OnModify                      Assign Value in Updated Field
    // 3         CSPL-00092    30-04-2019    Faculty Code - OnValidate     Assign Value in faculty Name Field
    // 4         CSPL-00092    30-04-2019    Subject Code - OnValidate     Assign Value in Subject Description Field

    Caption = 'Faculty Subject - COL';
    DataClassification = CustomerContent;
    // DrillDownPageID = "Student Detail-CS";
    // LookupPageID = "Student Detail-CS";

    fields
    {
        field(1; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Assign Value in faculty Name Field::CSPL-00092::30-04-2019: Start
                IF "Faculty Code" <> '' THEN
                    IF Employee.GET("Faculty Code") THEN
                        "Faculty Name" := (Employee."First Name" + ' ' + Employee."Last Name" + ' ' + Employee."Middle Name");
                //Code added for Assign Value in faculty Name Field::CSPL-00092::30-04-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS".Code WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(3; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Mother Tongue-CS";
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Certificate-CS" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code")//,
                                                                                                               /*Field15 = FIELD("Course Code"),
                                                                                                               Field3 = FIELD("Academic Year")*/);

            trigger OnValidate()
            begin
                //Code added for Assign Value in Subject Description Field::CSPL-00092::30-04-2019: Start
                CLEAR("Subject Description");
                IF SubjectMasterCS.GET("Subject Code") THEN
                    "Subject Description" := CopyStr(SubjectMasterCS.Description, 1, MaxStrLen("Subject Description"));
                //Code added for Assign Value in Subject Description Field::CSPL-00092::30-04-2019: End
            end;
        }
        field(5; "Course Master"; Boolean)
        {
            Caption = 'Course Master';
            DataClassification = CustomerContent;
        }
        field(6; "Alloted Hours"; Integer)
        {
            Caption = 'Alloted Hours';
            DataClassification = CustomerContent;
        }
        field(7; "Weekly Hours"; Integer)
        {
            Caption = 'Weekly Hours';
            DataClassification = CustomerContent;
        }
        field(8; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(10; Available; Boolean)
        {
            Caption = 'Available';
            DataClassification = CustomerContent;
        }
        field(11; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Citizenship Master-CS";
        }
        field(12; "Faculty Name"; Text[30])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
        }
        field(13; "Subject Description"; Text[50])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Year Code"; Code[10])
        {
            Caption = 'Year Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50015; "Theory Load"; Integer)
        {
            Caption = 'Thepry Load';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(50016; "Practical Load"; Integer)
        {
            Caption = 'Practical Load';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(50017; Activity; Text[250])
        {
            Caption = 'Activity';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(50118; "Actual Load"; Integer)
        {
            Caption = 'Actual Load';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(50119; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
    }

    keys
    {
        key(Key1; "Faculty Code", "Course Code", "Semester Code", "Section Code", "Subject Code", "Academic Year")
        {
        }
        key(Key2; "Course Code", "Semester Code", "Subject Code", Available)
        {
        }
        key(Key3; "Course Code", "Semester Code", "Section Code", "Subject Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::30-04-2019: Start
        "User ID" := CopyStr(USERID(), 1, MaxStrLen("User ID"));
        //Code added for User Id Assign in User Id Field::CSPL-00092::30-04-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::30-04-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::30-04-2019: End
    end;

    var
        Employee: Record Employee;
        SubjectMasterCS: Record "Subject Master-CS";
}


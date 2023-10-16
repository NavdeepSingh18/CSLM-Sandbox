table 50040 "Class Assignment Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    02-05-2019    OnInsert                      Assign Value in User Id and Mobile Insert Field.
    // 2         CSPL-00092    02-05-2019    OnModify                    Assign Value in Updated and Mobile Update Field
    // 3         CSPL-00092    02-05-2019    Student No. - OnValidate      Assign Value in Fields
    // 4         CSPL-00092    02-05-2019    Marks Obtained - OnValidate Assign Value in Fields

    Caption = 'Class Assignment Line-CS';

    fields
    {
        field(1; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::02-05-2019: Start
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    ClassAssignmentHeaderCS.Reset();
                    ClassAssignmentHeaderCS.SETRANGE("Assignment No.", "Assignment No.");
                    IF ClassAssignmentHeaderCS.FINDFIRST() THEN BEGIN
                        ClassAssignmentLineCS.Reset();
                        ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Student No.", "Student No.");
                        IF ClassAssignmentLineCS.FINDFIRST() THEN
                            ERROR('Student No. already exist');
                    END;
                    "Student Name" := StudentMasterCS."Student Name";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Program" := StudentMasterCS.Graduation;
                    "Student Assignment Status" := "Student Assignment Status"::Assigned;
                    ClassAssignmentHeaderCS.Reset();
                    ClassAssignmentHeaderCS.SETRANGE("Assignment No.", "Assignment No.");
                    IF ClassAssignmentHeaderCS.FINDFIRST() THEN BEGIN
                        "Maximum Mark" := ClassAssignmentHeaderCS."Maximum Mark";
                        "Maximum Weightage" := ClassAssignmentHeaderCS."Maximum Weightage";
                        "Global Dimension 1 Code" := ClassAssignmentHeaderCS."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ClassAssignmentHeaderCS."Global Dimension 2 Code";
                        "Type Of Course" := ClassAssignmentHeaderCS."Type Of Course";
                        Year := ClassAssignmentHeaderCS.Year;
                        Semester := ClassAssignmentHeaderCS.Semester;
                        "Course Code" := ClassAssignmentHeaderCS."Course Code";
                        Section := ClassAssignmentHeaderCS.Section;
                        "Academic Year" := ClassAssignmentHeaderCS."Academic Year";
                        "Subject Class" := ClassAssignmentHeaderCS."Subject Class";
                        "Subject Type" := ClassAssignmentHeaderCS."Subject Type";
                        "Subject Code" := ClassAssignmentHeaderCS."Subject Code";
                        "Exam Group" := ClassAssignmentHeaderCS."Exam Group";
                        "Exam Method Code" := ClassAssignmentHeaderCS."Exam Method Code";
                        "Faculty Code" := ClassAssignmentHeaderCS."Faculty Code";
                        "Faculty Name" := ClassAssignmentHeaderCS."Faculty Name";
                        "Created By" := FORMAT(UserId());
                        "Created On" := TODAY();
                    END;
                END ELSE BEGIN
                    "Maximum Mark" := 0;
                    "Maximum Weightage" := 0;
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Type Of Course" := "Type Of Course"::" ";
                    Year := '';
                    Semester := '';
                    "Course Code" := '';
                    Section := '';
                    "Academic Year" := '';
                    "Subject Class" := '';
                    "Subject Type" := '';
                    "Subject Code" := '';
                    "Exam Group" := '';
                    "Exam Method Code" := '';
                    "Faculty Code" := '';
                    "Faculty Name" := '';
                    "Created By" := '';
                    "Created On" := 0D;
                END;
                //Code added for Assign Value in Fields::CSPL-00092::02-05-2019: End
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Student Assignment Status"; Option)
        {
            Caption = 'Student Assignment Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Assigned,Submited,Approved,Rejected';
            OptionMembers = Assigned,Submited,Approved,Rejected;
        }
        field(5; "Submited Date"; Date)
        {
            Caption = 'Submited Date';
            DataClassification = CustomerContent;
        }
        field(6; "Marks Obtained"; Decimal)
        {
            Caption = 'Marks Obtained';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::02-05-2019: End
                IF "Marks Obtained" > "Maximum Mark" THEN
                    ERROR(Text004Lbl)
                ELSE BEGIN
                    WeightagePercentage := ("Marks Obtained" / "Maximum Mark") * 100;
                    "Weightage Obtained" := (WeightagePercentage / 100) * "Maximum Weightage";
                END;
                //Code added for Assign Value in Fields::CSPL-00092::02-05-2019: End
            end;
        }
        field(7; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Type Of Course"; Option)
        {
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50004; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50005; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Semester Master-CS";
        }
        field(50006; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Course Master-CS";
        }
        field(50007; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Section Master-CS";
        }
        field(50008; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Academic Year Master-CS";
        }
        field(50009; Session; Code[20])
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = Session;
        }
        field(50010; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50017; "Assignment Submitted"; Boolean)
        {
            Caption = 'Assignment Submitted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50018; "Order"; Integer)
        {
            Caption = 'Order';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50019; Path; Text[200])
        {
            Caption = 'Path';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50020; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = Employee."No.";
        }
        field(50021; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50022; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50023; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            Editable = false;
        }
        field(50024; "Weightage Obtained"; Decimal)
        {
            Caption = 'Weightage Obtained';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            Editable = true;
        }
        field(50025; "Marks Published"; Boolean)
        {
            Caption = 'Marks Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50026; "Subject Class"; Code[10])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Subject Classification-CS";
        }
        field(50027; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Subject Type-CS";
        }
        field(50028; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Subject Master-CS";
        }
        field(50029; "Exam Group"; Code[20])
        {
            Caption = 'Maximum Mark';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Sessional Exam Group-CS";
        }
        field(50030; "Exam Method Code"; Code[20])
        {
            Caption = 'Exam Method Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Exam Group Code-CS";
        }
        field(50031; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50032; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50033; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Group Master-CS".Code;
        }
        field(50034; "Student Batch"; Code[20])
        {
            Caption = 'Student Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Batch-CS".Code;
        }
        field(50035; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50036; "Faculty Name"; Text[80])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50037; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            OptionCaption = 'Open,Released,Published';
            OptionMembers = Open,Released,Published;
        }
        field(50038; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50039; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50040; Term; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
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
        field(33048926; "Date Result"; Date)
        {
            Caption = 'Date Result';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2021';
        }
    }

    keys
    {
        key(Key1; "Assignment No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in User Id and Mobile Insert Field::CSPL-00092::02-05-2019: Start
        "User ID" := FORMAT(UserId());
        "Mobile Insert" := TRUE;
        //Code added for Assign Value in User Id and Mobile Insert Field::CSPL-00092::02-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated and Mobile Update Field::CSPL-00092::02-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        //Code added for Assign Value in Updated and Mobile Update Field::CSPL-00092::02-05-2019: End
    end;

    var
        ClassAssignmentHeaderCS: Record "Class Assignment Header-CS";
        StudentMasterCS: Record "Student Master-CS";
        ClassAssignmentLineCS: Record "Class Assignment Line-CS";
        WeightagePercentage: Decimal;
        Text004Lbl: Label 'You Can''t Enter Marks More Than Maximum Internal Marks !!';


}


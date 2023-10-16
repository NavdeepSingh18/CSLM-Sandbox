table 50269 "Student Teacher Guardian-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   11/03/2019       OnModify()                                Code Add for any Change in data then Updated Mark.
    // 02    CSPL-00114   11/03/2019       Faculty Code - OnValidate()               Get Faculty Neme code add
    // 03    CSPL-00114   11/03/2019       Enrollment No. - OnValidate()             Code added for Student Related information fill.

    Caption = 'Student Teacher Guardian';
    DrillDownPageID = "Guardian Teacher List-CS";
    LookupPageID = "Guardian Teacher List-CS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Student Master-CS";
        }
        field(2; "Faculty Code"; Code[20])
        {
            Caption = 'faculty Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Get Faculty Neme code add::CSPL-00114::11032019: Start
                RecEmployee.Reset();
                RecEmployee.SETRANGE(RecEmployee."No.", "Faculty Code");
                IF RecEmployee.FindFirst() THEN
                    "Faculty Name" := RecEmployee."Search Name"
                ELSE
                    "Faculty Name" := '';
                //Get Faculty Neme code add::CSPL-00114::11032019: End
            END;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(4; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS".Code;
        }
        field(5; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(6; "Hostler/ Day Scholar"; Code[20])
        {
            Caption = 'Hostler/ Day Scholar';
            DataClassification = CustomerContent;
        }
        field(7; "Fathers Name"; Text[40])
        {
            Caption = 'Fathers Name';
            DataClassification = CustomerContent;
        }
        field(8; "Mothers Name"; Text[40])
        {
            Caption = 'Mothers Name';
            DataClassification = CustomerContent;
        }
        field(9; "Correspondence Address"; Text[200])
        {
            Caption = 'Correspondence Address';
            DataClassification = CustomerContent;
        }
        field(10; "Phone Number Student"; Text[30])
        {
            Caption = 'Phone Number Student';
            DataClassification = CustomerContent;
        }
        field(11; "Father/Mother Mobile No."; Text[20])
        {
            Caption = 'Father/Mother Mobile No.';
            DataClassification = CustomerContent;
        }
        field(12; "E-Mail Address Student"; Text[50])
        {
            Caption = 'E-Mail Address Student';
            DataClassification = CustomerContent;
        }
        field(13; "E-Mail Address Parent"; Text[50])
        {
            Caption = 'E-Mail Address Parent';
            DataClassification = CustomerContent;
        }
        field(14; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var

            begin
            end;
        }
        field(15; "High School %"; Code[10])
        {
            Caption = 'High School %';
            DataClassification = CustomerContent;
        }
        field(16; "Intermediate %"; Code[10])
        {
            Caption = 'Intermediate %';
            DataClassification = CustomerContent;
        }
        field(17; "Graduation %"; Code[10])
        {
            Caption = 'Graduation %';
            DataClassification = CustomerContent;
        }
        field(19; "Student Image"; BLOB)
        {
            Caption = 'Student Image';
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;
        }
        field(20; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Student Related information fill::CSPL-00114::11032019: Start
                StudentTeacherGuardianCS.Reset();
                StudentTeacherGuardianCS.SETRANGE(StudentTeacherGuardianCS."Enrollment No.", "Enrollment No.");
                IF StudentTeacherGuardianCS.FINDLAST() THEN
                    "Line No." := StudentTeacherGuardianCS."Line No." + 10000
                ELSE
                    "Line No." := 10000;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                IF StudentMasterCS.FindFirst() THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    Course := StudentMasterCS."Course Code";
                    "Course Name" := StudentMasterCS."Course Name";
                    "Type Of Course" := StudentMasterCS."Type Of Course";
                    Semester := StudentMasterCS.Semester;
                    "Program" := StudentMasterCS.Graduation;
                    Section := StudentMasterCS.Section;
                    "No." := StudentMasterCS."No.";
                    "Fathers Name" := StudentMasterCS."Fathers Name";
                    "Mothers Name" := StudentMasterCS."Mothers Name";
                    "Phone Number Student" := StudentMasterCS."Phone Number";
                    "Father/Mother Mobile No." := StudentMasterCS."Father Contact Number";
                    "E-Mail Address Student" := StudentMasterCS."E-Mail Address";
                    "Date of Birth" := StudentMasterCS."Date of Birth";
                    "Academic Year" := StudentMasterCS."Academic Year";
                    "Roll No." := StudentMasterCS."Roll No.";
                    Batch := StudentMasterCS.Batch;
                    "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                    Group := StudentMasterCS.Group;
                    Year := StudentMasterCS.Year;
                    StudentMasterCS.CALCFIELDS(StudentMasterCS."Student Image");
                    "Student Image" := StudentMasterCS."Student Image";
                END;
                //Code added for Student Related information fill::CSPL-00114::11032019: End
            end;
        }
        field(21; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            TableRelation = "Batch of Student-CS";
        }
        field(22; Group; Code[20])
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
            TableRelation = "Group Student-CS";
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(25; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(26; "Communication Date"; Date)
        {
            Caption = 'Communication Date';
            DataClassification = CustomerContent;
        }
        field(27; "Contact Person Name"; Text[50])
        {
            Caption = 'Contact Person Name';
            DataClassification = CustomerContent;
        }
        field(28; "Contact Person Phone No."; Text[30])
        {
            Caption = 'Contact Person Phone No.';
            DataClassification = CustomerContent;
        }

        field(29; "Interaction Summary"; Text[250])
        {
            Caption = 'Interaction Summary';
            DataClassification = CustomerContent;
        }
        field(30; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(31; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(32; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(33; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(34; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(35; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(50001; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11032019';
        }
        field(50002; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11032019';
        }
        field(50003; "Modefied By"; Code[30])
        {
            Caption = 'Modefied By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11032019';
        }
        field(50004; "Modefied On"; Date)
        {
            Caption = 'Modefied On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11032019';
        }
        field(50005; "Faculty Name"; Text[250])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11032019';
        }
        field(50006; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11032019';
        }
        field(50007; "Roll No."; Code[10])
        {
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11032019';
        }
    }

    keys
    {
        key(Key1; "No.", "Academic Year", Semester)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DrpoDown; "No.", "Enrollment No.")
        {
        }
    }

    trigger OnModify()
    begin
        //Code Add for any Change in data then Updated Mark::CSPL-00114::11032019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code Add for any Change in data then Updated Mark::CSPL-00114::11032019: End
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        StudentTeacherGuardianCS: Record "Student Teacher Guardian-CS";
        RecEmployee: Record "Employee";
}


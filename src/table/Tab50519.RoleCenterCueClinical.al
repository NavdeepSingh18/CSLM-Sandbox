table 50519 RoleCenterCueClinical
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Group Master"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Group Master-CS");
        }
        field(3; "Student Group"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Group Student-CS");
        }
        field(4; "Students Apprchng to GAP"; integer)
        {
            caption = 'Students Approching to GAP';
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Semester = filter('CLN5|CLN6|CLN7|CLN8'), "Course Code" = filter('NA')));
        }
        field(6; "Studs. on CLOA"; integer)
        {
            caption = 'Students on CLOA';
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('CLOA')));
        }
        field(7; "FIU Stud."; Integer)
        {
            Caption = 'FIU Students';
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Course Code" = filter('AUA-GHT')));
        }
        field(8; "Stud. with Clinical Hold"; integer)
        {
            Caption = 'Student with Clinical Hold';
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Clinical Hold Exist" = filter(true)));
        }
        field(5; "My Students DS"; integer)
        {
            Caption = 'My Students Document Specialist';
        }
        field(10; "My Students FMIM"; integer)
        {
            Caption = 'My Students FM1/IM1 Coordinator';
        }
        field(15; "My Students CC"; integer)
        {
            Caption = 'My Students Clerkship Coordinator';
        }
        field(20; "Students Approching to GAP"; integer)
        {

        }
        field(22; "Students on CLOA"; integer)
        {

        }
        field(24; "FIU Students"; Integer)
        {

        }
        field(28; "Student with Clinical Hold"; integer)
        {
        }
        field(30; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
        }
        field(32; "Document Pending for Approval"; Integer)
        {
        }
        field(34; "Pending Site Selection Apps"; Integer)
        {
            Caption = 'Pending Site Selection Application';
        }
        field(36; "Pending Special Accomo. Apps."; Integer)
        {
            Caption = 'Pending Special Accommodation Application';
        }
        field(38; "Pndng to Cnfrm Elcve Rotn Apps"; Integer)
        {
            Caption = 'Pending to Confirm Elective Rotation Application';
        }
        field(40; "Pndng Elcve Rotn Apps Approval"; Integer)
        {
            Caption = 'Pending Elective Rotation Application Approval';
        }
        field(42; "Pndg Non-Affiliated Apps"; Integer)
        {
            Caption = 'Pending Non-Affiliated Application';
        }
        field(44; "FM1/IM1 Rotations to Schedule"; Integer)
        {
            Caption = 'FM1/IM1 Rotations to Schedule';
        }
        field(46; "Core Rotations to Schedule"; Integer)
        {
            Caption = 'Core Rotations to Schedule';
        }
        field(47; "Elective Rotations to Schedule"; Integer)
        {
            Caption = 'Elective Rotations to Schedule';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
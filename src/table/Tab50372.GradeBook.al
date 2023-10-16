table 50372 "Grade Book"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                "First Name" := '';
                "Middle Name" := '';
                "Last Name" := '';
                "Student Name" := '';
                "Enrollment No." := '';
                Semester := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student No.") then begin
                    "First Name" := StudentMaster."First Name";
                    "Middle Name" := StudentMaster."Middle Name";
                    "Last Name" := StudentMaster."Last Name";
                    "Student Name" := StudentMaster."Student Name";
                    "Enrollment No." := StudentMaster."Enrollment No.";
                    Semester := StudentMaster.Semester;
                    "Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                end;
            end;
        }
        field(3; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            Editable = false;
        }
        field(4; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            Editable = false;
        }
        field(5; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            Editable = false;
        }
        field(6; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(7; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(8; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(9; "Admitted Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Admitted Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(10; Semester; Code[20])
        {
            // DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
        }
        field(11; "Exam Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Exam Code';
            TableRelation = IF ("Global Dimension 1 Code" = filter('9000')) "Subject Master-CS".Code where("Level Description" = filter("External Examination" | "Internal Exam Component"))
            Else
            If ("Global Dimension 1 Code" = filter('9100')) "Subject Master-CS".Code where("Level Description" = filter("Main Subject"));
        }
        field(12; "Exam Description"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Exam Description';
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(15; "Type of Input"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type of Input';
            OptionMembers = " ","Best","Model","Original";
            OptionCaption = ' ,Best,Model,Original';
        }
        field(16; "Input Sequence"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Input Sequence';
            MinValue = 0;
        }
        field(17; "Percentage Obtained"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Obtained';
        }
        field(18; "Grade"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade';
        }
        field(19; "Earned Points"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Earned Points';
        }
        field(20; "Available Points"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Available Points';
        }
        field(21; "Earned Points Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Earned Points Percentage';
        }
        field(22; "% Range"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = '% Range';
        }
        field(23; "Grade Result"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade Result';
        }
        field(24; "Recommendation"; Text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Recommendation';
        }
        field(25; "Indentation"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Indentation';
        }
        field(26; "Quality Point"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quality Point';
        }
        field(27; "Credit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit';
        }
        field(28; "Credit Earned"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Earned';
        }
        field(29; "Exam Classification"; Code[20])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
            TableRelation = "Examination Type Master-CS";
        }
        field(30; Term; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(31; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(32; "Grade Book No."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(33; "Created By"; Code[50])
        {
            Caption = 'Created By"';
            DataClassification = CustomerContent;
        }
        field(34; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(35; "Updated By"; Code[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(36; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(37; Status; Option)
        {
            OptionMembers = Open,"Pending For Approval",Approved,Rejected,Published;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudSubGB: Record "Student Subject GradeBook";
            begin
                StudSubGB.Reset();
                StudSubGB.SetRange("Student No.", "Student No.");
                StudSubGB.SetRange("Grade Book No.", "Grade Book No.");
                if StudSubGB.FindFirst() then begin
                    StudSubGB.validate(Status, Status);
                    StudSubGB.Modify(true);
                end;

            end;
        }
        field(41; "Exam Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(101; Level; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(103; "CBSE Version"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(104; Communications; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(105; "Published Document No."; code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(106; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }

    }

    keys

    {
        key(PK; "Entry No.", "Student No.")
        {
            Clustered = true;
        }
        key(Key2; "Student No.", Semester, "Academic Year", "Exam Code")
        {
            Clustered = false;
        }
        key(Key3; "Student No.", Semester, "Academic Year", "Type of Input", "Input Sequence", "Exam Code")
        {
            Clustered = false;
        }
        key(Key4; "Document No.", "Entry No.", "Student No.")
        {
            Clustered = false;
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
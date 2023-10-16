table 50076 "Academics Setup-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    12-02-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Academics Setup-CS';

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "No. series";
        }
        field(3; "Attendance No."; Code[20])
        {
            Caption = 'Attendance No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(4; "Common Subject Type"; Code[20])
        {
            Caption = 'Common Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Internal Marks No."; Code[20])
        {
            Caption = 'Internal Marks No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(6; "Attendance Code"; Code[20])
        {
            Caption = 'Attendance Code';
            DataClassification = CustomerContent;
        }
        field(7; "Attendance Percent No."; Code[20])
        {
            Caption = 'Attendance Percent No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(9; "External Marks No."; Code[20])
        {
            Caption = 'External Marks No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(10; "Hall Ticket Entry No."; Code[20])
        {
            Caption = 'Hall Ticket Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(11; "Attendance Fine Entry No."; Code[20])
        {
            Caption = 'Attendance Fine Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(12; "Internal Exam Group No."; Code[20])
        {
            Caption = 'Internal Exam Group No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(13; "Withdrawal No."; Code[20])
        {
            Caption = 'Withdrawal No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(14; "Course Syllabus Header No."; Code[20])
        {
            Caption = 'Course Syllabus Header No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(15; "Faculty Scheme Planning No."; Code[20])
        {
            Caption = 'Faculty Scheme Planning No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(16; "TC No."; Code[20])
        {
            Caption = 'TC No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(17; "Exam Slot No."; Code[20])
        {
            Caption = 'Exam Slot No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(18; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(19; "Examiner No."; Code[20])
        {
            Caption = 'Examiner No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(20; "Revaluation No."; Code[20])
        {
            Caption = 'Revaluation No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(21; "Revaluation Mark"; Code[20])
        {
            Caption = 'Revaluation Mark';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(22; "Revaluation Fees"; Decimal)
        {
            Caption = 'Revaluation Fees';
            DataClassification = CustomerContent;
        }
        field(23; "Student CBCS No."; Code[20])
        {
            Caption = 'Student CBCS No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(24; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
        }
        field(25; "CBCS Subject Type"; Code[20])
        {
            Caption = 'CBCS Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(26; "Student Leave Application No."; Code[20])
        {
            Caption = 'Student Leave Application No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(27; "Student Promotion No."; Code[20])
        {
            Caption = 'Student Promotion No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(28; "Alumni Entry No."; Code[20])
        {
            Caption = 'Alumni Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(29; "Alumni No."; Code[20])
        {
            Caption = 'Alumni No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(30; "Alumni Meeting No."; Code[20])
        {
            Caption = 'Alumni Meeting No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(31; "Placement Register No."; Code[20])
        {
            Caption = 'Placement Register No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(32; "Placement Company No."; Code[20])
        {
            Caption = 'Placement Company No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(33; "Placement History No."; Code[20])
        {
            Caption = 'Placement History No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(34; "Placement Schedule No."; Code[20])
        {
            Caption = 'Placement Schedule No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(35; "Grade Book Nos."; Code[20])
        {
            Caption = 'Grade Book Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(36; "Decision Document Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50000; "Image File Directory"; Text[250])
        {
            Caption = 'Image File Directory';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
        }
        field(50001; "Re-Appear External Nos."; Code[20])
        {
            Caption = 'Re-Apear External Nos.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "No. Series";
        }
        field(50002; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50003; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50004; "Intership No."; Code[20])
        {
            Caption = 'Intership No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "No. Series";
        }
        field(50005; "Convert to Year Semester No."; Code[10])
        {
            Caption = 'Convert to Year Semester No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "Semester Master-CS";
        }
        field(50006; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "No. Series";
        }
        field(50009; "BSIC No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BSIC No.';
            TableRelation = "No. Series";
        }
        field(50010; "MSPE No."; Code[20])
        {
            DataClassification = Customercontent;
            Caption = 'MSPE No.';
            TableRelation = "No. Series";
        }
        field(50011; "E-mail ID (Graduate Affairs)"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'E-mail ID (Graduate Affairs)';

        }
        field(50012; "Phone No. (Graduate Affairs)"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone No. (Graduate Affairs)';
        }
        field(50013; "Publish Score Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
        }
        field(33048922; "Re-appear No."; Code[20])
        {
            Caption = 'Re-appear No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "No. Series";
        }
        field(33048923; "Award List No."; Code[20])
        {
            Caption = 'Award List No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "No. Series";
        }
        field(33048924; "Decode Document No"; Code[20])
        {
            Caption = 'Decode Document No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "No. Series";
        }
        field(33048925; "Copy Code"; Code[20])
        {
            Caption = 'Copy Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-02-2019';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
        key(Key2; "Common Subject Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::12-02-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::12-02-2019: End
    end;
}


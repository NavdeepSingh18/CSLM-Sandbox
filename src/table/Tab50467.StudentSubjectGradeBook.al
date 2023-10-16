table 50467 "Student Subject GradeBook"
{


    Caption = 'Student Subject GradeBook';
    DataCaptionFields = "Student No.", "Student Name";
    // DrillDownPageId = StudentSubjectGradeBookList;
    // LookupPageId = StudentSubjectGradeBookList;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Master-CS";
            DataClassification = CustomerContent;


        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;


        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = "Subject Master-CS";
            DataClassification = CustomerContent;


        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(7; Course; Code[20])
        {
            Caption = 'Course';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;


        }
        field(8; Section; Code[10])
        {
            Caption = 'Student Group';
            // TableRelation = "Section Master-CS";
            TableRelation = "Group Master-CS".Code;

            DataClassification = CustomerContent;


        }
        field(9; "Internal Mark"; Decimal)
        {
            Caption = 'Internal Mark';
            DataClassification = CustomerContent;


        }
        field(10; "External Mark"; Decimal)
        {
            Caption = 'External Mark';
            DataClassification = CustomerContent;


        }
        field(11; Total; Decimal)
        {
            Caption = 'Total';
            Editable = true;
        }
        field(12; Result; Option)
        {
            Caption = 'Result';
            Editable = true;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
            DataClassification = CustomerContent;
        }

        field(14; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = "Grade Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            DataClassification = CustomerContent;

        }

        field(21; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;

        }

        field(28; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }

        field(50030; "Credit Earned"; Decimal)
        {
            Caption = 'Credit Earned';
            DataClassification = CustomerContent;

        }

        field(50089; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER, ';
            OptionMembers = FALL,SPRING,SUMMER," ";
        }

        field(60003; "Grade Book No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60004; "Communications"; text[2048])
        {
            DataClassification = CustomerContent;
        }
        Field(60005; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(60006; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(60007; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(60008; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(60009; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(60010; Updated; Boolean)
        {
            DataClassification = CustomerContent;
        }
        // field(99993; "SAP"; Integer)
        // {
        //     DataClassification = CustomerContent;
        // }
        // field(99994; "Previous SAP"; Integer)
        // {
        //     DataClassification = CustomerContent;
        // }
        Field(99988; GPA; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(99989; "New Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(99990; "Old Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(99991; Year; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(99992; "Academic Suggestion"; Option)
        {
            OptionMembers = " ",Progress,Dismiss;
            DataClassification = CustomerContent;
        }
        field(99993; "Student Sem Document No."; Code[20])
        {
            DataClassification = CustomerContent;

        }

        field(99994; Failed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(99995; Status; Option)
        {
            OptionMembers = Open,"Pending For Approval",Approved,Rejected,Published;
            DataClassification = CustomerContent;
        }
        field(99996; "Recommendation"; Text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Recommendation';
        }
        field(99997; "% Range"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = '% Range';
        }
        field(99998; "Grade To Be Published"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Grade Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
        }
        field(99999; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(33048933; "Start Date"; date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }

        field(33048935; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(33048938; "Numeric Grade"; Decimal)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Numeric Grade';
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        Key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code", Section, "Start Date")
        {

        }

    }

    trigger OnInsert()
    begin
        "Created By" := UserId();
        "Created On" := Today();
        Inserted := true;
    end;
}
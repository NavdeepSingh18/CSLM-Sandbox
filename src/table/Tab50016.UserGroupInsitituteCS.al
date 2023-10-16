table 50016 "User Group Insititute-CS"
{
    // version V.001-CS
    //CSPL-00307 T1-T1518

    Caption = 'Attendance Absence Entry';
    DataPerCompany = false;


    fields
    {
        field(1; "User Group"; Code[20])
        {
            Caption = 'User Group';
            DataClassification = CustomerContent;
            //TableRelation = "Student Intership Line-CS";
        }
        field(2; "Company Access"; Text[30])
        {
            Caption = 'Company Access';
            // ObsoleteState = Pending;
            // Description = 'Marked for Removal';
            DataClassification = CustomerContent;
            TableRelation = Company;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            ObsoleteState = Pending;
            Description = 'Marked for Removal';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            ObsoleteState = Pending;
            Description = 'Marked for Removal';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;

        }
        Field(50004; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50005; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(50006; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(50007; Semester; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50008; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPING,SUMMER;
        }
        field(50009; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(50010; Facilitator; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(50011; Comments; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(50012; Activity; Option)
        {
            OptionCaption = ',Small Group Activity,Anatomy Lab,ICM session,Exam,Other';
            OptionMembers = " ","Small Group Activity","Anatomy Lab","ICM session",Exam,Other;
        }
        field(50013; "Other Activity Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(50014; "Date of Absence"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50015; "Type of Absence"; Option)
        {
            OptionCaption = ' ,Absent,Tardy';
            OptionMembers = " ",Absent,Tardy;
        }
        field(50016; "Total Minutes Tardy"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50017; "Email Receipt Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50018; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50019; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50020; "Start DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Completion DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Email; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "No. Absences Tardy"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Administrative Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; Notes; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "User Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "User Group", "Company Access")
        {
        }
        key(Key2; "Entry No.", "Entry Date")
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        AbsenceAttandanceEntry: Record "User Group Insititute-CS";
    Begin
        // "Created By" := UserId(); // Synce from Portal API
        "Created On" := Today();

        AbsenceAttandanceEntry.Reset();
        AbsenceAttandanceEntry.SetCurrentKey("Entry No.");
        IF AbsenceAttandanceEntry.FindLast() then
            "Entry No." := AbsenceAttandanceEntry."Entry No." + 1
        Else
            "Entry No." := 1;

        "User Group" := Format("Entry No.");

    End;
}


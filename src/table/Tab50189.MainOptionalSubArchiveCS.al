table 50189 "Main&Optional Sub Archive-CS"
{
    // version V.001-CS

    Caption = 'Main&Optional Sub Archive-CS';
    DrillDownPageID = 50410;
    LookupPageID = 50410;

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
        field(6; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            TableRelation = "Subject Type-CS";
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
            Caption = 'Section';
            TableRelation = "Section Master-CS";
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
            DataClassification = CustomerContent;
        }
        field(12; Result; Option)
        {
            Caption = 'Result';
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
            DataClassification = CustomerContent;
        }
        field(13; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            OptionCaption = ' ,Present,Absent,On Duty,Leave';
            OptionMembers = " ",Present,Absent,"On Duty",Leave;
            DataClassification = CustomerContent;
        }
        field(14; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = "Grade Master-CS";
            DataClassification = CustomerContent;
        }
        field(15; "Line No"; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(20; Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = CustomerContent;
        }
        field(21; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(22; Credit; Decimal)
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(23; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
            DataClassification = CustomerContent;
        }
        field(24; "Attendance Percentage"; Decimal)
        {
            Caption = 'Attendance Percentage';
            DataClassification = CustomerContent;
        }
        field(25; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(26; "Attendance % as on Date"; Date)
        {
            Caption = 'Attendance % as on Date';
            DataClassification = CustomerContent;
        }
        field(27; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            DataClassification = CustomerContent;
        }
        field(28; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
        }
        field(29; Specilization; Code[20])
        {
            Caption = 'Specilization';
            DataClassification = CustomerContent;
        }
        field(30; Detained; Boolean)
        {
            Caption = 'Detained';
            DataClassification = CustomerContent;
        }
        field(31; "Attendance Detail"; Text[80])
        {
            Caption = 'Attendance Detail';
            DataClassification = CustomerContent;
        }
        field(32; Absent; Boolean)
        {
            Caption = 'Absent';
            DataClassification = CustomerContent;
        }
        field(33; "Main Exam Result Updated"; Boolean)
        {
            Caption = 'Main Exam Result Updated';
            DataClassification = CustomerContent;
        }
        field(50; "Grace Marks"; Integer)
        {
            Caption = 'Grace Marks';
            DataClassification = CustomerContent;
        }
        field(70; "Re-Appear External Marks"; Decimal)
        {
            Editable = false;
            Caption = 'Re-Appear External Marks';
            DataClassification = CustomerContent;
        }
        field(71; "Re-Appear Total"; Decimal)
        {
            Editable = false;
            Caption = 'Re-Appear Total';
            DataClassification = CustomerContent;
        }
        field(72; "Re-Appear Result"; Integer)
        {
            Editable = false;
            Caption = 'Re-Appear Result';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 10052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 10052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 10052019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
        }
        field(50015; Year; Code[10])
        {
            Description = 'CS Field Added 10052019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(50016; "Enrollment No"; Code[20])
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(50030; "Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50031; "Credit Grade Points Earned"; Integer)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Credit Grade Points Earned';
            DataClassification = CustomerContent;
        }
        field(50032; "Currency Code"; Code[10])
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(50033; "Selected Subject"; Code[10])
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Selected Subject';
            DataClassification = CustomerContent;
        }
        field(50034; "Selected Sub. Name"; Text[50])
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Selected Suject Name';
            DataClassification = CustomerContent;
        }
        field(50035; "Subject Class"; Code[20])
        {
            Description = 'CS Field Added 10052019';
            TableRelation = "Subject Classification-CS";
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
        }
        field(50036; "Re- Register"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Re-Register';
            DataClassification = CustomerContent;
        }
        field(50037; "Grace Criteria"; Option)
        {
            Description = 'CS Field Added 10052019';
            OptionCaption = ' ,External,Total';
            OptionMembers = " ",External,Total;
            Caption = 'Grace Criteria';
            DataClassification = CustomerContent;
        }
        field(50038; Publish; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Publish';
            DataClassification = CustomerContent;
        }
        field(50039; "Re-Registration"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Re-Registration';
            DataClassification = CustomerContent;
        }
        field(50040; "Re-Apply"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Re-Apply';
            DataClassification = CustomerContent;
        }
        field(50041; "Assignment Marks"; Decimal)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Assignment Marks';
            DataClassification = CustomerContent;
        }
        field(50042; "Total Internal"; Decimal)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Total Internal';
            DataClassification = CustomerContent;
        }
        field(50043; Updated; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50044; "Elective Group Code"; Code[20])
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Elective Group Code';
            DataClassification = CustomerContent;
        }
        field(50046; "Program/Open Elective Temp"; Option)
        {
            Description = 'CS Field Added 10052019';
            OptionCaption = ' ,Open Elective Common Subject,Program Elective Common Subject';
            OptionMembers = " ","Open Elective Common Subject","Program Elective Common Subject";
            Caption = 'Program/Open Elective Temp';
            DataClassification = CustomerContent;
        }
        field(50047; "Exam Fee"; Decimal)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Exam Fee';
            DataClassification = CustomerContent;
        }
        field(50048; "Registration Date"; Date)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Registration Date';
            DataClassification = CustomerContent;
        }
        field(50049; "Re-Registration Date"; Date)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Re-Registration Date';
            DataClassification = CustomerContent;
        }
        field(50050; "Grade Change Type"; Option)
        {
            Description = 'CS Field Added 10052019';
            OptionCaption = ' ,Revaluation,MakeUp';
            OptionMembers = " ",Revaluation,MakeUp;
            Caption = 'Grade Change Type';
            DataClassification = CustomerContent;
        }
        field(50051; Graduation; Code[10])
        {
            Description = 'CS Field Added 10052019';
            TableRelation = "Graduation Master-CS".Code;
            Caption = 'Graduation';
            DataClassification = CustomerContent;
        }
        field(50052; "Internal Marks Updated"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Internal Marks Updated';
            DataClassification = CustomerContent;
        }
        field(50053; "External Marks Updated"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'External Marks Updated';
            DataClassification = CustomerContent;
        }
        field(50054; "Actual Semester"; Code[10])
        {
            Description = 'CS Field Added 10052019';
            Editable = true;
            Caption = 'Actual Semester';
            DataClassification = CustomerContent;
        }
        field(50055; "Actual Year"; Code[10])
        {
            Description = 'CS Field Added 10052019';
            Editable = true;
            Caption = 'Actual Year';
            DataClassification = CustomerContent;
        }
        field(50056; "Actual Academic Year"; Code[10])
        {
            Description = 'CS Field Added 10052019';
            Editable = true;
            Caption = 'Actual Academic Year';
            DataClassification = CustomerContent;
        }
        field(50057; "Actual Subject Code"; Code[20])
        {
            Description = 'CS Field Added 10052019';
            Editable = true;
            Caption = 'Actual Subject Code';
            DataClassification = CustomerContent;
        }
        field(50058; "Actual Subject Description"; Text[100])
        {
            Description = 'CS Field Added 10052019';
            Editable = true;
            Caption = 'Actual Subject Description';
            DataClassification = CustomerContent;
        }
        field(50059; "Make Up Examination"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Make Up Exmination';
            DataClassification = CustomerContent;
        }
        field(50060; Revaluation1; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Revaluation';
            DataClassification = CustomerContent;
        }
        field(50061; Revaluation2; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Revaluation 2';
            DataClassification = CustomerContent;
        }
        field(50062; "Special Exam"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Special Exam';
            DataClassification = CustomerContent;
        }
        field(50063; "Re-Registration Exam Only"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Re-Registration Exam Only';
            DataClassification = CustomerContent;
        }
        field(50064; "Total Class Held"; Integer)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Total Class Held';
            DataClassification = CustomerContent;
        }
        field(50065; "Total Attendance Taken"; Integer)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Total Attendance Taken';
            DataClassification = CustomerContent;
        }
        field(50066; "Present Count"; Integer)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Present Count';
            DataClassification = CustomerContent;
        }
        field(50067; "Absent Count"; Integer)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Absent Count';
            DataClassification = CustomerContent;
        }
        field(50068; "Subject Drop"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Subject Drop';
            DataClassification = CustomerContent;
        }
        field(50069; "Subject Pass Date"; Date)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Subject Pass Date';
            DataClassification = CustomerContent;
        }
        field(50070; "Previous Detained Status"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Previous Detained Status';
            DataClassification = CustomerContent;
        }
        field(50071; "Student Status"; Option)
        {
            CalcFormula = Lookup ("Student Master-CS"."Student Status" WHERE("No." = FIELD("Student No.")));
            Description = 'CS Field Added 10052019';
            FieldClass = FlowField;
            OptionCaption = ' ,Student,Inactive,Provisional Student,Expired,Withdrwal -In- Process,Withdrawl/Discontinue,Student Transfer-In-Process,Course Completion,Casual,Reject & Rejoin,NFT,NFT-Extended,Academic Break,Terminated';
            OptionMembers = " ",Student,Inactive,"Provisional Student",Expired,"Withdrwal -In- Process","Withdrawl/Discontinue","Student Transfer-In-Process","Course Completion",Casual,"Reject & Rejoin",NFT,"NFT-Extended","Academic Break",Terminated;
            Caption = 'Student Status';
        }
        field(50072; "Subject Not Required"; Boolean)
        {
            CalcFormula = Lookup ("Subject Master-CS"."Subject Not Required" WHERE(Code = FIELD("Subject Code")));
            Description = 'CS Field Added 10052019';
            FieldClass = FlowField;
            Caption = 'Subject Not Required';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 10052019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 10052019';
            DataClassification = CustomerContent;
        }
        field(33048923; "Update Att. Per"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Update Attendance Percent';
            DataClassification = CustomerContent;
        }
        field(33048924; "Update Marks"; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Update Marks';
            DataClassification = CustomerContent;
        }
        field(33048925; Dropped; Boolean)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Dropped';
            DataClassification = CustomerContent;
        }
        field(33048926; "Internal Maximum"; Decimal)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Internal Maximum';
            DataClassification = CustomerContent;
        }
        field(33048927; "External Maximum"; Decimal)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
        }
        field(33048928; Group; Code[20])
        {
            Description = 'CS Field Added 10052019';
            TableRelation = "Group Master-CS".Code;
            Caption = 'Group';
            DataClassification = CustomerContent;
        }
        field(33048929; Batch; Code[20])
        {
            Description = 'CS Field Added 10052019';
            TableRelation = "Batch-CS".Code;
            Caption = 'Batch';
            DataClassification = CustomerContent;
        }
        field(33048930; "Roll No."; Code[10])
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
        }
        field(33048931; "Applicable Attendance per"; Decimal)
        {
            Description = 'CS Field Added 10052019';
            Caption = 'Applicable Attendance Percent';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code")
        {
            SumIndexFields = Points;
        }
        key(Key2; Course, Semester, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; Course, Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key4; "Student No.", Semester, Section)
        {
        }
        key(Key5; "Student No.", Semester, Result)
        {
        }
        key(Key6; Course, Semester, Section, "Academic Year")
        {
        }
        key(Key7; "Student No.", Course, Semester, Section, "Subject Type", "Subject Code")
        {
        }
        key(Key8; "Student No.", Result)
        {
            SumIndexFields = Credit;
        }
        key(Key9; Course, "Academic Year", Semester, "Student No.")
        {
        }
        key(Key10; "Subject Class")
        {
        }
    }

    fieldgroups
    {
    }
}
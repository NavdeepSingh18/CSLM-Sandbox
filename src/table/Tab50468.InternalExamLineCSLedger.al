table 50468 "Internal Exam Line Ledger"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                     Remarks
    // 1         CSPL-00092    07-05-2019    OnInsert                                    Assign Value in Fields
    // 2         CSPL-00092    07-05-2019    OnModify                                    Assign Value in Fields
    // 3         CSPL-00092    07-05-2019    Marks Obtained - OnValidate                 Validate Data
    // 4         CSPL-00092    07-05-2019    Student No. - OnValidate                    Validate Data and Assign Value in Fields
    // 5         CSPL-00092    07-05-2019    Obtained Internal Marks - OnValidate        Validate Data
    // 6         CSPL-00092    07-05-2019    SetFilterOnCourseSubjectExGroupLine         Function for Filter Data
    // 7         CSPL-00092    07-05-2019    ValidateShortcutDimCode Validate            Function For Dimensions

    Caption = 'Internal Exam Line Ledger';
    //DrillDownPageID = 33049433;
    //LookupPageID = 33049433;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(6; "Marks Obtained"; Decimal)
        {
            Caption = 'Marks Obtained';
            DataClassification = CustomerContent;


        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";


        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(11; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Present,Absent,Withdrawal';
            OptionMembers = " ",Present,Absent,Withdrawal;

        }
        field(12; "Exam Method Code"; Code[20])
        {
            Caption = 'Exam Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Internal Exam Line-CS"."Document No.";
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(14; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Grade Master-CS";
        }
        field(15; Rank; Integer)
        {
            Caption = 'Rank';
            DataClassification = CustomerContent;
        }
        field(19; ASN; Decimal)
        {
            Caption = 'ASN';
            DataClassification = CustomerContent;
        }
        field(20; ACT; Decimal)
        {
            Caption = 'ACT';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));


        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));


        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50015; "Exam Group"; Code[20])
        {
            Caption = 'Exam Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Sessional Exam Group-CS".Group;
        }
        field(50016; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Year Master-CS";
        }
        field(50031; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(50032; "Re-Sessional"; Decimal)
        {
            Caption = 'Re-Sessional';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50033; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            OptionCaption = 'Open,Released,Published';
            OptionMembers = Open,Released,Published;


        }
        field(50034; "Attendance %"; Decimal)
        {
            Caption = 'Attendance %';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50035; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
            OptionCaption = ' ,Regular,Re-Sessional';
            OptionMembers = " ",Regular,"Re-Sessional";
        }
        field(50036; "Roll No."; Code[10])
        {
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50037; "Assignment Marks"; Decimal)
        {
            Caption = 'Assignment Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50038; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50039; "Exam Method"; Code[10])
        {
            Caption = 'Exam Method';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50040; "Maximum Internal  Marks"; Decimal)
        {
            Caption = 'Maximum Internal  Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50041; "Obtained Internal Marks"; Decimal)
        {
            Caption = 'Obtained Internal Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';


        }
        field(50042; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50043; "Obtained Weightage"; Decimal)
        {
            Caption = 'Obtained Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = true;
        }
        field(50044; "Marks Published"; Boolean)
        {
            Caption = 'Marks Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50045; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50046; "MAL Practice Level"; Code[20])
        {
            Caption = 'MAL Practice Level';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Discipline MalPractice-CS";
        }
        field(50047; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50048; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Group Master-CS".Code;
        }
        field(50049; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Subject Classification-CS".Code;
        }
        field(50050; Reason; Text[100])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50051; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50052; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50053; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
        }
        field(50054; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
        }
        field(50055; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
            TableRelation = "Examination Time Slot-CS";
        }
        field(50056; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50057; "Exam Classification"; Code[20])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            TableRelation = "Examination Type Master-CS".Code WHERE("Exam Type" = FIELD("Document Type"));
        }
        field(50058; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No';
            DataClassification = CustomerContent;
        }
        field(50059; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
        }
        field(50060; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50061; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50062; "Leave Types"; Code[20])
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,ELOA,SLOA,CLOA';
            // OptionMembers = " ","ELOA","SLOA","CLOA";
            Editable = false;
        }
        field(50063; "Original Student No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50071; "Select To Perform"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50072; "Published Document No."; code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(103; "CBSE Version"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(201; "Entry From Portal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(33048922; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048923; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048924; "Modified By"; Text[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048925; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048928; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048929; "Ledger Created By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(33048930; "Ledger Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::07-05-2019: Start


        "Ledger Created By" := FORMAT(UserId());
        "Ledger Created On" := Today();

    end;


    trigger OnDelete()
    begin

        Error('Deletion is not allowed.');
    end;


}


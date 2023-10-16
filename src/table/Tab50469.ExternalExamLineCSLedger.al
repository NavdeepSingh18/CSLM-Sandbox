table 50469 "External Exam Line Ledger"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                 Remarks
    // 1         CSPL-00092    07-05-2019    OnModify                                Assign Value in Updated Field.
    // 2         CSPL-00092    07-05-2019    External Mark - OnValidate            Find Total Marks And Validate Data
    // 3         CSPL-00092    07-05-2019    Student No. - OnValidate              Assign Value in fields
    // 4         CSPL-00092    07-05-2019    Cr Points - OnValidate              Validate Data
    // 5         CSPL-00092    07-05-2019    MAL Practice Level - OnValidate        Find Grade

    Caption = 'External Exam Line Ledger';

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
        field(6; "External Mark"; Decimal)
        {
            Caption = 'External Mark';
            DataClassification = CustomerContent;
            MinValue = 0;


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
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(11; "Internal Mark"; Decimal)
        {
            Caption = 'Internal Mark';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(12; Total; Decimal)
        {
            Caption = 'Total';
            DataClassification = CustomerContent;
        }
        field(13; Result; Option)
        {
            Caption = 'Result';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail,On Hold';
            OptionMembers = " ",Pass,Fail,"On Hold";
        }
        field(14; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            Editable = true;
            OptionCaption = ' ,Present,Absent,Withdrawal';
            OptionMembers = " ",Present,Absent,Withdrawal;


        }
        field(15; "Std. Grade"; Code[20])
        {
            Caption = 'Std. Grade';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Academic year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(17; "Apply Type"; Option)
        {
            Caption = 'Apply Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Regular,Arrears';
            OptionMembers = " ",Regular,Arrears;
        }
        field(18; "Reason Code"; Code[20])
        {
            TableRelation = "Reason Code".Code where(Type = filter('Attendence'));
            Caption = 'Reason Code';
            DataClassification = CustomerContent;

        }
        field(19; "Reason Description"; Text[2048])
        {
            DataClassification = CustomerContent;
        }

        field(21; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
        }
        field(22; "Percentage Obtained"; Decimal)
        {
            Caption = 'Percentage Obtained';
            DataClassification = CustomerContent;
        }
        field(23; "Total Maximum"; Decimal)
        {
            Caption = 'Total Maximum';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(24; "Old Result-I"; Option)
        {
            Caption = 'Old Result-I';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(25; "Old Result-II"; Option)
        {
            Caption = 'Old Result-II';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(26; "Old Result-III"; Option)
        {
            Caption = 'Old Result-III';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(27; "Cr Points"; Decimal)
        {


        }
        field(28; "Grace Marks"; Decimal)
        {
            Caption = 'Grace Marks';
            DataClassification = CustomerContent;
        }
        field(29; "External Marks Old Result-I"; Decimal)
        {
            Caption = 'Ext. mark Old Result-I';
            DataClassification = CustomerContent;
        }
        field(30; "External Marks Old Result-II"; Decimal)
        {
            Caption = 'Ext. mark Old Result-II';
            DataClassification = CustomerContent;
        }
        field(31; "External Marks Old Result-III"; Decimal)
        {
            Caption = 'Ext. mark Old Result-I';
            DataClassification = CustomerContent;
        }
        field(32; Detained; Boolean)
        {
            Caption = 'Detained';
            DataClassification = CustomerContent;
        }
        field(33; Absent; Boolean)
        {
            Caption = 'Absent';
            DataClassification = CustomerContent;
        }
        field(34; UFM; Boolean)
        {
            Caption = 'UFM';
            DataClassification = CustomerContent;
        }
        field(35; Dropped; Boolean)
        {
            Caption = 'Dropped';
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
            Caption = 'Type of Course';
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
        field(50015; Year; Code[20])
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
        field(50032; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            OptionCaption = 'Open,Released,Published';
            OptionMembers = Open,Released,Published;
        }
        field(50033; "Attendance %"; Decimal)
        {
            Caption = 'Attendance';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50034; "Grade Generated"; Boolean)
        {
            Caption = 'Grade Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50035; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            OptionCaption = ' ,Regular,Re-Registration,Makeup';
            OptionMembers = " ",Regular,"Re-Registration",Makeup;
        }
        field(50036; "Grade Points"; Integer)
        {
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50037; "Credit Grade Points(CGP)"; Integer)
        {
            Caption = 'Credit Grade Points';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50038; "Rev. Grade"; Code[20])
        {
            Caption = 'Rev. Grade';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50039; "Roll No."; Code[10])
        {
            Caption = 'Roll No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50040; "MAL Practice Level"; Code[20])
        {
            Caption = 'MAL Practive Level';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Discipline MalPractice-CS"."No.";


        }
        field(50041; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50042; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = Employee."No.";
        }
        field(50043; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50044; "Exam Classification"; Code[20])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Examination Type Master-CS".Code WHERE("Exam Type" = FIELD("Document Type"));
        }
        field(50045; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50046; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Subject Classification-CS".Code;
        }
        field(50047; "Marks Published"; Boolean)
        {
            Caption = 'Marks Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50048; "Exam Group"; Code[10])
        {
            Caption = 'Exam Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Sessional Exam Group-CS";
        }
        field(50049; "External Maximum"; Decimal)
        {
            Caption = 'External Maximum';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            Editable = false;
        }
        field(50050; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Batch-CS".Code;
        }

        field(50051; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(50052; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50053; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
            TableRelation = "Group Master-CS".Code;
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
        field(50056; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50057; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50058; "Leave Types"; Code[20])
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,ELOA,SLOA,CLOA';
            // OptionMembers = " ","ELOA","SLOA","CLOA";
            Editable = false;
        }
        field(50059; "Obtained Weightage"; Decimal)
        {
            Caption = 'Obtained Weightage';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(50060; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(50061; "Original Student No."; Code[20])
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
        field(33048924; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048925; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By name';
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
        key(Key3; Course, Semester, Section, "Academic year", "Subject Type", "Subject Code")
        {
        }
        key(Key4; Course, Semester, "Academic year", "Subject Code")
        {
        }
        key(Key5; "Student No.", Semester)
        {
        }
        key(Key6; Total)
        {
        }

    }

    fieldgroups
    {
    }


    trigger OnInsert()
    begin
        "Ledger Created By" := UserId();
        "Ledger Created On" := Today();
    end;

    trigger OnDelete()
    begin

        Error('Deletion is not allowed');
    end;


}


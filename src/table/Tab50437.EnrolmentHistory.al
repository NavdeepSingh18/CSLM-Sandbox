table 50437 "Enrollment History"
{
    DataClassification = ToBeClassified;
    Caption = 'Enrollment History';

    fields
    {
        field(1; "Enrollment History No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Enrollment History No.';


        }

        field(3; "School No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'School No.';
            //TableRelation = School."School ID"; //Arvind Siani


        }
        field(4; "Student No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student No.';
            //TableRelation ="Student Master-CS"."No.";//Arvind Siani


        }
        field(5; "College of Graduation"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'College of Graduation';


        }
        field(6; "Currently Enrolled"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Currently Enrolled';


        }
        field(7; "Degree Candidate"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Degree Candidate';


        }
        field(8; "Degree Earned"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Degree Earned';
            // OptionMembers = " ",Certificate,Diploma,Associate,BA,BS,MS,MA,AA,AS,PhD,"1st (First-class Honours)","2.1 (Second-class Honours upper division)","2.2 (Second-class Honours,, lower division)","3rd (Third-class Honours) Pass (Ordinary)",Other;
            //OptionMembers = " ",Certificate,Diploma,Associate,BA,BS,MS,MA,AA,AS,PhD,"1st (First-class Honours)","2.1 (Second-class Honours, upper division)","2.2 (Second-class Honours, lower division)","3rd (Third-class Honours)","Pass (Ordinary)",Other;


        }
        field(9; "Degree Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Degree Type';
            OptionMembers = " ","High School","Under Graduate",Graduate,"Transfer School",Undergraduate;


        }

        field(10; "Did you Graduate"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Did you Graduate';



        }

        field(11; "Earned Credits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Earned Credits';
        }
        field(12; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(13; "GPA Credits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'GPA Credits';
        }
        field(14; "Graduation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Graduation Date';
        }
        field(15; "Graduation Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Graduation Year';

        }
        field(16; "Official GPA Scale"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Official GPA Scale';
            OptionMembers = " ","4.0 Scale","5.0 Scale","6.0 Scale","7.0 Scale","8.0 Scale","9.0 Scale","10.0 Scale","100 Scale";
        }

        field(17; "Official GPA"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Official GPA';
        }
        field(18; "Official Recalculated GPA"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Official Recalculated GPA';
        }
        field(19; "Official Transcripts Received"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Official Transcripts Received';
        }
        field(20; "Pre-Req Credits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Pre-Req Credits';
        }
        field(21; "Pre-Req Quality Points"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Pre-Req Quality Points';
        }

        field(22; "Prev. Attended Medical School"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = ' Previously Attended Medical School?';
        }
        field(23; "Primary College"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary College';
        }
        field(24; "Quality Points"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quality Points';
        }
        field(25; "Reason for Transfer"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason for Transfer';
        }
        field(26; "School Level"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'School Level';
            OptionMembers = " ","High School",GED,College;
        }
        field(27; "Self-Reported Graduation Year"; Text[4])
        {
            DataClassification = ToBeClassified;
            Caption = 'Self-Reported Graduation Year';

        }
        field(28; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';

        }
        field(29; "Tests Taken"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tests Taken';

        }
        field(30; "Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Transfer';

        }
        field(31; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = " ",Public,Private,Parochial,"Home School",College;

        }
        field(32; "18 Digit EnrollmentId"; Text[18])
        {
            DataClassification = ToBeClassified;
            Caption = '18 Digit EnrollmentId';
        }
        field(33; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }

        field(34; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(35; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

        Field(36; "School Name"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        //
    }


    keys
    {
        key("PK"; "Enrollment History No.")

        {

        }
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;




}
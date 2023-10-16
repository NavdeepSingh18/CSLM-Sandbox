table 50386 "Deferred/Declined Buffer"
{
    Caption = 'Student Status Deferred/Declined Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "18 Digits Student ID"; Text[18])
        {
            Caption = '18 Digits Student ID';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(3; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,Re-Admitted,Re-Entry,SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD';
            OptionMembers = " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(6; Term; Option)
        {
            Caption = 'Term';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(7; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(8; "New Term"; Option)
        {
            Caption = 'New Term';
            OptionMembers = FALL,SPRING," ";
        }
        field(9; "New Academic Year"; Code[10])
        {
            Caption = 'New Academic Year';
            DataClassification = CustomerContent;
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(12; "Entry Date"; date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Entry Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
        field(15; Type; Option)
        {
            OptionCaption = ' ,Course Change,Def-Dec,Readmits';
            OptionMembers = " ","Course Change","Def-Dec","Readmits";
        }
        field(16; "New Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(17; Semester; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(18; Success; Boolean)
        {
            DataClassification = CustomerContent;

        }

    }
    keys
    {
        // key(PK; "Student No.", "Academic Year", Term, "Line No.")
        key(PK; "Student No.", "Line No.")
        {
            Clustered = true;
        }
    }

}

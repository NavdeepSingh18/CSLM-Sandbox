table 50113 "Qualifying Detail Stud-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/06/2019       OnInsert()                                 Data Modification Flag

    Caption = 'Qualifying Detail Stud-CS';
    DrillDownPageID = "Qualifying Detail Stud List-CS";
    LookupPageID = "Qualifying Detail Stud List-CS";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Qualifying Exam"; Text[50])
        {
            Caption = 'Qualifying Exam';
            DataClassification = CustomerContent;
        }
        field(3; "Qualifying Year of Passing"; Integer)
        {
            Caption = 'Qualifying Year Of Passing';
            DataClassification = CustomerContent;
        }
        field(4; "Exam Marks/Grade/Points"; Text[30])
        {
            Caption = 'Exam Marks/Grade/Points';
            DataClassification = CustomerContent;
        }
        field(5; "College last Studied"; Text[100])
        {
            Caption = 'College Last Studied';
            DataClassification = CustomerContent;
        }
        field(6; "University/Board"; Text[100])
        {
            Caption = 'University/Board';
            DataClassification = CustomerContent;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(9; "Optional Subject Name"; Text[50])
        {
            Caption = 'Optional Subject Name';
            DataClassification = CustomerContent;
        }
        field(10; Updated; Boolean)
        {

            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        Field(11; "SLcM ID"; Code[20])
        {
            Caption = 'SLcM ID';
            DataClassification = CustomerContent;
        }
        field(12; "18 Digit Test ID"; Text[18])
        {
            Caption = '18 Digit Test ID';
            DataClassification = CustomerContent;
        }
        field(13; Test; Text[50])
        {
            Caption = 'Test';
            DataClassification = CustomerContent;
        }
        field(14; "18 Digit Student ID"; Text[18])
        {
            Caption = '18 Digit Student ID';
            DataClassification = CustomerContent;
        }
        field(15; "MCAT Test Score"; Decimal)
        {
            Caption = 'MCAT Test Score';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "MCAT Test Score" <> 0 then
                    IF "New MCAT 2015 Test Score" <> 0 then
                        Error('MCAT Score must be updated either %1 or %2.', "MCAT Test Score", "New MCAT 2015 Test Score");

                IF "MCAT Psychological" = 0 then
                    IF "MCAT Test Score" <> 0 then
                        "MCAT Psychological" := "MCAT Test Score";
            end;
        }
        field(16; "NBME Comp Test Score"; Decimal)
        {
            Caption = 'NBME Comp Test Score';
            DataClassification = CustomerContent;
        }
        field(17; "New MCAT 2015 Test Score"; Decimal)
        {
            Caption = 'New MCAT 2015 Test Score';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                IF "New MCAT 2015 Test Score" <> 0 then
                    IF "MCAT Test Score" <> 0 then
                        Error('MCAT Score must be updated either %1 or %2.', "MCAT Test Score", "New MCAT 2015 Test Score");


                IF "MCAT Psychological" = 0 then
                    IF "New MCAT 2015 Test Score" <> 0 then
                        "MCAT Psychological" := "New MCAT 2015 Test Score";
            end;
        }
        field(18; "Overall Score"; Decimal)
        {
            Caption = 'Overall Score';
            DataClassification = CustomerContent;
        }
        field(19; "MCAT Biological Science"; Decimal)
        {
            Caption = 'MCAT Biological Science';
            DataClassification = CustomerContent;
        }
        field(20; "MCAT Physical Science"; Decimal)
        {
            Caption = 'MCAT Physical Science';
            DataClassification = CustomerContent;
        }
        field(21; "MCAT Total Score"; Decimal)
        {
            Caption = 'MCAT Total Score';
            DataClassification = CustomerContent;
        }
        field(22; "MCAT Verbal Reasoning"; Decimal)
        {
            Caption = 'MCAT Verbal Reasoning';
            DataClassification = CustomerContent;
        }
        field(23; "MCAT Writing"; Decimal)
        {
            Caption = 'MCAT Writing';
            DataClassification = CustomerContent;
            Description = 'Not in Used';         //07-09-2021
            ObsoleteState = Pending;
        }
        field(24; "Test Date"; Date)
        {
            Caption = 'Test Date';
            DataClassification = CustomerContent;
        }
        field(25; "USMLE Step 1 Score"; Decimal)
        {
            Caption = 'USMLE Step 1 Score';
            DataClassification = CustomerContent;
        }
        field(26; "USMLE Step 2 CK Score"; Decimal)
        {
            Caption = 'USMLE Step 2 CK Score';
            DataClassification = CustomerContent;
        }
        field(27; "USMLE Step 2 CS Score"; Text[2])
        {
            Caption = 'USMLE Step 2 CS Score';
            DataClassification = CustomerContent;
        }
        field(28; "USMLE Test Score"; Decimal)
        {
            Caption = 'USMLE Test Score';
            DataClassification = CustomerContent;
        }
        field(29; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
            ;
        }
        field(30; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(31; "MCAT Psychological"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; "MCAT Writing 1"; Text[20])
        {
            Caption = 'MCAT Writing';
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(Key1; "Student No.", "SLcM ID")
        {
        }

    }

    trigger OnModify()
    begin
        //Data Modification Flag::CSPL-00114::19062019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Data Modification Flag::CSPL-00114::19062019: End
    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;
}


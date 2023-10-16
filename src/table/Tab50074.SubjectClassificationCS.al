table 50074 "Subject Classification-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    18-03-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Subject Classification-CS';
    DrillDownPageID = "Subject Detail Clsific-CS";
    LookupPageID = "Subject Detail Clsific-CS";
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Show Internal Marks"; Boolean)
        {
            Caption = 'Show Internal Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(50004; "Show External Marks"; Boolean)
        {
            Caption = 'Show External Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(50005; "Last Semester Evaluation"; Boolean)
        {
            Caption = 'Last Semester Evaluation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(50006; "Attendance Not Applicable"; Boolean)
        {
            Caption = 'Attendance Not Applicable';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(50007; "External Pass Not Mandatory"; Boolean)
        {
            Caption = 'External Pass Not Mandatory';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(50008; "Int. Exam Not Applicable"; Boolean)
        {
            Caption = 'Int. Exam Not Applicable';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(50009; "Grading Rule"; Option)
        {
            Caption = 'Grading Rule';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
            OptionCaption = ' ,Statistical, Absolute, Fixed';
            OptionMembers = " ",Statistical," Absolute"," Fixed";
        }
        field(50010; "Revaluation Applicable"; Boolean)
        {
            Caption = 'Revaluation Applicable';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(50020; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50021; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        Field(50022; "Occurence Not Applicale"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Occurrence Not Applicable';
        }
        Field(50023; "Colour Coding"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(33048924; "Room Allocation"; Boolean)
        {
            Caption = 'Room Allocation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(33048925; Invigilator; Boolean)
        {
            Caption = 'Invigilator';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }
        field(33048926; "Hall Ticket"; Boolean)
        {
            Caption = 'Hall Ticket';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-03-2019';
        }

    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::18-03-2019: Start
        "User ID" := FORMAT(UserId());
        Inserted := true;
        //Code added for User Id Assign in User Id Field::CSPL-00092::18-03-2019: End
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;

    end;
}


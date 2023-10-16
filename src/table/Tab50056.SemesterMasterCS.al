table 50056 "Semester Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    12-03-2019    OnInsert                Assign Use Id, Academic Year & Corse Code
    // 2         CSPL-00092    12-03-2019    OnModify                Assign True in Updated field

    Caption = 'Semester Master-CS';
    DrillDownPageID = "Semester Detail-CS";
    LookupPageID = "Semester Detail-CS";
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[10])
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
        field(3; "Order"; Integer)
        {
            Caption = 'Order';
            DataClassification = CustomerContent;
        }
        field(4; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-03-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-03-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Semester Code"; Integer)
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-03-2019';
        }
        field(50004; "Department Name"; Text[30])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-03-2019';
        }
        field(50005; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-03-2019';
        }
        field(50006; Graduation; Code[10])
        {
            Caption = 'Graduation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-03-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50007; "Immigration Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Immigration Applicable';
        }
        field(50008; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50009; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50010; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50011; Credit; Decimal)
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(50012; "Type Of Repeat"; Option)
        {
            Caption = 'Type Of Repeat';
            OptionMembers = " ","Semester","Year";
            DataClassification = CustomerContent;
        }
        field(50013; "Show Cue in Exam RoleCenter "; Boolean)
        {
            Caption = 'Show Cue in Exam RoleCenter';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2021';
        }
        field(50014; "Start Date Not Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50015; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        Field(50016; "OLR Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50017; "Total Weightage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'External Total Weightage';
            MinValue = 0;
        }
        field(50018; "Internal Total Weightage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Internal Total Weightage';
            MinValue = 0;
        }
        field(50019; "Temporary Grade"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Grade Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-03-2019';
        }
        field(33048921; "Portal ID"; Code[30])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-03-2019';
        }
        field(33048922; Block; Boolean)
        {
            Caption = 'Block';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2021';
        }
    }

    keys
    {
        key(Key1; "Code", Graduation)
        {
        }
        key(Key2; "Order")
        {
        }
        key(Key3; Sequence)
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Use Id::CSPL-00092::13-03-2019: Start
        "User ID" := FORMAT(UserId());
        Inserted := True;
        //Code added for Assign Use Id::CSPL-00092::13-03-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign True in Updated field::CSPL-00092::13-03-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign True in Updated field::CSPL-00092::13-03-2019: End
    end;
}


table 50497 "Residency Plac. Result Lines"
{
    Caption = 'Residency Placement Result Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Application No"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Residency Placement Result";
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            Var
                StudentMasterCS: Record "Student Master-CS";
            begin
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name";
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(5; "Subject_Speciality Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(6; "ERAS Applied"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(7; "ERAS Interview Offered"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(8; "ERAS Interview Attended"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(9; "ERAS Program Ranked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(10; "CaRMS Applied"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(11; "CaRMS Interview Offered"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(12; "CaRMS Interview Attended"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(13; "CaRMS Program Ranked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(18; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(19; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }

    keys
    {
        key(PK; "Application No", "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();

        Inserted := True;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();

        if xRec.Updated = Updated then
            Updated := true;
    end;



}
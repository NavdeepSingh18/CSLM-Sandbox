table 50461 "Student Ethnicity"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Ethnicity Code"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Ethnicity;
            trigger OnValidate()
            var
                RecEthnincity: Record "Ethnicity";
            begin
                RecEthnincity.Get("Ethnicity Code");
                "Ethnicity Name" := RecEthnincity."Ethnicity Description";
            end;
        }
        field(2; "Ethnicity Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Student No."; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            var
                RecStudentMaster: Record "Student Master-CS";
            begin
                RecStudentMaster.Get("Student No.");
                "Student Name" := RecStudentMaster."Student Name";
            end;

        }
        field(4; "Student Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(9; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(10; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }

    keys
    {
        key(PK; "Ethnicity Code", "Student No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        if xRec.Updated = Updated then
            Updated := true;
    end;


}
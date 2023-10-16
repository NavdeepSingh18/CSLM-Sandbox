table 50493 "MSP Subject Choice"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Application No"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Medical Scholar Program";
        }
        field(2; "Subject"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
            trigger OnValidate()
            var
                SubjectMasterCS: Record "Subject Master-CS";
            begin
                SubjectMasterCS.Reset();
                SubjectMasterCS.SetRange(Code, Subject);
                IF SubjectMasterCS.FindFirst() then
                    "Subject Semester" := SubjectMasterCS.Semester;
            end;
        }
        field(3; "Subject Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; Position; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",TA,Tutor,Both;

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
        key(PK; "Application No")
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

        IF xRec.Updated = Updated then
            Updated := true;

    end;



}
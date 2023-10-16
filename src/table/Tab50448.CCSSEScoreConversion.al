table 50448 "CCSSE Score Conversion"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code where(Code = field("Group Filter"));

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                "Course Description" := '';

                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.FindLast() then
                    "Course Description" := SubjectMaster.Description;
            end;
        }
        field(3; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code;
        }
        field(6; Score; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0;
        }
        field(7; "Score Value"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0;
            Caption = 'Value';
        }
        field(20; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(60000; "Group Filter"; Code[1000])
        {
            Editable = false;
            FieldClass = FlowFilter;
        }
    }


    keys
    {
        key(PK; "Effective Date", "Course Code", Score)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := Today;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified On" := Today;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}
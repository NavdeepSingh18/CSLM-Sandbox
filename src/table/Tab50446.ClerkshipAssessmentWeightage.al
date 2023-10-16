table 50446 "Clerkship Assessment Weightage"
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
                "Course Credit" := 0;
                Clear("No. of Weeks");

                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.FindLast() then begin
                    "Course Description" := SubjectMaster.Description;
                    "Course Credit" := SubjectMaster.Credit;
                    "No. of Weeks" := SubjectMaster.Duration;
                end;
            end;
        }
        field(3; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code;
        }
        field(4; "Course Credit"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0;
        }
        field(5; "No. of Weeks"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Clerkship Assessment Weightage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "CCSSE Weightage"; Decimal)
        {
            DataClassification = CustomerContent;
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
        key(PK; "Effective Date", "Course Code")
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
table 50447 "Clerkship Grading"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Hospital Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",General,FIU;
        }
        field(3; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";

            trigger OnValidate()
            begin
                if "Clerkship Type" <> "Clerkship Type"::Core then begin
                    "Course Code" := Format("Clerkship Type");
                    "Course Description" := Format("Clerkship Type");
                end;
            end;
        }
        field(4; "Course Code"; Code[20])
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
        field(5; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code;
        }
        field(6; "Grade Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Grade Master-CS".Code;

            trigger OnValidate()
            var
                Grade: Record "Grade Master-CS";
            begin
                "Grade Description" := '';
                Grade.Reset();
                Grade.SetRange(Code, "Grade Code");
                if Grade.FindFirst() then
                    "Grade Description" := Grade.Description;
            end;
        }
        field(7; "Grade Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(8; "Quality Point"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0;
        }
        field(9; "Cut-off Start"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Cut-off End"; Decimal)
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
        key(PK; "Hospital Category", "Clerkship Type", "Effective Date", "Course Code", "Grade Code")
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
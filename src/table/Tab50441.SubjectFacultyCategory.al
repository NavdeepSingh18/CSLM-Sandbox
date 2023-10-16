table 50441 "Subject Faculty Category"
{
    DataClassification = CustomerContent;
    Caption = 'Subject Wise Faculty Category';

    fields
    {
        field(1; "Subject Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject Code" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject Code") then
                        "Subject Description" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject Code" = '' then
                        "Subject Description" := '';
            end;
        }
        field(2; "Subject Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(3; "Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Code';
            TableRelation = "Faculty Category"."Category Code";
            trigger OnValidate()
            begin
                if FacultyCategory_lRec.Get("Category Code") then
                    "Category Description" := FacultyCategory_lRec."Category Description"
                else
                    "Category Description" := '';

            end;
        }
        field(4; "Category Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Description';
            Editable = false;
        }

        field(5; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(12; Inserted; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Inserted';
        }

    }

    keys
    {
        key(PK; "Subject Code", "Category Code")
        {
            Clustered = true;
        }

    }

    var
        SubjectMaster_lRec: Record "Subject Master-CS";
        FacultyCategory_lRec: Record "Faculty Category";

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
        Updated := true;
    end;


}
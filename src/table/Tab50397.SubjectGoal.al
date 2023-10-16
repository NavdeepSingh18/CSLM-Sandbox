table 50397 "Subject Goal"
{
    DataClassification = CustomerContent;
    Caption = 'Subject Wise Goal';

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
                    SubjectMaster_lRec.SetRange(Code, "Subject Code");
                    if SubjectMaster_lRec.FindFirst() then
                        "Subject Description" := SubjectMaster_lRec."Description";
                end else
                        "Subject Description" := '';
            end;
        }
        field(2; "Subject Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(3; "Goal Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Goal Code';
            TableRelation = Goal."Goal Code";
            trigger OnValidate()
            begin
                if Goal_lRec.Get("Goal Code") then
                    "Goal Description" := Goal_lRec."Goal Description"
                else
                    "Goal Description" := '';

            end;
        }
        field(4; "Goal Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Goal Description';
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

    }

    keys
    {
        key(PK; "Subject Code", "Goal Code")
        {
            Clustered = true;
        }

    }

    var
        SubjectMaster_lRec: Record "Subject Master-CS";
        Goal_lRec: Record Goal;

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        Updated := true;
    end;


}
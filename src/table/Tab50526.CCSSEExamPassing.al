table 50526 "CCSSE Exam Passing"
{
    Caption = 'CCSSE Exam Passing';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                SubjectMasterRec.Reset();
                SubjectMasterRec.SetRange(Code, "Subject Code");
                if SubjectMasterRec.FindFirst() then
                    "Subject Description" := SubjectMasterRec.Description
                else
                    "Subject Description" := '';
            end;

        }
        field(2; "Subject Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        // field(3; "Effective Date"; Date)
        // {
        //     DataClassification = CustomerContent;
        // }
        field(4; Score; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; Marks; Decimal)
        {
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK; "Subject Code", Score)
        {
        }
    }

    var
        SubjectMasterRec: Record "Subject Master-CS";
}
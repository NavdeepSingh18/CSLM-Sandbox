table 50473 "SAFI Proj. Course Element"
{
    DataClassification = CustomerContent;
    Caption = 'SAFI Projected Course Element';

    fields
    {
        field(1; ProgramID; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(2; Code; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(3; Semester; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(4; Completed_1; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(5; Completed_2; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(6; Completed_3; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(7; Completed_4; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(8; Completed_5; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(9; Enrolled; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(10; Projected_1; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(11; Projected_2; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(12; Projected_3; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(13; Projected_4; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(14; Projected_Desc1; Text[100])
        {
            DataClassification = CustomerContent;

        }
        Field(15; Projected_Desc2; Text[100])
        {
            DataClassification = CustomerContent;

        }
        Field(16; Projected_Desc3; Text[100])
        {
            DataClassification = CustomerContent;

        }
        Field(17; Projected_Desc4; Text[100])
        {
            DataClassification = CustomerContent;

        }
        Field(18; Status; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(19; Credits_1; Decimal)
        {
            DataClassification = CustomerContent;

        }
        Field(20; Credits_2; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(21; Credits_3; Decimal)
        {
            DataClassification = CustomerContent;

        }
        Field(22; Credits_4; Decimal)
        {
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(Key1; ProgramID, Code, Semester)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
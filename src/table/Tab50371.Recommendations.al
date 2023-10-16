table 50371 "Recommendations"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(4; Semester; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
        }
        field(5; "Min Percentage"; Decimal)//Using this field as a entry no.
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(6; "Max Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Max Percentage';
        }
        field(7; "Range Percentage"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Range Percentage';
        }
        field(20; "Recommendation"; text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Recommendation';
        }
        field(23; "Communications"; text[2048])
        {
            DataClassification = CustomerContent;
        }
        Field(24; "Academic SAP"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(25; Repeating; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(26; CBSE; Integer)//Not in Use
        {
            DataClassification = CustomerContent;
        }

        field(27; "Min. Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Min. Percentage';
        }
        field(28; "CBSE Max"; Decimal)
        {
            Caption = 'CBSE Max';
            DataClassification = CustomerContent;
        }
        field(29; "CBSE Min"; Decimal)
        {
            Caption = 'CBSE Min';
            DataClassification = CustomerContent;
        }



    }

    keys
    {
        key(PK; "Global Dimension 1 Code", Semester, "Min Percentage")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        RecRecomd: Record Recommendations;
    begin
        RecRecomd.Reset();
        RecRecomd.SetCurrentKey("Min Percentage");
        RecRecomd.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecRecomd.SetRange(Semester, Rec.Semester);
        IF RecRecomd.FindLast() then
            "Min Percentage" := RecRecomd."Min Percentage" + 1
        else
            "Min Percentage" := 1;
    end;
}
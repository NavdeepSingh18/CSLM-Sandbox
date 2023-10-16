table 50222 "Fee Discount Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    09-05-2019    OnInsert                            Assign Value in Fields.
    // 2         CSPL-00092    09-05-2019    Fee Code - OnValidate               Assign Value in G/L Account  Field

    Caption = 'Fee Discount Line-CS';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Fee Code"; Code[10])
        {
            caption = 'Fee Code';
            DataClassification = CustomerContent;
            TableRelation = "Fee Component Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in G/L Account  Field::CSPL-00092::09-05-2019: Start
                FeeComponentMasterCS.RESET();
                FeeComponentMasterCS.SETRANGE(FeeComponentMasterCS.Code, "Fee Code");
                IF FeeComponentMasterCS.FindFirst() THEN
                    "G/L Account" := FeeComponentMasterCS."G/L Account";

                //Code added for Assign Value in G/L Account  Field::CSPL-00092::09-05-2019: End
            end;
        }
        field(5; "Fee Type Code"; Code[20])
        {
            caption = 'Fee Type Code';
            DataClassification = CustomerContent;
            TableRelation = "Fee Type Master-CS";
        }
        field(6; "Discount%"; Decimal)
        {
            caption = 'Discount%';
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[30])
        {
            caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "G/L Account"; Code[20])
        {
            caption = 'G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(9; "Academic Year"; Code[20])
        {
            caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(10; Course; Code[20])
        {
            caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(11; Year; Code[10])
        {
            caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(12; Remark; Text[100])
        {
            Caption = 'Remark';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {


            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Parents Income"; Decimal)
        {
            caption = 'Parents Income';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50004; "Income Discount"; Decimal)
        {
            caption = 'Income Discount';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Fields::CSPL-00092::09-05-2019: Start
        IF FeeDiscountHeadCS.GET("Document No.") THEN BEGIN
            "Academic Year" := FeeDiscountHeadCS."Academic Year";
            Course := FeeDiscountHeadCS.Course;
        END;
        //Code added for Assign Value in Fields::CSPL-00092::09-05-2019: End
    end;

    var
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        FeeDiscountHeadCS: Record "Fee Discount Head-CS";
}


table 50180 "Stud. Rank Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   16/01/2019       OnInsert()                                 Get Student rank Line Values from student rank Header

    Caption = 'Stud. Rank Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Scholarship Code"; Code[10])
        {
            Caption = 'Scholarship Code';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";
        }
        field(4; Description; Text[50])
        {
            Caption = ' Description';
            DataClassification = CustomerContent;
        }
        field(5; Course; Code[10])
        {
            caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(6; "Admitted Year"; Code[10])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Min Rank"; Integer)
        {
            Caption = 'Min Rank';
            DataClassification = CustomerContent;
        }
        field(8; "Max Rank"; Integer)
        {
            Caption = 'Max Rank';
            DataClassification = CustomerContent;
        }
        field(9; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {

            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16012019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {

            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16012019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
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
        //Get Student rank Line Values from student rank Header::CSPL-00114::16012019: Start
        IF StudRankHeaderCS.GET("Document No.") THEN BEGIN
            "Scholarship Code" := StudRankHeaderCS."Scholarship Code";
            "Admitted Year" := StudRankHeaderCS."Admitted Year";
            Course := StudRankHeaderCS.Course;
        END;
        IF CategoryMasterCS.GET(StudRankHeaderCS."Scholarship Code") THEN
            Description := CategoryMasterCS.Description;
        //Get Student rank Line Values from student rank Header::CSPL-00114::16012019: End
    end;

    var
        StudRankHeaderCS: Record "Stud. Rank Header-CS";
        CategoryMasterCS: Record "Category Master-CS";
}


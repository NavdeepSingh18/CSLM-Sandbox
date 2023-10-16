table 50230 "Specialization-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   05/01/2019       OnInsert()             Getting "Academic Year" values from EducationVertical Codeunit

    Caption = 'Specialization-CS';
    //DrillDownPageID = 33049489;
    //LookupPageID = 33049489;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(4; "Total no of Elective"; Decimal)
        {
            Caption = 'Total no of Elective';
        }
        field(5; "Min Electives-Specialization"; Decimal)
        {
            Caption = 'Min Electives-Specialization';
            DataClassification = CustomerContent;
        }
        field(6; "Max Electives-Others"; Decimal)
        {
            Caption = 'Max Electives-Others';
            DataClassification = CustomerContent;
        }
        field(7; "Effective From"; Code[10])
        {
            Caption = 'Effective From';
            DataClassification = CustomerContent;
            TableRelation = "Mother Tongue-CS";
        }
        field(8; "Effective Till"; Code[10])
        {
            Caption = 'Effective Till';
            DataClassification = CustomerContent;
            TableRelation = "Mother Tongue-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05012019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05012019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            SumIndexFields = "Total no of Elective", "Min Electives-Specialization", "Max Electives-Others";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added Getting "Academic Year" values from EducationVertical Codeunit::CSPL-00114::05012019: Start
        "Academic Year" := VerticalEducationCS.CreateAdmission_Yr();
        //Code added Getting "Academic Year" values from EducationVertical Codeunits::CSPL-00114::05012019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}


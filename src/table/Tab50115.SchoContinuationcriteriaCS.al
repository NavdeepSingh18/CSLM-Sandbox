table 50115 "Scho Continuation criteria-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   07/01/2019       Scholarship Code - OnValidate()            Get Category Description value
    // 02    CSPL-00114   07/01/2019       Applicable Percentage - OnValidate()       Code added for validation
    // 03    CSPL-00114   07/01/2019       Applicable CGPA - OnValidate()             Code added for validation

    Caption = 'Scho Continuation criteria-CS';
    DrillDownPageID = "Duration Generation-CS";
    LookupPageID = "Duration Generation-CS";

    fields
    {
        field(1; "Scholarship Code"; Code[10])
        {
            Caption = 'Scholarship Code';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";

            trigger OnValidate()
            begin

                //Code added for Get Category Description value ::CSPL-00114::07012019: Start
                CategoryMasterCS.Reset();
                CategoryMasterCS.SETCURRENTKEY(Code);
                CategoryMasterCS.SETRANGE(Code, "Scholarship Code");
                IF CategoryMasterCS.FINDFIRST() THEN
                    Description := CategoryMasterCS.Description;
                //Code added for Get Category Description value ::CSPL-00114::07012019: End
            end;
        }
        field(2; "Applicable Code"; Option)
        {
            Caption = 'Applicable Code';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Percentage,Clear,CGPA,Branch Transfer';
            OptionMembers = "None",Percentage,Clear,CGPA,"Branch Transfer";
        }
        field(3; "Admitted Year"; Code[10])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Applicable Percentage"; Decimal)
        {
            Caption = 'Applicable Percentage';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for validation ::CSPL-00114::07012019: Start
                IF "Applicable Percentage" > 100 THEN
                    ERROR('Applicable Percentage Cannot Be Greater Than 100%');
                //Code added for validation ::CSPL-00114::07012019: End
            end;
        }
        field(6; "Applicable CGPA"; Decimal)
        {
            Caption = 'Applicable CGPA';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for validation ::CSPL-00114::07012019: Start
                IF "Applicable CGPA" > "Total CGPA" THEN;
                ERROR('Applicable CGPA Cannot Be Greater Than Total CGPA');
                //Code added for validation ::CSPL-00114::07012019: End
            end;
        }
        field(7; "Total CGPA"; Decimal)
        {
            Caption = 'Total CGPA';
            DataClassification = CustomerContent;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Scholarship Code", "Applicable Code", "Admitted Year")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CategoryMasterCS: Record "Category Master-CS";
}


table 50221 "Fee Discount Head-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    09-05-2019    OnInsert                            No. Series and Assign Value in Field.
    // 2         CSPL-00092    09-05-2019    No. - OnValidate                    No. Series
    // 3         CSPL-00092    09-05-2019    AssistEdit                          Select no series
    caption = 'Fee Discount Head';


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = '';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No. Series::CSPL-00092::09-05-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    FeeSetupCS.GET();
                    NoSeriesManagement.TestManual(FeeSetupCS."Discount No.");
                    "No. Series" := '';
                END;
                //Code added for No. Series::CSPL-00092::09-05-2019: End
            end;
        }
        field(2; "Fee Clasification Code"; Code[20])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Fee Classification Master-CS";
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(4; "Fee Discount Code"; Code[10])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Discount Category-CS";
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(6; "Discount%"; Decimal)
        {
            Caption = '';
            DataClassification = CustomerContent;
        }
        field(7; Course; Code[20])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(8; Category; Code[10])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS".Code WHERE("Fee Classification" = FIELD("Fee Clasification Code"));
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
        field(33009100; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(33009101; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(33009102; Description; Text[50])
        {
            Caption = '';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description)
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for No. Series and Assign Value in Field::CSPL-00092::09-05-2019: Start
        FeeSetupCS.GET();
        IF "No. Series" = '' THEN BEGIN
            FeeSetupCS.TESTFIELD(FeeSetupCS."Discount No.");
            NoSeriesManagement.InitSeries(FeeSetupCS."Discount No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "User ID" := FORMAT(UserId());
        //Code added for No. Series and Assign Value in Fields::CSPL-00092::09-05-2019: End
    end;

    var

        FeeSetupCS: Record "Fee Setup-CS";
        FeeDiscountHeadCS: Record "Fee Discount Head-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

    procedure AssistEdit(OldFee: Record "Fee Discount Head-CS"): Boolean
    begin
        //Code added for Select no series::CSPL-00092::09-05-2019: Start
        WITH FeeDiscountHeadCS DO BEGIN
            FeeDiscountHeadCS := Rec;
            FeeSetupCS.GET();
            FeeSetupCS.TESTFIELD(FeeSetupCS."Discount No.");
            IF NoSeriesManagement.SelectSeries(FeeSetupCS."Discount No.", OldFee."No. Series", "No. Series") THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := FeeDiscountHeadCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Select no series::CSPL-00092::09-05-2019: End
    end;
}


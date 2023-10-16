table 50178 "Scholarship Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/07/2019       OnInsert()                                Get Scholarship line Values from Scholarship Header

    Caption = 'Scholarship Line-CS';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = "Scholarship Header-CS";
        }
        field(2; "Line No."; Integer)
        {
            caption = 'Line No.';
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
            caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Admitted Year"; Code[10])
        {
            caption = 'Admitted Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; "Course Code"; Code[10])
        {
            caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(7; "Min Parent Income"; Decimal)
        {
            Caption = 'Min Parent Income';
            DataClassification = CustomerContent;
        }
        field(8; "Max Parent Income"; Decimal)
        {
            Caption = 'Max Parent Income';
            DataClassification = CustomerContent;
        }
        field(9; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DataClassification = CustomerContent;
        }
        field(10; "Amount To Pay"; Decimal)
        {
            caption = 'Amount To Pay';
            DataClassification = CustomerContent;
        }
        field(11; "Percentage To Pay"; Decimal)
        {
            Caption = 'Percentage To Pay';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 19072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 19072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Semester; Code[20])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(50004; "Fee Component"; Code[20])
        {
            Caption = 'Fee Component';
            DataClassification = CustomerContent;
            TableRelation = "Fee Component Master-CS";

        }
        field(50005; "Alternative Percentage to Pay"; Decimal)
        {
            Caption = 'Alternative Percentage to Pay';
            DataClassification = CustomerContent;
        }
        field(50008; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50009; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50010; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50011; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = CustomerContent;
            TableRelation = "Source Scholarship-CS".Code;

            trigger OnValidate()
            begin
                IF SourceScholarshipCS.GET("Source Code") THEN
                    "Source Name" := SourceScholarshipCS.Description
                else
                    "Source Name" := '';


            end;
        }
        field(50012; "Source Name"; Text[50])
        {
            Caption = 'Source Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50013; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50014; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
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
        //Code added for Get Scholarship line Values from Scholarship Header::CSPL-00114::19072019: Start
        IF ScholarshipHeaderCS.GET("Document No.") THEN BEGIN
            "Scholarship Code" := ScholarshipHeaderCS."Scholarship Code";
            "Admitted Year" := ScholarshipHeaderCS."Admitted Year";
            "Course Code" := ScholarshipHeaderCS."Course Code";
            Validate("Source Code", ScholarshipHeaderCS."Source Code");
        END;
        IF CategoryMasterCS.GET(ScholarshipHeaderCS."Scholarship Code") THEN
            Description := CategoryMasterCS.Description;

        Inserted := True;
        //Code added for Get Scholarship line Values from Scholarship Header::CSPL-00114::19072019: End
    end;

    Trigger OnModify()
    Begin
        if xRec.Updated = Updated then
            Updated := true;
    End;

    var
        ScholarshipHeaderCS: Record "Scholarship Header-CS";
        CategoryMasterCS: Record "Category Master-CS";
        SourceScholarshipCS: Record "Source Scholarship-CS";
}


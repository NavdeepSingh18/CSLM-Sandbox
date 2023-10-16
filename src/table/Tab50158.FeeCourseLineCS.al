table 50158 "Fee Course Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    09-05-2019    OnModify                            Assign Value in Updated Field.
    // 2         CSPL-00092    09-05-2019    Fee Code - OnValidate               Assign Value in Fields

    Caption = 'Fee Course Line-CS';

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
        field(3; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
            TableRelation = "Fee Component Master-CS" WHERE(Code = FIELD("Fee Code"));

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::09-05-2019: Start
                IF "Fee Code" <> '' THEN
                    IF FeeComponentMasterCS.GET("Fee Code") THEN BEGIN
                        Description := FeeComponentMasterCS.Description;
                        "Fee Group" := FeeComponentMasterCS."Fee Group";
                        "Fee Group Type" := FeeComponentMasterCS."Fee Group Type";
                        "Global Dimension 2 Code" := FeeComponentMasterCS."Global Dimension 2 Code";
                    END;

                FeeCourseHeadCS.Reset();
                IF FeeCourseHeadCS.GET("Document No.") THEN BEGIN
                    "Course Name" := FeeCourseHeadCS."Course Name";
                    "Admitted Year" := FeeCourseHeadCS."Admitted Year";
                    "G/L Acount for fine" := FeeCourseHeadCS."G/L Account for fine";
                    Semester := FeeCourseHeadCS.Semester;
                    Year := FeeCourseHeadCS.Year;
                    "Academic Year" := FeeCourseHeadCS."Academic Year";
                    Program := FeeCourseHeadCS.Program;
                    "Other Fees" := FeeCourseHeadCS."Other Fees";
                    "Course Code" := FeeCourseHeadCS."Course Code";
                    "Fee Classification Code" := FeeCourseHeadCS."Fee Classification Code";
                    VALIDATE("Global Dimension 1 Code", FeeCourseHeadCS."Global Dimension 1 Code");
                END;
                //Code added for Assign Value in Fields::CSPL-00092::09-05-2019: End
            end;
        }
        field(4; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Group Student-CS";
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Fees Type"; Code[20])
        {
            Caption = 'Fees Type';
            DataClassification = CustomerContent;
            TableRelation = "Fee Type Master-CS";
        }
        field(8; Installment; Boolean)
        {
            Caption = 'Installment';
            DataClassification = CustomerContent;
        }
        field(9; "No Of Installment"; Integer)
        {
            Caption = 'No Of Installment';
            DataClassification = CustomerContent;
        }
        field(10; "Installment Charges"; Decimal)
        {
            Caption = 'Installment Charges';
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
        field(50003; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50004; "Last Date"; Date)
        {
            caption = 'Last Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50005; "Late Fee Amount For Compound %"; Decimal)
        {
            caption = 'Late Fee Amount For Compound %';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50006; "Late Fee Amount %"; Decimal)
        {
            caption = 'Late Fee Amount %';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';

            trigger OnValidate()
            begin
                TESTFIELD("Fixed Amount", 0);
            end;
        }
        field(50007; "G/L Acount for fine"; Code[20])
        {
            caption = 'G/L Acount for fine';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "G/L Account";
        }
        field(50008; "Fine Applicable"; Boolean)
        {
            caption = 'Fine Applicable';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50009; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Course Master-CS";
        }
        field(50010; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Course Sem. Master-CS"."Semester Code";
        }
        field(50011; Year; Code[20])
        {
            Caption = 'Year';
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Year Master-CS".Code;
        }
        field(50012; "Academic Year"; Code[20])
        {
            caption = 'Academic Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Academic Year Master-CS";
        }
        field(50013; "Fixed Amount"; Decimal)
        {
            Caption = 'Fixed Amount';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';

            trigger OnValidate()
            begin
                TESTFIELD("Late Fee Amount %", 0);
            end;
        }
        field(50014; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Academic Year Master-CS";
        }
        field(50015; "Year Part"; Option)
        {
            caption = 'Year Part';
            Description = 'CS Field Added 11-05-2019';
            OptionCaption = ' ,1st,2nd';
            OptionMembers = " ","1st","2nd";
        }
        field(50016; "Course Name"; Text[150])
        {
            Caption = 'Course Name';
            CalcFormula = Lookup("Category Master-CS".Description WHERE(Code = FIELD("Course Code")));
            Description = 'CS Field Added 11-05-2019';
            FieldClass = FlowField;
        }
        field(50017; "Currency Code"; Code[10])
        {
            CalcFormula = Lookup("Fee Course Head-CS"."Currency Code" WHERE("No." = FIELD("Document No.")));
            Caption = 'Currency Code';
            Description = 'CS Field Added 11-05-2019';
            FieldClass = FlowField;
            TableRelation = Currency;
        }
        field(50018; "Fee Classification Code"; Code[20])
        {
            Caption = 'Fee Classification Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Fee Classification Master-CS";
        }
        field(50019; "Fee Group Type"; Option)
        {
            caption = 'Fee Group Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            Editable = true;
            OptionCaption = ' ,Admission,Exam';
            OptionMembers = " ",Admission,Exam;
        }
        field(50020; Updated; Boolean)
        {
            caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50021; "Program"; Code[20])
        {
            caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Graduation Master-CS";
        }
        field(50022; "Other Fees"; Boolean)
        {
            Caption = 'Other Fees';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50023; "Fee Group"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Group';
            OptionCaption = ' ,Non-Institutional,Institutional';
            OptionMembers = " ","Non-Institutional",Institutional;
            Editable = false;
        }
        field(50024; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
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
        Inserted := true;
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::09-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::09-05-2019: End
    end;

    var
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        FeeCourseHeadCS: Record "Fee Course Head-CS";

}


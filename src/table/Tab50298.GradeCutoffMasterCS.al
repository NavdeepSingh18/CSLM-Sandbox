table 50298 "Grade Cutoff Master-CS"
{
    // version V.001-CS

    Caption = 'Grade Cutoff Master';
    DrillDownPageID = "Allocation Grade List-CS";
    LookupPageID = "Allocation Grade List-CS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD("Course Code"));
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50000; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(50003; "Standard Calculation Formula"; Decimal)
        {
            Caption = 'Standard Calculation Formula';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            Editable = false;
        }
        field(50004; "Revised Value"; Decimal)
        {
            Caption = 'Revised Value';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50005; "Count Std"; Decimal)
        {
            Caption = 'Count Std';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50006; "Count Revised"; Decimal)
        {
            Caption = 'Count Revised';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50007; "Count Std Per"; Decimal)
        {
            Caption = 'Count Std Per';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50008; "Count Revised Per"; Decimal)
        {
            Caption = 'Count Revised Per';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50015; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = "Year Master-CS";
        }
        field(50031; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            Editable = false;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(50032; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = "Grade Master-CS";
        }
        field(50033; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50034; "Standard Value"; Decimal)
        {
            Caption = 'Standard Value';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50035; "Grade Points"; Integer)
        {
            Caption = 'Grade Points';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            Editable = false;
        }
        field(50036; "Max Percentage"; Decimal)
        {
            Caption = 'Max Percentage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50037; "Min Percentage"; Decimal)
        {
            Caption = 'Min Percentage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50038; "No of Candiates (Core)"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'No of Candiates (Core)';
            CalcFormula = Count ("Main Student Subject-CS" WHERE("Subject Code" = FIELD("Subject Code"),
                                                                 "Academic Year" = FIELD("Academic Year"),
                                                                 Semester = FIELD(Semester),
                                                                 Grade = FIELD(Grade),
                                                                 Graduation = FIELD(Program)));
            Description = 'CS Field Added 26052019';

        }
        field(50039; "No of Candiates ( Elective)"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'No of Candiates ( Elective)';
            CalcFormula = Count ("Optional Student Subject-CS" WHERE("Subject Code" = FIELD("Subject Code"),
                                                                     "Academic Year" = FIELD("Academic Year"),
                                                                     Semester = FIELD(Semester),
                                                                     Grade = FIELD(Grade),
                                                                     Graduation = FIELD(Program)));
            Description = 'CS Field Added 26052019';

        }
        field(50040; "Program"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'Program';
            CalcFormula = Lookup ("Course Master-CS".Graduation WHERE(Code = FIELD("Course Code")));
            Description = 'CS Field Added 26052019';

        }
        field(50041; "Total Core"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Total Core';
            CalcFormula = Count ("Main Student Subject-CS" WHERE("Subject Code" = FIELD("Subject Code"),
                                                                 Semester = FIELD(Semester),
                                                                 "Academic Year" = FIELD("Academic Year"),
                                                                 Graduation = FIELD(Program)));
            Description = 'CS Field Added 26052019';

        }
        field(50042; "Total Elective"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Total Elective';
            CalcFormula = Count ("Optional Student Subject-CS" WHERE(Semester = FIELD(Semester),
                                                                     "Academic Year" = FIELD("Academic Year"),
                                                                     "Subject Code" = FIELD("Subject Code"),
                                                                     Graduation = FIELD(Program)));
            Description = 'CS Field Added 26052019';

        }
        field(50043; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
    }

    keys
    {
        key(Key1; "No.", "Line No")
        {
            SumIndexFields = "Count Std", "Count Revised";
        }
        key(Key2; "Subject Code", "Max Percentage")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit "DimensionManagement";

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}


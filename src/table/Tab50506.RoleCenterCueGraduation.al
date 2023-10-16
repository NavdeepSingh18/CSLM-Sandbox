table 50506 RoleCenterCueGraduation
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Degree Audit"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Degree Audit" where("Document Status" = filter("Pending for Verification")));
        }
        field(3; "Assigned Task List"; integer)
        {
            // FieldClass = FlowField;
            // CalcFormula = Count();
        }
        field(4; "Pdng Transcript Printing Req."; integer)
        {
            caption = 'Pending Transcript Printing Request';
            FieldClass = FlowField;
            CalcFormula = Count("Certificates Application-CS" where(Status = filter(Pending)));
        }
        field(5; "Eligible Student List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = const('PENDGRAD')));
        }
        field(6; "Total Degree List"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Final Degree-CS");
        }
        field(7; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
        }
        field(8; "Academic Year Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
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
table 50500 RoleCenterCueAdmission
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Total Students"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Academic Year" = field("Academic Year Filter")));
        }
        field(3; Courses; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Course Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(4; "Housing Applications"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Housing Application" where(Status = filter("Pending for Approval"), "Academic Year" = field("Academic Year Filter")));
        }
        field(5; "Housing Waiver App"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Opt Out" where(status = Filter("Pending for Approval"), "Application Type" = filter("Housing Wavier"), "Academic Year" = field("Academic Year Filter")));
        }
        field(6; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
        }
        field(7; "Academic Year Filter"; Code[20])
        {
            Caption = 'Academic Year Filter';
            FieldClass = FlowFilter;
        }
        field(8; "Portal User List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Portal User Login-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(9; "Re-entry Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Academic Year" = field("Academic Year Filter"), Status = filter('REENTRY')));
        }
        field(10; "Re-admit Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Academic Year" = field("Academic Year Filter"), Status = filter('RADM')));
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
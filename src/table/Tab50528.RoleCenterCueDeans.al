table 50528 RoleCenterCueDeans
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
        }
        field(3; "College Withdrawal Apps"; integer)
        {
            Caption = 'College Withdrawal Applications';
            FieldClass = FlowField;
            CalcFormula = count("Withdrawal Approvals" where(Status = filter("Pending for Approval"), "Type of Withdrawal" = filter("College-Withdrawal"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(4; "Course Withdrawal Apps"; integer)
        {
            Caption = 'Course Withdrawal Applications';
            FieldClass = FlowField;
            CalcFormula = count("Withdrawal Approvals" where(Status = filter("Pending for Approval"), "Type of Withdrawal" = Filter("Course-Withdrawal"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(5; "SLOA Applications"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leaves Approvals" where("Type of Leaves" = filter(SLOA), Status = filter("Pending for Approval")));//, "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(6; "ELOA Applications"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leaves Approvals" where("Type of Leaves" = filter(ELOA), Status = filter("Pending for Approval")));//, "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(7; "CLOA Applications"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leaves Approvals" where("Type of Leaves" = filter(CLOA), Status = filter("Pending for Approval")));//, "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(8; "Academic Year Filter"; Code[20])
        {
            Caption = 'Academic Year Filter';
            FieldClass = FlowFilter;
        }
        field(9; "Active Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('ATT')));
        }
        field(10; "Probation Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('PROB')));
        }
        field(11; "ELOA Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('EXTLOA')));
        }
        field(12; "Total Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(13; "Total Course"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Course Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(14; "CLOA Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('CLOA')));
        }
        field(15; "SLOA Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('SLOA')));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }


}
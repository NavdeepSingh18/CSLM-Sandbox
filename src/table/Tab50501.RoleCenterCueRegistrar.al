table 50501 RoleCenterCueRegistrar
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
        field(3; "Total Courses"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Course Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(4; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
        }
        field(5; "Total Employees"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee);
        }
        field(6; "Total Pending Housing Apps"; Integer)
        {
            Caption = 'Total Pending Housing Applications';
            FieldClass = FlowField;
            CalcFormula = count("Housing Application" where(Status = filter("Pending for Approval"), "Academic Year" = field("Academic Year Filter")));
        }
        field(7; "Total pndg Housing Waiver Apps"; Integer)
        {
            Caption = 'Total Pending Housing Waiver Applicaitons';
            FieldClass = FlowField;
            CalcFormula = count("Opt Out" where(status = Filter("Pending for Approval"), "Application Type" = filter("Housing Wavier"), "Academic Year" = field("Academic Year Filter")));
        }
        field(8; "Total Pndg Clg Withdrawal Apps"; integer)
        {
            Caption = 'Total Pending College Withdrawal Applications';
            FieldClass = FlowField;
            CalcFormula = count("Withdrawal Approvals" where(Status = filter("Pending for Approval" | Rejected), "Type of Withdrawal" = filter("College-Withdrawal"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(9; "Total Pndng Course Withwl Apps"; integer)
        {
            Caption = 'Total Pending Course Withdrawal Applications';
            FieldClass = FlowField;
            CalcFormula = count("Withdrawal Approvals" where(Status = filter("Pending for Approval"), "Type of Withdrawal" = Filter("Course-Withdrawal"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(10; "Total SLOA Applicaitons"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leaves Approvals" where("Type of Leaves" = filter(SLOA), "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = FILTER("Pending for Approval" | Rejected)));
            // "Pending Leaves Approvals"
        }
        field(11; "Total ELOA Applications"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leaves Approvals" where("Type of Leaves" = filter(ELOA), "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = FILTER("Pending for Approval" | Rejected)));
            // "Pending Leaves Approvals"
        }
        field(12; "Total CLOA Applications"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leaves Approvals" where("Type of Leaves" = filter(CLOA), "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = FILTER("Pending for Approval" | Rejected)));
            // "Pending Leaves Approvals"
        }
        field(13; "Academic Year Filter"; Code[20])
        {
            Caption = 'Academic Year Filter';
            FieldClass = FlowFilter;
        }
        field(14; "Total Checked-In"; Integer)
        {
            Caption = 'Pending On-Ground Checked-In';
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("OLR Completed" = filter(true), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('ROL')));
        }
        field(15; "Total Checked-Completed"; Integer)
        {
            Caption = 'Pending On-Ground Checked-In Completed';
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("OLR Completed" = filter(true), "Student Group" = filter("On-Ground Check-In"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = Filter(<> 'DCL' & <> 'DIS' & <> 'WITH' & <> 'DEF')));
        }
        field(16; "Total Registrar Signoff"; Integer)
        {
            Caption = 'Pending Registrar Signoff';
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("OLR Completed" = filter(true), "Student Group" = filter("On-Ground Check-In Completed"), "Registrar Signoff" = filter(false), "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(17; "Active Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Academic Year" = field("Academic Year Filter"), Status = filter('ATT')));
        }
        field(18; "Probation Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('PROB')));
        }
        field(19; "CLOA Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Academic Year" = field("Academic Year Filter"), Status = filter('CLOA')));
        }
        field(20; "ELOA Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Academic Year" = field("Academic Year Filter"), Status = filter('EXTLOA')));
        }
        field(21; "SLOA Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Academic Year" = field("Academic Year Filter"), Status = filter('SLOA')));
        }
        field(22; "Pending for Graduate Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Academic Year" = field("Academic Year Filter"), Status = filter('PENDGRAD')));
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
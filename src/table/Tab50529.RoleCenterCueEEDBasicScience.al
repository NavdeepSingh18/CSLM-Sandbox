table 50529 RoleCenterCueEEDBscScnc
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
        field(4; "ELOA Applications"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leaves Approvals" where("Type of Leaves" = filter(ELOA), Status = filter("Pending for Approval")));//, "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(5; "SLOA Applications"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leaves Approvals" where("Type of Leaves" = filter(SLOA), Status = filter("Pending for Approval")));//, "Academic Year" = field("Academic Year Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(6; "Academic Year Filter"; Code[20])
        {
            Caption = 'Academic Year Filter';
            FieldClass = FlowFilter;
        }
        field(7; "Active Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('ATT')));
        }
        field(8; "Probation Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('PROB')));
        }
        field(9; "Course Withdrawal Apps"; integer)
        {
            Caption = 'Course Withdrawal Applications';
            FieldClass = FlowField;
            CalcFormula = count("Withdrawal Approvals" where(Status = filter("Pending for Approval"), "Type of Withdrawal" = Filter("Course-Withdrawal"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(10; "ELOA Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"), Status = filter('EXTLOA')));
        }
        field(11; "Total Students"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(12; "Total Course"; Integer)
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
        field(16; "Pending Advising Request"; Integer)
        {
            Caption = 'Pending Advising Request List';
        }
        field(17; "Approved Adv. Req."; Integer)
        {
            Caption = 'Approved Advising Request List';
        }
        field(18; "Reje. Comptd. Adv. Req."; integer)
        {
            Caption = 'Rejected/Completed Advising Request List';
        }
        field(19; "FAFSA TYPE"; Integer)
        {
            Caption = 'FAFSA TYPE';
        }
        field(20; "TOTAL APPROVED WITHDRAWAL"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(21; "PENDING WITHDRAWAL"; Integer)
        {
            DataClassification = CustomerContent;
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
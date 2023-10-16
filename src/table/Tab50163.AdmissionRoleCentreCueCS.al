table 50163 "Admission RoleCentre Cue-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   13/09/2019       OnInsert()                                 Code added for calcfield Related

    Caption = 'Admission RoleCentre Cue-CS';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';

            DataClassification = CustomerContent;
        }
        field(2; "Overdue Student  Payment"; Integer)
        {
            CalcFormula = Count ("Cust. Ledger Entry" WHERE("Document Type" = FILTER('Invoice' | 'Credit Memo'),
                                                            "Due Date" = FIELD("Overdue Date Filter"),
                                                            Open = CONST(true)));
            Caption = 'Overdue Sales Documents';
            FieldClass = FlowField;
        }
        field(20; "Due Date Filter"; Date)
        {
            Caption = 'Due Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Overdue Date Filter"; Date)
        {
            Caption = 'Overdue Date Filter';
            FieldClass = FlowFilter;
        }
        field(50000; "Active Student"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Student Status" = FILTER(Student)));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //Code added for calcfield Related::CSPL-00114::13092019: Start
                CALCFIELDS("Active Student");
                //Code added for calcfield Related::CSPL-00114::13092019: End
            end;
        }
        field(50001; "Inactive Student"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Student Status" = FILTER(Inactive)));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50002; "Provisional Student"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Student Status" = FILTER('Provisional Student')));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50003; "Expired Student"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Student Status" = FILTER(Expired)));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50004; "Withdrwal -In- Process"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Student Status" = FILTER('Withdrwal -In- Process')));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50005; "Withdrwal/Discontinue"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Student Status" = FILTER('Withdrawl/Discontinue')));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50006; "Student Transfer-In-Process"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Student Status" = FILTER('Student Transfer-In-Process')));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50007; "Category General"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Fee Classification Code" = FILTER('GENERAL')));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50008; "Category Foreign"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Fee Classification Code" = FILTER('FOREIGN')));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50009; "Category NRI Special"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Fee Classification Code" = FILTER('NRI SPECIAL')));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
        field(50010; "Admission Today"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Updated On" = FILTER('12-04-17')));
            Description = 'CS Field Added 13072019';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}


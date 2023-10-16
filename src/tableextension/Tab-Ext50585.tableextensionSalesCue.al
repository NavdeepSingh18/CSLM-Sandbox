tableextension 50585 "tableextensionSalesCue" extends "Sales Cue"
{
    // version NAVW19.00.00.45778-CS

    fields
    {
        field(50000; "Active Student"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Student Master-CS" WHERE("Student Status" = FILTER(Student)));
        }
    }
}


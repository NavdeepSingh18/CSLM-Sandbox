query 50008 "Student Opted with Living Exp"
{
    Caption = 'Students Opted with Living Expense';

    elements
    {
        dataitem(Financial_AID; "Financial AID")
        {
            column(Semester; Semester)
            {
            }
            filter(Living_expenses; "Living expenses")
            {
            }
            filter(Status; Status)
            {
            }
            filter(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            // filter(Academic_Year; "Academic Year")
            // {
            // }
            column(NumberOfHousingOccupancy)
            {
                Method = Count;
            }
        }
    }
}


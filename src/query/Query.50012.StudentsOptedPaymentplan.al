query 50012 "Student Opted with PP"
{
    Caption = 'Students Opted with Payment Plan';

    elements
    {
        dataitem(Student_Master_CS; "Student Master-CS")
        {
            column(Semester; Semester)
            {
            }
            filter(Payment_Plan_Applied; "Payment Plan Applied")
            {
            }
            filter(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            filter(Academic_Year; "Academic Year")
            {
            }
            column(NumberOfHousingOccupancy)
            {
                Method = Count;
            }
        }
    }
}


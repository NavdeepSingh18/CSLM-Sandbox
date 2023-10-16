query 50007 "Student Opted with SP"
{
    Caption = 'Students Opted with Self Payment';

    elements
    {
        dataitem(Student_Master_CS; "Student Master-CS")
        {
            column(Semester; Semester)
            {

            }
            filter(Self_Payment_Applied; "Self Payment Applied")
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


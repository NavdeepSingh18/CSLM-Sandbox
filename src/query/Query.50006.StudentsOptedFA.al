query 50006 "Student Opted with FA"
{
    Caption = 'Students Opted with FA';

    elements
    {
        dataitem(Student_Master_CS; "Student Master-CS")
        {
            column(Semester; Semester)
            {
            }

            filter(Financial_Aid_Approved; "Financial Aid Approved")
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


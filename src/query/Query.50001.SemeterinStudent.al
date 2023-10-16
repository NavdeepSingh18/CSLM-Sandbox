query 50001 "Semester in Student"
{
    Caption = 'Semester in Student';

    elements
    {
        dataitem(Student_Master_CS; "Student Master-CS")
        {
            column(Semester; Semester)
            {
            }
            filter(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }

            filter(Term; Term)
            {

            }
            filter(Academic_Year; "Academic Year")
            {

            }
            column(NumberOfStudent)
            {
                Method = Count;
            }
        }
    }
}


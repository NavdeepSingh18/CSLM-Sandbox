query 50000 "Course in Student"
{
    Caption = 'Course in Student';

    elements
    {
        dataitem(Student_Master_CS; "Student Master-CS")
        {
            column(Course_Code; "Course Code")
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


query 50010 "Degree or Certi Awarded"
{
    Caption = 'Total Degree/Certificate Awarded';

    elements
    {
        dataitem(Student_Degree; "Student Degree")
        {
            column(Degree_Code; "Degree Code")
            {
            }
            filter(DateAwarded; DateAwarded)
            {
            }
            filter(Degree_CodeFilter; "Degree Code")
            {

            }
            column(NoofStudents)
            {
                Method = Count;
            }
        }
    }
}


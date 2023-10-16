query 50018 "Exam Sub. wise Student"
{
    Caption = 'Exam Subject wise Student';

    elements
    {
        dataitem(Student_Subject_Exam; "Student Subject Exam")
        {
            column(Subject_Code; "Subject Code")
            {
            }
            // filter(Subject_Code;"Subject Code")
            // {
            // }
            column(NoofStudents)
            {
                Method = Count;
            }
        }
    }
}


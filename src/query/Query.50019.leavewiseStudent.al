query 50019 "Leaves wise Student"
{
    Caption = 'Leaves wise Student';

    elements
    {
        dataitem(Student_Master_CS; "Student Master-CS")
        {
            column(Status; Status)
            {
            }
            filter(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(NumberOfStudent)
            {
                Method = Count;
            }
        }
    }
}


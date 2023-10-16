query 50009 "Student With Or Without Fee"
{
    Caption = 'Students With Fee or Without Fee';

    elements
    {
        dataitem(Student_Master_CS; "Student Master-CS")
        {
            column(Fee_Generated; "Fee Generated")
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


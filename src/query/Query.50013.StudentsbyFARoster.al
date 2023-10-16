query 50013 "Student by FA Roster"
{
    Caption = 'Students by FA Roster';

    elements
    {
        dataitem(Student_Master_CS; "Student Master-CS")
        {
            column(Type_of_FA_Roster; "Type of FA Roster")
            {
            }
            filter(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(NumberofCountforTypesofFARoster)
            {
                Method = Count;
            }
        }
    }
}


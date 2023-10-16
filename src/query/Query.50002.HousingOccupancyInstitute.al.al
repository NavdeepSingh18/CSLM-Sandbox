query 50002 "Housing Occupancy by Ins."
{
    Caption = 'Housing Occupied by Institutes';

    elements
    {
        dataitem(Housing_Application; "Housing Application")
        {
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            filter(Status; Status)
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


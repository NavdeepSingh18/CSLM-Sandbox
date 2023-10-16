query 50004 "Housing Occupancy per year"
{
    Caption = 'Housing Occupied per year';

    elements
    {
        dataitem(Housing_Application; "Housing Application")
        {
            column(Academic_Year; "Academic Year")
            {
            }
            filter(Status; Status)
            {
            }
            column(NumberOfHousingOccupancy)
            {
                Method = Count;
            }
        }
    }
}


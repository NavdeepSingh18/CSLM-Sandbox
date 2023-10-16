query 50005 "Housing Occupancy by Gender"
{
    Caption = 'Housing Occupied by Gender';

    elements
    {
        dataitem(Housing_Application; "Housing Application")
        {

            column(Gender; "Gender Text")
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


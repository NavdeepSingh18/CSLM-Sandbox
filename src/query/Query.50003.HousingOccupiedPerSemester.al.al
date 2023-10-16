query 50003 "Housing Occupancy per Semester"
{
    Caption = 'Housing Occupied per Semester';

    elements
    {
        dataitem(Housing_Application; "Housing Application")
        {
            column(Semester; Semester)
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


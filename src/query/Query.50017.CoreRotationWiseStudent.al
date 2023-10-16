query 50017 "Core Rot. wise Student"
{
    Caption = 'Core Rotation wise Student';

    elements
    {
        dataitem(Roster_Scheduling_Line; "Roster Scheduling Line")
        {
            column(Course_Prefix_Code; "Course Prefix Code")
            {
            }
            filter(Clerkship_Type; "Clerkship Type")
            {
            }
            filter(Start_Date; "Start Date")
            {
            }
            filter(End_Date; "End Date")
            {
            }
            filter(Rotation_Confirmed; "Rotation Confirmed")
            {
            }
            filter(Status; Status)
            {
            }
            column(NoofRotationID)
            {
                Method = Count;
            }
        }
    }
}


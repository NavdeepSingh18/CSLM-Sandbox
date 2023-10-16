query 50011 "User Tasks"
{
    Caption = 'User Tasks';

    elements
    {
        dataitem(User_Task; "User Task")
        {
            column(Percent_Complete; "Percent Complete")
            {
            }
            column(CountofSubject)
            {
                Method = Count;
            }
        }
    }
}


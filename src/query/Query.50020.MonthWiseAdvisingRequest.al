query 50020 "Month Wise Advising Request"
{
    Caption = 'Month Wise Advising Request Query';

    elements
    {
        dataitem(Advising_Request; "Advising Request")
        {
            filter(Meeting_Date; "Meeting Date")
            {

            }
            column(Meeting_Month; "Meeting Month")
            {

            }
            filter(Request_Status; "Request Status")
            {
            }
            filter(Department_Type; "Department Type")
            {
            }
            column(NoofAdvisingRequest)
            {
                Method = Count;
            }
        }
    }
}
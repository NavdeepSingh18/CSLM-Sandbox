query 50015 "MSPE Apps. year wise"
{
    Caption = 'MSPE Apps Submitted by Studs. year wise';

    elements
    {
        dataitem(MSPE; MSPE)
        {
            DataItemTableFilter = "Processing Status" = filter(Pending);
            column(Academic_Year; "Academic Year")
            {
            }
            //             column(Processing_Status; "Processing Status")
            // {
            // }

            column(Countofyear)
            {
                Method = Count;
            }
        }
    }
}


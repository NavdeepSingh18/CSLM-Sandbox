query 50016 "Yearly Studs. Residency Status"
{
    Caption = 'Yearly Students Residency Status';

    elements
    {
        dataitem(Student_Residency_Status_List; Residency)
        {
            DataItemTableFilter = "Residency Status" = filter('INCOMPLETE|MATCHED|MATCHED - ADVANCED|MATCHED-ADVWITHDRAWN|NO MATCHED|OFF-CYCLE|OFF-CYCLE MATCH|OFF-CYCLE.|OPTEDOUT|OUTSIDE OF MATCH|PRE-MATCHED|SCRAMBLED|SCRAMBLED\SOAP|SOAP|SOAP ADVANCED|WITHDRAWN|PENDING|PRE-MATCHED-Advanced|Pre-Match');
            column(Residency_Status; "Residency Status")
            {
            }
            column(NoofYears)
            {
                Method = Count;
            }
            
        }
    }
}


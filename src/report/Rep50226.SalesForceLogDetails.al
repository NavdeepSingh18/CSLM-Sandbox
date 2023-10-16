report 50226 "SalesForce Log Details"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'SalesForce Log Details Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/SalesForceErrorLogDetails.rdl';
    dataset
    {
        dataitem("Salesforce Sync Error Log"; "Salesforce Sync Error Log")
        {
            DataItemTableView = where(Counter = filter(99));

            Column(Entry_No_; "Entry No.")
            { }
            Column(Log_Date; "Log Date")
            { }
            Column(Data_Table_Name; "Data Table Name")
            { }
            Column(Web_Service_Name; "Web Service Name")
            { }
            Column(Insert_Event; "Insert Event")
            { }
            column(Update_Event; "Update Event")
            { }
            Column(Error_Description; "Error Description")
            { }
            column(Data; Data)
            { }
            column(Table_ID; "Table ID")
            { }
            Column(URL; URL)
            { }
            column(Body_1; "Body 1")
            { }
            column(Method; Method)
            { }
            column(Event_Trigger; "Event Trigger")
            { }
            column(Retry; Retry)
            { }
            column(Counter; Counter)
            { }

        }
    }
}
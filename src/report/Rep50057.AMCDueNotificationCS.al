report 50057 "AMC Due NotificationCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/AMC Due NotificationCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = FILTER('Order'),
                                      "AMC PO" = FILTER(true));
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
            {
            }
            column(VendorInvoiceNo_PurchaseHeader; "Purchase Header"."Vendor Invoice No.")
            {
            }
            column(AMCEndDate_PurchaseHeader; "Purchase Header"."AMC End Date")
            {
            }
            column(VendorName; VendorRec.Name)
            {
            }
            column(DaysLeft; PurchSetup."Indent No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                NotificationDate := CALCDATE(AMCDate, "Purchase Header"."AMC End Date");
                IF NotificationDate <> (System.WorkDate()) THEN
                    CurrReport.Skip();
                IF VendorRec.GET("Purchase Header"."Buy-from Vendor No.") THEN;
            end;

            trigger OnPreDataItem()
            begin
                PurchSetup.GET();
                AMCDate := '-' + FORMAT(PurchSetup."AMC Over 1st Notification");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET();
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        VendorRec: Record "Vendor";
        CompanyInfo: Record "Company Information";
        NotificationDate: Date;
        AMCDate: Text;

}


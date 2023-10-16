report 50252 "Purchase Order Request"
{
    Caption = 'Purchase Quotation';
    DefaultLayout = RDLC;
    RDLCLayout = './SRC/reportrdlc/PurchaseOrderRequest.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            column(DepartmentManagerLbl; DepartmentManagerLbl) { }
            column(SignatureLbl; SignatureLbl) { }
            column(VendorTele; VendorTele) { }
            column(No_PH; "No.") { }
            column(VPLbl; VPLbl) { }
            column(SignLbl; SignLbl) { }
            column(PrintNameLbl; PrintNameLbl) { }
            column(ReasonsAndJustiLbl; ReasonsAndJustiLbl) { }
            column(DepartmentName; DepartmentName) { }
            column(RequiredNowLbl; RequiredNowLbl) { }
            column(AlreadyHeldLbl; AlreadyHeldLbl) { }
            column(UserAssignedName; UserAssignedName) { }
            column(DocumentDate_PurchaseHeader; Format("Document Date", 0, '<Closing><Day,2>-<Month,2>-<Year>')) { }
            column(Due_Date; Format("Due Date", 0, '<Closing><Day,2>-<Month,2>-<Year>')) { }
            column(LocationAddress; LocationAddress) { }
            column(LocationAddress2; LocationAddress2) { }
            column(LocationName; LocationName) { }
            column(LocaitonCity; LocaitonCity) { }
            column(LocationCountry; LocationCountry) { }
            column(LocationPINCode; LocationPINCode) { }
            column(LocationState; LocationState) { }
            column(TelLbl; TelLbl) { }
            column(PRLbl; PRLbl) { }
            column(DepartmentLbl; DepartmentLbl) { }
            column(NameofRequestor; NameofRequestorLbl) { }
            column(DateLbl; DateLbl) { }
            column(PreparedByLbl; PreparedByLbl) { }
            column(PURCHASEORDERLbl; PURCHASEORDERLbl) { }
            column(DueDateLbl; DueDateLbl) { }
            column(BuyfromCity_PurchaseHeader; "Buy-from City") { }
            column(BuyfromState; "Buy-from County") { }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code") { }
            column(BuyfromAddress_PurchaseHeader; "Buy-from Address") { }
            column(BuyfromContact_PurchaseHeader; "Buy-from Contact") { }
            column(BuyfromAddress2_PurchaseHeader; "Buy-from Address 2") { }
            column(BuyfromPostCode_PurchaseHeader; "Buy-from Post Code") { }
            column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.") { }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name") { }
            column(RowHeader; RowHeader) { }
            column(RowHeader1; RowHeader1) { }
            column(RowHeader3; RowHeader3) { }
            column(RowHeader4; RowHeader4) { }
            column(RowHeader6; RowHeader6) { }
            column(RowHeader7; RowHeader7) { }
            column(RowHeader8; RowHeader8) { }
            column(PurchaseRecordLbl; PurchaseRecordLbl) { }
            column(ReceivingRecordLbl; ReceivingRecordLbl) { }
            column(VendorInformationLbl; VendorInformationLbl) { }
            column(PurchasingDeptLbl; PurchasingDeptLbl) { }
            column(VendorNameLbl; VendorNameLbl) { }
            column(AddressLbl; AddressLbl) { }
            column(RequiredSignaturesLbl; RequiredSignaturesLbl) { }
            column(GrandTotalLbl; GrandTotalLbl) { }
            column(VendorNOLbl; VendorNOLbl) { }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; Address2)
            {
            }
            column(City; City)
            {
            }
            column(PostCode; PostCode)
            {
            }
            column(Country; Country)
            {
            }
            column(Email; Email)
            {
            }
            // column(Requi; Req)
            // {
            // }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Quote));
                column(No_PurchaseLine; "No.")
                {
                }
                column(UnitCostLCY_PurchaseLine; "Unit Cost")
                {
                }
                column(LineAmount_PurchaseLine; "Line Amount")
                {
                }
                column(LineNo_PurchaseLine; "Line No.")
                {
                }
                column(DocumentNo_PurchaseLine; "Document No.")
                {
                }
                column(DocumentType_PurchaseLine; "Document Type")
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(QtytoReceive_PurchaseLine; "Qty. to Receive")
                {
                }
                column(OutstandingQuantity_PurchaseLine; "Outstanding Quantity")
                {
                }
                column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                Column(Requisition_No_; "Requisition No.")
                {

                }
                Column(RequisitionCreator; RequisitionCreator)
                { }
            }

            trigger OnAfterGetRecord()
            var
                ApprovalEntry: Record "Approval Entry";
                UserSetup: Record "User Setup";
                PurchLine: Record "Purchase Line";
            begin
                LocationName := '';
                LocationAddress := '';
                LocationAddress2 := '';
                LocaitonCity := '';
                LocationPINCode := '';
                LocationState := '';
                LocationCountry := '';
                UserAssignedName := '';
                VendorTele := '';
                RequisitionCreator := '';

                if LocationRec.Get("Location Code") then begin
                    LocationName := LocationRec.Name;
                    LocationAddress := LocationRec.Address;
                    LocationAddress2 := LocationRec."Address 2";
                    LocaitonCity := LocationRec.City;
                    LocationPINCode := LocationRec."Post Code";
                    LocationState := LocationRec.County;
                    if CountryRec.Get(LocationRec."Country/Region Code") then
                        LocationCountry := CountryRec.Description;
                end;

                DimensionValueRec.Reset();
                DimensionValueRec.SetRange(code, "Shortcut Dimension 2 Code");
                if DimensionValueRec.FindFirst() then
                    DepartmentName := DimensionValueRec.Name;

                Users.Reset();
                Users.SetRange("User Name", "Assigned User ID");
                if Users.FindFirst() then
                    UserAssignedName := Users."Full Name";

                if VendorRec.Get("Buy-from Vendor No.") then
                    VendorTele := VendorRec."Phone No.";

                PurchLine.Reset();
                PurchLine.SetRange("Document No.", "Purchase Header"."No.");
                PurchLine.SetFilter("Requisition No.", '<>%1', '');
                IF PurchLine.FindFirst() then begin
                    RequisitionHdr.Reset();
                    RequisitionHdr.SetRange("No.", PurchLine."Requisition No.");
                    If RequisitionHdr.FindFirst() then begin
                        Users.Reset();
                        Users.SetRange("User Name", RequisitionHdr."User Id");
                        If Users.FindFirst() then
                            RequisitionCreator := Users."Full Name";
                    end;
                end;
                //CSPL-00307 Start 
                Clear(Name);
                Clear(Address);
                Clear(Address2);
                Clear(City);
                Clear(PostCode);
                Clear(Country);
                IF "Purchase Header"."Shortcut Dimension 1 Code" = '8000' then begin
                    CompanyInformation.Get;
                    Name := CompanyInformation.Name;
                    Address := CompanyInformation.Address;
                    Address2 := CompanyInformation."Address 2";
                    City := CompanyInformation.City;
                    PostCode := CompanyInformation."Post Code";
                    Country := CompanyInformation.County;
                    Email := CompanyInformation."E-Mail";


                end;
                IF "Purchase Header"."Shortcut Dimension 1 Code" = '9000' then begin
                    EduSetup.Reset();
                    EduSetup.SetRange("Global Dimension 1 Code", "Purchase Header"."Shortcut Dimension 1 Code");
                    If EduSetup.FindFirst() then;
                    Name := EduSetup."Institute Name";
                    Address := EduSetup."Institute Address";
                    Address2 := EduSetup."Institute Address 2";
                    City := EduSetup."Institute City";
                    PostCode := EduSetup."Institute Post Code";
                    Country := EduSetup."Institute Country Code";
                    Email := EduSetup."Institute E-Mail";
                end;
                IF "Purchase Header"."Shortcut Dimension 1 Code" = '9100' then begin
                    EduSetup.Reset();
                    EduSetup.SetRange("Global Dimension 1 Code", "Purchase Header"."Shortcut Dimension 1 Code");
                    If EduSetup.FindFirst() then;
                    Name := EduSetup."Institute Name";
                    Address := EduSetup."Institute Address";
                    City := EduSetup."Institute City";
                    PostCode := EduSetup."Institute Post Code";
                    Country := EduSetup."Institute Country Code";
                    Address2 := EduSetup."Institute Address 2";
                    Email := EduSetup."Institute E-Mail";
                end;
                //CSPL-00307 Ends
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        VendorRec: Record Vendor;
        DimensionValueRec: Record "Dimension Value";
        RequisitionHdr: Record "Requisition Header";
        Users: Record User;
        VendorTele: Text[30];
        RequiredSignaturesLbl: Label 'Required Signatures';

        UserAssignedName: Text;

        NameOFRequestor: Text;
        DepartmentName: Text;
        AddressLbl: Label 'Address:';
        VendorNameLbl: Label 'Vendor Name:';
        VendorInformationLbl: Label 'Vendor Information';
        TelLbl: Label 'Tel#';
        PRLbl: Label 'PR#';
        DepartmentLbl: Label 'Department:';
        AlreadyHeldLbl: Label 'Already Held';
        DepartmentManagerLbl: Label 'Department Manager';
        SignLbl: Label '(Signature)';
        PrintNameLbl: Label '(Print Name)';
        VPLbl: Label 'VP/Director of Administration ';
        ReasonsAndJustiLbl: Label 'Reasons and Justifications';
        NameofRequestorLbl: Label 'Name of Requestor:';
        DateLbl: Label 'Date:';
        PreparedByLbl: Label 'Prepared By:';
        PURCHASEORDERLbl: Label 'Purchase Quotation';
        DueDateLbl: Label 'Due Date:';
        LocationRec: Record Location;
        LocationName: Text;
        LocationAddress: Text;
        LocationAddress2: Text;
        LocaitonCity: Text;
        LocationState: Text;
        LocationCountry: Text;
        LocationPINCode: Code[20];
        CountryRec: Record "Country/Region";
        RequiredNowLbl: Label 'Required Now';
        VendorNOLbl: Label 'Vendor No.';
        GrandTotalLbl: Label 'Grand Total';
        RowHeader8: Label 'Amount Due';
        RowHeader7: Label 'Qty Received';
        RowHeader6: Label 'Date Received';
        RowHeader4: Label 'Total Price';
        RowHeader3: Label 'Unit Price';
        RowHeader1: Label 'Item No.';
        RowHeader: Label 'Description';
        PurchaseRecordLbl: Label 'Purchase Quotation';
        ReceivingRecordLbl: Label 'Receiving Record';
        PurchasingDeptLbl: Label 'To be filled in by Requestor';
        SignatureLbl: Label 'Signature of Receiving Party';
        RequisitionCreator: Text;
        Name: Text;
        Address: Text;
        Address2: text;
        City: Text;
        PostCode: Text;
        Country: Text;
        EduSetup: Record "Education Setup-CS";
        Email: Text;
        CompanyInformation: Record "Company Information";
        State: Text;


}

report 50251 "Purchase Order Print"
{
    Caption = 'Purchase Order';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/PurchaseOrderPrint.rdl';
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            column(DollarSign; DollarSign) { }
            column(CFOCOOLbl; CFOCOOLbl) { }
            column(UserAssignedName; UserAssignedName) { }
            column(BuyfromCity_PurchaseHeader; "Buy-from City")
            {
            }
            column(BuyfromCounty_PurchaseHeader; "Buy-from County")
            {
            }
            column(BuyfromAddress_PurchaseHeader; "Buy-from Address")
            {
            }
            column(BuyfromContact_PurchaseHeader; "Buy-from Contact")
            {
            }
            column(BuyfromAddress2_PurchaseHeader; "Buy-from Address 2")
            {
            }
            column(BuyfromPostCode_PurchaseHeader; "Buy-from Post Code")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
            {
            }
            column(DocumentDate_PurchaseHeader; Format("Document Date", 0, '<Closing><Day,2>-<Month,2>-<Year>'))
            {
            }
            column(ShiptoCity_PurchaseHeader; "Ship-to City")
            {
            }
            column(ShiptoName_PurchaseHeader; "Ship-to Name")
            {
            }
            column(ShiptoCounty_PurchaseHeader; "Ship-to County")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Ship-to Address")
            {
            }
            column(ShiptoContact_PurchaseHeader; "Ship-to Contact")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Ship-to Address 2")
            {
            }
            column(ShiptoPostCode_PurchaseHeader; "Ship-to Post Code")
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Payment Terms Code")
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(Due_Date; Format("Due Date", 0, '<Closing><Day,2>-<Month,2>-<Year>')) { }
            column(CompanyInformationName; CompanyInformation.Name) { }
            column(CompanyInformationPicture; CompanyInformation.Picture) { }
            column(CompanyInformationAddress; CompanyInformation.Address) { }
            column(CompanyInformationAddress2; CompanyInformation."Address 2") { }
            column(CompanyInformationCity; CompanyInformation.City) { }
            column(CompanyInformationHomepage2; CompanyInformation."Home Page") { }
            column(CompanyInformationCounty; CompanyInformation.County) { }
            column(CompanyInformationPostCode; CompanyInformation."Post Code") { }
            column(CompanyInformationEmail; CompanyInformation."E-Mail") { }
            column(Text1Lbl; Text1Lbl) { }
            column(Text2Lbl; Text2Lbl) { }
            column(Text3Lbl; Text3Lbl) { }
            column(Text4Lbl; Text4Lbl) { }
            column(Text5Lbl; Text5Lbl) { }
            column(Text6Lbl; Text6Lbl) { }
            column(LeftText1Lbl; LeftText1Lbl) { }
            column(LeftText2Lbl; LeftText2Lbl) { }
            column(LeftText3Lbl; LeftText3Lbl) { }
            column(LeftText4Lbl; LeftText4Lbl) { }
            column(LeftText5Lbl; LeftText5Lbl) { }
            column(LeftText6Lbl; LeftText6Lbl) { }
            column(LeftText7Lbl; LeftText7Lbl) { }
            column(LeftText8Lbl; LeftText8Lbl) { }
            column(LeftText9Lbl; LeftText9Lbl) { }
            column(LeftText10Lbl; LeftText10Lbl) { }
            column(LeftText11Lbl; LeftText11Lbl) { }
            column(LeftText12Lbl; LeftText12Lbl) { }
            column(LeftText13Lbl; LeftText13Lbl) { }
            column(LeftText14Lbl; LeftText14Lbl) { }
            column(LeftText15Lbl; LeftText15Lbl) { }
            column(VendorSelectionLbl; VendorSelectionLbl) { }
            column(RigitText1Lbl; RigitText1Lbl) { }
            column(RowHeader; RowHeader) { }
            column(RowHeader1; RowHeader1) { }
            column(RowHeader2; RowHeader2) { }
            column(RowHeader3; RowHeader3) { }
            column(RowHeader4; RowHeader4) { }
            column(RowHeader5; RowHeader5) { }
            column(RowHeader6; RowHeader6) { }
            column(RowHeader7; RowHeader7) { }
            column(RowHeader8; RowHeader8) { }
            column(RowHeader9; RowHeader9) { }
            column(PurchaseRecordLbl; PurchaseRecordLbl) { }
            column(ReceivingRecordLbl; ReceivingRecordLbl) { }
            column(VendorInformationLbl; VendorInformationLbl) { }
            column(ShipToLbl; ShipToLbl) { }
            column(PurchasingDeptLbl; PurchasingDeptLbl) { }
            column(PURCHASEORDERLbl; PURCHASEORDERLbl) { }
            column(DateLbl; DateLbl) { }

            column(PurchaseNoLbl; PurchaseNoLbl) { }
            column(DueDateLbl; DueDateLbl) { }
            column(PaymentTermsLbl; PaymentTermsLbl) { }
            column(ShipDateTermsLbl; ShipDateTermsLbl) { }
            column(WarrantyInfoLbl; WarrantyInfoLbl) { }
            column(VendorNameLbl; VendorNameLbl) { }
            column(AddressLbl; AddressLbl) { }
            column(Address2Lbl; Address2Lbl) { }
            column(ContactLbl; ContactLbl) { }
            column(CtiyStateLbl; CtiyStateLbl) { }

            column(RequiredSignaturesLbl; RequiredSignaturesLbl) { }
            column(MerchandiseTotalLbl; MerchandiseTotalLbl) { }
            column(TaxesLbl; TaxesLbl) { }
            column(FreightLbl; FreightLbl) { }
            column(INSURANCELbl; INSURANCELbl) { }
            column(GrandTotalLbl; GrandTotalLbl) { }
            column(DutyLbl; DutyLbl) { }
            column(SignatureLbl; SignatureLbl) { }

            column(PurchasingDirectorLbl; PurchasingDirectorLbl) { }

            column(VendorNOLbl; VendorNOLbl) { }

            column(ApprovedUser; ApprovedUser) { }
            column(UserSetupSignatureapproval; UserSetup.Signature) { }
            column(UserSetupSignatureAssigned; UserSetup2.Signature) { }
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

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));
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

                dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                {
                    DataItemLink = "Order No." = FIELD("Document No."), "Order Line No." = field("Line No.");
                    DataItemLinkReference = "Purchase Line";
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    column(PostingDate_PurchRcptLine; Format("Posting Date", 0, '<Closing><Day,2>-<Month,2>-<Year>'))
                    {
                    }
                    column(Quantity_PurchRcptLine; Quantity)
                    {
                    }
                    column(DocumentNo_PurchRcptLine; "Document No.")
                    {
                    }
                    column(LineNo_PurchRcptLine; "Line No.")
                    {
                    }
                    column(OnHandQty; OnHandQty) { }
                    trigger OnAfterGetRecord()
                    begin

                        // "Purchase Line"."Line Amount" := 0;
                        If OnHandQty = 0 then
                            OnHandQty := "Purchase Line".Quantity;

                        OnHandQty := OnHandQty - "Purch. Rcpt. Line".Quantity;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(OnHandQty);
                end;

            }
            trigger OnAfterGetRecord()
            var
                ApprovalEntry: Record "Approval Entry";

            begin
                Clear(ApprovedUser);
                Clear(UserAssignedName);

                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Table ID", 38);
                ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Order);
                ApprovalEntry.SetRange("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then begin
                    if UserSetup.Get(ApprovalEntry."Approver ID") then
                        // ApprovedUser := UserSetup."Full Name";
                        UserSetup.CalcFields(Signature);
                    //For Approved User +
                    Users.Reset();
                    Users.SetRange("User Name", ApprovalEntry."Approver ID");
                    if Users.FindFirst() then
                        ApprovedUser := Users."Full Name";
                    //For Approved User -
                end;

                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");

                //For Assigned User Name+
                UserSetup2.Reset();
                if UserSetup2.Get("Assigned User ID") then begin
                    UserSetup2.CalcFields(Signature);
                    Users.Reset();
                    Users.SetRange("User Name", "Assigned User ID");
                    if Users.FindFirst() then
                        UserAssignedName := Users."Full Name";
                end;
                //For Assigned User Name-

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
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        DollarSign: Label '$';
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        SignatureUpload: Boolean;
        SignatureUpload2: Boolean;
        Users: Record User;
        ApprovalEntry: Record "Approval Entry";
        UserAssignedName: Text;
        CFOCOOLbl: Label 'CFO/COO';
        ApprovedUser: Text[200];
        VendorNOLbl: Label 'Vendor No.';
        OnHandQty: Decimal;
        PaymentTerms: Record "Payment Terms";
        CompanyInformation: Record "Company Information";

        PurchasingDirectorLbl: Label 'Purchasing Director';
        SignatureLbl: Label 'Signature of Receiving Party';

        DateLbl: Label 'Date:';
        PurchaseNoLbl: Label 'Purchase Order:';

        DueDateLbl: Label 'Due Date:';
        PaymentTermsLbl: Label 'Payment Terms';
        ShipDateTermsLbl: Label 'Ship Date Terms';
        WarrantyInfoLbl: Label 'Warranty info';
        VendorNameLbl: Label 'Vendor Name:';
        AddressLbl: Label 'Address:';
        Address2Lbl: Label 'Address 2:';
        ContactLbl: Label 'Contact:';
        CtiyStateLbl: Label 'City/State/Zip';
        Text1Lbl: Label '"Payment:';
        Text2Lbl: Label 'Discount terms are as set forth in the Form. If no terms are specified, the net amount shall be payable within 30 days after the later of (i) delivery and acceptance of goods or other performance conforming with the terms of this Purchase Order and (ii) invoicing. Except as otherwise provided in the Purchase Order, the price includes all applicable Federal, State and local taxes and duties. Supplier assigns to Buyer all rights to refunds of sales and use taxes paid in connection with this Purchase Order and agrees to co-operate with Buyer in the processing of any refund claims. Unless expressly otherwise provided in the Form, Buyer shall not be liable for any shipping, handling, fuel surcharges or similar fees.';
        Text3Lbl: Label 'Timing:';
        Text4Lbl: Label 'If delivery or completion dates can not be met, Supplier shall inform Buyer immediately. Such notice shall not, however, constitute a change to the delivery or completion terms of this Purchase Order unless Buyer modifies this Purchase Order in writing. If any item is not received or if any element of the work is not completed by the date specified, the Buyer, at Buyers option and without prior notice to Supplier, may either approve a revised date or may cancel this Purchase Order and may obtain such goods or work elsewhere and in either event the Supplier shall be liable to the Buyer for any resulting loss incurred by the Buyer. Suppliers sole remedy for a delay caused by Buyer shall be an extension in the time for Suppliers performance equal to the duration of Buyers delay. Supplier shall not be liable for damages resulting from Suppliers failure to deliver or complete, or for delays in delivery or completion, caused solely by strikes not caused by or within the control of Supplier, lock-outs not caused by or within the control of Supplier, fires, war or acts of God. TIMING OF DELIVERY AND/OR PERFORMANCE OF THE WORK IS OF THE ESSENCE OF THIS PURCHASE ORDER.';
        Text5Lbl: Label 'Warranty:';
        Text6Lbl: Label 'Supplier expressly warrants all (i) goods delivered under this Purchase Order to be free from defects in material and workmanship and to be of the quality, size and dimensions ordered and (ii) work performed under this Purchase Order to be in conformity with all plans, specifications and other data incorporated as part of this Purchase Order. Notwithstanding any limitation of warranty, Supplier further represents and warrants that the supply, quality and fitness for the purpose of the goods or services will not be impaired, disrupted or interrupted in whole or in part by the occurrence of any leap year. All goods and work shall also be subject to any stricter warranties specified in the Purchase Order or in other materials incorporated by reference.';
        VendorSelectionLbl: Label 'Vendor selection checklist';
        RigitText1Lbl: Label 'Notes';
        LeftText1Lbl: Label 'Reasons for choosing vendor';
        LeftText2Lbl: Label 'Best competetive pricing';
        LeftText3Lbl: Label 'Provides cost saving alternatives';
        LeftText4Lbl: Label 'Backorders are held to a minimum';
        LeftText5Lbl: Label 'Provides prompt and accurate customer service';
        LeftText6Lbl: Label 'Provides status of orders';
        LeftText7Lbl: Label 'Interested in maintaining account';
        LeftText8Lbl: Label 'Provides quality products';
        LeftText9Lbl: Label 'Maintains up-to-date stock';
        LeftText10Lbl: Label 'Provides notice of any special offers or promotions';
        LeftText11Lbl: Label 'Delivers goods or services on time';
        LeftText12Lbl: Label 'Packages to restrict damage';
        LeftText13Lbl: Label 'Packs a shipment list with delivery';
        LeftText14Lbl: Label 'Proprietary vendor or manufacturer of the item';
        LeftText15Lbl: Label 'Rush order requested by the user';

        RequiredSignaturesLbl: Label 'Required Signatures';
        MerchandiseTotalLbl: Label 'Merchandise Total';
        TaxesLbl: Label 'Taxes';
        FreightLbl: Label 'Freight';
        INSURANCELbl: Label 'INSURANCE';
        GrandTotalLbl: Label 'Grand Total';
        DutyLbl: Label 'Duty';

        RowHeader9: Label 'Number of items on hand';
        RowHeader8: Label 'Amount Due';
        RowHeader7: Label 'Qty Received';
        RowHeader6: Label 'Date Received';
        RowHeader5: Label 'Total Price EC $';
        RowHeader4: Label 'Total Price US $';
        RowHeader3: Label 'Unit Price';
        RowHeader2: Label 'QTY';
        RowHeader1: Label 'Item No.';
        RowHeader: Label 'Description';
        PurchaseRecordLbl: Label 'Purchase Order Record';
        ReceivingRecordLbl: Label 'Receiving Record';
        VendorInformationLbl: Label 'Vendor Information';

        ShipToLbl: Label 'Ship to:';
        PurchasingDeptLbl: Label 'To be filled in by the Purchasing Dept.';

        PURCHASEORDERLbl: Label 'PURCHASE ORDER';
        Name: Text;
        Address: Text;
        Address2: text;
        City: Text;
        PostCode: Text;
        Country: Text;
        EduSetup: Record "Education Setup-CS";
        Email: Text;
}

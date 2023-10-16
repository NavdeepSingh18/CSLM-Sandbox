page 50436 "Hospital Card"
{
    Caption = 'Hospital';
    PageType = Card;
    UsageCategory = None;
    //ApplicationArea = All;
    SourceTable = Vendor;
    SourceTableView = where("Vendor Sub Type" = filter("Hospital"));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    ShowMandatory = true;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an additional part of the name.';
                    //CSPL-00307-ACGME
                }
                field("ACGME No."; Rec."ACGME No.")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                // field("State Code"; "State Code")//GMCSCOMM
                // {
                //     ApplicationArea = All;
                // }
                field("Country"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    ShowMandatory = true;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                //CSPL-00307-ACGME - Start
                field("Program Director"; Rec."Program Director")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Program Director field.';
                }
                field("Accreditation Status"; Rec."Accreditation Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Accreditation Status field.';
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Efective Date field.';
                }
                //CSPL-00307-ACGME - End
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        MailManagement: Codeunit "Mail Management";
                    begin
                        MailManagement.ValidateEmailAddressField(Rec."E-Mail");
                    end;
                }
                field(Latitude; Rec.Latitude)
                {
                    ApplicationArea = All;
                }
                field(Longitude; Rec.Longitude)
                {
                    ApplicationArea = All;
                }
                field(Residency; Rec.Residency)
                {
                    ApplicationArea = All;
                }
                field("Non-Affiliated Hospital"; Rec."Non-Affiliated Hospital")
                {
                    ApplicationArea = All;
                }
                field("LCME Sponsored"; Rec."LCME Sponsored")
                {
                    ApplicationArea = All;
                }
                group("DME Details")
                {
                    Caption = 'DME Details';
                    field("DME Code"; Rec."DME Code")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("DME Name"; Rec."DME Name")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("DME Phone No."; Rec."DME Phone No.")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("DME Email"; Rec."DME Email")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        trigger OnValidate()
                        var
                            MailManagement: Codeunit "Mail Management";
                        begin
                            MailManagement.ValidateEmailAddressField(Rec."E-Mail");
                        end;
                    }
                }
                field("FIU Hospital"; Rec."FIU Hospital")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Rotation Applicable"; Rec."FM1/IM1 Rotation Applicable")
                {
                    ApplicationArea = All;
                }
                field("Elective Rotation Applicable"; Rec."Elective Rotation Applicable")
                {
                    ApplicationArea = All;
                }
                field("Preffered for International"; Rec."Preffered for International")
                {
                    ApplicationArea = All;
                }
                field("Preffered for GHT Students"; Rec."Preffered for GHT Students")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Specialty; Rec.Specialty)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("System Ref. No."; Rec."System Ref. No.")
                {
                    Caption = 'Non-Affiliated Application No.';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Clinical Rotations Exist"; Rec."Clinical Rotations Exist")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clinical Rotations Exist field.';
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Sub Type"; Rec."Vendor Sub Type")
                {
                    ApplicationArea = All;
                }
                field("Primary Contact"; Rec."Primary Contact")
                {
                    ApplicationArea = All;
                }
                field("Primary Contact Name"; Rec."Primary Contact Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Weekly Rotation Cost List"; "Hospital Cost Factbox")
            {
                ApplicationArea = All;
                Caption = 'Weekly Rotation Cost List';
                SubPageLink = "Hospital ID" = field("No.");
            }
            part("Inventory List"; "Hospital Inventory Factbox")
            {
                ApplicationArea = All;
                Caption = 'Inventory List';
                SubPageLink = "Hospital ID" = field("No.");
            }
            part("Hospital Factbox"; "Exam Atdn Stud Ext. List-CS")
            { //CSPL-00307-ACGME
                ApplicationArea = All;
                Caption = 'Hospital Branch Address';
                SubPageLink = "Vendor No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ContactBtn)
            {
                AccessByPermission = TableData Contact = R;
                ApplicationArea = All;
                Caption = 'C&ontact';
                Image = ContactPerson;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View or edit detailed information about the contact person at the vendor.';

                trigger OnAction()
                var
                    BusinessContactRelation: Record "Business Contact Relation";
                    PGBusinessContactRelation: Page "Business Contact Relation";
                    ReleationType: Option " ",Vendor,Student;
                begin
                    ReleationType := ReleationType::Vendor;

                    BusinessContactRelation.Reset();
                    BusinessContactRelation.SetRange("Relation Type", BusinessContactRelation."Relation Type"::Vendor);
                    BusinessContactRelation.SetRange("No.", Rec."No.");

                    Clear(PGBusinessContactRelation);
                    PGBusinessContactRelation.SetVariables(ReleationType);
                    PGBusinessContactRelation.SetTableView(BusinessContactRelation);
                    PGBusinessContactRelation.RunModal();
                end;
            }

            action(Contracts)
            {
                ApplicationArea = All;
                Caption = 'Contracts';
                Image = ContractPayment;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View or edit Contract with Hospital';

                trigger OnAction()
                var
                    VendorContract: Record "Vendor Contract";
                begin
                    VendorContract.Reset();
                    VendorContract.FilterGroup(2);
                    VendorContract.SetRange("Vendor No.", Rec."No.");
                    VendorContract.FilterGroup(0);
                    page.RunModal(Page::"Hospital Contracts", VendorContract);
                end;
            }
            action(HospitalCost)
            {
                ApplicationArea = All;
                Caption = 'Co&st';
                Image = Cost;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View or edit Rotation Cost of Hospital';

                trigger OnAction()
                var
                    HospitalCostMaster: Record "Hospital Cost Master";
                begin
                    Rec.TestField("Global Dimension 1 Code");
                    HospitalCostMaster.Reset();
                    HospitalCostMaster.FilterGroup(2);
                    HospitalCostMaster.SetRange("Hospital ID", Rec."No.");
                    HospitalCostMaster.FilterGroup(2);
                    page.RunModal(Page::"Hospital Cost", HospitalCostMaster);
                end;
            }
            action(HospitalInventory)
            {
                ApplicationArea = All;
                Caption = 'Hospital &Inventory';
                Image = Inventory;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View or edit Inventory of Hospital';

                trigger OnAction()
                var
                    HospitalInventory: Record "Hospital Inventory";
                begin
                    Rec.TestField("Global Dimension 1 Code");
                    HospitalInventory.Reset();
                    HospitalInventory.FilterGroup(2);
                    HospitalInventory.SetRange("Hospital ID", Rec."No.");
                    HospitalInventory.FilterGroup(2);
                    page.RunModal(Page::"Hospital Inventory", HospitalInventory);
                end;

            }

            action("Block")
            {
                ApplicationArea = All;
                Caption = 'Block';
                Image = StopPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'To Stop all the Transactions.';

                trigger OnAction()
                var
                    HospitalInventory: Record "Hospital Inventory";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to block the Hospital - %1 (%2)?', true, Rec."No.", Rec.Name) then begin
                        HospitalInventory.Reset();
                        HospitalInventory.SetRange("Hospital ID", Rec."No.");
                        IF HospitalInventory.Find('-') then
                            repeat
                                HospitalInventory."Block Reason" := 'Hospital Blocked';
                                HospitalInventory.Status := HospitalInventory.Status::Blocked;
                                HospitalInventory.Modify();
                            until HospitalInventory.Next() = 0;

                        Rec.Blocked := Rec.Blocked::All;
                        Rec.Modify();
                        CALE.InsertLogEntry(1, 8, Rec."No.", Rec.Name, 'NA', 'BLOCKED', 'Hospital Blocked', '', '');
                        Message('Hospital - %1 (%2) is blocked.', Rec."No.", Rec.Name);
                    end;
                end;

            }
            action("Unblock")
            {
                ApplicationArea = All;
                Caption = 'Unblock';
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'To begin all Transactions.';

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to unblock the Hospital - %1 (%2)?', true, Rec."No.", Rec.Name) then begin
                        Rec.Blocked := Rec.Blocked::" ";
                        Rec.Modify();
                        CALE.InsertLogEntry(1, 7, Rec."No.", Rec.Name, 'NA', 'NA', 'NA', '', '');
                        Message('Hospital - %1 (%2) is unblocked.', Rec."No.", Rec.Name);
                    end;
                end;

            }

            action(HospitalAddresses)
            { //CSPL-00307-ACGME
                ApplicationArea = Basic, Suite;
                Caption = 'Hospital Branch Address';
                Image = Addresses;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Order Address List";
                RunPageLink = "Vendor No." = FIELD("No.");
                ToolTip = 'View a list of Branch addresses for the Hospital.';
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        Rec."Vendor Sub Type" := Rec."Vendor Sub Type"::Hospital;
        Rec."Global Dimension 1 Code" := '9000';
    end;
}
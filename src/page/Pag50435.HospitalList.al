page 50435 "Hospital List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Vendor;
    SourceTableView = where("Vendor Sub Type" = filter("Hospital"));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    // CardPageId = "Hospital Card";

    layout
    {
        area(Content)
        {
            repeater(Hospital)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                    // trigger OnDrillDown()
                    // var
                    //     HospitalCard: Page "Hospital Card";
                    // begin
                    //     Clear(HospitalCard);
                    //     HospitalCard.SetRecord(Rec);
                    //     HospitalCard.Run();
                    // end;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Country"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country/Region Code';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
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
                field("ACGME No."; Rec."ACGME No.")
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
                // field("State Code"; Rec."State Code")
                // {
                //     ApplicationArea = All;
                // }
                field(Specialty; Rec.Specialty)
                {
                    ApplicationArea = All;
                }
                field(Extension; Rec.Extension)
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
                field("Program Director"; Rec."Program Director")
                {
                    ApplicationArea = All;
                }
                field("Accreditation Status"; Rec."Accreditation Status")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("Clinical Rotations Exist"; Rec."Clinical Rotations Exist")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clinical Rotations Exist field.';
                    Editable = false;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("LCME Sponsored"; Rec."LCME Sponsored")
                {
                    ApplicationArea = All;
                }
                field(Latitude; Rec.Latitude)
                {
                    ApplicationArea = All;
                }
                field(Longitude; Rec.Longitude)
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Cost"; Rec."FM1/IM1 Cost")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                }
                field("Core Cost"; Rec."Core Cost")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                }
                field("Elective Cost"; Rec."Elective Cost")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Editable = false;
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
            {
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

                // trigger OnAction()
                // var
                //     BusinessContactRelation: Record "Business Contact Relation";
                //     PGBusinessContactRelation: Page "Business Contact Relation";
                //     ReleationType: Option " ",Vendor,Student;
                // begin
                //     ReleationType := ReleationType::Vendor;

                //     BusinessContactRelation.Reset();
                //     BusinessContactRelation.SetRange("Relation Type", BusinessContactRelation."Relation Type"::Vendor);
                //     BusinessContactRelation.SetRange("No.", Rec."No.");

                //     Clear(PGBusinessContactRelation);
                //     PGBusinessContactRelation.SetVariables(ReleationType);
                //     PGBusinessContactRelation.SetTableView(BusinessContactRelation);
                //     PGBusinessContactRelation.RunModal();
                // end;
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
                    // page.RunModal(Page::"Hospital Contracts", VendorContract);
                end;
            }
            action(HospitalCost)
            {
                AccessByPermission = TableData Contact = R;
                ApplicationArea = All;
                Caption = 'Co&st';
                Image = Cost;
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
                    HospitalCostMaster.FilterGroup(0);
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
                    HospitalInventory.FilterGroup(0);
                    page.RunModal(Page::"Hospital Inventory", HospitalInventory);
                end;
            }

            action("Update Cost on List")
            {
                ApplicationArea = All;
                Caption = 'Update Cost on List';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Update Cost on List to show latest Cost on the List.';

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    HospitalCostMaster: Record "Hospital Cost Master";
                    W: Dialog;
                    Text001Lbl: Label 'Hospital      ############1################\';
                begin
                    W.Open('Updating Cost on Hospital List..\' + Text001Lbl);
                    Vendor.Reset();
                    if Vendor.FindSet() then
                        repeat
                            W.Update(1, Vendor."No." + ' - ' + Vendor.Name);
                            Vendor."FM1/IM1 Cost" := 0;
                            Vendor."Core Cost" := 0;
                            Vendor."Elective Cost" := 0;

                            HospitalCostMaster.Reset();
                            HospitalCostMaster.SetCurrentKey("Effective Date");
                            HospitalCostMaster.SetRange("Hospital ID", Vendor."No.");
                            HospitalCostMaster.SetRange("Clerkship Type", HospitalCostMaster."Clerkship Type"::"FM1/IM1");
                            if HospitalCostMaster.FindLast() then
                                Vendor."FM1/IM1 Cost" := HospitalCostMaster."Weekly Cost";

                            HospitalCostMaster.Reset();
                            HospitalCostMaster.SetCurrentKey("Effective Date");
                            HospitalCostMaster.SetRange("Hospital ID", Vendor."No.");
                            HospitalCostMaster.SetRange("Clerkship Type", HospitalCostMaster."Clerkship Type"::Core);
                            if HospitalCostMaster.FindLast() then
                                Vendor."Core Cost" := HospitalCostMaster."Weekly Cost";

                            HospitalCostMaster.Reset();
                            HospitalCostMaster.SetCurrentKey("Effective Date");
                            HospitalCostMaster.SetRange("Hospital ID", Vendor."No.");
                            HospitalCostMaster.SetRange("Clerkship Type", HospitalCostMaster."Clerkship Type"::Elective);
                            if HospitalCostMaster.FindLast() then
                                Vendor."Elective Cost" := HospitalCostMaster."Weekly Cost";

                            Vendor.Modify();
                        until Vendor.Next() = 0;

                    W.Close();
                    Message('Costs updated successfully.');
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

    trigger OnOpenPage()
    begin
    end;
}
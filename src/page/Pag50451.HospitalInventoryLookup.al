page 50451 "Hospital Inventory Lookup"
{
    PageType = List;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Hospital Inventory";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Caption = 'Hospital List with Inventory Factbox';

    layout
    {
        area(Content)
        {
            repeater(Hospital)
            {
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field(Address; Address_1)
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                }
                field("Address 2"; Address_2)
                {
                    ApplicationArea = All;
                    Caption = 'Address 2';
                }
                field(City; City)
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }
            }
        }
        area(factboxes)
        {
            part(Information; "Hospital List FactBox")
            {
                ApplicationArea = All;
                Caption = 'Information';
                SubPageLink = "Hospital ID" = field("Hospital ID"), "Academic Year" = field("Academic Year"), "Clerkship Type" = field("Clerkship Type"), "Course Code" = field("Course Code");
            }
        }
    }

    var
        Vendor: Record Vendor;
        Address_1: Text[100];
        Address_2: Text[100];
        City: Text[50];
        PostCode: Text[50];

    trigger OnAfterGetRecord()
    begin
        Address_1 := '';
        Address_2 := '';
        City := '';
        PostCode := '';

        Vendor.Reset();
        if Vendor.Get(Rec."Hospital ID") then begin
            Address_1 := Vendor.Address;
            Address_2 := Vendor."Address 2";
            City := Vendor.City;
            PostCode := Vendor."Post Code";
        end;
    end;
}
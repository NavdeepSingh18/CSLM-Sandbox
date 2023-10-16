pageextension 50641 OrderAddressListExt extends "Order Address List"
{
    Caption = 'Hospital Branch Address';
    layout
    {
        addbefore(Code)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                Caption = 'Parent Hospital No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';
            }
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify(Code)
        {
            Caption = 'Branch Code';
        }
        modify(Address)
        {
            Visible = true;
        }
        modify("Address 2")
        {
            Visible = true;
        }

        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Name 2 field.';
            }
        }
        addafter(Code)
        {
            field("ACGME No."; Rec."ACGME No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Name 2 field.';

            }
            field("Temporary Hospital Name"; Rec."Temporary Hospital Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Name 2 field.';
            }

        }
        addafter(City)
        {
            field(Contact1; Rec.Contact)
            {
                ApplicationArea = All;
                Caption = 'Contact';
                ToolTip = 'Specifies the value of the ACGME No. field.';
            }
            field("Phone No1."; Rec."Phone No.")
            {
                ApplicationArea = All;
                Caption = 'Phone No';
                ToolTip = 'Specifies the value of the ACGME No. field.';
            }
            field("Country/Region Code1"; Rec."Country/Region Code")
            {
                ApplicationArea = All;
                Caption = 'Country/Region Code';
                ToolTip = 'Specifies the value of the ACGME No. field.';
            }
            field("Fax No1."; Rec."Fax No.")
            {
                ApplicationArea = All;
                Caption = 'Fax No';
                ToolTip = 'Specifies the value of the ACGME No. field.';
            }
            field("Post Code1"; Rec."Post Code")
            {
                ApplicationArea = All;
                Caption = 'ZIP Code';
                ToolTip = 'Specifies the value of the ACGME No. field.';
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the state or postal code as part of the address.';
            }
            field(Specialty; Rec.Specialty)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Specialty field.';
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the email address associated with the order address.';
            }
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

        }

    }

    actions
    {
        addafter("&Address")
        {
            action(Deletedata)
            {
                trigger OnAction()
                var
                    OrderAddress: Record "Order Address";
                Begin
                    OrderAddress.Reset();
                    OrderAddress.SetFilter(Code, '<>%1', '');
                    OrderAddress.DeleteAll();
                End;

            }
        }
    }
}
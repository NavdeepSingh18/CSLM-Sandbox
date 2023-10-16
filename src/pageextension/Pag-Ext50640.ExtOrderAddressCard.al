pageextension 50640 OrderAddressCardExt extends "Order Address"
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
                Editable = false;
            }
        }
        modify(Code)
        {
            Caption = 'Branch Code';
        }
        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Name 2 field.';
            }

            field("ACGME No."; Rec."ACGME No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ACGME No. field.';
            }
        }
        addafter(Contact)
        {
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
            field(Specialty; Rec.Specialty)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Specialty field.';
                MultiLine = true;
            }
            field("Temporary Hospital Name"; Rec."Temporary Hospital Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Temporary Hospital Name field.';
                MultiLine = true;
            }

        }
    }

    actions
    {
        modify("&Address")
        {
            Visible = false;
        }
    }

    var
        myInt: Integer;
}
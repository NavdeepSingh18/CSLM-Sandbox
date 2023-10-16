page 50736 "Contacts List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Contact;
    CardPageId = "Create Contacts Card";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the contact''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the contact''s middle name.';
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the contact''s last name.';
                    Caption = 'Last Name';
                }
                field(Name; Rec.Name)
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
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
                field("LGS Core Subject"; Rec."LGS Core Subject")
                {
                    ApplicationArea = All;
                }
                field("LGS Core Subject Description"; Rec."LGS Core Subject Description")
                {
                    ApplicationArea = All;
                }
                field("Elective Only"; Rec."Elective Only")
                {
                    ApplicationArea = All;
                }
                field(Preceptor; Rec.Preceptor)
                {
                    ApplicationArea = All;
                }
            }
        }

        area(FactBoxes)
        {
            part("Contacts Hospital Factbox"; "Contacts Hospital Factbox")
            {
                ApplicationArea = All;
                Caption = 'Hospitals With Contact';
                SubPageLink = "Contact No." = field("No.");
            }
        }
    }
}
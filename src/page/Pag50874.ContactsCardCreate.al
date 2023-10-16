page 50874 "Create Contacts Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Contact;
    Caption = 'Contacts Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Initiated Source"; Rec."Initiated Source Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Initiated Source No."; Rec."Initiated Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                group(Control37)
                {
                    Caption = 'Address';
                    field(Title; Rec.Title)
                    {
                        ApplicationArea = Basic, Suite;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the contact''s name title.';
                    }
                    field("First Name"; Rec."First Name")
                    {
                        ApplicationArea = Basic, Suite;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the contact''s first name.';

                        trigger OnValidate()
                        begin
                            Rec.Name := Rec."First Name";
                            if Rec."Middle Name" <> '' then
                                Rec.Name := Rec.Name + ' ' + Rec."Middle Name";
                            if Rec.Surname <> '' then
                                Rec.Name := Rec.Name + ' ' + Rec.Surname;
                        end;
                    }
                    field("Middle Name"; Rec."Middle Name")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s middle name.';
                        trigger OnValidate()
                        begin
                            Rec.Name := Rec."First Name";
                            if Rec."Middle Name" <> '' then
                                Rec.Name := Rec.Name + ' ' + Rec."Middle Name";
                            if Rec.Surname <> '' then
                                Rec.Name := Rec.Name + ' ' + Rec.Surname;
                        end;
                    }
                    field(Surname; Rec.Surname)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s last name.';
                        Caption = 'Last Name';
                        trigger OnValidate()
                        begin
                            Rec.Name := Rec."First Name";
                            if Rec."Middle Name" <> '' then
                                Rec.Name := Rec.Name + ' ' + Rec."Middle Name";
                            if Rec.Surname <> '' then
                                Rec.Name := Rec.Name + ' ' + Rec.Surname;
                        end;
                    }
                    field(Name; Rec.Name)
                    {
                        ApplicationArea = Basic, Suite;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the contact''s name.';
                        Caption = 'Name';
                        Editable = false;
                        Style = Strong;
                    }
                    field(Address; Rec.Address)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s address.';
                        ShowMandatory = true;
                        MultiLine = true;
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies additional address information.';
                        MultiLine = true;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the city where the contact is located.';
                    }
                    field(State; Rec.State)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'State';
                        ToolTip = 'Specifies the state as a part of the address.';
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the country/region of the address.';
                    }
                    field(ShowMap; 'ShowonMap')
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies the contact''s address on your preferred map website.';

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            Rec.DisplayMap();
                        end;
                    }
                }
                group(ContactDetails)
                {
                    Caption = 'Contact';
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s phone number.';
                    }
                    field("Phone No. 2"; Rec."Phone No. 2")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s phone number.';
                    }
                    field("Phone No. 3"; Rec."Phone No. 3")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s phone number.';
                    }
                    field("Mobile Phone No."; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s mobile telephone number.';
                    }
                    field("Fax No."; Rec."Fax No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTip = 'Specifies the contact''s fax number.';
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;
                        Importance = Promoted;
                        ToolTip = 'Specifies the email address of the contact.';
                    }
                    field("Home Page"; Rec."Home Page")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s web site.';
                    }
                    field("Correspondence Type"; Rec."Correspondence Type")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTip = 'Specifies the preferred type of correspondence for the interaction. NOTE: If you use the Web client, you must not select the Hard Copy option because printing is not possible from the web client.';
                    }
                    field(Preceptor; Rec.Preceptor)
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
                    field("Language Code"; Rec."Language Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the language that is used when translating specified text on documents to foreign business partner, such as an item description on an order confirmation.';
                    }
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
    actions
    {
        area(Processing)
        {
            action("Co&mments")
            {
                ApplicationArea = Comments;
                Caption = 'Co&mments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Rlshp. Mgt. Comment Sheet";
                RunPageLink = "Table Name" = CONST(Contact),
                                  "No." = FIELD("No."),
                                  "Sub No." = CONST(0);
                ToolTip = 'View or add comments for the record.';
            }
            group("Alternati&ve Address")
            {
                Caption = 'Alternati&ve Address';
                Image = Addresses;
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alternate Address';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Contact Alt. Address List";
                    RunPageLink = "Contact No." = FIELD("No.");
                    ToolTip = 'View or change Alternate Addresses of the contact.';
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        BusinessContactRelation: Record "Business Contact Relation";
    begin
        BusinessContactRelation.Reset();
        BusinessContactRelation.SetRange("Contact No.", Rec."No.");
        if BusinessContactRelation.FindSet() then
            repeat
                BusinessContactRelation.Validate("Contact No.", Rec."No.");
                BusinessContactRelation.Modify();
            until BusinessContactRelation.Next() = 0;
    end;
}
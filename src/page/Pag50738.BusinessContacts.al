page 50738 "Business Contact Relation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Business Contact Relation";

    layout
    {
        area(Content)
        {
            repeater("List of Business & Contacts")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        Open_UpdateContact();
                    end;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (Rec.Name = '') and (Rec."Contact No." <> '') then
                            Error('Name must not be Blank on Contact Card %1.', Rec."Contact No.");
                    end;

                    trigger OnDrillDown()
                    begin
                        Open_UpdateContact();
                    end;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Preceptor; Rec.Preceptor)
                {
                    ApplicationArea = All;
                }
                field("Elective Only"; Rec."Elective Only")
                {
                    ApplicationArea = all;
                }
                field(Paediatrics; Rec.Paediatrics)
                {
                    ApplicationArea = all;
                }
                field(Surgery; Rec.Surgery)
                {
                    ApplicationArea = All;
                }
                field("Obstetrics and Gynecology"; Rec."Obstetrics and Gynecology")
                {
                    ApplicationArea = All;
                }
                field("Family Medicine"; Rec."Family Medicine")
                {
                    ApplicationArea = All;
                }
                field("Internal Medicine"; Rec."Internal Medicine")
                {
                    ApplicationArea = All;
                }
                field(Psychiatry; Rec.Psychiatry)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("New Contact")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'New Contact';
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Contact: Record Contact;
                    ContactsCard: Page "Contacts Card";
                begin
                    if not Confirm('Do you want to Create a New Contact?') then
                        exit;

                    Contact.Init();
                    Contact."No." := '';
                    Contact."Initiated Source Type" := Contact."Initiated Source Type"::Vendor;
                    Contact."Initiated Source No." := Rec."No.";
                    Contact.Insert(true);
                    ContactsCard.SetTableView(Contact);

                    ContactsCard.SetRecord(Contact);
                    ContactsCard.Run();
                end;
            }
            action("View/Update Contact")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View/Update Contact';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Open_UpdateContact()
                end;
            }
            action("Update Recent Added Contact")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Recent Added Contact';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CurrPage.Update(true);
                end;
            }
        }
    }

    var
        ReleationType: Option " ",Vendor,Student;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Relation Type" := Rec."Relation Type"::Vendor;
    end;

    procedure Open_UpdateContact()
    var
        Contact: Record Contact;
        ContactsCard: Page "Contacts Card";
    begin
        Contact.Reset();
        Contact.SetRange("No.", Rec."Contact No.");
        if Contact.FindFirst() then begin
            Contact."Initiated Source Type" := Contact."Initiated Source Type"::Vendor;
            Contact."Initiated Source No." := Rec."No.";
            Contact.Modify();
        end;

        ContactsCard.SetVariables(Rec."Relation Type");
        ContactsCard.SetTableView(Contact);
        ContactsCard.SetRecord(Contact);
        ContactsCard.Run();
    end;

    procedure SetVariables(LReleationType: Option " ",Vendor,Student)
    begin
        ReleationType := LReleationType;
    end;
}
table 50482 "Business Contact Relation"
{
    Caption = 'Business Contact Relation';
    fields
    {
        field(1; "Relation Type"; Option)
        {
            Caption = 'Relation Type';
            OptionMembers = " ",Vendor,Student;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact."No.";

            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                "First Name" := '';
                "Middle Name" := '';
                "Last Name" := '';
                Name := '';
                Title := Title::" ";
                Address := '';
                "Address 2" := '';
                City := '';
                "Post Code" := '';
                "Country/Region Code" := '';
                "E-Mail" := '';
                "Home Page" := '';
                "Phone No." := '';
                "Mobile Phone No." := '';

                Contact.Reset();
                if Contact.Get("Contact No.") then begin
                    "First Name" := Contact."First Name";
                    "Middle Name" := Contact."Middle Name";
                    "Last Name" := Contact.Surname;
                    Name := Contact.Name;
                    Title := Contact.Title;
                    Address := Contact.Address;
                    "Address 2" := Contact."Address 2";
                    City := Contact.City;
                    "Post Code" := Contact."Post Code";
                    "Country/Region Code" := Contact."Country/Region Code";
                    "E-Mail" := Contact."E-Mail";
                    "Home Page" := Contact."Home Page";
                    "Phone No." := Contact."Phone No.";
                    "Mobile Phone No." := Contact."Mobile Phone No.";
                    Preceptor := Contact.Preceptor;
                end;
            end;
        }
        field(6; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(7; "Title"; Option)
        {
            Caption = 'Title';
            OptionMembers = " ","Mr.","Mrs.","Miss","Ms.","Dr.","Prof.";
        }
        field(8; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            // TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            // ELSE
            // IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            // ValidateTableRelation = false;
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(15; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(16; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(17; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            // TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            // ELSE
            // IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(92; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(501; "Business Relation Mgr."; Code[20])
        {
            Caption = 'Business Relation Mgr.';
        }
        field(502; "Business Relation Mgr. Name"; Text[100])
        {
            Caption = 'Business Relation Mgr. Name';
        }
        field(5061; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(50006; "Preceptor"; Boolean)
        {
            Caption = 'Preceptor';
        }
        field(55009; "Elective Only"; Boolean)
        {
            Caption = 'Elective Only';
        }
        field(55010; "Paediatrics"; Boolean)
        {
            Caption = 'Paediatrics';
        }
        field(55011; "Surgery"; Boolean)
        {
            Caption = 'Surgery';
        }
        field(55012; "OBG"; Boolean)
        {
            Caption = 'Obstetrics and Gynecology';
        }
        field(55013; "Obstetrics and Gynecology"; Boolean)
        {
            Caption = 'Obstetrics and Gynecology';
        }
        field(55014; "Family Medicine"; Boolean)
        {
            Caption = 'Family Medicine';
        }
        field(55015; "Internal Medicine"; Boolean)
        {
            Caption = 'Internal Medicine';
        }
        field(55016; "Psychiatry"; Boolean)
        {
            Caption = 'Psychiatry';
        }
    }

    keys
    {
        key(Key1; "No.", "Contact No.")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
    }
}
tableextension 50011 ExtendsContacts extends Contact
{
    // LookupPageId = "Contacts List";
    // DrillDownPageId = "Contacts List";

    fields
    {
        field(54997; "Department"; Text[250])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }
        field(54998; "Other Phone"; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(54999; "Relationship Manager"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(55000; "Initiated Source Type"; Option)
        {
            Caption = 'Initiated Source Type';
            OptionMembers = " ","Vendor","Student";
        }
        field(55001; "Initiated Source No."; Code[20])
        {
            Caption = 'Initiated Source No.';
        }
        field(55002; "State"; Code[10])
        {
            Caption = 'State';
            TableRelation = "State SLcM CS".Code;
        }
        field(55003; "Phone No. 2"; Text[30])
        {
            Caption = '2. Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(55004; "Phone No. 3"; Text[30])
        {
            Caption = '3. Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(55005; "Title"; Option)
        {
            Caption = 'Title';
            OptionMembers = " ","Mr.","Mrs.","Miss","Ms.","Dr.","Prof.";
        }
        field(55006; "Preceptor"; Boolean)
        {
            Caption = 'Preceptor';
        }
        field(55007; "LGS Core Subject"; Code[20])
        {
            Caption = 'LGS Core Subject';
            TableRelation = "Subject Master-CS".Code where("Level Description" = filter("Main Subject"), "Type of Subject" = filter(Core), "Subject Classification" = filter('CLINICAL ROTATION'));

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                "LGS Core Subject Description" := '';
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "LGS Core Subject");
                if SubjectMaster.FindFirst() then
                    "LGS Core Subject Description" := SubjectMaster.Description;
            end;
        }
        field(55008; "LGS Core Subject Description"; Text[100])
        {
            Caption = 'LGS Core Subject Description';
            TableRelation = "Subject Master-CS".Code where("Level Description" = filter("Main Subject"), "Type of Subject" = filter(Core), "Subject Classification" = filter('CLINICAL ROTATION'));
            Editable = false;
        }
        field(55009; "Elective Only"; Boolean)
        {
            Caption = 'Elective Only';
        }
        modify("Company Name")
        {
            Caption = 'Hospital Name';
        }
        modify("Phone No.")
        {
            Caption = '1. Phone No.';
        }
    }

    trigger OnAfterModify()
    var
        BusinessContactRelation: Record "Business Contact Relation";
    begin
        BusinessContactRelation.Reset();
        BusinessContactRelation.SetRange("Contact No.", "No.");
        if BusinessContactRelation.FindFirst() then
            repeat
                BusinessContactRelation."Relation Type" := "Initiated Source Type";
                BusinessContactRelation.Validate("Contact No.", "No.");
                BusinessContactRelation.Modify();
            until BusinessContactRelation.Next() = 0;
    end;

    trigger OnAfterDelete()
    var
        BusinessContactRelation: Record "Business Contact Relation";
    begin
        BusinessContactRelation.Reset();
        BusinessContactRelation.SetRange("Contact No.", "No.");
        if BusinessContactRelation.FindFirst() then
            repeat
                BusinessContactRelation.Delete();
            until BusinessContactRelation.Next() = 0;
    end;
}
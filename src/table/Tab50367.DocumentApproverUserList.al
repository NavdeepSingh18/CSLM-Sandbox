table 50367 "Document Approver Users"
{
    Caption = 'Document Approver Users';
    // LookupPageId = "Document Approver User List";
    // DrillDownPageId = "Document Approver User List";


    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(2; "Department Approver Type"; Option)
        {
            Caption = 'Department Approver Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bursar,Financial Aid,Residential Services,Student Services,Registrar,Admissions,Clinicals,EED Pre-Clinical,EED Clinical,Graduate Affairs,Examination,Graduation,BackOffice,Store,Promotions Committee';
            OptionMembers = " ","Bursar Department","Financial Aid Department","Residential Services","Student Services","Registrar Department","Admissions","Clinical Details","EED Pre-Clinical","EED Clinical","Graduate Affairs","Examination","Graduation",BackOffice,Store,"Promotions Committee";
        }
    }
    keys
    {
        key(PK; "User ID", "Department Approver Type")
        {
            Clustered = true;
        }
    }

}

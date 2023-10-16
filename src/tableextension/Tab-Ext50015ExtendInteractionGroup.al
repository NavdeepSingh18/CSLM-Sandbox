tableextension 50015 ExtendsInteractionGroup extends "Interaction Group"
{
    fields
    {
        field(50016; "Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionMembers = " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other,Housing,Room,"Housing Ledger",Graduation;
        }
    }
}
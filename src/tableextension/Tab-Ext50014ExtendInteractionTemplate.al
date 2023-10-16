tableextension 50014 ExtendsInteractionTemplate extends "Interaction Template"
{
    fields
    {
        field(50001; "Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionMembers = " ",Residency,"Clinical Clerkship",Student,Other,Housing,Graduation;
        }
    }
}
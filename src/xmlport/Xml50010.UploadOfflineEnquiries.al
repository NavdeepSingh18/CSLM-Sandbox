xmlport 50010 "Upload Offline Enquiries"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("<college enquiry-cs>"; "College Enquiry-CS")
            {
                XmlName = 'Enquiry';
                fieldelement(Enquiry_No; "<College Enquiry-CS>"."No.")
                {
                }
                fieldelement(Enquiry_Date; "<College Enquiry-CS>"."Enquiry Date")
                {
                }
                fieldelement(Applicant_Name; "<College Enquiry-CS>"."Applicant Name")
                {
                }
                fieldelement(Program; "<College Enquiry-CS>".Graduation)
                {
                }
                fieldelement(Gender; "<College Enquiry-CS>".Gender)
                {
                }
                fieldelement(Father_Name; "<College Enquiry-CS>"."Father's Name")
                {
                }
                fieldelement(Mother_Name; "<College Enquiry-CS>"."Mother's Name")
                {
                }
                fieldelement(Enquiry_Type; "<College Enquiry-CS>"."Enquiry Type")
                {
                }
                fieldelement(Enquiry_Source; "<College Enquiry-CS>"."Enquiry Source")
                {
                }
                fieldelement(State; "<College Enquiry-CS>".State)
                {
                }
                fieldelement(City; "<College Enquiry-CS>".City)
                {
                }
                fieldelement(Email; "<College Enquiry-CS>"."E-Mail Address")
                {
                }
                fieldelement(Mobile; "<College Enquiry-CS>"."Mobile Number")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

    }
}


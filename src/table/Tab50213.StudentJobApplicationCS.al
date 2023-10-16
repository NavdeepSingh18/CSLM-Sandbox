table 50213 "Student Job Application-CS"
{
    // version V.001-CS

    Caption = 'Student Job Application-CS';
    // DrillDownPageID = 50121;
    // LookupPageID = 50121;

    fields
    {
        field(1; "Student No"; Code[20])
        {
            caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(2; "Company Name"; Text[250])
        {
            caption = 'Company Name';
            DataClassification = CustomerContent;
        }
        field(3; "Job Description"; Text[250])
        {
            caption = 'Job Description';
            DataClassification = CustomerContent;
        }
        field(4; "Job Location"; Text[30])
        {
            caption = 'Job Location';
            DataClassification = CustomerContent;
        }
        field(5; "Date Of Drive"; Date)
        {
            caption = 'Date Of Drive';
            DataClassification = CustomerContent;
        }
        field(6; Designation; Code[10])
        {
            caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(7; "No Of Openings"; Integer)
        {
            caption = 'No Of Openings';
            DataClassification = CustomerContent;
        }
        field(8; "Eligbilty Criteria"; Text[250])
        {
            caption = 'Eligbilty Criteria';
            DataClassification = CustomerContent;
        }
        field(9; "Salary Pacakge"; Decimal)
        {
            caption = 'Salary Pacakge';
            DataClassification = CustomerContent;
        }
        field(10; "Bond Details"; Code[20])
        {
            caption = 'Bond Details';
            DataClassification = CustomerContent;
        }

        field(11; "Apply Status"; Boolean)
        {
            caption = 'Apply Status';
            DataClassification = CustomerContent;
        }
        field(12; "Entry No."; Integer)
        {
            caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}


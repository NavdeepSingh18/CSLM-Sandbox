table 50460 "FA Loan Master"
{
    Caption = 'FA Loan Master';

    fields
    {
        field(1; "BorrowerAddress"; Text[100])
        {
            Caption = 'Borrower Address';
            DataClassification = CustomerContent;
        }
        field(2; "Borrowercity"; Text[50])
        {
            Caption = 'Borrower City';
            DataClassification = CustomerContent;
        }
        field(3; "borrowerdob"; Date)
        {
            Caption = 'Borrower dob';
            DataClassification = CustomerContent;
        }
        field(4; "Borrowerdriverlicensenumber"; Text[20])
        {
            Caption = 'Borrower Driver License Number';
            DataClassification = CustomerContent;
        }
        field(5; "Borrowerdriverlicensestate"; Text[20])
        {
            Caption = 'Borrower Driver License State';
            DataClassification = CustomerContent;
        }
        field(6; "Borrowerfirstname"; Text[20])
        {
            Caption = 'Borrower First Name';
            DataClassification = CustomerContent;
        }
        field(7; "BorrowerIdentifier"; Text[50])
        {
            Caption = 'Borrower Identifier';
            DataClassification = CustomerContent;
        }
        field(8; "Borrowerlastname"; Text[20])
        {
            Caption = 'Borrower Last Name';
            DataClassification = CustomerContent;
        }
        field(9; "Borrowerlocaladdress"; Text[100])
        {
            Caption = 'Borrower Local Address';
            DataClassification = CustomerContent;
        }
        field(10; "Borrowerlocalcity"; Text[50])
        {
            Caption = 'Borrower Local City';
            DataClassification = CustomerContent;
        }
        field(11; "Borrowerlocalstate"; Text[50])
        {
            Caption = 'Borrower Local State';
            DataClassification = CustomerContent;
        }
        field(12; "Borrowerlocalzip"; Text[20])
        {
            Caption = 'Borrowerlocalzip';
            DataClassification = CustomerContent;
        }
        field(13; "Borrowerphone"; Text[20])
        {
            Caption = 'Borrower Phone';
            DataClassification = CustomerContent;
        }
        field(14; "Borrowerssn"; Text[20])
        {
            Caption = 'Borrower SSN';
            DataClassification = CustomerContent;
        }
        field(15; "Borrowerstate"; Text[50])
        {
            Caption = 'Borrower State';
            DataClassification = CustomerContent;
        }
        field(16; "Borrowerzip"; Text[20])
        {
            Caption = 'Borrowerzip';
            DataClassification = CustomerContent;
        }
        field(17; "FaLoanId"; Code[20])
        {
            Caption = 'FA Loan ID';
            DataClassification = CustomerContent;
        }
        field(18; "Fastudentaidid"; Code[20])
        {
            Caption = 'FSA ID';
            DataClassification = CustomerContent;
        }
        field(19; "Loanamountapproved"; Decimal)
        {
            Caption = 'Loanamountapproved';
            DataClassification = CustomerContent;
        }
        field(20; "LoanAmountCertified"; Decimal)
        {
            Caption = 'LoanAmountCertified';
            DataClassification = CustomerContent;
        }
        field(21; "LoanCreateDate"; Date)
        {
            Caption = 'LoanCreateDate';
            DataClassification = CustomerContent;
        }
        field(22; "Schooldloanid"; Code[20])
        {
            Caption = 'School Loan ID';
            DataClassification = CustomerContent;
        }
        field(23; "Studentdob"; Date)
        {
            Caption = 'Studentdob';
            DataClassification = CustomerContent;
        }
        field(24; "Studentfirstname"; Text[20])
        {
            Caption = 'Student First Name';
            DataClassification = CustomerContent;
        }
        field(25; "Studentlastname"; Text[20])
        {
            Caption = 'Student Last Name';
            DataClassification = CustomerContent;
        }
        field(26; "Studentssn"; Code[20])
        {
            Caption = 'Student SSN';
            DataClassification = CustomerContent;
        }
        field(27; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(28; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; FaLoanId)
        {

        }
    }

    trigger OnInsert()
    begin

        "Creation Date" := Today();
        "Created By" := Userid();
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;


}
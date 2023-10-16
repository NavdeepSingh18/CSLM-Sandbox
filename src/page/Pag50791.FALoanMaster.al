page 50791 "FA Loan Master"
{
    Caption = 'FA Loan Master';
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "FA Loan Master";
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageId = "FA Loan Master Card";

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field(FaLoanId; Rec.FaLoanId)
                {
                    ApplicationArea = All;
                }
                field(BorrowerAddress; Rec.BorrowerAddress)
                {
                    Caption = 'Borrower Address';
                    ApplicationArea = All;
                }
                field(Borrowercity; Rec.Borrowercity)
                {
                    Caption = 'Borrower City';
                    ApplicationArea = All;
                }
                field(borrowerdob; Rec.borrowerdob)
                {
                    Caption = 'Borrower DOB';
                    ApplicationArea = All;
                }
                field(Borrowerdriverlicensenumber; Rec.Borrowerdriverlicensenumber)
                {
                    Caption = 'Borrower Driver License Number';
                    ApplicationArea = All;
                }
                field(Borrowerdriverlicensestate; Rec.Borrowerdriverlicensestate)
                {
                    Caption = 'Borrower Driver License State';
                    ApplicationArea = All;
                }
                field(Borrowerfirstname; Rec.Borrowerfirstname)
                {
                    Caption = 'Borrower First Name';
                    ApplicationArea = All;
                }
                field(BorrowerIdentifier; Rec.BorrowerIdentifier)
                {
                    Caption = 'Borrower Identifier';
                    ApplicationArea = All;
                }
                field(Borrowerlastname; Rec.Borrowerlastname)
                {
                    Caption = 'Borrower Last Name';
                    ApplicationArea = All;
                }
                field(Borrowerlocaladdress; Rec.Borrowerlocaladdress)
                {
                    Caption = 'Borrower Local Address';
                    ApplicationArea = All;
                }
                field(Borrowerlocalcity; Rec.Borrowerlocalcity)
                {
                    Caption = 'Borrower Local City';
                    ApplicationArea = All;
                }
                field(Borrowerlocalstate; Rec.Borrowerlocalstate)
                {
                    Caption = 'Borrower Local State';
                    ApplicationArea = All;
                }
                field(Borrowerlocalzip; Rec.Borrowerlocalzip)
                {
                    Caption = 'Borrower Local Zip';
                    ApplicationArea = All;
                }
                field(Borrowerphone; Rec.Borrowerphone)
                {
                    Caption = 'Borrower Phone';
                    ApplicationArea = All;
                }
                field(Borrowerssn; Rec.Borrowerssn)
                {
                    ApplicationArea = All;
                }
                field(Borrowerstate; Rec.Borrowerstate)
                {
                    Caption = 'Borrower State';
                    ApplicationArea = All;
                }
                field(Borrowerzip; Rec.Borrowerzip)
                {
                    Caption = 'Borrower Zip';
                    ApplicationArea = All;
                }
                field(Fastudentaidid; Rec.Fastudentaidid)
                {
                    ApplicationArea = All;
                }
                field(Loanamountapproved; Rec.Loanamountapproved)
                {
                    Caption = 'Loan Amount Approved';
                    ApplicationArea = All;
                }
                field(LoanAmountCertified; Rec.LoanAmountCertified)
                {
                    Caption = 'Loan Amount Certified';
                    ApplicationArea = All;
                }
                field(LoanCreateDate; Rec.LoanCreateDate)
                {
                    Caption = 'Loan Create Date';
                    ApplicationArea = All;
                }
                field(Schooldloanid; Rec.Schooldloanid)
                {
                    ApplicationArea = All;
                }
                field(Studentdob; Rec.Studentdob)
                {
                    Caption = 'Student DOB';
                    ApplicationArea = All;
                }
                field(Studentfirstname; Rec.Studentfirstname)
                {
                    Caption = 'Student First Name';
                    ApplicationArea = All;
                }
                field(Studentlastname; Rec.Studentlastname)
                {
                    Caption = 'Student Last Name';
                    ApplicationArea = All;
                }
                field(Studentssn; Rec.Studentssn)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
report 50165 "Extension of Time Application"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Extension of Time Application.rdlc';

    dataset
    {
        dataitem("Immigration Header"; "Immigration Header")
        {
            RequestFilterFields = Term, "Academic Year", "Global Dimension 1 Code", Semester, "Enrollment No";
            DataItemTableView = SORTING("Document No.") WHERE("Visa Extension Date" = FILTER(<> 0D), "Document Status" = filter(Verified));
            Column(ShowFilter; GETFILTERS())
            {

            }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            {

            }
            Column(LogoImageAICASA; RecEduSetup1."Logo Image")
            {

            }
            Column("Institute_Name"; RecEduSetup."Institute Name")
            {

            }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            {

            }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            {

            }
            Column("Institute_City"; RecEduSetup."Institute City")
            {

            }

            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            {

            }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            {

            }
            Column("Institute_Email"; RecEduSetup.url)
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            Column(Term; Term)
            {

            }
            Column("AdYear"; "Academic Year")
            {

            }
            column(Last_Name; StudentMaster."Last Name")
            {

            }
            column(First_Name; StudentMaster."First Name")
            {

            }
            column(Pass_Port_No__1; StudentMaster."Pass Port No.")
            {

            }
            column(Pass_Port_Issued_Date_1; StudentMaster."Pass Port Issued Date")
            {

            }
            column(Pass_Port_Expiry_Date_1; StudentMaster."Pass Port Expiry Date")
            {

            }
            column(AddressTo; StudentMaster.Addressee)
            {

            }
            column(Country_Name; CountryName)
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Visa_Extension_Date; "Visa Extension Date")
            {

            }
            trigger OnPreDataItem()
            Begin
                RecEduSetup.Reset();
                RecEduSetup.SetRange("Global Dimension 1 Code", '9000');
                IF RecEduSetup.FindFirst() then
                    RecEduSetup.CALCFIELDS("Logo Image");

                RecEduSetup1.Reset();
                RecEduSetup1.SetRange("Global Dimension 1 Code", '9100');
                IF RecEduSetup1.FindFirst() then
                    RecEduSetup1.CALCFIELDS("Logo Image");
            End;

            trigger OnAfterGetRecord()
            begin
                CountryRec.Reset();
                CountryRec.SetRange(CountryRec.Code, "Country Code");
                If CountryRec.FindFirst() then
                    CountryName := CountryRec.Name;

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No");
                IF StudentMaster.FindFirst() then;
            end;
        }
    }

    var
        RecEduSetup: Record "Education Setup-CS";
        RecEduSetup1: Record "Education Setup-CS";
        CountryRec: Record "Country/Region";
        StudentMaster: Record "Student Master-CS";
        CountryName: Text[50];

}
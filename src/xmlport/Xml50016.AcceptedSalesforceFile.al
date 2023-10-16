xmlport 50016 "Accepted Salesforce File"
{
    FieldSeparator = ',';
    Format = VariableText;
    Direction = Import;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("SalesForce File"; "SalesForce File")
            {
                XmlName = 'SalesForceFile';

                fieldelement(GlobalDimenision1; "SalesForce File"."Global Dimension 1 Code")
                {
                    MinOccurs = Zero;

                }
                fieldelement(AnticipatedTerm; "SalesForce File"."Anticipated Term")
                {
                    MinOccurs = Zero;

                }
                fieldelement(AccountName; "SalesForce File"."Account Name")
                {
                    MinOccurs = Zero;

                }
                fieldelement(FirstName; "SalesForce File"."First Name")
                {
                    MinOccurs = Zero;
                    FieldValidate = Yes;

                }
                fieldelement(LastName; "SalesForce File"."Last Name")
                {
                    MinOccurs = Zero;
                    FieldValidate = Yes;

                }
                fieldelement(BirthDate; "SalesForce File"."Date of Birth")
                {
                    MinOccurs = Zero;

                }
                fieldelement(MailingStreet; "SalesForce File".Street)
                {
                    MinOccurs = Zero;

                }
                fieldelement(State; "SalesForce File".State)
                {
                    MinOccurs = Zero;

                }
                fieldelement(Postcode; "SalesForce File".Postcode)
                {
                    MinOccurs = Zero;

                }
                fieldelement(CountryCode; "SalesForce File"."Country Code")
                {
                    MinOccurs = Zero;

                }

                fieldelement(SemesterType; "SalesForce File"."Semester Type")
                {
                    MinOccurs = Zero;

                }
                fieldelement(ApplicationID; "SalesForce File"."Application ID")
                {
                    MinOccurs = Zero;

                }
                fieldelement(StudentNo; "SalesForce File"."Student No.")
                {
                    MinOccurs = Zero;

                }
                fieldelement(DecisionDate; "SalesForce File"."Decision Date")
                {
                    MinOccurs = Zero;

                }
                fieldelement(Stage; "SalesForce File".Stage)
                {
                    MinOccurs = Zero;

                }
                fieldelement(CourseCode; "SalesForce File"."Course Code")
                {
                    MinOccurs = Zero;

                }
                fieldelement(ApplicationType; "SalesForce File"."Application Type")
                {
                    MinOccurs = Zero;

                }
                fieldelement(ApplicationSubType; "SalesForce File"."Application Sub-type")
                {
                    MinOccurs = Zero;

                }
                fieldelement(VPAppreciationLetter; "SalesForce File"."VP Appreciation Letter")
                {
                    MinOccurs = Zero;

                }
                fieldelement(UndergraduateGPA; "SalesForce File"."Undergraduate GPA")
                {
                    MinOccurs = Zero;

                }
                fieldelement(PreReqGPA; "SalesForce File"."Pre-Req GPA")
                {
                    MinOccurs = Zero;

                }
                fieldelement(GraduateGPA; "SalesForce File"."Graduate GPA")
                {
                    MinOccurs = Zero;

                }
                fieldelement(HighSchoolGPA; "SalesForce File"."High School GPA")
                {
                    MinOccurs = Zero;

                }
                fieldelement(DepositPaidDate; "SalesForce File"."Deposit Paid Date")
                {
                    MinOccurs = Zero;

                }
                fieldelement(LastADACallBy; "SalesForce File"."Last ADA Call By")
                {
                    MinOccurs = Zero;

                }
                fieldelement(LastADACallDate; "SalesForce File"."Last ADA Call Date")
                {
                    MinOccurs = Zero;

                }
                fieldelement(EnrollmentNo; "SalesForce File"."Enrollment No.")
                {
                    MinOccurs = Zero;

                }
                fieldelement(EnrollmentStatus; "SalesForce File"."Enrollment Status")
                {
                    MinOccurs = Zero;

                }
                fieldelement(PhoneNo; "SalesForce File"."Phone No")
                {
                    MinOccurs = Zero;

                }
                fieldelement(EmailAddress; "SalesForce File"."Email Address")
                {
                    MinOccurs = Zero;

                }
                fieldelement(AdmissionCoordinator; "SalesForce File"."Admission Co-ordinator")
                {
                    MinOccurs = Zero;

                }
                fieldelement(SpecialProgram; "SalesForce File"."Special Program")
                {
                    MinOccurs = Zero;

                }
                fieldelement(Citizenship; "SalesForce File".Citizenship)
                {
                    MinOccurs = Zero;

                }
                fieldelement(SubStage; "SalesForce File"."Sub-Stage")
                {
                    MinOccurs = Zero;

                }

                fieldelement(HousingWaiver; "SalesForce File"."Housing Waiver")
                {
                    MinOccurs = Zero;

                }
                fieldelement(Housing; "SalesForce File".Housing)
                {
                    MinOccurs = Zero;

                }
                fieldelement(DigitID18; "SalesForce File"."18 Digit ID")
                {
                    MinOccurs = Zero;

                }



                trigger OnAfterInsertRecord()
                begin
                end;

                trigger OnBeforeInsertRecord()
                begin

                end;

                trigger OnAfterInitRecord()
                begin
                    IF FirstLine = TRUE THEN BEGIN
                        FirstLine := FALSE;
                        currXMLport.SKIP();
                    END;
                end;
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        FirstLine := TRUE;
    end;

    trigger OnPostXmlPort()
    var
    begin
        MESSAGE('File has been Uploaded.');
    end;


    var
        FirstLine: Boolean;

}